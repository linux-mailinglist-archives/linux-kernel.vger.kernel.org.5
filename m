Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C410D81177D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442179AbjLMPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442176AbjLMPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:40:18 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C3BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:40:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9dc789f23so4923617a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702482023; x=1703086823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvB5R6Qps8EFTNLIHUkdyYAJKBgwPtcunbgfuEeoU6g=;
        b=GvmWxVnOLak+XMPO+ggLEdSlED6JE/z2uvp2PXGaTAYYoaDmaYvqRSeOJJUpEJR+ZL
         HQ2IYp17ZbY2ziLW9uwZpr1T6UhWnRftuTm1UszZUfST35zEiFtAGBHWY/11hAEtqNtZ
         8Rx5x5ZpuvkbQbillGCUvnvwl0NZ2v71FakrXYGsAaOE3pV2cnMnGP+diFYjzBg7MX1l
         r/5qrliYBvl5ZIrPsHTjIt9jnckGfdYACvUkJPzdnvmwKT5/VlO5RY8XmMFb34lEeddj
         G2i1AwFtEaDHuzD29V3OCO8s+/QdpANgpLPC6SspD53QmgFUXio2r1P0NFVh9FH6Suyp
         66ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482023; x=1703086823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvB5R6Qps8EFTNLIHUkdyYAJKBgwPtcunbgfuEeoU6g=;
        b=AzGLJ10TADPqi44WrhXQFXtOpTB4jrgR9PpNHBjQoPhgpglAIe2qW96RCYWAerkR+6
         CG/T5PvhvBB7GymL/QbAxy+iZagBoDwVGM3j5l9/UKmJZQ+UKPkEQjg6AgANXesfp1sJ
         zdfjqYFW/HsoBH867J+d2xHIR08f5PnVIAvDPqcwWght3miQi5dDhCcryrLIOggEPAcK
         +m/wWzPIESnGK9JGyR8vDxrUg0ulTwZN/FnhhVG05MFiBwhDk6894kvPCJR4ifz/1xxV
         okLNakTQhiklbbBgCUoqCeG+jSCSmIzefIK4MkkfNhyOn6VNlZ0syRUwN6zKmScJd0lv
         LKyQ==
X-Gm-Message-State: AOJu0YwFjHnSPy/lygsVc2m4k8bNzXPbUiqKjxFdAAwQ9WRGQ6gSp6zU
        MqysIZsMv9nDjApmVOoOP+ObE/c3QZbYer87rH4IRA==
X-Google-Smtp-Source: AGHT+IHVfDbz2ufxJiJ+ybzWZHs1zirPa8Q2Gj1jaHJoxwwD1d3xd+htxri3DbBLv+kzQ7bYxAR6NL6MKlbNh59bzzg=
X-Received: by 2002:a9d:5615:0:b0:6da:bc7:d11d with SMTP id
 e21-20020a9d5615000000b006da0bc7d11dmr4830623oti.52.1702482023371; Wed, 13
 Dec 2023 07:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
In-Reply-To: <ZXm_WsIpgIyOUNHt@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 16:40:12 +0100
Message-ID: <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 3:27=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:
> > > Store the debounce period for a requested line locally, rather than i=
n
> > > the debounce_period_us field in the gpiolib struct gpio_desc.
> > >
> > > Add a global tree of lines containing supplemental line information
> > > to make the debounce period available to be reported by the
> > > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
> >
> > ...
> >
> > >  struct line {
> > >     struct gpio_desc *desc;
> > > +   struct rb_node node;
> >
> > If you swap them, would it benefit in a code generation (bloat-o-meter)=
?
> >
>
> Didn't consider that placement within the scruct could impact code
> generation.
> Having the rb_nodes at the beginning of struct is preferable?
>

I suppose it has something to do with 0 offset when using
container_of(). Not sure if that really matters though.

> > >  };
> >
> > ...
> >
> > > +struct supinfo {
> > > +   spinlock_t lock;
> > > +   struct rb_root tree;
> > > +};
> >
> > Same Q.
> >
>
> Same - I tend to put locks before the field(s) they cover.
> But if the node being first results in nicer code then happy to swap.
>
> > ...
> >
> > > +static struct supinfo supinfo;
> >
> > Why supinfo should be a struct to begin with? Seems to me as an unneede=
d
> > complication.
> >

I think we should keep it as a struct but defined the following way:

struct {
    spinlock_t lock;
    struct rb_root tree;
} supinfo;

>
> Yeah, that is a hangover from an earlier iteration where supinfo was
> contained in other object rather than being a global.
> Could merge the struct definition into the variable now.
>
> > ...
> >
> > > +                   pr_warn("%s: duplicate line inserted\n", __func__=
);
> >
> > I hope at bare minimum we have pr_fmt(), but even though this is poor m=
essage
> > that might require some information about exact duplication (GPIO chip =
label /
> > name, line number, etc). Generally speaking the __func__ in non-debug m=
essages
> > _usually_ is a symptom of poorly written message.
> >
> > ...
>
> Yeah, I wasn't sure about the best way to log here.
>
> The details of chip or line etc don't add anything - seeing this error
> means there is a logic error in the code - we have inserted a line
> without erasing it.  Knowing which chip or line it happened to occur on
> wont help debug it.  It should never happen, but you can't just leave it
> unhandled, so I went with a basic log.
>

We should yell loudly in that case - use one of the WARN() variants
that'll print a stack trace too and point you to the relevant line in
the code.

> >
> > > +out_unlock:
> > > +   spin_unlock(&supinfo.lock);
> >
> > No use of cleanup.h?
> >
>
> Again, that is new to me, so no not yet.
>

Yep, please use a guard, they're awesome. :)

> > ...
> >
> > > +static inline bool line_is_supplemental(struct line *line)
> > > +{
> > > +   return READ_ONCE(line->debounce_period_us) !=3D 0;
> >
> > " !=3D 0" is redundant.
> >
>
> I prefer conversion from int to bool to be explicit, but if you
> insist...
>
> > > +}
> >
> > ...
> >
> > >     for (i =3D 0; i < lr->num_lines; i++) {
> > > -           if (lr->lines[i].desc) {
> > > -                   edge_detector_stop(&lr->lines[i]);
> > > -                   gpiod_free(lr->lines[i].desc);
> > > +           line =3D &lr->lines[i];
> > > +           if (line->desc) {
> >
> > Perhaps
> >
> >               if (!line->desc)
> >                       continue;
> >
> > ?
>
> Seems reasonable - I was just going with what was already there.
>
> >
> > > +                   edge_detector_stop(line);
> > > +                   if (line_is_supplemental(line))
> > > +                           supinfo_erase(line);
> > > +                   gpiod_free(line->desc);
> > >             }
> > >     }
> >
> > ...
> >
> > > +static int __init gpiolib_cdev_init(void)
> > > +{
> > > +   supinfo_init();
> > > +   return 0;
> > > +}
> >
> > It's a good practice to explain initcalls (different to the default one=
s),
> > can you add a comment on top to explain the choice of this initcall, pl=
ease?
> >
>
> Not sure what you mean.  This section used gpiolib-sysfs as a template,
> and that has no documentation.
>
> > > +postcore_initcall(gpiolib_cdev_init);
> >
>
> Thanks for the review - always instructive.
>
> Cheers,
> Kent.

Bart
