Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F179872C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjIHMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjIHMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:39:44 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C81BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:39:40 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7a0254de2fdso753344241.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694176779; x=1694781579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvOWEgndNn9zVhQobGeusSukKrCvX3pWT/jhKhi3a3w=;
        b=WEo09o3gHsjV/dOzi/b/uDEW80LF60uFI47QolBPOzCGu3kcaLsV12SE2OJvV7Kf1/
         UuDlNi+zGsipcSULlZU19qPZo0zdcsxMZ/w5ZdEzKnzoCq5A0sVHgJ3Jz9PYvlTdi2J3
         GcidB0CxRxpiL38UlD2/NMMoHagFrrZY3xvR0um1zyj/O4K0af+MkTj7t35RsR39+ZAe
         Vf3Fg+d5PnIYrkSyQLuEM0b5s8BJ51QvnfUPlN5ebHS9QrX7/r7poS+rxHcsquBnJzRh
         beyEL6ghNJfWAMbRTy1SYdbDKpTAKeXKuz85xSqesliq4ORVQqwWohp1xi2UmJizd/n6
         V72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176779; x=1694781579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvOWEgndNn9zVhQobGeusSukKrCvX3pWT/jhKhi3a3w=;
        b=biSuGUtEfEufp8Vo4+qeBhrp4LYT66gJiR6WLBUBlNifs3hwu1LvfdrGtOwzW64Y9q
         wfTC/t6H/otxVFpVWhdhfJAyW7fOwdQ2EoWrv/B2g4Xva6y5D33qpZeSqQZnD9C2sRgg
         dODYqeDiHoVLunlhb3gGiJVYnv5Zve9Je3o8HcFc0RUx7/WSa6eyrXMI9rzQlLV28lAJ
         ZyKqkkla3/DJ7B2IY+Wj9i92sSHFAGbkSVKcMl+FsKAWJ7ttGAC3KaPjxAzOVEDF3GTi
         SI7YwUm8VL+ZwSPvzpNxINAYprhWtH77I+xV8GfckaV+k8Yj0ko8RpNdaIHKPVDdrW8K
         Diog==
X-Gm-Message-State: AOJu0YztdPXhD0lIxNw9UBcc7PJntp7WDHOh3lCPSGAqouVFTRnGZ6cj
        8mhoaGwF3X3XZbBcH0wpo3d2Msh/ImOo/G+0/wXC+g==
X-Google-Smtp-Source: AGHT+IHdxN7tYqOmaDDi7+1C2e6YHUY1AKKIYt6DMEYHcS8mYMAH/q0wdMPa2ApI9H3qkM4NNm0ECOFjdl6+nJirsic=
X-Received: by 2002:a67:ed04:0:b0:44e:9ab0:ed1d with SMTP id
 l4-20020a67ed04000000b0044e9ab0ed1dmr2408485vsp.1.1694176779256; Fri, 08 Sep
 2023 05:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230907082751.22996-1-brgl@bgdev.pl> <ZPnaoOUiYDR3yqGu@smile.fi.intel.com>
In-Reply-To: <ZPnaoOUiYDR3yqGu@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Sep 2023 14:39:28 +0200
Message-ID: <CAMRc=MfDOaRbgCH4OH8roLorRNYEscg1WhNFN_nDGyz9xRVWiQ@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: sim: don't fiddle with GPIOLIB private members
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 4:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 07, 2023 at 10:27:51AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We access internals of struct gpio_device and struct gpio_desc because
> > it's easier but it can actually be avoided and we're working towards a
> > better encapsulation of GPIO data structures across the kernel so let's
> > start at home.
> >
> > Instead of checking gpio_desc flags, let's just track the requests of
> > GPIOs in the driver. We also already store the information about
> > direction of simulated lines.
> >
> > For kobjects needed by sysfs callbacks: we can iterate over the childre=
n
> > devices of the top-level platform device and compare their fwnodes
> > against the one passed to the init function from probe.
> >
> > While at it: fix one line break and remove the untrue part about
> > configfs callbacks using dev_get_drvdata() from a comment.
>
> Will LGTM with the couple of remarks being addressed.
>
> ...
>
> >  #include <linux/completion.h>
> >  #include <linux/configfs.h>
> >  #include <linux/device.h>
>
> > +#include <linux/device/bus.h>
>
> No need, the device.h guarantees that.
>

Wait, wasn't you the one who always suggests including headers
directly if we're using any symbols defined in them? Like when I said
that we don't need to include linux/notifier.h because it's already
included in gpiolib.h and you argued the opposite? :)

device_match_fwnode() is defined in linux/device/bus.h so I thought
it's in order to include it.

> ...
>
> > +static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
> > +{
> > +     /*
> > +      * We can't pass this directly to device_find_child() due to poin=
ter
> > +      * type mismatch.
> > +      */
>
> Not sure if this comment adds any value.
>

I disagree - I would have used device_match_fwnode() as argument
passed directly to device_find_child() but I cannot due to pointer
type mismatch error so we need this wrapper and it's useful to say
why.

Bart

> > +     return device_match_fwnode(dev, data);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
