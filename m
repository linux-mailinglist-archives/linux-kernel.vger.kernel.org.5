Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A87F8F77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjKYV1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKYV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:27:18 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38206193
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:27:24 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f060e059a3so1832055fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700947642; x=1701552442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X02zGjhQuwfxCdCE8WnNqfJdr7djRtz+1k91SJ9Klbs=;
        b=m7ne2YBZm/oLfO56OJs1BRKWp5Gsz7lXY4wNyx5VDiiq4Xy/PjEgnAoKDfWj5kF61T
         twlWmEIMkPEoiVnDdPOq75xriTCFnbISPSGNpjSpzRk9ohem6YNrTtewZQ9P2UxBJ3Hi
         LtG68A7V1cAN84cpmFudpVBrvhp0iDbhCF8YG+jPJRoagNvEpl/U12HeZDUIOwptFS71
         gKwcBmLqv2i7gJB+cyoaUEhL93MLrmzSADs6Yjf4pxfjSeVXapYD+Pt8JeAnT25cDfMm
         x3PPF0c3TDOO6lBB3RiiGpI+XBoB6diUVmb4FaWsHnOj576pnoqifa8vgNWwCoXaNbFF
         OgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700947642; x=1701552442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X02zGjhQuwfxCdCE8WnNqfJdr7djRtz+1k91SJ9Klbs=;
        b=nn8w0PY8zBf6WAgF2l5KNYPyX1x85OtakyLf9HwR/yf8XvmZfAu0mwNAd4UaDwwXsQ
         KOYRmv63R42PxWmHz5uSGad68lEFNji+Zry7yYjhGimn89RmbelQEJcsuZoHs3ZCyCEi
         W8a5GBXu9NXNyuVsP53bPgp79v43wwElai8IRrfkHvOkj+870tYKA3MgLZuLly6YdQMf
         Ra9/08sk1pZT5uXjvVO2dmBfflO9jlK26Usb7AMG/7MrU+PUrY9eVdf7/yHXNU+YdVLn
         1amVVAEc/Ll6j8/lhzne7n6XGKG9iAXgsGTufwNNtHFr9mwJSr5CzjjqRt6iLddce3s3
         RthA==
X-Gm-Message-State: AOJu0Yy+rWNNb77FlvV7jnSqP+eNkpXtXQpPlwk+RaDufcx1jZugeEG9
        KZbrAlJlurWVmTYDeFxEwzF40duuyjmGnHWfTzMSksBeHcV7wDqnbpM=
X-Google-Smtp-Source: AGHT+IFzl7Za771ZdEl8EOL4JMHOCp/mB2Kuy5ayLYY5XJ41fARPWbJDDL32ChE682qbAl2nwS0QTXP6X6nS0UD+ivk=
X-Received: by 2002:a05:6870:c1ce:b0:1f9:8f0e:1c56 with SMTP id
 i14-20020a056870c1ce00b001f98f0e1c56mr9029500oad.50.1700947642595; Sat, 25
 Nov 2023 13:27:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700648164.git.cmo@melexis.com> <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
 <20231125175318.25c0d6ea@jic23-huawei>
In-Reply-To: <20231125175318.25c0d6ea@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 25 Nov 2023 22:26:46 +0100
Message-ID: <CAKv63us6yi2qaGLi3UgT=pfQ7QnxyM02FreD-qHnzTnKGSkRFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 at 18:53, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 22 Nov 2023 11:24:06 +0100
> Crt Mori <cmo@melexis.com> wrote:
>
> > MLX90635 is an Infra Red contactless temperature sensor most suitable
> > for consumer applications where measured object temperature is in range
> > between -20 to 100 degrees Celsius. It has improved accuracy for
> > measurements within temperature range of human body and can operate in
> > ambient temperature range between -20 to 85 degrees Celsius.
> >
> > Driver provides simple power management possibility as it returns to
> > lowest possible power mode (Step sleep mode) in which temperature
> > measurements can still be performed, yet for continuous measuring it
> > switches to Continuous power mode where measurements constantly change
> > without triggering.
> >
> > Signed-off-by: Crt Mori<cmo@melexis.com>
> Hi Crt,
>
> Very nice. A few minor bits inline.
>
> Note (as normal for me), I haven't sanity checked any calibration maths - just assuming
> you got that bit right as don't want to spend ages comparing datasheet maths to what
> you have coded up + I'm not sure I can get the datasheet anyway :)
>
> Jonathan
>
Hi Jonathan,
Maths I have unit tests where I did floating point (which will be
released as embedded library same as for 90632) to integer conversion
and ensure that the delta is less then the error of the sensor. So
math I take full responsibility :)

Datasheet will be public probably in March, when hopefully the sensor
is already part of the main Android kernel as well. But your review is
anyway very valuable and detailed. Thanks for all the remarks - there
is just one discussion below I would love to complete for future
reference.

Best regards,
Crt
>> ...
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "Powering EEPROM failed\n");
> > +             return ret;
> > +     }
> > +     usleep_range(MLX90635_TIMING_EE_ACTIVE_MIN, MLX90635_TIMING_EE_ACTIVE_MAX);
> > +
> > +     regcache_mark_dirty(data->regmap);
> > +
> > +     ret = regcache_sync(data->regmap);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "Failed to cache everything: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = regcache_sync_region(data->regmap, MLX90635_EE_Ha, MLX90635_EE_Gb);
>
> Why is this needed given you just synced the whole thing?
>

Well, this is the discussion I wanted to have. I expected
regcache_sync to perform i2c read of all the read_regs defined in
regmap to get them to cache - but it didn't. Then I expected the same
from sync_region, but it didn't, so I manually read them below.

So discussion I want to have is: why would we regcache_sync, if no
reads are performed? And second one is why would we return EBUSY for
volatile register range when cache_only is active?

Current driver implementation is very specific in bypassing all these,
so I am quite certain this regcache_sync_region here is not needed and
below regmap_async_complete as well, but I cannot be sure, since
regcache_sync doesn't really do the job I would expect it to do. I
looked into the code, but could not find the reason, why I do not see
any reads on oscilloscope and why I need to physically read registers
below, so that they are cached. regmap totally knows which registers
it should cache, but it does not at init, nor at regcache_sync
request. And if you remember in 90632 I had a similar remark, but
could not reproduce as EEPROM was readable in most powermodes (well
all used in driver), now I checked with scope and since I know this
chip does not allow EEPROM reading during the step sleep mode, so
everything was much easier to conclude.

> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "Failed to sync EEEPROM region: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = mlx90635_read_ee_ambient(data->regmap, &PG, &PO, &Gb);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "Failed to read to cache Ambient coefficients EEPROM region: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = mlx90635_read_ee_object(data->regmap, &Ea, &Eb, &Fa, &Fb, &Ga, &Gb, &Ha, &Hb, &Fa_scale);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "Failed to read to cache Object coefficients EEPROM region: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = regmap_async_complete(data->regmap);
>
> What is this syncing here for? Several calls above include internal calls to this.
> My knowledge of this stuff is limited, so I may well be misunderstanding what this does.
>
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "Failed to complete sync: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +}
>
> ...
>
...
> > +     mlx90635 = iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> > +     mlx90635->client = client;
> > +     mlx90635->regmap = regmap;
> > +     mlx90635->powerstatus = MLX90635_PWR_STATUS_SLEEP_STEP;
> > +
> > +     mutex_init(&mlx90635->lock);
> > +     indio_dev->name = id->name;
>
> Not keen on doing this as it can be fragile if id and of tables get out of sync
> or we are using backwards compatibles in dt bindings.
>
> Given only one part supported, just hard code the name for now.
>

Can you elaborate? Because I have the same thing in 90632 and I would
fix there as well. I assumed this is for linking to dt, to ensure it
is defined there?

> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->info = &mlx90635_info;
> > +     indio_dev->channels = mlx90635_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(mlx90635_channels);
> > +
...
>
> > +     if (MLX90635_DSP_VERSION(dsp_version) == MLX90635_ID_DSPv1) {
> > +             dev_dbg(&client->dev,
> > +                     "Detected DSP v1 calibration %x\n", dsp_version);
> > +     } else if ((dsp_version & MLX90635_DSP_FIXED) == MLX90635_DSP_FIXED) {
>
> FIELD_GET() for that bit then just check if it is 0 or 1
>
> > +             dev_dbg(&client->dev,
> > +                     "Detected Unknown EEPROM calibration %lx\n", MLX90635_DSP_VERSION(dsp_version));
> > +     } else {
> > +             dev_err(&client->dev,
> > +                     "Wrong fixed top bit %lx (expected 0x8X0X)\n",
> > +                     dsp_version & MLX90635_DSP_FIXED);
>
> I'd like to understand what breaks if this happens but we carry on anyway?
> I'd 'hope' that any future DSP version is backwards compatible or that there was some way to know if
> the difference between backwards compatible versions and ones that aren't.
>
The top bit in high nibble is fixed to 1, to ensure that we have
endianness correct in the wild. We did the same later on in 90632
where we had plenty of trouble the way people read 16 bits. So if that
top bit is not there (bottom nibble has it hardcoded to 0), then for
certain we do not have the correct chip. And as for compatible DSP
versions: when we release incompatible one, I will upgrade the driver,
otherwise we have some more slack in the driver to keep on working,
because that was also lesson learnt from my side in 90632 as there are
compatible DSP versions possible and used, but we are still honest and
bump also the DSP version here.
> > +             return -EPROTONOSUPPORT;
> > +     }
> ...
>
>
