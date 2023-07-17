Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C2755F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGQJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGQJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:38:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6677930C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:36:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b2b60731so22276375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689586598; x=1692178598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVwbeKFI1ZAtbn024A7ZszekCSOqYIkVGAQ3AmevuV8=;
        b=hmUL8AgTOU3B+5FiwZrMnBNCzBv8Ey4kZNQTRqaoq1X5YJFRqQ3evooKM/PEOhV22b
         dBswTNdWwpv5QU1VeCZqFeR1OSAV4u3aI7K8LlALHtrfJLNtjwp/jw6Z4Yxtw86/rxy6
         zEwdoWWHQVpTijv81iWqP+UOnYSFYgzY7uOottk8c9dPG33llSNHNZgPWAMJFWFOB7n1
         xErIxoWWW+yz/xtD5NxsX+jPOM6LvxAuqsELQNplWnIcikz1/itvR/754rSUhGVsqxZ6
         HmM9kIQROwnhp2TmtDx8T4hhcuyYdGP7hVu0wMf98zBcI8x6nZP7cbxFa+CyhAWSuJKJ
         jQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586598; x=1692178598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVwbeKFI1ZAtbn024A7ZszekCSOqYIkVGAQ3AmevuV8=;
        b=FqoTeYMkDVQVUj7gB5XgG9fRJ8drllTFm+q1ebyGL9Y70fLMWvBc89tMD87zoapBNp
         8W6W+mD5jkCAg2KCDmMJN+48N0IPQSAVy96fmezekrHiqU/OmHgai58nCuukkwqLbbCU
         7mARQhbw5A/wfyBJgIftenih2D8nUaqUCo9JwggMQSHi4NvvAVnW2jmnh2FR1y8xD96b
         lwbv+LDfo9uUQCon3bGinG6G9ymSF4POHuLcgoJe8iA/YlpLPFieQWQG6z7dUnHK86LV
         e5nEmdOXDcLtYsfDdwxLaM2J9CYWbTIQaqU+Sogd2xQ6W2Q5kBXjfkDkQ+zzkeZu2jYf
         y8EA==
X-Gm-Message-State: ABy/qLaJTOj6WUN9Uh6VcLabq0FGieBfQ3QqXNqJeiy870BsrAzrR5N/
        TDeokIW9NNOvg55rMmcp5N1dJfC4F74dBEp17bx3vQ==
X-Google-Smtp-Source: APBJJlGcuyHTSmm3J+pQhixkvpQD9tqgmEmpQ96JylQBEwdK+bfa0MfsQnDCybSb/h7nPpHvboYizmj+3vbT6DMV4jA=
X-Received: by 2002:a17:90a:ca06:b0:259:a879:cb8f with SMTP id
 x6-20020a17090aca0600b00259a879cb8fmr9575550pjt.7.1689586597595; Mon, 17 Jul
 2023 02:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-8-apatel@ventanamicro.com> <CAGETcx8kH8cJVdhcv5K4qNUo58godFZEBnOfTGKUUQ6VuUguvQ@mail.gmail.com>
 <86jzv2vpdb.wl-maz@kernel.org> <CAK9=C2ULxsXednwnoyzYKjQFpe_zBSZ4v0FqUYFnxK2TpbiMtg@mail.gmail.com>
 <86cz0uvcof.wl-maz@kernel.org> <CAAhSdy2sAaA_dmVCt9162kpw8-Ub1wjH_MNKxPOFN_VbW7M7vQ@mail.gmail.com>
 <868rbfufn2.wl-maz@kernel.org> <CAK9=C2UmU_Kvj6x_ZRJ70DAtdpehN9XQ6pdzFJ7-NLA_+XPyZQ@mail.gmail.com>
In-Reply-To: <CAK9=C2UmU_Kvj6x_ZRJ70DAtdpehN9XQ6pdzFJ7-NLA_+XPyZQ@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 17 Jul 2023 15:06:27 +0530
Message-ID: <CAK9=C2VzUzmjYkMFd6eYgWh_KyD1bp+7XCKqw4uGQYP5hjicvg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 2:35=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Mon, Jul 17, 2023 at 1:35=E2=80=AFPM Marc Zyngier <maz@kernel.org> wro=
te:
> >
> > On Fri, 14 Jul 2023 15:05:07 +0100,
> > Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Fri, Jul 14, 2023 at 7:05=E2=80=AFPM Marc Zyngier <maz@kernel.org>=
 wrote:
> > > >
> > > > On Fri, 14 Jul 2023 10:35:34 +0100,
> > > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > > >
> > > > > On Fri, Jul 14, 2023 at 2:31=E2=80=AFPM Marc Zyngier <maz@kernel.=
org> wrote:
> > > > > >
> > > > > > Anup,
> > > > > >
> > > > > > On Fri, 14 Jul 2023 00:56:22 +0100,
> > > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 10, 2023 at 2:44=E2=80=AFAM Anup Patel <apatel@ve=
ntanamicro.com> wrote:
> > > > > > > >
> > > > > > > > The RISC-V advanced interrupt architecture (AIA) specificat=
ion defines
> > > > > > > > a new interrupt controller for managing wired interrupts on=
 a RISC-V
> > > > > > > > platform. This new interrupt controller is referred to as a=
dvanced
> > > > > > > > platform-level interrupt controller (APLIC) which can forwa=
rd wired
> > > > > > > > interrupts to CPUs (or HARTs) as local interrupts OR as mes=
sage
> > > > > > > > signaled interrupts.
> > > > > > > > (For more details refer https://github.com/riscv/riscv-aia)
> > > > > > > >
> > > > > > > > This patch adds an irqchip driver for RISC-V APLIC found on=
 RISC-V
> > > > > > > > platforms.
> > > > > > > >
> > > > > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > +static int __init aplic_dt_init(struct device_node *node,
> > > > > > > > +                               struct device_node *parent)
> > > > > > > > +{
> > > > > > > > +       /*
> > > > > > > > +        * The APLIC platform driver needs to be probed ear=
ly
> > > > > > > > +        * so for device tree:
> > > > > > > > +        *
> > > > > > > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnod=
e which
> > > > > > > > +        *    provides a hint to the device driver core to =
probe the
> > > > > > > > +        *    platform driver early.
> > > > > > > > +        * 2) Clear the OF_POPULATED flag in device_node be=
cause
> > > > > > > > +        *    of_irq_init() sets it which prevents creation=
 of
> > > > > > > > +        *    platform device.
> > > > > > > > +        */
> > > > > > > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > > > > >
> > > > > > > Please stop spamming us with broken patches. Already told you=
 this is
> > > > > > > not an option.
> > > > > > >
> > > > > > > Nack.
> > > > > >
> > > > > > What puzzles me here is that *no other arch* requires this sort=
 of
> > > > > > hack. What is so special about the APLIC that it requires it? I=
 see
> > > > > > nothing in this patch that even hints at it, despite the "discu=
ssion"
> > > > > > in the last round.
> > > > > >
> > > > > > The rules are simple:
> > > > > >
> > > > > > - either the APLIC is so fundamental to the system that it has =
to be
> > > > > >   initialised super early, much like the GIC on arm64, at which=
 point
> > > > > >   it cannot be a platform device, and the story is pretty simpl=
e.
> > > > > >
> > > > > > - or it isn't that fundamental, and it can be probed as a platf=
orm
> > > > > >   device using the dependency infrastructure that is already us=
ed by
> > > > > >   multiple other interrupt controller drivers, without any need=
 to
> > > > > >   mess with internal flags. Again, this should be simple enough=
.
> > > > >
> > > > > APLIC manages all wired interrupts whereas IMSIC manages all
> > > > > MSIs. Both APLIC and IMSIC are fundamental devices which need
> > > > > to be probed super early.
> > > > >
> > > > > Now APLIC has two modes of operations:
> > > > > 1) Direct mode where there is no IMSIC in the system and APLIC
> > > > >     directly injects interrupt to CPUs
> > > > > 2) MSI mode where IMSIC is present in the system and APLIC
> > > > >     converts wired interrupts into MSIs
> > > > >
> > > > > The APLIC driver added by this patch is a common driver for
> > > > > both above modes.
> > > >
> > > > Which it doesn't need to be. You are pointlessly making life diffic=
ult
> > > > for yourself, and everyone else. The MSI bridge behaviour has *zero=
*
> > > > reason to be the same driver as the main "I need it super early"
> > > > driver. They may be called the same, but they *are* different thing=
s
> > > > in the system.
> > > >
> > > > They can share code, but they are fundamentally a different thing i=
n
> > > > the system. And I guess this silly approach has other ramifications=
:
> > > > the IMSIC is also some early driver when it really doesn't need to =
be.
> > > > Who needs MSIs that early in the life of the system? I don't buy th=
is
> > > > for even a second.
> > >
> > > IMSIC also provides IPIs which are required super early so I think
> > > we can't make IMSIC as a platform driver.
> >
> > Then split this part further. Just because the architecture lumps two
> > completely unrelated concepts together doesn't mean we need to follow
> > the same organisation.
>
> IPIs are supported as software injected MSIs. Basically, each HART
> has its own MSI controller and one HART can inject IPI to other HART
> by writing its MSI MMIO register.
>
> >
> > >
> > > >
> > > > Frankly, this whole thing needs to be taken apart and rebuilt from =
the
> > > > ground up.
> > > >
> > > > > For #2, APLIC needs to be a platform device to create a device
> > > > > MSI domain using platform_msi_create_device_domain() which
> > > > > is why the APLIC driver is a platform driver.
> > > >
> > > > You can't have your cake and eat it. If needed super early, and it
> > > > cannot be a platform driver. End of the story.
> > > >
> > > > And to my earlier point: IMSIC and APLIC-as-MSI-bridge have no purp=
ose
> > > > being early drivers. They must be platform drivers, and only that.
> > >
> > > We can have IMSIC and APLIC-Direct-Mode as non-platform driver
> > > whereas APLIC-as-MSI-bridge will be a platform driver.
> > >
> > > Both APLIC-Direct-Mode and APLIC-as-MSI-bridge can share a large
> > > part of the current driver.
> > >
> > > >
> > > > > > If these rules don't apply to your stuff, please explain what i=
s so
> > > > > > different. And I mean actually explain the issue. Which isn't t=
elling
> > > > > > us "it doesn't work without it". Because as things stand, there=
 is no
> > > > > > way I will even consider taking this ugly mix of probing method=
s.
> > > > >
> > > > > Yes, I don't want this ugly FWNODE_FLAG_BEST_EFFORT hack
> > > > > in this driver.
> > > >
> > > > And yet you are hammering it even when told this is wrong.
> > > >
> > > > > I tried several things but setting the FWNODE_FLAG_BEST_EFFORT
> > > > > flag is the only thing which works right now.
> > > >
> > > > How about you take a step back and realise that the way you've
> > > > architected your drivers makes little sense? I don't think you have
> > > > tried *that*.
> > >
> > > Both APLIC and IMSIC are separate devices as defined by the AIA spec.
> > >
> > > There are three possible systems:
> > > 1) Systems with only APLIC (i.e. only wired interrupts)
> > > 2) Systems with only IMSIC (i.e. only MSIs)
> >
> > How is that possible? Are you saying that even things like timers are
> > firing as MSIs?
>
> No, timer interrupts are triggered through INTC.
>
> In a full-blown AIA based system, we have three irqchips:
> 1) RISC-V INTC (per-HART local interrupts): This irqchip handles
>     per-HART local interrupts such as timer, external interrupt, etc.
> 2) IMSIC (per-HART MSI controller): This is the per-HART MSI
>     controller. Whenever an IMSIC of a HART receives MSI, it sets
>     the local external interrupt of that HART.
> 3) APLIC (system-level wired interrupt): This is a system level
>     interrupt controller for managing wired interrupt. In direct mode,
>     APLIC will set a local external interrupt of that HART whereas
>     in MSI mode, APLIC will do a MSI write to one of the per-HART
>     IMSIC.
>
> >
> > > 3) Systems with both APLIC and IMSIC (i.e. both wired interrupts and =
MSIs)
> > >
> > > To address the above, APLIC and IMSIC are separate drivers. I am okay
> > > with splitting the APLIC driver into two separate drivers .
> >
> > Again, we don't have to follow the split established by the
> > architecture. Instead, we should follow what is *functionally correct*
> > for the kernel. If we were to write Risc-V-OS, that'd be an acceptable
> > solution. But this is Linux, and the constraints are different.
> >
> > My take on this discussion is that we should have:
> >
> > - Direct-mode APLIC + IPI support as a an early irqchip driver
> >
> > - MSI-bridge APLIC + MSI support as platform driver
> >
> > Yes, these will likely share most of their code. But at least the
> > split will be manageable, and will avoid ugly hacks.
>
> APLIC only manages wired interrupts and does not support IPIs.
>
> For systems with only wired interrupts, APLIC is used in direct mode
> and IPI are triggered using SBI calls (firmware calls)
>
> To summarize IPIs and device interrupts, here are the three
> combinations:
> 1) RISC-V systems with only wired interrupts: These systems
>     will use APLIC in direct mode for wired interrupts and IPIs
>     are injected using SBI calls.
> 2) RISC-V systems with only MSIs: These systems will use IMSICs
>     for handling MSIs and IPIs are injected as software injected MSIs
> 3) RISC-V systems with both wired interrupts and MSIs: These
>     systems use APLIC in MSI-mode for wired interrupts and IMSIC
>     for MSIs. The IPIs are injected as software injected MSIs.
>

I have created two ascii diagrams which might help understand
the RISC-V AIA.

             Systems with only wired interrupts
             ----------------------------------

----------
|  HART0 |
|        |
|  timer |
|    |   |
|    v   |
| ------ |
| |INTC|<-----------------------\
| ------ |                      |
----------                      |
     .                      ---------
     .                      |       |<------
     .                      | APLIC |<------ Device Wired Interrupts
     .                      |       |<------
     .                      ---------
----------                      |
|  HARTN |                      |
|        |                      |
|  timer |                      |
|    |   |                      |
|    v   |                      |
| ------ |                      |
| |INTC|<-----------------------/
| ------ |
----------



             Systems with wired interrupts and MSIs
             --------------------------------------


----------      /------------------- Device MSIs
|  HART0 |      |
|        |      |
|  timer |      |
|    |   |      |
|    v   |      v
| ------ |  ---------
| |INTC|<---| IMSIC |<----------\
| ------ |  ---------           |
----------                      |
     .                      ---------
     .                      |       |<------
     .                      | APLIC |<------ Device Wired Interrupts
     .                      |       |<------
     .                      ---------
----------                      |
|  HARTN |                      |
|        |                      |
|  timer |                      |
|    |   |                      |
|    v   |                      |
| ------ |  ---------           |
| |INTC|<---| IMSIC |<----------/
| ------ |  ---------
----------      ^
                |
                \------------------- Device MSIs



As shown in the figures, we are dealing with three different irqchip.

The INTC is inside the HART whereas we have one IMSIC next
to each HART. The APLIC is a system-level irqchip.

Furthermore, AIA is a modular specification so platforms might
implement only APLIC or only IMSICs or both APLIC+IMSIC.

Regards,
Anup
