Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AA7929DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354131AbjIEQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353896AbjIEIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:33:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69113CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:33:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso32286551fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693902827; x=1694507627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fIa/MpEa51tsfHy6/cWnzhXG3DHHEf9vL3b6MO1snO8=;
        b=OnMbdMB5vCjLqUhgBi8/PmJF5kMKSFUD9qb0WBLqyStKqKg3SNCcL8FD+c/FLqjTvf
         DH/ka5TzWk0OSV5fbyGs09G3kDShcAa00sN6P+SPwGui7NeTXsEtKyDRZ4ra1zV+7uvH
         3Tt3jXjJaEuKQevTbrXcjw8nuNDBS2TD3p7B/OOG2Nj7NyBtI9H8UshBlizacwrPDiJn
         akufMpnzFMK86LeslMBsduQC0opMfbAItbmja2Lmm2NUkpRzIVAkdjhyD/8QJXOrGk3t
         Hz29H7xyVMmmY9DfvXOudYzPHXpBcrRLItNX3KjAmJGjjw7ySLbP0SDLfwBCsxZsbfsm
         niKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902827; x=1694507627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIa/MpEa51tsfHy6/cWnzhXG3DHHEf9vL3b6MO1snO8=;
        b=hc7gQAWKuw2dEVV33ed6tDxTTzVofBeldNhq/okkYSZxYxvVqbdTGuciNucIyPYUCv
         bIDi8IKPU0oF/CNZrKzQYKp9YxH/8ccae7AbnoDeE1pASR8q+oG58cp8z7ah8pbr9hs6
         8kVjh+Avg2UeLIwor0cXXDewZEOSF2Ng0oLIFjoKbR3cSMc2IHvN7xzYAZddydsw42n7
         i7nLs9lgcHzOncjImBT/tOeN2xZNuMiIBLxnYf9+tRWc0P1JCgP24201ASNFKAvbhUo5
         yGPZfdWMxdAL037d1E1wK1b2kYbaBqHF2th8zNboCRH86JkBdL+dco+x2GNtjVl9b7M4
         B/aQ==
X-Gm-Message-State: AOJu0Yx5WXD7D5nGlt3OXprqf3uPwQmW+tMrARbv+nM/pZ9Go/4/zIzy
        RkyubOOQRzYo/a0SNggvPJi1/w==
X-Google-Smtp-Source: AGHT+IERvRsqlyntQj4VnGYcehWf4fwbM2d9GauHcdKXaP7oVH8xT6P7pIWarRvWpuelwwxRKeA7rw==
X-Received: by 2002:a2e:b6c2:0:b0:2bc:da3e:3bda with SMTP id m2-20020a2eb6c2000000b002bcda3e3bdamr7592956ljo.2.1693902827530;
        Tue, 05 Sep 2023 01:33:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj43.neoplus.adsl.tpnet.pl. [83.9.3.43])
        by smtp.gmail.com with ESMTPSA id z9-20020a2e8849000000b002b9415597d0sm2774957ljj.78.2023.09.05.01.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:33:47 -0700 (PDT)
Message-ID: <879d42f0-acf7-441b-a820-3b6f67620eeb@linaro.org>
Date:   Tue, 5 Sep 2023 10:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: qcom-rng: Add hwrng support
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     neil.armstrong@linaro.org, agross@kernel.org, andersson@kernel.org,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org, vkoul@kernel.org
References: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
 <20230901144636.GP818859@hu-bjorande-lv.qualcomm.com>
 <76bec0e9-3d80-469b-8666-06f1b639facb@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <76bec0e9-3d80-469b-8666-06f1b639facb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.09.2023 04:50, Om Prakash Singh wrote:
> 
> 
> On 9/1/2023 8:16 PM, Bjorn Andersson wrote:
>> On Fri, Sep 01, 2023 at 06:45:02PM +0530, Om Prakash Singh wrote:
>>> This is follow patch on top of [1]
>>
>> This information does not add value to the git history, if you need to
>> inform the maintainer that the patch should be applied after some
>> in-flight dependency then state so after the "---" line below.
>>
>> But, this patch strictly conflicts with [1], so the statement won't make
>> sense if this is merged.
>>
>>> to add hwrng support for newer platform with trng capability.
>>
>> Please rewrite this so that it's clear that the problem you're trying to
>> solve with this patch (i.e. the problem description) is that newer
>> platforms has trng. Describe how this relates to the existing driver
>> (e.g. same/similar hardware interface). State that you purposefully kept
>> the crypto interface in place for the new hardware as well (so that it's
>> clear that this isn't an accident or oversight).
>>
>>>
>>> [1] https://lore.kernel.org/lkml/20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org/
>>>
>>> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
>>> ---
[...]

>>
>> Can you please confirm that it's appropriate to name this "trng" without
>> the "-ee" suffix. Should all trng instances (v2 and v3) skip
>> initialization?
> All trng supported platform needs to skip initialzation.
> we don't need to have both "trng-ee" and "trng".
> If "trng-ee" is prefer we shold update it in patch [1] it itself,
Looking back at ba3ab6371cdd ("crypto: qcom-rng - Add support for prng-ee"),
it was solved in a way that we would stray from today - nowadays
we'd call it qcom,msm8996-prng or something.

The -ee part was only there to discern parts that were initialized
by other software.

Since you said that all TRNGs need that, I'm also for dropping "-ee".

Konrad
