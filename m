Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A517925BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjIEQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353913AbjIEIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:36:57 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56340CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:36:54 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44e8984b724so1352932137.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693903013; x=1694507813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlsjQOgmFFNUt1m9Lt2zPKJMVSMTbucW1JXahOsWl+c=;
        b=kjQFtMwWkahcuCVKTgj4UpQcMKoPy3aOVTZHRmJQEB+U61qgrLEwllXyJwU+g1UKpy
         tb6tHafdslrsgAnIT7JEBQPa1HfcA8oz0APqUGyGd4KiRAxa6Y90MaOerbkYN8LOe9Se
         VftD+5i90BdOvZXornH1eYbKPFrECDzHsK+VknkskXMD9WQPaL+pj90JiKIcMu8gTZz/
         BPlbG9eXLhWXgbaII1/I7WEOaN2gW0DbRy7nXRqhnORs1UP67RpmuPwjPUj7uNxr9X3X
         1dcuaUdlUIdCyxtQGJ4t+m2ExcyadiqRnvdfy63cVeaa8iAEu+87bj9zHdbmc+0xj40B
         EeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903013; x=1694507813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlsjQOgmFFNUt1m9Lt2zPKJMVSMTbucW1JXahOsWl+c=;
        b=A/fFhRjW3Fy3qYnNDwTCpSrPX65HmDVIT7rH7k++qe+gUprte4YzNG0Y9mmt7AWOJc
         yj/VJKIWp7vUzzWs6XIIMozifGm7qa7aWVV6eNP8Y4acFTeTtwQ/JMee/A57+7Bs/0px
         1hYJWTzYMphkpTC2/7sdKpIz+QPANFnQs6cjhyncug1NYkwPZv5Orw4agEkWaa65hBbo
         mQQd3KngRtrg0jkJZ04TCe9c5Rc+oR9wwJpiRVK+Fr89IDIQBcSDyCpcUeAv3lL2GHff
         xsb4VyhL2JM4Lo0sZ5Ug7NWg78pGjb5DOA1PsGjxxRAUywb8nKmg870npSes0SBDc1vx
         HZzA==
X-Gm-Message-State: AOJu0YywJsQVfo/OTaGumm1sAqwt4QnZWm05/5KkOC2Tv+ymrnny3jkw
        bF0od8oa2i3zgsSm8G98NQFWMKeB93sO3U9F5tQJKA==
X-Google-Smtp-Source: AGHT+IGRDEC62pyg3qU8itOWPkFU26zCaVY/sg95ZJW9wtyl5CBJvNiHZVwFQmWXZGfA1eA8B/lFvlumQ/fKLizKsbU=
X-Received: by 2002:a05:6102:3576:b0:44d:4c07:f203 with SMTP id
 bh22-20020a056102357600b0044d4c07f203mr6688676vsb.17.1693903013473; Tue, 05
 Sep 2023 01:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230904073410.5880-1-brgl@bgdev.pl> <ZPWiZSgyar1zWfR1@smile.fi.intel.com>
In-Reply-To: <ZPWiZSgyar1zWfR1@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Sep 2023 10:36:42 +0200
Message-ID: <CAMRc=MdRdiEE=FND=a2Y1XZVqUadzdx+UNgc63Okio_ha4h6jQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: rename gpio_set_debounce_timeout() for consistency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 11:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 09:34:09AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > All other functions that manipulate a struct gpio_desc use the gpiod_
> > prefix. Follow this convention and rename gpio_set_debounce_timeout() t=
o
> > gpiod_set_debounce_timeout().
>
> No, that's not true. This one is inline with the other gpio_set() _intern=
al_
> APIs. If renamed, should be done consistently.
>

All the other ones are static to gpiolib.c. With static symbols the
naming convention is a bit more relaxed throughout the kernel. But I
do agree and I will get to them in time. :)

Bart
