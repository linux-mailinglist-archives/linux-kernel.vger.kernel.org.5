Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9051E7BCCCA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjJHGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbjJHGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9429C9D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 23:45:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso5301a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696747512; x=1697352312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj28NxioJUT9pNxHmjKPy7bneREmBqaMO4pmGBynunM=;
        b=nhtd5IFdbPIj8ifm14qbkA4KYrHzOhw54votUsQUgw1bxjq62+yHiJPWvpOTQPQeqD
         +7vUqog9PZ5Cq0bxgEd8jFQbe73J/MQ7qmY49PaQVwpO8fh97+Fn7o2CP7tEYSCbS+Xl
         K1DWb0tihKGBDwRkr1uv9Pb3zZ4FCcr5Frj9pfnSGEnP5rMnug13/s4PWXPJ/0YpUZ0N
         1aCAxzJcIRDXp5aFWSTdF/QCywx/K2v3cmpMxxoBZwHCOdLfq34b7U4tvSvkhSE9qrwg
         fCLs9rGSSNt6Hr0JyCAlBZYDc4GTEyg2tQJ4RkNYcob50rjkMXdQ41G6Wju2R5QqIixI
         iqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747512; x=1697352312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj28NxioJUT9pNxHmjKPy7bneREmBqaMO4pmGBynunM=;
        b=rW5YF5SQkCweRSxWnKUl5/EZT3eKxlwDiHQF5C7FnluRoKL5ODEoLz6xaPAKrnK2ni
         OSeevsHbfo3WicZ8nlnq4yM4KGfAcinqf1a0WDxrYAg3fhfAiv0MLWGUKr2Z0qhxJbMp
         P6mh1Pj+FhqYPjmwiIQdNiREeXps4jPIpYJ3LHaSSO81t/avhjXWTR4MPsyH2+b8Fw5U
         BLhhBkJsndMlbqMIcylpbkikW1NxX5VMlcxRoXqVOCGJ9YnXIgxwels2ZAlp4d2V2d+y
         GD9VUTqEf9IQf4ajeD/M+yUAFbBWmXdjEEx3UJybNe4aBMzKr/SqLoEg9U12VSdJ2IRr
         rCgA==
X-Gm-Message-State: AOJu0YzEn4wLKvE4XpQ1grl9Qh8m8c5Uo+cKsxfdpDDJkcwBo69VGhoK
        IkwY9RjNUs/vqmx+gX0nC964NGWBO76X7f12yCkx9A==
X-Google-Smtp-Source: AGHT+IG4CyyZZCd0/HZEeFTV2mudAvLVlov42FQWSJxLp3oocKs6i+qpPc56NDMRIUK6Uphtzbq9cKh6rZ4HnEp1nu4=
X-Received: by 2002:a50:d0d7:0:b0:538:1d3b:172f with SMTP id
 g23-20020a50d0d7000000b005381d3b172fmr296503edf.3.1696747511677; Sat, 07 Oct
 2023 23:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com> <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
In-Reply-To: <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 8 Oct 2023 08:45:00 +0200
Message-ID: <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 8:34=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
>
> On 2023/10/7 13:29, Eric Dumazet wrote:
> > On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev=
> wrote:
> >> Although there is a kfree_skb_reason() helper function that can be use=
d to
> >> find the reason why this skb is dropped, but most callers didn't incre=
ase
> >> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> >>
> > ...
> >
> >> +
> >> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >> +{
> >> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_=
alloc() */
> >> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->co=
re_stats);
> >> +       unsigned long *field;
> >> +
> >> +       if (unlikely(!p))
> >> +               p =3D netdev_core_stats_alloc(dev);
> >> +
> >> +       if (p) {
> >> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + =
offset);
> >> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> > This is broken...
> >
> > As I explained earlier, dev_core_stats_xxxx(dev) can be called from
> > many different contexts:
> >
> > 1) process contexts, where preemption and migration are allowed.
> > 2) interrupt contexts.
> >
> > Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
> >
> > I _think_ I already gave you how to deal with this ?
>
>
> Yes, I replied in v6.
>
> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux.de=
v/
>
> > Please try instead:
> >
> > +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> > +{
> > +       /* This READ_ONCE() pairs with the write in netdev_core_stats_a=
lloc() */
> > +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->cor=
e_stats);
> > +       unsigned long __percpu *field;
> > +
> > +       if (unlikely(!p)) {
> > +               p =3D netdev_core_stats_alloc(dev);
> > +               if (!p)
> > +                       return;
> > +       }
> > +       field =3D (__force unsigned long __percpu *)((__force void *)p =
+ offset);
> > +       this_cpu_inc(*field);
> > +}
>
>
> This wouldn't trace anything even the rx_dropped is in increasing. It
> needs to add an extra operation, such as:

I honestly do not know what you are talking about.

Have you even tried to change your patch to use

field =3D (__force unsigned long __percpu *)((__force void *)p + offset);
this_cpu_inc(*field);

Instead of the clearly buggy code you had instead :

    field =3D (unsigned long *)((void *)this_cpu_ptr(p) + offset);
     WRITE_ONCE(*field, READ_ONCE(*field) + 1);

If your v7 submission was ok for tracing what you wanted,
I fail to see why a v8 with 3 lines changed would not work.
