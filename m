Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1E777C21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjHJP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjHJP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:26:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780B26B7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:26:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31781e15a0cso974965f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691681196; x=1692285996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNsC6DRU5bpBnpx9EKSFoX9Gyu3UdgIgeXbnvwbee7o=;
        b=saXEWEv1TYSunNNOBEbbtEsjxNa0G7OjPxOT6CRT8ftCK4ImJTdpBi0ys1X3saFRP9
         x8Y9YZ3p/xl94xozpMB7Fsk2dLsTLozy8VkVNckc5WzHCcH/orTEiFnqDiUQ+jWKi8er
         9iMq2pMAKGeZaW8YQQ7XNm3iK5ax+ibo7e8KTxKq7aO53WkvfQGjKTcTIJHMS6PB33mc
         +Nzm746U0Kw2E4ojGtEJTUsvxqF+iA00Fxo5KDq/+29Xkh7H/1nmjeDg1ZTSE0WitBYe
         tuPzfDKqt/HcVrvFxRZyKQkAenBeTRW6DfKvGvjssE5G2s/r0w83tFJnjqhxQHFz5P4i
         Qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681196; x=1692285996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNsC6DRU5bpBnpx9EKSFoX9Gyu3UdgIgeXbnvwbee7o=;
        b=iZ5Aa/KFW0f4xN5FhC/qX41hs2Ps1/1/YFlxZIYTSy81nUJKGWp7vN70z51RmBWYaT
         yIjHZI+jRFkSVltKpBZzOidd8Rg1x8c7vHgr7l6Wag4YACcEWjxOqCIDWuUfW4+2iKN3
         rPFp0DZrvBE7EryuQlzgiz/jk1sW6fvCrhUk+WBZ7oE+tiwkzioftjlr3NbfR43pgM/O
         7fawLWBAmFCV0g0PABWtMmACH800hl3A6Z52rx9xozNSCMmxUzKgPcgXwvSOuzeGnWUG
         uBAb6NkzjeqZ8NuDhZVpwsaIiTpAJNXLXhLMKSwrH7b5/0+RfPmhVyTqRIQ6DYfwZ2WE
         imjQ==
X-Gm-Message-State: AOJu0YwjBtwvPircbfofY84SKw1wTXef6jKSyyKBlpcFywgpTmPyB9Na
        Edt0bZd8Nu7Xg3RW/1KtW3NQSw==
X-Google-Smtp-Source: AGHT+IFijmy+AKPYmuwLBhNSxBrYVoO1dLa2WWrHtoa4kx5x+axf9Kr6sq1PRCnv2BvpA9g2cyE46g==
X-Received: by 2002:a5d:66cf:0:b0:317:5bb2:aeca with SMTP id k15-20020a5d66cf000000b003175bb2aecamr2134924wrw.16.1691681196022;
        Thu, 10 Aug 2023 08:26:36 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b00317e9f8f194sm2505073wrp.34.2023.08.10.08.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 08:26:35 -0700 (PDT)
Message-ID: <d839ef44-3427-88b8-513e-a84b24cc6929@linaro.org>
Date:   Thu, 10 Aug 2023 16:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine:
 Move default ov5640 to a standalone dts
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
 <20230809202343.1098425-6-bryan.odonoghue@linaro.org>
 <ZNT9nLaSBZvm1HNe@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZNT9nLaSBZvm1HNe@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 16:11, Stephan Gerhold wrote:
> Hi,
> 
> just some nitpicks. Some of them were present before already but maybe
> you can prepend or append another cleanup patch while at it. :)
> 
> On Wed, Aug 09, 2023 at 09:23:42PM +0100, Bryan O'Donoghue wrote:
>> At the moment we define a single ov5640 sensor in the apq8016-sbc and
>> disable that sensor.
>>
>> The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
>> card. Move the definition from the apq8016-sbc where it shouldn't be to a
>> standalone dts.
>>
> 
> I wonder what would be required to implement this using a DT overlay,
> rather than a standalone separate DT? Seems like there are some .dtso
> files in upstream Linux.
> 
> I'm also fine with the separate DTB personally, though.

So, we've discussed that previously and its a good model, which I like 
and which works well for RPI as an example.

AFAIK though the runtime dtbo overlay is still missing at least one 
upstream commit and the state of dtbo in qcom bootloaders is variable, 
probably good in LK, good in u-boot and then I'd say nothing doing.

I'm hoping to transition the mezzanine dtb files to something "generic" 
for boards that support 96 boards interfaces.

Its a bit out of scope for this series as, all I really want to do here 
is fixup obvious errors as I find them in camss and its dtbs.

So anyway the idea would be to define labels in the core board dts files 
for stuff like "powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;" I'm not 
sure that's really feasible until its tried though.

Basically any mezzanine board would ideally only be defined once, with 
96boards supporting baseboards providing the necessary additional detail 
on pins and regulators for the mezzanine to consume..

Come to think of it though you'd have to #include "myboard.dts" so 
maybe, probably, that idea not feasible.

dtbo would be better still but like I say I'm not presupposing a decent 
bootloader that can apply the overlay.

I/we will look again at dtbo since its just a neater model really.

>> Enables the sensor by default, as we are adding a standalone mezzanine
>> structure.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |  1 +
>>   .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 55 +++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 49 -----------------
>>   3 files changed, 56 insertions(+), 49 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f15548dbfa56e..19016765ba4c6 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
>> new file mode 100644
>> index 0000000000000..ef0e76e424898
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Linaro Ltd.
>> + */
> 
> I assume you have permission from the original contributor to relicense
> this? apq8016-sbc.dts is GPL.

Eh it was Loic @ Linaro but, TBH I just added a boilerplate here ...

No you're right this should be // SPDX-License-Identifier: GPL-2.0-only

> 
>> +
>> +/dts-v1/;
>> +
>> +#include "apq8016-sbc.dts"
>> +
> 
> Please also move the fixed regulators here, they're part of the
> mezzanine, not the DB410c.

ack, true

> 
>> +&camss {
>> +	status = "okay";
>> +
>> +	ports {
>> +		port@0 {
>> +			reg = <0>;
>> +			csiphy0_ep: endpoint {
>> +				data-lanes = <0 2>;
>> +				remote-endpoint = <&ov5640_ep>;
>> +				status = "okay";
> 
> Should be unneeded since it's not set to disabled anywhere?

>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&cci {
>> +	status = "okay";
>> +};
>> +
>> +&cci_i2c0 {
>> +	camera_rear@3b {
> 
> camera@

sure

---
bod

