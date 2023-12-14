Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8F81328F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573427AbjLNOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573415AbjLNOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:09:34 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18282CF;
        Thu, 14 Dec 2023 06:09:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9df0a6560so5617566b6e.2;
        Thu, 14 Dec 2023 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562980; x=1703167780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnDoJ6wVmo9VoXzzMiE8cFoyXSZgzadjzCBeRZFN5gs=;
        b=N6udWIjPR42EV3mF0HsCdZ8AJRJnqFSLT/nbX7a/j9+ZkN3ufzit9LrX7aPiqHKBtQ
         WJoUAFXOu4qFHDIQDpDiwMI0el8EhzrDvSJHareCFvOwrPpf3cAzL2FCDTqWVVDRAo+0
         TgFZLn83b5nRR6NEwi5C8pGhF47EXKsG4AHV9sv3ldEdwCJI+hMz7Fr/6Ug02chfu7i7
         aDbms3ibQ55Uj/xaamrMdOhN2fk5Uk4C4F3/s9fygrtrkk3uFvoWFERj1Npr3uBPndyW
         cskwDfTHRsJvddNY+PhNj9aYCcpt33lYo1sabakK5+gJZ37GRlcAElnCDJXMAsJIM1Oj
         k6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562980; x=1703167780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnDoJ6wVmo9VoXzzMiE8cFoyXSZgzadjzCBeRZFN5gs=;
        b=tThvsQNPO1l80N0E/P5d6aE11z+2ve+N8R9OFOj92nIhXLSArLHbANWeFhAzHSByW4
         xmTooAUwUVv5oFxZryRE+8OCEm7KytAjhS4PMlJPeYvTQmCFkUtX1i4ScOexakWtOHOS
         v0IDd4XviR21zP/WM66+44RCsCPwrqeffxvXnjCg06AYJH7Z0Gq3lqMJQlCKSF9nVI9N
         KF4DE+C9iigot1+1+meThVkwXGhcs2CEneGlu0lcrGiptrtObt5GPx4DcLSHNs4+5vCk
         ZTKqfm76100xd1GIC5aD3otuJAx5bELUZAB+/lAEiURQ6TOWlDaAjuRD3h1ikA/m+IU8
         DlUQ==
X-Gm-Message-State: AOJu0Yxma45T5dvB+YyyQBwq0dyQ47R7Df9JpIAQWPlx1MKxFQIdUhT1
        qlvR4dbnqFJQDToP04vrcxEIDmJ13szEsFJvSnI=
X-Google-Smtp-Source: AGHT+IGPp77OIeq0HPwK1G1mRuXPVT/TNiXRQRsdPVwq0HzCh+/6goRnf27mZqKmRhoHC4FS1baWhsKabTH7NXn1ZHo=
X-Received: by 2002:a05:6808:f91:b0:3b9:e654:9010 with SMTP id
 o17-20020a0568080f9100b003b9e6549010mr10465714oiw.34.1702562980290; Thu, 14
 Dec 2023 06:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20231213190528.3751583-1-tmaimon77@gmail.com> <20231213190528.3751583-4-tmaimon77@gmail.com>
 <cf3ce945-2f1c-4dae-86b8-349dae3d962b@app.fastmail.com>
In-Reply-To: <cf3ce945-2f1c-4dae-86b8-349dae3d962b@app.fastmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 14 Dec 2023 16:09:29 +0200
Message-ID: <CAP6Zq1inLOMHORqO8=RbP6NfwJ63kLaH0G3+TKBhfn0p2CE53w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] soc: nuvoton: add NPCM BPC driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     pmenzel@molgen.mpg.de, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>, avifishman70@gmail.com,
        tali.perry1@gmail.com, Joel Stanley <joel@jms.id.au>,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your comments.

On Thu, 14 Dec 2023 at 14:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 13, 2023, at 20:05, Tomer Maimon wrote:
> > Add Nuvoton BMC NPCM BIOS post code (BPC) driver.
> >
> > The NPCM BPC monitoring two configurable I/O address written by the host
> > on the bus.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/soc/nuvoton/Kconfig    |   9 +
> >  drivers/soc/nuvoton/Makefile   |   1 +
> >  drivers/soc/nuvoton/npcm-bpc.c | 387 +++++++++++++++++++++++++++++++++
> >  3 files changed, 397 insertions(+)
> >  create mode 100644 drivers/soc/nuvoton/npcm-bpc.c
>
> I try hard to avoid having user interfaces in drivers/soc/, that
> subsystem should primarily be used for things that don't have an
> existing subsystem in the kernel and are used by other in-kernel
> drivers but don't export hteir own misc device.
>
> > diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
> > index d5102f5f0c28..ebd162633942 100644
> > --- a/drivers/soc/nuvoton/Kconfig
> > +++ b/drivers/soc/nuvoton/Kconfig
> > @@ -2,6 +2,15 @@
> >
> >  menu "NUVOTON SoC drivers"
> >
> > +config NPCM_BPC
> > +     tristate "NPCM BIOS Post Code support"
> > +     depends on (ARCH_NPCM || COMPILE_TEST)
> > +     help
> > +       Provides NPCM driver to control the BIOS Post Code
> > +       interface which allows the BMC to monitor and save
> > +       the data written by the host to an arbitrary I/O port,
> > +       the BPC is connected to the host thourgh LPC or eSPI bus.
> > +
>
> This one in particular looks like this might be implemented
> by more than one BMC type, it's a fairly generic functionality.
>
> Have you talked to the other maintainers of SoCs used in
> OpenBMC about coming up with a common interface?
Yes, Both Nuvoton and Aspeed use the same user-facing code to manage
the host snooping.
https://github.com/openbmc/phosphor-host-postd
>
> > +#define DEVICE_NAME  "npcm-bpc"
Will do.
>
> [nitpicking] No need for macros like this one, open-coding the
> string is usually more readable.
>
>     Arnd

Thanks,

Tomer
