Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B5B77881A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjHKHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:23:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5351DD7;
        Fri, 11 Aug 2023 00:23:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40fd2de0ddcso11369071cf.2;
        Fri, 11 Aug 2023 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691738581; x=1692343381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UogLUKYq0gqOblesBbG58yj9hThY60FiFujRSwjIu0A=;
        b=D64pqSPLMVFpY00BlcIIUXLRdwI/RZsLmyCoJ/Yn7HWZr7Q6mfnvHfjOt7lTvm4G+8
         C37FSqLtoo2FeCHv7o+oAUFQnqXBUFXF9XSETis6KVy8uINOUcO4nIxLPLB7jytsH6SI
         1sgjHkISG4XqC+quEnF3XEA8KSBwYmIwt9JFdpBDnun1YBJBRgLPE9hWUjqrO+hqprJj
         jETKlSDU4zeBrrVxtrkKj901QxQD+xmKYKFcLTKz/3Fv1PsJ5YEMmoGLLn8fofVQnii8
         uhz+Q9xELTzqgTID29dRkofd4QF2qDoT1hi7QQmYVB8ST7DdUANdDnxQIifB3oF/toOG
         iM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691738581; x=1692343381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UogLUKYq0gqOblesBbG58yj9hThY60FiFujRSwjIu0A=;
        b=LguqByLoAQKY4hVzIMvhelDsg907m+WUZFGsfP32U9oOKccvTSLY9R+5gTLpMyPtfC
         HdJI6ufulRnStzysTPuysJngwePHk94JJiirBuwZB1l5TbgGVBOvojueSgpE+ZiqpU7G
         PuBXYD3oRP3CDqdmem9PcN7h+F/PgPtUbolfL5WLysIKbmAhhunQtCzNBVmqNWmT3Bhb
         fvKrdfLxe/8dbPpC+LXDh5CzkNZ3YsJ4toUxExohBlsDUxRIfD6+8+xvflpFinPhIIEP
         23BuFrkLkRqPoPSaF9mlRCEwaZgTUJ1XZpBwPDbuHNt2rP2yLpVYFVzEYtKdbVbEzK8U
         F0/g==
X-Gm-Message-State: AOJu0Yzu7s5udbWYUhYXTrl2ufG/p4zzqhH70G3RlT2SKWL94ePjtqtb
        TUJu2XJ3dAyahdyP3qrWH+mxhtM9n8Qow1fudyQ=
X-Google-Smtp-Source: AGHT+IFPaeIj6sYj2JeoZitFCKGI+WQ34332wkOpYin6H/E11sYX7qMN1ShAWRvuuKDXSh0D2TLD3ZJeiBv43f1KV9A=
X-Received: by 2002:a0c:cb8d:0:b0:63f:7f2e:3b84 with SMTP id
 p13-20020a0ccb8d000000b0063f7f2e3b84mr864420qvk.63.1691738581335; Fri, 11 Aug
 2023 00:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230809052952.323-1-wenchao.chen@unisoc.com> <CAPDyKFoykxdP70t2pjeiX0pkKuUCZ2AeFM4yT4-wfVijxB7OHw@mail.gmail.com>
In-Reply-To: <CAPDyKFoykxdP70t2pjeiX0pkKuUCZ2AeFM4yT4-wfVijxB7OHw@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 11 Aug 2023 15:22:50 +0800
Message-ID: <CA+Da2qx52QVk5Hz2PdY78qHRmspkDkXbWCWbUOGXCt2nbjNW0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 6:09=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 9 Aug 2023 at 07:30, Wenchao Chen <wenchao.chen@unisoc.com> wrote=
:
> >
> > Added .prepare_hs_tuning and .execute_hs_tuning host
> > callbacks to support host-specific tuning for SD high
> > speed mode.
>
> This certainly needs to be clarified more. Especially why it's needed
> for the sdhci-sprd variant.
>

First of all, Unisoc's IC provides cmd delay and read delay to ensure
that the host can
get the correct data. However, according to SD Spec, there is no need
to do tuning in
high speed mode, but with the development of chip processes, it is
more and more difficult
to find a suitable delay to cover all the chips.
Therefore, we need SD high speed mode online tuning.

> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/core/sd.c         |  12 ++++
> >  drivers/mmc/host/sdhci-sprd.c | 124 ++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h      |   6 ++
> >  3 files changed, 142 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 246ce027ae0a..ac2da8f2fbce 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32 ocr,
> >                  */
> >                 mmc_set_clock(host, mmc_sd_get_max_clock(card));
> >
> > +               if (host->ops->prepare_hs_tuning) {
> > +                       err =3D host->ops->prepare_hs_tuning(host, card=
);
> > +                       if (err)
> > +                               goto free_card;
> > +               }
>
> Adding a new callback for this is a bit questionable, I think.
>
> In the ->set_ios() callback, we could instead check MMC_TIMING_SD_HS
> and when the clock is updated, then also run a tuning sequence, right?
>

Yeah, I'll try.

> > +
> >                 /*
> >                  * Switch to wider bus (if supported).
> >                  */
> > @@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32 ocr,
> >
> >                         mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
> >                 }
> > +
> > +               if (host->ops->execute_hs_tuning) {
> > +                       err =3D host->ops->execute_hs_tuning(host, card=
);
> > +                       if (err)
> > +                               goto free_card;
> > +               }
>
> Similar to the above comment, in the ->set_ios() callback we could
> instead check MMC_TIMING_SD_HS when moving to MMC_BUS_WIDTH_4, then
> run a tuning sequence, right?
>

ibid.

> >         }
> >  cont:
> >         if (!oldcard) {
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-spr=
d.c
> > index 7f4ee2e12735..5f365dcbb9c7 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/highmem.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/mmc/mmc.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -22,6 +23,9 @@
> >  #include "sdhci-pltfm.h"
> >  #include "mmc_hsq.h"
> >
> > +#include "../core/mmc_ops.h"
> > +#include "../core/sd_ops.h"
>
> No, this isn't how we include header files. Instead move the functions
> that you may need to include/linux/mmc/host.h.
>
> Also, please split up core changes from host driver changes.
>

I'll fix it in the next version.

> > +
> >  /* SDHCI_ARGUMENT2 register high 16bit */
> >  #define SDHCI_SPRD_ARG2_STUFF          GENMASK(31, 16)
> >
> > @@ -73,6 +77,11 @@
> >  #define SDHCI_SPRD_CLK_DEF_RATE                26000000
> >  #define SDHCI_SPRD_PHY_DLL_CLK         52000000
> >
> > +#define SDHCI_SPRD_MAX_PHASE           0xff
> > +#define SDHCI_SPRD_CMD_DLY_MASK                GENMASK(15, 8)
> > +#define SDHCI_SPRD_POSRD_DLY_MASK      GENMASK(23, 16)
> > +#define SDHCI_SPRD_CPST_EN             GENMASK(27, 24)
> > +
> >  struct sdhci_sprd_host {
> >         u32 version;
> >         struct clk *clk_sdio;
> > @@ -86,6 +95,11 @@ struct sdhci_sprd_host {
> >         u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> >  };
> >
> > +enum sdhci_sprd_tuning_type {
> > +       SDHCI_SPRD_TUNING_SD_HS_CMD,
> > +       SDHCI_SPRD_TUNING_SD_HS_DATA,
> > +};
> > +
> >  struct sdhci_sprd_phy_cfg {
> >         const char *property;
> >         u8 timing;
> > @@ -533,6 +547,111 @@ static void sdhci_sprd_hs400_enhanced_strobe(stru=
ct mmc_host *mmc,
> >                      SDHCI_SPRD_REG_32_DLL_DLY);
> >  }
> >
> > +static int mmc_send_tuning_cmd(struct mmc_card *card)
> > +{
> > +       return mmc_send_status(card, NULL);
> > +}
> > +
> > +static int mmc_send_tuning_data(struct mmc_card *card)
> > +{
> > +       u8 status[64];
>
> We use kmalloc-ed data for data transfers.
>

Why is it better to use kmalloc-ed data?

> > +
> > +       return mmc_sd_switch(card, 0, 0, 0, status);
> > +}
> > +
> > +static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *ca=
rd,
> > +                       enum sdhci_sprd_tuning_type type)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct sdhci_sprd_host *sprd_host =3D TO_SPRD_HOST(host);
> > +       u32 *p =3D sprd_host->phy_delay;
> > +       int err =3D 0;
> > +       int i;
> > +       bool value;
> > +       int final_phase;
> > +       u32 dll_cfg, dll_dly;
> > +       int range_end =3D SDHCI_SPRD_MAX_PHASE;
> > +       int len =3D 0;
> > +       int count =3D 0;
> > +
> > +       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > +
> > +       dll_cfg =3D sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> > +       dll_cfg &=3D ~SDHCI_SPRD_CPST_EN;
> > +       sdhci_writel(host, dll_cfg, SDHCI_SPRD_REG_32_DLL_CFG);
> > +
> > +       dll_dly =3D p[mmc->ios.timing];
> > +
> > +       for (i =3D 0; i <=3D SDHCI_SPRD_MAX_PHASE; i++) {
> > +               if (type =3D=3D SDHCI_SPRD_TUNING_SD_HS_CMD) {
> > +                       dll_dly &=3D ~SDHCI_SPRD_CMD_DLY_MASK;
> > +                       dll_dly |=3D ((i << 8) & SDHCI_SPRD_CMD_DLY_MAS=
K);
> > +               } else {
> > +                       dll_dly &=3D ~SDHCI_SPRD_POSRD_DLY_MASK;
> > +                       dll_dly |=3D ((i << 16) & SDHCI_SPRD_POSRD_DLY_=
MASK);
> > +               }
> > +
> > +               sdhci_writel(host, dll_dly, SDHCI_SPRD_REG_32_DLL_DLY);
> > +
> > +               if (type =3D=3D SDHCI_SPRD_TUNING_SD_HS_CMD)
> > +                       value =3D !mmc_send_tuning_cmd(card);
> > +               else
> > +                       value =3D !mmc_send_tuning_data(card);
> > +
> > +               if (value) {
> > +                       dev_dbg(mmc_dev(host->mmc), "tuning ok: %d\n", =
i);
> > +                       count++;
> > +               } else {
> > +                       dev_dbg(mmc_dev(host->mmc), "tuning fail: %d\n"=
, i);
> > +                       if (len < count) {
> > +                               len =3D count;
> > +                               range_end =3D i - 1;
> > +                               count =3D 0;
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (!count) {
> > +               final_phase =3D 0;
> > +               dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n")=
;
> > +               err =3D -EIO;
> > +               goto out;
> > +       }
> > +
> > +       if (count > len) {
> > +               len =3D count;
> > +               range_end =3D i - 1;
> > +       }
> > +
> > +       final_phase =3D range_end - (len - 1) / 2;
>
> The whole len, count, range_end, final_phase things look rather messy.
> Please have a look and try to clean up that part a bit, I am sure it
> can be done, somehow.
>

Indeed, it looks messy. I'll fix it in the next version.

> > +
> > +       if (type =3D=3D SDHCI_SPRD_TUNING_SD_HS_CMD) {
> > +               p[mmc->ios.timing] &=3D ~SDHCI_SPRD_CMD_DLY_MASK;
> > +               p[mmc->ios.timing] |=3D ((final_phase << 8) & SDHCI_SPR=
D_CMD_DLY_MASK);
> > +       } else {
> > +               p[mmc->ios.timing] &=3D ~(SDHCI_SPRD_POSRD_DLY_MASK);
> > +               p[mmc->ios.timing] |=3D ((final_phase << 16) & SDHCI_SP=
RD_POSRD_DLY_MASK);
> > +       }
> > +
> > +       dev_info(mmc_dev(host->mmc), "the best step %d, phase 0x%02x, d=
elay value 0x%08x\n",
> > +                       final_phase, final_phase, p[mmc->ios.timing]);
>
> Does this really deserve to be a dev_info? Looks like a dev_dbg to me, no=
?
>

Yeah. You're right.
I'll fix it in the next version.

> > +
> > +out:
> > +       sdhci_writel(host, p[mmc->ios.timing], SDHCI_SPRD_REG_32_DLL_DL=
Y);
> > +
> > +       return err;
> > +}
> > +
> > +static int sdhci_sprd_prepare_hs_cmd_tuning(struct mmc_host *mmc, stru=
ct mmc_card *card)
> > +{
> > +       return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_CMD=
);
> > +}
> > +
> > +static int sdhci_sprd_execute_hs_data_tuning(struct mmc_host *mmc, str=
uct mmc_card *card)
> > +{
> > +       return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_DAT=
A);
> > +}
> > +
> >  static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_ho=
st,
> >                                        struct device_node *np)
> >  {
> > @@ -577,6 +696,11 @@ static int sdhci_sprd_probe(struct platform_device=
 *pdev)
> >         host->mmc_host_ops.request =3D sdhci_sprd_request;
> >         host->mmc_host_ops.hs400_enhanced_strobe =3D
> >                 sdhci_sprd_hs400_enhanced_strobe;
> > +       host->mmc_host_ops.prepare_hs_tuning =3D
> > +               sdhci_sprd_prepare_hs_cmd_tuning;
> > +       host->mmc_host_ops.execute_hs_tuning =3D
> > +               sdhci_sprd_execute_hs_data_tuning;
> > +
> >         /*
> >          * We can not use the standard ops to change and detect the vol=
tage
> >          * signal for Spreadtrum SD host controller, since our voltage =
regulator
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 461d1543893b..13cf894b9e3c 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -184,6 +184,12 @@ struct mmc_host_ops {
> >         /* Execute HS400 tuning depending host driver */
> >         int     (*execute_hs400_tuning)(struct mmc_host *host, struct m=
mc_card *card);
> >
> > +       /* Prepare HS tuning depending host driver */
> > +       int     (*prepare_hs_tuning)(struct mmc_host *host, struct mmc_=
card *card);
> > +
> > +       /* Execute HS tuning depending host driver */
> > +       int     (*execute_hs_tuning)(struct mmc_host *host, struct mmc_=
card *card);
> > +
> >         /* Prepare switch to DDR during the HS400 init sequence */
> >         int     (*hs400_prepare_ddr)(struct mmc_host *host);
> >
>
> Kind regards
> Uffe
