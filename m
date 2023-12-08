Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD7809889
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572900AbjLHBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:18:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB585
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:19:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b27726369so17210575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701998342; x=1702603142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYzwSCPqiLl7k8qbCaz0m1NIvdf+DIxXUY3+wg3ee94=;
        b=E9thBKFL18i+pJ5L25jNA6tVkGftyHb3+sNN/BHAu5MicLbZH0Xpc1hYWF4o/aXbUX
         oNlO1TDm3jroN6PodcwQqAeVhHItH2IOFrkGaDzoG1OhRfKZulOtNMsVAbyIoRXwT/Yg
         7SoCeTZvOMWKhVpLn52ot2it0o3pd9p00BzaRmU3rliZMCPmN+Iq2QAUGnDLLrOWJRq4
         ie+brBLyJ8i4rHoDqoqzll9+tEhIZ+/O9GHQs6T6dygsIzAVav5cRg2+whSkDr1y1cLM
         9UwN3VW6hGrigR48VGkM+J2CYQP18eVlfKQEnVrPPQPM3/QtYvM3jb6pJceTNYbQ/ZTn
         FQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998342; x=1702603142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYzwSCPqiLl7k8qbCaz0m1NIvdf+DIxXUY3+wg3ee94=;
        b=RodoqFArT69Yok8EZGvZmNfW2duiHsDzvXNHAB3coWdTRMSsxjAshrbr+mMlNMV/K9
         7y2l9UvmZptclZIJOljfG0H2A5zhbXEhigVizuYr0aIriJndbj9E/7D4sRMUcNc14/ol
         DaEhQoGCsKHu2knHM+R5s0m93xvdF1MRGPvBRCKuPZEO22hDvEr3pdtnn4AM/xRPqpCk
         WXDSEcR+pnV8z5ukGcyyBckAzA1cOWAijpFgKZQ0Hi84w59Olc0/xbS/VPnN5K0t5Rgb
         xFJUiFOZue9vgW79tYZPe5uct2iTIN81FaLpzQVukLo2zciRMAg6T1aCJXCuxcrrYvZt
         EksA==
X-Gm-Message-State: AOJu0Yz7/336qFuief437LP+xvfHyRN+RTE7RIGHbiuJYZ4TUSz8l/7O
        TLrjD8NnF0RWk+AaM7Oe9VugzZ/FaADYvbAxsKYHHQ==
X-Google-Smtp-Source: AGHT+IG+m5ndDrZYwAjGiJo+XbvTuXbn4cv9JA7hIaiio0HiC93zA6LGU2W0vDdt642q9QLDRGH9i6qmYPagNCY64U4=
X-Received: by 2002:a05:600c:246:b0:40b:5e59:da8d with SMTP id
 6-20020a05600c024600b0040b5e59da8dmr2133389wmj.160.1701998342457; Thu, 07 Dec
 2023 17:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-3-davidai@google.com>
 <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
In-Reply-To: <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
From:   David Dai <davidai@google.com>
Date:   Fri, 8 Dec 2023 10:18:51 +0900
Message-ID: <CABN1KCKfCWB6fVAuMSN9AdJOe-zueNMPFUdDnKLcq-uetz2ZFQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Apologies for the late reply,

On Wed, Nov 15, 2023 at 3:29=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 10-11-23, 17:49, David Dai wrote:
> > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtua=
l-cpufreq.c
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *polic=
y)
> > +{
> > +     writel_relaxed(policy->cached_target_freq,
>
> Drivers shouldn't be using the cached_target_freq directly. Use the targe=
t freq
> or index passed from cpufreq core.

We were trying to avoid rounding to frequency table entries to provide
more accurate frequency requests. However, we didn't find any
significant power or performance regressions using the frequencies
from the table, so I'll send another patch series using your
suggestion.

>
> > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +     topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->=
related_cpus);
> > +     kfree(policy->freq_table);
> > +     policy->freq_table =3D NULL;
>
> No need of doing this. Also the order of above two calls is wrong anyway.

Can you clarify this point a bit more? Are you suggesting to just
remove setting policy->freq_table to NULL and swap the ordering
freeing the freq_table vs clearing the topology source? I can
alternatively use dev_pm_opp_free_cpufreq_table to mirror the init.

Thanks,
David

>
> --
> viresh
