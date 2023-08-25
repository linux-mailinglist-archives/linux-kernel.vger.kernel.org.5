Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10678901D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjHYVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjHYVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:07:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF12136
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:07:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5009969be25so2139096e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692997638; x=1693602438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cx2kdN3V9PI0XkGpdSmIAj+sRhFlfp/arAzprHkdhNQ=;
        b=fvQ3eYkUM0EPcqWeGmQ2kAuwNIbuF89OSurRg7XDXd6lcRFfne6hcZYQlKTdZ/ZCc5
         FnQ2t+0aapFS02Sq2AOVspzKTuwzPHR6fSWAHfwTXyRBBIayk9HH7wUI863Hp+n3UhEe
         xwu94CWHoevz6G19qogtXVpk564HIyjHBcDPXd3JPAk+9w0vhjsF0Q6SuicKNk3dBD3A
         52W8aZKIvHaGGAPNUUSVKE7sazjVOBSa59mQll9me9V/nMulWDELzTfeUIddvNlA7EBM
         UtrvjysOjUlnT37l9tRZSVwpDL6YDt7COCANMPj1yN3uhdC++/j10NfoH7X1SeECLxU7
         n18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997638; x=1693602438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx2kdN3V9PI0XkGpdSmIAj+sRhFlfp/arAzprHkdhNQ=;
        b=FUpq5hRSl/ykZXHtvAAvr5PQg4J7msw17O5Jn7+ndrmpjXgtu1uF80F0fiVg7YfNyh
         ouGoy3yOvowbFR9sYDELrkH4Gh6BSlZH/UjgpKtj/+Ag5Yosr1IWsAOa/i0N21soKEyb
         WNEmPgV9gdZs5r9GF6RYXptWIQ7WMeseccNkms1uYClD7eesXZHD2zWd6dk1GFoERbXv
         IFt3FSoR1C4HOF5qzB4nupAAb0DSuDv8XkGMiOWCB7L0mR7SKRQJ+JOVDMCuiOEmbi13
         hueTajugF3dU+MEwlCHsxs15wf1coKhCRusziprhlKBMVgzeE/T2Q9rUtLtY+MRBheUb
         dFlA==
X-Gm-Message-State: AOJu0YyaCxL+amm2V24+3pMp/8vZBB/sm9tkuUVNmWD98CvYTb7fYRmA
        TYOhIoRuf2VWk5THVJA8WrkQ+A==
X-Google-Smtp-Source: AGHT+IGHQOrvSaysxx19NYESHD6PK/o4oq4OmZ4ErncEk3iae8KfMtwhFnUH3iVVYNKkLB1Kbq9FeQ==
X-Received: by 2002:a05:6512:b07:b0:4fd:fad6:5495 with SMTP id w7-20020a0565120b0700b004fdfad65495mr18092631lfu.18.1692997637827;
        Fri, 25 Aug 2023 14:07:17 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id i12-20020ac2522c000000b004fe38e566cfsm422631lfl.280.2023.08.25.14.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 14:07:17 -0700 (PDT)
Message-ID: <d413843f-5187-41ee-89aa-1f4dc0bc729d@linaro.org>
Date:   Fri, 25 Aug 2023 23:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] arm64: dts: qcom: sc7280: Add missing LMH interrupts
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
 <CAD=FV=XKeE7_ciuvfAic+24kyOF0yaFT7iCJWgN9NaW-zG+vKA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAD=FV=XKeE7_ciuvfAic+24kyOF0yaFT7iCJWgN9NaW-zG+vKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.2023 22:17, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 11, 2023 at 1:58 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Hook up the interrupts that signal the Limits Management Hardware has
>> started some sort of throttling action.
>>
>> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> test case:
>>
>> - hammer the CPUs (like compile the Linux kernel)
>> - watch -n1 "cat /proc/interrupts | grep dcvsh"
>> - the numbers go up up up up -> good
> 
> I'm not doing much on sc7280 these days,
:( I'm really sad it got the boot

but I did try putting your
> patch on a sc7280-hoglin (AKA a CRD). I tried to stress the system out
> a bunch (ran 8 instances of "while true; do true; done" and opened
> something to activate the GPU). I didn't see any LMH interrupts fire.
> Of course, with ChromeOS firmware LMH is _supposed_ to be mostly
> disabled, so maybe that's right? Our policy was always to have Linux
> do as much of the throttling as possible and only use LMH as a last
> resort.
> 
> I assume I don't need any specific config option turned on?
> 
> I know that on other Qualcomm boards I see LMH nodes in the device
> tree, which we don't have in sc7280. Like "qcom,sdm845-lmh". Is that
> important? I haven't been following what's been going on with LMH in
> Linux since we try not to use it.
It used to be important, but on newer socs it's preconfigured in fw

> 
> For giggles, I also tried putting the patch on a sc7280-villager
> device to see if it had different thermals. I even put my jacket over
> it to try to keep it warm. I saw the sensors go up to 109C on the
> medium cores and still no LMH interrupts. Oh, and then the device shut
> itself down. I guess something about thermal throttling in Linux must
> be disabled but then it still handles the critical state? :( That's
> concerning...
> 
> I put the same kernel on a trogdor device and that did normal Linux
> throttling OK. So something is definitely wonky with sc7280... I dug
> enough to find that if I used "step_wise" instead of "power_allocator"
> that it works OK, so I guess something is wonky about the config of
> power_allocator on sc7280. In any case, it's not affected by your
> patch and I've already probably spent too much time on it. :-P
Hm, perhaps it would be worth to try this patch on a non-chrome 7280
device.. Would you guys have standard android-y or windows-y firmware
that you could flash on these to try out, or should I try poking
somebody else?

Konrad
