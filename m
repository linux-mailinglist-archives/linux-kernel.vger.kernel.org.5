Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F170D7D12DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbjJTPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377616AbjJTPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:34:34 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4ABE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:34:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35135b79b6aso3146525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697816070; x=1698420870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V84nzu//9Ccx1eMGnmV3Yd2nV/swh6SKrL0rqKbIxJY=;
        b=G6l3mcdrohPpWMojssZrawNlWkWNW+I3XU45WoAZjmbGJ/YYArX1ndT5LtnJ6dAvLU
         +bBtbjWcpDfE06VesJqqinmkKBvhvKFmXp4p8JdH/3sKQHCodj02Pbg5V6mZ1SutJJyw
         fAJuHiKBkxc1vq4ipkeRlk9qVH0qHhhzsNAWFwQezAjv4wx/597xMTtmxfA1Ux+ccuPM
         yIhjZyXlJ9K1yxQgJBvGAgKHMWU8VouNZ84EjJyV7sTZD6VQhqwVo1QVmLqNCfPi8DLR
         KRmIptu3EkKdrSdggq2x8/sdWS52uMNDTSH0qxPcc0OU2gAiIq06/vinsGPkWZpPgSOC
         QujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816070; x=1698420870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V84nzu//9Ccx1eMGnmV3Yd2nV/swh6SKrL0rqKbIxJY=;
        b=FU++UduCIJIJN8qzWk5do1UQJT9tgglDgrCWZu5b/JCmc5i+PRO/Ia0pJnOIUpSHaF
         HQNiUCqjAKD70tJQ6wm8xPih4xpCBm3EolBek5uL5rjbfVMdUXgK06cj7vXVm4yIhY2W
         SrJ3rR2qvcUVs7kgASkoogDfO6etPEzc0V03uq2mlwxpI1HoQ5aiEOA2Djuqo6wsYlhR
         zxlJEiZ41bRs6idAuS0pbPO2GNExg30/hsBEdrnbKFvwCnKACghpxyaGgWtZw39jh3dk
         JMQ1jOAxRpuH7JKa3zyQjC/zv7t3m/vkLoxciNj0+cDL2JRebKp//2CyOjV0rHGlq8ry
         bSBw==
X-Gm-Message-State: AOJu0YzXQAf0gy6Qo6pmnq06TnACLhDmyXdq+GE8l4bfY99cdSyEchnT
        upx5hm2oVW3dpnbzGYDuCX+WqC4944+y5WE1qnUS3w==
X-Google-Smtp-Source: AGHT+IE4AmkczySvssaZLBoqaDR6DLJEyO82ucexzFqv5S6VyCKkYLRm7Z+wA7GdZpfQZh0uzq46vH0BJ0c5Cq0hpAg=
X-Received: by 2002:a05:6e02:1547:b0:352:5ff6:5484 with SMTP id
 j7-20020a056e02154700b003525ff65484mr2576435ilu.28.1697816069731; Fri, 20 Oct
 2023 08:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us> <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us> <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
 <87o7gtpdb4.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87o7gtpdb4.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 20 Oct 2023 21:04:18 +0530
Message-ID: <CAK9=C2WVkbDtz9uZTNjEcJzKQ44cHLR=+nSVZZmSptzL_U4NNA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 8:10=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> Thanks for the quick reply!
> >>
> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>
> >> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn=
@kernel.org> wrote:
> >> >>
> >> >> Hi Anup,
> >> >>
> >> >> Anup Patel <apatel@ventanamicro.com> writes:
> >> >>
> >> >> > The RISC-V AIA specification is ratified as-per the RISC-V intern=
ational
> >> >> > process. The latest ratified AIA specifcation can be found at:
> >> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-in=
terrupts-1.0.pdf
> >> >> >
> >> >> > At a high-level, the AIA specification adds three things:
> >> >> > 1) AIA CSRs
> >> >> >    - Improved local interrupt support
> >> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >> >> >    - Per-HART MSI controller
> >> >> >    - Support MSI virtualization
> >> >> >    - Support IPI along with virtualization
> >> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >> >> >    - Wired interrupt controller
> >> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI ge=
nerator)
> >> >> >    - In Direct-mode, injects external interrupts directly into HA=
RTs
> >> >>
> >> >> Thanks for working on the AIA support! I had a look at the series, =
and
> >> >> have some concerns about interrupt ID abstraction.
> >> >>
> >> >> A bit of background, for readers not familiar with the AIA details.
> >> >>
> >> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
> >> >> each MSI is dedicated to a certain hart. The series takes the appro=
ach
> >> >> to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
> >> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
> >> >> slice only *one* msi-irq is acutally used.
> >> >>
> >> >> This scheme makes affinity changes more robust, because the interru=
pt
> >> >> sources on "other" harts are pre-allocated. On the other hand it
> >> >> requires to propagate irq masking to other harts via IPIs (this is
> >> >> mostly done up setup/tear down). It's also wasteful, because msi-ir=
qs
> >> >> are hogged, and cannot be used.
> >> >>
> >> >> Contemporary storage/networking drivers usually uses queues per cor=
e
> >> >> (or a sub-set of cores). The current scheme wastes a lot of msi-irq=
s.
> >> >> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instead=
 of
> >> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there woul=
d be
> >> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
> >> >> would like to use 5 queues (5 cores) on a 128 core system, the curr=
ent
> >> >> scheme would consume 5 * 128 MSIs, instead of just 5.
> >> >>
> >> >> On the plus side:
> >> >> * Changing interrupts affinity will never fail, because the interru=
pts
> >> >>   on each hart is pre-allocated.
> >> >>
> >> >> On the negative side:
> >> >> * Wasteful interrupt usage, and a system can potientially "run out"=
 of
> >> >>   interrupts. Especially for many core systems.
> >> >> * Interrupt masking need to proagate to harts via IPIs (there's no
> >> >>   broadcast csr in IMSIC), and a more complex locking scheme IMSIC
> >> >>
> >> >> Summary:
> >> >> The current series caps the number of global interrupts to maximum
> >> >> 2047 MSIs for all cores (whole system). A better scheme, IMO, would=
 be
> >> >> to expose 2047 * #harts unique MSIs.
> >> >>
> >> >> I think this could simplify/remove(?) the locking as well.
> >> >
> >> > Exposing 2047 * #harts unique MSIs has multiple issues:
> >> > 1) The irq_set_affinity() does not work for MSIs because each
> >> >      IRQ is not tied to a particular HART. This means we can't
> >> >      balance the IRQ processing load among HARTs.
> >>
> >> Yes, you can balance. In your code, each *active* MSI is still
> >> bound/active to a specific hard together with the affinity mask. In an
> >> 1-1 model you would still need to track the affinity mask, but the
> >> irq_set_affinity() would be different. It would try to allocate a new
> >> MSI from the target CPU, and then switch to having that MSI active.
> >>
> >> That's what x86 does AFAIU, which is also constrained by the # of
> >> available MSIs.
> >>
> >> The downside, as I pointed out, is that the set affinity action can
> >> fail for a certain target CPU.
> >
> > Yes, irq_set_affinity() can fail for the suggested approach plus for
> > RISC-V AIA, one HART does not have access to other HARTs
> > MSI enable/disable bits so the approach will also involve IPI.
>
> Correct, but the current series does a broadcast to all cores, where the
> 1-1 approach is at most an IPI to a single core.
>
> 128+c machines are getting more common, and you have devices that you
> bring up/down on a per-core basis. Broadcasting IPIs to all cores, when
> dealing with a per-core activity is a pretty noisy neighbor.

Broadcast IPI in the current approach is only done upon MSI mask/unmask
operation. It is not done upon set_affinity() of interrupt handling.

>
> This could be fixed in the existing 1-n approach, by not require to sync
> the cores that are not handling the MSI in question. "Lazy disable"

Incorrect. The approach you are suggesting involves an IPI upon every
irq_set_affinity(). This is because a HART can only enable it's own
MSI ID so when an IRQ is moved to from HART A to HART B with
a different ID X on HART B then we will need an IPI in irq_set_affinit()
to enable ID X on HART B.

>
> >> > 2) All wired IRQs for APLIC MSI-mode will also target a
> >> >     fixed HART hence irq_set_affinity() won't work for wired
> >> >     IRQs as well.
> >>
> >> I'm not following here. Why would APLIC put a constraint here? I had a
> >> look at the specs, and I didn't see anything supporting the current
> >> scheme explicitly.
> >
> > Lets say the number of APLIC wired interrupts  are greater than the
> > number of per-CPU IMSIC IDs. In this case, if all wired interrupts are
> > moved to a particular CPU then irq_set_affinity() will fail for some of
> > the wired interrupts.
>
> Right, it's the case of "full remote CPU" again. Thanks for clearing
> that up.
>
> >> > The idea of treating per-HART MSIs as separate IRQs has
> >> > been discussed in the past.
> >>
> >> Aha! I tried to look for it in lore, but didn't find any. Could you
> >> point me to those discussions?
> >
> > This was done 2 years back in the AIA TG meeting when we were
> > doing the PoC for AIA spec.
>
> Ah, too bad. Thanks regardless.
>
> >> My concern is interrupts become a scarce resource with this
> >> implementation, but maybe my view is incorrect. I've seen bare-metal
> >> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts, but maybe
> >> that is considered "a lot of interrupts".
> >>
> >> As long as we don't get into scenarios where we're running out of
> >> interrupts, due to the software design.
> >>
> >
> > The current approach is simpler and ensures irq_set_affinity
> > always works. The limit of max 2047 IDs is sufficient for many
> > systems (if not all).
>
> Let me give you another view. On a 128c system each core has ~16 unique
> interrupts for disposal. E.g. the Intel E800 NIC has more than 2048
> network queue pairs for each PF.

Clearly, this example is a hypothetical and represents a poorly
designed platform.

Having just 16 IDs per-Core is a very poor design choice. In fact, the
Server SoC spec mandates a minimum 255 IDs.

Regarding NICs which support a large number of queues, the driver
will typically enable only one queue per-core and set the affinity to
separate cores. We have user-space data plane applications based
on DPDK which are capable of using a large number of NIC queues
but these applications are polling based and don't use MSIs.

>
> > When we encounter a system requiring a large number of MSIs,
> > we can either:
> > 1) Extend the AIA spec to support greater than 2047 IDs
> > 2) Re-think the approach in the IMSIC driver
> >
> > The choice between #1 and #2 above depends on the
> > guarantees we want for irq_set_affinity().
>
> The irq_set_affinity() behavior is better with this series, but I think
> the other downsides: number of available interrupt sources, and IPI
> broadcast are worse.

The IPI overhead in the approach you are suggesting will be
even bad compared to the IPI overhead of the current approach
because we will end-up doing IPI upon every irq_set_affinity()
in the suggested approach compared to doing IPI upon every
mask/unmask in the current approach.

The biggest advantage of the current approach is a reliable
irq_set_affinity() which is a very valuable thing to have.

ARM systems easily support a large number of LPIs per-core.
For example, GIC-700 supports 56000 LPIs per-core.
(Refer, https://developer.arm.com/documentation/101516/0300/About-the-GIC-7=
00/Features)

In the RISC-V world, we can easily define a small fast track
extension based on S*csrind extension which can allow a
large number of IMSIC IDs per-core.

Instead of addressing problems on a hypothetical system,
I suggest we go ahead with the current approach and deal
with a system having MSI over-subscription when such a
system shows up.

Regards,
Anup
