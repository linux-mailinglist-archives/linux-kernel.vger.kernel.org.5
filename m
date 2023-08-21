Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D72782955
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjHUMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjHUMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:43:51 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA296CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:43:49 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44d45391e84so336417137.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692621829; x=1693226629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2hAgkXRqvYTqzEU7Gvb3ilsaYDJH03LaWTtSQAIH0s=;
        b=osfGKX8d4xOQ+ftpUFkypgJUuXpfzRWq0YLkIgroxalKulqzPEpoHAdg/w4fOQjRnx
         FrGGp28eEIeiS+XlJaGvTct4YPqgonk2sHWwlvOFIalaaHU08JRQv+2H4m8FfDAB4QlN
         u6MQr43TPTtfyusb6nhXtIOoULO0ME9aj8JU/85HnpIsNOmBoA3fSQ1WTzzU8krGJt39
         OiVjtUvRXnJkXbzuTafJN53WyZzEBnxuYbZCqxHEtxiFlR1lAycTXSgnXZqL4gKinh9T
         bONvqfKJw+XsTta9u/SEIntsw9hsmRb2X2+lCYfGk1YLsUTLvJn3NsGIqEOFb+BUaq+N
         CH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621829; x=1693226629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2hAgkXRqvYTqzEU7Gvb3ilsaYDJH03LaWTtSQAIH0s=;
        b=N5ZnlC9RnKgniu5lhGYouNJbBqIrRarKuedU5+QCdd2cJa1HkITZ96WOVnuMRxJfog
         jHAGwdiLP5E9w2tPGW2Oxb1UOSvpD4nlhizTbeLn58HPk+FApatg8kngj1Ck9JgH1Bqu
         eormP/J3TbxB+vXeuIXGmb4glhF4QEOBugg5j5Jg7O/2ZTGKhfgQHyGj+3DKnEPBDoqt
         rJpqzp71mGBglcDJA6WU17jxGobKr47UthRtubRnCo65+LzgvxHj8I8yculi7ZdZYCSW
         fri8655AZV76zVLtoBi5XJiny/TvQDsfIV8VkaPsEz/MAtWN5fUKrJSvyW73DqilpS4a
         BDZA==
X-Gm-Message-State: AOJu0YwXiyB10iGlGpi9CMQ2W9+fWHXS5oAymBb8t1E7W/zSf2KHARZ3
        cmqXsQPQMQnzeYf64CRcEYuL5nr9ytjYct4IAqmCSY/DRU53MRk3dX8=
X-Google-Smtp-Source: AGHT+IET2nPBCyAdg9CqdAf/azuJM8JnHjHzujG6oAfZMzEfYSWJNjzWFk6V+RfFpcUhc8aJLFKBbvo9Pq7NoyIVVx4=
X-Received: by 2002:a67:f70b:0:b0:44d:4385:1627 with SMTP id
 m11-20020a67f70b000000b0044d43851627mr2961763vso.14.1692621828963; Mon, 21
 Aug 2023 05:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl> <20230817184958.25349-5-brgl@bgdev.pl>
 <ZN9IYYgD6q/H3EuG@smile.fi.intel.com>
In-Reply-To: <ZN9IYYgD6q/H3EuG@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 14:43:38 +0200
Message-ID: <CAMRc=MfHCz8CfJniDXhuHXovPZ5AvNdTFUT3-LNYM4sQ15d=yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] gpio: cdev: wake up chardev poll() on device unbind
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

On Fri, Aug 18, 2023 at 12:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 08:49:56PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a notifier block to the gpio_chardev_data structure and register it
> > with the gpio_device's device notifier. Upon reception of an event, wak=
e
> > up the wait queue so that the user-space be forced out of poll() and ne=
ed
> > to go into a new system call which will then fail due to the chip being
> > gone.
>
> ...
>
> > +     struct gpio_chardev_data *cdev =3D container_of(nb,
> > +                                                   struct gpio_chardev=
_data,
> > +                                                   device_unregistered=
_nb);
>
>         struct gpio_chardev_data *cdev =3D
>                 container_of(nb, struct gpio_chardev_data, device_unregis=
tered_nb);
>
> ?

I could live with the other version but sure, why not.

I will send a v3 with a helper wrapper around
blocking_notifier_call_chain() for more brevity.

Bart
