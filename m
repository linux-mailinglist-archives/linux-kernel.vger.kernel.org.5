Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D192F7BE93E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377093AbjJIS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:28:36 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C076BA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:28:33 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so1639697e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696876113; x=1697480913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVTS2gNSziSCqdd4br1CWXRZan38f1zAmy1gwi7TOnI=;
        b=oX+Vhx4KyGKyH9s3gwW4Zv3kGb42Nd5ceN8nQFUUx+7W0dEiELwTOu80KEpq0pQuo2
         lYRoC/hxRMS50s2zgfI8XbBaE6VnYRcQs0phpHkx2iXrtTYKnkYEK96HdR4CNuCO4pVc
         DkgjozwjvYjvlSEWZq4rvRcJe0/QAKoRV4G2Gg3UFqpUqBE+hAieFQ/x3/4+eKWQMG+0
         7Sb6FTbEyzokVlAfNbJDy/p99et7emr1DPhh30GFI5TkPH0QMC8YfGdqZ7fYqfgzrhyl
         fGTHwAH6AOIkKJmkK3MvjGFXxLw07w79wLmfXEmLq6m9WuItdfK9EyPQnjaOhJMW9uHy
         QeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876113; x=1697480913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVTS2gNSziSCqdd4br1CWXRZan38f1zAmy1gwi7TOnI=;
        b=Mp9sohokwySyvW0XqSVU7ar0KmUwKHSpTkrxKoEBwGSC+Rr98egFGjYtN+5dCwMGf8
         ToBuLB0u2QIATOfmfqmIPc6UXQv1CfPC/+zM6Fpop0R7mqrNFpQtn+mzSvMtlVscMsuj
         mn3Brp+CGjIHcNsX0U2TANJKmlc0gfbRryKNQXsV0Q3/bWOzRPJhMx7dUYrNp4yHgTVi
         6AhHQPPvKB64siZm/HQxhZNMc9S5Xq9/oSBqpECh9xqniB1Nqxsd7XT5nBSeHzfSZvHh
         B+JUyzmWyRVLw7ilwqS2SehzDfqC2m4X4XLmCpOWywnoAIcAinjS42ZEMYnGiBlvJO09
         a1zg==
X-Gm-Message-State: AOJu0YwTVkgTYkYhUt2/OggNz5gnfTOADJOyh2JngRg8XVRmsyShOIdF
        Xk4vFGEJO2uwG/tUH+OcsVSKu78Uc0LoYb4M+l83bA==
X-Google-Smtp-Source: AGHT+IGW64Icyk4xUDU85D92Wg7PfvyQNNDjiw3TmyPPLT8U9JJKy5TL8T0zon3iZKL7xXS8pLwpxYZUqYWZC7KKpJQ=
X-Received: by 2002:a1f:49c3:0:b0:4a0:8a35:6686 with SMTP id
 w186-20020a1f49c3000000b004a08a356686mr2006179vka.11.1696876112724; Mon, 09
 Oct 2023 11:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl> <ZSAIUVAQ6ifi8LTL@smile.fi.intel.com>
 <CAMRc=MdrLSPCEsQ6OEgRX-7Wh7ka+Rczja=QjY-srozj3cz68w@mail.gmail.com> <ZSEMnqAynnrfBxX1@smile.fi.intel.com>
In-Reply-To: <ZSEMnqAynnrfBxX1@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 20:28:21 +0200
Message-ID: <CAMRc=MfFEBSeJ78NO7XeuzAMJ0KezEPAYWsWnFXXaRyQPAf3dA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dipen Patel <dipenp@nvidia.com>,
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

On Sat, Oct 7, 2023 at 9:45=E2=80=AFAM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> On Fri, Oct 06, 2023 at 09:07:54PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Oct 6, 2023 at 3:15=E2=80=AFPM Andy Shevchenko <andy@kernel.org=
> wrote:
> > >
> > > On Fri, Oct 06, 2023 at 01:51:47PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > struct gpio_chip is not only used to carry the information needed t=
o
> > > > set-up a GPIO device but is also used in all GPIOLIB callbacks and =
is
> > > > passed to the matching functions of lookup helpers.
> > > >
> > > > In that last case, it is currently impossible to match a GPIO devic=
e by
> > > > fwnode unless it was explicitly assigned to the chip in the provide=
r
> > > > code.
> > >
> > > That's expected behaviour.
> >
> > Is it though? We now have a GPIO device that represents a piece of
> > physical hardware that has an fwnode assigned and the associated GPIO
> > chip (tied to that device) that has none. How is that logical? It's
> > not coherent.
>
> To me it is pretty much logical, yes. The providers decide themselves
> if they want to have any specific device node for the chip or inherit
> it from the physical hardware. Note, there are two types of the FW descri=
ptions
> of the GPIO controller, when it's 1:1 to the banks and when it's one devi=
ce
> with list of children, one per bank. Due to this differences we have
> this field in the GPIO chip to begin with.
>

This is irrelevant for this discussion. The tegra driver in question
knows which fwnode it's using - the one from the parent device. It's
just that when the HTE driver tries to find the chip using either
gpiochip_find() or gpio_device_find(), it fails and I'm pretty sure
that if Dipen bisected it, it would point to commit daecca4b8433
("gpiolib: Do not alter GPIO chip fwnode member").

IMO the GPIO subsystem should take a phandle to the HTE engine it uses
for timestamping and that would allow us to not do the lookup at all
but that's a different discussion.

Anyway, I think Linus' suggestion is better than this patch.

Bart

>
> > I'm not surprised users of that code will be confused -
> > like Dipen in this case.
>
> Which case? I'm still unsure you pictured the issue here.
> Where can I read about it?
>
> > > > If the fwnode is taken from the parent device, the pointer in
> > > > struct gpio_chip will remain NULL.
> > >
> > > > If we have a parent device but gc->fwnode was not assigned by the
> > > > provider, let's assign it ourselves so that lookup by fwnode can wo=
rk in
> > > > all cases.
> > >
> > > I don't think this is a good change. We paper over the real issue whe=
re
> > > we and callers need to understand what they are looking for.
> > >
> > > ...
> > >
> > > > This is something that Dipen reported with one of the tegra drivers=
 where
> > > > a GPIO lookup by fwnode does not work because the fwnode pointer in=
 struct
> > > > gpio_chip is NULL. This patch addresses this use-case.
> > >
> > > I am not sure I understand the problem here. All these should have be=
en
> > > addressed already, no?
> > >
> > > So, the GPIOLIB should use dev_fwnode(&gdev->dev) inside it, outside =
it
> > > the GPIO drivers are free to use gc->fwnode as long as they understan=
d
> > > the lifetime of the respective object.
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
