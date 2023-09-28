Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF837B251B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjI1STS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1STR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:19:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48F99;
        Thu, 28 Sep 2023 11:19:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32488a22810so816718f8f.3;
        Thu, 28 Sep 2023 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695925153; x=1696529953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/vYG8CJ/ewvJ2G4SHIfjDvp/E77tz/2UvBKFbRj/OM=;
        b=lkEIwUBJcgz3w1n8+0KuwHDPVHp7o6QRATLJFyobfjPlx6EIplO8BHWk/OU2qHRtwg
         LL+Zf3YzCmFTVO+pr6ZEQRvuI14qVOjnJVW6jw3gCzoNYxTpCagjHGBqMMj3WsGlrjtR
         gqu5X1JI2VgwiuPyA+2R1z9UG80JYxg9D848eQz//o5dTjuzdtHR+er4ZyiF+3EBwe9Y
         uMEyYpLmotHx1Li1GhiTtdfRgV9UxWO9x65POAP90j9zrin2beVZdATjGegiIAq00BAO
         XaBApHbheo01iLQe5hlBxuF5b1tS0EUpILOus/Y8BcOEOIY+TG9QlftIDxoNs8r7FvX/
         phUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925153; x=1696529953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/vYG8CJ/ewvJ2G4SHIfjDvp/E77tz/2UvBKFbRj/OM=;
        b=M+EOMdulBXJkZ/+do9BpmIrn5rvVEpdaO1DBNeuR0HUWeKKFPizH5/34pNurl/Z2Yq
         GLdo7kZK5yza6kwlLTKfAxw6agZFNZixWCncSNkRrXgj1cOqO7hlTvhsQbsj+8+9ly93
         ktgN4oMZ+iRF05MKx5FYp2DGRv6SdKAD8GZg1lbzgoz86NJlZscGTE1zmm1B2o4/4vtd
         I56suwEi5akTeu3rA6UzQhjobJ5VpCYdierlEW/TNaXigrG4HFfuvdPStAWg/zU64OE5
         T6tMF+8UX8OAO6muBpow9xNmXVDK7DQUuaYmPxK+dia55qmtceLcHZG6Qy39QunpsUgr
         nExw==
X-Gm-Message-State: AOJu0YxAlSeu1jfmqyzReXkJvuBE5agcrILuiJYrbyBoDHEF4Odjrbth
        mg2pCiF0ygY8YwxqnDOQaLOroVeFk0PgY40pCqw=
X-Google-Smtp-Source: AGHT+IEkXnAd53of4antYDJ+mebfWoU45tHrRpXzvuqB49hiREtfEaw/BcVrqDN2SzGAfN7vXbEQS6lOPaT+Cixw1HM=
X-Received: by 2002:a05:6000:1006:b0:31f:9b4f:1910 with SMTP id
 a6-20020a056000100600b0031f9b4f1910mr1808253wrx.63.1695925152811; Thu, 28 Sep
 2023 11:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com> <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
In-Reply-To: <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 28 Sep 2023 23:49:01 +0530
Message-ID: <CAM+2EuKb9-Wc+HAmsmPfmdM49k=7yoXboDF+swaMS_bgXbCOQA@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Uwe Kleine-K=C3=B6nig,

On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> > The Bosch BMI323 is a 6-axis low-power IMU that provide measurements fo=
r
> > acceleration, angular rate, and temperature. This sensor includes
> > motion-triggered interrupt features, such as a step counter, tap detect=
ion,
> > and activity/inactivity interrupt capabilities.
> >
> > The driver supports various functionalities, including data ready, FIFO
> > data handling, and events such as tap detection, step counting, and
> > activity interrupts
> >
> > Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloa=
ds/datasheets/bst-bmi323-ds000.pdf
>
> Maybe put this link better in the driver.

Yes, if there are multiple commits on the driver, the datasheet
link will move further down with the initial commit. I will add
datasheet link in the driver.

>
> > +static struct i2c_driver bmi323_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "bmi323",
> > +             .of_match_table =3D bmi323_of_i2c_match,
> > +     },
> > +     .probe_new =3D bmi323_i2c_probe,
> > +     .id_table =3D bmi323_i2c_ids,
> > +};
> > +module_i2c_driver(bmi323_i2c_driver);
>
> If you want to compile this driver after v6.6-rc2 (which includes
> commit 5eb1e6e459cf ("i2c: Drop legacy callback .probe_new()")) better
> use .probe here instead of .probe_new().

Thanks for pointing it out.
I switched to v6.6-rc3 and I will change to .probe.

Regards
Jagath

Jagath

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
