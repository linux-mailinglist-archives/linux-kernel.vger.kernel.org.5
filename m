Return-Path: <linux-kernel+bounces-9767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E581CB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C48E285BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C11CA9C;
	Fri, 22 Dec 2023 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJDHt0hc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75281B271
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb6fc61ce7so1283173b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703254206; x=1703859006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAJDlTM+58o2Y9+qepQZZcO4FGucuyjx04vNE8Nc6w8=;
        b=LJDHt0hcIwlnq9+NPLvUm1FnLzX1gVmrag8AxIOOq7F24uVhIx2lKWq2foUOi8XS15
         U7jegL6tM2uNbcB2whVRahHeNISGtJ2YVFmeZGL5jIO4GeU0ZB/McTbUBEhs+OS+IV1Y
         8PmYnk8rcq6Y1kWwcZVYUwt0m2Nvem20d5/loGx39/hNVYWwRA75NV2YUtusKAg4PmUO
         BzMcH+F0WPQy4Q/VDx1nHK/wnEyUqLcQ5hCpvLOyCHQVHiwamDZrTM9TCoOXFE8lhlXp
         PS7AfHV2lSMg/i5Ta1IqQh5IQ4likZaEFf0UNmDiOcPqhMZ/L3yIuHX6nahDn9OkIpTV
         D9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254206; x=1703859006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAJDlTM+58o2Y9+qepQZZcO4FGucuyjx04vNE8Nc6w8=;
        b=Zfiuin+y40q28FtjtHmTMeGBtpP8/+GexNj8TA45TiaK/yOR9J3re0/YHX4+OIjmuj
         AI06aFYz34V0rH+jO4u7byFeX/PzVb3QqIZTQMePMYQLe+WqxWCbLLIlMSSs6ebiyfhc
         Wd8bL5jznUpvy/JrsKM99vNgzMmrn4BRUMKk0mANXe7xIAxj5ATZVOtM3ZnSm9U6fpld
         8YkvaCnBo++oZGegNa7fUuzTGriBwjk4Y3FwUi2qwHfeQqmdGO3apTFoK0jMNVUTAm9K
         u1r6rN5G9YPujXwE6BbY47c13IjosS/Bh/gquuZMT18FNqeFjsn0U9wkusybEd0ywujl
         u1Pw==
X-Gm-Message-State: AOJu0YyUIDAFoRJWksr+QlQz6opeqOx2L45qJGFVlI+kt96+W4MLzEMT
	+PabAlXaG+14PXbJQOiyJHZGPMn05BavSbScvOK61IBpc9GZjA==
X-Google-Smtp-Source: AGHT+IELp68yunTytrpd91RU9zV6VAAIr3UAhtq9PdTi042C/qhywPoUc3s0eTS16SZepGwlf53I6g7id7qB06Scykg=
X-Received: by 2002:a05:6358:9045:b0:170:efd3:2d03 with SMTP id
 f5-20020a056358904500b00170efd32d03mr1750136rwf.24.1703254205702; Fri, 22 Dec
 2023 06:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel> <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel> <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
 <ZYWYZ6Ys3hSb4IOe@rigel>
In-Reply-To: <ZYWYZ6Ys3hSb4IOe@rigel>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 22 Dec 2023 15:09:54 +0100
Message-ID: <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 at 15:08, Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, Dec 22, 2023 at 02:37:43PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 22, 2023 at 1:56=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
>
> > > > > And you could've included me in the Cc so I didn't just find it b=
y
> > > > > accident.
> > > >
> > > > Maybe it's time to add you to the MAINTAINERS for this file as a de=
signated
> > > > reviewer?
> > > >
> > >
> > > You are patching my recent change that you yourself reviewed only day=
s
> > > ago. I would think that you would Cc me whether I were a maintainer o=
r
> > > not as I'm very likely to have relevant feedback.
> >
> > On that note: do you see yourself as a full GPIO reviewer or do you
> > prefer I split out the uAPI part into a separate section in
> > MAINTAINERS and nominate you as its maintainer?
> >
>
> Not sure I'm comfortable with either.
>
> Definitely not full GPIO.  I don't feel sufficiently familiar with GPIO
> and the related subsystems to qualify.
>
> Splitting out cdev and the uAPI makes more sense to me, but in my mind at
> least even that requires a level of commitment higher than the rather
> spotty attention I've been providing recently.
> I'm more inclined to leave it as is.
>

I can still split the uAPI files into their own section, make Linus
and myself maintainers and make you a reviewer, how about that?

Bart

> Cheers,
> Kent.

