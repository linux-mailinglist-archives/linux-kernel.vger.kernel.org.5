Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE8778E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjHKL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:56:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47BD110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3046482e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691754973; x=1692359773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ekg8d7VnSEmC/9widfKE7c1klznCQGBPRD9AlwjwCNk=;
        b=luCkbIMvgW4IRGoXPX89ZUU3Gx8kEnm5/2hEsCllbBFMZd8Ff7WtRLHzSF0emKhN08
         fgjZELOebZH6vI5GQhzf1Kp6xmSKQRBeWuOgvBGLK1i0F25s//6/A0C0LoSH2OKWhk/F
         C7QoYlami3klNXzKk1FQiuAOeUCgoXy70wVi9niDpxcA/Ozj3hifS13ewer7F7Krc21X
         d8EiWRtMMs9DGkoEZroxHqMMmGAnRBwqXAMABr1npvsA9zW1vVdWfL0foqk5vz2hhOdY
         6DxeB3Erv1SaUx5tDqzMKv7HihTWbr76LixOTfSagGkbSW20XBvQuItkLJsY56YdLiOR
         liQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754973; x=1692359773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekg8d7VnSEmC/9widfKE7c1klznCQGBPRD9AlwjwCNk=;
        b=e7bE+fw/Tb55kC/w+pUn3x6Xaw+uvY8KBuMLl6oA63/wFiq6lEE098cXc+AVNkDdx/
         ecG9CTtlBM8BWcjQYrFC7vUtQQbeEOVtKUA5GFQkcV8vqOCTyJF2O+QIsiYpKMWpokEG
         7E5+LiCvBea4DwC+MigipM+xhBSAAv7OE62gWYMDQU8UXeYMRce079a53uEAMpq4ENEK
         1DszIx9a6mWcTf37j3NFBXI4ni1gHSUtzf7j3JQ4IsIUFuRQ03YBQd2mtOHluOxYPIt+
         w99VNdAhuCE1JuE0rlvSPA4A4K0Wp8S/amY8AhUJrIHtq/xhAG+r11KLOrdma3+XzED/
         rCOA==
X-Gm-Message-State: AOJu0YzhZ45PYv0QUj2nbBBRTJa8D/IURvzUTZva1u5Nh53jSDFU+ZSY
        a4pSiJN1AqPp1tDXnMxVRfl3xA==
X-Google-Smtp-Source: AGHT+IEKsQ60XDMTqPSCT9CvfsU5kRYoXu9i7QC5VpCaRTRcmPgMild251awN4s/7Z04kduV7m/Sgw==
X-Received: by 2002:a05:6512:3e3:b0:4f9:5a87:1028 with SMTP id n3-20020a05651203e300b004f95a871028mr1068758lfq.30.1691754972916;
        Fri, 11 Aug 2023 04:56:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id l25-20020ac24319000000b004fe0c0235ddsm704728lfh.143.2023.08.11.04.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 04:56:12 -0700 (PDT)
Message-ID: <838c5cb2-8dc8-4214-b8ba-54649ca8c6d3@linaro.org>
Date:   Fri, 11 Aug 2023 13:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: pm_helpers: Unify v3 and v4 venc/vdec_get
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811-topic-venus_dedup-v1-1-c4b4af499ef2@linaro.org>
 <85603f46-6520-6afa-1560-9ccd171475d8@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <85603f46-6520-6afa-1560-9ccd171475d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 13:52, Bryan O'Donoghue wrote:
> On 11/08/2023 12:12, Konrad Dybcio wrote:
>> They do the same thing, except v3 and earlier are expected to have the
>> old style of bindings (i.e. core clock per core under video-enc/decoder
>> subnode).
>>
>> Unify them to stop duplicating needlessly.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 34 ++++++++------------------
>>   1 file changed, 10 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index 48c9084bb4db..83d1e68bb9ca 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -295,6 +295,8 @@ static int core_get_v1(struct venus_core *core)
>>   {
>>       int ret;
>>   +    legacy_binding = true;
>> +
>>       ret = core_clks_get(core);
>>       if (ret)
>>           return ret;
>> @@ -349,6 +351,9 @@ static int vdec_get_v3(struct device *dev)
>>   {
>>       struct venus_core *core = dev_get_drvdata(dev);
>>   +    if (!legacy_binding)
>> +        return 0;
>> +
>>       return vcodec_clks_get(core, dev, core->vcodec0_clks,
>>                      core->res->vcodec0_clks);
>>   }
>> @@ -374,6 +379,9 @@ static int venc_get_v3(struct device *dev)
>>   {
>>       struct venus_core *core = dev_get_drvdata(dev);
>>   +    if (!legacy_binding)
>> +        return 0;
>> +
>>       return vcodec_clks_get(core, dev, core->vcodec1_clks,
>>                      core->res->vcodec1_clks);
>>   }
>> @@ -764,17 +772,6 @@ static int coreid_power_v4(struct venus_inst *inst, int on)
>>       return ret;
>>   }
>>   -static int vdec_get_v4(struct device *dev)
>> -{
>> -    struct venus_core *core = dev_get_drvdata(dev);
>> -
>> -    if (!legacy_binding)
>> -        return 0;
>> -
>> -    return vcodec_clks_get(core, dev, core->vcodec0_clks,
>> -                   core->res->vcodec0_clks);
>> -}
>> -
>>   static void vdec_put_v4(struct device *dev)
>>   {
>>       struct venus_core *core = dev_get_drvdata(dev);
>> @@ -809,17 +806,6 @@ static int vdec_power_v4(struct device *dev, int on)
>>       return ret;
>>   }
>>   -static int venc_get_v4(struct device *dev)
>> -{
>> -    struct venus_core *core = dev_get_drvdata(dev);
>> -
>> -    if (!legacy_binding)
>> -        return 0;
>> -
>> -    return vcodec_clks_get(core, dev, core->vcodec1_clks,
>> -                   core->res->vcodec1_clks);
>> -}
>> -
>>   static void venc_put_v4(struct device *dev)
>>   {
>>       struct venus_core *core = dev_get_drvdata(dev);
>> @@ -1180,10 +1166,10 @@ static const struct venus_pm_ops pm_ops_v4 = {
>>       .core_get = core_get_v4,
>>       .core_put = core_put_v4,
>>       .core_power = core_power_v4,
>> -    .vdec_get = vdec_get_v4,
>> +    .vdec_get = vdec_get_v3,
>>       .vdec_put = vdec_put_v4,
>>       .vdec_power = vdec_power_v4,
>> -    .venc_get = venc_get_v4,
>> +    .venc_get = venc_get_v3,
>>       .venc_put = venc_put_v4,
>>       .venc_power = venc_power_v4,
>>       .coreid_power = coreid_power_v4,
>>
>> ---
>> base-commit: 21ef7b1e17d039053edaeaf41142423810572741
>> change-id: 20230811-topic-venus_dedup-08f183d3a611
>>
>> Best regards,
> 
> This makes sense.
> 
> It'd be nice to get rid of the top-level static bool and bury it in the core venus structure but, that's not a problem with your patch.
That's the plan, just that untangling this mess will take some time

Konrad
