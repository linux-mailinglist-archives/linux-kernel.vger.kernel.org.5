Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E285763B90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjGZPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjGZPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:48:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC7212A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:48:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b74209fb60so101534921fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690386517; x=1690991317;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdRBaqWQcDzdroYiVTw4ku8PnAMCge9liG5VCXR9gfQ=;
        b=dYNtyQZDZwn1aFHm3OwTwze9ruXrIWPulcIqsVIOTpGLTuUyb3A11h+x544Y4vO6no
         ELxTYoBX/S73v9i/w/RazYLCQlZ1Ih9SYhqozIJ9/fCpOiswRQfGCRFdW1pjoh/AYbaD
         zsTyRgWIHaR+lCVaXkM21iNuFauElpelDGSHbLAsIpIDefLWTX2BYckI2S1QhGrArS2c
         azr498Td3h6FYfSoEdEKO+IgcMZ3l1ovQtfKNqUW2n3Ui2mkTsvwjlYMAbIqgyGmmeGC
         gOa5ykYX8+GohbAN+LmXh8E6jTVICsXJasTjv3rMBoVZoghgPwrPye3IKI33uhYt8dQA
         RZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386517; x=1690991317;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdRBaqWQcDzdroYiVTw4ku8PnAMCge9liG5VCXR9gfQ=;
        b=MF9RhjzoJf4ozm2RlBVTT/zW67gjI7otgmkuQyfgwaEltouvG7pl9MUA7sNfi9ZIMR
         M7T0rEwMCEflYFMfVGPJAG145J39c6UH/TO0Ap+RsVqh40/GgF1VX9Y60Zn5UHi+ri6+
         HhNQd9NrIsDkn+UsU1q+doIOceTfmXWW28wgzeT0kDJxirYfWOKHQ7q0FNKgsw41+Mc3
         50DC/dKIOs8GU6J7ILr87NuhNVWRPLwM0ho7NPncf7lZvmLIPcaiQahlaC7mIajiEfbF
         VOsDWlZsT14IIHpZUPeXvjPIuE2/w2fEaT0BlPpP591X1FcwpztN5ljoosFRTZoJgbSZ
         u3jA==
X-Gm-Message-State: ABy/qLYJ9JluYAg0ZJv2nKFzDsteTAjq3aFT1J/rUs4ZDX7Dq1h4FxVV
        OaVTnag1O83H+8IGRP15rz6mCQ==
X-Google-Smtp-Source: APBJJlG6AXimO2Nl+jP69zgKErNHATS6Nc6zK4sujiqR9jeRne7RNuy+p1FVCSNQsM7L8I/hIPcQEQ==
X-Received: by 2002:a2e:3001:0:b0:2b5:8a21:5627 with SMTP id w1-20020a2e3001000000b002b58a215627mr1697229ljw.51.1690386517242;
        Wed, 26 Jul 2023 08:48:37 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b6e13fcedcsm4256170ljj.122.2023.07.26.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:48:36 -0700 (PDT)
Message-ID: <df363ae5-cd45-6c9c-51dc-fa915dddde2d@linaro.org>
Date:   Wed, 26 Jul 2023 17:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] arm64: dts: qcom: msm8998: Remove AGGRE2 clock from
 SLPI
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v1-9-cf6cd5c621d5@linaro.org>
 <43afe706-5765-a8e7-2bbe-d9b21ec7a06e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <43afe706-5765-a8e7-2bbe-d9b21ec7a06e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.2023 17:50, Jeffrey Hugo wrote:
> On 7/21/2023 9:36 AM, Konrad Dybcio wrote:
>> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
>> within the interconnect driver. Attaching it to SLPI was a total hack.
>> Get rid of it.
> 
> Nit - why do we care what driver manages the clock?  DT describes hardware...
> 
> The entire SLPI block hangs off the AGGRE2 bus, so that bus needs to be on for the SLPI.  I agree that AGGRE2 is really an interconnect device and SLPI should be a consumer of that, but we don't have 8998 interconnects defined yet.  Seems like this hack is still needed.
I'll try to get somebody to check on a device with working SLPI, but
the DT-side explanation here is: this is not a clock. It's previously
been misrepresented as such, but it lies within the "interconnect"
class.

Konrad
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index 360fe3edcc08..547c3f9654a6 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -1599,9 +1599,8 @@ remoteproc_slpi: remoteproc@5800000 {
>>                 px-supply = <&vreg_lvs2a_1p8>;
>>   -            clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>> -                 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>> -            clock-names = "xo", "aggre2";
>> +            clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +            clock-names = "xo";
>>                 memory-region = <&slpi_mem>;
>>  
> 
