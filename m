Return-Path: <linux-kernel+bounces-105996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CD87E745
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF25B22383
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0E2E646;
	Mon, 18 Mar 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dqCljK87"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DF2D051;
	Mon, 18 Mar 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757440; cv=none; b=r16btV3p5XMdjTY63zbl0RFFCdJOWTnll3ghwsinUzo0Px1nurEwGMwjtnX/3HLNt06nE9k5Q1y4WnWOf1jtI8FuiXonqLzyfg1qvSVnIbf+zE0iep5Tc3yxvfP6p9Su/zP74iziCRktyaHeXPX5BBajjpWZeoSvzkDQKeKVG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757440; c=relaxed/simple;
	bh=bP27MDgLQVsxPJz30ePvmAkgcuAp6o4heyYS1YR8rMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deJ0PL/0KSdPlOFhyGYln9iK1x8BpQUBZDy4gH+X+x00+1Is56o0pvBH7tEHP7xhcaz7flxEOHa55Fa2KsNwtk1ef3vCXdBpCGocTG7YIK4D//50JVGzkfXDowNAz8HEy+rEHPpFEStGGM5yFHxqib4EalnDVvG6EOm5rfjqDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dqCljK87; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757437;
	bh=bP27MDgLQVsxPJz30ePvmAkgcuAp6o4heyYS1YR8rMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dqCljK873zJV+arBMDPeIZpUg9ZOzIzundiwp8nN6nLh3LuVc6/DIeuuUt89HYAot
	 rXcNzz5YGRtjkKw1bdQUdGYSRLhwEY4UiimV38r1e95fOSEgynQGyOPzNO2SGKvmZu
	 zo4nLrn4eTqIB/ReVT38q3cYfo4/eDzpt0I6TfMyNdDLHJCmHK3z6gvrS/DMelKh5w
	 jQjjZdM+m3c3rdQdHzmqY4Xoj/IRcnLET/scpUbGXanKcLwulD2V+Bzz1zJDgnrYWN
	 OmDLESblK79n6EzpqLTWmAiYK38sFA1HdI8Pju5vyAhl+J2V1m5q/4C7e/h5jzxRkH
	 91E5PBLtNuaBA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A522237813EA;
	Mon, 18 Mar 2024 10:23:56 +0000 (UTC)
Message-ID: <60d59234-0121-4559-ae1c-6fb05a39aaa7@collabora.com>
Date: Mon, 18 Mar 2024 11:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] arm64: dts: mediatek: mt7622: drop "reset-names"
 from thermal block
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 "David S . Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240317221050.18595-1-zajec5@gmail.com>
 <20240317221050.18595-5-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240317221050.18595-5-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/03/24 23:10, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Binding doesn't specify "reset-names" property and Linux driver also
> doesn't use it.
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated properties are not allowed ('reset-names' was unexpected)
>          from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> 
> Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



