Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6B7FFDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377021AbjK3Vuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjK3Vuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:50:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C510F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:50:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so18137991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701381057; x=1701985857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aANyBr2T0t8LeKYSkonqHHH3ddTbNb3vuWdQ0g12q+Q=;
        b=wPqbnp5qRtfp082LnkkE85atm3ai15hClOrgxH6TPBNETyZNCpcH/qjtLUfN7cQKtI
         bMTA0rqlEolb32uyNkz1HxvbutaB6wTKhJCOGnzKhRi4UewsaSh/QM/8sAHq38spLDzT
         KLoSUBpSmdV1eJgKTqeAz1Gzps830CBLFa2rMRRgDk/rjfINktB0nKMr8Gx8uRM72f/4
         BukNYUQV/kZJRv8+XUYZ/GR3DkLp/+QQZymLbG/bWxIxe/gJSguC/9/mr6WVJO34LClf
         G8h6xe7nP6ufrCRt3DWIoG52TC7gVCNhPKji9sTmZXB9szz4BnJjER6fF2GPRjdSFCzc
         ID4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381057; x=1701985857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aANyBr2T0t8LeKYSkonqHHH3ddTbNb3vuWdQ0g12q+Q=;
        b=OnIapn3LcI6OfWa13bspgAqOLwndZamDYaaVGT1i4CCOKrT2bMDABdnode85cXqFZI
         VoY9VlDj9oszBJeEj0AG9wDwjPxunnIcpXff2DmEZyrs4GgPTAE5AcRZ8iGQFPT2y++n
         rg7aTCP9f5w+mYp2fYzIkAEDDZR5kYYleUAkqOCBiQt4WdmTUFTy6K+ksd2EILfaUcw+
         f7BBK5Uw+5/JxaHHb/NtDn9LE+OoXEFzM2YOtroINQm+PPb24Xbc3RsxlN7h1/QEUHoX
         T86msXdGAtHcn9AP2HHVw2I29kzlgbUY/fL+Q48h2glT5cDiYDp/RQmiJ3k5CSBt685C
         KFLA==
X-Gm-Message-State: AOJu0YwSGeoLA6qSRV/SSLk0B1MRGnTgddNonpiW2wzkBdOncuxX2uNT
        ofWFqk3/OcH0zGwVVzdH71Xt1XlFyWxrq4NhSzhr3A==
X-Google-Smtp-Source: AGHT+IGTreSyOMteX5Yn0pCJXOJ23n2w1uz7JmQUqmbNcKkrGMdUipIFSV2GkcHhgdqYisB6JJKbOnVn4oDTwdlFnHo=
X-Received: by 2002:a2e:8503:0:b0:2c9:bacc:1285 with SMTP id
 j3-20020a2e8503000000b002c9bacc1285mr117766lji.47.1701381056908; Thu, 30 Nov
 2023 13:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 15:50:46 -0600
Message-ID: <CAMknhBHsFS5p-_250WRmkH2za+QPV6WyKNfgD-E1W8=HV3W3fg@mail.gmail.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct ad9467_state
To:     nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> are done which means we need to properly protect the whole operation so
> we are sure we will be in a sane state if two concurrent calls occur.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 04474dbfa631..91821dee03b7 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> -
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>

Ah, the case of the misplaced header from the previous patch is solved. :-)

>  #include <linux/device.h>
> @@ -122,6 +122,8 @@ struct ad9467_state {
>         unsigned int                    output_mode;
>
>         struct gpio_desc                *pwrdown_gpio;
> +       /* protect against concurrent accesses to the device */
> +       struct mutex                    lock;
>  };
>
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv =
*conv, unsigned int reg,
>         int ret;
>
>         if (!readval) {
> +               guard(mutex)(&st->lock);
>                 ret =3D ad9467_spi_write(spi, reg, writeval);
>                 if (ret)
>                         return ret;
> @@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *=
conv, int val, int val2)
>                 if (scale_val[0] !=3D val || scale_val[1] !=3D val2)
>                         continue;
>
> +               guard(mutex)(&st->lock);
>                 ret =3D ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
>                                        info->scale_table[i][1]);
>                 if (ret < 0)
>
> --
> 2.42.1
>
>

Alternately, this could probably be solved with spi_bus_lock/unlock
and spi_sync_locked rather than introducing a new mutex.
