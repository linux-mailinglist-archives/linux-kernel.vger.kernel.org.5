Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04086770BE3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjHDWXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:23:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12671704
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:23:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so43821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691187821; x=1691792621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDVToZuCub2aXoluBLOzh7ZI5LhuxsWLO5G4MUK/7/I=;
        b=Fj/rCa+d9CUjvApIAZNeYd11Oo2n1X+mxvFlbtkqGh9r56dMwVHL9NznWX8TjEfSyz
         s6ODwzRUXHhZwkBdQCFPDetRNq+U5JTh5qTJc1nxc4s4k9UCMZkM5nPEKnRhcej+dJrl
         TrHBoLsHMQ3r5ZWdiJy9HEudHieVC4LQMVeIwL4xtAb6hRwDxaJYL+UIqSFFCyhzQevY
         u5PsHqGQpCrLyYnJ0SslbdBnX4I0No4ju6GwrIAGwJXUAqHKOQ4+8Uql5z1Ew/68v9KR
         /cXCVDMqEdLtMtkfZElT4DURhWm5B75NqI4JbGFnk7rezjHiTecKl+l2ynSPZxTC1TXX
         wPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187821; x=1691792621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDVToZuCub2aXoluBLOzh7ZI5LhuxsWLO5G4MUK/7/I=;
        b=czbIBQchnStFRidPBY0Eo29aW1SfksFRuEaNHMAlADtXqI0xwYpv4VdU1Fcz0Cg7Qq
         F4ru8Ah4j+N5S4WFxLx1kmizMPWgnkWZWCChoC0W/ekxmEvsD3FDkbX1+8Clnkv6w0LW
         amKSLOT/CaVlDSN09FMfSvBdxHmIn70Ha+gds7n5A7bikPKCLcCLWADb0PlOSDc48WcG
         r6+Cwxpok3yEVGGwgJau+HcZRJnocy6RTUV6ZHpWgX63kI5SLenQov7CkBmthuyRqA6B
         TWUSYAPga/Jej+Iz2Giarp9tAyaX96OXC+BYn3BlKmvERCo8HyuiXgx8qxGbgljkANS/
         mwuQ==
X-Gm-Message-State: AOJu0Yw3ZEhIbSY2W7dLWipHOy9YTilsBP/5L2Ts/MwwqJ8iDtRByI1j
        sgTT/xoAAkBYb7OQrTbnnZo3pziKXgy5+IMIq+Qsfw==
X-Google-Smtp-Source: AGHT+IFw4EQHEWVqrAp3XPGt0A26DjwPM1ed1SPOxFy3mcLkzyP66+hTodU/JodM+dKQHjN3/JD3+3VOdrZpzd7an6Q=
X-Received: by 2002:ac8:4e81:0:b0:3f2:2c89:f1ef with SMTP id
 1-20020ac84e81000000b003f22c89f1efmr56187qtp.5.1691187820859; Fri, 04 Aug
 2023 15:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <ZMjUMk5xXzahXjno@google.com>
In-Reply-To: <ZMjUMk5xXzahXjno@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 4 Aug 2023 15:23:04 -0700
Message-ID: <CAGETcx-urKn2dUwKN_e0HYpzJ++LtZc3pGUoHi7fGTr5DMkhfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Quentin Perret <qperret@google.com>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 2:45=E2=80=AFAM Quentin Perret <qperret@google.com> =
wrote:
>
> Hi David,
>
> On Monday 31 Jul 2023 at 10:46:09 (-0700), David Dai wrote:
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *polic=
y)
> > +{
> > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > +     /*
> > +      * Use cached frequency to avoid rounding to freq table entries
> > +      * and undo 25% frequency boost applied by schedutil.
> > +      */
>
> The VMM would be a better place for this scaling I think, the driver
> can't/shouldn't make assumptions about the governor it is running with
> given that this is a guest userspace decision essentially.
>
> IIRC the fast_switch() path is only used by schedutil, so one could
> probably make a case to scale things there, but it'd be inconsistent
> with the "slow" switch case, and would create a fragile dependency, so
> it's probably not worth pursuing.

Thanks for the input Quentin!

David and I spend several hours over several days discussing this. We
were trying to think through and decide if we were really removing the
25% margin applied by the guest side schedutil or the host side
schedutil. We ran through different thought experiments on what would
happen if the guest used ondemand/conservative/performance/powersave
governors and what if in the future we had a configurable schedutil
margin.

We changed our opinions multiple times until we finally remembered
this goal from my original presentation[1]:

"On an idle host, running the use case in the host vs VM, should
result in close to identical DVFS behavior of the physical CPUs and
CPU selection for the threads."

For that statement to be true when the guest uses
ondemand/conservative governor, we have to remove the 25% margin
applied by the host side schedutil governor. Otherwise, running the
workload on the VM will result in frequencies 25% higher than running
the same load on the host with ondemand/conservative governor.

So, we finally concluded that we are really undoing the host side
schedutil margin. And in that case, it makes sense to undo this in the
VMM side. So, we'll go with your suggestion in this email instead of
making the schedutil margin to be 0 for the guest.

[1] - https://lpc.events/event/16/contributions/1195/attachments/970/1893/L=
PC%202022%20-%20VM%20DVFS.pdf

Thanks,
Saravana

>
> > +     u32 freq =3D mult_frac(policy->cached_target_freq, 80, 100);
> > +
> > +     data->ops->set_freq(policy, freq);
> > +     return 0;
> > +}
>
> Thanks,
> Quentin
