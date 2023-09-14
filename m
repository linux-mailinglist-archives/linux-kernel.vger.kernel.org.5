Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6783279FCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjINHL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjINHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:11:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559CCF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:11:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b83cso6589955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694675479; x=1695280279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h0ZuDwh1rf6DxeXFX2hTo7zsJWLjsfMyXea4lnDesA=;
        b=yn+Mq0Gwxu96XJ0pRlPE3ZHPPEMARv/MUIyxzg9ZjQ2x+eC0yl9G7ybGOtO1VzxmSM
         2RTK+7Kgtk6ZhpVU/Rto5VGGttTUp6H++SQ8IX0g913daaZddSqOoQ7zQQWb0cMS7kNe
         C+4sHCLoPUzbc9pLMaqgygkM9i+GaAyJM8BcW6pE4v/i3yAXAakSrhdva8O0wsuU/Qzj
         uKhVYEr1fg5xNMUXvdJxuldXbXey2m5B1qW+5SDWbZQjYnSfxV4V5WOEvCR9b2CRzBMr
         zoXIw5n8YARfWt4/OgICDrFkUOw16zgiaTyLWzdD36RHxqLhxB6X2Dn7ZB/gBtPUO3Py
         c1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675479; x=1695280279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h0ZuDwh1rf6DxeXFX2hTo7zsJWLjsfMyXea4lnDesA=;
        b=iNm6vPYeVNWHaWp/vFHu7VqsR8T3XAeofjGTu4z2/CqD7UaecXNn/zYJZhZ/dgxfQv
         aKiV4Ew2OhHnGdpZC4c7Y73CYkbaGep4JF2h1Q/BfIe8YY+1aWDgwyDXizATFasNMePh
         0vSEeSPa+yAKB/5yhLqzzNFDu4ezUa1cou35sPqrkW7HTixc2me9JpYeNRhX9hcIVjwV
         RAFYqYp4blKQs1UiOLLFYtd/tJLHjzKwBy8LJA0UD0vluRRNBW8yTbM7tHPfbnKFXztv
         ZC/QIejipfXqLZV5RNKTYK655hkoDazkaM+PnZuCWpp71HIg8nW0E1T3aiEk7d02xSF/
         NeAw==
X-Gm-Message-State: AOJu0YyMkcql1dsMbrSaexD0Ac/lc3xF6/XZmq0D8bojZhuXWWbO+lCo
        T4lR5vH8+hrVmH0jWGKtZqzw1Q==
X-Google-Smtp-Source: AGHT+IGepcioAmLDJ5yHj/4XT3khz32VPFxMtQxJjTkGxn1Sec0dfMWaMrgX4erCJapFuFurG6tFqg==
X-Received: by 2002:adf:ee08:0:b0:319:8c35:37b with SMTP id y8-20020adfee08000000b003198c35037bmr4177430wrn.7.1694675479125;
        Thu, 14 Sep 2023 00:11:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m6-20020adfe946000000b0031980783d78sm918742wrn.54.2023.09.14.00.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:11:18 -0700 (PDT)
Message-ID: <cc25b9ba-08e6-24e1-8e21-f3e43bb73311@linaro.org>
Date:   Thu, 14 Sep 2023 09:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/5] arm64: dts: imx93: update gpio node
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
 <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
 <DU0PR04MB941722CE1A9BF9F87946DE0A88F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9fc4817d-00ae-aaf4-bfb6-b24361f55799@linaro.org>
 <DU0PR04MB94177EF6250838FFFB5FD6D188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB94177EF6250838FFFB5FD6D188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 08:53, Peng Fan wrote:
>> Subject: Re: [PATCH 5/5] arm64: dts: imx93: update gpio node
>>
>> On 14/09/2023 08:04, Peng Fan wrote:
>>>> Subject: Re: [PATCH 5/5] arm64: dts: imx93: update gpio node
>>>>
>>>> On 14/09/2023 04:21, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Per binding doc, i.MX93 GPIO supports two interrupts, and not
>>>>> compatible with i.MX7ULP. So update the node
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++--------
>>>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>>> b/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>>> index 6f85a05ee7e1..011c34a57c53 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>>> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>>> @@ -825,11 +825,12 @@ usdhc3: mmc@428b0000 {
>>>>>  		};
>>>>>
>>>>>  		gpio2: gpio@43810080 {
>>>>> -			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
>>>>> +			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
>>>>
>>>> As your driver change points, it is breaking users, so no :(
>>>
>>> ok. Although i.MX93 GPIO is not compatible with i.MX7ULP from HW
>>> perspective, the compatible string should keep as it is now and
>>> binding
>>
>> If it is not compatible, then how could it work before?
> 
> i.MX7ULP reg:
> 0h Port Data Output Register (PDOR) 
> 4h Port Set Output Register (PSOR) 
> 8h Port Clear Output Register (PCOR) 
> Ch Port Toggle Output Register (PTOR) 
> 10h Port Data Input Register (PDIR) 
> 14h Port Data Direction Register (PDDR)
> 
> i.MX8ULP/93 has different registers address, but 
> i.MX93 registers has 0x40 off as below:
> 40h Port Data Output (PDOR)
> 
> Even linux i.MX7ULP gpio driver could work with i.MX8ULP/93
> GPIO HW with dts node using an 0x40 offset + base addr
> for i.MX93 gpio. I think from hw design, they are
> not compatible. Besides the upper differences,
> there are other differences.

Sorry, I don't understand it. I asked how could they work before in
Linux, if they are not compatible, and you pasted regs.

So again - if they are not compatible, how could it work? Or maybe it
never worked? But then commit msg would say it.

Best regards,
Krzysztof

