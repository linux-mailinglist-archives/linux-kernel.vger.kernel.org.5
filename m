Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE779CD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjILKKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjILKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:10:38 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966D1FF0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:09:35 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7a25184a648so2490828241.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513374; x=1695118174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmVQQDfuX/j76DUm++ev24Gh9ttqt0+2IKJM2QX7OSE=;
        b=HFglwU7Cb0vP34PvfqgkXzzet0UVEfDnSfMcMz/bpj4HGMQdJfeO0Y34V/5iMKm19a
         lrhlyISKrhaOpMHcyh/n+4GaDle6h/z8H/BLCLwq8onm7tIwWHs9TzhYh/VygAsKhUEa
         N7F57IzQ2M1JXe7JX6rYn+rkFAGXE0kxIUX908lEdWfoNOYkx6my6gS9YPQUrT7Dqtak
         4usQ0JEg3dVJDXdmc/lb8fv8ve2WY4VaiMnfu14pTtFPRUpR7oiLXF1aJP77uKrw80K1
         45SsuKusSODd/xYqzZQ3nK3hbAuywC99qguacHhHKscrWCvElRTSkZeeDO+FveX3RaVC
         n4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513374; x=1695118174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmVQQDfuX/j76DUm++ev24Gh9ttqt0+2IKJM2QX7OSE=;
        b=YmvQxMUy+NoPFZCsLAb3hV0J4U7an47S8kCL+/mb9sAjofuPR5pcx+axRHFhkJk85D
         1HDNZJeQXNM4jCfJpEyWLTN3F9iaopolZIpziHBgvd+ctQP2d0DqO5PPQdaYYne+FE1d
         IFZlFdioX3TivGDgHXPZGvWimp2iWcULw9snnNXk/7B9NTgpNb9qDK4b79Xv5y/lSgol
         bwTgvaz5ZjPSipZ9TePtxycUT948E9FUxpsi3/wyLARt9zt3BztJHhPgItCgiilIRrEp
         LQKnKCo5cJ6/N1RyaNP/AjCTnCzEBB+EMErSQNFXg4sKHQSr0ocPCt1I6cMlASCntsot
         +waA==
X-Gm-Message-State: AOJu0Yz9pkdHV8DMynxbZl7lAeAfXoNICanIxrdzHOmm+nM+stvVkLB/
        /aPYuw0m6IIcblJQIBX+f9XJCJcbocQvGHItZLzWrQ==
X-Google-Smtp-Source: AGHT+IGZ60lRPEbVSHt6DeyFJ9ULYeQIvv5Z64eOq55b6CG24sCbp0lLHEVPsajyXrw6r7m0v8GYNjRP9XJCWvyk0Ws=
X-Received: by 2002:a67:f557:0:b0:44d:5b62:bcd5 with SMTP id
 z23-20020a67f557000000b0044d5b62bcd5mr11766196vsn.23.1694513374192; Tue, 12
 Sep 2023 03:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230912094519.22769-1-brgl@bgdev.pl> <20230912094519.22769-3-brgl@bgdev.pl>
 <80d7b0ad-026d-6ba9-7c1f-7f0c3b5af588@linux.alibaba.com>
In-Reply-To: <80d7b0ad-026d-6ba9-7c1f-7f0c3b5af588@linux.alibaba.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 12:09:23 +0200
Message-ID: <CAMRc=Mf4YvHVparOOPjDAVeMs5Oby4tjkaVYt4hoqLP4rKKbmg@mail.gmail.com>
Subject: Re: [RFT PATCH 3/3] gpio: eic-sprd: use devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:05=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/12/2023 5:45 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Make two calls into one by using devm_platform_ioremap_resource().
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Please don't do this. See the previous commit:
> 4ed7d7dd4890bb8120a3e77c16191a695fdfcc5a ("Revert "gpio: eic-sprd: Use
> devm_platform_ioremap_resource()"")
>

Ah, I see. Dropped. Could use a comment describing the problem though.

Bart

> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index be7f2fa5aa7b..1e548e4e4cb8 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -594,7 +594,6 @@ static int sprd_eic_probe(struct platform_device *p=
dev)
> >       struct device *dev =3D &pdev->dev;
> >       struct gpio_irq_chip *irq;
> >       struct sprd_eic *sprd_eic;
> > -     struct resource *res;
> >       int ret, i;
> >
> >       pdata =3D of_device_get_match_data(dev);
> > @@ -621,11 +620,7 @@ static int sprd_eic_probe(struct platform_device *=
pdev)
> >                * have one bank EIC, thus base[1] and base[2] can be
> >                * optional.
> >                */
> > -             res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
> > -             if (!res)
> > -                     break;
> > -
> > -             sprd_eic->base[i] =3D devm_ioremap_resource(dev, res);
> > +             sprd_eic->base[i] =3D devm_platform_ioremap_resource(pdev=
, i);
> >               if (IS_ERR(sprd_eic->base[i]))
> >                       return PTR_ERR(sprd_eic->base[i]);
> >       }
