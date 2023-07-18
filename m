Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3C757C32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGRMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGRMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:49:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F78198
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:49:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so9287454e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689684583; x=1692276583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fx88Y8ylLpGMnec9BSD55VgDeuGfnAWt7EEQ/PtHDpc=;
        b=koqsTf9JZBAUJF7/UVBzKuGMxqH9qIu3JA4uLuPxD87jLK6y30SqI9JH5CUvO96/eA
         px1f4wC1o8IvE/I7Few5mIzN34j1PCsZo3xIti9KbRzvsephQi37px7sde4+KuZY/+jh
         dXDdHZ7cl7YiOeL4CZ9G4vFWro9GLDuiaZmzFt2lcjAKlbIoVM5yyHqs1XpfkqijunDl
         NBlVRAlXaZrbhrQQ9aRNQ5jT70hAiKmr/dKiWEIY0bQmSqP0i3SHGZf3baH+I6vL3L8j
         hKZcDyYEhZprHVX5Rdd4DFZ/oUjTcmG6kiRu1GtfAtxKhuv9yU+4sMup8lIEAEUx3d2m
         dFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684583; x=1692276583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx88Y8ylLpGMnec9BSD55VgDeuGfnAWt7EEQ/PtHDpc=;
        b=itnsjnfUJaQ7yq+wnkIW3d/AxCHEBHW0/pX+MOyLmEFew+gUJ4KHIMaDAeTuAA/gVf
         vznSmw2ZvmYo4wzNmMBsIxrv9XEDjBgp0UCMsXAjOXttmqNY2Z8od5rmWPoXVOe2gpv4
         z1RBXk0qt9qBy4iv4PhTkXWVypto1w3yGYNKfKgD+q5XAdNa0zHt5s+ZeLYPFib0pcEk
         8q7hCs7JUbF1bsUGWEc9RF8u9fXKICwOHX6aEvDYl07hEDPWlp5k0sjFtvFnOo0X4fvi
         L3dJPQyP/pgRViudVImIjxmIpLOwDTINXohwuu6CiCYKL7s0ZfEYCL4W+DolVwhauQrt
         TSvA==
X-Gm-Message-State: ABy/qLZyOElN7jqpuO2f/xnrX38WU9dXKEa4M+qsDrm2hnqTE60/atNy
        HyQ6DNd0xa0WttyDW86thKIAPA==
X-Google-Smtp-Source: APBJJlFQjh+0nmNmA5FTBnkDIQZOdmKm8Oi8kw6dVTUbNrpst5WEY+YTzAEUBE4GyrQFJ7Wdjdz1Hw==
X-Received: by 2002:ac2:4461:0:b0:4f8:75af:e917 with SMTP id y1-20020ac24461000000b004f875afe917mr9567492lfl.41.1689684583024;
        Tue, 18 Jul 2023 05:49:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id d21-20020ac24c95000000b004db1a7e6decsm420016lfl.205.2023.07.18.05.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:49:42 -0700 (PDT)
Message-ID: <a930fa66-4ee4-88ef-6351-acbcadd2481e@linaro.org>
Date:   Tue, 18 Jul 2023 14:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
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
 <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
 <ZLVru50N2ukdXnsW@gerhold.net>
 <pv7pcn5xc7xdjigefrwzvbjvp5lmgfziywfpvxn2nl7hjnvyre@kukniawnm5rm>
 <ZLaAcELnsldc98Uk@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZLaAcELnsldc98Uk@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 14:07, Stephan Gerhold wrote:
> On Mon, Jul 17, 2023 at 09:02:29PM -0700, Bjorn Andersson wrote:
>> On Mon, Jul 17, 2023 at 06:26:35PM +0200, Stephan Gerhold wrote:
>>> On Mon, Jul 17, 2023 at 05:19:11PM +0200, Konrad Dybcio wrote:
>>>> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
>>>> that it's enabled to prevent unwanted power collapse.
>>>>
>>>> Enable runtime PM to keep the power flowing only when necessary.
>>>>
>>>
>>> Are you sure this is necessary? If VDD_CX was really possible to fully
>>> "power collapse" then I would expect that you lose all register
>>> settings. This is not something we want or can even handle for GCC.
>>> You would need to restore all frequency settings, branch bits etc etc.
>>>
>>
>> This differ between platforms, some allow us to completely power down CX
>> while keeping registers state using MX, others require that CX stays in
>> retention at least.
>>
>> So, CX isn't the only rail powering GCC. For the most part though, we
>> have a relationship between frequencies votes for by clients and the
>> corner of CX, and hence I think the current description is ok...
>>
> 
> This patch is just about sending enable/disable votes for the power
> domains though, based on runtime PM which triggers when all the clocks
> are disabled.
> 
> It's unrelated to voting for CX corners required by certain clock
> frequencies (we handle those in the OPP tables of the consumers).
> And it's also unrelated to ensuring rentention of register contents
> since we actually release all votes when the clocks are idle.
> 
> So while adding runtime PM to all the clock drivers sounds nice, I'm
> a bit confused what problem we're actually solving with this patch. :)
In a very specific and unfortunate situation, there could be no other
CX votes, and trying to access (perhaps at least parts of) GCC would
result in a failure.

Konrad
