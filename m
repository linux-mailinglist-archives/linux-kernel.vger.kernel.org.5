Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AC778A87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjHKKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjHKKBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:01:36 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996372728;
        Fri, 11 Aug 2023 03:01:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-584243f84eeso20076767b3.0;
        Fri, 11 Aug 2023 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691748095; x=1692352895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jlLRMZA4ImN3IG+gJngij67oCQSqkgKuM7jpk7yrV4=;
        b=OQe4aN8Lsjf/ZUfPAWbjEz4s+xbjHza0Lpgc3a6I753AC6T5ZZ1uLCee13b8IPAYnn
         tuw9xp8JT/7rj/GPfE53ELn8lZM6Cpj7FeRYGGF9XK5tdvE95B4iCEgoo7ESl4ve2cop
         L7GYB8oQVDQ+TcwubnuI1ekOkqi8xz0bNgCaEvXj0aTOsYlmwRV99YWHowyj/MTshy2X
         1DH3CF+/4ERWutr5Qp1WluY/QE13zq4khXZ+rQqed6NPBoknOPI8lHwq25ISCoC5DfjJ
         MZGRbik4KuQ2GBogS+/p+S4MCzi2ummcJxiGtDFdC+UfXPvFWE8jgxx+v45qdK2jOXsB
         8rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748095; x=1692352895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jlLRMZA4ImN3IG+gJngij67oCQSqkgKuM7jpk7yrV4=;
        b=HD+fgPpvs1R8zSbQGfwPDbdxx25y/qkHGWwc9NfntpVFwKNOQHlbsz/yOyoev2MR+L
         msf0DtTrYd9OMp4Nh0uF9yOylJXOrC+6y7jmElwu5ePWsO9ZxJzT8Y8HEZdGJji/nHCl
         z8g/rgQjtCsWXV1kU/jc0RX2KTRdTQGIRWHEgAr3brBrFll0W9l0QbX1pGx53lKMeMcX
         6iqFMUeeal+fR0QSRstF8bE7MdKNfssBEpGURsFqiISZKDavbqp/WsDJtCUkn+9LYDYU
         2x6DNQIQN6BM6vNTKSbZogTtg9wfr4nRq0gbprPzkCwE4UY2Gf9lBQGkyx9sAgvO+h8V
         B2Qw==
X-Gm-Message-State: AOJu0YzoN6cE3ALlIxcOV7p8+jPIgLvNY2ZVbhHnxpBVnwSKGT+A4FaV
        /zBu/suwSSiliNr6xChwVXdf/oO9IsU0EF/SDUU=
X-Google-Smtp-Source: AGHT+IEnu2OvzwpUgMjjfCjSegLblfYWP+kwUstZrBQQx1DyOExHUjDT+EDCcwRGZLlF9vDIwgp+Xfe1vTScE2//1TI=
X-Received: by 2002:a0d:f984:0:b0:57a:8ecb:11ad with SMTP id
 j126-20020a0df984000000b0057a8ecb11admr1385264ywf.43.1691748094713; Fri, 11
 Aug 2023 03:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691607526.git.mehdi.djait.k@gmail.com> <8fb74f21bda4949a862bcb4bb1ed4f0acb135948.1691607526.git.mehdi.djait.k@gmail.com>
 <ZNYDa+Un5bl5y9vT@smile.fi.intel.com>
In-Reply-To: <ZNYDa+Un5bl5y9vT@smile.fi.intel.com>
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
Date:   Fri, 11 Aug 2023 12:01:23 +0200
Message-ID: <CAFukWp2w2KwE+Obt1DWTcT81DbN7FdMNVo2Q7MSvjNi=_0uBRA@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Hello Andy,

Thank you for the review.

On Fri, Aug 11, 2023 at 11:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 09:11:36PM +0200, Mehdi Djait wrote:
> > Add the chip_info structure to the driver's private data to hold all
> > the device specific infos.
> > Refactor the kx022a driver implementation to make it more generic and
> > extensible.
>
> ...
>
> > +     chip_info =3D device_get_match_data(&i2c->dev);
> > +     if (!chip_info) {
> > +             const struct i2c_device_id *id =3D i2c_client_get_device_=
id(i2c);
>
> Missing blank line.
>
> > +             chip_info =3D (const struct kx022a_chip_info *)id->driver=
_data;
> > +             if (!chip_info)
> > +                     return -EINVAL;
> > +     }
>
> ...
>
> > -     if (val > KX022A_FIFO_LENGTH)
> > -             val =3D KX022A_FIFO_LENGTH;
> > +     val =3D min_t(unsigned int, data->chip_info->fifo_length, val);
>
> min_t() is a beast. Please, use min() if no special requirement for
> min_t() here, otherwise explain why.

No actual reason, you suggested min_t or min for a previous version

>
> ...
>
> > +     data->fifo_buffer =3D kmalloc(data->chip_info->fifo_length *
> > +                                 KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_K=
ERNEL);
>
> kmalloc_array()

Should I send another version for this ?
The usage of kmalloc is quite straightforward and easy to understand here.

--
Kind Regard
Mehdi Djait
