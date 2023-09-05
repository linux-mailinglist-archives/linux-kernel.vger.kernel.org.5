Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C04792ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbjIEQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354874AbjIEPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:21:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0BE197;
        Tue,  5 Sep 2023 08:21:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56f84de64b9so1665457a12.1;
        Tue, 05 Sep 2023 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693927278; x=1694532078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl1B7J0NnXr4SILiYpt6+iuxshEs/q2lTGYJqQ90wVE=;
        b=pFuMpVWQk8Qvldd1znn6FN0ogbV2XhzXR9DA0uoq5XyCrvqTltfAKKgWZTkbqn9gl4
         m8NO2IOYihAyIHsSufC9e+fLGKXwr6sIZARLtPY+lG9gOVqkD2Y3x4IeEHKM28Vz53XB
         IWzTY7oaR1D3Ks1w8FL4S4e1mwS+GMVZHixKSztqcmJ15LAoEE3l50tAQO72vOVjXa+H
         UezhMkWTFzTDPIFEqvyHMgAGjZ1TlLpEdotBcIaIxmHwsGL0HBe1Jp/P+pibR++G1zed
         rAVN8WNtzmmuv0VLoFOsJyxbA9JCXTW/YR8cmaNiT4TdsDApL56gh2Lr31UA0LlAe0b3
         XBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693927278; x=1694532078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl1B7J0NnXr4SILiYpt6+iuxshEs/q2lTGYJqQ90wVE=;
        b=N3fEPHVG/0JcAGh8hVqZevIfa5H4AXKDweUQTqaIAKratOccBbWbjLPgYJMUoCmWnd
         /VrR63iNKOpxOA5Habuib/0ieMjTsd1nn5rGOC8pGmZ188MvGUDRIgw04z3UCI7K+NPl
         xdioGnk7oLZziexwGneJnF6I/95uKuJkTcau5hxHw5eIZmG5aOR389vqB2aZ46UfHkCK
         n27zMamR94ePLLVzi6rqh0UFZYxrr96QZWBjEcFN9afIUhwAOiDlb3VAL07w244lvcEC
         ldYpoHW+gtKYXUAgK7g3DDEf+Br9yCvpSKb+9zpCDvxdmWiRBWKZCkCUemzJCVNWqcSG
         YK4Q==
X-Gm-Message-State: AOJu0YwreyJNdl+UqfbTKbd/hzQIKO6jaESWFqhxfK7dSP+fhq2IxQCd
        VreiF2uYVzbyLd+kc2jPTIQ=
X-Google-Smtp-Source: AGHT+IHX/TdJ+yKBQpB3iWV5gCGpHJhkVqqjhuGJUNPhKasBAK7ZbJ2f9CazW+5woOqUfHNU7tih/w==
X-Received: by 2002:a17:90a:ff05:b0:26f:6f2a:a11 with SMTP id ce5-20020a17090aff0500b0026f6f2a0a11mr17587394pjb.12.1693927278451;
        Tue, 05 Sep 2023 08:21:18 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902788e00b001bc930d4517sm9506745pll.42.2023.09.05.08.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 08:21:18 -0700 (PDT)
Message-ID: <0a7755e4-1d6a-1f35-6826-cd54b46f0fea@gmail.com>
Date:   Tue, 5 Sep 2023 23:19:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com
References: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
 <20230830090212.3880559-2-peteryin.openbmc@gmail.com>
 <b9cbe9be-b03e-6c7a-d06c-b75b012b5b25@linaro.org>
 <18b78489-6a12-a09f-620d-985be747f9da@gmail.com>
 <a0f0ab97-2333-542a-327f-f5711136b35a@linaro.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <a0f0ab97-2333-542a-327f-f5711136b35a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/23 18:38, Krzysztof Kozlowski wrote:
> On 05/09/2023 11:55, PeterYin wrote:
>> On 8/30/23 17:44, Krzysztof Kozlowski wrote:
>>> On 30/08/2023 11:02, peteryin wrote:
>>>> Add linux device tree entry related to
>>>> Minerva specific devices connected to BMC SoC.
>>>>
>>>> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
>>> To clarify: your full name or known identity is "peteryin"?
>>>
>>>> ---
>>>>    arch/arm/boot/dts/Makefile                    |   1 +
>>>>    .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 385 ++++++++++++++++++
>>>>    2 files changed, 386 insertions(+)
>>>>    create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 9e1d7bf3cff6..edb0b2105333 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>>    	aspeed-bmc-facebook-wedge400.dtb \
>>>>    	aspeed-bmc-facebook-yamp.dtb \
>>>>    	aspeed-bmc-facebook-yosemitev2.dtb \
>>>> +	aspeed-bmc-facebook-minerva.dtb \
>>> Nothing improved here.
>>>
>>>>    	aspeed-bmc-ibm-bonnell.dtb \
>>>>    	aspeed-bmc-ibm-everest.dtb \
>>>>    	aspeed-bmc-ibm-rainier.dtb \
>>>> +	"","","","","","","","",
>>>> +	/*O0-O3 line 224-231*/
>>>> +	"","","","","","","","",
>>>> +	/*O4-O7 line 232-239*/
>>>> +	"","","","","","","","",
>>>> +	/*P0-P3 line 240-247*/
>>>> +	"","","","","","","","",
>>>> +	/*P4-P7 line 248-255*/
>>>> +	"","","","","","","","";
>>>> +};
>>>> +
>>> Nor here.
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>> Could you please clarify for me?
>>
>> Are you asking if the last line should not have a blank line, or I can't
>> set a comment for the sgpio line like this:
> 6 or 7 versions ago I said:
> "Still redundant blank line."
> so it is about stray blank line.
>
> https://lore.kernel.org/all/9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org/

Thanks for your reply.

Do you mean that I should make corrections starting from this point in my 7?

from

&i2c15 {
 >-------status = "okay";
--blank line
 >-------// SCM FRU

to

&i2c15 {
 >-------status = "okay";
 >-------// SCM FRU


or I can't  add blank line before comment

from

+    "","","","","","","","",
+    /*O0-O3 line 224-231*/
+    "","","","","","","","",
+    /*O4-O7 line 232-239*/
+    "","","","","","","","",
+    /*P0-P3 line 240-247*/
+    "","","","","","","","",
+    /*P4-P7 line 248-255*/
+    "","","","","","","","";
+};

to

+    "","","","","","","","",
/*O0-O3 line 224-231*/
+    "","","","","","","","",
/*O4-O7 line 232-239*/
+    "","","","","","","","",
/*P0-P3 line 240-247*/
+    "","","","","","","","",
/*P4-P7 line 248-255*/
+    "","","","","","","","";
+};

If not, could you please provide guidance on the expected format?

Thanks.

> Best regards,
> Krzysztof
>
