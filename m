Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC59A798542
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjIHJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjIHJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:57:58 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662F1FF2;
        Fri,  8 Sep 2023 02:57:14 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-48d0dbf4ec5so654572e0c.2;
        Fri, 08 Sep 2023 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166980; x=1694771780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4NF0w3XAPrGaxJ5Sc/Fqz9qFVjNQRJyWxChIpfwlaU=;
        b=ASPfybU935UHYWMWyp+C4rIayDrvGiBwEypd8yVgG9ZtyUnc6iofJuorGBEUauazyB
         lgFe4hW7jBsZA5KlsJ9bHkWysHNPeAmPjx193/UY+CyLafCrkKYD0O8Vhj5E2ZiWNggq
         4FSgY8I4DbKMpzN2XIAn0btnymfvoDVF9OV87oiWSPJ5u4Ic+vsWxIX+zGChiW457UKl
         tFmvvNjVS362m49A7LdU9uZqDDx+TJgzmAC5netys4Ev0562trllIxd+QUfwnxHtm7wr
         QyuVHPXT3n0ks193oTMJ4974Gakc1NMslcCR9mtRg1QclAYvw/Uxa03ehV5V0taJSthp
         Nz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166980; x=1694771780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4NF0w3XAPrGaxJ5Sc/Fqz9qFVjNQRJyWxChIpfwlaU=;
        b=W+yfFCr6FFq/K/RTYEOsxKIpSTTF3Ap0O2XFv5kkZnh3a6rqeRFrZVcWi+DjSWBDO2
         8+6T+HpGHY3KePof/flSfwGqWNeH+t9BHkYX0dJRB0D0c9Jd2RGwNHw4lpB0ttZgiWbm
         AWX8l6FdYQNeZAyzGepazbgXYgMpIXqTSkqhuEb/N33MzetE4VWTW7m8GPdjascu/qDT
         //ksKI0ugIJpaFidT81sWmIhG8lHjh9GfulNZXLORISlAh/micoeuePCgbWVm1KLgDEj
         JPf+6QMBfn8L527FlnN0+D54POIPBWvdjB8r6QA71xBhF6/KJ5LwK2uFpjWK3quK1K5p
         Kc0w==
X-Gm-Message-State: AOJu0YxGzLhOt3gSL4QNj5qA0j6C2p3Gkic4wHrg8Re5C6p/Xrp2xatw
        6FWyGc/GV/IEIVp71dkY9qA2LW7tw0tsIgqnpbs=
X-Google-Smtp-Source: AGHT+IECe5sCdTamj/Jc8VZhQjUnqS0+/Ej8Wj6PwDHXtDwVWhYnMqTnPhujsbCs11TVyLKn5xUvzRZZOnXY7XVzLC8=
X-Received: by 2002:a67:f9d9:0:b0:44d:4aa1:9d44 with SMTP id
 c25-20020a67f9d9000000b0044d4aa19d44mr1776201vsq.8.1694166980526; Fri, 08 Sep
 2023 02:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-21-victorshihgli@gmail.com> <e8ed5409-5a00-9478-5b91-85d54b7fb2bb@intel.com>
In-Reply-To: <e8ed5409-5a00-9478-5b91-85d54b7fb2bb@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 8 Sep 2023 17:56:08 +0800
Message-ID: <CAK00qKAuPLL_8ja0u0OYhiXSjNW347Y1U_r0Ty9j4JdvqDqf4A@mail.gmail.com>
Subject: Re: [PATCH V10 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 4:35=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/08/23 13:02, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's add_host/remove_host operation.
> > Any sdhci drivers which are capable of handling UHS-II cards must
> > call those functions instead of the corresponding sdhci's.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V10:
> >  - Move some definitions of PatchV9[05/23] to PatchV10[20/23].
> >
> > Updates in V8:
> >  - Change return type to void for __sdhci_uhs2_add_host_v4().
> >  - Remove unused variables in __sdhci_uhs2_add_host_v4().
> >
> > Updates in V7:
> >  - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
> >    in sdhci_uhs2_add_host().
> >  - Cancel export state of some functions.
> >
> > Updates in V6:
> >  - Add complete_work_fn/thread_irq_fn variables in struct sdhci_host.
> >  - Use complete_work_fn/thread_irq_fn variables in
> >    sdhci_alloc_host() and sdhci_uhs2_add_host().
> >  - Use sdhci_uhs2_mode() to simplify code in __sdhci_uhs2_remove_host()=
.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 102 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   2 +
> >  drivers/mmc/host/sdhci.c      |   7 ++-
> >  drivers/mmc/host/sdhci.h      |   3 +
> >  include/linux/mmc/host.h      |   1 +
> >  5 files changed, 113 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 8d1be670af49..80eafacc8b9f 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/host.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -997,6 +998,107 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq,=
 void *dev_id)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/*********************************************************************=
********\
> > + *
> > + * Device allocation/registration                                     =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps=
1)
> > +{
> > +     struct mmc_host *mmc;
> > +     u32 max_current_caps2;
> > +
> > +     mmc =3D host->mmc;
> > +
> > +     /* Support UHS2 */
> > +     if (caps1 & SDHCI_SUPPORT_UHS2)
> > +             mmc->caps2 |=3D MMC_CAP2_SD_UHS2;
> > +
> > +     max_current_caps2 =3D sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> > +
> > +     if ((caps1 & SDHCI_CAN_VDD2_180) &&
> > +         !max_current_caps2 &&
> > +         !IS_ERR(mmc->supply.vmmc2)) {
> > +             /* UHS2 - VDD2 */
> > +             int curr =3D regulator_get_current_limit(mmc->supply.vmmc=
2);
> > +
> > +             if (curr > 0) {
> > +                     /* convert to SDHCI_MAX_CURRENT format */
> > +                     curr =3D curr / 1000;  /* convert to mA */
> > +                     curr =3D curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> > +                     curr =3D min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT=
);
> > +                     max_current_caps2 =3D curr;
> > +             }
> > +     }
> > +
> > +     if (caps1 & SDHCI_CAN_VDD2_180)
> > +             mmc->ocr_avail_uhs2 |=3D MMC_VDD_165_195;
> > +     else
> > +             mmc->caps2 &=3D ~MMC_CAP2_SD_UHS2;
> > +}
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> > +
> > +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead=
)
> > +{
> > +     if (!sdhci_uhs2_mode(host))
> > +             return;
> > +
> > +     if (!dead)
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> > +}
> > +
> > +int sdhci_uhs2_add_host(struct sdhci_host *host)
> > +{
> > +     struct mmc_host *mmc =3D host->mmc;
> > +     int ret;
> > +
> > +     ret =3D sdhci_setup_host(host);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (host->version >=3D SDHCI_SPEC_400)
> > +             __sdhci_uhs2_add_host_v4(host, host->caps1);
> > +
> > +     if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
> > +             /* host doesn't want to enable UHS2 support */
> > +             mmc->caps2 &=3D ~MMC_CAP2_SD_UHS2;
> > +
> > +     /* overwrite ops */
> > +     if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> > +             sdhci_uhs2_host_ops_init(host);
> > +
> > +     host->complete_work_fn =3D sdhci_uhs2_complete_work;
> > +     host->thread_irq_fn    =3D sdhci_uhs2_thread_irq;
> > +
> > +     /* LED support not implemented for UHS2 */
> > +     host->quirks |=3D SDHCI_QUIRK_NO_LED;
> > +
> > +     ret =3D __sdhci_add_host(host);
> > +     if (ret)
> > +             goto cleanup;
> > +
> > +     return 0;
> > +
> > +cleanup:
> > +     if (host->version >=3D SDHCI_SPEC_400)
> > +             __sdhci_uhs2_remove_host(host, 0);
> > +
> > +     sdhci_cleanup_host(host);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
> > +
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> > +{
> > +     __sdhci_uhs2_remove_host(host, dead);
> > +
> > +     sdhci_remove_host(host, dead);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
> > +
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 3aa2cb4b39d6..bd5aae054c6f 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -186,5 +186,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *h=
ost, u32 clear, u32 set);
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)=
;
> >  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq);
> >  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> > +int sdhci_uhs2_add_host(struct sdhci_host *host);
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 318d4830732f..b3de7e30ba54 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -4104,6 +4104,9 @@ struct sdhci_host *sdhci_alloc_host(struct device=
 *dev,
> >
> >       host->max_timeout_count =3D 0xE;
> >
> > +     host->complete_work_fn =3D sdhci_complete_work;
> > +     host->thread_irq_fn    =3D sdhci_thread_irq;
> > +
> >       return host;
> >  }
> >
> > @@ -4853,7 +4856,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >       if (!host->complete_wq)
> >               return -ENOMEM;
> >
> > -     INIT_WORK(&host->complete_work, sdhci_complete_work);
> > +     INIT_WORK(&host->complete_work, host->complete_work_fn);
> >
> >       timer_setup(&host->timer, sdhci_timeout_timer, 0);
> >       timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> > @@ -4862,7 +4865,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >
> >       sdhci_init(host, 0);
> >
> > -     ret =3D request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_i=
rq,
> > +     ret =3D request_threaded_irq(host->irq, sdhci_irq, host->thread_i=
rq_fn,
> >                                  IRQF_SHARED, mmc_hostname(mmc), host);
> >       if (ret) {
> >               pr_err("%s: Failed to request IRQ %d: %d\n",
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 6bbb9f073f29..5235f2da6568 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -626,6 +626,9 @@ struct sdhci_host {
> >       struct timer_list timer;        /* Timer for timeouts */
> >       struct timer_list data_timer;   /* Timer for data timeouts */
> >
> > +     void            (*complete_work_fn)(struct work_struct *work);
> > +     irqreturn_t     (*thread_irq_fn)(int irq, void *dev_id);
> > +
> >  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> >       struct dma_chan *rx_chan;
> >       struct dma_chan *tx_chan;
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 1eba64228725..918d4998c1de 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -379,6 +379,7 @@ struct mmc_host {
> >       u32                     ocr_avail_sdio; /* SDIO-specific OCR */
> >       u32                     ocr_avail_sd;   /* SD-specific OCR */
> >       u32                     ocr_avail_mmc;  /* MMC-specific OCR */
> > +     u32                     ocr_avail_uhs2; /* UHS2-specific OCR */
>
> ocr_avail_uhs2 gets set but doesn't seem to be used
>

Hi, Adrian

I will drop the ocr_avail_uhs2 in the next version.

Thanks, Victor Shih

> >       struct wakeup_source    *ws;            /* Enable consume of ueve=
nts */
> >       u32                     max_current_330;
> >       u32                     max_current_300;
>
