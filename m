Return-Path: <linux-kernel+bounces-52778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C511849C99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE2B28FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC724219;
	Mon,  5 Feb 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KFe8ckRI"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21624A0A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141911; cv=none; b=WmnQw/j0Rof0vXmuCe72R2gbdLwcFpjCvWnu2QKVFPVnsV+elErLMpZcYmdel8Anvk5prn0xy+bidpf4JNvELVvgnI6OjJTCuXEoV4qN4N4PYyq0pgkR2F8Rk4vWTbe8YLm6diWfFK2CUy11pCR9Uz3D5ng0Pvh/ktd/IZNUzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141911; c=relaxed/simple;
	bh=i9NRrWK6b8V7TvWV1IOAAFtc4UxArBnqNaxGbxri0X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZ/aqtdCnL9UXaWTDsCaK56oS25snei/mjKhA5BJ4RzYzQtkmJ94PeTYTqzbuL8cWkk895QGULrW8vIl9LDYjFUNmBLrcRbj6+WQY7Lnq9SSeHgTLz+CSAnLMxNuSMAuHpus6fx6Yb5oeWaWjqvxtiwhUl3CW8Oby+84QRzzEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KFe8ckRI; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c00ec6f1a7so917581e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707141909; x=1707746709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSGpib2JooJQqbxukkrHs26Jx1mtMm+Lmzj5ORsziMU=;
        b=KFe8ckRIa20fk1N6pj34U55+GrxHmt8/ZIDYCerAqWWCecQcrFniR5rdq0jhoIIV6K
         UsE4Y8cwD+9o9fToxFk9gcvZqf9Cv3/jBmP8VYKiQYYLxHxtQNitVF0TJdtYiuQAKw0/
         0vXsHL/tgmzWf0AvJiAZQIUkKMWj4t2C8Zf4m/JQTjEoW6aop6FKMcjvs8Ef8Fwh6Bk5
         98zmr6nr75Z9bL+yKI4SAU7Nj0XOBbTifp+HE6Kfl4xwHyQsmyyRCJtWi6M9sUnwa4zI
         DqrNQ5C5CECT+EHGzKKDNFudhB3fAblQXOMJByVpmRf6hHIAnSBzClkitwPgSW5jhk/q
         PyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141909; x=1707746709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSGpib2JooJQqbxukkrHs26Jx1mtMm+Lmzj5ORsziMU=;
        b=Ql5967fhZFCVVtaobYxHq/rVggwMXUWEWyxBfnXdWso/i4At2V8alYs34PAIrwqQQF
         yYLSlTraR0UMFHfBhT9hROmxSXNq46K9nqLRVTii41s7qE6vY1orhxmgMbMUDt1CzqzT
         S9eWPKOWw5NgyX2Km4kh7H1LLdAaFWfVK3LIgU3ECJVPz3XfEg6MbzymaEUyGq/Pskn9
         VeJa6jZ0AdT/tgy6IXU8pQMqFdV2VmNVx9UBEZrA5Us8XR06Z3vxFIRwqLx5dXgl0z5S
         4OUSXOug8wVZaByhMmc6SmQ2/I2WnXsvc7iiLPjCcfc+7mFmDOvRNFjRsPI48dzJAjeQ
         W3QQ==
X-Gm-Message-State: AOJu0YxrBY31kVeq7gN9/ovjBtXrA1ScLQF4J6KAqF80IWetpC+0IYjI
	6jKKdMrVU4aIXt2CS53xPsLv8jvxyss0NMS5GWaRnHvanPN3Z/Pt+BYdefE+dI4L+YZLrGMYbZw
	MtkR6Ij2zgSXXKpGciZbwEiKCsEvHDbyCD2dWZQ==
X-Google-Smtp-Source: AGHT+IGYjNwR5B4FlfGuVOK0O4J5fa65C6t5jyX6gYjqaO38YBsmM6/iQ5/rkBoPHqsi3uRUHWyp78aiFNp7u96fH64=
X-Received: by 2002:a05:6122:4584:b0:4c0:23bd:1f0d with SMTP id
 de4-20020a056122458400b004c023bd1f0dmr2457283vkb.15.1707141909149; Mon, 05
 Feb 2024 06:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com> <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
 <ZcDkvOrlSRkmYIk_@smile.fi.intel.com> <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
 <ZcDm3ZrW1dQQAroY@smile.fi.intel.com> <CAMRc=Me+ETGfgjgQV+SSZenLW5MeNLVSrFKBhs707FDEqEHFJw@mail.gmail.com>
 <ZcDpo__BIF2Bf8CC@smile.fi.intel.com>
In-Reply-To: <ZcDpo__BIF2Bf8CC@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 15:04:58 +0100
Message-ID: <CAMRc=Md+z4V9qm8OjgqZeW_Ybfh4uuG7fBQvG4zTD_gC-5XyPw@mail.gmail.com>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:50:18PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 5, 2024 at 2:47=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 05, 2024 at 02:39:40PM +0100, Bartosz Golaszewski wrote:
> > > > On Mon, Feb 5, 2024 at 2:38=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski=
 wrote:
>
> ...
>
> > > > > > > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, v=
oid *data)
> > > > > > > > +{
> > > > > > > > +     struct gpio_device *gdev =3D gc->gpiodev;
> > > > > > > > +     int ret;
> > > > > > > > +
> > > > > > > > +     if (gdev->mockdev)
> > > > > > > > +             return 0;
> > > > > > > > +
> > > > > > > > +     ret =3D gpiochip_sysfs_register(gdev);
> > > > > > > > +     if (ret)
> > > > > > > > +             chip_err(gc, "failed to register the sysfs en=
try: %d\n", ret);
> > > > > > >
> > > > > > > > +     return 0;
> > > > > > >
> > > > > > > ???
> > > > >
> > > > > What the point of function to be int if you effectively ignore th=
is by always
> > > > > returning 0?
> > > >
> > > > Because the signature of the callback expects an int to be returned=
?
> > >
> > > But why do you return 0 instead of ret?
> > >
> >
> > Because we don't want to *find* a device really. We just want to
> > iterate over all of them and call a callback. Any value other than 0
> > will be interpreted as a match. Besides: failure to register one GPIO
> > sysfs entry shouldn't maybe cause a failure for all subsequent
> > devices?
>
> To me it's not obvious, hence I would like to see a comment before return=
 0.
>

I'll add it for v3.

Bart

> > > > > > Not sure what the ... and ??? mean? The commit message should h=
ave
> > > > > > read "... traverse it from gpiofind_sysfs_register()" I agree b=
ut the
> > > > > > latter?
> > > > >
> > > > > I didn't realize this may not be obvious :-(.
> > > > >
> > > > > > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

