Return-Path: <linux-kernel+bounces-90404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB286FEB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29351C20FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376A376F3;
	Mon,  4 Mar 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1mtAGLgh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532B3E49D;
	Mon,  4 Mar 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547202; cv=none; b=I8gn+q18IOGjtdkeH0pkhDTyL4SH5Yfx1POcuzBD+VgypeDZIR7UB9EtfwLWpbqNEUugmxw+ZmgyeOX1kQS6xtlb6/ohWjhUoFbuAKUSzuikUFPrXHeLBeF6s1jSq9BV2ZjbAhZIWs3UPoAWo9wb98NIBEFWEdKyfXp/+0FXqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547202; c=relaxed/simple;
	bh=mL5gAOPgp7I1aSd3xpkKdxtF2Zjaucw/vmjKyyRakaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pza+ySQ8YIg6Oz7xfKAqOfQRqYFlygTHjXzWCfyL2p/H0reuLXLM4jRmLq7WESGak/Q86JEun3lpdMAgjXBNgz7emP2p3L4iTdVMFyUJbbxVozzhbXha69pMXiTKFgS+zMyojoY8ppDRkuLLa2oFafQt8Ac5S9hrWR8kGE0cBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1mtAGLgh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547199;
	bh=mL5gAOPgp7I1aSd3xpkKdxtF2Zjaucw/vmjKyyRakaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1mtAGLghMf3iESaIeNOGt1Mt5mrdXTnTL+HSXApGoLFBRiYeJk+UwrdU90zi9pLkx
	 68dRZ/eodispEozhUg5L9A+4LVP9n4QDIINQd92cnbihbTcSamTjJ7htxNcUeutC8V
	 QVRkmE26HO72ae/XyEdPYiZWCqiQL9uNRcmv3W9znTbiCVAEGf0c0PagzQcryqKRV1
	 QQduFiEQ2G2VG64LaxuEgLEBzUwaKtVVcQg/RbFV/w2zm8JsDZwVJM8lrEwfhBqkmO
	 uVagJuF1ZRwvQM4G6WSigKYJdHRsmzwXAYKus0wheJveZDnGKwgC/4H+H5Fm4jth+S
	 VU4RZQPOqtLSw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5263E37820C3;
	Mon,  4 Mar 2024 10:13:18 +0000 (UTC)
Message-ID: <6c7a1768-c553-460b-97db-1e51e3a7ed64@collabora.com>
Date: Mon, 4 Mar 2024 11:13:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt7622: drop "reset-names" from
 thermal block
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240301113506.22944-1-zajec5@gmail.com>
 <20240301113506.22944-5-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301113506.22944-5-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 12:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Binding doesn't specify "reset-names" property and Linux driver also
> doesn't use it.
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated properties are not allowed ('reset-names' was unexpected)
>          from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Fixes tag missing


> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 7da4ac273a15..9d19dd8ee524 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -513,7 +513,6 @@ thermal: thermal@1100b000 {
>   			 <&pericfg CLK_PERI_AUXADC_PD>;
>   		clock-names = "therm", "auxadc";
>   		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
> -		reset-names = "therm";
>   		mediatek,auxadc = <&auxadc>;
>   		mediatek,apmixedsys = <&apmixedsys>;
>   		nvmem-cells = <&thermal_calibration>;



