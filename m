Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AE8118E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjLMQOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjLMQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:14:31 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C651D5D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:14:34 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9e756cf32so4670693a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702484073; x=1703088873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kPYkgmTxNDFsvUr6Kl8OO3OVhnWJzARJQekH92FNOs=;
        b=U3WnVNTpNofpA/2uQxTLp3nL7WFrcG4zzs61BN0JnIsrlsBcTip5VwxjuXSW0yhFO5
         7dW4//1krOj8wNAEgnE7ZYzMOPhPDDDAJ7zs/ng03s8lO0Sq5tF39ePpIyVJ30Ga16SY
         eoTD1t3z6zHAWOyBG1ZT1Tkl5s4RMUqwbCYmz7vYEXTL/Bfi+jZ+O7aEhbv2v5Wk+sdk
         HNjlwgX5YepgTQH6cLlCbVmBPaKFV73H/lPZOjQQtzz2Jx6kCiVMwuHZ0oGFmrdgSZjW
         b3kVnsVNCZyBSnuNlKAZkMHCEr2rbfHHEyFysfmEvh3zDsXfZK/YbOAqWkQb9hRUkwUv
         kYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484073; x=1703088873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kPYkgmTxNDFsvUr6Kl8OO3OVhnWJzARJQekH92FNOs=;
        b=KyGGurPXxbyzEf3pfj5rv5MtLkxG8V7D60oXmm/2o7ZwwBkTvPvp5IkAV07pgzUuHl
         yCPZV8noczphwIGmkQbYeOle30nU/KJNLLjuUAHnMgK84rD7D6v57p4tXihUW62jG4v0
         4xr5TCBFgauUnfwww++A/alaRw67t8C7HWKXI3/58t88rB8p5S5SiTXuVvOZbcEOhiTL
         xSzqNwD8wQ8RRj2kvlTYWPj2LUtvsgvixnphNgKWB91veLvlWHQbwsxxqfPleLuodkzs
         nvtqyiFbO+AgwCYpueNui+ERwBOGxnXatND+g4sbCyzdBoEgSeS+hzK37KtxRZZpten/
         dvww==
X-Gm-Message-State: AOJu0Ywk3MwQLELP8jm1szvXvWJ0T7t9qZRbs+AZOEBNVMGGGEUYb76P
        Er2yvKqHNkx39Nr2H9u/hs+9dtihhG+s/cbB1tVPbQ==
X-Google-Smtp-Source: AGHT+IGWMSjJoQawXfxsaFvQRqXE19S3wcQSkmbKO4nJ7iCo/iKqMj2wpyxB1MaxR3ybW2mbH9mhXtFOjjdyUCAoWgc=
X-Received: by 2002:a9d:4b06:0:b0:6d9:d87c:3633 with SMTP id
 q6-20020a9d4b06000000b006d9d87c3633mr7766934otf.56.1702484073508; Wed, 13 Dec
 2023 08:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com> <ZXnU3tMYCc2Rw8Qv@rigel>
In-Reply-To: <ZXnU3tMYCc2Rw8Qv@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 17:14:22 +0100
Message-ID: <CAMRc=Mf7d+EsM=zhqbU05ZS4Ur=frbFYn8DqNqXPRwLDemOrzw@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 4:59=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 13, 2023 at 3:27=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:
> > > > > Store the debounce period for a requested line locally, rather th=
an in
> > > > > the debounce_period_us field in the gpiolib struct gpio_desc.
> > > > >
> > > > > Add a global tree of lines containing supplemental line informati=
on
> > > > > to make the debounce period available to be reported by the
> > > > > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
> > > >
> > > > ...
> > > >
> > > > >  struct line {
> > > > >     struct gpio_desc *desc;
> > > > > +   struct rb_node node;
> > > >
> > > > If you swap them, would it benefit in a code generation (bloat-o-me=
ter)?
> > > >
> > >
> > > Didn't consider that placement within the scruct could impact code
> > > generation.
> > > Having the rb_nodes at the beginning of struct is preferable?
> > >
> >
> > I suppose it has something to do with 0 offset when using
> > container_of(). Not sure if that really matters though.
> >
>
> There are other fields that get the container_of() treatment, but node
> does look to be the one most used, so probably makes sense to put it
> first.
>
> > > > >  };
> > > >
> > > > ...
> > > >
> > > > > +struct supinfo {
> > > > > +   spinlock_t lock;
> > > > > +   struct rb_root tree;
> > > > > +};
> > > >
> > > > Same Q.
> > > >
> > >
> > > Same - I tend to put locks before the field(s) they cover.
> > > But if the node being first results in nicer code then happy to swap.
> > >
> > > > ...
> > > >
> > > > > +static struct supinfo supinfo;
> > > >
> > > > Why supinfo should be a struct to begin with? Seems to me as an unn=
eeded
> > > > complication.
> > > >
> >
> > I think we should keep it as a struct but defined the following way:
> >
> > struct {
> >     spinlock_t lock;
> >     struct rb_root tree;
> > } supinfo;
>
> That is what I meant be merging the struct definition with the variable
> definition.  Or is there some other way to completely do away with the
> struct that I'm missing?

No, I also meant that.

>
> > >
> > > Yeah, that is a hangover from an earlier iteration where supinfo was
> > > contained in other object rather than being a global.
> > > Could merge the struct definition into the variable now.
> > >
> > > > ...
> > > >
> > > > > +                   pr_warn("%s: duplicate line inserted\n", __fu=
nc__);
> > > >
> > > > I hope at bare minimum we have pr_fmt(), but even though this is po=
or message
> > > > that might require some information about exact duplication (GPIO c=
hip label /
> > > > name, line number, etc). Generally speaking the __func__ in non-deb=
ug messages
> > > > _usually_ is a symptom of poorly written message.
> > > >
> > > > ...
> > >
> > > Yeah, I wasn't sure about the best way to log here.
> > >
> > > The details of chip or line etc don't add anything - seeing this erro=
r
> > > means there is a logic error in the code - we have inserted a line
> > > without erasing it.  Knowing which chip or line it happened to occur =
on
> > > wont help debug it.  It should never happen, but you can't just leave=
 it
> > > unhandled, so I went with a basic log.
> > >
> >
> > We should yell loudly in that case - use one of the WARN() variants
> > that'll print a stack trace too and point you to the relevant line in
> > the code.
> >
>
> Ok, so any suggestion as to which WARN() variant would make the most sens=
e?
>

Just a regular WARN(1, "msg ...");

> > > >
> > > > > +out_unlock:
> > > > > +   spin_unlock(&supinfo.lock);
> > > >
> > > > No use of cleanup.h?
> > > >
> > >
> > > Again, that is new to me, so no not yet.
> > >
> >
> > Yep, please use a guard, they're awesome. :)
> >
>
> Will do.
>
> Thanks,
> Kent.

Bart
