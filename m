Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A167E4D92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjKGXsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKGXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:47:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1050C10CB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:47:57 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6754b4091b6so39117136d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699400876; x=1700005676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwiYwgDPePRyKDhIdyq+gxbwUtv6ztRkGu1vD58BCfU=;
        b=GLE6YcUXiZVaDhNRRBgDrrb8ptklAXljZEHWD8CwEmtasOQcPBvNpnid408+nHv/uX
         a4kuyX1FEQShivBIGM/OhSU99Fo0G3UqWzucD/2X8K7xHDNwnlDfVkmQOnwgsAd6ZPtQ
         dG4+D7RySa8YJ+03c+J4CWvs+9Jdl1jkEPtS9pMPNv9sf2OaMPfwvKHrvA6gC+updWYQ
         ETwz6bdI3TmeDhY7twFETJPK3HyMu9G0WgmeQEA9cJpw1ceKoHOuVIfBkfOile5Q9gFR
         Dzcy/srqa1F7WU0OGKAk+LL7sQi/AlKrYAaoZQjR7fV7UfafwZANwxJ9noO1kOxhUJVL
         36pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699400876; x=1700005676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwiYwgDPePRyKDhIdyq+gxbwUtv6ztRkGu1vD58BCfU=;
        b=kTBgT8QUTtEggDHPnkL4p3tooTp+YEfpzmSs/qLQpSdVKfcPYoruMYR56wk9KNOVnM
         PEA1qSF5QeH/P+zMwWIeSak2UT2iF58OhnKPr4xBAulQD6gchr+7husemGbyRGQi8jA/
         +yEx53JCbD/ENR2xJcjhhzcUWxAUhiuy4VmZS5g1eipCF73G4zYEwC4LaVPBiEDP0oeD
         zjlnj/8oKlX4aQJ/eD/2TnPKGCXPO+B350lIIyjbobuV5NcevAyrPCBa+dizV2YBuyOy
         VvrWjsXyLZJdLEc7iAIQJsqiuN1GziTcqj0asvVHDcK7fLqst47/TyPm5b8x5nMmKrQ4
         MXFQ==
X-Gm-Message-State: AOJu0YzipB6WHeGN5eQwNoLnXBp6Cx2kHGIr7h99n1vKO/O9J/xChTSA
        O8OcjlKddQL3x3tbZOIZXqlEPM4MlsRBJ50+JkC81g==
X-Google-Smtp-Source: AGHT+IHssMMrX4lEp4vtt6ZlKyyydttGs0SzYQgAkmOanWn/emWbZcA3IgXFKH4igP3ZN3Aj2LGnIA+vG2fFNRyrMfU=
X-Received: by 2002:a05:6214:e8d:b0:66f:bcc5:cf70 with SMTP id
 hf13-20020a0562140e8d00b0066fbcc5cf70mr313097qvb.42.1699400876052; Tue, 07
 Nov 2023 15:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <ZUqSQKHwvKQs7_qA@google.com>
 <ZUrCE9j1Gvw4zacY@google.com>
In-Reply-To: <ZUrCE9j1Gvw4zacY@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 7 Nov 2023 15:47:19 -0800
Message-ID: <CAL715WL3Uo-XjH=GYW9vybDJTscE4-f2a_fndUpOEig1JhkwvQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 3:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Nov 07, 2023, Mingwei Zhang wrote:
> > On Tue, Nov 07, 2023, Sean Christopherson wrote:
> > >  arch/x86/events/core.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index 40ad1425ffa2..f8a8a4ea4d47 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_eve=
nt *event)
> > >             hwc->last_period =3D period;
> > >             ret =3D 1;
> > >     }
> > > -   /*
> > > -    * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> > > -    */
> > > -   if (unlikely(left < 2))
> > > -           left =3D 2;
> > >
> > >     if (left > x86_pmu.max_period)
> > >             left =3D x86_pmu.max_period;
> > >
> > > -   static_call_cond(x86_pmu_limit_period)(event, &left);
> > > +   /*
> > > +    * Exempt KVM guest events from the minimum period requirements. =
 It's
> > > +    * the guest's responsibility to ensure it can make forward progr=
ess,
> > > +    * and it's KVM's responsibility to configure an appropriate "per=
iod"
> > > +    * to correctly virtualize overflow for the guest's PMCs.
> > > +    */
> > > +   if (!event->attr.exclude_host) {
> > > +           /*
> > > +            * Quirk: certain CPUs dont like it if just 1 event is le=
ft:
> > > +            */
> > > +           if (unlikely(left < 2))
> > > +                   left =3D 2;
> > > +
> > > +           static_call_cond(x86_pmu_limit_period)(event, &left);
> > > +   }
> > >
> > >     this_cpu_write(pmc_prev_left[idx], left);
> > >
> >
> > Nice one. I am curious how you tested this one? I would like to
> > reproduce that one on my side.
>
> The check_emulated_instr() sub-test in KVM-Unit-Tests's x86/pmu.c fails w=
hen run
> with "my" (which is really yours) fix for the KVM's handling of emulated =
PMC
> events[*].  If KVM synthesizes an "instructions retired" event that bumps=
 the
> PMC to all ones, i.e. -1 for all intents and purposes, the test fails bec=
ause
> KVM creates a sample_period of '1', but perf programs a period of '2'.
>
> I suspect a very simple test of writing -1 to a PMC from the guest would =
exhibit
> the same behavior.
>
> [*] https://lkml.kernel.org/r/ZUWAg3WP2XESCAR4%40google.com

Nice, I will try that and see if I can reproduce. Will give
Reviewed-by after testing it on my side.

Thanks.
-Mingwei
