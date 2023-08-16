Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5877DBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbjHPIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242822AbjHPIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:17:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50699EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:17:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdbbede5d4so40840705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692173832; x=1692778632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KollqGO/dAUktTKQSV48LBDZD/Is8TwBzR7oQ65i/bg=;
        b=VJJPgq5hUi3U42SXqtOW26rvO+Yk5s4uHO6IdG+wDPxl08aBzfgSxCNz7sss7tXBdN
         XeG1KtDo47thXL2KCd7qqsih/GRA9dKe1pc0KU9RzuBtuYb1eAEo+D03YguG+KHhRxoK
         ugOFwJsjfOG8i0VJLgPqrlfWMGwfOimkhRPkfqWLM9eyC/isoUgM7G7ujM1eqvkVLM9O
         4j+geWj0pqYF9FaHfueF9GLLb/g6pglk4FOFqLC3sqrrAalOwwRH8I6JSJe7zVtVE20y
         piz7B1cFg2zBSZROUe3TbxvxdXwqePV9VL7zJl8MUuM7cwZ1F/LUfnk1WF/n+k+668fC
         wusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173832; x=1692778632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KollqGO/dAUktTKQSV48LBDZD/Is8TwBzR7oQ65i/bg=;
        b=AQ42tDzvSwiNGfMlEKYon/pdTz4b8nPt2OAviK8jJKUsY7AtsO4WfOZyEFwgPmEdkv
         rwci+LHHq0W0UYyIC4eFh5xvH31gd6QRmGZc0AZUdTYCoYI7wKMwvLxU0IBRuMCSL32c
         7phYh8bybIJs5jH9lErwibJsBb1w7pDOxc+aNwXXS2gmysfFgWg2I9hqU8bKz+TDy7JR
         z5yq5f7zaa1+seQ9PvIda3sw1ot+EedGIL7AD3j7OXzsLF7qbPoTB1sZlacp6OYdeqTj
         u/7h8M7Ql0nq+nZZKBM1hN6hpLx4q9yydgN+2hgveV+hpKvzT171pE06jqowef8wXX3U
         NKsg==
X-Gm-Message-State: AOJu0Yz54gBXeekmG2tqB9FmDJeeWN/xEdx19mRwR+Wn33OSETqpOZX1
        1Zsj3OVuq0l1N3mnrE5E0wHq0Q==
X-Google-Smtp-Source: AGHT+IFGr1enhOVTDxrwB3LWcvV3qEjEtdn80iA1vBXgnCKahHwtjqgSIOzA6krQ7SKdiGVqCgeHjw==
X-Received: by 2002:a17:903:2306:b0:1b3:d4d5:beb2 with SMTP id d6-20020a170903230600b001b3d4d5beb2mr1671917plh.9.1692173831778;
        Wed, 16 Aug 2023 01:17:11 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001b891259eddsm12363232plh.197.2023.08.16.01.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:17:10 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:47:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Liao, Chang" <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: Add missing error pointer check
Message-ID: <20230816081708.o36cvwi3wwh62cmu@vireshk-i7>
References: <20230816030549.849824-1-liaochang1@huawei.com>
 <20230816034630.a4hvsj373q6aslk3@vireshk-i7>
 <8fea501c-b950-17bd-c710-c923b9af6e62@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fea501c-b950-17bd-c710-c923b9af6e62@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-23, 15:27, Liao, Chang wrote:
> Hi Viresh,
> 
> 在 2023/8/16 11:46, Viresh Kumar 写道:
> > On 16-08-23, 03:05, Liao Chang wrote:
> >> The function cppc_freq_invariance_init() may failed to create
> >> kworker_fie, make it more robust by checking the return value to prevent
> >> an invalid pointer dereference in kthread_destroy_worker(), which called
> >> from cppc_freq_invariance_exit().
> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  drivers/cpufreq/cppc_cpufreq.c | 21 ++++++++++++++-------
> >>  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > I think why it was designed this way was to make the driver work,
> > without invariance support, in the worst case instead of just failing
> > completely. The invariance thing is a good to have feature, but not
> > really necessary and so failing probing the driver for that isn't
> > worth it. We should print all error messages though.
> > 
> Thanks for pointing that out. I think you are right that the kworker created
> in the cppc driver is not the only arch_freq_scale updater, the ARCH provided
> updater has more priority than the driver, so the driver should still work even
> without kworker_fie supports.
> 
> If that is the case, i think the best thing to do is checking the error pointer
> and printing an error message before calling kthread_destroy() in cppc_freq_invariance_exit(),
> this is because at that point, it is really necessary to ensure the kworker_fie has
> been initialized as expected, otherwise it will raise a NULL pointer exception.

Or just set fie_disabled to true ?

> I hope this makes sense, thanks.

It does.

-- 
viresh
