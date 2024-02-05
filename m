Return-Path: <linux-kernel+bounces-52783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132D849CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24ADDB24717
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA84F249F7;
	Mon,  5 Feb 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y8ojhYe9"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572920DD5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142092; cv=none; b=VHbcqQ9XLrY+iiQcYk+I11OE9rlJQyKSD4UXkpMbqvtsCFK+ke/l5Lrbce9JMS5g2oAmznY93qdizYi6+f+OfKKF/9YwWzHz8CaYO8L9zPVd6iqTufeBSxO0hIDOBogW3NQy989RQVL+nBwYXbfIX8vlxQytvwEPFKw7fxomrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142092; c=relaxed/simple;
	bh=LGS2xq+8pfU94MZROrWBItjD7BFDPFXaXa75pK1svlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJXvkuJltEQzI79mb2QoHB40+BMBpzPC//rRWzoVnFNmpyHChHoBptyJHx+NEWA8zlrpwE/+AcebCm7LHS+MdGCbF9MO8O1pbVFzlpjYAG7rM/AMgIL1xX41y3538fPJ2AUBmzraAB7dLAYt3WK3wd+65Y0/exQZv4d9yNpaBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y8ojhYe9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso2216626241.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707142090; x=1707746890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFQEy4nON+QsNXZ1HJDqeBEBWT/NbjQF7n/123X17hc=;
        b=y8ojhYe9zj5UUkpt2I77r6xHsS+Shcey5fzW1wrhkuOeGXT7smNCzMkxQ4/TAgPOOb
         WG3fOJyK1vm3moqn6PFxm1O8CWAah1WV/X3GP3x8EmKvWDpytEzESstUS+fIfoJjAwTi
         cMxD5bmxk9crrKQWLgNHvsCQGYBT30J7HfLR2+Cl08aMmaSK2KMSaxKmDhyXeG1qakjT
         KGQWjY+aJX2Unfp8azcJXe/bNtDQmdPC8t57z5REQ6ajOKGqrqlMibFtmhvF6fyyNMVa
         X3OcXd7NLryhjJVd/gfi9jETOhKzNz8PrwznI+UuJCspIcF+tqsvNEd2So3RO3hCfAWT
         UTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142090; x=1707746890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFQEy4nON+QsNXZ1HJDqeBEBWT/NbjQF7n/123X17hc=;
        b=XdfzTFoeaO8tzUEndZHtzdhvQyUu/ycYBexYI3/l5Z/gL0o8rm4p3XJgXNd9t8p3Xs
         3hTbyWLPBm5BNx6yFyQ6IbKFnM/xdmV2atqNognZa69yavYZ+5P5S2Qc62IXZ2UsRGLs
         Y4SWwgk4pp6dKr5EpdL+U6XJ0UKB7r/LCfx54YIgCQN2CnEHg/QuXuptg1tQeM3xNtQX
         9pWwhtf5pwbDW6Jo1Gall3HVVCyZ7EP8+sllEnc6ZsAFhKOjxlPXw4LgpLcOhUHgR75Y
         Q5/LEHBviL7Uw8oDyhHGesBWvH9z+eYVo/oHieU0S/8PVZCIuLfvMowfHoAZY6/KGzIE
         /VaQ==
X-Gm-Message-State: AOJu0YxCu/cpowrd/BL2kxNdjlCxKOv9gMxRd6WDyjFhDJ/TexicqXwK
	kKHB2Ls3Kc/HbMYI7a+ppSnaQhmwZssw0KOJYnEtnZaYfwaXNXp2jGumiTMHh0Hw9hXeGlM6Gzj
	izNHc9wH3c4wgjRpt5n3Yh5f2GiPtbttPss4gfw==
X-Google-Smtp-Source: AGHT+IHIoP4VPwclrEm8SFO/pI0RfNbwe9mHqdzQ1e70oorq/YISptztec5RaCq5ic+k1tVYLHnfGg+gvLZwzonIzpI=
X-Received: by 2002:a05:6122:4b02:b0:4c0:3c09:6f34 with SMTP id
 fc2-20020a0561224b0200b004c03c096f34mr692795vkb.2.1707142089866; Mon, 05 Feb
 2024 06:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-7-brgl@bgdev.pl>
 <ZcDRuRCT9xE48cYi@smile.fi.intel.com> <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
 <ZcDpWf7u3bW34Y8s@smile.fi.intel.com> <CAMRc=Mf740MJEg5fkAZaeL5yZAvVpJvjJ3zWcn-gWqS6_ue1mA@mail.gmail.com>
 <ZcDreg9pXqFX8zwa@smile.fi.intel.com>
In-Reply-To: <ZcDreg9pXqFX8zwa@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 15:07:59 +0100
Message-ID: <CAMRc=Mets9QLRpeaEDs=L+W3i7JD-7uZ-AU+OPGzmhsELK95vw@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] gpio: add SRCU infrastructure to struct gpio_desc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 06:04:23AM -0800, Bartosz Golaszewski wrote:
> > On Mon, 5 Feb 2024 14:57:45 +0100, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Mon, Feb 05, 2024 at 02:54:08PM +0100, Bartosz Golaszewski wrote:
> > >> On Mon, Feb 5, 2024 at 2:48=E2=80=AFPM Andy Shevchenko
> > >> <andriy.shevchenko@linux.intel.com> wrote:
> > >> > On Mon, Feb 05, 2024 at 10:34:01AM +0100, Bartosz Golaszewski wrot=
e:
>
> ...
>
> > >> > > +                     for (j =3D 0; j < i; j++)
> > >> > > +                             cleanup_srcu_struct(&desc->srcu);
> > >> >
> > >> > What does this loop mean?
> > >>
> > >> I open-coded it because I want to store the value of i to go back an=
d
> > >> destroy the SRCU structs on failure.
> > >
> > > Where/how is j being used?
> > >
> >
> > In this bit:
>
> I am sorry, but I don't see how...
>
> >         for (i =3D 0; i < gc->ngpio; i++) {
> >                 struct gpio_desc *desc =3D &gdev->descs[i];
> >
> >                 ret =3D init_srcu_struct(&desc->srcu);
> >                 if (ret) {
> >                         for (j =3D 0; j < i; j++)
> >                                 cleanup_srcu_struct(&desc->srcu);
>
> So, you call the same several times, why?

Ah, now I feel stupid. You're right of course, I'll fix it.

Bart

>
> >                         goto err_remove_of_chip;
> >                 }
>
> > >> > > +                     goto err_remove_of_chip;
> > >> > > +             }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

