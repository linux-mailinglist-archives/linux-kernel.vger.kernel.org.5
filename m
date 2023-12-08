Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C198C80AE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574762AbjLHVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjLHVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:03:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67483BD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:03:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so30941591fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702069408; x=1702674208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCi2po4nRjlaziOyq9XY4t2jyFLyXekskEb5+lw8sWc=;
        b=1FOuNTasBWa0n+ZFv9ai/qECmd1LcuKQi7m7Qdv8W+/hRj38cHVrGid2zLT9Gie+yZ
         hAtOLmHFZT3sYiuF40Rojoyv/YLseE48fVk36wcktDtE8LRVtehuvBpBqKTAnmj0/qm8
         NNYChi1p5STltx0JiMMjBVIXQaTRb7ZHCFQMOG+EfjlpHmsRPvgNmqfk0C3NACMNGHSZ
         k1CYSu/sFCNC4v0x1Hc5n7f4rkfhK/GuPrHmliybF1XYqj7iKQ9NEYjLKL2vxtxYFmKP
         6fU6GOsTgppCg1Qgb3of7cyPMW4ocgo0psENWsXTteCbhps6x4bXQ4Oc5jgw7cxoP4Bf
         LOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069408; x=1702674208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCi2po4nRjlaziOyq9XY4t2jyFLyXekskEb5+lw8sWc=;
        b=TDlNJfPUqgNjISdas6Bnp+RfUPJ0DvqH+xL2ppnEMEPxm7hxpSY9KirQkzmWOMdoW1
         vWS3Br+Wi5aHerYShQ7ngc3ukRsTTehii7hX8cg91PusJOZrjTozHj41LeaQ4oElYeet
         9k295HPV14Fw/f+guw8dfxcJUQIFWIhOpKevijObqj1JpNipNyL7cxsQ85mOaaIe5GGM
         haJ7JIGRZGj4DtXA5CyDQ68A0eD82yErqt5Njg3aOdN764byu31oa/LinJER3bl3gB10
         ecUMw7HqYUeBzzOWR0cWp8+iPT5bx1caVwYT+w3grn5lVf9AO/bf+YJA7UmRFB3CjLDw
         VYLw==
X-Gm-Message-State: AOJu0YyheYh0tWDAdfYjpzlA8uA839oy5oLov1lIIn86iu4/LcNdUxKY
        cTNbUCyzijfD1jVDyoOXmumwOJCZBz2GuplBnXlNEA==
X-Google-Smtp-Source: AGHT+IHj15CpIXY/CgfF9I+sEq3Guw0XiYVd37u32w3HFLRyzYYLSheTV91Zlsxf/OrVKjPH5Qm0mFm0WpmvcRM5Dj4=
X-Received: by 2002:a2e:9ec4:0:b0:2ca:1a1:c286 with SMTP id
 h4-20020a2e9ec4000000b002ca01a1c286mr141361ljk.74.1702069408580; Fri, 08 Dec
 2023 13:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com> <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
In-Reply-To: <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 8 Dec 2023 15:03:17 -0600
Message-ID: <CAMknhBGKaVmfs6rhb7RfzMEvji8G-BFBu4=QZSS0WSrfL7rrqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 9:52=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> This adds a new driver for the AD7380 family ADCs.
>
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
>
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

...

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index bee11d442af4..e046d8004f41 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
>  obj-$(CONFIG_AD7292) +=3D ad7292.o
>  obj-$(CONFIG_AD7298) +=3D ad7298.o
>  obj-$(CONFIG_AD7923) +=3D ad7923.o
> +obj-$(CONFIG_AD7476) +=3D ad7380.o

copy/paste oops: should be CONFIG_AD7380

>  obj-$(CONFIG_AD7476) +=3D ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
