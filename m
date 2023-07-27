Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADE7652A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjG0Liy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjG0Lip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:38:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4BB30D8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:38:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d124309864dso728790276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690457911; x=1691062711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5hwP5Yjltzhcjg0+28iB6NeIFoqy4kUssAl46J2XgM=;
        b=ndyt1UJvTyr1g3MaHQB9IT4i/YnzIhZGnFtSNhOZKtHIzlcEl2z4HGwddtCz96O6/c
         Bqu29SDrwzv+Ve71lNIR0gUoi4qs6eJhX5pzX5vWKx7XK2MclMk1mnoA7sdgnB+33RU4
         oSTP/2eGYA520uRZilL7R3SqcpzuXFYWyNtg+mVgT8j735oPCRxsxC6BP6NF2YIyt8py
         QTIXeEpI8zUHULmOXLsGmCr++L9ON7ZNZROsKpD8PoJWfNAta+vNfsgSfe624KdSlE1K
         KoyC4ktqTT7JJxG4fAoTZ8TdDh2bBeBQv4QEl0uP+iupbY5+pupypUtkeOu8VpFN/W8M
         oPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457911; x=1691062711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5hwP5Yjltzhcjg0+28iB6NeIFoqy4kUssAl46J2XgM=;
        b=LqG+rt263O3AOTZnf4304+lc3I6kfYBVMYzcHxE6HgOz/xZvigJELRxQ5UDD9GHrfe
         C3Fu9A7b/IgwGtvq2q4zf9DSC9TCE4zJ7+5uyaO5rVfzjHRrKKUp/UlwC2Gr6r1Fb8h1
         JC2pG+ykaZIzX8BIC8Br4QKPkxtwa/jXfFJ4Q0xef+eVrps1RlPofCq5oshsbO7fMS+L
         ddypl7n2JT2/oVW9UDzPPjV8vs1tWyA/NURiR+debx7fgpHf4mxch9NHHvjlHYNO0M9o
         bQ4nLoNufEA4DaJ75tdHDuGGtFrW/o0eisutZ4jgwI0JVeZ/vw7H/VZGOyzMOxEWlf46
         KAyA==
X-Gm-Message-State: ABy/qLbWaMmwXORBgTjWuKwxrYVRzMFf11snRPCwFULYhKhywNAUrrCX
        Fyvie2RZbHvT0NxrkS3NlYskph1Br6ltITc5fRNlpw==
X-Google-Smtp-Source: APBJJlG0mw/YXbnpbIAdV8u/ZB4HN9+QW+c/1g+oFO6AU4eaqLh/dtA7s3jf42Q/rRPL8k7inqYpXBoXFSLORTirKB0=
X-Received: by 2002:a25:5087:0:b0:d0e:2e5c:2f80 with SMTP id
 e129-20020a255087000000b00d0e2e5c2f80mr4218084ybb.64.1690457910929; Thu, 27
 Jul 2023 04:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org> <ZLf4c7ejFBJLH7iN@e120937-lin>
 <CAPDyKFr3ann52GAtOLfnLSGgsdF+EZBNz_apNo_OHzrQ-Hg55Q@mail.gmail.com> <ZME4MQpYd7kJmFzF@e120937-lin>
In-Reply-To: <ZME4MQpYd7kJmFzF@e120937-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Jul 2023 13:37:50 +0200
Message-ID: <CAPDyKFou5Vq-7j5HpZ1AT7AF-+y4wgEqs9tLyNWV0uE2isS85w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance domain
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > >
> > > Is it not possible that, once registered, GenPD can decide, at some point
> > > in the future, to try act on some of these domains associated with a CPU ?
> > > (like Clock framework does at the end of boot trying to disable unused
> > >  clocks...not familiar with internals of GenPD, though)
> >
> > The "magic" that exists in genpd is to save/restore the performance
> > state at genpd_runtime_suspend|resume().
> >
> > That means the consumer device needs to be attached and runtime PM
> > enabled, otherwise genpd will just leave the performance level
> > unchanged. In other words, the control is entirely at the consumer
> > driver (scmi cpufreq driver).
> >
>
> Ok, so if the DT is well formed and a CPU-related perf domain is not
> wrongly referred from a driver looking for a device perf-domain, the
> genPD subsystem wont act on the CPUs domains.

Yes, correct!

>
> > >
> > > > +             scmi_pd->domain_id = i;
> > > > +             scmi_pd->perf_ops = perf_ops;
> > > > +             scmi_pd->ph = ph;
> > > > +             scmi_pd->genpd.name = scmi_pd->info->name;
> > > > +             scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> > > > +             scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> > > > +
> > > > +             ret = perf_ops->level_get(ph, i, &perf_level, false);
> > > > +             if (ret) {
> > > > +                     dev_dbg(dev, "Failed to get perf level for %s",
> > > > +                              scmi_pd->genpd.name);
> > > > +                     perf_level = 0;
> > > > +             }
> > > > +
> > > > +             /* Let the perf level indicate the power-state too. */
> > > > +             ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
> > >
> > > In SCMI world PERF levels should have nothing to do with the Power
> > > state of a domain: you have the POWER protocol for that, so you should
> > > not assume that perf level 0 means OFF, but you can use the POWER protocol
> > > operation .state_get() to lookup the power state. (and you can grab both
> > > perf and power ops from the same driver)
> >
> > Well, I think this may be SCMI FW implementation specific, but
> > honestly I don't know exactly what the spec says about this. In any
> > case, I don't think it's a good idea to mix this with the POWER
> > domain, as that's something that is entirely different. We have no
> > clue of those relationships (domain IDs).
> >
> > My main idea behind this, is just to give the genpd internals a
> > reasonably defined value for its power state.
> >
>
> The thing is that in the SCMI world you cannot assume that perf_level 0
> means powered off, the current SCP/SCMI platform fw, as an example, wont
> advertise a 0-perf-level and wont act on such a request, because you are
> supposed to use POWER protocol to get/set the power-state of a device.

Right, thanks for clarifying this!

>
> So it could be fine, as long as genPD wont try to set the level to 0
> expecting the domain to be as a consequence also powered off and as
> long as it is fine for these genpd domains to be always initialized
> as ON. (since perf_level could never be found as zero..)

Okay, so to me, it sounds like that we should set GENPD_FLAG_ALWAYS_ON
for the genpd. This makes it clear that the domain can't be powered
off.

Moreover, we should prevent genpd internals from setting the
performance state to 0 for the scmi performance domain. Let me look
into how to best deal with that.

Kind regards
Uffe
