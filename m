Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92D773CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjHHQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjHHQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212E35A9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:45:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe44955decso6992880e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509556; x=1692114356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q24TuyQPIV9JKdXRN8c9UpIkwf6u74tQnVD/uWybcPY=;
        b=SMs9Itnja6QLjIoTQUqgFDywUYxLGJ3bZKJCJvnms0GyQnhRnIBSnNWnBsXWRgXabB
         ElgKqyAQf6kxPHAOQy19OursYRwTS8UoWGiw1A5iWo2O9p88eYzNsA2df0a43LZMpd62
         YogC+uxjgdSHSYwVMnC7+AT7ng4I3mWeaNFIQoSyxlf8bUBiEvX2LiOGTorYqNzxvMlS
         SxIqnR7rFrxwTlDKlFQVkjgBSLxH8BGXP4gnImk3ffaUQU+4CkAK//nNsX4NXvsj52fc
         uk9Zu7CZZO08bN3aMljBwV32DbIK1ZpjnIRqaSS1yNKOZCHkHxNECL5Xhy1/XV9ya4yQ
         myxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509556; x=1692114356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24TuyQPIV9JKdXRN8c9UpIkwf6u74tQnVD/uWybcPY=;
        b=R/SLQ0cSui23DIkWoeFD9FzmiGmNgMNO3rthvXYihFcp4Q4uOyjzsdv2iDXbO3SOjN
         FywNzAIdW0yuTt7+jqYLBhOQYni4Jn2EcjjkmrHJbMbaBXEuo32xVS+YrWJcatVWxEwU
         VGWpouGV1vKTBjdiHsCXlSVXVtfJV9l+pw3hqN/21yDrFQKOtOnc8seSwLOw5BqnK4Ay
         wbcwzAsVpUZZY1ev4X1x6BFxPDwe2wsDilA7T4PVDhTwCa+xy2sEjAoKWBYBih0Hrmxd
         uJM+ODQpeQOC3RzamBRgykUVX+pz1X96fPYEOl2j4ZaJmUcFgs2uNsn6LC5LTIVBW2S5
         yNqQ==
X-Gm-Message-State: AOJu0Yz7YsCvpgE90JTmHVJ7EtYhr6kasw+WwOOxjjJ9GpDXSWebT58Y
        yUa+kaDIhogbi1La0jBDL0N9yBCxIvDlIruI4CI=
X-Google-Smtp-Source: AGHT+IH+83IRgkTcHHxGdoUT4Se5hAS8eTHNASuvSJa4UvMYgg41Fn4+QsSO9CRbFeCN7dZHSqw6Rg==
X-Received: by 2002:a17:906:31d2:b0:99b:50ea:2f96 with SMTP id f18-20020a17090631d200b0099b50ea2f96mr68317ejf.12.1691506140661;
        Tue, 08 Aug 2023 07:49:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id le3-20020a170907170300b0099cf840527csm812527ejc.153.2023.08.08.07.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 07:49:00 -0700 (PDT)
Message-ID: <701ad779-0d1e-e8e6-8eba-294452cfb0bc@linaro.org>
Date:   Tue, 8 Aug 2023 16:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp
 secure enclave firmware
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
 <20230712121219.2654234-3-pankaj.gupta@nxp.com>
 <1ac2fb68-02e0-ddfe-87aa-fcd093779009@linaro.org>
 <DU2PR04MB86306E154C195F69368D3AB8950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB86306E154C195F69368D3AB8950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 13:07, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, July 13, 2023 12:08 AM
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; clin@suse.com;
>> conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
>> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
>> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
>> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
>> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
>> Sethi <V.Sethi@nxp.com>
>> Subject: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp secure
>> enclave firmware
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 12/07/2023 14:12, Pankaj Gupta wrote:
>>> Added support for NXP secure enclave called EdgeLock Enclave firmware
>>> (se-fw) for imx8ulp-evk.
>>>
>>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>>> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>>> index 3ddc0f3125b3..10ed31974a6f 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
>>> @@ -114,7 +114,7 @@ sosc: clock-sosc {
>>>               #clock-cells = <0>;
>>>       };
>>>
>>> -     sram@2201f000 {
>>> +     sram0: sram@2201f000 {
>>>               compatible = "mmio-sram";
>>>               reg = <0x0 0x2201f000 0x0 0x1000>;
>>>
>>> @@ -161,6 +161,16 @@ s4muap: mailbox@27020000 {
>>>                       #mbox-cells = <2>;
>>>               };
>>>
>>> +             ele_fw: se-fw {
>>> +                     compatible = "fsl,imx-ele";
>>> +                     mboxes = <&s4muap 0 0 &s4muap 1 0>;
>>> +                     mbox-names = "tx", "rx";
>>> +                     fsl,mu-did = <7>;
>>> +                     fsl,mu-id = <2>;
>>> +                     sram-pool = <&sram0>;
>>
>> It does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.li/
>> naro.org%2Fblog%2Ftips-and-tricks-for-validating-devicetree-sources-with-
>> the-devicetree-
>> schema%2F&data=05%7C01%7Cpankaj.gupta%40nxp.com%7Cd13d0b68d01c
>> 4d10d8cb08db83070ed2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>> 7C0%7C638247838553225400%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=pO6dnz4aPqVejRNDR0OU4n04hXebyqgrNKg4DPhahI0%3D
>> &reserved=0
>> for instructions).
> 
> Tested. Before submitting the patch.
> [Pankaj] Accepted.

You really tested that patch? Before I waste my time on proving it was
not, are you 100% sure that you tested that patch and no new warnings
are printed? Or are you just agreeing with me that this time you will test?
> 

Best regards,
Krzysztof

