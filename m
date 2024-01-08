Return-Path: <linux-kernel+bounces-19350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE4826BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF8CB209AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008F14014;
	Mon,  8 Jan 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4WVtXkq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80013FFB;
	Mon,  8 Jan 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b73593f37dso236953e0c.1;
        Mon, 08 Jan 2024 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704710746; x=1705315546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tHmWjaoT1G1CAqBk+LJazEM79dmgGS6SI10YtiKi7U=;
        b=H4WVtXkqIA0vql7w1CKbDSpQSXbvGPWpop0gpLbXzkXcgO8I1f16rAJk1xm6mcI2SW
         oDrG9Zoi0wOPEmO9ybnf1IK8yWX3VWcGEBtvbvq8bJeLrGlLZ5LETf9JpT+VMKXJda17
         IWEK96bifaZpWzOQPo/8AXtLkjPJCv2nz6hLp/IeMIePPVdVnwG9rpN8vLnAgLALlnP6
         IDI4XTsRCmE+aAPyHxyMoiEOl58heBpHtLCfjZy5aza7JwRcUXGhpTLaEw82/+ke/x2R
         FxLrUWVXjgtIzT5G15ftcKTWUkbw9olZhoZ3Qo69w1HshyfY4qVAZiynzcUn9ASFNRkQ
         HiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710746; x=1705315546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tHmWjaoT1G1CAqBk+LJazEM79dmgGS6SI10YtiKi7U=;
        b=tVPbkuCa1CdAET6LLMaRZx5gXNeuqlpkA6138AIBrb+6e3w8LVNZlZsLj2I7uvrhIA
         GneJahJIZDx6z8SjnezZ6qzVyUNlfuUDixrtdTrgudESsV6y9KRs8u2HxVaokbWZy68d
         ymRN8VDbwHfpoQfsW26V6/jF3JRZ6Lp20Kk52uHo2cw9TnLLDr5aB2ACvJplC0zcXXhd
         LNTL5+UEY/lrPiN44w8djogbOD8pc3lkHHQpjKUDS8xCu9uOf35Uvn0LQgEhNl1FX44z
         7FrFnV917pua4bRd7Aco41YwuV2K40flZWqs/fmrd8o+AnwrVdUNBoZxz/21xBVb8zZT
         073g==
X-Gm-Message-State: AOJu0Yw9UuaD2JnmBb2PX4p/4c3eXl6RdNS5DYVYGl7atwkH2QT+PfXc
	xWu1fiOkkrHEBiS3NJuAhGQkgTi7SZuEUl4wN/Y=
X-Google-Smtp-Source: AGHT+IGdn0P+BExOTa9zmw/ayHGaH6L+4WWw2w3lrE+3QyyKqg1vZYmzn9ZMsaKGZG+LFPJ5GkXu+taDHU03z/QJ0xI=
X-Received: by 2002:a05:6122:4a17:b0:4b7:197b:318a with SMTP id
 ez23-20020a0561224a1700b004b7197b318amr847688vkb.23.1704710746354; Mon, 08
 Jan 2024 02:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117113149.9069-1-victorshihgli@gmail.com>
 <20231117113149.9069-13-victorshihgli@gmail.com> <4068ed64-b5d8-4491-b461-4a4eaddf92f1@intel.com>
In-Reply-To: <4068ed64-b5d8-4491-b461-4a4eaddf92f1@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 8 Jan 2024 18:45:34 +0800
Message-ID: <CAK00qKBc8zxLHFjO1pfSQaVY-irBQRDJmsusNoWV+bW0iG_myQ@mail.gmail.com>
Subject: Re: [PATCH V13 12/21] mmc: sdhci-uhs2: add set_power() to support vdd2
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
> > This is a UHS-II version of sdhci's set_power operation.
> > Use sdhci_uhs2_set_power() to set VDD2 for support UHS2 interface.
> > VDD2, as well as VDD, is handled here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V13:
> >  - Drop use vmmc2.
> >  - Modify comment message.
> >
> > Updates in V10:
> >  - Move some definitions of PatchV9[05/23] to PatchV10[11/23].
> >
> > Updates in V9:
> >  - Modify annotations in sdhci_get_vdd_value().
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets.
> >  - Add the initial value of the pwr in sdhci_uhs2_set_power().
> >
> > Updates in V7:
> >  - Add clear the power reg before setting a new value
> >    in sdhci_uhs2_set_power().
> >  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value=
().
> >  - Drop pwr variable in sdhci_get_vdd_value().
> >
> > Updates in V6:
> >  - Add mmc_opt_regulator_set_ocr().
> >  - Remove unnecessary functions.
> >
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  3 files changed, 82 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 066549526060..7d5070f58d00 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -59,6 +59,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> > +                                         struct regulator *supply,
> > +                                         unsigned short vdd_bit)
> > +{
> > +     return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, su=
pply, vdd_bit);
> > +}
> > +
> >  bool sdhci_uhs2_mode(struct sdhci_host *host)
> >  {
> >       return  host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 =
mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned cha=
r mode, unsigned short vdd)
> > +{
> > +     struct mmc_host *mmc =3D host->mmc;
> > +     u8 pwr =3D 0;
> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
>
> mmc_regulator_set_vqmmc2() only sets the voltage, it doesn't
> disable the regulator.
>

Hi, Ulf

Would you have any idea about using the  mmc_regulator_set_vqmmc2()
to disable the regulator?

Thanks, Victor Shih

> > +     } else {
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +             /* support 1.8v only for now */
> > +             mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
> > +
> > +             /* Clear the power reg before setting a new value */
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             /* vdd first */
> > +             pwr |=3D SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             pwr |=3D SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +     }
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 27ea5b875c29..4d50cac7717d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > -
> > +#include <linux/bug.h>
> >  #include <linux/leds.h>
> >
> >  #include <linux/mmc/mmc.h>
> > @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_ho=
st *host, unsigned char mode,
> >               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +     switch (1 << vdd) {
> > +     case MMC_VDD_165_195:
> > +     /*
> > +      * Without a regulator, SDHCI does not support 2.0v
> > +      * so we only get here if the driver deliberately
> > +      * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +      * for the purpose of turning on the power.
> > +      */
> > +     case MMC_VDD_20_21:
> > +             return SDHCI_POWER_180;
> > +     case MMC_VDD_29_30:
> > +     case MMC_VDD_30_31:
> > +             return SDHCI_POWER_300;
> > +     case MMC_VDD_32_33:
> > +     case MMC_VDD_33_34:
> > +     /*
> > +      * 3.4V ~ 3.6V are valid only for those platforms where it's
> > +      * known that the voltage range is supported by hardware.
> > +      */
> > +     case MMC_VDD_34_35:
> > +     case MMC_VDD_35_36:
> > +             return SDHCI_POWER_330;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd)
> >  {
> >       u8 pwr =3D 0;
> >
> >       if (mode !=3D MMC_POWER_OFF) {
> > -             switch (1 << vdd) {
> > -             case MMC_VDD_165_195:
> > -             /*
> > -              * Without a regulator, SDHCI does not support 2.0v
> > -              * so we only get here if the driver deliberately
> > -              * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -              * for the purpose of turning on the power.
> > -              */
> > -             case MMC_VDD_20_21:
> > -                     pwr =3D SDHCI_POWER_180;
> > -                     break;
> > -             case MMC_VDD_29_30:
> > -             case MMC_VDD_30_31:
> > -                     pwr =3D SDHCI_POWER_300;
> > -                     break;
> > -             case MMC_VDD_32_33:
> > -             case MMC_VDD_33_34:
> > -             /*
> > -              * 3.4 ~ 3.6V are valid only for those platforms where it=
's
> > -              * known that the voltage range is supported by hardware.
> > -              */
> > -             case MMC_VDD_34_35:
> > -             case MMC_VDD_35_36:
> > -                     pwr =3D SDHCI_POWER_330;
> > -                     break;
> > -             default:
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr) {
> >                       WARN(1, "%s: Invalid vdd %#x\n",
> >                            mmc_hostname(host->mmc), vdd);
> > -                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 782c399fae15..cdb418d97c4d 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsig=
ned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                    unsigned char mode,
> >                                    unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
>

