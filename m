Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07B77415F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjHHRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjHHRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D251E324
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:07:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9667715e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510846; x=1692115646;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsp33dBf7UhgamzOkYxOzQdC3CHLd9zXwnmRE8U0OWI=;
        b=BLh7lEZEWXDgnTC3aiMQjivhLA7hRBL1fFgDETled3wHSjm6Uy95V9IBLIlpoXdZf0
         kdQ5UzbfgeYOhG0Dpqt1/pOIcz3MtnVpgvAO9Ch3MnrHg94V9q16H024NtGnfTBrUswo
         6FgYwj3IvRWBLskujW5zEaPNHdINOe8/JSBeSi0fdHRXRgH71ceyRT9541xyKc7aZEl+
         VQ3SIcS68jjGYFDaljVvla3EAtTS/snK/3ety8i/5pzsG9Zu7CtmuGFXPOe7mq8cbQ8C
         QbPZ1OV6k+992cFmAcd4TdP0Slj0lydmz0IFcggcVxDeanLu7SWQbGTO1uC9bdLnQbop
         mZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510846; x=1692115646;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsp33dBf7UhgamzOkYxOzQdC3CHLd9zXwnmRE8U0OWI=;
        b=L1LxSURAd+raXrYfsG3EM2eYd/H0CyudJ4d4T0Mq1dUfAt0omDqkYoqR06309Qpk42
         2OaEeYwuHsS6u3pUe7FSHrMRpsG177k7SF680DSd6GQ9X9m5gkRl2UXLTfrVKrHA5HPv
         r9JRKsBVAEvd4+f36Y+WYm7ID5hwYtiZVtagHoUOqbizfSOEdXYP+IFLLYvQU0Weock7
         R+iFXQBvY1x1R94a8UpJ7gwwWhpKyczjWA+BsnYLhlTXcKsP2EM5zMVCjTF2/Ulsb+gY
         xdzFkukKGl90uQ1oDjng/Z9pddi+9Q1VBiduRRS0c4EVcPvUbsf7aYWfTUFlJ56dMPBD
         AzSw==
X-Gm-Message-State: AOJu0YyZqf2Qb3urmOM0WGS78GygdSfTanNaA3+Z+Hu0sYTBB5xLNu+j
        FspIESrvmROX5oxlmZIdWUW7z6kl/78HSrwemTw=
X-Google-Smtp-Source: AGHT+IHJ3hZ82wubWYBzU8TJVHIOBqyUG04wm6z7DeM5yDPFDtsTGPypfW+gUnZ0OMkFJqxWx8oYeQ==
X-Received: by 2002:a2e:7e0b:0:b0:2b6:ed80:15d1 with SMTP id z11-20020a2e7e0b000000b002b6ed8015d1mr8862529ljc.24.1691506333010;
        Tue, 08 Aug 2023 07:52:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906180800b009934855d8f1sm6817973eje.34.2023.08.08.07.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 07:52:12 -0700 (PDT)
Message-ID: <65a57225-43d5-fdfa-c12d-3f33f8e535be@linaro.org>
Date:   Tue, 8 Aug 2023 16:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
 <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
 <DU2PR04MB863043CFB54E4CF2C5F34B65950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <DU2PR04MB8630F001B107D331F9F5DE1E950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB8630F001B107D331F9F5DE1E950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 13:49, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Pankaj Gupta
>> Sent: Tuesday, August 8, 2023 5:04 PM
>> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> clin@suse.com; conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
>> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
>> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
>> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
>> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
>> Sethi <V.Sethi@nxp.com>
>> Subject: RE: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added
>> nxp secure enclave fw
>>
>>
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Sent: Thursday, July 13, 2023 12:38 AM
>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
>>> s.hauer@pengutronix.de; kernel@pengutronix.de; clin@suse.com;
>>> conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
>>> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
>>> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
>>> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
>>> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org;
>>> linux-arm-kernel@lists.infradead.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
>>> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
>>> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
>> Varun
>>> Sethi <V.Sethi@nxp.com>
>>> Subject: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added
>>> nxp secure enclave fw
>>>
>>> Caution: This is an external email. Please take care when clicking
>>> links or opening attachments. When in doubt, report the message using
>>> the 'Report this email' button
>>>
>>>
>>> On 12/07/2023 14:12, Pankaj Gupta wrote:
>>>> Added support for NXP secure enclave called EdgeLock Enclave
>>>> firmware
>>>> (se-fw) for imx93-11x11-evk.
>>>>
>>>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>>>> ---
>>>>  arch/arm64/boot/dts/freescale/imx93.dtsi | 11 ++++++++++-
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>> b/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>> index 8643612ace8c..2b0f901d2709 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
>>>> @@ -1,6 +1,6 @@
>>>>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>  /*
>>>> - * Copyright 2022 NXP
>>>> + * Copyright 2022-2023 NXP
>>>>   */
>>>>
>>>>  #include <dt-bindings/clock/imx93-clock.h> @@ -863,5 +863,14 @@
>>>> ddr-pmu@4e300dc0 {
>>>>                       reg = <0x4e300dc0 0x200>;
>>>>                       interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>>>>               };
>>>> +
>>>> +             ele_fw: se-fw {
>>>> +                     compatible = "fsl,imx93-ele";
>>>> +                     mboxes = <&s4muap 0 0 &s4muap 1 0>;
>>>
>>> This should be two entries.
>>>
>>>> +                     mbox-names = "tx", "rx";
>>>> +                     fsl,mu-did = <3>;
>>>> +                     fsl,mu-id = <2>;
>>>
>>> Drop both. Since you put it into the DTSI, it means it is compatible specific.
>> [Pankaj] Removed the above three entries.
> 
> 
> [Pankaj] Correction: 
> I missed to note that in our up-coming SoC(s), there will be multiple MU(s):
> Those can only be identified using mu_id. Hence, following two only, will be removed:
> +                     mbox-names = "tx", "rx";
> +                     fsl,mu-did = <3>;

Which SoC? How the bindings are going to look like for that SoC? What is
mu-did in such case and how does it relate to different mailboxes? Why
it cannot be inferred from compatible?

BTW, responding three weeks after my review does not help your case. I
totally loose the context. Of course you can reply even after 1 year,
it's your right, but it does not help the discussion.

Best regards,
Krzysztof

