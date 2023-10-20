Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA07D0E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377075AbjJTLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:00:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CDCA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:00:28 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3574f99d236so2360855ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697799628; x=1698404428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHpSTiytGwc8Xy6az9Rfbbssa0qq9wGR2suTbmUsAMc=;
        b=X6P2dsajpmyoOlONtjNxeWLpMb1gaDrX6FH77GXjhVfE/BJT/pkDecUbhLHMIIgysW
         Gqgdpo7X29CNt+80ThZzss+Jyngctgk861pWIYefCH6QSfI8Q6UdchPusGaHUS+2rZtP
         flDSCFUWEFUc3T6LxN+aHK+Uo32BJ3+BlLr31uFR/nWvc+LPkYGDycr+Az10j3X+hhmu
         srFamMesAenR/DDaepeRAoA8lo/D7Q3uzmiDOuqu8t1gZos9cFu+5JNsVsO9SpfkZePI
         AnlimfuucSO2/xX8qlTIU07belhkyr8gMvy7TqZeIQ4EfafW0ZZhaLo5MXwYQCfsj/oB
         Lt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799628; x=1698404428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHpSTiytGwc8Xy6az9Rfbbssa0qq9wGR2suTbmUsAMc=;
        b=Zb3Wl81Cv5dNi0I921bMMW7mIGv8vMipi7KX5q0mlWsiDhDeXMf5K5YFHy+k5XjN0S
         aiVykmF57mwNcPrMGp6paiAahFkcjzb/0BlmlXPb8Ro7FodGH5RcDBQbwAJMm5vJjHfk
         GOs0hv06/gajcjNb/Wsj322bnh/ZKWfAqFgVSrh2aoQ3AkwY983YMHxzmBPweft5IFeu
         h5ysebGbKinNUyrpiolOubblConN5xehhKxgUYAwEfZhH135WOUSYiml13lKSXR+DQD8
         8b1T6rJKLL938NduduWGk0kU1GoLnpjkLtjsT7PjgNBMqncu6uq/HbFcBUzwiOSnZMSw
         wxOg==
X-Gm-Message-State: AOJu0YzdZp0xYoZfOxIk+dxBDbTBoWX5+zxr4nBMPpPt8FKf/HSt7MFo
        bbYsKxkcagJu5qu+hEIuqaSP9dX0zFOWe0y37DUF9Q==
X-Google-Smtp-Source: AGHT+IGCAtPEjW44URtyXRv9Ih8OBkpbo4xga8jq4Ij91cUQrItZ1+vY358SrKxx+E5sUr1RMDKRetXLSO2IMRidhyc=
X-Received: by 2002:a05:6e02:1c2b:b0:351:5322:b801 with SMTP id
 m11-20020a056e021c2b00b003515322b801mr1833400ilh.16.1697799627968; Fri, 20
 Oct 2023 04:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us> <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87h6mlbryy.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 20 Oct 2023 16:30:15 +0530
Message-ID: <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
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

On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Thanks for the quick reply!
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> Hi Anup,
> >>
> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>
> >> > The RISC-V AIA specification is ratified as-per the RISC-V internati=
onal
> >> > process. The latest ratified AIA specifcation can be found at:
> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-inter=
rupts-1.0.pdf
> >> >
> >> > At a high-level, the AIA specification adds three things:
> >> > 1) AIA CSRs
> >> >    - Improved local interrupt support
> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >> >    - Per-HART MSI controller
> >> >    - Support MSI virtualization
> >> >    - Support IPI along with virtualization
> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >> >    - Wired interrupt controller
> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI gener=
ator)
> >> >    - In Direct-mode, injects external interrupts directly into HARTs
> >>
> >> Thanks for working on the AIA support! I had a look at the series, and
> >> have some concerns about interrupt ID abstraction.
> >>
> >> A bit of background, for readers not familiar with the AIA details.
> >>
> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
> >> each MSI is dedicated to a certain hart. The series takes the approach
> >> to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
> >> slice only *one* msi-irq is acutally used.
> >>
> >> This scheme makes affinity changes more robust, because the interrupt
> >> sources on "other" harts are pre-allocated. On the other hand it
> >> requires to propagate irq masking to other harts via IPIs (this is
> >> mostly done up setup/tear down). It's also wasteful, because msi-irqs
> >> are hogged, and cannot be used.
> >>
> >> Contemporary storage/networking drivers usually uses queues per core
> >> (or a sub-set of cores). The current scheme wastes a lot of msi-irqs.
> >> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instead of
> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there would b=
e
> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
> >> would like to use 5 queues (5 cores) on a 128 core system, the current
> >> scheme would consume 5 * 128 MSIs, instead of just 5.
> >>
> >> On the plus side:
> >> * Changing interrupts affinity will never fail, because the interrupts
> >>   on each hart is pre-allocated.
> >>
> >> On the negative side:
> >> * Wasteful interrupt usage, and a system can potientially "run out" of
> >>   interrupts. Especially for many core systems.
> >> * Interrupt masking need to proagate to harts via IPIs (there's no
> >>   broadcast csr in IMSIC), and a more complex locking scheme IMSIC
> >>
> >> Summary:
> >> The current series caps the number of global interrupts to maximum
> >> 2047 MSIs for all cores (whole system). A better scheme, IMO, would be
> >> to expose 2047 * #harts unique MSIs.
> >>
> >> I think this could simplify/remove(?) the locking as well.
> >
> > Exposing 2047 * #harts unique MSIs has multiple issues:
> > 1) The irq_set_affinity() does not work for MSIs because each
> >      IRQ is not tied to a particular HART. This means we can't
> >      balance the IRQ processing load among HARTs.
>
> Yes, you can balance. In your code, each *active* MSI is still
> bound/active to a specific hard together with the affinity mask. In an
> 1-1 model you would still need to track the affinity mask, but the
> irq_set_affinity() would be different. It would try to allocate a new
> MSI from the target CPU, and then switch to having that MSI active.
>
> That's what x86 does AFAIU, which is also constrained by the # of
> available MSIs.
>
> The downside, as I pointed out, is that the set affinity action can
> fail for a certain target CPU.

Yes, irq_set_affinity() can fail for the suggested approach plus for
RISC-V AIA, one HART does not have access to other HARTs
MSI enable/disable bits so the approach will also involve IPI.

>
> > 2) All wired IRQs for APLIC MSI-mode will also target a
> >     fixed HART hence irq_set_affinity() won't work for wired
> >     IRQs as well.
>
> I'm not following here. Why would APLIC put a constraint here? I had a
> look at the specs, and I didn't see anything supporting the current
> scheme explicitly.

Lets say the number of APLIC wired interrupts  are greater than the
number of per-CPU IMSIC IDs. In this case, if all wired interrupts are
moved to a particular CPU then irq_set_affinity() will fail for some of
the wired interrupts.

>
> > 3) Contemporary storage/networking drivers which use per-core
> >      queues use irq_set_affinity() on queue IRQs to balance
> >      across cores but this will fail.
>
> Or via the the managed interrupts. But this is a non-issue, as pointed
> out in my reply to 1.
>
> > 4) HART hotplug breaks because kernel irq-subsystem can't
> >     migrate the IRQs (both MSIs and Wired) targeting HART X
> >     to another HART Y when the HART X goes down.
>
> Yes, we might end up in scenarios where we can't move to a certain
> target cpu, but I wouldn't expect that to be a common scenario.
>
> > The idea of treating per-HART MSIs as separate IRQs has
> > been discussed in the past.
>
> Aha! I tried to look for it in lore, but didn't find any. Could you
> point me to those discussions?

This was done 2 years back in the AIA TG meeting when we were
doing the PoC for AIA spec.

>
> > Also, the current approach is very similar to the ARM GICv3 driver
> > where ITS LPIs across CPUs are treated as single IRQ.
>
> I'm not familiar with the GIC. Is the GICv3 design similar to IMSIC? I
> had the impression that the GIC had a more advanced interrupt routing
> mechanism, than what IMSIC exposes. I think x86 APIC takes the 1-1
> approach (the folks on the To: list definitely knows! ;-)).

GIC has a per-CPU redistributor which handles LPIs. The MSIs are
taken by GIC ITS and forwarded as LPI to the redistributor of a CPU.

The GIC driver treats LPI numbering space as global and not per-CPU.
Also, the limit on maximum number of LPIs is quite high because LPI
INTID can be 32-bit wide.

>
> My concern is interrupts become a scarce resource with this
> implementation, but maybe my view is incorrect. I've seen bare-metal
> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts, but maybe
> that is considered "a lot of interrupts".
>
> As long as we don't get into scenarios where we're running out of
> interrupts, due to the software design.
>

The current approach is simpler and ensures irq_set_affinity
always works. The limit of max 2047 IDs is sufficient for many
systems (if not all).

When we encounter a system requiring a large number of MSIs,
we can either:
1) Extend the AIA spec to support greater than 2047 IDs
2) Re-think the approach in the IMSIC driver

The choice between #1 and #2 above depends on the
guarantees we want for irq_set_affinity().

Regards,
Anup
