Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD02776594
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjHIQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHIQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:52:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1B211F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:52:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so481661fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691599939; x=1692204739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQJEv5Vw7ZJZLzL74/YFszGSXRtz97IWL9b+9KOEYBk=;
        b=ZO9GM7kMXDoegIZvjBMStvrp6k0mAqPeeKnZVncyjI7+NV+JiqCs4v1oWOzjGWf5i3
         jWjFOuQ9uQTMZCKyW4vhy1nIipCY47B5mMkYGIEbldjoVUEFPleKpQEuJK1DlGg2mA9G
         +oX5pZ4MY+Q7IwuV3YHqwG38AGslp4Xfs0rYVMITikLmthAjz+17AHdkyiYBk1F5Sr32
         wnS9cOcy0IRxja9nUUeFC31S9eb800X6nntcGCReQQS27uzpd+Mjk9s/e56lWTsfp3nL
         QSX/GXd7MrzDvYzDji+t/p/ChlJy04GchzD9M3hRWqz8DmP8+kgqElQYr1Smv8rEQ/aB
         Uksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599939; x=1692204739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQJEv5Vw7ZJZLzL74/YFszGSXRtz97IWL9b+9KOEYBk=;
        b=YH97n3QZDK01TAquEVlja/HdilgP7plUuuLf1+i9Mp7/HE76qDyKsJXkmE17NveQ0C
         e8Lf01l6Y+sA0V+dnfUTG1YarzmUSnhQRx0obuVZ41cObQJmJYTqylYdKcLomWWWbJB/
         Wb9cjOi3mQ2VvT2E9v5m0zqRulI4E8DT0CBqJ/xYcdXg/I29a6fFqRT/AhqIUP89kwyP
         O3uacPKh4cLzj1yUolJuzyPK5lb6FPXPZfK7HZzvV9Sn8poPwNcW5PCQuPklmMvjCYNl
         xPgISIEBef+Z+ZGy/ja1uZitEQOns3eMNfMjEaFAv50YQ4GiXDR0HWkgwqmzDYulCYVa
         kfBg==
X-Gm-Message-State: AOJu0YxgiWV7bVoDkUTT9NM02VgxI1eCEgEK3VP6vxRh7mtICYea8QUV
        elRUeeLOyxHKP39GVRVnC0rgSw==
X-Google-Smtp-Source: AGHT+IHKrr6dngxD5jbf0lI7E9pc6JW/R62gAP8zLLoHL2aQJmFdV+8JZpgmrPwhkyIEldKOTgVLyQ==
X-Received: by 2002:a2e:b0fc:0:b0:2b9:ee3e:240c with SMTP id h28-20020a2eb0fc000000b002b9ee3e240cmr2392361ljl.24.1691599939431;
        Wed, 09 Aug 2023 09:52:19 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e880a000000b002b9f03729e2sm2787141ljh.36.2023.08.09.09.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 09:52:18 -0700 (PDT)
Message-ID: <cc9e6464-5e47-4044-9785-c57167f0e1c5@linaro.org>
Date:   Wed, 9 Aug 2023 18:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
Content-Language: en-US
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZLeiM6l6tu6XDzrr@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 10:43, Johan Hovold wrote:
> On Tue, Jul 18, 2023 at 09:23:52AM -0700, Bjorn Andersson wrote:
>> On Tue, Jul 18, 2023 at 03:26:51PM +0200, Konrad Dybcio wrote:
>>> On 18.07.2023 15:20, Johan Hovold wrote:
>>>> On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
>>>>> Some clocks need to be always-on, but we don't really do anything
>>>>> with them, other than calling enable() once and telling Linux they're
>>>>> enabled.
>>>>>
>>>>> Unregister them to save a couple of bytes and, perhaps more
>>>>> importantly, allow for runtime suspend of the clock controller device,
>>>>> as CLK_IS_CRITICAL prevents the latter.
>>>>
>>>> But this doesn't sound right. How can you disable a controller which
>>>> still has clocks enabled?
>>>>
>>>> Shouldn't instead these clocks be modelled properly so that they are
>>>> only enabled when actually needed?
>>> Hm.. We do have clk_branch2_aon_ops, but something still needs to
>>> toggle these clocks.
>>>
>>
>> Before we started replacing these clocks with static votes, I handled
>> exactly this problem in the turingcc-qcs404 driver by registering the
>> ahb clock with a pm_clk_add(). The clock framework will then
>> automagically keep the clock enabled around operations, but it will also
>> keep the runtime state active as long as the clock is prepared.
>>
>> As mentioned in an earlier reply today, there's no similarity to this in
>> the reset or gdsc code, so we'd need to add that in order to rely on
>> such mechanism.
> 
> This reminds me of:
> 
> 	4cc47e8add63 ("clk: qcom: gdsc: Remove direct runtime PM calls")
> 
> which recently removed a broken attempt to implement this for gdscs.
> 
> Just stumbled over GENPD_FLAG_PM_CLK which may provide a way forward at
> least for genpd (but see below).
> 
>>> I *think* we could leave a permanent vote in probe() without breaking
>>> runtime pm! I'll give it a spin bit later..
>>>
>>
>> Modelling the AHB clock in DT and putting a devm_clk_get_enabled() would
>> properly connect the two, and thereby handle probe order between the two
>> clock controllers.
> 
> Yeah, this dependency really should be described eventually.
> 
>> But it would prevent the power-domain of the parent provider to ever
>> suspending. Using pm_clk_add() this would at least depend on client
>> votes.
> 
> IIUC using pm_clk_add() would also prevent the parent from suspending
> due to that resume call in clk_prepare().
> 
> And this mechanism is also used for GENPD_FLAG_PM_CLK...
So.. how do we go about solving the issue that this patch tried to
address?

Konrad
