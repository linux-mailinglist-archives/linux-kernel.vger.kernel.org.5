Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2875F357
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGXKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:31:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6510F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:31:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so58163431fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690194669; x=1690799469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RiHIilmtHLP/QavO+OGO0GXl45X3ep1zM9w6gfMfPkI=;
        b=hb13hJgDOvjkCYKa88uF+9cle2s96UA6EUmELfaeULfNKkImo3jN7y6WVsFAZIhKGS
         /wn7vUinRseTBqMz6b1uSvW6etMkD+xtfiONU6KDJU8ss7W+r/QNIx4Ga7h1DCbDqlKp
         7BaJ7GpNlXoHJNNGNAiaqpPvy/TtkVOdgX01W0VNKMMbzIRy1u9toFWkUzY+aArm3egc
         qNfhJ0Ulj2cBHN/ftuQnjzhFXLHZR5711P7pEzwC4/EmAKsCCM9bofj3s8eiXqUlvuWS
         Y1zc8El9RX6ikctkQjzI5fkATFaq1lctpvdShJkhWYQOyB31ins7IZ2B8ObXu9wdPsG4
         p8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194669; x=1690799469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiHIilmtHLP/QavO+OGO0GXl45X3ep1zM9w6gfMfPkI=;
        b=ZlvaLHwjj90TgEep076QxUTcf2XgS3GJEUgYqIyXhu6LVvY6/RDBuPCSMe24qphjVK
         2JAh56XwUGfou+JVd5SM1I4fodK2ZFmHXxgLNB1Zy7n4sLWyyOOjqyp7scNXdsgATYcz
         9L1NVqDsAktjq/0H8xtk8rQ6CCMmEatMBoO0CHbq5KKyJ5lO2Kz9pOpIibE2442PsiTr
         DK4NnfbtERaamIQBwAZimmgvqNX9XNlU1UhZxdCjlVAFAl4bLDdqItLrWbcoFs395mBQ
         teZPbklHdfaB1SCwu4e8vVjG1usH0/OqHp0YKfdIKmpNVY3I5GFzghyeKFdb2bMi/JU/
         Jc7A==
X-Gm-Message-State: ABy/qLZqBrJN4BjIVNSjsB1bICXOvCqgyFISxGp0A5KrDXu63HckBxyR
        XoqpyqsG3VrAt/Sg6eia6AYIpA==
X-Google-Smtp-Source: APBJJlHKAzgTcZxkzYS3fSGQXQBlZ9mX3fhV1WNe2d3EY3lX3vQxMHj32kTI+ExC1ULbKMplpm78QA==
X-Received: by 2002:a2e:8097:0:b0:2b7:339c:f791 with SMTP id i23-20020a2e8097000000b002b7339cf791mr5860487ljg.25.1690194669057;
        Mon, 24 Jul 2023 03:31:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl203.neoplus.adsl.tpnet.pl. [83.9.31.203])
        by smtp.gmail.com with ESMTPSA id w12-20020a2e998c000000b002b724063010sm2774991lji.47.2023.07.24.03.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:31:08 -0700 (PDT)
Message-ID: <96573f47-d38c-2886-e408-ce463550308e@linaro.org>
Date:   Mon, 24 Jul 2023 12:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: qcm2290: Enable sync state
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
 <20230720-topic-qcm2290_icc-v1-2-7f67f2e259c1@linaro.org>
 <ZLmQdjDgIbbhyTMJ@gerhold.net>
 <3e1d650d-7c5b-381c-464f-3c464c056a1b@linaro.org>
 <ZL0InL6slLRNcVkI@gerhold.net>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZL0InL6slLRNcVkI@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2023 13:01, Stephan Gerhold wrote:
> On Fri, Jul 21, 2023 at 02:03:16PM +0200, Konrad Dybcio wrote:
>> On 20.07.2023 21:52, Stephan Gerhold wrote:
>>> On Thu, Jul 20, 2023 at 08:24:01PM +0200, Konrad Dybcio wrote:
>>>> Very surprisingly, qcm2290 does not seem to require any interface
>>>> clocks.
>>>
>>> What does this mean exactly? The interconnect .sync_state() is
>>> responsible to drop the initial maximum bandwidth votes, with the
>>> assumption that all active devices have voted for the bandwidth they
>>> need. How does this relate to "requiring interface clocks"?
>> If it required such clocks to be present, sync_state could not
>> complete, as trying to access some nodes would crash the platform
>> due to unclocked access.
> 
> You mean something like the IPA clock that must be active to do the QoS
> writes?
> 
> Wouldn't it already crash before .sync_state() then, when the initial
> max bandwidth votes are being made?
No, the bandwidth votes are fully handled by RPM with no external deps.

Only accessing the QoS registers from the AP seems to trigger crashes
on unclocked access. But surprisingly, not on this SoC.

>>>> It's therefore safe to enable sync_state to park unused devices.
>>>> Do so.
>>>
>>> Doesn't this make everything painfully slow? There are no interconnect
>>> consumers at all in qcm2290.dtsi. I would expect that all bandwidths
>>> end up at minimum.
>> There are no interconnect providers defined in qcm2290.dtsi.
> 
> Ack, so I guess you're going to add them together with the actual
> consumers?
Correct.

> 
> I think the patch itself is fine. Only the commit message is a bit
> misleading. The actual change that is being done here is enabling the
> bandwidth scaling (dropping the max bandwidth votes after
> .sync_state()). Can you try to clarify the commit message a bit?
Yes, I'll resend.

Konrad
