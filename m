Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62C7B4F95
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjJBJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJBJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:54:55 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F1AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:54:51 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so6188897241.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696240491; x=1696845291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQk9WKQf6wTX5p8wxFHLOknA4t/nyk+AgRRg1oWYdhQ=;
        b=Mv815g/nbn4u+I/KrsKa9iyJhqx3JwE+L+KWjECqLOu9e9chdWhji57KYEL7eVKnER
         sLXu/clJB+AdbsL7V4YzyvWBYx95/v1vpcQ4iYXZSobH5i0+Qopd80B3m9ddKLQq/Fgu
         S0dyesIgw5EoRu381pOGjbdEYKbThC/L2woPBarT1yVF+XkZ0TNFTwKWHqtT7NLTUjHN
         vXFXS54dXC/KtEzMCRLu7gJkpuiS7KrJbCwa6HX2GXVZOKKYUgKzuvTfGxWOzWf2vrSm
         ij5GvODhmC8XE7K1Lgly4K7t9p+Rx0Q/rus0cIM0HwbAMOl4oICCv96VxDXz9sH2BDd0
         M64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240491; x=1696845291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQk9WKQf6wTX5p8wxFHLOknA4t/nyk+AgRRg1oWYdhQ=;
        b=HdwXHNFG6Fy/PouC3pl5+0PRDXzBfu6z8kbBgIvGIJr/QVvlp4GfwgTw4+S9cHW0lz
         0opFHdudsampd5ebuqNhbZc2sFB+3zKRl75lQvlUzzVVCH5s8BTwOGZjAvXHuEOkjtVL
         1hGHRfHR/wbeCZC3TjbOF1/DSBu4RiDfeV+9IiWH1EvDoe8BKanil8CydAXWPixcNd0P
         ZTAD3ZSjLa9u+98IA3TblnC8J29Y9h6ZgYFbthjYtz87FCkMF69MgAJCwTCaP4hbuKPJ
         mR6NW3cvdqiB8nxtLlm03U3EirUDQ/cpefrhvJSy1giu7IwmhPmiCKb+Q6TYIuMAzaOp
         Y6qg==
X-Gm-Message-State: AOJu0YxEJAydmKmHvhbpZtE4NFwop16yBLjy1ok5cxbZf0TZZ7okM24n
        Kx4XP2dETcy+Qt81x6CIaeazgQNb3Xu14rEOSsjOQw==
X-Google-Smtp-Source: AGHT+IH3Wly4Y8a48dseTR5Kou8rKUP3Ria54hdWexULcUH+2B+J4+J2ck9zX9NWtGibqgI6Ke50Lkhgrls8gcDKcc8=
X-Received: by 2002:a05:6102:302b:b0:452:6bb2:3620 with SMTP id
 v11-20020a056102302b00b004526bb23620mr9152195vsa.22.1696240490732; Mon, 02
 Oct 2023 02:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-6-brgl@bgdev.pl>
 <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
In-Reply-To: <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Oct 2023 11:54:40 +0200
Message-ID: <CAMRc=MesApEwEQxesBkodtB_4Zu4ubf3XScJ4iNLwn7sWBEcEQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] gpiolib: provide gpio_device_get_desc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 27, 2023 at 04:29:25PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Getting the GPIO descriptor directly from the gpio_chip struct is
> > dangerous as we don't take the reference to the underlying GPIO device.
> > In order to start working towards removing gpiochip_get_desc(), let's
> > provide a safer variant that works with an existing reference to struct
> > gpio_device.
>
> ...
>
> > +EXPORT_SYMBOL_GPL(gpiochip_get_desc);
>
> > +struct gpio_desc *
> > +gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
>
> I'm wondering if you move this to be upper than gpiochip_get_desc() and
> diff will look better...
>

There's a limit to bikeshedding in my book and "making the diff look
better" is definitely it. :)

Bart
