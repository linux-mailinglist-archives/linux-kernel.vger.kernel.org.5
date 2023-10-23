Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EDF7D2CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJWIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:34:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53709DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:34:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2913684b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698050080; x=1698654880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR8KPNyv3zA05aOnkxQ4ETv9DdtPX6p9DawGEERDunE=;
        b=IlUh33D7sLQ7F/d+bK/fR2Uy46y4sR81wmNL6GYowJ4SBeGnT0qc4QYOsQ9MYx/j3C
         yc/gEBWwQvvkRL41AQddeTIIAZMrxF6fYsbVwGHdUtHmjZdFk/mXzAJrhCjCIQlA/PRm
         RuNsHr441DhWTUxRVSuiQzw/XtEB72vNoejesWFGwu8SJWB5YK4X0AN4dLMiyM+qQyIP
         gsG9Sou3B4cP/OeTxy23U0rKO9x/sN+hlE3Sg6dYUdV6JS3PgixT9yG5tlBZDct1CK8R
         b7dkQ9prVvQqDEm/zTawcT0v9Vc6Lykyy3bOXoWNC5bwCL12lY1LQ6JWl3H1c1R5AZu9
         iPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050080; x=1698654880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR8KPNyv3zA05aOnkxQ4ETv9DdtPX6p9DawGEERDunE=;
        b=QbtYtJfFlatEq67CAKQRgR0pdhFr6Nom0+tsggF5o2PUaFWff7K1hxkuDR1TnKa+71
         GMzPTZHAxmx+a5oalzstCDncKe1IN6M88PW4rhneY0miq1ob2HV8xAlbutzg0fBscYOi
         ojQ63AKWLakYKzCWIe3bQWAxtkCxn1CxO/f16ogEPlmArQoiaWf1pObNJyRbrK+VUa+x
         CDP6pAndRlRAY3N4Kj2lvwLMC/U7jvA3w7kLQSZtvSjrWVtwr71p2nUt2SAPVlUY8vAG
         VQ4dqL2TL8Addq1e4/UAH+5y4oOkueT35kh3ajXy0TDpmgAs2IFGhGxjdBQfw2d8hUs6
         l/yQ==
X-Gm-Message-State: AOJu0YyHzp4eKvWpflgtF/mm3fvSSWObvhi7CQYa+WW/51PSJakw36yS
        sLLSOOrVeV5MWUg0Rbvb+KJ79UE+aHwY8iZtuRFfbQ==
X-Google-Smtp-Source: AGHT+IFXhqBiushNXKeL48+cHAHIX6i6jopbNruTLpgFa74dQ5CKzy8rMHklTu1wEk3qPGVkDqiin5PmFn+Wkm3RIkk=
X-Received: by 2002:a05:6a20:12d0:b0:17a:4890:fa31 with SMTP id
 v16-20020a056a2012d000b0017a4890fa31mr8849626pzg.56.1698050079415; Mon, 23
 Oct 2023 01:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us> <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us> <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
 <87o7gtpdb4.fsf@all.your.base.are.belong.to.us> <CAK9=C2WVkbDtz9uZTNjEcJzKQ44cHLR=+nSVZZmSptzL_U4NNA@mail.gmail.com>
 <87v8b1i72s.fsf@all.your.base.are.belong.to.us> <CAK9=C2X__tYk21F+o2GmKDMzdnZf8TXJn=baO248ao8as47vnA@mail.gmail.com>
 <875y31cc2y.fsf@all.your.base.are.belong.to.us> <87jzrdx1mm.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87jzrdx1mm.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 23 Oct 2023 14:04:26 +0530
Message-ID: <CAK9=C2U2FEoAPgoxibsbPsjF+d+APWFuJtEL43=xxwnwM4L1ZA@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Linux RISC-V AIA Support
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:32=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> > Anup Patel <apatel@ventanamicro.com> writes:
> >
> >> On Fri, Oct 20, 2023 at 10:07=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@=
kernel.org> wrote:
> >>>
> >>> Anup Patel <apatel@ventanamicro.com> writes:
> >>>
> >>> > On Fri, Oct 20, 2023 at 8:10=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjor=
n@kernel.org> wrote:
> >>> >>
> >>> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>> >>
> >>> >> > On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <b=
jorn@kernel.org> wrote:
> >>> >> >>
> >>> >> >> Thanks for the quick reply!
> >>> >> >>
> >>> >> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>> >> >>
> >>> >> >> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel=
 <bjorn@kernel.org> wrote:
> >>> >> >> >>
> >>> >> >> >> Hi Anup,
> >>> >> >> >>
> >>> >> >> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>> >> >> >>
> >>> >> >> >> > The RISC-V AIA specification is ratified as-per the RISC-V=
 international
> >>> >> >> >> > process. The latest ratified AIA specifcation can be found=
 at:
> >>> >> >> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/r=
iscv-interrupts-1.0.pdf
> >>> >> >> >> >
> >>> >> >> >> > At a high-level, the AIA specification adds three things:
> >>> >> >> >> > 1) AIA CSRs
> >>> >> >> >> >    - Improved local interrupt support
> >>> >> >> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >>> >> >> >> >    - Per-HART MSI controller
> >>> >> >> >> >    - Support MSI virtualization
> >>> >> >> >> >    - Support IPI along with virtualization
> >>> >> >> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >>> >> >> >> >    - Wired interrupt controller
> >>> >> >> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e.=
 MSI generator)
> >>> >> >> >> >    - In Direct-mode, injects external interrupts directly =
into HARTs
> >>> >> >> >>
> >>> >> >> >> Thanks for working on the AIA support! I had a look at the s=
eries, and
> >>> >> >> >> have some concerns about interrupt ID abstraction.
> >>> >> >> >>
> >>> >> >> >> A bit of background, for readers not familiar with the AIA d=
etails.
> >>> >> >> >>
> >>> >> >> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per har=
t, and
> >>> >> >> >> each MSI is dedicated to a certain hart. The series takes th=
e approach
> >>> >> >> >> to say that there are, e.g., 2047 interrupts ("lnx-irq") glo=
bally.
> >>> >> >> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- and =
in the
> >>> >> >> >> slice only *one* msi-irq is acutally used.
> >>> >> >> >>
> >>> >> >> >> This scheme makes affinity changes more robust, because the =
interrupt
> >>> >> >> >> sources on "other" harts are pre-allocated. On the other han=
d it
> >>> >> >> >> requires to propagate irq masking to other harts via IPIs (t=
his is
> >>> >> >> >> mostly done up setup/tear down). It's also wasteful, because=
 msi-irqs
> >>> >> >> >> are hogged, and cannot be used.
> >>> >> >> >>
> >>> >> >> >> Contemporary storage/networking drivers usually uses queues =
per core
> >>> >> >> >> (or a sub-set of cores). The current scheme wastes a lot of =
msi-irqs.
> >>> >> >> >> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", =
instead of
> >>> >> >> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", the=
re would be
> >>> >> >> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage d=
evice
> >>> >> >> >> would like to use 5 queues (5 cores) on a 128 core system, t=
he current
> >>> >> >> >> scheme would consume 5 * 128 MSIs, instead of just 5.
> >>> >> >> >>
> >>> >> >> >> On the plus side:
> >>> >> >> >> * Changing interrupts affinity will never fail, because the =
interrupts
> >>> >> >> >>   on each hart is pre-allocated.
> >>> >> >> >>
> >>> >> >> >> On the negative side:
> >>> >> >> >> * Wasteful interrupt usage, and a system can potientially "r=
un out" of
> >>> >> >> >>   interrupts. Especially for many core systems.
> >>> >> >> >> * Interrupt masking need to proagate to harts via IPIs (ther=
e's no
> >>> >> >> >>   broadcast csr in IMSIC), and a more complex locking scheme=
 IMSIC
> >>> >> >> >>
> >>> >> >> >> Summary:
> >>> >> >> >> The current series caps the number of global interrupts to m=
aximum
> >>> >> >> >> 2047 MSIs for all cores (whole system). A better scheme, IMO=
, would be
> >>> >> >> >> to expose 2047 * #harts unique MSIs.
> >>> >> >> >>
> >>> >> >> >> I think this could simplify/remove(?) the locking as well.
> >>> >> >> >
> >>> >> >> > Exposing 2047 * #harts unique MSIs has multiple issues:
> >>> >> >> > 1) The irq_set_affinity() does not work for MSIs because each
> >>> >> >> >      IRQ is not tied to a particular HART. This means we can'=
t
> >>> >> >> >      balance the IRQ processing load among HARTs.
> >>> >> >>
> >>> >> >> Yes, you can balance. In your code, each *active* MSI is still
> >>> >> >> bound/active to a specific hard together with the affinity mask=
. In an
> >>> >> >> 1-1 model you would still need to track the affinity mask, but =
the
> >>> >> >> irq_set_affinity() would be different. It would try to allocate=
 a new
> >>> >> >> MSI from the target CPU, and then switch to having that MSI act=
ive.
> >>> >> >>
> >>> >> >> That's what x86 does AFAIU, which is also constrained by the # =
of
> >>> >> >> available MSIs.
> >>> >> >>
> >>> >> >> The downside, as I pointed out, is that the set affinity action=
 can
> >>> >> >> fail for a certain target CPU.
> >>> >> >
> >>> >> > Yes, irq_set_affinity() can fail for the suggested approach plus=
 for
> >>> >> > RISC-V AIA, one HART does not have access to other HARTs
> >>> >> > MSI enable/disable bits so the approach will also involve IPI.
> >>> >>
> >>> >> Correct, but the current series does a broadcast to all cores, whe=
re the
> >>> >> 1-1 approach is at most an IPI to a single core.
> >>> >>
> >>> >> 128+c machines are getting more common, and you have devices that =
you
> >>> >> bring up/down on a per-core basis. Broadcasting IPIs to all cores,=
 when
> >>> >> dealing with a per-core activity is a pretty noisy neighbor.
> >>> >
> >>> > Broadcast IPI in the current approach is only done upon MSI mask/un=
mask
> >>> > operation. It is not done upon set_affinity() of interrupt handling=
.
> >>>
> >>> I'm aware. We're on the same page here.
> >>>
> >>> >>
> >>> >> This could be fixed in the existing 1-n approach, by not require t=
o sync
> >>> >> the cores that are not handling the MSI in question. "Lazy disable=
"
> >>> >
> >>> > Incorrect. The approach you are suggesting involves an IPI upon eve=
ry
> >>> > irq_set_affinity(). This is because a HART can only enable it's own
> >>> > MSI ID so when an IRQ is moved to from HART A to HART B with
> >>> > a different ID X on HART B then we will need an IPI in irq_set_affi=
nit()
> >>> > to enable ID X on HART B.
> >>>
> >>> Yes, the 1-1 approach will require an IPI to one target cpu on affini=
ty
> >>> changes, and similar on mask/unmask.
> >>>
> >>> The 1-n approach, require no-IPI on affinity changes (nice!), but IPI
> >>> broadcast to all cores on mask/unmask (not so nice).
> >>>
> >>> >> >> My concern is interrupts become a scarce resource with this
> >>> >> >> implementation, but maybe my view is incorrect. I've seen bare-=
metal
> >>> >> >> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts, but=
 maybe
> >>> >> >> that is considered "a lot of interrupts".
> >>> >> >>
> >>> >> >> As long as we don't get into scenarios where we're running out =
of
> >>> >> >> interrupts, due to the software design.
> >>> >> >>
> >>> >> >
> >>> >> > The current approach is simpler and ensures irq_set_affinity
> >>> >> > always works. The limit of max 2047 IDs is sufficient for many
> >>> >> > systems (if not all).
> >>> >>
> >>> >> Let me give you another view. On a 128c system each core has ~16 u=
nique
> >>> >> interrupts for disposal. E.g. the Intel E800 NIC has more than 204=
8
> >>> >> network queue pairs for each PF.
> >>> >
> >>> > Clearly, this example is a hypothetical and represents a poorly
> >>> > designed platform.
> >>> >
> >>> > Having just 16 IDs per-Core is a very poor design choice. In fact, =
the
> >>> > Server SoC spec mandates a minimum 255 IDs.
> >>>
> >>> You are misreading. A 128c system with 2047 MSIs per-core, will only
> >>> have 16 *per-core unique* (2047/128) interrupts with the current seri=
es.
> >>>
> >>> I'm not saying that each IMSIC has 16 IDs, I'm saying that in a 128c
> >>> system with the maximum amount of MSIs possible in the spec, you'll e=
nd
> >>> up with 16 *unique* interrupts per core.
> >>
> >> -ENOPARSE
> >>
> >> I don't see how this applies to the current approach because we treat
> >> MSI ID space as global across cores so if a system has 2047 MSIs
> >> per-core then we have 2047 MSIs across all cores.
> >
> > Ok, I'll try again! :-)
> >
> > Let's assume that each core in the 128c system has some per-core
> > resources, say a two NIC queue pairs, and a storage queue pair. This
> > will consume, e.g., 2*2 + 2 (6) MSI sources from the global namespace.
> >
> > If each core does this it'll be 6*128 MSI sources of the global
> > namespace.
> >
> > The maximum number of "privates" MSI sources a core can utilize is 16.
> >
> > I'm trying (it's does seem to go that well ;-)) to point out that it's
> > only 16 unique sources per core. For, say, a 256 core system it would b=
e
> > 8. 2047 MSI sources in a system is not much.
> >
> > Say that I want to spin up 24 NIC queues with one MSI each on each core
> > on my 128c system. That's not possible with this series, while with an
> > 1-1 system it wouldn't be an issue.
> >
> > Clearer, or still weird?
> >
> >>
> >>>
> >>> > Regarding NICs which support a large number of queues, the driver
> >>> > will typically enable only one queue per-core and set the affinity =
to
> >>> > separate cores. We have user-space data plane applications based
> >>> > on DPDK which are capable of using a large number of NIC queues
> >>> > but these applications are polling based and don't use MSIs.
> >>>
> >>> That's one sample point, and clearly not the only one. There are *man=
y*
> >>> different usage models. Just because you *assign* MSI, doesn't mean t=
hey
> >>> are firing all the time.
> >>>
> >>> I can show you a couple of networking setups where this is clearly no=
t
> >>> enough. Each core has a large number of QoS queues, and each queue wo=
uld
> >>> very much like to have a dedicated MSI.
> >>>
> >>> >> > When we encounter a system requiring a large number of MSIs,
> >>> >> > we can either:
> >>> >> > 1) Extend the AIA spec to support greater than 2047 IDs
> >>> >> > 2) Re-think the approach in the IMSIC driver
> >>> >> >
> >>> >> > The choice between #1 and #2 above depends on the
> >>> >> > guarantees we want for irq_set_affinity().
> >>> >>
> >>> >> The irq_set_affinity() behavior is better with this series, but I =
think
> >>> >> the other downsides: number of available interrupt sources, and IP=
I
> >>> >> broadcast are worse.
> >>> >
> >>> > The IPI overhead in the approach you are suggesting will be
> >>> > even bad compared to the IPI overhead of the current approach
> >>> > because we will end-up doing IPI upon every irq_set_affinity()
> >>> > in the suggested approach compared to doing IPI upon every
> >>> > mask/unmask in the current approach.
> >>>
> >>> Again, very workload dependent.
> >>>
> >>> This series does IPI broadcast on masking/unmasking, which means that
> >>> cores that don't care get interrupted because, say, a network queue-p=
air
> >>> is setup on another core.
> >>>
> >>> Some workloads never change the irq affinity.
> >>
> >> There are various events which irq affinity such as irq balance,
> >> CPU hotplug, system suspend, etc.
> >>
> >> Also, the 1-1 approach does IPI upon set_affinity, mask and
> >> unmask whereas the 1-n approach does IPI only upon mask
> >> and unmask.
> >
> > An important distinction; When you say IPI on mask/unmask it is a
> > broadcast IPI to *all* cores, which is pretty instrusive.
> >
> > The 1-1 variant does an IPI to a *one* target core.
> >
> >>> I'm just pointing out that there are pro/cons with both variants.
> >>>
> >>> > The biggest advantage of the current approach is a reliable
> >>> > irq_set_affinity() which is a very valuable thing to have.
> >>>
> >>> ...and I'm arguing that we're paying a big price for that.
> >>>
> >>> > ARM systems easily support a large number of LPIs per-core.
> >>> > For example, GIC-700 supports 56000 LPIs per-core.
> >>> > (Refer, https://developer.arm.com/documentation/101516/0300/About-t=
he-GIC-700/Features)
> >>>
> >>> Yeah, but this is not the GIC. This is something that looks more like
> >>> the x86 world. We'll be stuck with a lot of implementations with AIA =
1.0
> >>> spec, and many cores.
> >>
> >> Well, RISC-V AIA is neigher ARM GIG not x86 APIC. All I am saying
> >> is that there are systems with large number per-core interrupt IDs
> >> for handling MSIs.
> >
> > Yes, and while that is nice, it's not what IMSIC is.
>
> Some follow-ups, after thinking more about it more over the weekend.
>
> * Do one really need an IPI for irq_set_affinity() for the 1-1 model?
>   Why touch the enable/disable bits when moving interrupts?

In the 1-1 model, the ID on the current HART and target HART upon
irq_set_affinity will be different so we can't leave the unused ID on
current HART enabled because it can lead to spurious interrupts
when the ID on current HART is re-used for some other device.

There is also a possibility of receiving an interrupt while the ID was
moved to a new target HART in-which case we have to detect and
re-trigger interrupt on the new target HART. In fact, x86 APLIC does
an IPI to take care of this case.

>
> * In my book the IMSIC looks very much like the x86 LAPIC, which also
>   has few interrupts (IMSIC <2048, LAPIC 256). The IRQ matrix allocator
>   [1], and a scheme similar to LAPIC [2] would be a good fit. This is
>   the 1-1 model, but more sophisticated than what I've been describing
>   (e.g. properly handling mangaged/regular irqs). As a bonus we would
>   get the IRQ matrix debugfs/tracepoint support.
>

Yes, I have been evaluating the 1-1 model for the past few days. I also
have a working implementation with a simple per-CPU bitmap based
allocator which handles both legacy MSI (block of 1,2,4,8,16, or 32 IDs)
and MSI-X.

The irq matrix allocator needs to be improved for handling legacy MSI
so initially I will post a v11 series which works for me and converging
with irq matrix allocator can be future work.

Regards,
Anup
