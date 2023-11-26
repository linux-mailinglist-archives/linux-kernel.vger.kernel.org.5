Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958C7F9513
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZTjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZTi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:38:58 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D4FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:39:04 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f060e059a3so2174966fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701027544; x=1701632344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQQcvauD4AnDngHziaZiwAO5Pne6N9UA8wUl/1bPLHs=;
        b=j4stSEKfzRrXf7p4J+43+WPiq02V1AdyIuz5PCSe5s/tCzX2uIQBMfww7v8yGRUlNY
         cIVcEQ/O3HjCwhMJPyEWNOM/LMx3RfUeO67jSgTuS+7nW718326oHFI7xcIMSWvOPb1a
         I3gOcGWrFQWoa66aWU8B92fiUPT2DB8HUSZlfykgksOJYhly1ptriudo15qwZLtU4glW
         zoo1FJI3qxEON/l9LwqNZ353PrGH53Ro128EcZQgx4OBgBeUtUZpxs8k+Odrj23f2m11
         GMsPh5dgz1OhM9cgQumgqcgemiCy2iCApy5igk7CrvsHbKdqf7wN6ECfJXLwRimzr1/q
         0VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701027544; x=1701632344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQQcvauD4AnDngHziaZiwAO5Pne6N9UA8wUl/1bPLHs=;
        b=mqJQXBkY+uB6MVFzIxc2uEfaJr5BDLjURzOH0S15YyT9o0/TN5ra3/dONkXOw+Thnt
         4TFiOY1GWeHhAQ85It3r+pZy1ngrmtj2aARxio1Z5faP1Q/VsbZChVWDNPTeDAsujPJJ
         UbJXKkDZ24WuwCOPdB82YYVlV6K+WfXfYirTQhqpKRVinjHsF7TzwXDAST3bTh67xeCw
         2eKTmBQZB/XHkjBTkru1dj2mYYoXSM9mU43PA8OPaXPWefrWi7zLzud7j98b7e8+AY8E
         2TR9lkvjBfvXi8CV81qOXNecZLLJHPb/L+zU5V8gxoHBGVYYx5+1TI+RH1O8MeTy0K8E
         /JtQ==
X-Gm-Message-State: AOJu0Yxhr9zc7JsZj3LAKsdzHpnvltTEGXy7eQGZO5uwxfHe6I4Ht8if
        jnj9AnXZZgA2COTq0oBgYnTHAwUo8jGdbeoOZ1PsCg==
X-Google-Smtp-Source: AGHT+IG7edIjwzkLZriydsCq7vbE7y15jpsvy1UuJxgahaRABmgkv+NduMY4tmeDZo7/eBLZmwoqa7UWkMx675D6BbM=
X-Received: by 2002:a05:6870:ebca:b0:1ef:cedd:5c32 with SMTP id
 cr10-20020a056870ebca00b001efcedd5c32mr13555001oab.3.1701027543687; Sun, 26
 Nov 2023 11:39:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700648164.git.cmo@melexis.com> <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
 <20231125175318.25c0d6ea@jic23-huawei> <CAKv63us6yi2qaGLi3UgT=pfQ7QnxyM02FreD-qHnzTnKGSkRFw@mail.gmail.com>
 <20231126160147.65636cc5@jic23-huawei>
In-Reply-To: <20231126160147.65636cc5@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 26 Nov 2023 20:38:27 +0100
Message-ID: <CAKv63uvW5zgz1BHgEQAC_daU9Xx6Hs+9mc_poOeHPWcbkEUE8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 at 17:01, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 25 Nov 2023 22:26:46 +0100
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Sat, 25 Nov 2023 at 18:53, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Wed, 22 Nov 2023 11:24:06 +0100
> > > Crt Mori <cmo@melexis.com> wrote:
> > >
> > > > MLX90635 is an Infra Red contactless temperature sensor most suitable
> > > > for consumer applications where measured object temperature is in range
> > > > between -20 to 100 degrees Celsius. It has improved accuracy for
> > > > measurements within temperature range of human body and can operate in
> > > > ambient temperature range between -20 to 85 degrees Celsius.
> > > >
> > > > Driver provides simple power management possibility as it returns to
> > > > lowest possible power mode (Step sleep mode) in which temperature
> > > > measurements can still be performed, yet for continuous measuring it
> > > > switches to Continuous power mode where measurements constantly change
> > > > without triggering.
> > > >
> > > > Signed-off-by: Crt Mori<cmo@melexis.com>
> > > Hi Crt,
> > >
> > > Very nice. A few minor bits inline.
> > >
> > > Note (as normal for me), I haven't sanity checked any calibration maths - just assuming
> > > you got that bit right as don't want to spend ages comparing datasheet maths to what
> > > you have coded up + I'm not sure I can get the datasheet anyway :)
> > >
> > > Jonathan
> > >
> > Hi Jonathan,
> > Maths I have unit tests where I did floating point (which will be
> > released as embedded library same as for 90632) to integer conversion
> > and ensure that the delta is less then the error of the sensor. So
> > math I take full responsibility :)
> >
> > Datasheet will be public probably in March, when hopefully the sensor
> > is already part of the main Android kernel as well. But your review is
> > anyway very valuable and detailed. Thanks for all the remarks - there
> > is just one discussion below I would love to complete for future
> > reference.
> >
> > Best regards,
> > Crt
...
> > any reads on oscilloscope and why I need to physically read registers
> > below, so that they are cached.
>
> I agree the docs are a little vague, but looking at the code there
> aren't any reads, only writes to the device so I think this behaviour
> is by design.  The cache is considered correctly synced if an entry
> is simply not cached (valid I suppose as no wrong values cached).
>
> > regmap totally knows which registers
> > it should cache, but it does not at init, nor at regcache_sync
> > request. And if you remember in 90632 I had a similar remark, but
> > could not reproduce as EEPROM was readable in most powermodes (well
> > all used in driver), now I checked with scope and since I know this
> > chip does not allow EEPROM reading during the step sleep mode, so
> > everything was much easier to conclude.
>
> I think the key here is that the cache isn't really meant to provide
> access to values when the device is powered down; it is there to
> reduce bus traffic. Hence the last thing you normally want to do is
> read back all the values.  There is a way to get that to happen
> on init though.
>
> You want to hit this path:
> https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regcache.c#L183
> I think you set num_reg_defaults_raw = Number of registers, but don't provide any
> default values, so as to indicate they should be read from the device.
>

Ok, then I have understood this correctly I should only retain
regcache_sync and abandon any other call to sync or complete and just
rely on the natural state of the cache (and the toggling of the
cache_only flag I am doing here). Will roll v2 with that, after I
confirm it still works.

> > ...
> > > > +     mlx90635 = iio_priv(indio_dev);
> > > > +     i2c_set_clientdata(client, indio_dev);
> > > > +     mlx90635->client = client;
> > > > +     mlx90635->regmap = regmap;
> > > > +     mlx90635->powerstatus = MLX90635_PWR_STATUS_SLEEP_STEP;
> > > > +
> > > > +     mutex_init(&mlx90635->lock);
> > > > +     indio_dev->name = id->name;
> > >
> > > Not keen on doing this as it can be fragile if id and of tables get out of sync
> > > or we are using backwards compatibles in dt bindings.
> > >
> > > Given only one part supported, just hard code the name for now.
> > >
> >
> > Can you elaborate? Because I have the same thing in 90632 and I would
> > fix there as well. I assumed this is for linking to dt, to ensure it
> > is defined there?
>
> Exactly, the dt table and the i2c_id one can end up out of sync - perhaps
> deliberately and when compatible = "device1", "device2" is used
> I'm not sure exactly which one will turn up in this id if the dt table
> only includes device2.
>
> So rather than arguing that out and pinning down the expected behaviour
> we tend to avoid using id->name in new drivers.
> It's probably not broken to do so but lets make life easier for any
> future cases by not doing it.
>
>

Ok, will also roll the fix for the existing two drivers.

> >
...
> > >
> > > I'd like to understand what breaks if this happens but we carry on anyway?
> > > I'd 'hope' that any future DSP version is backwards compatible or that there was some way to know if
> > > the difference between backwards compatible versions and ones that aren't.
> > >
> > The top bit in high nibble is fixed to 1, to ensure that we have
> > endianness correct in the wild. We did the same later on in 90632
> > where we had plenty of trouble the way people read 16 bits. So if that
> > top bit is not there (bottom nibble has it hardcoded to 0), then for
> > certain we do not have the correct chip. And as for compatible DSP
> > versions: when we release incompatible one, I will upgrade the driver,
> > otherwise we have some more slack in the driver to keep on working,
> > because that was also lesson learnt from my side in 90632 as there are
> > compatible DSP versions possible and used, but we are still honest and
> > bump also the DSP version here.
>
> So there isn't a clear division between 'minor and major' version numbers
> as used in many similar cases? Minor can tick without a driver change as the
> interface only grows (nothing breaks), but major implies incompatible.
>
> Anyhow, sounds like you carry on with just a dbg print if an unexpected version
> seen. That's fine.
>

I am trying to convince them to do that, but your comment will provide
me some leverage for my case.  As usual, I was assured there would be
no DSPv2 anyway. Thanks for the feedback.

Crt
>
> Jonathan
>
>
>
