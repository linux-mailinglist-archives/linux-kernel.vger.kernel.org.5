Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05C7EC780
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKOPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKOPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:38:34 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FBA1AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:38:29 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59b5484fbe6so78929987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700062709; x=1700667509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrqmeQ1b3jWvPwiKhEDKttHMvlM+GcVpLzujKePYQsk=;
        b=CuxKxtnH4kzYw+M0xHyaxgP5+GGYXJ70eWVH8/FRkTEnTsxVm22mn6BbJP9uUi03lY
         0tAwykSybKQkXS90Wv/4gw0D4VBWZ/e9Ka9Wc9cG9q7jF7d/q79P4Y2gZ2nl/m2dZpbi
         VK+ROHI9Za+s/gCknoD7RxhFNCR957NT1tlARx9LTG8Y9ROPFo0NXLggv++9mTpPg/1i
         jlkWFnlgKKWCFFjjGmxu6z79kJpvOkEWm2Rc31aB5VyCe0E6M+ThHd+muRI5k+j4ThYG
         zOd7zCSNhrHCMIielG9tp4KAMxKWW3z3z7aO+t6wPig1gOFM4cZsVrccaTidEy3jpI42
         LbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062709; x=1700667509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrqmeQ1b3jWvPwiKhEDKttHMvlM+GcVpLzujKePYQsk=;
        b=TrGCNonKGIXWiM+Ffu7OesHe6gNusa0HoXVunwkydRr8nlBL5U7WYEjDKyiUTWd8xe
         YlO8wKSqCzy7o8JJ+kYKudL2++XwH4GSnhjivG7hSN5yZ80QEuGK2fYf/8RhrMHHXf3E
         iLNcUiXlLPM3RiKQuGRLwSFuhu7x8k4ZtUwD2dZ7DLwGWOQXaOPoioJ4b9pmhJSBrs9g
         OEbPCw2oMoPKlkSed7pF1XxhnYs9yJNIMSIvXdqyg3uRTD2Fbq0FT5ZCccPwHKzJkrJS
         yLGCSxwgRi5GAkDCK7bw5T+7c7egzMhqZqiwLl4g5+OzmpgnMFtFIRIqmAlg+FdgtPVA
         86oA==
X-Gm-Message-State: AOJu0YyY5hdHtHY3wjZTSJoQmYPtUWWPLIT4yuOx0re7E3L2x0VwVb3f
        5GsoK2OLBbbrTEg1VXehf1BdmfNO9G/Z6KaSqMRRaA==
X-Google-Smtp-Source: AGHT+IHle69HGMM73axSbTrxTEchdRM11aGWeB2nuHgAcv5unqlb5d7O8Uri7BhbV0Cqu/PwgfL+Pytmev0WUwA2OgM=
X-Received: by 2002:a0d:e855:0:b0:5a7:f002:4fe4 with SMTP id
 r82-20020a0de855000000b005a7f0024fe4mr14385322ywe.23.1700062709022; Wed, 15
 Nov 2023 07:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Nov 2023 16:37:52 +0100
Message-ID: <CAPDyKFrZdHseZ6udjNSdOG7hwK82G1wT30j39A1KwKBAaY_cMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 12:15, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The SPI_MASTER_HALF_DUPLEX is the legacy name of a definition
> for a half duplex flag. Since all others had been replaced with
> the respective SPI_CONTROLLER prefix get rid of the last one
> as well. There is no functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

> ---
>  drivers/input/rmi4/rmi_spi.c             | 2 +-
>  drivers/mmc/host/mmc_spi.c               | 2 +-
>  drivers/net/ethernet/micrel/ks8851_spi.c | 4 ++--
>  drivers/usb/gadget/udc/max3420_udc.c     | 2 +-
>  include/linux/spi/spi.h                  | 2 --
>  5 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
> index 852aeb0b2c07..07c866f42296 100644
> --- a/drivers/input/rmi4/rmi_spi.c
> +++ b/drivers/input/rmi4/rmi_spi.c
> @@ -375,7 +375,7 @@ static int rmi_spi_probe(struct spi_device *spi)
>         struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
>         int error;
>
> -       if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
> +       if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
>                 return -EINVAL;
>
>         rmi_spi = devm_kzalloc(&spi->dev, sizeof(struct rmi_spi_xport),
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index cc333ad67cac..b0cccef4cfbf 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1322,7 +1322,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>         /* We rely on full duplex transfers, mostly to reduce
>          * per-transfer overheads (by making fewer transfers).
>          */
> -       if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
> +       if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
>                 return -EINVAL;
>
>         /* MMC and SD specs only seem to care that sampling is on the
> diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
> index 70bc7253454f..7c41623dac90 100644
> --- a/drivers/net/ethernet/micrel/ks8851_spi.c
> +++ b/drivers/net/ethernet/micrel/ks8851_spi.c
> @@ -156,7 +156,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
>
>         txb[0] = cpu_to_le16(op | KS_SPIOP_RD);
>
> -       if (kss->spidev->master->flags & SPI_MASTER_HALF_DUPLEX) {
> +       if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
>                 msg = &kss->spi_msg2;
>                 xfer = kss->spi_xfer2;
>
> @@ -180,7 +180,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
>         ret = spi_sync(kss->spidev, msg);
>         if (ret < 0)
>                 netdev_err(ks->netdev, "read: spi_sync() failed\n");
> -       else if (kss->spidev->master->flags & SPI_MASTER_HALF_DUPLEX)
> +       else if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
>                 memcpy(rxb, trx, rxl);
>         else
>                 memcpy(rxb, trx + 2, rxl);
> diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
> index 2d57786d3db7..89e8cf2a2a7d 100644
> --- a/drivers/usb/gadget/udc/max3420_udc.c
> +++ b/drivers/usb/gadget/udc/max3420_udc.c
> @@ -1201,7 +1201,7 @@ static int max3420_probe(struct spi_device *spi)
>         int err, irq;
>         u8 reg[8];
>
> -       if (spi->master->flags & SPI_MASTER_HALF_DUPLEX) {
> +       if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
>                 dev_err(&spi->dev, "UDC needs full duplex to work\n");
>                 return -EINVAL;
>         }
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 255a0562aea5..7b4baff63c5c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1638,8 +1638,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
>  /* Compatibility layer */
>  #define spi_master                     spi_controller
>
> -#define SPI_MASTER_HALF_DUPLEX         SPI_CONTROLLER_HALF_DUPLEX
> -
>  #define spi_master_get_devdata(_ctlr)  spi_controller_get_devdata(_ctlr)
>  #define spi_master_set_devdata(_ctlr, _data)   \
>         spi_controller_set_devdata(_ctlr, _data)
> --
> 2.43.0.rc1.1.gbec44491f096
>
