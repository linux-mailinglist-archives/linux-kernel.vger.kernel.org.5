Return-Path: <linux-kernel+bounces-158031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267BD8B1A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A71C214F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F43C08D;
	Thu, 25 Apr 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="coSCGmlh"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1932940B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024033; cv=none; b=EYTthPCp74HfRD+NOkSI9ReZ+XZzxNepGJHezyqoPuQvt05IDL7c80SfUDY7CtNfnX76jINOPDVsJBj1igG00OdptavSW7X3bgu3+m7S7H+NGufMvOvBwp7Famuh9JOByiLYKlDndaUpsGYhU6R+qwSe/5SVDMXyz0yezTPv1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024033; c=relaxed/simple;
	bh=mGknz1DFZBDlAewGtOSP9zmEu+RdP+MwRYIyDKseweQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXQVwOR3zl+RSl0frYWKEmZJHqvG0v6mJWfBAPeMt/vjhLtz+HImd0n7wqxoYhc2NEA2dWrQQv0tiSXyBYKGi9nDIkvpGCw6qJjGoTp6tkvtOQKV2eUoWy5jY/R4umwo8sxFhCvnc7CTjhfrTfZg6mLwZhXA5vfNf3809mh+lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=coSCGmlh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c1a6362a4so3034745ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1714024029; x=1714628829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGknz1DFZBDlAewGtOSP9zmEu+RdP+MwRYIyDKseweQ=;
        b=coSCGmlhtSZD1rZVOTSIMPi0X348w6bdgqu+bkNqL7LkNQEYFBSe+ceFf4VTC5WZJQ
         oS0S4X26ueuOgQxWmIYtQq2AKEorLwcvp3EY4510VAXmAZkKTKq0jnWLaK/gHNW5aXIX
         69w6WMLci8JgKbyxNQStoo16pFY33OqHLFMNy0C8L5O1ajjGV1xYz/5EP7LTKG811mmb
         STdWQhTcaNFdCa0Ou6GpCjHsjBrScDY6u1E+QxJvASo+Dg0w3DktmSgi+DTUqLzp2v1t
         PBRCqmrqNLk3v2lxaqkJl0DRmF1NYBPOv1e0sWGm/36h547gCZEM7WTz6o7PSts+z0wX
         ZG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714024029; x=1714628829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGknz1DFZBDlAewGtOSP9zmEu+RdP+MwRYIyDKseweQ=;
        b=kBYAHeAigPQSISshsocIpb2AUXpYBspCbSkC4iL1HnLHPInp6ZD8MHExDszA5BEZdk
         D9AYMituBnPGwviJzdpu7kQmTLr+4cX6XGeoOSMOqJdISUf9Nx/DXmenlUGAvT0iYY7p
         0AxgSzQQKqKNz/dvren5zVYnzXmdD0yMtEQBUbHHrgOAX5zyZ0cmQ7TLjOkK2p6Ktgbd
         HUh2ABWIJ31YC/N0hRIMLi0bBWzJ3zu3SpBNg8TfpH6sfxk/WClekpoX73x6vCfbNmZx
         FHxIq8z4uY5bbxYoTn//bZFml5tT4UN8UjdwIoQByDK89y01tLdgDRXD0++HysYV4Bk5
         aPgA==
X-Forwarded-Encrypted: i=1; AJvYcCWFiExPz3E4EdM4NrGLEQiNQEqLnX6ZY9WeCIlm5fvG9tEPA5XsLsQ9fewhYqTtwtWRbV3FlkrKCMPAKZHo1wCK+VhfRfjr6OodtQsO
X-Gm-Message-State: AOJu0YxGwaqDKbr38Tc3xnUjXH38D0nVgXPdPzKQpIS1xnHAiu/7VoSa
	RgZo76E4nGkvKXOks+9IOO6gSE2lBH2EyA7wSZpQk9gZPaRhiLyf76pq1FKKL7BaWrP4u4FvUJD
	Ch0GHAM5VVWwAHl03ukb3IwZ5YmIMgdcJiOY04Q==
X-Google-Smtp-Source: AGHT+IHjBTTZQa7qBgppDed7Yik2WMBfjkdFGbu5wMEapZDol0p3T2lbrICDTJnWsIP7sYBB0USpkPC+bdxSwSztcyI=
X-Received: by 2002:a05:6e02:1b07:b0:36b:f987:19b3 with SMTP id
 i7-20020a056e021b0700b0036bf98719b3mr5937042ilv.24.1714024029010; Wed, 24 Apr
 2024 22:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com> <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
 <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
 <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
 <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com>
 <20240424-7b4434122a8c1cf1c1173403@orel> <CAP-5=fVts9oyi8AYmWnLvASZu_2AjcMeHX3UVLGiECX6yi3Pew@mail.gmail.com>
 <CAHBxVyFqd_4BWYmoxFkPWkJTzXKPqYD4UdPzdyGTQj+E-qBrjQ@mail.gmail.com>
In-Reply-To: <CAHBxVyFqd_4BWYmoxFkPWkJTzXKPqYD4UdPzdyGTQj+E-qBrjQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 25 Apr 2024 11:16:57 +0530
Message-ID: <CAAhSdy2joFbZ=jie0mPZXM1Qj0KSkSJyJ9J0Xyb12fbA0AYQSg@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:36=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Wed, Apr 24, 2024 at 11:27=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Apr 24, 2024 at 6:31=E2=80=AFAM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 05:36:43PM -0700, Atish Kumar Patra wrote:
> > > > On Mon, Apr 22, 2024 at 8:44=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Mon, Apr 15, 2024 at 9:07=E2=80=AFPM Anup Patel <anup@brainfau=
lt.org> wrote:
> > > > > >
> > > > > > On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@riv=
osinc.com> wrote:
> > > > > > >
> > > > > > > On 4/10/24 18:40, Samuel Holland wrote:
> > > > > > > > Hi Atish,
> > > > > > > >
> > > > > > > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > > > > > > >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <sam=
uel.holland@sifive.com> wrote:
> > > > > > > >>>
> > > > > > > >>> The RISC-V SBI PMU specification defines several standard=
 hardware and
> > > > > > > >>> cache events. Currently, all of these events appear in th=
e `perf list`
> > > > > > > >>> output, even if they are not actually implemented. Add lo=
gic to check
> > > > > > > >>> which events are supported by the hardware (i.e. can be m=
apped to some
> > > > > > > >>> counter), so only usable events are reported to userspace=
.
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >> Thanks for the patch.
> > > > > > > >> This adds tons of SBI calls at every boot for a use case w=
hich is at
> > > > > > > >> best confusing for a subset of users who actually wants to=
 run perf.
> > > > > > > >
> > > > > > > > I should have been clearer in the patch description. This i=
s not just a cosmetic
> > > > > > > > change; because perf sees these as valid events, it tries t=
o use them in
> > > > > > > > commands like `perf stat`. When the error from SBI_EXT_PMU_=
COUNTER_CFG_MATCH
> > > > > > > > causes the ->add() callback to fail, this prevents any othe=
r events from being
> > > > > > > > scheduled on that same CPU (search can_add_hw in kernel/eve=
nts/core.c). That is
> > > > > > > > why the dTLB/iTLB miss counts are missing in the "before" e=
xample below.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for explaining the problem. I can reproduce it in qemu=
 as well if
> > > > > > > enough number of invalid events given on the command line and=
 the
> > > > > > > workload is short enough.
> > > > > > >
> > > > > > > >> This probing can be done at runtime by invoking the
> > > > > > > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > > > > > > >> We can update the event map after that so that it doesn't =
need to
> > > > > > > >> invoke pmu_sbi_check_event next time.
> > > > > > > >
> > > > > > > > I tried to implement this suggestion, but it did not work. =
The SBI interface
> > > > > > > > does not distinguish between "none of the counters can moni=
tor the specified
> > > > > > > > event [because the event is unsupported]" and "none of the =
counters can monitor
> > > > > > > > the specified event [because the counters are busy]". It is=
 not sufficient for
> > > > > > > > the kernel to verify that at least one counter is available=
 before performing
> > > > > > > > the check, because certain events may only be usable on a s=
ubset of counters
> > > > > > > > (per riscv,event-to-mhpmcounters), and the kernel does not =
know that mapping.
> > > > > > > >
> > > > > > >
> > > > > > > Yeah. My suggestion was to fix the perf list issue which is d=
ifferent
> > > > > > > than the issue reported now.
> > > > > > >
> > > > > > > > As a result, checking for event support is only reliable wh=
en none of the
> > > > > > > > counters are in use. So the check can be asynchronous/defer=
red to later in the
> > > > > > > > boot process, but I believe it still needs to be performed =
for all events before
> > > > > > > > userspace starts using the counters.
> > > > > > > >
> > > > > > >
> > > > > > > We should defer it a work queue for sure. We can also look at=
 improving
> > > > > > > SBI PMU extension to support bulk matching behavior as well.
> > > > > > >
> > > > > > > However, I think a better solution would be to just rely on t=
he json
> > > > > > > file mappings instead of making SBI calls. We are going to ha=
ve the
> > > > > > > event encoding and mappings in the json in the future.
> > > > > >
> > > > > > The problem with JSON based event encoding is how to deal in-ca=
se
> > > > > > we are running inside Guest/VM because Host could be anything.
> > > > > >
> > > > > > IMO, the JSON based approach is not suitable for SBI PMU. For n=
ow,
> > > > > > we either defer the work using the work queue or keep the appro=
ach
> > > > > > of this patch as-is.
> > > > > >
> > > > > > The good part about SBI PMU extension is that we do have a stan=
dard
> > > > > > set of events and we only need a way to discover supported stan=
dard
> > > > > > events with a minimum number of SBI calls. It is better to add =
a new
> > > > > > SBI PMU call to assist supported event discovery which will als=
o
> > > > > > help us virtualize it.
> > > > > >
> > > > > > Regards,
> > > > > > Anup
> > > > >
> > > > > +Ian Rogers
> > > > >
> > > > > `perf list` will already filter some events depending on whether =
the
> > > > > PMU supports them, for example, legacy cache events. I think we c=
an
> > > > > extend this to json events.
> > > > >
> > > >
> > > > Yes. That's what I was thinking as well. However, that may be a
> > > > problem in virtualization
> > > > as Anup pointed out.
> > > >
> > > > As per my understanding, cloud providers provide json files for VMs
> > > > based on the host
> > > > architecture and allow migration only between hosts with the same
> > > > family of cpu. In RISC-V, the mapfile.csv works based on 3 register=
s
> > > > indicating marchid, mimpid, and mvendorid. Thus, the json file has =
to
> > > > be tied with the host machine it is going to be run.
> > >
> > > This is also my understanding. That is, that cloud instances typicall=
y
> > > dedicate CPUs to VMs and don't try to present CPU models to VMs which
> > > don't exactly match the host's CPUs. The remaining concern would be i=
f
> > > the hypervisor doesn't emulate/passthrough everything the json descri=
bes
> > > for the host CPU type.
> >
>
> x86/ARM64 kvm also can filter any event for the guest they want.
>
> > So this isn't accurate. For x86 perf uses the CPUID instruction. A
> > host operating system can change the CPUID for a guest, say pretending
> > a newer CPU model is actually an older one. This can be done when
> > migrating VMs as having the CPUID change dynamically in a guest would
> > be a problem. VM migration like this can have issues and it is fair to
> > say that it is avoided.
> >
>
> I was specifically asking if the json file is updated for a guest when mi=
grated
> if the events supported on the destination host are different than the
> source host ?
>
> Or The VM migration across different CPUIDs (e.g different family of CPUs=
)
> are avoided completely. It seems the latter from your statement ?
>
>
> > Fwiw, a particular problem we have with x86 guests is the host hiding
> > CPUID leaves that describe things like the frequency of the CPU. It is
> > difficult to compute metrics in units of time when you don't know what
> > frequency cycles relates to.
> >
> > > However, this is just "typical" clouds. All bets are off for general
> > > virtualization, as Anup points out.
> > >
> > > >
> > > > We will end up doing the same if we only rely on the json file to
> > > > filter events in the future. Please let me know if the assumption i=
s
> > > > incorrect.
> > > >
> > > > If we allow a SBI call route to discover which events are supported=
,
> > > > the guest can always support legacy events on any host even though =
it
> > > > doesn't have a json file.
> > >
> > > Yes, I think we need a solution which works even without a json file,
> > > since a VM may use a special mvendorid,marchid,mimpid triplet to
> > > describe a more generic CPU type. Unless we also create json files
> > > for these VCPUs, or provide other event discovery mechanisms, then
> > > the VMs will not have anything.
> >
>
> We have to create a json file for VMs anyways for raw events. Having
> the discovery through
> SBI call allows minimum guarantee for the perf legacy events.
>
> > I think a set of generic events is a good thing, then the PMU driver
> > can map perf's legacy events to the generic events in a clean way. I'm
> > not sure what the issue is with RISC-V guest operating systems. To
>
> The pertinent question here is how does the guest know the list of
> supported generic or perf legacy
> events as RISC-V doesn't have any standard event format/encoding
> support. There are two approaches
>
> 1. Define a new SBI interface which allows the host to let the guest
> know which events are supported at one shot.
> The perf legacy events mappings are updated at guest boot time via
> this interface. Currently, this patch achieves this
> by iterating through all the possible legacy events and making an SBI
> call one at a time during the boot.
>
> 2. Rely on the json file present (if) in the guest. In this case, all
> the supported perf legacy events must be present in
> the json. In absence of that, the driver assumes it is not supported.

I think we should define the SBI interface anyway and let hypervisors
choose their own approach. In other words, if the json file is not present
for a platform (guest/host) then kernel perf driver can rely on other
means (such as SBI interface).

>
>
> > lower overhead on x86 pass-through PMUs are being explored, that is
> > the guest operating system directly programming the CPU's performance
> > counters to avoid hypervisor traps. For this to work the triplet
> > mvendorid,marchid,mimpid should match that of the host.
> >
>
> Yes. I am tracking the pass through series for vPMU in x86.
> RISC-V also doesn't have pass through support and implements counter
> virtualization similar
> to other architectures as well but we have less number of traps
> because of the bulk access features.
>
> > The perf tool supports the notion of a standard set of legacy events
> > like instructions, cycles and certain cache events. More recently
> > we've moved to prefer sysfs and json events over these, primarily
> > because the Apple M1 ARM based Macs nobody was establishing the
> > mapping from legacy to an actual event. Users were complaining that
> > 'cycles' via a sysfs event worked, but when ARM was made like Intel
> > and prioritized legacy first, we broke it. Now we prioritize sysfs and
> > json way for all architectures and hopefully everyone is happy. The
> > last clean up for this is in:
> > https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com=
/
> >
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > drew

Regards,
Anup

