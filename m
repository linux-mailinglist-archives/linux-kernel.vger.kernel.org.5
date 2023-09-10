Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F05799F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjIJSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:46:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA118F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:46:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401ec23be82so41775845e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694371571; x=1694976371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yb5NRWuYCShvv6L69CZpP7aXEX5iiSnBmt7oq/UO2CY=;
        b=f5o86o0i4ISsi4J4HGtHNpUykioDjtUknvLNb1/7dJC+bZuT4xsKy06GuV7ftVI7DG
         fJDSBsOChu21AlBDLMkdW2Ytpj89rbLPYEWryxQai0eI/iTntxHzz96vlIpnXD/lnDMv
         +FW1JPIzaTg20+0zl6UeciTsaaYOxlrXZWmv3+Odsr3pWmVZcDe9f7oIo+MerYhpfPNs
         mVI2FG1/KT0YAqF4ok51ylB8gXTMS2KBdgMCkXdbjTcqpYvwTNy/UhJ5K1DKxtuptRBC
         /y2amtW/S36nZ0jr8vGeXj9WyJZ9izlJH3r0c5n45lxvJc7MdYve0Iy44jW92FaKPOe+
         nyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694371571; x=1694976371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb5NRWuYCShvv6L69CZpP7aXEX5iiSnBmt7oq/UO2CY=;
        b=TFpxmpAxdnMf6jOyNzIdHxVGW+7dbcVv8p3LBmmZp0HVC87MU9SZpKt8jVb9LELdRi
         PjtN3wcFKKZs5VQqe2xM0WdEKAeOIdV1r+HnS6J7UzqoXw+hIwUxS7+vyBYTrlRER186
         mWICA9FUg6rdi7oykS/eguxsfBY371iHcPjzqFebccioNLdJD9t8V72l6oABq2WrLCEK
         qHGZcHzflScy8J4kjIO7Vi1ZZw7cAcSptnaLDxS0MD9HNLeh+HeiOd4d/7F57aIPyUte
         pL1tcnjkF5SdTceEpwec/ftHQL/vqP4Njh8lJpXL6qyo3w7hyRBmAeBXINDlYHsPk2Nl
         NAfw==
X-Gm-Message-State: AOJu0Yy9ZRx61DRw3rHU2zNqH+aH9OgcRjtHw2EXfIYb1qvd45h/keZg
        4L6m/8exi9mmOsdWyG0l5excSw==
X-Google-Smtp-Source: AGHT+IEtFJiCetTqWbIx4ICoY39wgYxtOSgFymM9XU8u86i0xOdptEOrr5Aw1HwHbgDq4iSNUl4HPw==
X-Received: by 2002:a7b:c389:0:b0:3fe:1af6:6542 with SMTP id s9-20020a7bc389000000b003fe1af66542mr6653575wmj.33.1694371571388;
        Sun, 10 Sep 2023 11:46:11 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bc8ce000000b00402dbe0bbdcsm11013075wml.28.2023.09.10.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:46:10 -0700 (PDT)
Date:   Sun, 10 Sep 2023 19:46:09 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230910184609.fiqsxu3gmhvz34jn@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907132631.GF10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 15:26, Peter Zijlstra wrote:
> On Wed, Sep 06, 2023 at 10:18:50PM +0100, Qais Yousef wrote:
> 
> > This is probably controversial statement. But I am not in favour of util_est.
> > I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
> > default instead. But I will need to do a separate investigation on that.
> 
> I think util_est makes perfect sense, where PELT has to fundamentally

My concern about it is that it has inherit bias towards PERF. In the soap of
tasks running in the system, not all of which care about perf. The key tasks
tend to be the minority, I'd say. Again, I need to do more investigations but
my worry mainly comes from that and what impact it could have on power.

In an ideal world where userspace is fully uclamp aware, we shouldn't need it.
The task can set uclamp_min to make sure it sees the right performance at wake
up.

And depends on the outcome of this discussion, we might need to introduce
something to help speed up/slow down migration more selectively. So it could
become redundant control.

> decay non-running / non-runnable tasks in order to provide a temporal
> average, DVFS might be best served with a termporal max filter.

Ah, I certainly don't think DVFS need PELT HALFLIFE to be controlled. I only
see it being useful on HMP systems, under-powered specifically, that really
need faster *migration* times. Maybe we can find a better way to control this.
I'll think about it.

Not sure about the temporal max. Isn't this a bias towards perf first too?


Thanks!

--
Qais Yousef
