Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722E776C58F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjHBGr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHBGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:47:26 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA6122
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:47:21 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79a00f74a92so2112646241.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690958840; x=1691563640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJvHQjKu6z8FmkxGVc6ZWP2ECLJmKX/NOuW6r8YK/ZY=;
        b=hmnH5vSiUAJ+W5vjK+o3mGftPoblFBk4JmznB923bZJ9Wv+fKdeFzaDFVjJjRbuCZw
         jN6jB1A98Nd9Z+YyYre4du24Q6JFzJvIOCbJL834POAY9PxMJOymdpIoYKOECjS9NaVy
         +NZnXnrLXqELYni+F4IC8I9MSt20BXOtnCk03ZaTLU0JAB2MF5os9CDIDhOSNZYS+sZ8
         Mn1xKpbJYlWyqYW0sXBq9lV3vEV+svxLcLVkSJbH6CpB+oDGbIe3yCohoKgos4G6CyUJ
         9BAZAQLBUwqAvdGeBnAPj3PCoE84d46XtimAR8PJN9IZrKjWXh4gZcWryTgiLi+J472/
         fHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690958840; x=1691563640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJvHQjKu6z8FmkxGVc6ZWP2ECLJmKX/NOuW6r8YK/ZY=;
        b=D24AB1pwascwQzLMmWQezqF5ntbBMAw5a9zdoYRqveujiVcteWU7jV7Dh/RZi/UvU9
         7sMWCmp+Bl+z6/Pdf/KzPckECjhAzTaeHFne1988APA3QooJ14Ma7sFQ4rkZOsKXpgQL
         sikjCmMvJrTL8pgTP2M9sBQFYTauVZ1RtXldRlgUiFWkWm4ebExrsjrKtzEiUGfV/pF3
         uOdlqH/Nl1pwWJvidiiwp0MYJyRfcWyia2CHcsn6+fggofp0yxPDCbIQDitLIPywnyen
         u2+KgDl8CGcIrsqOSqFDQRGGTsBgGCRNwxMioNHa4wyO2eivJhtSTXmPwBBhvIG36vOX
         G/mw==
X-Gm-Message-State: ABy/qLarFrrb+nmn0YOK7jGvKijCY4EGwMO7pTORw6hp5+mmHy1ULEtM
        uUNbcR70jusC6dyyYheLpMIDmPWH4hdfwCBpywZE9fPQeOYsB598Hoc=
X-Google-Smtp-Source: APBJJlEHRNMirg/Ob3AFzf5MNSsBaVkPAO0J8E7KRR5F6XkepT9GrYUIOrCYs9uQu6c2Ic2w1JXq7GtO7aG9IpEh2jk=
X-Received: by 2002:a67:f1c2:0:b0:443:8898:2a50 with SMTP id
 v2-20020a67f1c2000000b0044388982a50mr3163651vsm.35.1690958840254; Tue, 01 Aug
 2023 23:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230801190951.51818-1-brgl@bgdev.pl> <ZMlY+QU+yXIl4yab@smile.fi.intel.com>
In-Reply-To: <ZMlY+QU+yXIl4yab@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 2 Aug 2023 08:47:09 +0200
Message-ID: <CAMRc=McLt23osfxcNA4-3eqVY_O-PD_BQzwWSthELGxd+=jVmw@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: mark the GPIO chip as a one that can sleep
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Tue, Aug 1, 2023 at 9:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 01, 2023 at 09:09:51PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Simulated chips use a mutex for synchronization in driver callbacks so
> > they must not be called from interrupt context. Set the can_sleep field
> > of the GPIO chip to true to force users to only use threaded irqs.
>
> Ah, good catch! Doesn't it deserve a Fixes tag?

I will add it when applying.

Bart

>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpio-sim.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> > index cfbdade841e8..5f8723ad0048 100644
> > --- a/drivers/gpio/gpio-sim.c
> > +++ b/drivers/gpio/gpio-sim.c
> > @@ -429,6 +429,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *=
swnode, struct device *dev)
> >       gc->set_config =3D gpio_sim_set_config;
> >       gc->to_irq =3D gpio_sim_to_irq;
> >       gc->free =3D gpio_sim_free;
> > +     gc->can_sleep =3D true;
> >
> >       ret =3D devm_gpiochip_add_data(dev, gc, chip);
> >       if (ret)
> > --
> > 2.39.2
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
