Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9F7C9A45
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjJORWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:22:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11892A1;
        Sun, 15 Oct 2023 10:22:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so20840641fa.0;
        Sun, 15 Oct 2023 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697390523; x=1697995323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KkduH/ZQuhYuwGTaVnTAfxaGqMb6uJiQI/XtTEMqE4=;
        b=XtPySN2jLe402FLlgPGH4EbDsBfBB4aj35fbBpV5NPz6wWcL1hlu/A631rpfXFKvhI
         v1YUYMhsu/jGNgUJ61uez2ow9wKoLGDN69ctqml8lTwbdskRgg0w+07lAP6Xnw22o8U9
         gYbCUkQzUd8bMWYeVwjkZqN5xKvanOdOzGUFRNJWO3sbjcCQpzp9C8wwDy1sFp+b2/rz
         x/L0iWpyZZfE/YmpI6cDPFV+YkDwA9nfrJcsTIRMluow4naXqK0bSri8EjjMl7ChW35w
         Gvf8jHSr+wCoU6Xuxk7aBzDlPS73efoKLaP9g62JpGzFbRyq9HRPAv4U0yzp+wv2H5e0
         xGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697390523; x=1697995323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KkduH/ZQuhYuwGTaVnTAfxaGqMb6uJiQI/XtTEMqE4=;
        b=uB9M4TkCspEWSg91hLj9q7g7hW3Z4WlH4Ei8M3Ip77GbW/+XJX+mV5+UttABnn8Kfx
         /bVobwZb6V7aTyNA4BFk/XTVeG51BAgO8Iomd/Sl98n2kzOmfvzDA0602suVXkmz+HU3
         9e1z+VdANwuIXUAjagHiW6mosnZytJ6FKlJyvLPsstkh0rFzFdGr80uWu+u9XljA835s
         tZ+5rgCqzLLj++LH6Mg26diB8kMAHVFzV2LYW2GNKIef8hKiFzn+7KnKhYqiFFHTGkdE
         JcWIpIiLWx12ErIkGgmtRZgguMq7vVHLXEVBI37Lrbe8OXhOAAf0sMZ0Yp/sVxgZA3oh
         68gg==
X-Gm-Message-State: AOJu0Yw8FjquwDxzuyNx2jgArpTKx9AnxxuohbqGi7cyRrsvK2pRbDDD
        FlzyKvTvhvRz/LweISHnDAu3f+UXnU1M1oiHMcI=
X-Google-Smtp-Source: AGHT+IE+B5mf8etTcynZmQWKI3zC4RXIloC3dzspmE6UY9SFz6DoDrzTJ/Auqc3A3EKOjZTrJE9pN116bJxSgdXowoA=
X-Received: by 2002:a2e:a596:0:b0:2c5:fde:e457 with SMTP id
 m22-20020a2ea596000000b002c50fdee457mr4314039ljp.3.1697390522995; Sun, 15 Oct
 2023 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230057.3365626-1-tmaimon77@gmail.com> <20231012230057.3365626-4-tmaimon77@gmail.com>
 <7add0297-709f-4836-832f-f8fbd412eca5@molgen.mpg.de>
In-Reply-To: <7add0297-709f-4836-832f-f8fbd412eca5@molgen.mpg.de>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 15 Oct 2023 20:21:51 +0300
Message-ID: <CAP6Zq1g0eT0X5UvQ6Zok=JdOb2WOJ89qFW2MtUQh_z737F7F1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] usb: chipidea: Add support for NPCM
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for your comments

On Fri, 13 Oct 2023 at 16:18, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tomer,
>
>
> Thank you for your patch.
>
> Am 13.10.23 um 01:00 schrieb Tomer Maimon:
> > Add Nuvoton NPCM BMC SoCs support to USB ChipIdea driver.
> > NPCM SoC include ChipIdea IP block that used for USB device controller
>
> include*s*
> =E2=80=9Cthat *is* used=E2=80=9D or just =E2=80=9C=E2=80=A6 used for=E2=
=80=9D
Will do
>
> > mode.
>
> Please add a line, how you tested this patch.
I don't recall "how you tested the patch" done in the commit message,
I can add it in the cover letter
>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > Acked-by: Peter Chen <peter.chen@kernel.org>
> > ---
> >   drivers/usb/chipidea/Kconfig        |   4 +
> >   drivers/usb/chipidea/Makefile       |   1 +
> >   drivers/usb/chipidea/ci_hdrc_npcm.c | 114 +++++++++++++++++++++++++++=
+
> >   3 files changed, 119 insertions(+)
> >   create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c
> >
> > diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfi=
g
> > index c815824a0b2d..bab45bc62361 100644
> > --- a/drivers/usb/chipidea/Kconfig
> > +++ b/drivers/usb/chipidea/Kconfig
> > @@ -43,6 +43,10 @@ config USB_CHIPIDEA_MSM
> >       tristate "Enable MSM hsusb glue driver" if EXPERT
> >       default USB_CHIPIDEA
> >
> > +config USB_CHIPIDEA_NPCM
> > +     tristate "Enable NPCM hsusb glue driver" if EXPERT
> > +     default USB_CHIPIDEA
> > +
> >   config USB_CHIPIDEA_IMX
> >       tristate "Enable i.MX USB glue driver" if EXPERT
> >       depends on OF
> > diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makef=
ile
> > index 71afeab97e83..718cb24603dd 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -13,6 +13,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)               +=3D otg_=
fsm.o
> >
> >   obj-$(CONFIG_USB_CHIPIDEA_GENERIC)  +=3D ci_hdrc_usb2.o
> >   obj-$(CONFIG_USB_CHIPIDEA_MSM)              +=3D ci_hdrc_msm.o
> > +obj-$(CONFIG_USB_CHIPIDEA_NPCM)              +=3D ci_hdrc_npcm.o
> >   obj-$(CONFIG_USB_CHIPIDEA_PCI)              +=3D ci_hdrc_pci.o
> >   obj-$(CONFIG_USB_CHIPIDEA_IMX)              +=3D usbmisc_imx.o ci_hdr=
c_imx.o
> >   obj-$(CONFIG_USB_CHIPIDEA_TEGRA)    +=3D ci_hdrc_tegra.o
> > diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea=
/ci_hdrc_npcm.c
> > new file mode 100644
> > index 000000000000..37b64a3dbd96
> > --- /dev/null
> > +++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2023 Nuvoton Technology corporation.
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/usb/chipidea.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/of.h>
> > +
> > +#include "ci.h"
> > +
> > +struct npcm_udc_data {
> > +     struct platform_device  *ci;
> > +     struct clk              *core_clk;
> > +     struct ci_hdrc_platform_data pdata;
> > +};
> > +
> > +static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
> > +{
> > +     struct device *dev =3D ci->dev->parent;
> > +
> > +     switch (event) {
> > +     case CI_HDRC_CONTROLLER_RESET_EVENT:
> > +             /* clear all mode bits */
> > +             hw_write(ci, OP_USBMODE, 0xffffffff, 0x0);
> > +             break;
> > +     default:
> > +             dev_dbg(dev, "unknown ci_hdrc event\n");
>
> Please print it out.
Do you mean instead dev_dbg to use dev_info? in that case, each event
that didnt handled will cause a print.
>
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int npcm_udc_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct npcm_udc_data *ci;
> > +     struct platform_device *plat_ci;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     ci =3D devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
> > +     if (!ci)
> > +             return -ENOMEM;
> > +     platform_set_drvdata(pdev, ci);
> > +
> > +     ci->core_clk =3D devm_clk_get_optional(dev, NULL);
> > +     if (IS_ERR(ci->core_clk))
> > +             return PTR_ERR(ci->core_clk);
> > +
> > +     ret =3D clk_prepare_enable(ci->core_clk);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to enable the cloc=
k: %d\n", ret);
> > +
> > +     ci->pdata.name =3D dev_name(dev);
> > +     ci->pdata.capoffset =3D DEF_CAPOFFSET;
> > +     ci->pdata.flags =3D CI_HDRC_REQUIRES_ALIGNED_DMA |
> > +             CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS;
> > +     ci->pdata.phy_mode =3D USBPHY_INTERFACE_MODE_UTMI;
> > +     ci->pdata.notify_event =3D npcm_udc_notify_event;
> > +
> > +     plat_ci =3D ci_hdrc_add_device(dev, pdev->resource, pdev->num_res=
ources,
> > +                                  &ci->pdata);
> > +     if (IS_ERR(plat_ci)) {
> > +             ret =3D PTR_ERR(plat_ci);
> > +             dev_err(dev, "failed to register HDRC NPCM device: %d\n",=
 ret);
> > +             goto clk_err;
> > +     }
> > +
> > +     pm_runtime_no_callbacks(dev);
> > +     pm_runtime_enable(dev);
> > +
> > +     return 0;
> > +
> > +clk_err:
> > +     clk_disable_unprepare(ci->core_clk);
> > +     return ret;
> > +}
> > +
> > +static int npcm_udc_remove(struct platform_device *pdev)
> > +{
> > +     struct npcm_udc_data *ci =3D platform_get_drvdata(pdev);
> > +
> > +     pm_runtime_disable(&pdev->dev);
> > +     ci_hdrc_remove_device(ci->ci);
> > +     clk_disable_unprepare(ci->core_clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id npcm_udc_dt_match[] =3D {
> > +     { .compatible =3D "nuvoton,npcm750-udc", },
> > +     { .compatible =3D "nuvoton,npcm845-udc", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, npcm_udc_dt_match);
> > +
> > +static struct platform_driver npcm_udc_driver =3D {
> > +     .probe =3D npcm_udc_probe,
> > +     .remove =3D npcm_udc_remove,
> > +     .driver =3D {
> > +             .name =3D "npcm_udc",
> > +             .of_match_table =3D npcm_udc_dt_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(npcm_udc_driver);
> > +
> > +MODULE_DESCRIPTION("NPCM USB device controller driver");
> > +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
>
> Should that address also be recorded as the patch author?
I prefer to use this e-mail since this is my main e-mail.
>
> > +MODULE_LICENSE("GPL v2");
>
>
> Kind regards,
>
> Paul

Best regards,

Tomer
