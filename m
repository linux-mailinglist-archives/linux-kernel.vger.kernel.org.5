Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03C80EBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbjLLMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346586AbjLLMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:35:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA782106
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:35:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so17128915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702384537; x=1702989337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owJV1DmeJ4fzQxz4ZVEVTw4U+j7bkU+2Yl4dUuHEfQE=;
        b=I2c3ikbJ/2wJqLwAGrQdYeTsFwHl1s9Fe9+ErGqMcrp2x4nu/ikTUZ0M92N9v3iEZA
         6d8ZBaC3SbeKD6zhpYvzLYXQedgU2VF3SKH4l12xLkai804XtMErYfSPro6uCUIZMMwz
         BNQpbIuhwQLBbjw2GyYzEnIem7yNDgW7rsueakS6XYxQ3M1LjBZSvbRWVqJKBL8FCK5F
         ql6gbEpRNPupSsn6cCvPmD9KkXw6DdutmeI4l8SyY3SMgDSWJ2lxM08BZv6R0LS+0bFf
         gYGgZtaYzIYk33D9TfyydYVoUFKeZ3Zmrk5KAl+jUrrcXs3RjJ+3ssEiKxELHGCfaFlE
         a4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384537; x=1702989337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owJV1DmeJ4fzQxz4ZVEVTw4U+j7bkU+2Yl4dUuHEfQE=;
        b=T7mMQ+BnqVvE52YDBCWQXieKkNHTmxRmNBBAm63Q9VuKzZ9kQE4E9FdBfF4ZtfYT9D
         PDiqlbN2qjvJCY1U1oc+4t6qmZcmHc1dkdphsJF8mHp1/NVOS+OtgVzgMTD+rmmtbz70
         UE1PRbi6BzvEipHBrGieD39YsvK6IPIGgsfbY4Lr/GPyCKLr2MatJN7oK8mrNHIFK2U/
         QccnVS6sF4ea6HiAOiouOnNmJwefgnUUxSRHy50Usho1dzPYWyFwjvhJpZJo3vwca0in
         p2Bf8xEwLFZAa62C+KAfGI6xZ2JKF+huObTR5cc8wlu0YnlPHUzMYxAPl6nkp91/gf/I
         x44w==
X-Gm-Message-State: AOJu0Yx0WC2k2giDfpGTBJ3BklGZYIwrHTNHwXEed/PWV+/oiBhQuUCL
        hnQ0q03E3Epb426DIdHvplYfgQ==
X-Google-Smtp-Source: AGHT+IHtJYYjSMLbQrW4WDwReSNA1pV0Ue24MB0zI+yINbXbwA+e9B9ECiPS7v9iybTpc4FYHC7brQ==
X-Received: by 2002:a05:600c:c1b:b0:40c:27af:2ac8 with SMTP id fm27-20020a05600c0c1b00b0040c27af2ac8mr3100333wmb.6.1702384537191;
        Tue, 12 Dec 2023 04:35:37 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm8959699wmb.40.2023.12.12.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:35:36 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:35:35 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212123535.3yns5f4b6awiuesk@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <47ef274b-d9cc-4f4f-8134-2dced46005fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47ef274b-d9cc-4f4f-8134-2dced46005fa@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 11:46, Dietmar Eggemann wrote:
> On 08/12/2023 02:52, Qais Yousef wrote:
> > Due to the way code is structured, it makes a lot of sense to trigger
> > cpufreq_update_util() from update_load_avg(). But this is too aggressive
> > as in most cases we are iterating through entities in a loop to
> > update_load_avg() in the hierarchy. So we end up sending too many
> > request in an loop as we're updating the hierarchy.
> 
> But update_load_avg() calls cfs_rq_util_change() which only issues a
> cpufreq_update_util() call for the root cfs_rq?

Yes I've noticed that and wondered. Maybe my analysis was flawed and I was just
hitting the issue of iowait boost request conflicting with update_load_avg()
request.

Let me have another look. I think we'll still end up needing to take the update
out of util_avg to be able to combine the two calls.


Cheers

--
Qais Yousef

> 
> So the 'iterating through entities' should be for a task in a non-root
> taskgroup which the condition (1) takes care of.
> 
> cfs_rq_util_change()
> 
>     ...
>     if (&rq->cfs == cfs_rq) (1)
> 
>         cpufreq_update_util()
> 
> [...]
