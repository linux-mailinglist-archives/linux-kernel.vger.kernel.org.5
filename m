Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002A7E5345
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjKHKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKHKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:25:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554D1BD6;
        Wed,  8 Nov 2023 02:25:25 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E66836607479;
        Wed,  8 Nov 2023 10:25:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699439123;
        bh=OZoOlukZrdzbFvt6S2UQgIRYEsNDObjxtvTcrLKVge8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jtmkPzgYDtgX2bmJjmCa2lz4SefqscfmnQNC8rGdYUUVLv7u8qt44PbWh9oZXbFNp
         hDv8SlCw09oUGHeXEmlWT5op8FIQKT6uMTgPz0MeC7UjHyGR23UqJDGCusZ8Jh908D
         1aFp/TMCyfWgSePVoCw934Vwx0u+SNCxoqgtdHZV23kVt2212yturoajfmsWEym+V2
         nhCeNhiyalq5j7Q7GZoJjpHDMnWnOSv5h/OKn6b+A+Q0qokdtl97ijnfU1WUhhMp8o
         A8vmWq/sC/lTrto6gfDULQirX9qCLkT81yJk86ZXSJILkUJepMFoH+dYywWsJREdyH
         Oo40MG9u1qVvQ==
Message-ID: <cf73377f-8413-46d0-bcd8-9d12c2c38bc7@collabora.com>
Date:   Wed, 8 Nov 2023 11:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add I2C arbiter clocks to
 i2c 1/2/5
Content-Language: en-US
To:     =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
References: <20231020075540.15191-1-angelogioacchino.delregno@collabora.com>
 <8414e0ccdb5f456877df06d4e5c6befff5463991.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8414e0ccdb5f456877df06d4e5c6befff5463991.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/11/23 07:56, Yu-chang Lee (李禹璋) ha scritto:
> On Fri, 2023-10-20 at 09:55 +0200, AngeloGioacchino Del Regno wrote:
>> The I2C busses 1, 2 and 5 have got a separated arbiter clock: add it
>> to their respective nodes.
>>
>> Fixes: 2e78620b1350 ("arm64: dts: Add MediaTek MT8186 dts and
>> evaluation board and Makefile")
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> index f04ae70c470a..af6f6687de35 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>> @@ -1224,8 +1224,9 @@ i2c1: i2c@11008000 {
>>   			      <0 0x10200200 0 0x100>;
>>   			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
>> 0>;
>>   			clocks = <&imp_iic_wrap
>> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C1>,
>> -				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
>> -			clock-names = "main", "dma";
>> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>,
>> +				 <&infracfg_ao
>> CLK_INFRA_AO_I2C1_ARBITER>;
>> +			clock-names = "main", "dma", "arb";
>>   			clock-div = <1>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> @@ -1238,8 +1239,9 @@ i2c2: i2c@11009000 {
>>   			      <0 0x10200300 0 0x180>;
>>   			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH
>> 0>;
>>   			clocks = <&imp_iic_wrap
>> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C2>,
>> -				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
>> -			clock-names = "main", "dma";
>> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>,
>> +				 <&infracfg_ao
>> CLK_INFRA_AO_I2C2_ARBITER>;
>> +			clock-names = "main", "dma", "arb";
>>   			clock-div = <1>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> @@ -1280,8 +1282,9 @@ i2c5: i2c@11016000 {
>>   			      <0 0x10200700 0 0x100>;
>>   			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH
>> 0>;
>>   			clocks = <&imp_iic_wrap
>> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5>,
>> -				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
>> -			clock-names = "main", "dma";
>> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>,
>> +				 <&infracfg_ao
>> CLK_INFRA_AO_I2C5_ARBITER>;
>> +			clock-names = "main", "dma", "arb";
>>   			clock-div = <1>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
> 
> In previous discussion[1], if the arbiter clock is not added into dts
> node does trackpad lost its functionality before system suspend/resume?
> And is this patch meant to solve the same issue in [1]?
> 
> Reply on behalf of our i2c PIC.
> 

Yes, it loses functionality sometimes after PM resume, but with this added clock
the problem is solved.

And yes, it's the same as [1].

Regards,
Angelo


