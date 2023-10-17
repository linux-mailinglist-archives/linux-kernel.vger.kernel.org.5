Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FD7CCDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjJQURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjJQURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:17:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5E6EAB;
        Tue, 17 Oct 2023 13:07:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so3139907e87.3;
        Tue, 17 Oct 2023 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697573245; x=1698178045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAg++LrW3itK5V1WlKpiZ2b/nQX2LkLJrp9r6Hg+m/U=;
        b=fyla5S4OvCipJM/zDK1s9UNIRpBC7Mjb63FEuf2qgq0w3eZv54ii8U42n1acRtFlSw
         yq7k00GwzCMKz4jmt+KiJkYiSeUE/4cmbNDHSYktDKIdlWGDYIgNhcs0DFWG1Jl56MPo
         uo6VDd30BbtIAiX3au4GT4clz9qYZ4VUaSb7GVary8cdy8mjgcBsXph+n7+UvIUE7AoH
         7mi5/PZBMvos2gTshF8dLYuXvkjs29nNkgprcGMwjmduhikymaPHRKGLQSYw/ppFrHSb
         /HoLYon3T3DmFb9hMflTuH3GBB7EBwfTrBPnNSWY58le9XUVTjeEAky+5tYHtIxK8GAw
         wmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573245; x=1698178045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAg++LrW3itK5V1WlKpiZ2b/nQX2LkLJrp9r6Hg+m/U=;
        b=HtHe4gpvG1/Y25iUr/McroqkQAACDbn8l4UYVUY+3hpxnmYhm+zFKLGcxrWWSIf9tj
         5e0xZcVmweCm1OB3ljG7Mz2/tKBA3elFabB1LcfC5ALm3RNKWq9dg28ZkZWiiepYB1pq
         2HIwyQybQgh8EBu0ntTy1jkfMkc8lMiz+iiaWi27T9mML+bZ62hdh1cNfSGlkYrLCOOY
         mkgXJ2/LVHcu9Hx9yqTzOn4nluo2YmE2CcJVYi47k1o2S1NtrrgN18lZ2o89zOBzRU6r
         pGhmd1VbMuY6cK31IHvaKcXW0Yy4RPtbgcm9GixbVWGycwt0/duMt9Pm8rzOgq/LuEhE
         rZ6w==
X-Gm-Message-State: AOJu0Yx4Pt1zgTrZSevJIRBWWt7tA9ZRqc9ycdsQ2Vh4naix6XvSDelp
        EYxx/1w0ICTi/SKl2XyuqWDik/mHPSq4Kdg9csY=
X-Google-Smtp-Source: AGHT+IEqwRenbscVZ0NA7c0QZm2NZMJwFuAjJu03tHzrSKrWUtbnnSQutaqDUbCBHGH8REY6dKqpQ5X1YCi2LT8F0nQ=
X-Received: by 2002:ac2:4827:0:b0:507:9f4c:efc8 with SMTP id
 7-20020ac24827000000b005079f4cefc8mr2339662lft.14.1697573244534; Tue, 17 Oct
 2023 13:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666614295.git.mazziesaccount@gmail.com> <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
In-Reply-To: <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Wed, 18 Oct 2023 01:37:12 +0530
Message-ID: <CAM+2Eu+Xp6j1ppLd+zHMTu6jfc6DQKBShfe-nAyokVi0MUmoSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: Support Kionix/ROHM KX022A accelerometer
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Matti,

On Mon, Oct 24, 2022 at 6:10=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g), and probably some other cool features.

This is a nice driver, and I found it very helpful as a reference.
One question regarding scale please see below.

> + * range is typically +-2G/4G/8G/16G, distributed over the amount of bit=
s.
> + * The scale table can be calculated using
> + *     (range / 2^bits) * g =3D (range / 2^bits) * 9.80665 m/s^2
> + *     =3D> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are z=
eroed
> + *     in low-power mode(?) )
> + *     =3D> +/-2G  =3D> 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
> + *     =3D> +/-2G  - 598.550415
> + *        +/-4G  - 1197.10083
> + *        +/-8G  - 2394.20166
> + *        +/-16G - 4788.40332
> + */
> +static const int kx022a_scale_table[][2] =3D {
> +       { 598, 550415 },
> +       { 1197, 100830 },
> +       { 2394, 201660 },
> +       { 4788, 403320 },
> +};

Given that the integer part is non-zero, and
IIO_VAL_INT_PLUS_MICRO is returned for read_scale,
As raw value will never be fractional how does this
correspond to a reading of 9.8 m/s=C2=B2 for the Z-axis?

> +
> +static int kx022a_read_avail(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            const int **vals, int *type, int *length,
> +                            long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *vals =3D (const int *)kx022a_accel_samp_freq_table;
> +               *length =3D ARRAY_SIZE(kx022a_accel_samp_freq_table) *
> +                         ARRAY_SIZE(kx022a_accel_samp_freq_table[0]);
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (const int *)kx022a_scale_table;
> +               *length =3D ARRAY_SIZE(kx022a_scale_table) *
> +                         ARRAY_SIZE(kx022a_scale_table[0]);
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}

Regards
Jagath
