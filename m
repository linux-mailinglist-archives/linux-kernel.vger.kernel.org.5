Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51FF755EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGQJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:05:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809EB10DA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:05:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so3358460a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689584712; x=1692176712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuPXKA6AKfKX3YXn9maEPWetHix9gCWYuJrvbb06Blg=;
        b=WVtMTNUo4uD9qbMpoAU5Lo+ezwnCjtT8U83mdbovGMIIA4mYGHNtYL1P6g9LZEB1n4
         yhNdSNKV1wbT+7LcO8gchTW3+3Y7PwRDfs8/cmccRp18uyEFftIzbtTWhCOSlByvzeZA
         igomZP6Wpt7h0J0fNx4Ik1Oz2QhJ6Dc24W7giA8bxOxYc7J+kqHWLoacDbSIx8zmNuTJ
         KSqJzTbIS17aZ1kpB9beuVtYAUaN8cwlR5609A8FzKyPoZJfpLUUBDpOIWaHM6gwP8V+
         jwAImUwaVkL2SFWkK+Sq2UVbrJXSODv7nnSuKEEGpWXaX7m2ZtWajdh9J8OuABxFZHnq
         4j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584712; x=1692176712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuPXKA6AKfKX3YXn9maEPWetHix9gCWYuJrvbb06Blg=;
        b=TaFZIFVOdta2qUn8c0JxXo7j106CVshBssonMzDU+YwFkyxiA9PBfcIDVoBk3vS5FE
         srrm3CSaUR70ctn3o0G80tzDznIJ+4H1Wyyfzmn9UbIk+qwzY9vq2CjWokuCR0s0BLIi
         HzH8+yK05b/GWUmiIOWv1XygL4zlcrvHJqf7n1DE4y+SAh7E3gf7ZBK5H0y2cyMyvrav
         HuXuAgjn5926VaTdtFwopB1RPApg3mIFFmHKzuBabUHShXzuhS9jG6emHhPvroZo7NFb
         8kcQ0Ddio4b3MSqNxIxKi/SHtx8PQm2fyKrQvdrWfJbjeQQxAu1mFSNveJ6cuMIXnyYf
         YXHQ==
X-Gm-Message-State: ABy/qLabbHBCZJPLrm1otXC0WsFiVLsmxxYuYyWjyAu+Geq+fUvUpGAL
        nFL5RHaFxROtbr1O9pbL8O+qp1RpEy0fQq/MrgeqqA==
X-Google-Smtp-Source: APBJJlHc5pV9rE3rVLksz1FoZLlcAuVrhcbeli390I0O/bDMG1j6KHtCAMQ1kxztii+dr63j97xIWatQe3qUUkE6t4k=
X-Received: by 2002:a17:90a:7441:b0:262:fa59:2908 with SMTP id
 o1-20020a17090a744100b00262fa592908mr12186094pjk.1.1689584711797; Mon, 17 Jul
 2023 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-8-apatel@ventanamicro.com> <CAGETcx8kH8cJVdhcv5K4qNUo58godFZEBnOfTGKUUQ6VuUguvQ@mail.gmail.com>
 <86jzv2vpdb.wl-maz@kernel.org> <CAK9=C2ULxsXednwnoyzYKjQFpe_zBSZ4v0FqUYFnxK2TpbiMtg@mail.gmail.com>
 <86cz0uvcof.wl-maz@kernel.org> <CAAhSdy2sAaA_dmVCt9162kpw8-Ub1wjH_MNKxPOFN_VbW7M7vQ@mail.gmail.com>
 <868rbfufn2.wl-maz@kernel.org>
In-Reply-To: <868rbfufn2.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 17 Jul 2023 14:35:01 +0530
Message-ID: <CAK9=C2UmU_Kvj6x_ZRJ70DAtdpehN9XQ6pdzFJ7-NLA_+XPyZQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Saravana Kannan <saravanak@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 1:35=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 14 Jul 2023 15:05:07 +0100,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 7:05=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On Fri, 14 Jul 2023 10:35:34 +0100,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > On Fri, Jul 14, 2023 at 2:31=E2=80=AFPM Marc Zyngier <maz@kernel.or=
g> wrote:
> > > > >
> > > > > Anup,
> > > > >
> > > > > On Fri, 14 Jul 2023 00:56:22 +0100,
> > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 10, 2023 at 2:44=E2=80=AFAM Anup Patel <apatel@vent=
anamicro.com> wrote:
> > > > > > >
> > > > > > > The RISC-V advanced interrupt architecture (AIA) specificatio=
n defines
> > > > > > > a new interrupt controller for managing wired interrupts on a=
 RISC-V
> > > > > > > platform. This new interrupt controller is referred to as adv=
anced
> > > > > > > platform-level interrupt controller (APLIC) which can forward=
 wired
> > > > > > > interrupts to CPUs (or HARTs) as local interrupts OR as messa=
ge
> > > > > > > signaled interrupts.
> > > > > > > (For more details refer https://github.com/riscv/riscv-aia)
> > > > > > >
> > > > > > > This patch adds an irqchip driver for RISC-V APLIC found on R=
ISC-V
> > > > > > > platforms.
> > > > > > >
> > > > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > >
> > > > > [...]
> > > > >
> > > > > > > +static int __init aplic_dt_init(struct device_node *node,
> > > > > > > +                               struct device_node *parent)
> > > > > > > +{
> > > > > > > +       /*
> > > > > > > +        * The APLIC platform driver needs to be probed early
> > > > > > > +        * so for device tree:
> > > > > > > +        *
> > > > > > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode =
which
> > > > > > > +        *    provides a hint to the device driver core to pr=
obe the
> > > > > > > +        *    platform driver early.
> > > > > > > +        * 2) Clear the OF_POPULATED flag in device_node beca=
use
> > > > > > > +        *    of_irq_init() sets it which prevents creation o=
f
> > > > > > > +        *    platform device.
> > > > > > > +        */
> > > > > > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > > > >
> > > > > > Please stop spamming us with broken patches. Already told you t=
his is
> > > > > > not an option.
> > > > > >
> > > > > > Nack.
> > > > >
> > > > > What puzzles me here is that *no other arch* requires this sort o=
f
> > > > > hack. What is so special about the APLIC that it requires it? I s=
ee
> > > > > nothing in this patch that even hints at it, despite the "discuss=
ion"
> > > > > in the last round.
> > > > >
> > > > > The rules are simple:
> > > > >
> > > > > - either the APLIC is so fundamental to the system that it has to=
 be
> > > > >   initialised super early, much like the GIC on arm64, at which p=
oint
> > > > >   it cannot be a platform device, and the story is pretty simple.
> > > > >
> > > > > - or it isn't that fundamental, and it can be probed as a platfor=
m
> > > > >   device using the dependency infrastructure that is already used=
 by
> > > > >   multiple other interrupt controller drivers, without any need t=
o
> > > > >   mess with internal flags. Again, this should be simple enough.
> > > >
> > > > APLIC manages all wired interrupts whereas IMSIC manages all
> > > > MSIs. Both APLIC and IMSIC are fundamental devices which need
> > > > to be probed super early.
> > > >
> > > > Now APLIC has two modes of operations:
> > > > 1) Direct mode where there is no IMSIC in the system and APLIC
> > > >     directly injects interrupt to CPUs
> > > > 2) MSI mode where IMSIC is present in the system and APLIC
> > > >     converts wired interrupts into MSIs
> > > >
> > > > The APLIC driver added by this patch is a common driver for
> > > > both above modes.
> > >
> > > Which it doesn't need to be. You are pointlessly making life difficul=
t
> > > for yourself, and everyone else. The MSI bridge behaviour has *zero*
> > > reason to be the same driver as the main "I need it super early"
> > > driver. They may be called the same, but they *are* different things
> > > in the system.
> > >
> > > They can share code, but they are fundamentally a different thing in
> > > the system. And I guess this silly approach has other ramifications:
> > > the IMSIC is also some early driver when it really doesn't need to be=
.
> > > Who needs MSIs that early in the life of the system? I don't buy this
> > > for even a second.
> >
> > IMSIC also provides IPIs which are required super early so I think
> > we can't make IMSIC as a platform driver.
>
> Then split this part further. Just because the architecture lumps two
> completely unrelated concepts together doesn't mean we need to follow
> the same organisation.

IPIs are supported as software injected MSIs. Basically, each HART
has its own MSI controller and one HART can inject IPI to other HART
by writing its MSI MMIO register.

>
> >
> > >
> > > Frankly, this whole thing needs to be taken apart and rebuilt from th=
e
> > > ground up.
> > >
> > > > For #2, APLIC needs to be a platform device to create a device
> > > > MSI domain using platform_msi_create_device_domain() which
> > > > is why the APLIC driver is a platform driver.
> > >
> > > You can't have your cake and eat it. If needed super early, and it
> > > cannot be a platform driver. End of the story.
> > >
> > > And to my earlier point: IMSIC and APLIC-as-MSI-bridge have no purpos=
e
> > > being early drivers. They must be platform drivers, and only that.
> >
> > We can have IMSIC and APLIC-Direct-Mode as non-platform driver
> > whereas APLIC-as-MSI-bridge will be a platform driver.
> >
> > Both APLIC-Direct-Mode and APLIC-as-MSI-bridge can share a large
> > part of the current driver.
> >
> > >
> > > > > If these rules don't apply to your stuff, please explain what is =
so
> > > > > different. And I mean actually explain the issue. Which isn't tel=
ling
> > > > > us "it doesn't work without it". Because as things stand, there i=
s no
> > > > > way I will even consider taking this ugly mix of probing methods.
> > > >
> > > > Yes, I don't want this ugly FWNODE_FLAG_BEST_EFFORT hack
> > > > in this driver.
> > >
> > > And yet you are hammering it even when told this is wrong.
> > >
> > > > I tried several things but setting the FWNODE_FLAG_BEST_EFFORT
> > > > flag is the only thing which works right now.
> > >
> > > How about you take a step back and realise that the way you've
> > > architected your drivers makes little sense? I don't think you have
> > > tried *that*.
> >
> > Both APLIC and IMSIC are separate devices as defined by the AIA spec.
> >
> > There are three possible systems:
> > 1) Systems with only APLIC (i.e. only wired interrupts)
> > 2) Systems with only IMSIC (i.e. only MSIs)
>
> How is that possible? Are you saying that even things like timers are
> firing as MSIs?

No, timer interrupts are triggered through INTC.

In a full-blown AIA based system, we have three irqchips:
1) RISC-V INTC (per-HART local interrupts): This irqchip handles
    per-HART local interrupts such as timer, external interrupt, etc.
2) IMSIC (per-HART MSI controller): This is the per-HART MSI
    controller. Whenever an IMSIC of a HART receives MSI, it sets
    the local external interrupt of that HART.
3) APLIC (system-level wired interrupt): This is a system level
    interrupt controller for managing wired interrupt. In direct mode,
    APLIC will set a local external interrupt of that HART whereas
    in MSI mode, APLIC will do a MSI write to one of the per-HART
    IMSIC.

>
> > 3) Systems with both APLIC and IMSIC (i.e. both wired interrupts and MS=
Is)
> >
> > To address the above, APLIC and IMSIC are separate drivers. I am okay
> > with splitting the APLIC driver into two separate drivers .
>
> Again, we don't have to follow the split established by the
> architecture. Instead, we should follow what is *functionally correct*
> for the kernel. If we were to write Risc-V-OS, that'd be an acceptable
> solution. But this is Linux, and the constraints are different.
>
> My take on this discussion is that we should have:
>
> - Direct-mode APLIC + IPI support as a an early irqchip driver
>
> - MSI-bridge APLIC + MSI support as platform driver
>
> Yes, these will likely share most of their code. But at least the
> split will be manageable, and will avoid ugly hacks.

APLIC only manages wired interrupts and does not support IPIs.

For systems with only wired interrupts, APLIC is used in direct mode
and IPI are triggered using SBI calls (firmware calls)

To summarize IPIs and device interrupts, here are the three
combinations:
1) RISC-V systems with only wired interrupts: These systems
    will use APLIC in direct mode for wired interrupts and IPIs
    are injected using SBI calls.
2) RISC-V systems with only MSIs: These systems will use IMSICs
    for handling MSIs and IPIs are injected as software injected MSIs
3) RISC-V systems with both wired interrupts and MSIs: These
    systems use APLIC in MSI-mode for wired interrupts and IMSIC
    for MSIs. The IPIs are injected as software injected MSIs.

Regards,
Anup
