Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D1759627
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGSNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGSNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:05:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7DE42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:05:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314172bac25so6574115f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689771901; x=1692363901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2v15FV5HEdsVZND3gNMk5XELuxxs73NjNmHo8oxKqI=;
        b=rSJ1i+OX9gZwZDcaQlfy9rGKmClFYk5KSiPEIdWLbIQ+kC+eyBq8bqmUngpv3Z+ldM
         noV7Efs0mbvE81ZZ16cOAPdP+Ip8GDjEZMsYxejtMviS5VC2D+DLt4nZR6xL4kTYxJ7k
         T3fajhKcbD82cTtaAFhbJggC9hlTT1zctDhpDwdiMmx7ffX+qK8Y2TCi8Dn5GZbhHien
         6qWJUY6k/AJiS3KRzgDjbhUv0XLEW2aLt6O73XiRIZEgI3v5S9SXPtdyxnb9lfedYljK
         qVQ83nlyYWcy75Wbtz2N3EY63/qQr9idAE9WhTDzshugFIEXCgmcWdJ0cBaVMgczURS8
         s/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771901; x=1692363901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2v15FV5HEdsVZND3gNMk5XELuxxs73NjNmHo8oxKqI=;
        b=MqgQ8/ZTKkP8oqHjqgswHY9wQYadK0kAT26o9nxJgZRWKGvLirZFPQAFhzruMJCGBF
         6P4NMZVeKqmmcl8+B7LUEu+PYHOYD+2qYk1YNWnQ5E7GnZdsm/rwVnMZp8q9meX2sjCm
         Q7q6GME8HkZNhZ4N9ZJXTZz2fwCINGVwVJ+eB/SdeCClu+ASV+yReFK1j1hymgNCbzrD
         p30ldOUgcJ63CqzpE3XYoo6R6Z01sK4mZ/epKcU2FAexnWMNK7BIgtD3TpLotmDfYWMe
         u348fj1kdlKkF6DqPGpcqjGvFUqNPGp4unNJ4HcCgJGgWeh6cRf0HipbXqHpkItRLodm
         SvJw==
X-Gm-Message-State: ABy/qLYCQxKmM06b2kow94KcOLpngMVvd81peZAcwNOHJawfUkBP2h8t
        94OLavUAVdWQwU7bt/a/YGOH9w==
X-Google-Smtp-Source: APBJJlGh07XBcpdkdM7cwI9mTKN2jyAkUp7O5TNmHvwYxF1VD6ZNE+U12v4NKdFvggmtI486OCYhlA==
X-Received: by 2002:a05:6000:102:b0:313:e9be:24e7 with SMTP id o2-20020a056000010200b00313e9be24e7mr15328251wrx.59.1689771901062;
        Wed, 19 Jul 2023 06:05:01 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d5347000000b003143add4396sm5265472wrv.22.2023.07.19.06.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:05:00 -0700 (PDT)
Message-ID: <6afa314b-ca5e-a924-de2f-f1db90770623@linaro.org>
Date:   Wed, 19 Jul 2023 14:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: venus: Fix firmware path for sm8250
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <ff2b6098-17fa-1a99-137e-c4f7c7176f10@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ff2b6098-17fa-1a99-137e-c4f7c7176f10@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 14:03, Dmitry Baryshkov wrote:
> On 12/07/2023 12:50, Bryan O'Donoghue wrote:
>> On 11/07/2023 19:53, Patrick Whewell wrote:
>>> The firmware path for the sm8250 resources is incorrect. This fixes the
>>> path to address the firmware correctly.
>>>
>>> Signed-off-by: Patrick Whewell 
>>> <patrick.whewell@sightlineapplications.com>
>>> ---
>>>   drivers/media/platform/qcom/venus/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/core.c 
>>> b/drivers/media/platform/qcom/venus/core.c
>>> index 2ae867cb4c48..348085f8fc9c 100644
>>> --- a/drivers/media/platform/qcom/venus/core.c
>>> +++ b/drivers/media/platform/qcom/venus/core.c
>>> @@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
>>>       .vmem_size = 0,
>>>       .vmem_addr = 0,
>>>       .dma_mask = 0xe0000000 - 1,
>>> -    .fwname = "qcom/vpu-1.0/venus.mdt",
>>> +    .fwname = "qcom/vpu-1.0/venus.mbn",
>>>   };
>>>   static const struct freq_tbl sc7280_freq_table[] = {
>>
>> Is the policy not to stick with .mdt for existing platforms but use 
>> .mbn for new platforms.
> 
> This was slightly different for venus, where it was suggested to use 
> .mdt for all the platforms. However last year when Chrome team was 
> updating sc7280/sc7180 Venus firmware, Rob Clark and yours truly have 
> persuaded them to (finally) switch to .mbn and provide compatibility 
> .mdt symlinks.
> 
> Then we have similarly converted all the rest of the venus firmware files.
> 
> See:
> 
> https://lore.kernel.org/linux-arm-msm/CANHAJhG-aoOBgTzirGu-1uqCFUJd+AnenMSkoUqnG3mhraCRfw@mail.gmail.com/t/#u
> 
> https://lore.kernel.org/linux-arm-msm/CANHAJhEWXf8U-FJJbOUpRV1gCXsd++H8kzbiBP1Z7iryaOCoYQ@mail.gmail.com/t/#u
> 
>>
>> https://lore.kernel.org/all/CALAqxLU1gjTY95+phBt=WksyguZuKpNKa6aYaJTe0GeCAg6WrA@mail.gmail.com/T/
>>
>> Its a symlink for me but, is it a symlink for everybody ?
>>
>> root@linaro-gnome:~# ls /lib/firmware/qcom/vpu-1.0/ -l
>> lrwxrwxrwx 1 root root       9 Dec  2  2022 venus.mdt -> venus.mbn
> 
> Yes, it is a symlink for everybody:
> 
> $ grep Link.*qcom.v linux-firmware/WHENCE
> Link: qcom/venus-1.8/venus.mdt -> venus.mbn
> Link: qcom/venus-4.2/venus.mdt -> venus.mbn
> Link: qcom/venus-5.2/venus.mdt -> venus.mbn
> Link: qcom/venus-5.4/venus.mdt -> venus.mbn
> Link: qcom/vpu-1.0/venus.mdt -> venus.mbn
> 
> So, long story short, I think this patch makes sense (and we should 
> update other entries in this file too).
> 
> Patrick, maybe you can do it as well?
> 

Fine so.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
