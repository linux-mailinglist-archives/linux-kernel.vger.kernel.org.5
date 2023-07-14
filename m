Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE037536B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjGNJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGNJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:35:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3141727
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:35:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c4dd264359cso1450994276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689327345; x=1691919345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt39Bw/1ICieuy3xPQ3V/nq5k9xeT5GMxbYyADM5Ukk=;
        b=eslUTpMWrNAx2aATLEtT8SRgCHC+OB6UqLIj2Eer+pOjVMfBLWucrB0s3DvfklSfBl
         2V4VfHd7NkbeQgvGYsSfgx9I7wtAQSam18rcFpP0OqWknK0FJBh6B76rdcsFuiOkyZsO
         Wjx1v23ukYT2WqgnpMJx+ho5D8D4W/EmOzn9c3LllJl4v1U4P+p8x/cxUTYf72KhlUqa
         etOO4BTiMJ9g1ZN/96rrcCGWDJhVlTS0gc/Aco6tLHOFXqU9CJO5oSK7w5lTHFCCLF+V
         ge5aFp3/gdoaoDLiH2UJ8kCXvmP1Qa53CQCvBwdRYCPwN0IFlYi6aHG/NvBQ/wzLQkc5
         Makg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327345; x=1691919345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt39Bw/1ICieuy3xPQ3V/nq5k9xeT5GMxbYyADM5Ukk=;
        b=YrC/BZ3N1x+/j2EwHMpEk2QUroiutcpuYn6sUeCWqEZ3vviiWc1yTgY3T5K9vRu0UA
         1NU0RZv7HNbE1nxIQmNM3ALU8y2uSSBlRttwY/xn/XEAZQFt/C3ePhkTrPdfJmbNvcyd
         xRBnftpydVcf2IAfPEg/WhM949pmQxAOb/hdem3J8tWhPy9H6SAkwrDU5fJqRlNpwSME
         HpwZCKymJZqrAodmPQHBJQlkGI99nrlbGig9uiSPpEV6GHy93txQOiYDWX99ZCmBJwX1
         CClFznYwpsb4WtuvBrQ15Eic1vEHjTAfllFit2k7EaFN6rt2E+FcBzCSrNFXFNPg+PZz
         XYzA==
X-Gm-Message-State: ABy/qLYL1zHppwXrbCe4iOpJafYd8Zamez2HX2Ka8Hiajb1itgxwEsCj
        AU6dtewVRIpdXruO4YVxCNl4B5oV/vjPGpr/uBtCyg==
X-Google-Smtp-Source: APBJJlFnjaoGpAtQUN7x4jgU73upuuxFNXMx+nVUkht79U11I0K8h99tqhekeYm3ockpIX5yS0dq10/tiPAkFZJvpVE=
X-Received: by 2002:a81:540a:0:b0:56d:2038:c254 with SMTP id
 i10-20020a81540a000000b0056d2038c254mr4796899ywb.44.1689327345450; Fri, 14
 Jul 2023 02:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-8-apatel@ventanamicro.com> <CAGETcx8kH8cJVdhcv5K4qNUo58godFZEBnOfTGKUUQ6VuUguvQ@mail.gmail.com>
 <86jzv2vpdb.wl-maz@kernel.org>
In-Reply-To: <86jzv2vpdb.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 14 Jul 2023 15:05:34 +0530
Message-ID: <CAK9=C2ULxsXednwnoyzYKjQFpe_zBSZ4v0FqUYFnxK2TpbiMtg@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 2:31=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Anup,
>
> On Fri, 14 Jul 2023 00:56:22 +0100,
> Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 2:44=E2=80=AFAM Anup Patel <apatel@ventanamicro=
.com> wrote:
> > >
> > > The RISC-V advanced interrupt architecture (AIA) specification define=
s
> > > a new interrupt controller for managing wired interrupts on a RISC-V
> > > platform. This new interrupt controller is referred to as advanced
> > > platform-level interrupt controller (APLIC) which can forward wired
> > > interrupts to CPUs (or HARTs) as local interrupts OR as message
> > > signaled interrupts.
> > > (For more details refer https://github.com/riscv/riscv-aia)
> > >
> > > This patch adds an irqchip driver for RISC-V APLIC found on RISC-V
> > > platforms.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> [...]
>
> > > +static int __init aplic_dt_init(struct device_node *node,
> > > +                               struct device_node *parent)
> > > +{
> > > +       /*
> > > +        * The APLIC platform driver needs to be probed early
> > > +        * so for device tree:
> > > +        *
> > > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
> > > +        *    provides a hint to the device driver core to probe the
> > > +        *    platform driver early.
> > > +        * 2) Clear the OF_POPULATED flag in device_node because
> > > +        *    of_irq_init() sets it which prevents creation of
> > > +        *    platform device.
> > > +        */
> > > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> >
> > Please stop spamming us with broken patches. Already told you this is
> > not an option.
> >
> > Nack.
>
> What puzzles me here is that *no other arch* requires this sort of
> hack. What is so special about the APLIC that it requires it? I see
> nothing in this patch that even hints at it, despite the "discussion"
> in the last round.
>
> The rules are simple:
>
> - either the APLIC is so fundamental to the system that it has to be
>   initialised super early, much like the GIC on arm64, at which point
>   it cannot be a platform device, and the story is pretty simple.
>
> - or it isn't that fundamental, and it can be probed as a platform
>   device using the dependency infrastructure that is already used by
>   multiple other interrupt controller drivers, without any need to
>   mess with internal flags. Again, this should be simple enough.

APLIC manages all wired interrupts whereas IMSIC manages all
MSIs. Both APLIC and IMSIC are fundamental devices which need
to be probed super early.

Now APLIC has two modes of operations:
1) Direct mode where there is no IMSIC in the system and APLIC
    directly injects interrupt to CPUs
2) MSI mode where IMSIC is present in the system and APLIC
    converts wired interrupts into MSIs

The APLIC driver added by this patch is a common driver for
both above modes.

For #2, APLIC needs to be a platform device to create a device
MSI domain using platform_msi_create_device_domain() which
is why the APLIC driver is a platform driver.

>
> If these rules don't apply to your stuff, please explain what is so
> different. And I mean actually explain the issue. Which isn't telling
> us "it doesn't work without it". Because as things stand, there is no
> way I will even consider taking this ugly mix of probing methods.

Yes, I don't want this ugly FWNODE_FLAG_BEST_EFFORT hack
in this driver.

I tried several things but setting the FWNODE_FLAG_BEST_EFFORT
flag is the only thing which works right now.

>
> In any case, reposting the same stuff ad nauseam is only going to
> result in this series being ignored, which I don't think is what you
> want.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
