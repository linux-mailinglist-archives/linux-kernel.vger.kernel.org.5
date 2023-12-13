Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8F811B25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441863AbjLMRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:33:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C66C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:33:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so645e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488817; x=1703093617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rexuqcFwHqdlHAnmzezB75k11Vu6IciAHqCQRg1EFk=;
        b=CurjT7jDfTVe+G0k7CfdsQmaen7h6lllpozBU28ev3Ff8MRfkzIKZbZC6UXdSX4DvY
         an42q/aDvIJKG8zqt3Namf4dgztJ0oxZijs4RFFkZgvIAfDYpEWMF8G+TowMfIYCocCQ
         7YPRXhU8a3VhQYD7bt8+oUTY6UfsXBzWAPbx02SPE1AwutMafayBMyZl/zV8IJuIRI6h
         ji+Q0EfWsrTO6SMPVA9hqVng4qtehbK5hL3zMpLrcUaRvfZGlj85CMJ+MTXfWy+Ood9j
         457Gtf9u2GIaDKem419rTKX6Oz1lFvT0CJ0G5/EAZMwpShpyKbTPVUs3y/H88jU5ibhU
         Gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488817; x=1703093617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rexuqcFwHqdlHAnmzezB75k11Vu6IciAHqCQRg1EFk=;
        b=cvVUqPs2VXCo6d7JyJiVDSjxF7MMGfCggUWMtlZScUoSH9kVarS4A3fXAKb7WeWutS
         UK/TeSoVqrn/+Flq9U6Vv2btwbNssdYd7Nl9H2WTt3vdCW/lV1fhDKvPKZUYmIxklSji
         vUwVbGlmu5H0hNrWfCgxAfNyE+rNNwsEkqplJhKk1uai27zrYX0Hb+5/LrcmcZb+fgxP
         +OPeMOKrGncWqpkws/5IZrFsIHYepFbvFUBup7GsFmpMLPc0GcYtjvnfS/eM0nsgH+9y
         ox81P9KYZy0M4yBTu4iNdv5usvAjx2D3V3nIPDGeCZy0a1lY3q0NeR5nztObtzVEkkx8
         g1PA==
X-Gm-Message-State: AOJu0YwG8uT6cvNbq70Pe3Uk6pz/v1F3x/h5NSugxZoyMpTDG+ogE7ja
        vxddilXBUegC7KbD57kBrIGVgoPNOZINx75z0mUUYw==
X-Google-Smtp-Source: AGHT+IHHO3CXr1c91zGReoiMKH9pniwJIgiRdy/zD2AGfZaLjQ3Cmk9FTHeR9ohgHH7KGCUIJxY+WYj6AJzQMH9dMGs=
X-Received: by 2002:a05:600c:4f4b:b0:40c:4ed3:8d1f with SMTP id
 m11-20020a05600c4f4b00b0040c4ed38d1fmr202857wmq.7.1702488816749; Wed, 13 Dec
 2023 09:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-4-kan.liang@linux.intel.com> <20231209054809.GB2116834@leoy-yangtze.lan>
 <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com> <20231213133336.GA3895246@leoy-yangtze.lan>
In-Reply-To: <20231213133336.GA3895246@leoy-yangtze.lan>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Dec 2023 09:33:24 -0800
Message-ID: <CAP-5=fVGoQbaUmDqr8CmoRT3Wx=Pp7TtmWuwvXrvEeGw5eannA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
        will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 13, 2023 at 5:33=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Mon, Dec 11, 2023 at 01:39:36PM -0500, Liang, Kan wrote:
> > On 2023-12-09 12:48 a.m., Leo Yan wrote:
> > > On Thu, Dec 07, 2023 at 11:23:36AM -0800, kan.liang@linux.intel.com w=
rote:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> Introduce a generic perf_mem_events__name(). Remove the ARCH-specifi=
c
> > >> one.
> > >
> > > Now memory event naming is arch dependent, this is because every arch
> > > has different memory PMU names, and it appends specific configuration=
s
> > > (e.g. aarch64 appends 'ts_enable=3D1,...,min_latency=3D%u', and x86_6=
4
> > > appends 'ldlat=3D%u', etc).  This is not friendly for extension, e.g.=
 it's
> > > impossible for users to specify any extra attributes for memory event=
s.
> > >
> > > This patch tries to consolidate in a central place for generating mem=
ory
> > > event names, its approach is to add more flags to meet special usage
> > > cases, which means the code gets more complex (and more difficult for
> > > later's maintenance).
> > >
> > > I think we need to distinguish the event naming into two levels: in
> > > util/mem-events.c, we can consider it as a common layer, and we maint=
ain
> > > common options in it, e.g. 'latency', 'all-user', 'all-kernel',
> > > 'timestamp', 'physical_address', etc.  In every arch's mem-events.c
> > > file, it converts the common options to arch specific configurations.
> > >
> > > In the end, this can avoid to add more and more flags into the
> > > structure perf_mem_event.
> >
> > The purpose of this cleanup patch set is to remove the unnecessary
> > __weak functions, and try to make the code more generic.
>
> I understand weak functions are not very good practice.  The point is
> weak functions are used for some archs have implemented a feature but
> other archs have not.
>
> I can think a potential case to use a central place to maintain the
> code for all archs - when we want to support cross analysis.  But this
> patch series is for supporting cross analysis, to be honest, I still
> don't see benefit for this series, though I know you might try to
> support hybrid modes.

So thanks to Kan for doing this series and trying to clean the code
up. My complaint about the code is that it was overly hard wired.
Heck, we have event strings to parse that hard code PMU and event
names. In fixing hybrid my complaint was that we were adding yet more
complexity and as a lot of this was resting on printf format strings
it was hard to check that these were being used correctly. The
direction of this patch series I agree with.

Imo we should avoid weak definitions. Weak definitions are outside of
the C specification and have introduced bugs into the code base -
specifically a weak const array was having its size propagated into
code but then the linker later replaced that weak array. An
architecture #ifdef is better than a weak definition as the behavior
is defined and things blow up early rather than suffering from subtle
corruptions.

The Linux kernel device driver is abstracting what the hardware is
doing and since the more recent changes the PMU abstraction in the
perf tool is trying to match that. If we need to interface with PMUs
differently on each architecture then something is wrong. It happens
that things are wrong and we need to work with that. For example, on
intel there are topdown events that introduce ordering issues. We have
default initialization functions for different PMUs. The perf_pmu
struct is created in perf_pmu__lookup and that always calls an
perf_pmu__arch_init where the name of the PMU is already set. In the
weak perf_pmu__arch_init we tweak the perf_pmu struct so that it will
behave correctly elsewhere in the code. These changes are paralleling
that. That said, the Intel perf_pmu__arch_init does strcmps against
"intel_pt" and "intel_bts", does it really need to be arch specific
given it is already PMU specific? A situation we see in testing is
people trying to run user space ISA emulators like qemu, say ARM on
x86, should the PMU set up for intel_pt and intel_bts be broken in
this environment? I think that as the names are very specific I'd
prefer if the code were outside of the tools/perf/arch directory.
There are cases with PMU names like "cpu" where we're probably going
to need ifdefs or runtime is_intel() calls.

Anyway, my point is that I think we should be moving away from arch
specific stuff, as this patch series tries, and that way we have the
best chance of changes benefitting users regardless of hardware. It
may be that to make all of this work properly we need to modify PMUs,
but that all seems good, such as adding the extended type support for
legacy events on ARM PMUs so that legacy events can work without a
fixed CPU. We haven't got core PMUs working properly, see the recent
perf top hybrid problem. There are obviously issues with uncore as,
for example, most memory controllers are replicated PMUs but some
kernel perf drivers select a memory controller via a config value. We
either need to change the drivers for some kind of uniformity or do
some kind of abstracting in the perf tool. I think we'll probably need
to do it in the tool and when doing that we really shouldn't be doing
it in an arch specific or weak function way.

Thanks,
Ian

> > The two flags has already covered all the current usage.
> > For now, it's good enough.
> >
> > I agree that if there are more flags, it should not be a perfect
> > solution. But we don't have the third flag right now. Could we clean up
> > it later e.g., when introducing the third flag?
> >
> > I just don't want to make the patch bigger and bigger. Also, I don't
> > think we usually implement something just for future possibilities.
>
> Fine for me, but please address two main concerns in next spin:
>
> - Fix building failure in patch 01;
> - Fix the concerned regression on Arm64/AMD archs in patch 04.  I will
>   give a bit more explanation in another reply.
>
>
> [...]
>
> > >> -#define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> > >> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D=
 s, .ldlat =3D l, .aux_event =3D a }
> > >>
> > >>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] =3D=
 {
> > >> -  E("spe-load",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D0,min_latency=3D%u/",       "arm_spe_0"),
> > >> -  E("spe-store",  "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D0,store_filter=3D1/",                      "arm_spe_0"),
> > >> -  E("spe-ldst",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D1,min_latency=3D%u/",       "arm_spe_0"),
> > >> +  E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D0,min_latency=3D%u/",      "arm_spe_0",    true,   0),
> > >> +  E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D0,s=
tore_filter=3D1/",                     "arm_spe_0",    false,  0),
> > >> +  E("spe-ldst",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D1,min_latency=3D%u/",      "arm_spe_0",    true,   0),
> > >
> > > Arm SPE is AUX event, should set '1' to the field '.aux_event'.
> >
> > It actually means whether an extra event is required with a mem_loads
> > event.  I guess for ARM the answer is no.
>
> Thanks for confirmation.
>
> > > I am a bit suspect if we really need the field '.aux_event', the
> > > '.aux_event' field is only used for generating event string.
> >
> > No, it stores the event encoding for the extra event.
> > ARM doesn't need it, so it's 0.
>
> I searched a bit and confirmed '.aux_event' is only used in
> util/mem-events.c and for 'perf record'.
>
> I failed to connect the code with "it stores the event encoding for the
> extra event".  Could you elaborate a bit for this?
>
> Thanks,
> Leo
