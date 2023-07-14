Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F20753C79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjGNOFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjGNOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:05:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A8269D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:05:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso3314880e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1689343518; x=1691935518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnFTCmfQr51Jyi3FZr0J8MFBJPMMvcfdmJ7yH61hf14=;
        b=NpgncndOWMiRR8Xyml8UoEY1xzREMaqFk6QiyYloSb5x6ozVoS1i4YFMkBiWcERulW
         CadO6Ij+N310y5vrkesaZ6tl6T1Fz7F5oo+XTtkocuAI0QTCISMoteiXsdUdKBwIBCqg
         6PDiAayVs2G/7MzXv6OnGG7u27l4Dx9v2dZm1sRTK3YRjDOCaovkEIVtNu2W1ulxZ+2S
         CR7kRszFBFq72utvKF16frB9IgQnWfk84FQsK0alxT2lmo9lUUD1Oo8gFCRZpCZN7+om
         Af8mcFXOm+BMxU7HPEASSRQJcwdJt1cUNsn0OTzfl7cjytcsOqjKW+n44Y/X0QgOTkIi
         fE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343518; x=1691935518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnFTCmfQr51Jyi3FZr0J8MFBJPMMvcfdmJ7yH61hf14=;
        b=kUmVijvShaX660qXH6q/3cQgWNFQmlpUeZV8Qi7vrQEbVwlr4k7GAxrJ+Ady10YuvQ
         50m8FgfHaqF6T4S34GAi9vyRFU5/xBsqAs51Z9iImvRTuHe3cr4UTw2hjsHEU1NKO6Fc
         fcBLjfwl7UgKBVaJkx3/n4/+u88GYJgklhPiJCtEudkM8pWCzNCNOILVy+d9Qhj28fAa
         17kPontIfpS6nIeFwWLEsmzwThA45hQ7jB88DKakzPolkzeb0XGgBQvvhh0Qu7kW/jpR
         sV9gTGk2mPA8J0UJ8iFWG+ZsS1NNKIQUncTVxw5+D1Wv9t8/HkOIeojXlpoxRrDBGqqj
         FCZQ==
X-Gm-Message-State: ABy/qLaSV436ZIWYrfP2oQOeGrQnHUp1NbXP8X12Khdj+mCglp0kWrf8
        PSkvblRIwqUF52b9kCVqvzGueDzNapouOlXsapwUqw==
X-Google-Smtp-Source: APBJJlHpiApDHfRtmrkPWenZ82kudEb1Dy7+1/rcFajH80YzpIcFj6SCENrVeYhu0lDwrFpyjLGg/WUEpyGXT3oMhhQ=
X-Received: by 2002:a05:6512:340b:b0:4fb:9f24:bba9 with SMTP id
 i11-20020a056512340b00b004fb9f24bba9mr4627841lfr.5.1689343518371; Fri, 14 Jul
 2023 07:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-8-apatel@ventanamicro.com> <CAGETcx8kH8cJVdhcv5K4qNUo58godFZEBnOfTGKUUQ6VuUguvQ@mail.gmail.com>
 <86jzv2vpdb.wl-maz@kernel.org> <CAK9=C2ULxsXednwnoyzYKjQFpe_zBSZ4v0FqUYFnxK2TpbiMtg@mail.gmail.com>
 <86cz0uvcof.wl-maz@kernel.org>
In-Reply-To: <86cz0uvcof.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 14 Jul 2023 19:35:07 +0530
Message-ID: <CAAhSdy2sAaA_dmVCt9162kpw8-Ub1wjH_MNKxPOFN_VbW7M7vQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 7:05=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 14 Jul 2023 10:35:34 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Fri, Jul 14, 2023 at 2:31=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > Anup,
> > >
> > > On Fri, 14 Jul 2023 00:56:22 +0100,
> > > Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Mon, Jul 10, 2023 at 2:44=E2=80=AFAM Anup Patel <apatel@ventanam=
icro.com> wrote:
> > > > >
> > > > > The RISC-V advanced interrupt architecture (AIA) specification de=
fines
> > > > > a new interrupt controller for managing wired interrupts on a RIS=
C-V
> > > > > platform. This new interrupt controller is referred to as advance=
d
> > > > > platform-level interrupt controller (APLIC) which can forward wir=
ed
> > > > > interrupts to CPUs (or HARTs) as local interrupts OR as message
> > > > > signaled interrupts.
> > > > > (For more details refer https://github.com/riscv/riscv-aia)
> > > > >
> > > > > This patch adds an irqchip driver for RISC-V APLIC found on RISC-=
V
> > > > > platforms.
> > > > >
> > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >
> > > [...]
> > >
> > > > > +static int __init aplic_dt_init(struct device_node *node,
> > > > > +                               struct device_node *parent)
> > > > > +{
> > > > > +       /*
> > > > > +        * The APLIC platform driver needs to be probed early
> > > > > +        * so for device tree:
> > > > > +        *
> > > > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode whic=
h
> > > > > +        *    provides a hint to the device driver core to probe =
the
> > > > > +        *    platform driver early.
> > > > > +        * 2) Clear the OF_POPULATED flag in device_node because
> > > > > +        *    of_irq_init() sets it which prevents creation of
> > > > > +        *    platform device.
> > > > > +        */
> > > > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > >
> > > > Please stop spamming us with broken patches. Already told you this =
is
> > > > not an option.
> > > >
> > > > Nack.
> > >
> > > What puzzles me here is that *no other arch* requires this sort of
> > > hack. What is so special about the APLIC that it requires it? I see
> > > nothing in this patch that even hints at it, despite the "discussion"
> > > in the last round.
> > >
> > > The rules are simple:
> > >
> > > - either the APLIC is so fundamental to the system that it has to be
> > >   initialised super early, much like the GIC on arm64, at which point
> > >   it cannot be a platform device, and the story is pretty simple.
> > >
> > > - or it isn't that fundamental, and it can be probed as a platform
> > >   device using the dependency infrastructure that is already used by
> > >   multiple other interrupt controller drivers, without any need to
> > >   mess with internal flags. Again, this should be simple enough.
> >
> > APLIC manages all wired interrupts whereas IMSIC manages all
> > MSIs. Both APLIC and IMSIC are fundamental devices which need
> > to be probed super early.
> >
> > Now APLIC has two modes of operations:
> > 1) Direct mode where there is no IMSIC in the system and APLIC
> >     directly injects interrupt to CPUs
> > 2) MSI mode where IMSIC is present in the system and APLIC
> >     converts wired interrupts into MSIs
> >
> > The APLIC driver added by this patch is a common driver for
> > both above modes.
>
> Which it doesn't need to be. You are pointlessly making life difficult
> for yourself, and everyone else. The MSI bridge behaviour has *zero*
> reason to be the same driver as the main "I need it super early"
> driver. They may be called the same, but they *are* different things
> in the system.
>
> They can share code, but they are fundamentally a different thing in
> the system. And I guess this silly approach has other ramifications:
> the IMSIC is also some early driver when it really doesn't need to be.
> Who needs MSIs that early in the life of the system? I don't buy this
> for even a second.

IMSIC also provides IPIs which are required super early so I think
we can't make IMSIC as a platform driver.

>
> Frankly, this whole thing needs to be taken apart and rebuilt from the
> ground up.
>
> > For #2, APLIC needs to be a platform device to create a device
> > MSI domain using platform_msi_create_device_domain() which
> > is why the APLIC driver is a platform driver.
>
> You can't have your cake and eat it. If needed super early, and it
> cannot be a platform driver. End of the story.
>
> And to my earlier point: IMSIC and APLIC-as-MSI-bridge have no purpose
> being early drivers. They must be platform drivers, and only that.

We can have IMSIC and APLIC-Direct-Mode as non-platform driver
whereas APLIC-as-MSI-bridge will be a platform driver.

Both APLIC-Direct-Mode and APLIC-as-MSI-bridge can share a large
part of the current driver.

>
> > > If these rules don't apply to your stuff, please explain what is so
> > > different. And I mean actually explain the issue. Which isn't telling
> > > us "it doesn't work without it". Because as things stand, there is no
> > > way I will even consider taking this ugly mix of probing methods.
> >
> > Yes, I don't want this ugly FWNODE_FLAG_BEST_EFFORT hack
> > in this driver.
>
> And yet you are hammering it even when told this is wrong.
>
> > I tried several things but setting the FWNODE_FLAG_BEST_EFFORT
> > flag is the only thing which works right now.
>
> How about you take a step back and realise that the way you've
> architected your drivers makes little sense? I don't think you have
> tried *that*.

Both APLIC and IMSIC are separate devices as defined by the AIA spec.

There are three possible systems:
1) Systems with only APLIC (i.e. only wired interrupts)
2) Systems with only IMSIC (i.e. only MSIs)
3) Systems with both APLIC and IMSIC (i.e. both wired interrupts and MSIs)

To address the above, APLIC and IMSIC are separate drivers. I am okay
with splitting the APLIC driver into two separate drivers .

Regards,
Anup
