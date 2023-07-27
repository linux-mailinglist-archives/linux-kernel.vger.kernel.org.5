Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87707649B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjG0IC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjG0ICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:02:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7A4C29
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:59:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so2411382e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690444752; x=1691049552;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfNbDLYC26biBGsggpyLhltrK0rGvNpSu33CJuB2kx8=;
        b=YAicZCiH7pUA2/T0IHgQlktcWTxPWBNbtnRF+qKUTwNMZfxArt5dBNm+XycC+tB29f
         QkmQa6cD5sGu9bMVdlIoaDLcT9ugDJUgkYQLwe8A2etaSjqc4otaWeyhpouFJn1A1ReV
         39yZWukkxLu721hGFTKpL7VIAAUca9CCT/E4NsEyvivt7rKk+ZqAX6Kpu/NcAPtIpF3C
         d75V5wN7Ihf6dgAu4fYc1gQf/E9jU8ZSR9hPk9WTu42S28bYyIl0XnDutDywzd3fbGKo
         k7NrtC9jZPA3L8cixtA6WmOICHRoy2XXr4c4NjwJ7PQKXeErU3RIOLdZ+16OviNw7uZD
         S61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444752; x=1691049552;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfNbDLYC26biBGsggpyLhltrK0rGvNpSu33CJuB2kx8=;
        b=lfk5VauWzv+m9T3hD2c5rsr2wTc6VdOnTmBWcO3SbapySb7dcUraxASz4E2Xkg3lA6
         NYAKkt2ZcoUbJP8IwLNION1S6bUrMJAbACWJuEPH4bBp4HZBaEUP41Yt/GXmzgP8L3RG
         UZM1h6Sbc3CsieaTAQheDXFMP4G5b2hHo8T9RLu97CkedpKHWTW4PwGvLsicaAU5tRZ3
         0l63hPzlrN5lv7BHszHeRU0cGR4RpGUQUkX0z3n08eQssqKVJy8AoG2jnRO1BcELGu0V
         9+xfg66qPkLs5j6r1EQ9dJtF8BudpTSad2iEwWqDqYhDpNV0NsHDnZTQU3P/079TxpnO
         hWmQ==
X-Gm-Message-State: ABy/qLZD5nWPvTirC2vaO3rnzzexY29ksL0SmmJTNGsLkFBK1ho1xqge
        PK3fdpm/OeFxdIcLawMMzccRi3kPBYqXjVryEp5+2w==
X-Google-Smtp-Source: APBJJlGAmRNwLiXcMg7/t/QBv4vvfkcQ5a5T3E/x5Cx+1Hq/t1T1ewcQRouL801QvhgzD0T6mCj0lg==
X-Received: by 2002:a19:5006:0:b0:4f8:6831:fd70 with SMTP id e6-20020a195006000000b004f86831fd70mr534271lfb.3.1690444752336;
        Thu, 27 Jul 2023 00:59:12 -0700 (PDT)
Received: from [192.168.1.101] (abxj4.neoplus.adsl.tpnet.pl. [83.9.3.4])
        by smtp.gmail.com with ESMTPSA id w16-20020ac25d50000000b004fb64600e5dsm191843lfd.219.2023.07.27.00.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:59:12 -0700 (PDT)
Message-ID: <518770c2-05ad-a2a2-4e73-7ceb30687614@linaro.org>
Date:   Thu, 27 Jul 2023 09:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
 <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.2023 08:56, Krzysztof Kozlowski wrote:
> On 27/07/2023 04:35, Tengfei Fan wrote:
>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>  2 files changed, 19 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 337abc4ceb17..db805d0929c8 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -186,6 +186,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> new file mode 100644
>> index 000000000000..04ad1dd4285a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4450.dtsi"
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>> +	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>> +
>> +	aliases { };
>> +
>> +	chosen {
>> +		bootargs = "console=hvc0 earlycon=hvc0 hvc_dcc.enable=1 cpuidle.off=1";
> 
> No earlycon, no hvc.enable (there is no such parameter), no cpuidle.off
> (again don't add fake stuff). So the only suitable argument is console,
> but this should be actually used via stdout path, although it seems
> there is no device node for such usage?
hvc totally comes from Qualcomm downstream and all the Gunyah
shenanigans..

Tengfei, please ensure the patches are tested against linux-next
with no additional changes or modules, with a clean Linux userspace
(or at least a ramdisk).

Konrad
