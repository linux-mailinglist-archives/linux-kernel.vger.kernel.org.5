Return-Path: <linux-kernel+bounces-63184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2982852C06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B241C22D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF77224E0;
	Tue, 13 Feb 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rj6WYGWg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB622097;
	Tue, 13 Feb 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815496; cv=none; b=Hc7uqPfkzL+7Aw7nhpvpc0Kdo6sKgeyuOaoaNzmGg8RChoiSZd1En7wqZAXqXvVftYpB14NcPdEpKz7pNnw63eJU5ry6iHVezSIgg0fukDCd16H7vzvjWZx1EM+9Fd8kdJllElyHbDHqcsafHGQTKXkQc05DWeiI2GnwJZqPDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815496; c=relaxed/simple;
	bh=ZRya2IRpTo+isAm8zeDAAsRcDE8ZzmojpAFzkmjK+ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdjEpNdHU4DRfFBL0F20v7IdnFxFQvhe5/s9AyZsUrPLXfnd/TcKsR7oyVo+Y2vM5PwONCVsVnlY7sjv3Y7147qnrH3xyEWhOdmReG3e6asLAZ+i6Lo0edET3ql7NQPS0BSchyAXTf2wmPJsGZzY0uXTY4vzNqGX3Qiuiw6LV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rj6WYGWg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707815493;
	bh=ZRya2IRpTo+isAm8zeDAAsRcDE8ZzmojpAFzkmjK+ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rj6WYGWgWju7e9ovPFwW7Nj9Al7gHaylI9V6PT98Z8dRe53A3pZlUiXSnhnQIg2lL
	 8Fv2KTa23hdJjRn1x516OW/7LMpWYXU2oCx6Ou6E+X0e9+k1aJN822KroQKxbRMNBV
	 V1ECW9ecAB7wMDeqLRrA7gNDggc/nc6SDSfoVpgvn0pCfD0OXWusxcyxpTYnaHk01z
	 s1ZBQsIytP89tnrWTLrbNkOQdf7wmaksGXesZrZBU60JhiEW0dlwTJSI982GlkQqYR
	 vHUtgkzBHrdNJPjSsrOUnxxOXSrU2x5sj4o/J4fwyUXRH0ys52+X7jSOHR0h8hyrXf
	 uqF5zIPR3FOcg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FECC3782043;
	Tue, 13 Feb 2024 09:11:32 +0000 (UTC)
Message-ID: <ff6d841f-6eb8-449c-91cd-63e4958bf4eb@collabora.com>
Date: Tue, 13 Feb 2024 10:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: mediatek: mt7986: drop "#reset-cells"
 from Ethernet controller
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sam Shih <sam.shih@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240213053739.14387-1-zajec5@gmail.com>
 <20240213053739.14387-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213053739.14387-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 06:37, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Ethernet block doesn't include or act as a reset controller.
> Documentation also doesn't document "#reset-cells" for it.
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: ethernet@15100000: Unevaluated properties are not allowed ('#reset-cells' was unexpected)
>          from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
> 
> Fixes: 082ff36bd5c0 ("arm64: dts: mediatek: mt7986: introduce ethernet nodes")
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



