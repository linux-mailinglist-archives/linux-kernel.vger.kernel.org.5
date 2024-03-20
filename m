Return-Path: <linux-kernel+bounces-108678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61CC880E51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685051F22F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D839FD0;
	Wed, 20 Mar 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uiCYaqVU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CF383A1;
	Wed, 20 Mar 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925720; cv=none; b=BKVYQo6RaGH0G6mxJeoPtOnbfbs01y08j3Xa8pkkJtvCNkrenklvAsvhRkbkMLUSce9/1dIR7FI7M/ISFk+rA6+VfcoAEQ7bATv7jBg/yXo9lu3TkPB9//M/W4nN5Z+xAWhWVbee76AgtSNH1NfVbciikyZ+EIfFjfCYWvstSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925720; c=relaxed/simple;
	bh=0pLI0L5jQtxzcpdywVIifeQcG2pw2/Wr4GhCFKwu9uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgOFKqn7mN1RV5/sHN8hzt5TwdlZyb7rvZnm9QFDBpDz8MO3beL/qYEZZi/95zx5W3RlbbONLVYaXSFqHbhfa9cCBtL4xg6DUma0SF/OURq1h5JICSJ4wGqXEIqVrVvPLjAwuQieUUa+BDCVvnpSkmuBcIwjCjIL8i3aYFhPZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uiCYaqVU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710925716;
	bh=0pLI0L5jQtxzcpdywVIifeQcG2pw2/Wr4GhCFKwu9uQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uiCYaqVUV8qdI13Y/tOKLHPQhu5i6nOwDEC321w6keVmWgCjyw0VmAjj5GRSxwjz0
	 yvMEuRJKxXITdz19QVhKXxTaFb9rRm9Ha0wcbiXvAS/nOUAf0YsInuuLxlnyeDnCpK
	 KXaIaqQkj9wkBlz/oNJ9Cp8NIeU6Q0AUVqOHrAmc5GGUOS4o/lQh1uuWx8RYUaGUHl
	 70oCjHV8h6zrIYNN3ZUHkMSZhZjLGSS2HiVySP2drmm3AYSQeIZ7cVybNL4gxT8VLS
	 qY5ZeH96WEONwZ/qm5TGHQSoOsi66GcCqfBdaW6Od9LeMo/5qj1sqiUaQAbrnrkW7D
	 QmIS3L+BVuU4g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9AE8F37813C4;
	Wed, 20 Mar 2024 09:08:35 +0000 (UTC)
Message-ID: <2812525d-9c17-4758-bc4f-e3093cc26ef7@collabora.com>
Date: Wed, 20 Mar 2024 10:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] drm/mediatek: Rename files "mtk_drm_crtc.c" to
 "mtk_crtc.c"
Content-Language: en-US
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240320024222.14234-1-shawn.sung@mediatek.com>
 <20240320024222.14234-8-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240320024222.14234-8-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/24 03:42, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_crtc.c to mtk_crtc.c and
> modify the Makefile accordingly.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



