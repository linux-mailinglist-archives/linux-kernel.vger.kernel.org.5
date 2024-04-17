Return-Path: <linux-kernel+bounces-148626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA518A8541
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A859C28180B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F3140395;
	Wed, 17 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3DctJJn9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E31EB27;
	Wed, 17 Apr 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361826; cv=none; b=uPkz3CdxuAQf7HA8ku13/AIsVU0ktEvexPnUe20Vr/qGezA6Hu/hhVj1f/OrsfxZRMkAISNs+wYdNeqBGjTaCmUDO6dUh+qhHvTgKdD/as96UZgoXBbB9KpvNlaDlLc95HfZ/+3a7VFNKjyTJW/qS/lPLpg2z2TCpAo6rulAoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361826; c=relaxed/simple;
	bh=C10c0j9rUMDZTqWWXJ3mbmlN530Uqy2jVku/X9owZB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDPegkQQGNLCPE+iBFdmP0CgYDZygBJTzDFWtbc1OSRCmkDqWGHE4xEV4aunKf6VWDBRu2hfkv5yfeVJivNg+DahGhvr4KQGgqlVnFT58QjEdz3J6kqqTMEgMvtOivT9mSAXngRAdczcK9aThd/uxyLKfo3f2NfutaK0gAWbHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3DctJJn9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713361823;
	bh=C10c0j9rUMDZTqWWXJ3mbmlN530Uqy2jVku/X9owZB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3DctJJn9xKbax1ctnQtqhoj9wcBbyIUez6JUTeoNeiXYXKeXFwscqwquGvopFS5jA
	 CeORZDrLvUxoswS0xOUrRoLOcPBLraDXfh7T4HIYsNeWKadYqaczN33+x4nULqlZjK
	 cMSyoGf+ZioBTkqU0wU8w8c+RuKiraubHBkxak7Zd1rpGMXDCI0cOPJDG8ZFTMKyQP
	 U460A1XGEFyOVbHHnNywDb6ziDstMz8qm+lN/q10nmT/B5YT0SFZB2LVTL2syaaSb8
	 LqphPFRNZj0iqJ94rBaNzFcMYJSYt5M5QrVsNCPAkJBA1ZDitl9IRpRN1hBfuW3jAG
	 jZnXF9/LhltFA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62DA3378001E;
	Wed, 17 Apr 2024 13:50:21 +0000 (UTC)
Message-ID: <f04ac76d-4348-4b79-890d-829114921299@collabora.com>
Date: Wed, 17 Apr 2024 15:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
 <1db01bd8-0936-40e5-9f1b-7ea34746bef1@collabora.com>
 <5vqnkgp77tir5j5cumo62pm2cw4xjabexu7nk3kze4gk4ri5dn@g3pee2beuuco>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <5vqnkgp77tir5j5cumo62pm2cw4xjabexu7nk3kze4gk4ri5dn@g3pee2beuuco>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/04/24 15:25, Uwe Kleine-König ha scritto:
> Hello,
> 
> On Wed, Apr 17, 2024 at 12:19:19PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
>>> According to the Mediatek MT8365 datasheet, the display PWM block has
>>> a power domain.
>>>
>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>
>> It's the same for at least MT8195, MT8183 and I think MT8192 as well... so
>> not having that from the beginning is actually a mistake.
>>
>> Please add a Fixes tag and resend, after which:
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> You mean similar to:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fb7c3d8ba039df877886fd457538d8b24ca9c84b
> 
> ? It seems someone you know well was quicker :-)
> 
> Best regards
> Uwe
> 

LOL! I totally forgot that I fixed that already :-D

I need more coffee!

Cheers,
Angelo

