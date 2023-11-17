Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEB7EF115
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjKQKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:29 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A44D52;
        Fri, 17 Nov 2023 02:50:24 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45db31f9156so730936137.1;
        Fri, 17 Nov 2023 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218223; x=1700823023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dvd1r0uV7IB9mFxXPza1NzbwXVBeZL/6VUSeoirYaIk=;
        b=gnnMQihO8Uu6RklknqauW+mICG4ONA3DAe82I2Q9ZAtJxuvqCWJWugAvGrSqPWw/c2
         YZQPmSgUVO5uDGCgvdgEIxReUUmQVK6h+2fbZvXGGEYl0P/k/aqcBLDMmR8Gr2DBzuFA
         0bVToEygPxJEjCe0Q3dNPIC4M2t1Rf0J9GJUbnyBS5D6pjDWYRrjIgrUyIssK/G0n97P
         RoezD8rubBv7kFl9z6I6V+4FM+vrAMO8ynz7kag4o7tO9lwBJiFJn8wIxm6eYSjycrrP
         qb6pEXPtz4NPzososxHSuBpLLEz5SnOme0r3pB/WiTWynMm8qFAQFVT+YlKoYlVfaaNm
         4syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218223; x=1700823023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dvd1r0uV7IB9mFxXPza1NzbwXVBeZL/6VUSeoirYaIk=;
        b=mpanbMnx6qSqf0rUMuUkbxzKF1Sa0Q8icAeH11QwBNrdUmtm17JbW6q1V7yN0qaZgF
         11tOB9BfTNozh9O3pzPmw2fgYeXyG8jXhDeTPbWWkO2ZGrpjuNQCGiSZL5D1BKsFzpWE
         YD8L1RRcRW2j96BzhXVEWg9TN3gP8rcODpl1zXXLVCm1ppN2f/n0dEgCdigX+m21lgpq
         2pFwy726zLFkjb/DNm7ZPClhXbOeiJuy6x5lSl2/eJH7epc46Vms3Fc+C7T0WsLao0MS
         +CrsMJOntoUxbuCaY3YidlQ0xHIA9me1DwIOsZVez+Jgl1rPJuH90FazzP5fBO0nIUgg
         WdBA==
X-Gm-Message-State: AOJu0Yz2iFfSTt+U6STJUljx82H/iBm20LdkIYiNS0iVr8o8XK8wY7ii
        lDT0wzNyFnayL1679o+WoygV6NRGSExbuYOcWGU=
X-Google-Smtp-Source: AGHT+IFOOx+2j8QplduXh8ugvFYiOwflitIPYtQ9KjZEv1Tm5Sr1tPiPeNRfrHSmXV3cEKU/T1DVH873vcz/Juv4D1Y=
X-Received: by 2002:a05:6102:4b14:b0:45e:3da0:6a31 with SMTP id
 ia20-20020a0561024b1400b0045e3da06a31mr24769944vsb.13.1700218223454; Fri, 17
 Nov 2023 02:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-18-victorshihgli@gmail.com> <CAPDyKFoQY=y-aZQa3GBGayE6=Ei=hw_Nu=1_tmQ-ckv94ujf4A@mail.gmail.com>
In-Reply-To: <CAPDyKFoQY=y-aZQa3GBGayE6=Ei=hw_Nu=1_tmQ-ckv94ujf4A@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:50:11 +0800
Message-ID: <CAK00qKDL3r821peDME7nSLfCs_CQOJnmN029Hfhyb+6KGswxhg@mail.gmail.com>
Subject: Re: [PATCH V12 17/23] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 7:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's uhs2_set_reg operation.
> > UHS-II interface (related registers) will be initialised here.
>
> Please clarify this. It's not entirely easy to understand what goes on
> by reading the commit message above.
>
> Again, the similar comments as I provided for patch15 applies to
> $subject patch too.
>

Hi, Ulf

I will merge patch#15, patch#16 and patch#17 into one patch(patch#15)
for version 13.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> > Updates in V8:
> >  - Reorder the definitions and lose the parentheses in
> >    sdhci_uhs2_set_config().
> >  - read_poll_timeout() to instead of read_poll_timeout_atomic()
> >    in sdhci_uhs2_check_dormant().
> >
> > Updates in V7:
> >  - Remove unnecessary function.
> >
> > Updates in V6:
> >  - Remove unnecessary function.
> >  - Remove unnecessary parameter when call the DBG().
> >  - Cancel export state of some functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 88 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index af1b0c5e48fd..09b86fec9f7b 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -278,6 +278,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *=
mmc, struct mmc_ios *ios)
> >         sdhci_set_clock(host, host->clock);
> >  }
> >
> > +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> > +{
> > +       u32 value;
> > +       u16 sdhci_uhs2_set_ptr =3D sdhci_readw(host, SDHCI_UHS2_SETTING=
S_PTR);
> > +       u16 sdhci_uhs2_gen_set_reg      =3D sdhci_uhs2_set_ptr;
> > +       u16 sdhci_uhs2_phy_set_reg      =3D sdhci_uhs2_set_ptr + 4;
> > +       u16 sdhci_uhs2_tran_set_reg     =3D sdhci_uhs2_set_ptr + 8;
> > +       u16 sdhci_uhs2_tran_set_1_reg   =3D sdhci_uhs2_set_ptr + 12;
> > +
> > +       /* Set Gen Settings */
> > +       value =3D FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host=
->mmc->uhs2_caps.n_lanes_set);
> > +       sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> > +
> > +       /* Set PHY Settings */
> > +       value =3D FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->=
uhs2_caps.n_lss_dir_set) |
> > +               FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uh=
s2_caps.n_lss_sync_set);
> > +       if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +           host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD)
> > +               value |=3D SDHCI_UHS2_PHY_SET_SPEED_B;
> > +       sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> > +
> > +       /* Set LINK-TRAN Settings */
> > +       value =3D FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc-=
>uhs2_caps.max_retry_set) |
> > +               FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_=
caps.n_fcu_set);
> > +       sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> > +       sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_u=
hs2_tran_set_1_reg);
> > +}
> > +
> > +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> > +{
> > +       int timeout =3D 100000; /* 100ms */
>
> Define.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +       u32 val;
> > +
> > +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DO=
RMANT_STATE),
> > +                             100, timeout, true, host, SDHCI_PRESENT_S=
TATE)) {
> > +               pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hos=
tname(host->mmc));
> > +               sdhci_dumpregs(host);
> > +               return -EIO;
> > +       }
> > +       return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > @@ -359,6 +401,51 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *=
mmc)
> >         return 0;
> >  }
> >
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
>
> Please re-order the code so this declaration isn't needed. And make it
> part of the patch that introduced the function, not in the $subject
> patch.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +
> > +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_opera=
tion op)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct mmc_ios *ios =3D &mmc->ios;
> > +       int err =3D 0;
> > +
> > +       DBG("Begin uhs2 control, act %d.\n", op);
> > +
> > +       switch (op) {
> > +       case UHS2_PHY_INIT:
> > +               err =3D sdhci_uhs2_do_detect_init(mmc);
> > +               break;
> > +       case UHS2_SET_CONFIG:
> > +               sdhci_uhs2_set_config(host);
> > +               break;
> > +       case UHS2_ENABLE_INT:
> > +               sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> > +               break;
> > +       case UHS2_DISABLE_INT:
> > +               sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> > +               break;
> > +       case UHS2_CHECK_DORMANT:
> > +               err =3D sdhci_uhs2_check_dormant(host);
> > +               break;
> > +       case UHS2_DISABLE_CLK:
> > +               err =3D sdhci_uhs2_disable_clk(mmc);
> > +               break;
> > +       case UHS2_ENABLE_CLK:
> > +               err =3D sdhci_uhs2_enable_clk(mmc);
> > +               break;
> > +       case UHS2_SET_IOS:
> > +               err =3D sdhci_uhs2_set_ios(mmc, ios);
> > +               break;
> > +       default:
> > +               pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> > +                      mmc_hostname(host->mmc), op);
> > +               err =3D -EIO;
> > +               break;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > @@ -481,6 +568,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_ho=
st *host)
> >  {
> >         host->mmc_host_ops.start_signal_voltage_switch =3D
> >                 sdhci_uhs2_start_signal_voltage_switch;
> > +       host->mmc_host_ops.uhs2_control =3D sdhci_uhs2_control;
> >
> >         return 0;
> >  }
>
> Kind regards
> Uffe
