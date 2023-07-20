Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411B75AD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGTLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGTLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:52:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1E9CC;
        Thu, 20 Jul 2023 04:52:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 563926607083;
        Thu, 20 Jul 2023 12:52:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689853959;
        bh=j6JBGmm4BC6EWYmzoUGSqSenhIca3LpJaT76xsHZwTE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xt7dJTYXN55pPb9ezM3gpK0FtimTlDw7eTmN3DLYu08lxxv4dULmDgIaFCwqKpXvU
         fiG2EzYCp8fB+UTzq6z7slCqfMQf5u1p55ad1Aqvi4ExKDjm7dsgpaSa4dtFRoXkKT
         9/xR7zKY3lu6JJltvecbzCjKZv/d1sYlAoC9ZTxbIYIKy6AX1kr5/rTwNR/kH6A9eH
         vyzAu2pTQQksxKIvYazhCByzBKnBAXZJwPJ0fj+ePBAaxZhoklRT+yAJqhyKb8+Lp0
         aasAo/fJ/rtk4CH7TqyrftTCZTiNxTnVPQhyVIp7o3UWoESWUX9iUh+5qdr1DY3CNA
         sFFv0X/sG+5zA==
Message-ID: <d892a76c-165b-dbeb-79aa-70f3ebd7f07c@collabora.com>
Date:   Thu, 20 Jul 2023 13:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt6795: Add support for display
 blocks and DPI/DSI
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com
References: <20230720091559.86406-1-angelogioacchino.delregno@collabora.com>
 <20230720091559.86406-2-angelogioacchino.delregno@collabora.com>
 <0809ac02-b8bf-ed63-9e2e-e77cd7e93464@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0809ac02-b8bf-ed63-9e2e-e77cd7e93464@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 13:35, Alexandre Mergnat ha scritto:
> 
> 
> On 20/07/2023 11:15, AngeloGioacchino Del Regno wrote:
>> Introduce all nodes for all of the display blocks in the MediaTek Helio
>> X10 MT6795 SoC, including the DSI PHY and DSI/DPI interfaces: those are
>> left disabled as usage is board specific.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 252 +++++++++++++++++++++++
>>   1 file changed, 252 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> index 597bce2fed72..d805d7a63024 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> @@ -2,6 +2,9 @@
>>   /*
>>    * Copyright (c) 2015 MediaTek Inc.
>>    * Author: Mars.C <mars.cheng@mediatek.com>
>> + *
>> + * Copyright (C) 2023 Collabora Ltd.
>> + *                    AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
> 
> Shouldn't be like this ?
> 
>   * Copyright (c) 2015 MediaTek Inc.
>   * Copyright (C) 2023 Collabora Ltd.
>   * Authors: Mars.C <mars.cheng@mediatek.com>
>   *          AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 

I don't think that there's any rule about this?
Also I don't really mind the strings order, but if anyone really does, I can change
it....

>>    */
>>   #include <dt-bindings/interrupt-controller/irq.h>
...
>> @@ -708,6 +953,13 @@ smi_common: smi@14022000 {
>>               clock-names = "apb", "smi";
>>           };
>> +        od@14023000 {
>> +            compatible = "mediatek,mt6795-disp-od", "mediatek,mt8173-disp-od";
>> +            reg = <0 0x14023000 0 0x1000>;
>> +            clocks = <&mmsys CLK_MM_DISP_OD>;
>> +            mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0x3000 0x1000>;
>> +        };
>> +
>>           larb2: larb@15001000 {
>>               compatible = "mediatek,mt6795-smi-larb";
>>               reg = <0 0x15001000 0 0x1000>;
> 
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> 



