Return-Path: <linux-kernel+bounces-52777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DF849C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45331C244C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68577249ED;
	Mon,  5 Feb 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hQXP055s"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B12375D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141887; cv=none; b=ZJ2uo5YQQfDUGP4BfqOCe5WA/5lQaM8wPDmRN0RGIhsZ/yuUQ9Qs5EliwD/i0pN9y+Zmn0tWf3SNOlbb99keuKo04s9EyM1LGe4Ihm+CoWGkiup1/Gca+gIJvOT1aIFY7I4Wh0uKd9+9m5z/8BRtVLPQjx2xTl2k5LncO+Z4ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141887; c=relaxed/simple;
	bh=c7iXP8ZW3jn5tW4zW589D6c25M4gK71BHUAhCvkB8pM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbExJeags9YobmDD0niLaizan2kU/g3DVBaZyLRAP0+PYXs3b3xGiRWCmTRM+BLCwjh0EtSwl2h15m2FhOWtj+y72C69+kI/RMMNsYIwlnSqWk+SGeDdN67rabxoTHgeXpWvhybVeg51hHQWrPTMZtbv5eiBZca3o3kT3soiRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hQXP055s; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso2279636241.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707141885; x=1707746685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrTM/fBQlhkg4h2sD56SoqFOPdHwXZlUX3acx2EnaKM=;
        b=hQXP055s6vkMsicCzVzBBlC1W7KBBo8Jp2WsuDBtCCSJSj/s+FJyaycGJwSWdgZw84
         fgQN/PD2/ysIpPwNAo6lYJXSKHxQYDYbRqx/iD/wD/RlRAv7zF1KFpkuZe+17ljjsS5M
         TGdSLVqxEXNavYxbvE52b6mmSo1VSxqsV9Vcvcu0DqGTE54ogDLn6X8xoNdpP/1lLig7
         f2dT6oJHrYtd2GDUKG46ky4prHJH8+MsR0Vs0HRLIjlKFJULj9yxrKM4sw0hGypVrNEa
         CnNidshSFW3lAEhWk6OYM9R1jcXgoYJ2bH0MD3Upa/CQ/ij5Y+uj3BfUwykoyxPgZoDU
         fcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141885; x=1707746685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mrTM/fBQlhkg4h2sD56SoqFOPdHwXZlUX3acx2EnaKM=;
        b=WWDLbCzHTwQyQ1uQCahQEkKa0E8G/zTHVyjZZgCqI6pv9JGAz4afhz8EFn+eknFrDE
         5z0fbkjOaHGPivovEsYuxYAI1V5RNehMGL1uBlrmhT6oazEVGzSRu3Z6rNDa8xiwHCXF
         zFdRVixgh8w8+fmx/MO5L2gk+TNOxyHlpjB1NYTqPirr+w2HB5j0Gz2A5nAQIY4o2TeL
         dTzTODHwFAPZt87km5l5OdiVOYeCaB/ERWXHCyf7YyPhBOmQgd6vqQgyKeEdLFhgFtAP
         WAJdtn0dYB6iSI2Ksslwhill+lin1JVeg0o5CWwQBwd0SgWR+sMopO1X8bmrnhFSnTCQ
         EqEg==
X-Gm-Message-State: AOJu0Ywez5zf4OKhJcZdZTZDEVUZeOND2ng4LhIMXm31i6RdPfaCLXJU
	Zt8Z5JSZT5QVMWE9M19eRT25Lu8j9/HQyBpZQWeJWdCDBeGG/IzJkFSId7f3ziS2TYJeErxHLfM
	S+J4KkPDOOgFaEMR4Ou45g25/NQ05E0g9+wJGj9MKId/wLr3q
X-Google-Smtp-Source: AGHT+IHg9iozjtD+bm3x7ykxMkfnVKqQCOIsyqCC7nQTi/O5nLP+g9bFrSEnHKm3P2eX1jXDdqzv/tWZmOLZHf7PZws=
X-Received: by 2002:a05:6359:4598:b0:178:20ea:abb5 with SMTP id
 no24-20020a056359459800b0017820eaabb5mr18024876rwb.26.1707141864213; Mon, 05
 Feb 2024 06:04:24 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 06:04:23 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <ZcDpWf7u3bW34Y8s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-7-brgl@bgdev.pl>
 <ZcDRuRCT9xE48cYi@smile.fi.intel.com> <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
 <ZcDpWf7u3bW34Y8s@smile.fi.intel.com>
Date: Mon, 5 Feb 2024 06:04:23 -0800
Message-ID: <CAMRc=Mf740MJEg5fkAZaeL5yZAvVpJvjJ3zWcn-gWqS6_ue1mA@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] gpio: add SRCU infrastructure to struct gpio_desc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2024 14:57:45 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Feb 05, 2024 at 02:54:08PM +0100, Bartosz Golaszewski wrote:
>> On Mon, Feb 5, 2024 at 2:48=E2=80=AFPM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Mon, Feb 05, 2024 at 10:34:01AM +0100, Bartosz Golaszewski wrote:
>
> ...
>
>> > > +                     for (j =3D 0; j < i; j++)
>> > > +                             cleanup_srcu_struct(&desc->srcu);
>> >
>> > What does this loop mean?
>>
>> I open-coded it because I want to store the value of i to go back and
>> destroy the SRCU structs on failure.
>
> Where/how is j being used?
>

In this bit:

        for (i =3D 0; i < gc->ngpio; i++) {
                struct gpio_desc *desc =3D &gdev->descs[i];

                ret =3D init_srcu_struct(&desc->srcu);
                if (ret) {
                        for (j =3D 0; j < i; j++)
                                cleanup_srcu_struct(&desc->srcu);
                        goto err_remove_of_chip;
                }

Bart

>> > > +                     goto err_remove_of_chip;
>> > > +             }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

