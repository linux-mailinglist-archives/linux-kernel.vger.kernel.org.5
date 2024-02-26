Return-Path: <linux-kernel+bounces-81384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB258675A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B69B28981
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9367FBB0;
	Mon, 26 Feb 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IoK2SJZK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF17EF0E;
	Mon, 26 Feb 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951161; cv=none; b=H6lYoepMKDfqet3asLwyTg8HRMK3aUvBPn/VY99yifhiJsktFnTKsbkqKmFrDIPdxBpLkZBioa3iCE9hfKpvDxex9t7+gYG9IL4hSYG4pKNjsoGnpoEIUu57wpjOE4C/PJ3YJaZPfMEgoqeE+hVNWINBLFY77FEPApdsSr1CIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951161; c=relaxed/simple;
	bh=ssUCrohjGs4Ygd/5Qap/4ztBIgAopUsbSegnQlFXBuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bImXNVVwATJ4b7GPFUEWc7H2Ovxp8yRJ2Syf4V8vo8+ILIECHqJklZe1sX8O5OEwXySU++uxDuVzjgHo4ZXM9yNNZxEqWeqd3EGQ1GkfXynzgmYsNLDFz5GuPWdw2NDMr9G0rvvomaWQPUy2p1a/6nnhQUWzyN3LPrIoBa3XBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IoK2SJZK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951158;
	bh=ssUCrohjGs4Ygd/5Qap/4ztBIgAopUsbSegnQlFXBuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IoK2SJZKpm0P3y5QWkmCT+CPMGfrpZr35MgbrCienTK3RajBgjOuKBbToeXDXD/ce
	 oUGse1nuo0B8diR26ZyyFpJXIRE37sM+EO4Nxh2B1EBp2jjOaeQoMe3DI5ZoRzwW1D
	 wS8mmdYYMNWm8Mh8BeiNyO8jx/4E0cDJYs6LzeOtFFglldRUVBTKXq3WjgrC/UQuL8
	 +62I+DlDPILBrBWAQcezRfq3HN/pQLVJsnhynHwMu5taQquVn+/tXUx++MA0yIf5QL
	 VLEemCo2cSf6+Kmr2/46hl5nT8l9Vv/2ulhu76SjstCIYeKCp7Kf9egfusb/C8SqRH
	 PZa+CLRCsuaCA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0501A37820CF;
	Mon, 26 Feb 2024 12:39:16 +0000 (UTC)
Message-ID: <4a17e974-ca9c-41b4-aa5c-2d41598120a6@collabora.com>
Date: Mon, 26 Feb 2024 13:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/mediatek: Rename files "mtk_drm_gem.*" to
 "mtk_gem.*"
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
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
 <20240226085059.26850-10-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-10-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_gem.* to mtk_gem.*.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


