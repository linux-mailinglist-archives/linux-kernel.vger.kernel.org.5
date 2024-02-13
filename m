Return-Path: <linux-kernel+bounces-63179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C7852BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77C61F21D02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A5210FE;
	Tue, 13 Feb 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M2JZ3glv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2B1799D;
	Tue, 13 Feb 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815351; cv=none; b=j25IvJl3p1PV1VsfC3qWiA4MlwDhsbXYt5imfb+LqSEKtP+/xYP66mr+h6oAsIP3I5B0IsNAVNih0QQFWb9ovf5E1hw7oKRHedWGHPAnzbALxJ0ffuKSftZQRNa7qk2CEhIGGsnlXYHUtIQYigkmYNlZl0iqwYJL1xXU4GH0hns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815351; c=relaxed/simple;
	bh=fp9FGluwMSXxSuqD4GvNc9fG6fxLNPpYbuY+L6o9QAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDoQVDmt9PXBLBSWWxeTwg+GiZf9Pu4N6Naaxl3Tv6cuMsUACr3jfJeg8DXFu63v5w5gDMhSRqnXIJ2cppGIyIuDZbDoIN46eFwz6JHiZvY5eT6C3k2FIJkbAeFhXeXFYo0PKzNRzUke59MLQKrLzVsFTib27ZXmZ96v6vS2o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M2JZ3glv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707815347;
	bh=fp9FGluwMSXxSuqD4GvNc9fG6fxLNPpYbuY+L6o9QAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M2JZ3glvC7qhQgMUEee6dMUQpQy4grZJc7duZhsoSxfLjpVAgIbyCiZVLPAGeDaWu
	 CWxjEcWAv29bG0mkxPSJWzzHqCS+yrC0fW/iXJwux1TBAqG5wft9Id8nkh7PoEopeQ
	 xWgttt3GZ/dy+vUx8wRXHXmUJFkKv7dqDHAI8IMipIRNhfMIoslcmE3wCbP1mLRfbk
	 PTrN/ADI8YYQtTF07p/QUutDhR4FqXL2l5mQc6QuMQZ6DkBLtw6eelM0TUgOgtCQnQ
	 T7NKpFXMPG5cEUkuBKsjmjXVpfaE9at9ckJV4dDxgJAwVD/uAF33lrGGwTVVZk4Mig
	 xkJb5z5jRmfjQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6EE023781FEF;
	Tue, 13 Feb 2024 09:09:06 +0000 (UTC)
Message-ID: <6429a878-af3c-4182-b65f-60e1c0afccc5@collabora.com>
Date: Tue, 13 Feb 2024 10:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add missing clocks to ssusb
 power domains
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240212-mt8186-ssusb-domain-clk-fix-v1-1-26cb98746aa3@collabora.com>
 <985e1a4f-c538-4a9d-be58-2c688aa7350c@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <985e1a4f-c538-4a9d-be58-2c688aa7350c@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/02/24 22:53, Nícolas F. R. A. Prado ha scritto:
> On Mon, Feb 12, 2024 at 04:32:44PM -0500, Nícolas F. R. A. Prado wrote:
>> The ssusb power domains currently don't list any clocks, despite
>> depending on some, and thus rely on the bootloader leaving the required
>> clocks on in order to work.
>>
>> When booting with the upstream arm64 defconfig, the power domain
>> controller will defer probe until modules have loaded since it has an
>> indirect dependency on CONFIG_MTK_CMDQ, which is configured as a module.
>> However at the point where modules are loaded, unused clocks are also
>> disabled, causing the ssusb domains to fail to be enabled and
>> consequently the controller to fail probe:
>>
>> mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@4: failed to power on domain: -110
>> mtk-power-controller: probe of 10006000.syscon:power-controller failed with error -110
>>
>> Add the missing clocks to the ssusb power domains so the power
>> controller can boot without relying on bootloader state.
>>
>> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> index adaf5e57fac5..02f33ec3cbd3 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> @@ -931,11 +931,19 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
>>   
>>   				power-domain@MT8186_POWER_DOMAIN_SSUSB {
>>   					reg = <MT8186_POWER_DOMAIN_SSUSB>;
>> +					clocks = <&topckgen CLK_TOP_USB_TOP>,
>> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
>> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
>> +					clock-names = "sys_ck", "ref_ck", "xhci_ck";
>>   					#power-domain-cells = <0>;
>>   				};
>>   
>>   				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
>>   					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
>> +					clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
>> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
>> +						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
>> +					clock-names = "sys_ck", "ref_ck", "xhci_ck";
> 
> I forgot to mention this here, but the XHCI clock wasn't needed to get the power
> domains to work per se, but leaving it out caused issues when probing the mtu3
> devices:
> <3>[   15.431506] mtu3 11201000.usb: clks of sts1 are not stable!
> <3>[   15.443965] mtu3 11201000.usb: device enable failed -110
> <3>[   15.454306] mtu3 11201000.usb: mtu3 hw init failed:-110
> <3>[   15.463865] mtu3 11201000.usb: failed to initialize gadget
> <4>[   15.477890] mtu3: probe of 11201000.usb failed with error -110
> 
> <3>[   15.514603] mtu3 11281000.usb: clks of sts1 are not stable!
> <3>[   15.525239] mtu3 11281000.usb: device enable failed -110
> <3>[   15.614174] mtu3 11281000.usb: mtu3 hw init failed:-110
> <3>[   15.619647] mtu3 11281000.usb: failed to initialize gadget
> <4>[   15.630623] mtu3: probe of 11281000.usb failed with error -110
> 
> Not sure if this issue should be handled separately (maybe the mtu3 device
> should enable the XHCI clock?), but I opted to include the clock here to get
> boot working for this device at once.
> 

Hey Nicolas,
As you just said: having the XHCI clock in the power domain is wrong :-)

Almost comically, the MTU3 binding already supports having a XHCI clock
named "xhci_ck" after "dma_ck"... so the solution is to add the TOP_XHCI
clock in the mtu3 node and that's it. Do not remove it from the children.

mtu3-node-at-somewhere {
		clocks = <&topckgen CLK_TOP_USB_TOP>,
			 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
			 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
			 <&infracfg_ao CLK_INFRA_AO_ICUSB>,
			 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
}

Waiting for a v2...

Cheers,
Angelo

