Return-Path: <linux-kernel+bounces-19352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C4826BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B2B1F223FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653725769;
	Mon,  8 Jan 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnTOVb8i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E57250F5;
	Mon,  8 Jan 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-46781bd40f8so328645137.1;
        Mon, 08 Jan 2024 02:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704710762; x=1705315562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlOM9uFTWiV/ILSzIqM0wAx12hGFckgtaUWN6aC3Cpc=;
        b=gnTOVb8ixMFKIFzF/ZvyQSGrSS006WipXdfdZHmHVytnKVbp90ZGLISYpA2RyUrOxb
         4IJwV+XrkHcED86m2cIfr5fu8djriVLmZ/r7PRBDl19wT4Vhx1GPh6jCwHZiMuKJ/QIq
         s3BBGqWqhnHbgO0ZxGikJTazlXrA6QwaQd+TLBAEEkBpT87hB0ZJK3+eSCiVeAL71bl6
         if7pXQS4G7tXPOPkFIU6r18YlNF/mnT6Np8kVhOGyjOa2r1BcxqibRx276rhNLs26hxj
         snbvT9XK2ESxPbFNqAS3rfhe2m4i63CIdTBF9G2IZHEMHxh1qtftE3M1npZxlBw6GT9u
         jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710762; x=1705315562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlOM9uFTWiV/ILSzIqM0wAx12hGFckgtaUWN6aC3Cpc=;
        b=IFcVHmR6lX4lbKbqrJsrKU95g1npVdPIVBciOgUQj44qxpoA86O1nqW1Z1/+QdK6kc
         t1tJJHXcwDu1yoJte3hFROCfTdEs8D7ChJDpw0gW2hvcZnw6/3tzEFDAdDwjUkqlirwS
         8XOcNZ9aIv4p3XgR9khYCrXTJzZJpjrShzYgz5X9OiD6mXdhkUr8l8KCj4bjuo/MxNgh
         4SKNntRnZ0JLNCzMAKbIQMXubmSgBlFPiDBbxCpsW0T9sj/JOU/uWbDqdWGDvjT1OA3q
         R0o1Ts6/eJ7kpaU3pmrfdS2zmLOaJD8svpcgi2XtpKBk4FihvSfs3iMrkINWPIicKIO4
         bfRw==
X-Gm-Message-State: AOJu0YxsIYNmPKKjNXpRzeLr99lTIsb683P0YKFp0VnxOty7AvPuoSJM
	5ojpdmGWgJCh6T1+017HOosvZPu0ZhlG98vxfNk0zIBKiiM=
X-Google-Smtp-Source: AGHT+IF0FlGMJAZxmUR5MFwdl5kpNj/YkCekkySoc7cKQ2G3uySGcuPFlTOpXJ+EUE4vCVeyWKZMHBHt5AlgVDnoD6A=
X-Received: by 2002:a05:6102:f9a:b0:467:c276:57be with SMTP id
 e26-20020a0561020f9a00b00467c27657bemr1242088vsv.8.1704710761912; Mon, 08 Jan
 2024 02:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117113149.9069-1-victorshihgli@gmail.com>
 <20231117113149.9069-15-victorshihgli@gmail.com> <66166245-f906-4057-8b44-16ec5a33e6e2@intel.com>
In-Reply-To: <66166245-f906-4057-8b44-16ec5a33e6e2@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 8 Jan 2024 18:45:50 +0800
Message-ID: <CAK00qKCFwBEjvhXFxkQ-wsHugio3sTVy6jW5oh-n2B7kQGpSkw@mail.gmail.com>
Subject: Re: [PATCH V13 14/21] mmc: sdhci-uhs2: add set_ios()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 5:12=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 17/11/23 13:31, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's set_ios operation.
> > THis is used to handle basic IO bus setting.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V13:
> >  - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
> >  - Modify comment message.
> >
> > Updates in V9:
> >  - Simplity the turning_on_clk in sdhci_set_ios().
> >
> > Updates in V8:
> >  - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED=
_B
> >    and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
> >  - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
> >    and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
> >  - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
> >    in sdhci_uhs2_set_ios().
> >
> > Updates in V7:
> >  - Remove unnecessary functions.
> >
> > Updates in V6:
> >  - Modify return value in some functions.
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 132 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 5a79dd29aa38..a55b910f3615 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -214,6 +214,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *ho=
st, struct mmc_command *cmd)
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
> > +     if (ios->power_mode !=3D MMC_POWER_OFF &&
> > +         (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD))
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
> > +                     mmc_regulator_set_vqmmc2(mmc, ios);
>
> mmc_regulator_set_vqmmc2() only sets the voltage, it doesn't
> disable the regulator.
>

Hi, Ulf

Would you have any idea about using the  mmc_regulator_set_vqmmc2()
to disable the regulator?

Thanks, Victor Shih

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
> > index 4d50cac7717d..64704f6537e0 100644
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
> > @@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct =
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
> > +     bool turning_on_clk;
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
> > +     turning_on_clk =3D ios->clock !=3D host->clock && ios->clock && !=
host->clock;
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> >
> >       if (host->ops->set_power)
> >               host->ops->set_power(host, ios->power_mode, ios->vdd);
> > @@ -2958,7 +2970,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u3=
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
> > @@ -2986,6 +2998,7 @@ static void sdhci_enable_preset_value(struct sdhc=
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
> > index cdb418d97c4d..b2e425dfac95 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -848,6 +848,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
>

