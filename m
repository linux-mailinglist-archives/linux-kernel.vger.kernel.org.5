Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE47AF4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjIZUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjIZUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:18:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80713A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:18:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32333fb6beeso2627515f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695759505; x=1696364305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+81qDPZNqpR8eYxIDUO2ZfevYUKo4zlzZshzHiE6JqQ=;
        b=kidZRP6zp7p/EPBgCvG4vVxphieUfnVVnTIoxH+qHmwIJd7GZR8vc7DKgmA1RZKv9h
         6VE4szJh2PXmG7yUbgfhkOmAOMPkCxKDNNK780xIaBxIzmq+4pp5lqLwhjrh5QXQ0Qf6
         K7beiDrggqab0/Hj+w7JGwNKJ8LKJ80XZbP7Qd1L4xy1cmXAibqoCfa9RFawsgSsEZbj
         LryIY8jCSpEqgn5Oyx6jo7gEUr9Qkuf+MnyqGEFxuogcXfZ/skm8QFJ2I9HaERqs9kUb
         4W9GXO/8yjlDf68rAiicbJi1RJWXEdhQmn7il0UjH8sXuFR0vCBRC5iuYdfFcxsNuD56
         Ladw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695759505; x=1696364305;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+81qDPZNqpR8eYxIDUO2ZfevYUKo4zlzZshzHiE6JqQ=;
        b=gOCPtmjqGjJmh986SX1eYVRtJmEiYNTxDln50OK14cQN18QV/+eE9aZ8EX4v0fi3+b
         j+O8uqCFAGeY7vGGceaVaEbI84JS5Em69IxyUlOWumL2wJLrRNPi5xnM0YWdGzy9v6UZ
         8o7V4uejSaFd76TXfo80w3q8QxEh2eDdzPebOQAb0gftuPbpcaUgr4xud6nB4dHGkFdh
         bL8HBcwOgAxoUb8v0YnJOmBxJ+CffhuPTwvlCE7Xy+WFJ5XeTFnfTa+/J5HQjYBcAsA8
         OqBWjlkmnuBkZ1odgFVzkg4MHdWD9gAFO0O0mATlEXW9dHb40mYHHe4+egbPucnSQIp9
         p0Mw==
X-Gm-Message-State: AOJu0YxCP+YTvZhI8iTmtCnF9Tr1rAzv4i1unl/1UqDtzVA9MRIF33Dl
        nccx9xsah8onJyAgpC5nFB9THQ==
X-Google-Smtp-Source: AGHT+IGVONNYAPC5n7xGXk2r0jfsjgQXokg9/YcysxoVlHNAZOY9XmtsA63E1IboX9gczARb8NpEQA==
X-Received: by 2002:adf:ea84:0:b0:319:6327:6adb with SMTP id s4-20020adfea84000000b0031963276adbmr9190097wrm.70.1695759504956;
        Tue, 26 Sep 2023 13:18:24 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id gv10-20020a170906f10a00b0099cd008c1a4sm8163271ejb.136.2023.09.26.13.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:18:24 -0700 (PDT)
Message-ID: <9b9a9c0d-8a09-48a4-b996-554d7e1b9340@linaro.org>
Date:   Tue, 26 Sep 2023 22:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm64: dts: qcom: msm8916-samsung-a2015: Add sound
 and modem
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
 <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
 <ZRMwdRo9hAm4BO5E@gerhold.net>
 <278ac134-992e-460a-b37a-60a746eab107@linaro.org>
 <ZRM6dJXNvx93jFrM@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZRM6dJXNvx93jFrM@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 22:09, Stephan Gerhold wrote:
> On Tue, Sep 26, 2023 at 09:56:12PM +0200, Konrad Dybcio wrote:
>> [...]
>>
>>>>> +
>>>>>  &blsp_i2c2 {
>>>>>  	status = "okay";
>>>>>  
>>>>> @@ -243,6 +258,13 @@ &gpu {
>>>>>  	status = "okay";
>>>>>  };
>>>>>  
>>>>> +&lpass {
>>>>> +	dai-link@3 {
>>>>> +		reg = <MI2S_QUATERNARY>;
>>>>> +		qcom,playback-sd-lines = <1>;
>>>>> +	};
>>>>> +};
>>>> Is that not status = reserved?
>>>>
>>>
>>> Correct. This is here to simplify switching to the modem-bypass audio
>>> routing if someone does not need (or want) the modem. The direct audio
>>> path with the LPASS drivers tends to be more reliable and configurable
>>> (especially wrt bit formats, sampling rates, latency, channels etc).
>>> I know that at some point this helped someone who tried to use an old
>>> phone as some kind of portable musical instrument / synthesizer.
>>>
>>> It's not too obvious that these definitions would be needed when making
>>> those changes (because devices using the standard SD lines (i.e <0>) do
>>> not need it). If you forget about this you get non-functional audio with
>>> no error or any hint what could be wrong.
>>>
>>> To simplify switching between the different audio routing options, the
>>> lk2nd bootloader actually has an option to do this transformation in the
>>> DTB automagically during boot. It's sort of like a DTB overlay that
>>> disables the QDSP6 audio path and enables this node instead. The DAI
>>> links are also adjusted where necessary.
>>>
>>> Do you think a comment would help here?
>> I'd say a comment would be necessary here :D
>>
> 
> No problem, I will try to add something simple.
> 
>> While I understand this use-case, I believe this is better suited
>> for an actual DTBO or something entirely kept inside lk2nd.
>> Otherwise this looks very confusing to an outside reader.
>>
> 
> Translating from the QDSP6 audio setup to the LPASS one is mostly simple
> but not entirely trivial (especially the patching needed for the DAI
> links). Main blocker for DTBOs is that you can only add or change, but
> AFAIK there is no mechanism to _delete_ or fully recreate nodes.
Correct.

> 
> I guess I could maybe derive this from the QDSP6 definitions using
> custom magic code, but the code complexity for that is much higher than
> adding these nodes here for completeness.
I hate to be the bearer of bad news, but this is probably more
of a "do we reasonably want this upstream" type question, as
you'll probably get some grumpy emails about upstream not caring
about what's outside the mainline tree..

> 
> Let me try to add some comment first.
Please try to explicitly explain the reasoning of why one would
want this change and what are the drawbacks etc.

Konrad
