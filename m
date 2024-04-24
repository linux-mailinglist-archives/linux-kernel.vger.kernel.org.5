Return-Path: <linux-kernel+bounces-157530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F418B1267
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B446B28994F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7402316D9BE;
	Wed, 24 Apr 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4czK3M5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206C16E88D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983265; cv=none; b=JO5sD2GIhPPB9j+Gn6N2dSfYdcK5RTI3o8kVmj2TQyiUPq14VNvdPQ9qAIc8d3MYEoHOwgzdypfWquksaMLUjByjA7O8DSTga0dpg7jOP11mTnP3j17t8wUxGD8mAaPOAnIzmxA3GkKZN78PwxxcvB4kM15IBvjoWtohU9eV5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983265; c=relaxed/simple;
	bh=lUkuDxqy2td1CJh92CLAhjg1PDaKaSR6jAMKDt4n7lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOnOImKKcfYgAFZ0KmNQfCozaWSuySVgfIpWtaklCuFGTZ6pwlJayM+8uzrsHUxE+GkkFNb9W+ggegNLhm+/dVo8PWPZwyd74iFJ6zvCyfAjCjMDcKxC2Y2uHxZ3h0ECasxwem2vbMimDy5AFLq1XoVRtM+nRh48qzEC9UZ1p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4czK3M5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e8414dc4e8so22025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713983263; x=1714588063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUkuDxqy2td1CJh92CLAhjg1PDaKaSR6jAMKDt4n7lc=;
        b=H4czK3M52lZQ4lkNCmSvwoIFwLsJDvcQaR7TB2hyNXO7RbxyMnO4GNHdORFbq6NEU3
         UTuNAc6oFRnJlKrJG2yqGNygNn7p6SYYLktBzjVOe8zuL8ZNIu3H898Y7qxN2yEsBxeV
         BeZA3E8R2u0TcFBOBsYT8dFb2BZEnvHBbVjmRmxp1vnq+zIPRx6gGP+e08Lmo8XNFLjH
         oHLTh7gSejXDpnlGvbkd3CqeFPSiOrt26y5/BmSs6+xLmnE3RIxNi6ns4BORYqNEu0UH
         Bn08rej2h+0kCkaPVAm/Gzjl/PahVowZZ4sC2GUyJyW11bcoRo3c95/O4p6pOM2BA0+a
         rHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983263; x=1714588063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUkuDxqy2td1CJh92CLAhjg1PDaKaSR6jAMKDt4n7lc=;
        b=gZIGmJ91W9lZ34RRsAa2QrzxL4OYzRMoFitbqWeMEk9aG9MJ9fuC5SM3EAta6bsGU0
         KQF5xEf//lLBGXCcSZIfxP1/cnNRTcIiqlwtytbBXWb/YJ0LKlVe63cpN1myCWSSP0od
         1I1o8WEDAi0jgsxl6YRnsw48/f+hefZz5J7vT/B68bT28O843hN2TvT20nr3K99gkleZ
         WFTvZOx3/brspespiPiYu3soAF4TaVc5x+5bXbsGF8wM8QSQA4ljQ2zDMsxOFIlmMt4Y
         aeLB1lQ0xVaujw4AW8IPRWm4MOAaxBXjfkH5LW373O6r69NK63Ob9gklpflR5jG/Giee
         Geyg==
X-Forwarded-Encrypted: i=1; AJvYcCXicZgh713hjN12qeUgj/Jw8wm4XOCNhEisC4igUhLUR1ds8c/mdRkF0MieputebYQOLdCwVx6JPffx3yEpB4YJTVWmYPAoju32HtPU
X-Gm-Message-State: AOJu0YxML2t2/S9DMoDWPOVvzKrXk0NOkQBZnSaN56JL2FUj17qkA+Gk
	9BdyoJ8vt4xMQRo9dQ3cQvCWf3x5CqcUrQAwVo7GtGd1W1BHVk4gvtfemrPd0sNz8ri9u4r+S64
	PPeh2eP3naAKaFWdOopiWv1YQdw/r3+o/5Fqc
X-Google-Smtp-Source: AGHT+IG9TFWjYX67TS5BhRxVy86ZzzMgfPz0j+VuLcUx7js4RWdhKLVokAumLhOPIOnftf73ljJ0IdX49/SiVJMVFwM=
X-Received: by 2002:a17:902:d581:b0:1e5:3c03:cbc1 with SMTP id
 k1-20020a170902d58100b001e53c03cbc1mr9793plh.21.1713983262738; Wed, 24 Apr
 2024 11:27:42 -0700 (PDT)
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
 <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com> <20240424-7b4434122a8c1cf1c1173403@orel>
In-Reply-To: <20240424-7b4434122a8c1cf1c1173403@orel>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 11:27:28 -0700
Message-ID: <CAP-5=fVts9oyi8AYmWnLvASZu_2AjcMeHX3UVLGiECX6yi3Pew@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:31=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Apr 23, 2024 at 05:36:43PM -0700, Atish Kumar Patra wrote:
> > On Mon, Apr 22, 2024 at 8:44=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Mon, Apr 15, 2024 at 9:07=E2=80=AFPM Anup Patel <anup@brainfault.o=
rg> wrote:
> > > >
> > > > On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@rivosin=
c.com> wrote:
> > > > >
> > > > > On 4/10/24 18:40, Samuel Holland wrote:
> > > > > > Hi Atish,
> > > > > >
> > > > > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > > > > >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samuel.=
holland@sifive.com> wrote:
> > > > > >>>
> > > > > >>> The RISC-V SBI PMU specification defines several standard har=
dware and
> > > > > >>> cache events. Currently, all of these events appear in the `p=
erf list`
> > > > > >>> output, even if they are not actually implemented. Add logic =
to check
> > > > > >>> which events are supported by the hardware (i.e. can be mappe=
d to some
> > > > > >>> counter), so only usable events are reported to userspace.
> > > > > >>>
> > > > > >>
> > > > > >> Thanks for the patch.
> > > > > >> This adds tons of SBI calls at every boot for a use case which=
 is at
> > > > > >> best confusing for a subset of users who actually wants to run=
 perf.
> > > > > >
> > > > > > I should have been clearer in the patch description. This is no=
t just a cosmetic
> > > > > > change; because perf sees these as valid events, it tries to us=
e them in
> > > > > > commands like `perf stat`. When the error from SBI_EXT_PMU_COUN=
TER_CFG_MATCH
> > > > > > causes the ->add() callback to fail, this prevents any other ev=
ents from being
> > > > > > scheduled on that same CPU (search can_add_hw in kernel/events/=
core.c). That is
> > > > > > why the dTLB/iTLB miss counts are missing in the "before" examp=
le below.
> > > > > >
> > > > >
> > > > > Thanks for explaining the problem. I can reproduce it in qemu as =
well if
> > > > > enough number of invalid events given on the command line and the
> > > > > workload is short enough.
> > > > >
> > > > > >> This probing can be done at runtime by invoking the
> > > > > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > > > > >> We can update the event map after that so that it doesn't need=
 to
> > > > > >> invoke pmu_sbi_check_event next time.
> > > > > >
> > > > > > I tried to implement this suggestion, but it did not work. The =
SBI interface
> > > > > > does not distinguish between "none of the counters can monitor =
the specified
> > > > > > event [because the event is unsupported]" and "none of the coun=
ters can monitor
> > > > > > the specified event [because the counters are busy]". It is not=
 sufficient for
> > > > > > the kernel to verify that at least one counter is available bef=
ore performing
> > > > > > the check, because certain events may only be usable on a subse=
t of counters
> > > > > > (per riscv,event-to-mhpmcounters), and the kernel does not know=
 that mapping.
> > > > > >
> > > > >
> > > > > Yeah. My suggestion was to fix the perf list issue which is diffe=
rent
> > > > > than the issue reported now.
> > > > >
> > > > > > As a result, checking for event support is only reliable when n=
one of the
> > > > > > counters are in use. So the check can be asynchronous/deferred =
to later in the
> > > > > > boot process, but I believe it still needs to be performed for =
all events before
> > > > > > userspace starts using the counters.
> > > > > >
> > > > >
> > > > > We should defer it a work queue for sure. We can also look at imp=
roving
> > > > > SBI PMU extension to support bulk matching behavior as well.
> > > > >
> > > > > However, I think a better solution would be to just rely on the j=
son
> > > > > file mappings instead of making SBI calls. We are going to have t=
he
> > > > > event encoding and mappings in the json in the future.
> > > >
> > > > The problem with JSON based event encoding is how to deal in-case
> > > > we are running inside Guest/VM because Host could be anything.
> > > >
> > > > IMO, the JSON based approach is not suitable for SBI PMU. For now,
> > > > we either defer the work using the work queue or keep the approach
> > > > of this patch as-is.
> > > >
> > > > The good part about SBI PMU extension is that we do have a standard
> > > > set of events and we only need a way to discover supported standard
> > > > events with a minimum number of SBI calls. It is better to add a ne=
w
> > > > SBI PMU call to assist supported event discovery which will also
> > > > help us virtualize it.
> > > >
> > > > Regards,
> > > > Anup
> > >
> > > +Ian Rogers
> > >
> > > `perf list` will already filter some events depending on whether the
> > > PMU supports them, for example, legacy cache events. I think we can
> > > extend this to json events.
> > >
> >
> > Yes. That's what I was thinking as well. However, that may be a
> > problem in virtualization
> > as Anup pointed out.
> >
> > As per my understanding, cloud providers provide json files for VMs
> > based on the host
> > architecture and allow migration only between hosts with the same
> > family of cpu. In RISC-V, the mapfile.csv works based on 3 registers
> > indicating marchid, mimpid, and mvendorid. Thus, the json file has to
> > be tied with the host machine it is going to be run.
>
> This is also my understanding. That is, that cloud instances typically
> dedicate CPUs to VMs and don't try to present CPU models to VMs which
> don't exactly match the host's CPUs. The remaining concern would be if
> the hypervisor doesn't emulate/passthrough everything the json describes
> for the host CPU type.

So this isn't accurate. For x86 perf uses the CPUID instruction. A
host operating system can change the CPUID for a guest, say pretending
a newer CPU model is actually an older one. This can be done when
migrating VMs as having the CPUID change dynamically in a guest would
be a problem. VM migration like this can have issues and it is fair to
say that it is avoided.

Fwiw, a particular problem we have with x86 guests is the host hiding
CPUID leaves that describe things like the frequency of the CPU. It is
difficult to compute metrics in units of time when you don't know what
frequency cycles relates to.

> However, this is just "typical" clouds. All bets are off for general
> virtualization, as Anup points out.
>
> >
> > We will end up doing the same if we only rely on the json file to
> > filter events in the future. Please let me know if the assumption is
> > incorrect.
> >
> > If we allow a SBI call route to discover which events are supported,
> > the guest can always support legacy events on any host even though it
> > doesn't have a json file.
>
> Yes, I think we need a solution which works even without a json file,
> since a VM may use a special mvendorid,marchid,mimpid triplet to
> describe a more generic CPU type. Unless we also create json files
> for these VCPUs, or provide other event discovery mechanisms, then
> the VMs will not have anything.

I think a set of generic events is a good thing, then the PMU driver
can map perf's legacy events to the generic events in a clean way. I'm
not sure what the issue is with RISC-V guest operating systems. To
lower overhead on x86 pass-through PMUs are being explored, that is
the guest operating system directly programming the CPU's performance
counters to avoid hypervisor traps. For this to work the triplet
mvendorid,marchid,mimpid should match that of the host.

The perf tool supports the notion of a standard set of legacy events
like instructions, cycles and certain cache events. More recently
we've moved to prefer sysfs and json events over these, primarily
because the Apple M1 ARM based Macs nobody was establishing the
mapping from legacy to an actual event. Users were complaining that
'cycles' via a sysfs event worked, but when ARM was made like Intel
and prioritized legacy first, we broke it. Now we prioritize sysfs and
json way for all architectures and hopefully everyone is happy. The
last clean up for this is in:
https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> drew

