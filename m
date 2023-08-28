Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1492678AE43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjH1K7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjH1K6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:58:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA62C2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:58:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b52875b8d9so277815ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693220313; x=1693825113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljL1zThljNasYQ4d5IYv4Q1vKQ9tJwA3CVawyxE2lvA=;
        b=CBhMy1Zhg0aT9q7W2gF8mS2/k7YTOOK7XS92x+cNEAEeS/3LfKKWfWRlOhn5Moh6lF
         Cmoq76ipQaDHrZ1u/J0VxMAA3pLQ0q9BKRhE14XOUC7Gb+Dd77p1FAi60SqR8/OxCS0p
         3Ts3UUDgbP7hJlievl+l99XsNtE72lBLJ3wik1yu1LVJhiblaudGq/68hEXu6yZlYCsC
         gjIF6oeOV3AmVAVOroHQt+2+89LFGYyQNV/nteOSS18tsV5P//6dF+t7KMw5ysGbtvcU
         j48uz+b5AOfxe8PajF6nTt91FcaMkNmgayYx5MOJrpJy1w032x41qfuxbwlhHEVXkt/A
         OQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220313; x=1693825113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljL1zThljNasYQ4d5IYv4Q1vKQ9tJwA3CVawyxE2lvA=;
        b=kRe/NvhRneYk299o40nGlE8WxMaPujIFDI/IcisXazQ1QB6DXGw9J/cW219BslLZXR
         tz7Bvk6/S66YNeWNl5OkAUKBhQqyC89fkm4c2OZjpHs+NXLeBNXYV6z9zmlflRcdLBXQ
         hrgo2MkQ8sT5DgRYoco6pootdI7Q4KJxOk54KKoLD4/tuLOI0kgAhJOqTPv7RavjLDEl
         N2PhBoGo+OZD59VYZKKhRdnbk0j8KVAdbwvBtRlQY+4UkjXAyVL0zuBxr30rQ6jkRMVk
         9E1wLo4SCuet50QJXMh37VNCRz7gMyl1tBAl3lJOtKmE8Xpx01FPSbQiQg609tY1ENKR
         NI0A==
X-Gm-Message-State: AOJu0YyLDhLsMUwZJUSL39orcgz1QtOyBBxnMNxdJj2tW1h4GODdrhQM
        QMNwULUWHATjrITkhMp0ERcC7yxCkMOuJRgoU3zYGg==
X-Google-Smtp-Source: AGHT+IG+mcjH46KFJbv9Xyf6eAr40t0VLQkMB5ZkYJptXrUwi91WHySh6jdFgXtg+sKU+2XFGOfguluz1NTx/E9D9gQ=
X-Received: by 2002:a17:902:c64a:b0:1b9:c5de:9aa with SMTP id
 s10-20020a170902c64a00b001b9c5de09aamr307146pls.27.1693220313032; Mon, 28 Aug
 2023 03:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com> <20230828100313.3051403-1-benchuanggli@gmail.com>
In-Reply-To: <20230828100313.3051403-1-benchuanggli@gmail.com>
From:   =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>
Date:   Mon, 28 Aug 2023 12:57:56 +0200
Message-ID: <CADj_en4DkCKwRuLqUpCMPeAxMX5v7upifGabDrhW+d+kwKNDZw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, stable@vger.kernel.org,
        svenva@chromium.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Thanks for reviewing our patch.

On Mon, Aug 28, 2023 at 12:03=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com=
> wrote:
>
> Hi,
>
> On 24/08/23 20:18, Adrian Hunter wrote:
> > On 24/08/23 14:50, Stanis=C5=82aw Kardach wrote:
> > > Hi Adrian,
> > >
> > > Thanks for reviewing our patches.
> > >
> > > On Thu, Aug 24, 2023 at 1:47=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com <mailto:adrian.hunter@intel.com>> wrote:
> > >
> > >     Hi
> > >
> > >     Looks OK - a few minor comments below
> > >
> > >     On 23/08/23 20:41, Sven van Ashbrook wrote:
> > >     > To improve the r/w performance of GL9763E, the current driver i=
nhibits LPM
> > >     > negotiation while the device is active.
> > >     >
> > >     > This prevents a large number of SoCs from suspending, notably x=
86 systems
> > >
> > >     If possible, can you give example of which SoCs / products
> > >
> > >     > which use S0ix as the suspend mechanism:
> > >     > 1. Userspace initiates s2idle suspend (e.g. via writing to
> > >     >    /sys/power/state)
> > >     > 2. This switches the runtime_pm device state to active, which d=
isables
> > >     >    LPM negotiation, then calls the "regular" suspend callback
> > >     > 3. With LPM negotiation disabled, the bus cannot enter low-powe=
r state
> > >     > 4. On a large number of SoCs, if the bus not in a low-power sta=
te, S0ix
> > >     >    cannot be entered, which in turn prevents the SoC from enter=
ing
> > >     >    suspend.
> > >     >
> > >     > Fix by re-enabling LPM negotiation in the device's suspend call=
back.
> > >     >
> > >     > Suggested-by: Stanislaw Kardach <skardach@google.com <mailto:sk=
ardach@google.com>>
> > >     > Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write perform=
ance for GL9763E")
> > >     > Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org>
> > >     > Signed-off-by: Sven van Ashbrook <svenva@chromium.org <mailto:s=
venva@chromium.org>>
> > >     >      # on gladios device
> > >     >      # on 15590.0.0 with v5.10 and upstream (v6.4) kernels
> > >     >
> > >
> > >     3 extraneous lines here - please remove
> > >
> > >     > ---
> > >     >
> > >     > Changes in v2:
> > >     > - improved symmetry and error path in s2idle suspend callback (=
internal review)
> > >     >
> > >     >  drivers/mmc/host/sdhci-pci-gli.c | 102 +++++++++++++++++++----=
--------
> > >     >  1 file changed, 64 insertions(+), 38 deletions(-)
> > >     >
> > >     > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/hos=
t/sdhci-pci-gli.c
> > >     > index 1792665c9494a..19f577cc8bceb 100644
> > >     > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > >     > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > >     > @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci=
_host *host, int reg)
> > >     >       return value;
> > >     >  }
> > >     >
> > >     > -#ifdef CONFIG_PM_SLEEP
> > >     > -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> > >     > -{
> > >     > -     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > -
> > >     > -     pci_free_irq_vectors(slot->chip->pdev);
> > >     > -     gli_pcie_enable_msi(slot);
> > >     > -
> > >     > -     return sdhci_pci_resume_host(chip);
> > >     > -}
> > >     > -
> > >     > -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> > >     > -{
> > >     > -     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > -     int ret;
> > >     > -
> > >     > -     ret =3D sdhci_pci_gli_resume(chip);
> > >     > -     if (ret)
> > >     > -             return ret;
> > >     > -
> > >     > -     return cqhci_resume(slot->host->mmc);
> > >     > -}
> > >     > -
> > >     > -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip=
)
> > >     > -{
> > >     > -     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > -     int ret;
> > >     > -
> > >     > -     ret =3D cqhci_suspend(slot->host->mmc);
> > >     > -     if (ret)
> > >     > -             return ret;
> > >     > -
> > >     > -     return sdhci_suspend_host(slot->host);
> > >     > -}
> > >     > -#endif
> > >     > -
> > >     >  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc=
,
> > >     >                                         struct mmc_ios *ios)
> > >     >  {
> > >     > @@ -1029,6 +993,68 @@ static int gl9763e_runtime_resume(struct =
sdhci_pci_chip *chip)
> > >     >  }
> > >     >  #endif
> > >     >
> > >     > +#ifdef CONFIG_PM_SLEEP
> > >     > +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> > >     > +{
> > >     > +     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > +
> > >     > +     pci_free_irq_vectors(slot->chip->pdev);
> > >     > +     gli_pcie_enable_msi(slot);
> > >     > +
> > >     > +     return sdhci_pci_resume_host(chip);
> > >     > +}
>
> sdhci_pci_gli_resume() is the same as before. Is there any reason to move=
 it here?
To avoid having multiple #ifdef CONFIG_PM_SLEEP blocks. We can leave
it, where it
was if you prefer.
>
> > >     > +
> > >     > +static int gl9763e_resume(struct sdhci_pci_chip *chip)
> > >     > +{
> > >     > +     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > +     int ret;
> > >     > +
> > >     > +     ret =3D sdhci_pci_gli_resume(chip);
> > >     > +     if (ret)
> > >     > +             return ret;
> > >     > +
> > >     > +     ret =3D cqhci_resume(slot->host->mmc);
> > >     > +     if (ret)
> > >     > +             return ret;
> > >     > +
> > >     > +     /* Disable LPM negotiation to bring device back in sync
> > >     > +      * with its runtime_pm state.
> > >     > +      */
> > >
> > >     I would prefer the comment style:
> > >
> > >             /*
> > >              * Blah, blah ...
> > >              * Blah, blah, blah.
> > >              */
> > >
> > >     > +     gl9763e_set_low_power_negotiation(slot, false);
>
> There is a situation for your reference.
> If `allow_runtime_pm' is set to false and the system resumes from suspend=
, GL9763E
> LPM negotiation will be always disabled on S0. GL9763E will stay L0 and n=
ever
> enter L1 because GL9763E LPM negotiation is disabled.
>
> This patch enables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled -> (=
a)
> (a) -+--> idle -->  gl9763e_runtime_suspend() -> LPM enabled
>      |
>      +--> no idle -> gl9763e_runtime_resume() -> LPM disabled
Is the lower branch of this sequence possible? I mean please correct
me if I'm wrong
but after the s2idle resume, devices are considered runtime active unless d=
eemed
otherwise, so gl_9763e_resume() -> fl9763e_runtime_resume() should not
happen, right?
>
> This patch disables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled (no =
runtime_pm)
>
> Although that may not be the case with the current configuration, it's on=
ly a
> possibility.
Actually last year there was a patch to improve R/W performance of GL9763E:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df9e5b33934cec24b8c024add5c5d65d2f93ade05
If I'm reading the code right we're not modifying allow_runtime_pm,
rather we're disabling
the L1 negotiation in the same manner as the abovementioned patch does
in the runtime
PM flow. So in a way we're restoring whatever setting was there except
a situation where
the runtime PM was disabled from the start on the device and we do not
restore the
original state of the LPM negotiation fields. Not sure if such case is
really possible.
>
> > >     > +
> > >     > +     return 0;
> > >     > +}
> > >     > +
> > >     > +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
> > >     > +{
> > >     > +     struct sdhci_pci_slot *slot =3D chip->slots[0];
> > >     > +     int ret;
> > >     > +
> > >     > +     /* Certain SoCs can suspend only with the bus in low-
> > >
> > >     Ditto re comment style
> > >
> > >     > +      * power state, notably x86 SoCs when using S0ix.
> > >     > +      * Re-enable LPM negotiation to allow entering L1 state
> > >     > +      * and entering system suspend.
> > >     > +      */
> > >     > +     gl9763e_set_low_power_negotiation(slot, true);
> > >
> > >     Couldn't this be at the end of the function, save
> > >     an error path
> > >
> > > Please correct me if I'm wrong but writing to device config
> > > space could trigger a side effect, so it's probably better to
> > > do it before calling functions suspending the device?
> >
> > sdhci doesn't know anything about the bus.  It is independent
> > of PCI, so I can't see how it would make any difference.
> > One of the people cc'ed might know more.  Jason Lai (cc'ed)
> > added it for runtime PM.
> >
>
> As far as I know, when disabling LPM negotiation, the GL9763E will stop e=
ntering
> L1. It doesn't other side effect. Does Jason.Lai and Victor.Shih have any=
 comments
> or suggestions?
The reason we've put the LPM negotiation handling at the start of
suspend and finish
of resume was mostly for semantical reasons - first do device logic,
then call base
framework/module logic which might expect all the device-specific steps to =
be
performed already. Maybe it does not make any difference in the real world =
for
SDHCI controllers but it just seemed to look better. Also suspend and resum=
e
callbacks already have such ordering when it comes to cqhci_* and sdhci_*
functions.
>
> Best regards,
> Ben Chuang
>
> > >
> > >
> > >     > +
> > >     > +     ret =3D cqhci_suspend(slot->host->mmc);
> > >     > +     if (ret)
> > >     > +             goto err_suspend;
> > >     > +
> > >     > +     ret =3D sdhci_suspend_host(slot->host);
> > >     > +     if (ret)
> > >     > +             goto err_suspend_host;
> > >     > +
> > >     > +     return 0;
> > >     > +
> > >     > +err_suspend_host:
> > >     > +     cqhci_resume(slot->host->mmc);
> > >     > +err_suspend:
> > >     > +     gl9763e_set_low_power_negotiation(slot, false);
> > >     > +     return ret;
> > >     > +}
> > >     > +#endif
> > >     > +
> > >     >  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> > >     >  {
> > >     >       struct pci_dev *pdev =3D slot->chip->pdev;
> > >     > @@ -1113,8 +1139,8 @@ const struct sdhci_pci_fixes sdhci_gl9763=
e =3D {
> > >     >       .probe_slot     =3D gli_probe_slot_gl9763e,
> > >     >       .ops            =3D &sdhci_gl9763e_ops,
> > >     >  #ifdef CONFIG_PM_SLEEP
> > >     > -     .resume         =3D sdhci_cqhci_gli_resume,
> > >     > -     .suspend        =3D sdhci_cqhci_gli_suspend,
> > >     > +     .resume         =3D gl9763e_resume,
> > >     > +     .suspend        =3D gl9763e_suspend,
> > >     >  #endif
> > >     >  #ifdef CONFIG_PM
> > >     >       .runtime_suspend =3D gl9763e_runtime_suspend,
> > >
> > >
> > >
> > > --
> > > Best Regards,
> > > Stanis=C5=82aw Kardach
> >
> >



--=20
Best Regards,
Stanis=C5=82aw Kardach
