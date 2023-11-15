Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD887EBB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjKODDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjKODDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:03:53 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 19:03:48 PST
Received: from mail-m24122.xmail.ntesmail.com (mail-m24122.xmail.ntesmail.com [45.195.24.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CEAD7;
        Tue, 14 Nov 2023 19:03:48 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=B63RZCm9h9X1F0ItkSIiZQN1Q5SRObyjJ+Ejx8p3zSkT1Osm5pEecBpZdu3t7ZwqoD8zLnJrRp4+2RK4+mqxkuxcWD89NrPIulFQdFsg+iFFwnqNyBrsORajiYmHx/kq6Gb79Vx3Kf8iw+o9+c9nJ5SubHukVF/8iOqtYtf/NCg=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=JogRrWa0NTb5d0n006ipq3R/fD5aUYOfvc69+L6lX00=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id B76777801CE;
        Wed, 15 Nov 2023 10:45:25 +0800 (CST)
Message-ID: <3906a288-cafa-4c60-9fb3-4d4c75487340@rock-chips.com>
Date:   Wed, 15 Nov 2023 10:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] dt-bindings: display: vop2: Add rk3588 support
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112841.1771312-1-andyshrk@163.com> <11331566.rMLUfLXkoz@diego>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <11331566.rMLUfLXkoz@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kdH1YfTBlCQkgfSBpOSxpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8bd0de85bab24fkuuub76777801ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6ASo4Ljw8H05KST1JLFYT
        NSlPFClVSlVKTEtLS0pNSElNTEpNVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0xCSTcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 05:54, Heiko Stübner wrote:
> Am Dienstag, 14. November 2023, 12:28:41 CET schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> The vop2 on rk3588 is similar to which on rk356x
>> but with 4 video outputs and need to reference
>> more grf modules.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   .../display/rockchip/rockchip-vop2.yaml       | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
>> index b60b90472d42..c333c651da1a 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
>> @@ -20,6 +20,7 @@ properties:
>>       enum:
>>         - rockchip,rk3566-vop
>>         - rockchip,rk3568-vop
>> +      - rockchip,rk3588-vop
>>   
>>     reg:
>>       items:
>> @@ -48,6 +49,8 @@ properties:
>>         - description: Pixel clock for video port 0.
>>         - description: Pixel clock for video port 1.
>>         - description: Pixel clock for video port 2.
>> +      - description: Pixel clock for video port 4.
>> +      - description: Peripheral clock for vop on rk3588.
>>   
>>     clock-names:
>>       items:
>> @@ -56,12 +59,29 @@ properties:
>>         - const: dclk_vp0
>>         - const: dclk_vp1
>>         - const: dclk_vp2
>> +      - const: dclk_vp3
>> +      - const: pclk_vop
> with the error Rob's bot reported, I guess both clocks and clock-names
> need a minItems element to mark these new clocks essentially as optional?

Yes, when add minItems for clocks and clkock-names, the erro gone.

Considering we also have vop2 based soc(rk3562) only have one video port,

so it is better to set the minItems as 3 here?

>
>>     rockchip,grf:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description:
>>         Phandle to GRF regs used for misc control
>>   
>> +  rockchip,vo-grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to VO GRF regs used for misc control, required for rk3588
>> +
>> +  rockchip,vop-grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to VOP GRF regs used for misc control, required for rk3588
>> +
>> +  rockchip,pmu:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to PMU regs used for misc control, required for rk3588
>> +
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>>   
>> @@ -81,6 +101,11 @@ properties:
>>           description:
>>             Output endpoint of VP2
>>   
>> +      port@3:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Output endpoint of VP3
>> +
>>     iommus:
>>       maxItems: 1
>>   
>>
>
>
>
