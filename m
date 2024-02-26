Return-Path: <linux-kernel+bounces-81390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157AB86754B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59C7288568
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0601128811;
	Mon, 26 Feb 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DEFZ1HM7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B094126F13;
	Mon, 26 Feb 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951167; cv=none; b=uUys9fRvVGuTTDmZtQKLCguBijF13lJt96F40IYmo+95/eaAh76xeBOw6BF2vB9fvLXYerViWZMkvU4xGgrU4QOlmQTVgKNrP42PDTKn9fgFY0jaN/gepkPDl4RSwKPuj4pigtyBRaL88YTmyVFb0vn+BT0h6Dt1rn3dC/LuSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951167; c=relaxed/simple;
	bh=IJlVIU07O9fLX3cymIc5k0g8Lxcz/CNKc3JeVD5/Ojc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6geaexNUbqVQ567+2fY2kP7kFJ2iPl83u3J398aDj4OeHELYIkCfb8+byKnpYPp5eqTmCwEDBlPxtB+dZC3f4enl6f9N9Bm7p/kmTHR9Z6vSklRjdj3zkAZV7Gx2akCqH/o63PbIn5vdNmMtPDoKRT0L3Pon8xQAkBv1UvIop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DEFZ1HM7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951164;
	bh=IJlVIU07O9fLX3cymIc5k0g8Lxcz/CNKc3JeVD5/Ojc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEFZ1HM7x4+e9SmNiPfO+UoWp9syO9knHrUyp2BeC1aepXmQQawP4sHXyjHHjyp1n
	 eWXlYD25UrSjt71NwLR8RA0yJpBK+j0NdIvZzs/nG9fV49CSSax7P+rxSzfZw38tuu
	 Sofi0wOXTMPbIgkr8vG9K8TCXbjT4l3wFfBFqVGOb6jK8B6l0pjYzO2uDdSjUk03ZD
	 muABdVjYdTBAyJvnoGfchrttABDY1rNUKagsxSD5y0l37wCCSSrzEF5sdpPH7bNZ4c
	 HegyDX5PgH8zMXjr4EVDmB8CyaYX5s0rKfBHcR7fQ/10+cTi4AwWpY070UA5dwdCld
	 dgfiQmjP6MCEg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 02F8637820C6;
	Mon, 26 Feb 2024 12:39:22 +0000 (UTC)
Message-ID: <89659b2c-5521-4328-86b0-1bcf967693ae@collabora.com>
Date: Mon, 26 Feb 2024 13:39:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/mediatek: Rename "mtk_drm_ddp_comp" to
 "mtk_ddp_comp"
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
 <20240226085059.26850-3-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-3-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_ddp_comp" to "mtk_ddp_comp":
> - To align the naming rule
> - To reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>



