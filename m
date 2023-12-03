Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1958021A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 09:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjLCIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 03:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 03:03:32 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF1C0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 00:03:38 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cdc0b3526eso28842847b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701590617; x=1702195417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTVJVIDBZaj5fzzMVjd2zG2bVjzxreayrJVae6FjjUs=;
        b=K00nUIPcuRc0mhcPWlO4ECajga3brX6qTM8kN32qE+MhAlV5NhHmOEDaDHM2JUYxDg
         sI6UhGmB8OXTYH4Pfz7gFoLy4yaeQwa82l9WgYEPG2A/rFf06WKgOAzuKPo+PI6eQA0Y
         sFeMrvtWWaYipBZ7yqHUBaABUcqj/ufnDnB9hdmQ7xq7QSNBMlIx8ucfo2nYukf84oAj
         BgpJegmCGxZhTPGN46yYcxVzz7sPjQ5LfY4e6AWbVua1J0X/+L4wvui3/LKghreRl9uO
         oD4Gk3ErCHUV00DDBQ9aoWWgc4YbN72X7H/YV5S6n2amDp+wFJJCP1X92KEK4F87VQL4
         e3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701590617; x=1702195417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTVJVIDBZaj5fzzMVjd2zG2bVjzxreayrJVae6FjjUs=;
        b=Pj2XBg34F9owXr0q5hI+jOzdUDkBStNNZ98PmchMJMZho2m2HtiuS70OF+d1+DXE8G
         mkclIchE+KTEKIT7OdSVg4tJhF2Mm1egfOzb33Ew/nWF5t7dYEuf2RSQ2m3r9eBtLTWp
         RMjax0W0QPofoCUdWXbyOXxTTH8K0rK2hBvTJRkZTg/5xwC1SrZpBZxBnh59lVjF8LP1
         /N0NYn8YFGv2yd43VvB7fq/ttrhFea15M4FD51FDvGTD94pwKu2RfzanAZ6Bp8zMVdae
         Yov6g8iCsTsP5wHrcADhfJ51ISBGHNFaewlMRtvZaoOmNdHLJF5trawlJtNeNSqc8WJn
         ZrqQ==
X-Gm-Message-State: AOJu0Yw6iJjXYprCF8Y5qReUDg9lKeg8XTHnfiZuQtKfcRrltbeGropY
        CDhfj/TeQzKCbFDzhOIWUSS6/lqwlc2ApXpBcyY=
X-Google-Smtp-Source: AGHT+IHcEsvhAqzzte4Z0+Bz3jNOY3S3+INoFR0W03gvySiM3WRw+Id8CGrsKCAdKWXtpofj72CzGEYimkoSDnUwFiI=
X-Received: by 2002:a81:99d3:0:b0:5d3:a63b:88f7 with SMTP id
 q202-20020a8199d3000000b005d3a63b88f7mr1157215ywg.25.1701590617445; Sun, 03
 Dec 2023 00:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20231102002453.1299195-1-william@wkennington.com>
 <20231102101009.15104-1-william@wkennington.com> <CAD_4BXgmCdc_H-XfmGnW3fa6H=cbONma6QzUiofNVZWJtcBwOg@mail.gmail.com>
In-Reply-To: <CAD_4BXgmCdc_H-XfmGnW3fa6H=cbONma6QzUiofNVZWJtcBwOg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 3 Dec 2023 10:03:26 +0200
Message-ID: <CAP6Zq1gG8d8AEPQZ0izrYdY66fxE3ec57jFDzBK5q6Zrji74qA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: npcm: Add CPU hotplug callbacks for kexec support
To:     William Kennington <william@wkennington.com>
Cc:     tali.perry1@gmail.com, avifishman70@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Sat, 2 Dec 2023 at 01:51, William Kennington <william@wkennington.com> w=
rote:
>
> On Thu, Nov 2, 2023 at 3:10=E2=80=AFAM William A. Kennington III
> <william@wkennington.com> wrote:
> >
> > From: Brian Ma <chma0@nuvoton.com>
> >
> > Add callbacks required for kexec to function. The NPCM7xx does
> > not expose controls for powering down CPU cores, so just wait in idle
> > loop.
> >
> > Signed-off-by: Brian Ma <chma0@nuvoton.com>
> > Signed-off-by: William A. Kennington III <william@wkennington.com>
> > ---
> >  arch/arm/mach-npcm/platsmp.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.=
c
> > index 41891d3aa124..6cc7b5894f08 100644
> > --- a/arch/arm/mach-npcm/platsmp.c
> > +++ b/arch/arm/mach-npcm/platsmp.c
> > @@ -69,10 +69,27 @@ static void __init npcm7xx_smp_prepare_cpus(unsigne=
d int max_cpus)
> >
> >         iounmap(scu_base);
> >  }
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static void npcm7xx_cpu_die(unsigned int cpu)
> > +{
> > +       while (1)
> > +               cpu_do_idle();
> > +}
> > +
> > +static int npcm7xx_cpu_kill(unsigned int l_cpu)
> > +{
> > +       return 1;
> > +}
> > +#endif
> > +
> >
> >  static struct smp_operations npcm7xx_smp_ops __initdata =3D {
> >         .smp_prepare_cpus =3D npcm7xx_smp_prepare_cpus,
> >         .smp_boot_secondary =3D npcm7xx_smp_boot_secondary,
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +       .cpu_die                        =3D npcm7xx_cpu_die,
> > +       .cpu_kill                       =3D npcm7xx_cpu_kill,
> > +#endif
> >  };
> >
> >  CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm750-smp", &npcm7xx_smp=
_ops);
> > --
> > 2.42.0.820.g83a721a137-goog
> >'
>
> Mind taking another look? This should be updated accordingly.

Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>

Best regards,

Tomer
