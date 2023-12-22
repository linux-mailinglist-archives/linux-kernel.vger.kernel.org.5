Return-Path: <linux-kernel+bounces-9526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406C381C704
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5EB281AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D34D512;
	Fri, 22 Dec 2023 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AKyUKZfq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0BFBE8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-466e5faf29eso11579137.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703235539; x=1703840339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecNqm3KCZK5TPbasxuftGkkhiYfCxbseeo7kCc76bg8=;
        b=AKyUKZfq/enD4Xfvlcu7aku4l+XOxNyMnkhEhy+EC72uFlxszex87BUmYqFP6VCSdP
         cuhKJ6CwqDjJSj9Kl2Wnusw8JOpWn6gi+/Yt4AfOBC5qrvFB0JEVgdzlxOF8QBUxxrvH
         WI3HQapDEc9wjvRLucFBm+VzX64JHYB1TXVWPm5xcVBmN2dKTZldgIuJcZiHgipw1fVF
         KnoLv6o0pJv30qKpA9GMS8e7TRWSkypGsJ/wjJ+qLFYEN5+njUJ8XPgd+zzj2NxO82QN
         uL6aNEzEvRhhfhGmFHdeiL+Zyv0P5IdzmYpQAvLSeBUt2nfYuKmpC28PzKVF50qx2Fjp
         Pa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235539; x=1703840339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecNqm3KCZK5TPbasxuftGkkhiYfCxbseeo7kCc76bg8=;
        b=i3jtVJePvahzuwvRRC9m0H9Jtp7NC7Ob1QBNw/rBY0b9yGX9wY9EfHF3gVRLqjckAg
         dFA255uIxwdK1vh6NwBt39ZSgWRQjA9vQrl3YAX9aGlE3i7G6Ny5XoKtWcGoGrySmV3k
         zKhWIcSPqglqZ7WQXrdGLEGK1CpSW0E84vQ8+vYKjzby9MWJd5qVT8O8qEzl9wYwYZn+
         DtAuzE4Z4hDx5vI2xsL3O0dKn4+zRCvwgW7AuHROvLXNAPGVJy3ySQVcaFmgHMwiKwsI
         BfSqlsDQewqI2rBNggHP1hdNwGk8hLmH1vyxsfLVfLDB3uEWkYwgyFG6JM2xWsMEVkw+
         saIw==
X-Gm-Message-State: AOJu0Yw4ze7Cli1ZxVRw3xfNC7fPTbh4VsHfTNp50o6R4kadZQTfccYT
	a5egEaOnWTNZGpfiQyUXCD60xvwBE+70wG0/OcklyhVLlp3TSA==
X-Google-Smtp-Source: AGHT+IFM9nmiSGlO/V2NqByyGiFjDUDdyQoQCB1/8S5i9MlsDlqpG+qP62g9RZoiAW8nUN0UBv12+et55xeNtjdB/gA=
X-Received: by 2002:a05:6102:32cb:b0:466:c6b0:d10e with SMTP id
 o11-20020a05610232cb00b00466c6b0d10emr586157vss.1.1703235539292; Fri, 22 Dec
 2023 00:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com> <ZYTihbWMcHMHSkC_@rigel>
In-Reply-To: <ZYTihbWMcHMHSkC_@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Dec 2023 09:58:48 +0100
Message-ID: <CAMRc=McSXrivkzhJVEh7-+1fzO6EBLMawhxYd7YgcsXW9wBKbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
To: Kent Gibson <warthog618@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:12=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Dec 21, 2023 at 07:55:27PM +0200, Andy Shevchenko wrote:
> > Instead of repeating the same code and reduce possible miss
> > of READ_ONCE(), split line_get_debounce_period() heler out
> > and use in the existing cases.
> >
>
> helper
>
>
> Not a fan of this change.
>

Yeah, sorry but NAK. READ_ONCE() is well known and tells you what the
code does. Arbitrary line_get_debounce_period() makes me have to look
it up.

Bart

> So using READ_ONCE() is repeating code??
> Doesn't providing a wrapper around READ_ONCE() just rename that repititio=
n?
> What of all the other uses of READ_ONCE() in cdev (and there are a lot) -
> why pick on debounce_period?
>
> The line_set_debounce_period() is necessary as the set is now a
> multi-step process as it can impact whether the line is contained
> in the supinfo_tree.  The get is just a get.
>
> And you could've included me in the Cc so I didn't just find it by
> accident.
>
> Cheers,
> Kent.
>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 744734405912..c573820d5722 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -651,6 +651,16 @@ static struct line *supinfo_find(struct gpio_desc =
*desc)
> >       return NULL;
> >  }
> >
> > +static unsigned int line_get_debounce_period(struct line *line)
> > +{
> > +     return READ_ONCE(line->debounce_period_us);
> > +}
> > +
> > +static inline bool line_has_supinfo(struct line *line)
> > +{
> > +     return line_get_debounce_period(line);
> > +}
> > +
> >  static void supinfo_to_lineinfo(struct gpio_desc *desc,
> >                               struct gpio_v2_line_info *info)
> >  {
> > @@ -665,15 +675,10 @@ static void supinfo_to_lineinfo(struct gpio_desc =
*desc,
> >
> >       attr =3D &info->attrs[info->num_attrs];
> >       attr->id =3D GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> > -     attr->debounce_period_us =3D READ_ONCE(line->debounce_period_us);
> > +     attr->debounce_period_us =3D line_get_debounce_period(line);
> >       info->num_attrs++;
> >  }
> >
> > -static inline bool line_has_supinfo(struct line *line)
> > -{
> > -     return READ_ONCE(line->debounce_period_us);
> > -}
> > -
> >  /*
> >   * Checks line_has_supinfo() before and after the change to avoid unne=
cessary
> >   * supinfo_tree access.
> > @@ -846,7 +851,7 @@ static enum hte_return process_hw_ts(struct hte_ts_=
data *ts, void *p)
> >               line->total_discard_seq++;
> >               line->last_seqno =3D ts->seq;
> >               mod_delayed_work(system_wq, &line->work,
> > -               usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
> > +                              usecs_to_jiffies(line_get_debounce_perio=
d(line)));
> >       } else {
> >               if (unlikely(ts->seq < line->line_seqno))
> >                       return HTE_CB_HANDLED;
> > @@ -987,7 +992,7 @@ static irqreturn_t debounce_irq_handler(int irq, vo=
id *p)
> >       struct line *line =3D p;
> >
> >       mod_delayed_work(system_wq, &line->work,
> > -             usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
> > +                      usecs_to_jiffies(line_get_debounce_period(line))=
);
> >
> >       return IRQ_HANDLED;
> >  }
> > @@ -1215,7 +1220,7 @@ static int edge_detector_update(struct line *line=
,
> >                       gpio_v2_line_config_debounce_period(lc, line_idx)=
;
> >
> >       if ((active_edflags =3D=3D edflags) &&
> > -         (READ_ONCE(line->debounce_period_us) =3D=3D debounce_period_u=
s))
> > +         (line_get_debounce_period(line) =3D=3D debounce_period_us))
> >               return 0;
> >
> >       /* sw debounced and still will be...*/
> > --
> > 2.43.0.rc1.1.gbec44491f096
> >

