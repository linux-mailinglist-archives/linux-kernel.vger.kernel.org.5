Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B217901A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjIARzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjIARzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:55:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40434E66
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:55:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007f3d3235so4060077e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693590933; x=1694195733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXwfrkGM7Hz+jCAI0wm9OEdUpgziFLOO3YnjHkqpV2w=;
        b=xdoz+/a23dmydI3ey5EbohLlk1xVa0PRFwgfEbKyT5yqzWSZpmqKvxzagemM34mJHr
         BiuPFGWu/VgtvMSiCict3JQAwZZAAmqMX+deq9FXGMmnFTuR1nniieoryYnObZwysVUH
         E8TY7LxHC/Tm6kXNPq8ennScCZt7NJdGlAJtBeQWjcYjJNbf4Kp4aaO/eCM2nQiS7rhb
         xs9IHcK/wKzgxe8EY0V8jBIVWhC1vHxvQqdI0XGyuqmy2mQ1lmngVsQsWdb2JtYXPnAE
         NlP9OorykmSZegjxcCrtl1ToNMnI+k3Ee8pfVxczjiI2AyZ62bLN8pvCguVT/9mchIGo
         M2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693590933; x=1694195733;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXwfrkGM7Hz+jCAI0wm9OEdUpgziFLOO3YnjHkqpV2w=;
        b=e2TQrvxRURLw3sQdaWv8gKxt7/bjpRdNU7AG4SjlVLiDL+iEf2SflTtUKir6Lw/U7n
         pWv5AQROYMZiucGhG4/tidaG2b1/LDHjy0lYOYkbJBueoXopaWZN3F9x43+7+2tG/FFo
         GtPVA0gQ7XLiTB1+KAaw6jSfhM915Vn0Yepxoc921KvpZFa3k9xtnU75D4RmmUMZzRZD
         zP+2UQRAHL4OL+bycBsEfUSQTP17n3Wka4wUCukENNFwCi3zYY6UL3sDWLrG2Ao/VTjF
         r8CTROnt6/RY6g+glOFJD8QqkxR4C82K47k9mxegCZrKH86Jlse1l5PH8UTj9vm9IlO/
         lAdQ==
X-Gm-Message-State: AOJu0YwVCz0kIin5CxICxZXNI9y6HqkcrYmS4PBv1Jh372lSZ4CEmFb9
        i7h6aA/VthernGM2GWsC2l9hqQ==
X-Google-Smtp-Source: AGHT+IEVz6fJWAjbQSaZH9j8buVj8fBa5mtJlorGodbyAE6AeJjp2x4UEgh5FPmAsFJCi5/vrH6s7Q==
X-Received: by 2002:a05:6512:2016:b0:500:91c1:9642 with SMTP id a22-20020a056512201600b0050091c19642mr1780047lfb.21.1693590933257;
        Fri, 01 Sep 2023 10:55:33 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id r1-20020a19ac41000000b004ff748f6f1fsm717827lfc.69.2023.09.01.10.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 10:55:32 -0700 (PDT)
Message-ID: <519259d7-ac6d-409b-a864-071e41f66f70@linaro.org>
Date:   Fri, 1 Sep 2023 19:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
 <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
 <33a26241-026a-9466-5dd6-e3202b29f57c@linaro.org>
 <ybugl2m7o5cnzj4lv5ksit2rip6yvths5ieo3xlw6cycto2zax@2jimga475z2t>
 <ZLeiM6l6tu6XDzrr@hovoldconsulting.com>
 <cc9e6464-5e47-4044-9785-c57167f0e1c5@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <cc9e6464-5e47-4044-9785-c57167f0e1c5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.08.2023 18:52, Konrad Dybcio wrote:
> On 19.07.2023 10:43, Johan Hovold wrote:
>> On Tue, Jul 18, 2023 at 09:23:52AM -0700, Bjorn Andersson wrote:
>>> On Tue, Jul 18, 2023 at 03:26:51PM +0200, Konrad Dybcio wrote:
>>>> On 18.07.2023 15:20, Johan Hovold wrote:
>>>>> On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
>>>>>> Some clocks need to be always-on, but we don't really do anything
>>>>>> with them, other than calling enable() once and telling Linux they're
>>>>>> enabled.
>>>>>>
>>>>>> Unregister them to save a couple of bytes and, perhaps more
>>>>>> importantly, allow for runtime suspend of the clock controller device,
>>>>>> as CLK_IS_CRITICAL prevents the latter.
>>>>>
>>>>> But this doesn't sound right. How can you disable a controller which
>>>>> still has clocks enabled?
>>>>>
>>>>> Shouldn't instead these clocks be modelled properly so that they are
>>>>> only enabled when actually needed?
>>>> Hm.. We do have clk_branch2_aon_ops, but something still needs to
>>>> toggle these clocks.
>>>>
>>>
>>> Before we started replacing these clocks with static votes, I handled
>>> exactly this problem in the turingcc-qcs404 driver by registering the
>>> ahb clock with a pm_clk_add(). The clock framework will then
>>> automagically keep the clock enabled around operations, but it will also
>>> keep the runtime state active as long as the clock is prepared.
>>>
>>> As mentioned in an earlier reply today, there's no similarity to this in
>>> the reset or gdsc code, so we'd need to add that in order to rely on
>>> such mechanism.
>>
>> This reminds me of:
>>
>> 	4cc47e8add63 ("clk: qcom: gdsc: Remove direct runtime PM calls")
>>
>> which recently removed a broken attempt to implement this for gdscs.
>>
>> Just stumbled over GENPD_FLAG_PM_CLK which may provide a way forward at
>> least for genpd (but see below).
>>
>>>> I *think* we could leave a permanent vote in probe() without breaking
>>>> runtime pm! I'll give it a spin bit later..
>>>>
>>>
>>> Modelling the AHB clock in DT and putting a devm_clk_get_enabled() would
>>> properly connect the two, and thereby handle probe order between the two
>>> clock controllers.
>>
>> Yeah, this dependency really should be described eventually.
>>
>>> But it would prevent the power-domain of the parent provider to ever
>>> suspending. Using pm_clk_add() this would at least depend on client
>>> votes.
>>
>> IIUC using pm_clk_add() would also prevent the parent from suspending
>> due to that resume call in clk_prepare().
>>
>> And this mechanism is also used for GENPD_FLAG_PM_CLK...
> So.. how do we go about solving the issue that this patch tried to
> address?
I see things this way:

- clock controllers (non-gcc) that use magic writes today,
  they should stay as they are to avoid dramatic spaghetti wrt
  dt backwards compatibility

- clock controllers (non-gcc) that use CLK_IS_CRITICAL are
  transitioned to magic writes to skip the PM code fluff which
  prevents shutting down the PDs if any clock is critical and
  for uniformity with point 1 (as the device trees still don't
  contain any references to the necessary clocks)

- new clock controllers are modeled with use of pm_clk and with
  proper device tree references

FWIW Qualcomm nowadays just keep these clocks always on (answering
Johan's question - they're either off-from-Linux-POV-not-really-in-
hardware or these clocks retain the enable bit, I don't know) in
their shipping downstream kernels, the power leak is probably
minimal, but if we can avoid it, every nanowatt is to our advantage

Konrad
