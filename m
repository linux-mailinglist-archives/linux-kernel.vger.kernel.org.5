Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608C7B4EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjJBJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjJBJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:13:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202F8AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:13:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c007d6159aso248253171fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696237982; x=1696842782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T79zDNJj+9dqlOgFzCSfd183bIz+iEwSOWv3GoRBRtE=;
        b=QB8EdX7gZKNwSd5+sPoKoR7YwxInMcbCD2qO1VSTDimF6RHItZK6O5gB+1MqVhHmQj
         b+FT3zCG7VbCj9l/fa3AlSvT46w24SnmF32JMhfyd2ZHZdclNj3HnAUmQvy/H6ZGrzcz
         vR0BfrnAst8xTbzdWPrNn7ksMDD8/niHsppZi9JXM0GgGw6oWh4h4egpgEcrO1myjgjL
         MV6LBuglWp8eGYZsyuYfal1nKpPqH5/c9awnDSMoNtGafN5t8ZBNbbX5dbsv5XGY41S3
         ZQbiVVU2Fhxy/eZ2PEuP3CuC0G9aIE8EYUob/nkfEvFTD0qBFBP06MZUrX7ojPFzmBqP
         ogRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696237982; x=1696842782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T79zDNJj+9dqlOgFzCSfd183bIz+iEwSOWv3GoRBRtE=;
        b=QqUMA22OnrsYevaxfv9zdpYHQ/Zcc9hdUzS/PafLEfzpR33CSBJGSMCf4kDHucBeCK
         XgQ6Q00HDQEXKNYiDkNGtNHPWN4siBxDGU/aXnQ9OEH+ldZ0M2SpSbZ3EU2/qTPXAJ/K
         M1b0FswedUnKECvGB+LkyguefHZv1xfRLrzxBNlza9TbeUoIOLyS9AwOpecQeetJ7ZZL
         tJdToYquK8BGglTx/gUrlj4oqo8VyIsza5bWQ5FPW897ucE1VuBqVufiAKX0StlMZh9b
         BeL42/VOsK4/+qRBKyr/xIHy4DQmdPSJStjE2kVGNpqGFpoCZfRCiuXxPpvcWa8BGfD3
         6NRg==
X-Gm-Message-State: AOJu0YyBWqotr+zl2a3VdMa0auciIe6QZG/n9bTLAEYvc+CAaRLh5MS7
        0Dg7idwvhHG9+q4CfUHhbBXu1qOgqA3SvE44SgA=
X-Google-Smtp-Source: AGHT+IFI4DCv7GEmbK66/p7aD+zFDDg5iKgxWQ1eNYOaUPF8JCihOkYql9dU9KeK2py0z+NCRusgug==
X-Received: by 2002:a2e:9c9a:0:b0:2b6:dc55:c3c7 with SMTP id x26-20020a2e9c9a000000b002b6dc55c3c7mr10839642lji.20.1696237982239;
        Mon, 02 Oct 2023 02:13:02 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p11-20020a2e9acb000000b002b9e9a8532dsm5324593ljj.138.2023.10.02.02.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:13:01 -0700 (PDT)
Message-ID: <9096086a-3bae-be33-7961-f9db24f301da@linaro.org>
Date:   Mon, 2 Oct 2023 11:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sc8280xp: Don't keep display AHB
 clocks always-on
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230929-topic-8280_ahbdisp-v1-0-72bdc38309b9@linaro.org>
 <20230929-topic-8280_ahbdisp-v1-2-72bdc38309b9@linaro.org>
 <ZRfsvAJIdlmOWjf2@hovoldconsulting.com>
 <43473e04-ac33-179e-4343-e5c78eef3faf@linaro.org>
 <ZRqAel1pwLom-h45@hovoldconsulting.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZRqAel1pwLom-h45@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/23 10:34, Johan Hovold wrote:
> On Sat, Sep 30, 2023 at 06:44:47PM +0200, Konrad Dybcio wrote:
>> On 9/30/23 11:39, Johan Hovold wrote:
>>> On Fri, Sep 29, 2023 at 03:38:53PM +0200, Konrad Dybcio wrote:
>>>> These clocks are consumed by the dispcc[01] clock controllers, so there's
>>>> no reason to keep them on from gcc probe. Remove that hack.
>>>
>>> Eh, how did you test this patch?
> 
>> Oehh you're right, I didn't notice that I still had clk_ignore_unused :/
> 
> That doesn't matter since these clocks are never even registered with
> the clock framework.
That's the point, if it was missing and was not enabled I would have 
noticed display not working (unless the bootloader left it on, which it 
did for at least the mdss instance with the eDP panel)

> 
> But you'd notice that if you try to verify the clock state by looking at
> /sys/kernel/debug/clk/clk_summary for example.
> 
>>> The GCC_DISP_AHB_CLK clocks are not modelled by the clock driver
>>> currently so nothing is guaranteeing them to be enabled if we were to
>>> apply this patch. They just happen to be left on by the bootloader on
>>> some machines currently (well at least one of them is on one machine).
> 
>> What fooled me is that despite not being modeled by the clock driver, it
>> is defined in bindings and referenced in the device tree.
>>
>> Another thing I'll fix up!
> 
> Right, a number of Qualcomm SoCs apparently fail to register these
> clocks. You should start by determining why that is as I assume (hope)
> it was done for a reason.
The reason is, downstream lazily enables clocks because people decided 
they don't leak much power and are still enabled after a clock 
controller reset (or something) and we started blindly copying that 
around 2017 :/

> 
> Then the Qualcomm drivers use sloppy bulk clock look-up and enable so
> that an integrator would never even notice when clocks are missing. Once
> the clocks are registered, that could be tightened up as well.
Yeah the current state of things is not great.

Konrad
