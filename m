Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF587DEF92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjKBKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbjKBKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:12:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D78128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:12:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c603e235d1so104630566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698919962; x=1699524762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZqB9qrmysX13BT59JOVtj+fnTDElF0sFcixuSiHwSU=;
        b=OHJUaVqBv/0QeBZg2/+BrobPFLKnYBcRK5JhixRJ9K3Hj91EdRd4ZfUlYmquH0lzvc
         lg8xhYoU0nrMRKfwkV3NdESsMUvRxbpfcV9bwNILUW3eqm6NEm6r5dJjSbqoiFSplvfS
         qDYJGa/WefAOywlcejCvUaZhsobHHP+t0CmyS8/PwtwwzOS/rm7tkDDDfJJaL5YzezQL
         bj6k6xS/ircf0I2b4Cg23GKz5bAHfqMoX6Cnb0QqhUNsdB0TS5mcSgVQ9weOOmm3oBYB
         yAhJXhke+UpCq9aE+pXLja30fCUdAeA6L2GP0E1LUlVy1f2eXQHIa7FSFvEb/HO/eZPk
         aX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919962; x=1699524762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZqB9qrmysX13BT59JOVtj+fnTDElF0sFcixuSiHwSU=;
        b=q02SEWn/MTE9rKVGEqgb4LLTgma2+oCIqjprWfWz6NSD0i4aZXLEI4khAfLSZ2XuSp
         qyXz1LgZJgUNjPD3GZPUTC8sJFDLUA+FA8cfAGL+k5qDPs6h8sExDolsiSRwFC+BUM4R
         PO+Yq8Tj+hdlQ1dGhy1KypqVe+SMJu24y7WBIbZvv35XRYkZU2EJmhdlXsgqAgb1Uvok
         7jKa66kk66BirApHBhdSUA5gI3NwtOaxG7qR3cSMOPBlxpuXVZPHZxtWrXz763434Gzh
         TvOyx2KTnBqESlC3knt1zkQ1jKNccIes5o3iknxDmEwG8O1Jf8tNWIPOX1x3Z07HsbgY
         8yNQ==
X-Gm-Message-State: AOJu0YxSA3YK9x/p0kgUM2Sk+rBsoSA8XZnGBvWy88/1Al55w/nUXm9p
        YJ3mrSc/tXu+4fEXiugbBUuaXxtAhmgMPDDOV4utGNsQtpQBzbLbIJ8=
X-Google-Smtp-Source: AGHT+IEM4bA7T/We4VeeGxv2tCY3ws3IIvRo7YMxFoEuSfPYV9VuV5hrtJA0KB9Qd5PVLMJVVfX589u23zx/Dkm3DBU=
X-Received: by 2002:a17:907:36cd:b0:9be:5ab2:73c2 with SMTP id
 bj13-20020a17090736cd00b009be5ab273c2mr3861703ejc.58.1698919961848; Thu, 02
 Nov 2023 03:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231102002453.1299195-1-william@wkennington.com>
 <20231102005321.1303809-1-william@wkennington.com> <CAP6Zq1ig9hadeWATYVgzZkhmsU3qe6Se+hwU6rSjvnGr0OmvMA@mail.gmail.com>
In-Reply-To: <CAP6Zq1ig9hadeWATYVgzZkhmsU3qe6Se+hwU6rSjvnGr0OmvMA@mail.gmail.com>
From:   William Kennington <wak@google.com>
Date:   Thu, 2 Nov 2023 03:12:30 -0700
Message-ID: <CAPnigKn5ObA3iMAwdcw9nnvpgO3o5q8D+v=+Nv5edNWQzpkNEA@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: npcm: Add CPU hotplug callbacks for kexec support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     william@wkennington.com, Brian Ma <chma0@nuvoton.com>,
        avifishman70@gmail.com, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, tali.perry1@gmail.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:39=E2=80=AFAM Tomer Maimon <tmaimon77@gmail.com> w=
rote:
>
> Hi William,
>
>
> On Thu, 2 Nov 2023 at 02:53, <william@wkennington.com> wrote:
> >
> > From: Brian Ma <chma0@nuvoton.com>
> >
> > Add callbacks required for kexec to function. The NPCM7xx/NPCN8xx does
> > not expose controls for powering down CPU cores, so just wait in idle
> > loop.
> This patch is related only to NPCM7xx please modify NPCM7xx/NPCN8xx to NP=
CM7xx.

Fixed in v2 message.

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
> >
>
> Best regards,
>
> Tomer
