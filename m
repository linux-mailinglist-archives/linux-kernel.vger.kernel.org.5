Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF67A989B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIURua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIURuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:50:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2296400CE;
        Thu, 21 Sep 2023 10:15:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-773c03f2ac4so64888485a.3;
        Thu, 21 Sep 2023 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316501; x=1695921301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSGt8GmgPTrgC8DHgC9SgthQTvKXBruCz417lKX/6DM=;
        b=AvbqNESZcyAC0HsTYxSp55kBu2C+j538N2kvN3hUf5P37VlwZH12jUmeUPCQpohjan
         0aBIw/IRXkGDrnWJWOxB0xWUf5ipaPjC/6HOYrz6nfo/r9HYmk79XqY83ToiJEyfvyHC
         X59w7pGZkzSsETAg7gOM32yjw1cQ9BSz8/shIOfFXvejirxqTjY6am/fpzCqt5wmS2Cb
         U9xcp4+/+ur5TD6DS09kDypk8qiiBQ50C27VigAxAQvu8wwFtalK7t0T5oGLZ5+/iBS3
         RuHYcQo3ivhd+WDMEz1HkgXWQ1qkALSdOt2X2C8GAQpv9Uxv3Y+OZ8vHGCJYknlrzfu3
         KkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316501; x=1695921301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSGt8GmgPTrgC8DHgC9SgthQTvKXBruCz417lKX/6DM=;
        b=miQnKgLQ7MrxQ3qDNsKr8GfSknMmI9ty3nrHtJagyynnatmuPAuc96dJgBTjTk0EJR
         66N645xOliwZyAFHb4ANNqasQM0DXCUWPsr0PSjdH0VqqIb3l4XhUUh9ZiTSV9gR5oal
         HyJxPfK5R9XwAar9Wxg2uQIbNfEHIuz6BmkcAwmfIw2AEmLlPP9udn2U79K0ylL2Eeg7
         RVc8CCZwb+bemi2leFF5V5FCAnY/TDEXtoR/LvehrvQej4vsc1iOFob/SRcScZCrF47i
         RZp1hb2KqK2CpgIyAyk+cYPGcfGCEq2A2skZIjhD2Tz+HrWTfJuIASk2RGfZbx6jhXag
         U6yA==
X-Gm-Message-State: AOJu0Yx5oBQvfWD32by/1orHPGSEAXxV+0SpfK4HmsKGbC+kiWrdQf0v
        xyt1CPY3rNSXIPcyOzZ3DOayXEHmiAO7or55qnjGkLOe0fF2EQ==
X-Google-Smtp-Source: AGHT+IHbKJswryODKEqx2Tbnn5V1qJQhZH1DF7k1r2FZCl7CPJ+76ehOvhPwRK35bBt25exHmoz9koX0UKVfur+k7H4=
X-Received: by 2002:aca:d10:0:b0:3ab:8cb8:1294 with SMTP id
 16-20020aca0d10000000b003ab8cb81294mr5315709oin.28.1695309633703; Thu, 21 Sep
 2023 08:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230913214944.59804-1-blarson@amd.com> <20230913214944.59804-7-blarson@amd.com>
In-Reply-To: <20230913214944.59804-7-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Sep 2023 18:19:57 +0300
Message-ID: <CAHp75VfRLv1=3M+a9pr=ZJgNwtBOrT9xi0UjDJMuY8uM9+ffSw@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:52=E2=80=AFAM Brad Larson <blarson@amd.com> wrot=
e:
>
> The Pensando SoC controller is a SPI connected companion device
> that is present in all Pensando SoC board designs.  The essential
> board management registers are accessed on chip select 0 with
> board mgmt IO support accessed using additional chip selects.

...

> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/reset-controller.h>
> +#include <linux/spi/spi.h>

types.h ?

> +#include <linux/uaccess.h>

...

> +       struct penctrl_device *penctrl;

> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];

These are not DMA-safe, is this a problem?

> +       struct spi_transfer t[2] =3D {};
> +       struct penctrl_spi_xfer *msg;
> +       struct spi_device *spi;
> +       unsigned int num_msgs;
> +       struct spi_message m;
> +       u32 size;
> +       int ret;

...

> +       /* Verify and prepare SPI message */
> +       size =3D _IOC_SIZE(cmd);
> +       num_msgs =3D size / sizeof(struct penctrl_spi_xfer);

sizeof (*msg) ?

> +       if (num_msgs > 2 || size =3D=3D 0 || size % sizeof(struct penctrl=
_spi_xfer)) {

Dito.

> +               ret =3D -EINVAL;
> +               goto out_unlock;
> +       }

...

> +       msg =3D memdup_user((struct penctrl_spi_xfer *)arg, size);
> +       if (IS_ERR(msg)) {
> +               ret =3D PTR_ERR(msg);
> +               goto out_unlock;
> +       }

Wondering if you can start using cleanup.h.

...

> +       /* Perform the transfer */
> +       mutex_lock(&spi_lock);
> +       ret =3D spi_sync(spi, &m);
> +       mutex_unlock(&spi_lock);

> +       if (ret || (num_msgs =3D=3D 1))
> +               goto out_unlock;

Second conditional will return 0. Is it by design?
Since it's not so obvious I would split these conditionals.

...

> +       spi->chip_select =3D current_cs;

spi_set_chipselect()

...

> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u3=
2 *val)
> +{
> +       struct spi_device *spi =3D penctrl->spi;
> +       struct spi_transfer t[2] =3D {};
> +       struct spi_message m;

> +       u8 txbuf[3];
> +       u8 rxbuf[1];

Not DMA-safe. Is it a problem?

> +       int ret;

> +       txbuf[0] =3D PENCTRL_SPI_CMD_REGRD;
> +       txbuf[1] =3D reg;
> +       txbuf[2] =3D 0;

Can be assigned in the definition block

       u8 txbuf[] =3D { ... };

> +       t[0].tx_buf =3D txbuf;
> +       t[0].len =3D sizeof(txbuf);

> +       rxbuf[0] =3D 0;

Ditto.

    u8 rxbuf[] =3D { 0 };

> +       t[1].rx_buf =3D rxbuf;
> +       t[1].len =3D sizeof(rxbuf);
> +
> +       spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
> +       ret =3D spi_sync(spi, &m);
> +       if (ret)
> +               return ret;
> +
> +       *val =3D rxbuf[0];
> +       return 0;
> +}

...

> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u=
32 val)
> +{
> +       struct spi_device *spi =3D penctrl->spi;
> +       struct spi_transfer t =3D {};
> +       struct spi_message m;
> +       u8 txbuf[4];

> +       txbuf[0] =3D PENCTRL_SPI_CMD_REGWR;
> +       txbuf[1] =3D reg;
> +       txbuf[2] =3D val;
> +       txbuf[3] =3D 0;

Can be assigned in the definition block.

> +       t.tx_buf =3D txbuf;
> +       t.len =3D sizeof(txbuf);
> +       spi_message_init_with_transfers(&m, &t, 1);
> +       return spi_sync(spi, &m);
> +}

...

> +       struct penctrl_device *penctrl =3D
> +               container_of(rcdev, struct penctrl_device, rcdev);

One line?

...

> +       spi->chip_select =3D 0;

spi_set_chipselect()

...

> +       struct penctrl_device *penctrl =3D
> +               container_of(rcdev, struct penctrl_device, rcdev);

One line?

...

> +       spi->chip_select =3D 0;

spi_set_chipselect()

...

> +static int penctrl_spi_probe(struct spi_device *spi)
> +{
> +       int i, ret;
> +
> +       /* Allocate driver data */
> +       penctrl =3D kzalloc(sizeof(*penctrl), GFP_KERNEL);

devm_kzalloc() ?

> +       if (!penctrl)
> +               return -ENOMEM;
> +
> +       penctrl->spi =3D spi;
> +       mutex_init(&spi_lock);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(penctrl_devices); i++) {
> +               ret =3D misc_register(&penctrl_devices[i]);
> +               if (ret) {
> +                       dev_err(&spi->dev, "Failed to register device %s\=
n",
> +                               penctrl_devices[i].name);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       /* Register reset controller */
> +       penctrl->rcdev.dev =3D &spi->dev;
> +       penctrl->rcdev.ops =3D &penctrl_reset_ops;
> +       penctrl->rcdev.owner =3D THIS_MODULE;
> +       penctrl->rcdev.of_node =3D spi->dev.of_node;
> +       penctrl->rcdev.nr_resets =3D 1;
> +       device_set_node(penctrl->rcdev.dev, dev_fwnode(&spi->dev));
> +
> +       ret =3D reset_controller_register(&penctrl->rcdev);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "failed to register reset controller=
\n");
> +       return 0;

> +cleanup:

err_cleanup: ?

> +       for (i =3D 0; i < ARRAY_SIZE(penctrl_devices); i++) {

  while (i--) {

> +               if (penctrl_devices[i].this_device)
> +                       misc_deregister(&penctrl_devices[i]);
> +       }
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko
