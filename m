Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3758A7A5F76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjISKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjISKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:25:15 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C583F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:25:08 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59be9a09c23so54987847b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695119107; x=1695723907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTOQCdbDpvS27y9xUteclsr4Jwuo4rZFpQ7lkNz8QlM=;
        b=twjVe7s9Grszmb8I59E4w35ML/wgnH2WvHvrXK2U+CvgXtfezzauKxVqfBWmC4ByA1
         QdRF44X82tcdiWQXb+1TjZ7/Rr29ePCWJtFWsyD2lKxKs10spsmRWKSR/ZvUbqJcQVLK
         hZbNwU8MTbMiCrqLw9ukd370RgEJpC3Uzvmq7Gfi1IkMkZYyrxRLDcVo+5NLgrblf5Dn
         dwS+qzqPqBWiKbtygOaCVqDcUnm5u5xJh1ycduxAO3DMjEKzt9xt04i+N+47+StaeFsg
         0Ys9K3eicqtEEhQaqx2p9F9W7zq0X21AlA9xQk+f233SeBcEwebgSOAaXljHwrUc4FsD
         zybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695119107; x=1695723907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTOQCdbDpvS27y9xUteclsr4Jwuo4rZFpQ7lkNz8QlM=;
        b=Yg6omoEjWKoBkNRGCyFcZTcj676gy1lsC25UkuAICx2LcF8h+1bRDU3A8i/31ECjOc
         jOJ5mvhoBYKGZA9r29ZyTYSiY8Jny61nk6hIK+O2fMu+3cPtHGRe87zepRzsNa92Tig/
         826O/Lw+hmQdyvKXz3VPgM4FyAZxY722hN4Zp12QCDZOgBVcUO5/b+cWA0+DVyoJ+yY1
         ILQUxNvuM/kTeik2Dzr9ZQfrC+0Yt7fKWoKjvxX9itMKFBRKH9pLP0xBsksmqSgI+aT6
         XQA9xxVmaq4IkCdNY8mY1Qi2SGuwQTNeFUvtgfxHJgnWIwVlxx3RsgA0DJeUii/DgqHJ
         6JMw==
X-Gm-Message-State: AOJu0YyhPq7ZKGS4LZsXqS27/+esXvBBprmychhdv3xWXypoji5AzB93
        fUKGMzxseBzEjM7J4SNtFWqVepEeMFEb6iqcnr7UsQ==
X-Google-Smtp-Source: AGHT+IHTJg2TjgD/sw4rcGejK/KhIF7bIqj2TFYRmcSh/sZvxQLrJ4gJC+/a6nS+Zhvm35U8o7kztHKGG4U+pFfX3l0=
X-Received: by 2002:a25:77ce:0:b0:d82:9342:861a with SMTP id
 s197-20020a2577ce000000b00d829342861amr8945995ybc.4.1695119107197; Tue, 19
 Sep 2023 03:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <CAPDyKFpn93YU78fRg02Avb3g=W2=+Cn=HD4tUbzTYq9WKGVOKw@mail.gmail.com> <20230918102642.icz7gywqmakaatgc@bogus>
In-Reply-To: <20230918102642.icz7gywqmakaatgc@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Sep 2023 12:24:30 +0200
Message-ID: <CAPDyKFqh5JqMcJO7q8OoG0i7gT8hZC63qeA_NoECnHUAo3F0=w@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] arm_scmi/cpufreq: Add generic performance
 scaling support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 12:26, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Sep 15, 2023 at 12:45:02AM +0200, Ulf Hansson wrote:
> > Sudeep, Christian,
> >
> > On Fri, 25 Aug 2023 at 13:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v3:
> > >         - Re-based upon the for-next/scmi/updates branch.
> > >         - Re-ordered some of the patches in the series, to eas review.
> > >         - Added some new DT doc patches in the series, according to comments.
> > >         - Fixed other comments, see version history for each patch.
> > >
> > > Changes in v2:
> > >         - Split up the series, to get the basic support in place as the first
> > >         step. The part that remains is the integration with the OPP library, to
> > >         allow consumer drivers to change performance level using the OPP lib.
> > >         - Re-based on top v6.5-rc1.
> > >         - Other changes will be described for each patch.
> > >
> > > The current SCMI performance scaling support is limited to cpufreq. This series
> > > extends the support, so it can be used for all kind of devices and not only for
> > > CPUs.
> > >
> > > The changes are spread over a couple of different subsystems, although the
> > > changes that affects the other subsystems than the arm_scmi directory are
> > > mostly smaller, except for last patch which is in the new genpd directory.
> > >
> > > The series is based upon the for-next/scmi/updates branch, but to enable the
> > > genpd provider in patch 13 (the actual scmi performance domain driver) to be
> > > placed in the new genpd directory, I have also merged an immutable branch [1],
> > > which is queued for v6.6.
> > >
> > > Note that, I am runing this on the Qemu virt platform with Optee running an SCMI
> > > server. If you want some more details about my test setup, I can share this with
> > > you, just let me know.
> > >
> > > Looking forward to your feedback!
> > >
> > > Kind regards
> > > Ulf Hansson
> > >
> > > [1]
> > > git.kernel.org/pub/scm/linux/kernel/git/people/ulf.hansson/linux-pm.git genpd_create_dir
> > >
> > >
> > > Ulf Hansson (13):
> > >   firmware: arm_scmi: Extend perf protocol ops to get number of domains
> > >   firmware: arm_scmi: Extend perf protocol ops to get information of a
> > >     domain
> > >   cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
> > >   firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
> > >   firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
> > >   cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
> > >   cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
> > >   dt-bindings: arm: cpus: Add a power-domain-name for a
> > >     performance-domain
> > >   dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
> > >   dt-bindings: power: Clarify performance capabilities of power-domains
> > >   cpufreq: scmi: Add support to parse domain-id using
> > >     #power-domain-cells
> > >   PM: domains: Allow genpd providers to manage OPP tables directly by
> > >     its FW
> > >   genpd: arm: Add the SCMI performance domain
> > >
> > >  .../devicetree/bindings/arm/cpus.yaml         |   4 +-
> > >  .../bindings/firmware/arm,scmi.yaml           |  11 +-
> > >  .../bindings/power/power-domain.yaml          |  17 +-
> > >  MAINTAINERS                                   |   1 +
> > >  drivers/base/power/domain.c                   |  11 +-
> > >  drivers/cpufreq/scmi-cpufreq.c                |  55 +++++--
> > >  drivers/firmware/arm_scmi/Kconfig             |  12 ++
> > >  drivers/firmware/arm_scmi/perf.c              |  90 +++++------
> > >  drivers/genpd/Makefile                        |   1 +
> > >  drivers/genpd/arm/Makefile                    |   3 +
> > >  drivers/genpd/arm/scmi_perf_domain.c          | 150 ++++++++++++++++++
> > >  include/linux/pm_domain.h                     |   5 +
> > >  include/linux/scmi_protocol.h                 |  18 ++-
> > >  13 files changed, 293 insertions(+), 85 deletions(-)
> > >  create mode 100644 drivers/genpd/arm/Makefile
> > >  create mode 100644 drivers/genpd/arm/scmi_perf_domain.c
> > >
> >
> > Unless you have some additional comments, I think patch 1 -> 12 should
> > be ready to be applied to your scmi tree, as is. I tried to apply it
> > today and did not encounter any problem.
> >
>
> Sorry for the delay, was off few days last week. I will take a look at
> the series later this week
>
> > Patch 13 needs a rebase so I will submit a new version of it. For you
> > to apply it to your tree, you need to move your scmi branch to
> > v6.6-rc2 (on Monday), would that be okay for you to manage?
> >
>
> Sure I can rebase on -rc2. I assume Arnd is aware of the dependency and
> must be OK with that. The general preference/expectation is -rc1 but I
> understand the exception this time.

Thanks! And yes, I can confirm that Arnd is aware too.

Kind regards
Uffe
