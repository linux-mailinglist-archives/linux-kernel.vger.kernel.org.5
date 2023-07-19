Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8B759620
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGSNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:03:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91211986
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:03:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fdd515cebcso1282921e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689771810; x=1690376610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFAMq1qPymRj6Xya9er8tBTq0cfQC5mHGrY4rGKZmos=;
        b=kuCOVQIjNz2C7vC59YqeKdz5HPDUV2Z9Bs+EyzjJHM/sGl8Na3urD6dIAQ0z3QqFd+
         fzg9+Dp9RCUUrRZZQCtyxPqx51K6e2JykTnaIz+Be+F5dMgOnBGiAW2gXDoXk1mnR6DQ
         eUvOzCY9V03/99Ye4e0DI26I6KlTT1loF+YTyvygCuNTHewG6F6PW2hrEMb25UfA6g5x
         6shhQXzUPTdmVoJU2GvSu42P0v8UWRRRQUT3vxLHqcsfwNxaYgAwiN2BGPnxfBxGG5pU
         dMu8dX3nqSyMg79nRxyK+HB4VHFzvTYgMBRwDGSVLrmJSVyscl38qB8T6u3pKfsdBkrR
         lv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771810; x=1690376610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFAMq1qPymRj6Xya9er8tBTq0cfQC5mHGrY4rGKZmos=;
        b=G10w0/q2hmWDRt3vGZc4a6YG7Ym1I2G+k13PICOpQmePJ05lAetsciMX5vjz0NUfMn
         0vNBFgA3ZDDpj++xbF6a7y4MTlFJb0TrawXIRq9UI3lBtlbxdU59TRi6ZmU02tmIZtdM
         odj8EhnHdYktWRbioQ3WfOH6Rae8zA25mzk12ife/uCWDVfQ84FJV1CLYdtVUkVZEix9
         BITHXNOwYSbQRKk5r1S8e0iKUEpA/0Dhr+CfJKdrBPlRRsBNcvX2SACrAi1Ztr8gCtC2
         spRaUG17NEn7KcHmrTJ/VQt3U/KvZwj2n3OMYThNI7h2HxQmF+yragMO/aECqMpQzRFq
         VDTQ==
X-Gm-Message-State: ABy/qLbCKySptuyxlG2pEjblveoFG60+cLXnpFajw/ogMv3U18+SgQxE
        EeWF2ldgIvi3SA/Dmkff7XGdPg==
X-Google-Smtp-Source: APBJJlEwC/ndTbsuls9mVuPZzWisBsRW2gQNAzu1hS9l9oU+Ty+9w/9dDTD6LyzohdLkNHAVHB9SNw==
X-Received: by 2002:a05:6512:559:b0:4f8:5964:ac63 with SMTP id h25-20020a056512055900b004f85964ac63mr1740441lfl.24.1689771810120;
        Wed, 19 Jul 2023 06:03:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q16-20020a19a410000000b004fbbf9e58bbsm950825lfc.126.2023.07.19.06.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:03:29 -0700 (PDT)
Message-ID: <ff2b6098-17fa-1a99-137e-c4f7c7176f10@linaro.org>
Date:   Wed, 19 Jul 2023 16:03:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: Fix firmware path for sm8250
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     William Gray <william.gray@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711185330.10106-1-patrick.whewell@sightlineapplications.com>
 <2abbae30-f92e-33e4-5509-8979129da665@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2abbae30-f92e-33e4-5509-8979129da665@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 12:50, Bryan O'Donoghue wrote:
> On 11/07/2023 19:53, Patrick Whewell wrote:
>> The firmware path for the sm8250 resources is incorrect. This fixes the
>> path to address the firmware correctly.
>>
>> Signed-off-by: Patrick Whewell 
>> <patrick.whewell@sightlineapplications.com>
>> ---
>>   drivers/media/platform/qcom/venus/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c 
>> b/drivers/media/platform/qcom/venus/core.c
>> index 2ae867cb4c48..348085f8fc9c 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
>>       .vmem_size = 0,
>>       .vmem_addr = 0,
>>       .dma_mask = 0xe0000000 - 1,
>> -    .fwname = "qcom/vpu-1.0/venus.mdt",
>> +    .fwname = "qcom/vpu-1.0/venus.mbn",
>>   };
>>   static const struct freq_tbl sc7280_freq_table[] = {
> 
> Is the policy not to stick with .mdt for existing platforms but use .mbn 
> for new platforms.

This was slightly different for venus, where it was suggested to use 
.mdt for all the platforms. However last year when Chrome team was 
updating sc7280/sc7180 Venus firmware, Rob Clark and yours truly have 
persuaded them to (finally) switch to .mbn and provide compatibility 
.mdt symlinks.

Then we have similarly converted all the rest of the venus firmware files.

See:

https://lore.kernel.org/linux-arm-msm/CANHAJhG-aoOBgTzirGu-1uqCFUJd+AnenMSkoUqnG3mhraCRfw@mail.gmail.com/t/#u

https://lore.kernel.org/linux-arm-msm/CANHAJhEWXf8U-FJJbOUpRV1gCXsd++H8kzbiBP1Z7iryaOCoYQ@mail.gmail.com/t/#u

> 
> https://lore.kernel.org/all/CALAqxLU1gjTY95+phBt=WksyguZuKpNKa6aYaJTe0GeCAg6WrA@mail.gmail.com/T/
> 
> Its a symlink for me but, is it a symlink for everybody ?
> 
> root@linaro-gnome:~# ls /lib/firmware/qcom/vpu-1.0/ -l
> lrwxrwxrwx 1 root root       9 Dec  2  2022 venus.mdt -> venus.mbn

Yes, it is a symlink for everybody:

$ grep Link.*qcom.v linux-firmware/WHENCE
Link: qcom/venus-1.8/venus.mdt -> venus.mbn
Link: qcom/venus-4.2/venus.mdt -> venus.mbn
Link: qcom/venus-5.2/venus.mdt -> venus.mbn
Link: qcom/venus-5.4/venus.mdt -> venus.mbn
Link: qcom/vpu-1.0/venus.mdt -> venus.mbn

So, long story short, I think this patch makes sense (and we should 
update other entries in this file too).

Patrick, maybe you can do it as well?

-- 
With best wishes
Dmitry

