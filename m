Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA9776F82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHJFX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:23:54 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F4E75;
        Wed,  9 Aug 2023 22:23:50 -0700 (PDT)
Received: from [10.0.0.200] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B6570160723;
        Thu, 10 Aug 2023 07:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1691645027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1DC7uX+Tru/lXHpCzQVmsHKdgr0xMNZ6rgnElWJ+sSE=;
        b=ghF8VkWszjyLLLy2YFoEIvOtGQPgUU99+31ks6MtBLBikSf+u5ZHrgHoABvKJyfnMpCCZI
        BE2jD/eoAVQAAinIf0CFFkP4RPFa2FQSgdmZpz6k0CN07N43IykHiUdaXmAlxOkZyI+Jh8
        +koGD+lq93hY2AvsZHfs9M+YmzK/eto=
Message-ID: <d724e3e2-cb46-46d4-8499-8e7c745805da@ixit.cz>
Date:   Thu, 10 Aug 2023 07:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: switch to vqmmc-supply
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <guido.gunther@puri.sm>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@puri.sm
References: <20230730121047.43115-1-david@ixit.cz>
 <ZMebuXJKFMpjCuul@qwark.sigxcpu.org>
 <a29cf254-80c9-50e6-c723-71a8f03e6e35@pengutronix.de>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <a29cf254-80c9-50e6-c723-71a8f03e6e35@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 14:42, Ahmad Fatoum wrote:
> Hello David,
> Hello Guido,
>
> On 31.07.23 13:32, Guido Günther wrote:
>> Hi,
>> On Sun, Jul 30, 2023 at 03:10:46PM +0300, David Heidelberg wrote:
>>> Resolves following warning:
>>> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: mmc@30b50000: Unevaluated properties are not allowed ('power-supply' was unexpected)
>>> 	from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#
>>>
>>> Cc: kernel@puri.sm
>>> Cc: Guido Günther <agx@sigxcpu.org>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>>> index b3549eae6278..a8b5da3ca08f 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>>> @@ -1031,7 +1031,7 @@ &usdhc2 {
>>>   	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>>>   	bus-width = <4>;
>>>   	vmmc-supply = <&reg_usdhc2_vmmc>;
>>> -	power-supply = <&wifi_pwr_en>;
>>> +	vqmmc-supply = <&wifi_pwr_en>;
>>  From the schematics WIFI_PWR_EN connects to the Wifi card's `W_DISABLE`
>> so I don't think vqmmc is correct here. I wonder if there's a better way
>> to model that in DT? Any suggestions would be welcome.
> I think mmc-pwrseq is what you are after.

Guido sent patch to replace it with `mmc-pwrseq` in 
https://www.spinics.net/lists/kernel/msg4894084.html

-- 
David Heidelberg
Certified Linux Magician

