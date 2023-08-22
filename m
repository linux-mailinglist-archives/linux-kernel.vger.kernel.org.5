Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5167845BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjHVPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbjHVPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:39:04 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9FCE7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:38:58 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48d0edd8a81so839870e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692718737; x=1693323537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNOB/ytBkL2V3HoSr5q3ZrR1tYhUuCfM0bUrM/8EyfM=;
        b=0PI9zYyQ8D+Hvp/PFSDLwKqTjrVESxDjlc6hRfyedYIZ2kc+rFBVYsXVuQew6v1/xk
         yrKdKFPhNw92IuQLkrwazt7lx4RT41prFilBk1MEnrM4cD0wkTcYXPX5yMmIg8zEeFj8
         pdOf0VkkPo2uIOBMrRciwTYYPu30e1yZsI7b2bSjdQVohWcGgIxYHjV7+OelDJZIO4+G
         gfK4olE2lvq+iAhh2RzszBwVrCdxOXZFw9O701wfEwnRyi1apWxTG9F7r3cEOR8+z4pq
         e19kPdyC6DDMgPK3Yw9Kn71P3Ugbe6rY7qqU0vJjfDEPFCIO1pDHaczmhXDjYZ8jkMHY
         n/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718737; x=1693323537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNOB/ytBkL2V3HoSr5q3ZrR1tYhUuCfM0bUrM/8EyfM=;
        b=VBX/uAz4Rd6YE/Xjl+dDLJkdcM+v1QpLxQ3ymp5LoX68xWN2aPHXqFZIPFCyPU/CgC
         ufXr1GbPMHgWqNGovm0dwpPw6P8HMd9q/nD+NK7Ut3wrtlix3Wqzx5Ino6GEvkj6+vCN
         vUCil7zIVnIZdDVwZcboChOwAebtMWdXCDLKSnJu5BnWGuWWF3ipFOcsUiPbs7/t0py4
         w1BypUko5owyJb/GtVjXwbA+whxE9Se+llsxgh85h3ZlKD/y8WbaCf82pBUAyfXSKuO8
         qs9Xr033I2BrpM6ZyXY4GmEBmaJhXXcLmOkJeDLpIH3hL1mc4A6HW1udgnv9Hlg62qnH
         JSqQ==
X-Gm-Message-State: AOJu0YwOVpT0BR6umKduWelC1kGFQwlRxXNE1+QMBiLkLaRtOI0fgkTF
        kpTtI7Szh0sX7A2MCnQT9g7dnjfuQrWjsL2tL0+uxYT6rb1a0NJcdi0=
X-Google-Smtp-Source: AGHT+IGsfdLCngf36xWwcOeFXsIqJNxcEMmABRlZ52uh3h15bGe5EF7e4EJBVTzMSzMs8XzoRy5vMZWA+KxNlVffwCI=
X-Received: by 2002:a1f:e783:0:b0:48f:9c75:411c with SMTP id
 e125-20020a1fe783000000b0048f9c75411cmr1218804vkh.6.1692718736057; Tue, 22
 Aug 2023 08:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230822152244.214394-1-brgl@bgdev.pl> <ZOTUHzKKBNcjQLRi@smile.fi.intel.com>
In-Reply-To: <ZOTUHzKKBNcjQLRi@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Aug 2023 17:38:45 +0200
Message-ID: <CAMRc=MdWbQPuNh=ziyqD_xVaXDD3nE5yNeq1+d4F_P4_3H=xxQ@mail.gmail.com>
Subject: Re: [PATCH] HID: cp2112: make the irqchip immutable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
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

On Tue, Aug 22, 2023 at 5:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 22, 2023 at 05:22:44PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This make the GPIO irqchip exposed by the CP2112 driver use an immutabl=
e
> > irq_chip struct thus addressing the following warning on probe:
> >
> >   (cp2112_gpio): not an immutable chip, please consider fixing it!
>
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Df=
or-next&id=3D3e2977c425ad2789ca18084fff913cceacae75a2
>
> Can you test HID for-next for this hardware?
>

Ah you beat me to it. I didn't see this one.

Bart
