Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E267926C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbjIEQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354156AbjIEJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:57:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25319CC3;
        Tue,  5 Sep 2023 02:57:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so1388793b3a.3;
        Tue, 05 Sep 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693907859; x=1694512659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MXWXFgX5aFPhZ6qllDXEBQgIeC6Jxy5NEVmVqVP4Hs=;
        b=aFxe+LwMnG36M23x+RiCX7g0LxvbGQzo8PTxadsvhFqmxpGHs3ts/vWbIrNRL+yxCI
         Y7F5JsviQAqBgBV23p+MX9RWiAPmxHqPb3QdD6xv9Fi5U5g7bHNcMQNYFRDMIZlrLl3k
         2ZgXkTotZFfXzLSqjdMG5elagzjPGVikxJPXW7glGzjjWP/TLW1XHJCpie7evF0aFiyR
         HL9xW86P9g+qLlN21hVwwW1Fw0k3wiWiXfphCgbifjQg1A92UvGze5+/5uUeF3PWMkrx
         UUdehyNCDyBy5PyMl2NuW/lDDtDvSMt6ZVOecgfQ/0oHsJKzTuZD5Rv7bOyiPxBUS2lO
         EBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907859; x=1694512659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MXWXFgX5aFPhZ6qllDXEBQgIeC6Jxy5NEVmVqVP4Hs=;
        b=VTmA+B5rHy7QztB3sxtPt8UG6DjLnkmP6BbeaKAeR84i87/MSWEjMAyeX6OLuaOuEw
         xdBYU/TOpu6xZ6qQicqGEmnfgJulsqQ2usV4/1WXLfxA4sQ5X8/wic71g/0dGduCg14q
         7Sh8lC1YKMDKIR/T1HcOME3B+Do8Mv56zLn131wfpL1g/EbD1UgahNAVhmOenAbkT/TJ
         VycbfN9fodejKYvOfw5sOeLGUVzJZU6kXwrOkDFNVtk+aDGRF49qvAucQfb0X8YqvHwZ
         fG0bFsihpqqSYAi7lA+E+uUEt6sTqPsg+L5cyjLM7j2MsEdIJZp8NHsQpCZKHQcbYQdT
         iz+w==
X-Gm-Message-State: AOJu0YxKngOEEhf0TMrYHCQqOnqAo+EfpsOYg8VMs6ysKKA45IuUMNUH
        OBIhfMxEbgYyQAhfLI+sSbMouCF9mobqPg==
X-Google-Smtp-Source: AGHT+IG9oGAsnYDLZhL+LakWC4U811CoL+trnqHsY45OMKtbt/MUxwWcgiOmJozHaNgB60WIAUpsRQ==
X-Received: by 2002:a05:6a20:748d:b0:13b:9e04:5466 with SMTP id p13-20020a056a20748d00b0013b9e045466mr12415184pzd.49.1693907859389;
        Tue, 05 Sep 2023 02:57:39 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b0064d57ecaa1dsm8710981pfn.28.2023.09.05.02.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 02:57:39 -0700 (PDT)
Message-ID: <18b78489-6a12-a09f-620d-985be747f9da@gmail.com>
Date:   Tue, 5 Sep 2023 17:55:25 +0800
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
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <b9cbe9be-b03e-6c7a-d06c-b75b012b5b25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/23 17:44, Krzysztof Kozlowski wrote:
> On 30/08/2023 11:02, peteryin wrote:
>> Add linux device tree entry related to
>> Minerva specific devices connected to BMC SoC.
>>
>> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> To clarify: your full name or known identity is "peteryin"?
>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 385 ++++++++++++++++++
>>   2 files changed, 386 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 9e1d7bf3cff6..edb0b2105333 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-bmc-facebook-wedge400.dtb \
>>   	aspeed-bmc-facebook-yamp.dtb \
>>   	aspeed-bmc-facebook-yosemitev2.dtb \
>> +	aspeed-bmc-facebook-minerva.dtb \
> Nothing improved here.
>
>>   	aspeed-bmc-ibm-bonnell.dtb \
>>   	aspeed-bmc-ibm-everest.dtb \
>>   	aspeed-bmc-ibm-rainier.dtb \
>
>> +	"","","","","","","","",
>> +	/*O0-O3 line 224-231*/
>> +	"","","","","","","","",
>> +	/*O4-O7 line 232-239*/
>> +	"","","","","","","","",
>> +	/*P0-P3 line 240-247*/
>> +	"","","","","","","","",
>> +	/*P4-P7 line 248-255*/
>> +	"","","","","","","","";
>> +};
>> +
> Nor here.
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
Could you please clarify for me?

Are you asking if the last line should not have a blank line, or I can't 
set a comment for the sgpio line like this:

/*P4-P7 line 248-255*/

> Thank you.
>
> Best regards,
> Krzysztof
>
