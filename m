Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B317C41DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjJJUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjJJUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:45:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E0B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:45:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5045cb9c091so8176378e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696970719; x=1697575519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPVTHJ1SRjIYGSGNIrfYEdJa5KfN1v9ZTP/0pcmtqxU=;
        b=cc7LsnXhRy+qAQYoYK7e7aQJnPD36+2OCtGqKZw/yBpneGg2mPNsCai10tK6Iyf9ks
         w0E0WCErM6MXGPXxtpELIU4FuQ2vo4umC0/kSYoDIyPsXV+kAH3quMQnHdjQdUExYd2c
         Noc3fWmeArwIflvxka5kG/kDXy7n7KoYx3z04JZbHXeTdzYhFWhHQ7escXRqomHEOZ45
         6luilGsNJAC+f4TVSJe+AVVihYIKW5wHUrae5huFhfPEmAXdaeMnn+AfuDK82MleHgJR
         0UynI0doH46XuLxHeqAoKdtI9e9pnH+DjV37NfEQsrnmufhaAqbHh7Zeroj8OrmdQfVG
         +rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970719; x=1697575519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPVTHJ1SRjIYGSGNIrfYEdJa5KfN1v9ZTP/0pcmtqxU=;
        b=SOcRPfvJ0VGRtB1TdCuXoobaPEdt07DaXgWFZV9USHX7JCmoNdC3ZEERzmsL4LiSFj
         v/DvUxA1/6eKS5GxBpon43uYdEKfdWVQJe4D+UaljzcKdsWpd+sLJwi9rKePJ5mVyBeO
         NJVtU1dxupdZRrlRKmYTTCiV4txJlm0YlD8dZ3hC6T+Mb8xmY9798JAnupmNXMoh2iCm
         8Oox+4c5ngNfo8iA7wrDnSBPKuLAejlkTn4wkKm0MHDYpnxrIe7eobGtqCx9z49ipu9J
         VrI/svBo5RhnEgIcrWAQEPZl6ZvylkoTcf7lY+KthjVcC2LX6aDAzu4ILOWE/WGGxza7
         ksWw==
X-Gm-Message-State: AOJu0YxX1MI2JpdcfryMV05iySGMMT3L7tUGKDCqN0q1OdvGPRCQsZB1
        VITkXhuz7YQ45I4+4TcoQxMVGA==
X-Google-Smtp-Source: AGHT+IH2U0m+t021BDI/5PGBjkzHuCgOLH/WWVyyc7thxzv3HkotLuRpbgoFwGPTSXw65L9pWGr/bg==
X-Received: by 2002:ac2:5b1b:0:b0:503:2924:f8dd with SMTP id v27-20020ac25b1b000000b005032924f8ddmr16884240lfn.47.1696970719415;
        Tue, 10 Oct 2023 13:45:19 -0700 (PDT)
Received: from ?IPV6:2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884? ([2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884])
        by smtp.gmail.com with ESMTPSA id v21-20020ac25935000000b00505723e56acsm1943851lfi.273.2023.10.10.13.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 13:45:18 -0700 (PDT)
Message-ID: <da02414c-a151-464b-8976-d353c6da7b8e@linaro.org>
Date:   Tue, 10 Oct 2023 22:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: smd: Disable unused clocks
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
 <bc8fa799-aa64-4b69-97ce-8f1872c8eb11@linaro.org>
 <ZSRfc_w19h-55Bib@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZSRfc_w19h-55Bib@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 10/9/23 22:15, Stephan Gerhold wrote:
> On Fri, Oct 06, 2023 at 11:08:39PM +0200, Konrad Dybcio wrote:
>> On 4.10.2023 14:10, Stephan Gerhold wrote:
>>> At the moment, clk-smd-rpm forces all clocks on at probe time (for
>>> "handoff"). However, it does not make the clk core aware of that.
>>>
>>> This means that the clocks stay enabled forever if they are not used
>>> by anything. We can easily disable them again after bootup has been
>>> completed, by making the clk core aware of the state. This is
>>> implemented by returning the current state of the clock in
>>> is_prepared().
>>>
>>> Checking the SPMI clock registers reveals that this allows the RPM to
>>> disable unused BB/RF clocks. This reduces the power consumption quite
>>> significantly and is also needed to allow entering low-power states.
>>>
>>> As of commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
>>> interconnect bus clocks") the interconnect-related clocks are no longer
>>> managed/exposed by clk-smd-rpm. Also the BI_TCXO_AO clock is now
>>> critical (and never disabled).
>>>
>>> There is still a slight chance that this change will break boot on some
>>> devices. However, this will be most likely caused by actual mistakes in
>>> the device tree (where required clocks were not actually specified).
>> Precisely this, and solely as a consequence of the interconnect driver
>> not covering all the required clocks (usually named GCC_SOME_NOC_XYZ_CLK,
>> but there's quite a lot more).
>>
>> For platforms without an interconnect driver, breaking stuff this **MOST
>> LIKELY** means that Linux uses some hw that isn't voted for (e.g. missing
>> crypto clock under scm or something).
>>
>> For those with an interconnect driver, this will uncover issues that were
>> previously hidden because of the smd-rpm interconnect being essentially
>> broken for most of its existence. I can smell 660 breaking from however
>> many miles you are away from me, but it's "good", as we were relying on
>> (board specific) magic..
>>
>> I've been carrying an equivalent patch in my tree for over half a year now
>> and IIRC 8996 was mostly fine. It's also a good idea to test suspend
>> (echo mem > /sys/power/state) and wakeup.
>>
> 
> I didn't notice any problems on 8916 and 8909 either. :-)
> 
>> For reasons that I don't fully recall, I do have both .is_prepared and
>> .is_enabled though..
>>
> 
> clk-smd-rpm doesn't have any .enable()/.disable() ops (only .prepare()
> and .unprepare()) so I don't think is_enabled is needed. For the unused
> clock cleanup in drivers/clk/clk.c (clk_disable_unused()) we just care
> about the clk_unprepare_unused_subtree() part. That part is run when the
> clock reports true in .is_prepared(). The equivalent for .is_enabled()
> would just be a no-op because there are no .enable()/.disable() ops.
Oh I found out why :D

"""
The RPM clock enabling state can be found with 'enabled' in struct
clk_smd_rpm. Add .is_enabled hook so that clk_summary in debugfs
can a correct enabling state for RPM clocks.
"""

Konrad

