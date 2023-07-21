Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AF75C428
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGUKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGUKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:12:16 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F430E8;
        Fri, 21 Jul 2023 03:12:01 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7919342c456so473222241.2;
        Fri, 21 Jul 2023 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934321; x=1690539121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSEl1iuKVpVWhCUY1WwZ4/yjxoSBkNlE+I1TvZAHeTM=;
        b=UQ4tkyaXJSE9cKRQg9z/mPFPLU1PJTh6d1Nkyia8jYVMZIfDmxDuqgRhtsvxL8R7km
         nG4pik7LFeSsO5kQW9hct2+pzDJ2Yp4H4XdMAqWblQEs7US8WOKIj5fwJK+DSjtc6xuI
         cCRL5jkXw3sdYfsz3QLbyf72GmrqW55J7X6s0PFuD2boXc7IZtXHrh6d6BFeGU2uNVYT
         UoVYEJQXeuZ+RxV4XkEEB0PDg8Kugw+HrWfmgHzmeQXt+5/lxrlEoxso6FIMpxDm7sAn
         k6GQVhhQp5epKPMfpZueQM0Y774i6ddTlz5H/vT4xHIY4FBXn4Ek05QO+yA+qt/AcRDv
         mEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934321; x=1690539121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSEl1iuKVpVWhCUY1WwZ4/yjxoSBkNlE+I1TvZAHeTM=;
        b=WAHtFA8hoen65f6B7zf1CkUDWv//9J+K/djDcg4whNYGUDXIbylK1POT5eIpAZ14RU
         n6VqLYXDf9262XU8pgVtG0P7nVioDCCHTrEJNRfdcyQTM43eGJWOExChTdm+JtnTNAc4
         tLbe8CV7TSYEwAJeOkHjbiVFMns1I9vYiIvrV654tq5d8sv+dYGHzDFa/2gxfYCNDJ3y
         zCbU5brLAVv+pXEPP26PuzCJjdIpQO/qDE9TVpoeXTOi8i9gr17ekrQIsb7s7iypGFN8
         vdUbPS3bTRgnCVSmMiEEfInJbjdDbefnTiVD1rUFr10ObShBsMNIauu4GHDSobYS73V+
         1sPA==
X-Gm-Message-State: ABy/qLY4wqRpiLF8E2IU4E9sMFVzsfA/xtNKLaj+DM+rsnYDS0PVCbuO
        qNXjQY9qkmlT6aAF2yfyt3o16O/BcRhyAi7bq6A=
X-Google-Smtp-Source: APBJJlHD84PtfY/SDNEK21KpMDQBGAgL3pZCdqWt/F0DobtvJ20CSm5sVowyPLj+JZG8m3JX+2jgMRQdt5mRhYhREAI=
X-Received: by 2002:a67:eb03:0:b0:443:621e:d138 with SMTP id
 a3-20020a67eb03000000b00443621ed138mr340920vso.5.1689934320822; Fri, 21 Jul
 2023 03:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-15-victorshihgli@gmail.com> <cf59220b-2aa7-b487-b469-f2e6260058b5@intel.com>
In-Reply-To: <cf59220b-2aa7-b487-b469-f2e6260058b5@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:11:48 +0800
Message-ID: <CAK00qKBHxaeipiYjZMQwYWa+Umg2YXRfNHDpKHmUFLoV4_46sA@mail.gmail.com>
Subject: Re: [PATCH V8 14/23] mmc: sdhci-uhs2: add set_ios()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/06/23 13:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's set_ios operation.
> > It covers both UHS-I and UHS-II.
> >
> > Updates in V8:
> >  - Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> >    MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >    __sdhci_uhs2_set_ios().
> >  - Add the switch case for MMC_TIMING_SPEED_A_HD,
> >    MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >    sdhci_get_preset_value().
> >  - mmc_opt_regulator_set_ocr() to instead of
> >    mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> >
> > Updates in V7:
> >  - Remove unnecessary functions.
> >
> > Updates in V6:
> >  - Modify return value in some functions.
> >  - Remove unnecessary functions.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 94 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      | 56 +++++++++++++--------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 132 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index d519e6ce6199..ad791c48f681 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -214,6 +214,70 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *hos=
t, struct mmc_command *cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> >
> > +/**
> > + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable regis=
ter
> > + * @host:    SDHCI host
> > + * @clear:   bit-wise clear mask
> > + * @set:     bit-wise set mask
> > + *
> > + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> > + */
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     ier &=3D ~clear;
> > +     ier |=3D set;
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> > +
> > +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios =
*ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     u8 cmd_res, dead_lock;
> > +     u16 ctrl_2;
> > +
> > +     /* UHS2 Timeout Control */
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +
> > +     /* change to use calculate value */
> > +     cmd_res |=3D FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead=
_lock);
> > +
> > +     sdhci_uhs2_clear_set_irqs(host,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> > +                               0);
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +     sdhci_uhs2_clear_set_irqs(host, 0,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> > +
> > +     /* UHS2 timing. Note, UHS2 timing is disabled when powering off *=
/
> > +     ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +     if (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +         ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +         ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD)
> > +             ctrl_2 |=3D SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> > +     else
> > +             ctrl_2 &=3D ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> > +     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +     host->timing =3D ios->timing;
> > +
> > +     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> > +             sdhci_enable_preset_value(host, true);
> > +
> > +     if (host->ops->set_power)
> > +             host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +     else
> > +             sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> > +
> > +     sdhci_set_clock(host, host->clock);
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > @@ -235,6 +299,36 @@ static int sdhci_uhs2_start_signal_voltage_switch(=
struct mmc_host *mmc,
> >       return sdhci_start_signal_voltage_switch(mmc, ios);
> >  }
> >
> > +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *io=
s)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +     pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > +              mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd=
, ios->timing);
> > +
> > +     if (!sdhci_uhs2_mode(host)) {
> > +             sdhci_set_ios(mmc, ios);
> > +             return 0;
> > +     }
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return 0;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (ios->power_mode =3D=3D MMC_POWER_OFF) {
> > +                     mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, =
0);
> > +                     mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2,=
 0);
> > +             }
> > +             return -1;
> > +     }
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> > +
> > +     __sdhci_uhs2_set_ios(mmc, ios);
> > +
> > +     return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index ccf4e1834c2d..a3641c5f8c77 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index ef344d4edf8f..6e5a9d93a769 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,8 +47,6 @@
> >  static unsigned int debug_quirks =3D 0;
> >  static unsigned int debug_quirks2;
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able);
> > -
> >  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_com=
mand *cmd);
> >
> >  void sdhci_dumpregs(struct sdhci_host *host)
> > @@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_h=
ost *host)
> >       case MMC_TIMING_MMC_HS400:
> >               preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >               break;
> > +     case MMC_TIMING_UHS2_SPEED_A:
> > +     case MMC_TIMING_UHS2_SPEED_A_HD:
> > +     case MMC_TIMING_UHS2_SPEED_B:
> > +     case MMC_TIMING_UHS2_SPEED_B_HD:
> > +             preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +             break;
> >       default:
> >               pr_warn("%s: Invalid UHS-I mode selected\n",
> >                       mmc_hostname(host->mmc));
> > @@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struc=
t sdhci_host *host, struct mmc_i
> >              (sdhci_preset_needed(host, ios->timing) || host->drv_type =
!=3D ios->drv_type);
> >  }
> >
> > -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > -     bool reinit_uhs =3D host->reinit_uhs;
> > -     bool turning_on_clk =3D false;
> > -     u8 ctrl;
> > -
> > -     host->reinit_uhs =3D false;
> > -
> > -     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > -             return;
> > -
> > -     if (host->flags & SDHCI_DEVICE_DEAD) {
> > -             if (!IS_ERR(mmc->supply.vmmc) &&
> > -                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > -                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > -             return;
> > -     }
> >
> >       /*
> >        * Reset the chip on each power off.
> > @@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct m=
mc_ios *ios)
> >               sdhci_enable_preset_value(host, false);
> >
> >       if (!ios->clock || ios->clock !=3D host->clock) {
> > -             turning_on_clk =3D ios->clock && !host->clock;
> > -
> >               host->ops->set_clock(host, ios->clock);
> >               host->clock =3D ios->clock;
> >
> > @@ -2374,6 +2361,32 @@ void sdhci_set_ios(struct mmc_host *mmc, struct =
mmc_ios *ios)
> >                       mmc->max_busy_timeout /=3D host->timeout_clk;
> >               }
> >       }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> > +
> > +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     bool reinit_uhs =3D host->reinit_uhs;
> > +     bool turning_on_clk =3D false;
> > +     u8 ctrl;
> > +
> > +     host->reinit_uhs =3D false;
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (!IS_ERR(mmc->supply.vmmc) &&
> > +                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             return;
> > +     }
> > +
> > +     if (!ios->clock || ios->clock !=3D host->clock)
> > +             turning_on_clk =3D ios->clock && !host->clock;
>
> This is simpler and then turning_on_clk need not be initialised earlier:
>
>         turning_on_clk =3D ios->clock !=3D host->clock && ios->clock && !=
host->clock;
>

Hi, Adrian

      I will update it to the V9 version.

Thanks, Victor Shih

> > +
> > +     sdhci_set_ios_common(mmc, ios);
> >
> >       if (host->ops->set_power)
> >               host->ops->set_power(host, ios->power_mode, ios->vdd);
> > @@ -2957,7 +2970,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u3=
2 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able)
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  {
> >       /* Host Controller v3.00 defines preset value registers */
> >       if (host->version < SDHCI_SPEC_300)
> > @@ -2985,6 +2998,7 @@ static void sdhci_enable_preset_value(struct sdhc=
i_host *host, bool enable)
> >               host->preset_enabled =3D enable;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
> >
> >  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *m=
rq,
> >                               int err)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index f3bd558b337f..03d29423a678 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -847,6 +847,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, i=
nt width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
>
