Return-Path: <linux-kernel+bounces-148631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7148A8553
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0998E2830E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328014037D;
	Wed, 17 Apr 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mykj5nAq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD413C81F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361946; cv=none; b=ZM/N2LUOcAubMN04fzWnpyJVe9RuF6RlCBbw3DdOH1Xt8lc1m15jbwRsFhCbyj527VkVHI5QZ4Ma/UuDaC8BeXqlCJxzbU+Jr1FAhsrYZbbbFhcOr3ZH1y2K7ggYquXlsslgqmS3ZTkSdEDJDvJwEoNLHqsGL3HUzgPd019kk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361946; c=relaxed/simple;
	bh=VxunfktQMOjppOCQpES9K8zlG6woQD+gav0HVLUYdWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MdvBFch1gSWTbYrGnjOQMHciihUiCrvTAtX8jNWpZEGJjnqIIjkGtoSaycgbHs/4zg6ZbKqGMXflHI6lWY8V3khk09ibOH5BCyhwA4kPG/Bou3LePEmuG2MVtICK+s+Kspbk3+ZkZdohxOP5+ycAXE0PRRKjMoefmfMQZW2KXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mykj5nAq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713361942;
	bh=VxunfktQMOjppOCQpES9K8zlG6woQD+gav0HVLUYdWw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Mykj5nAq4uZmDGUy8aeGxuqe1I9F/q86kU0nNQ1xVNXcg8XVae31Bm2y0lTzMLRxz
	 sCbBts3Q1SnTtyf+WFufvN7v6WNYpJwBUoN1k7kZTBFXzQr3V5p5NWX3Od/aVo/z13
	 dcyJZqtU2prWJkdPjLYZkRNp7EoJzGjc7SHTX5MKlH0rQh2+K9hh1JGB/+PJkfi8iK
	 58QYY/y1ZXU2KXl29NUD5sHJrhTDD3on7edMTS7rVk+37dU6erHEzcqvjviarUFc6h
	 M0BkSzY5TVdDI0g1canrfGMTmTSWsLkVVnnRDYmVwIiYpaCBC2x2gaSqy9+8cL/6e8
	 jsIu2PVVQMrHQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7EB49378001E;
	Wed, 17 Apr 2024 13:52:21 +0000 (UTC)
Message-ID: <275e760d-e4e2-4a6b-88f7-9a8590b0773b@collabora.com>
Date: Wed, 17 Apr 2024 15:52:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
To: Wojciech Macek <wmacek@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 chrome-platform@lists.linux.dev
References: <20240417103819.990512-1-wmacek@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240417103819.990512-1-wmacek@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/24 12:38, Wojciech Macek ha scritto:
> In case there is no DP device attached to the port the
> transfer function should return IO error, similar to what
> other drivers do.
> In case EAGAIN is returned then any read from /dev/drm_dp_aux
> device ends up in an infinite loop as the upper layers
> constantly repeats the transfer request.
> 
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



