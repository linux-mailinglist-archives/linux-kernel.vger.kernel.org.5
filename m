Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A27CF223
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjJSINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:13:12 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A12C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:13:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7e5dc8573so94758257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697703189; x=1698307989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNXAg6WXAZAsL2lMx9e2qvm8h7lypLA4sU9HIno/7Ac=;
        b=CbM48R1Ta6XNWpCc+/vYUA2vOBM/sbqtdW53wvVg0cDxIvlXaHFsOFcEejYyMPYNga
         NHroH8W+zYrTjVhTs/3pVnz28/zX4iRaeeEEWtjck50oIL1TGdkNG1mz4yLOPp04Cw40
         6XXzs3W8GG9YMVfMXoQGlm2i6TIXZe5UAgL338kWPyZYpFbUlqW7ftnQVI619xGyWFn9
         X5YVCELkOHjtu3VLJDZ8Gpyrl3ruzVTOsO3X3sDRbG7Lt3qfpFYYEkoJmX8+kjHwxAnY
         7DevgxnRp+Afhh56lfMPyqSqr8NRsHw4g9UfNkpoMv2VxhRVB0737cAE47sYNndvnbWE
         DjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703189; x=1698307989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNXAg6WXAZAsL2lMx9e2qvm8h7lypLA4sU9HIno/7Ac=;
        b=qY/tnXXntpYQ8Hi+jDhxu71kHUDkjCNfRyNqMSbnb/avD/sfUakOgCrChH79d+vSwr
         RbP8QJnFI0leRb8Ia8rM5Fna/iPmppE/25kIXiWEKYzVmPfEikz5P7m1SO82x8Ty/L6Q
         T3Baj9+vakm6tnL/85bXyzsyuENIMbA0HMXa8be97ne9wJR427l8eDfMKofXFP39F64H
         yF51ctId0UDgQdSYWI3KGQo+q+1CuQ7X7twMar8s7bJSaTdCSd5jJ0nTvs0kbpDvVpDK
         i2LLtrKmQQ+2VIle9cln3iZoA57LsejT9ilGLDaPlVA/ZPagh3+dHrkDU3udcwRVmebC
         qhUw==
X-Gm-Message-State: AOJu0YyR16oDBp7dKFbm/imb8cY/BjefsbYkpHwUydwYmi1t5bJQykGn
        No288PPyWNbD8BsjlM7AWiS/y49UQFr10hJjZEAlNA==
X-Google-Smtp-Source: AGHT+IG5/me75SiraO/3My6hz1nX11lqSMH1zP+XrnVS62FOFGKt+YA7jS5F5Cc3ovhRHVneD+/m1Jf4WUkFXTNa7Fc=
X-Received: by 2002:a05:690c:101:b0:5a8:e303:1db2 with SMTP id
 bd1-20020a05690c010100b005a8e3031db2mr193504ywb.23.1697703189456; Thu, 19 Oct
 2023 01:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com> <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com> <ZS7_5VGvRnw99gzd@google.com>
 <ZS9mo4/jnRNoTE+v@smile.fi.intel.com> <ZTBfFIyCsl2gkp6f@google.com>
In-Reply-To: <ZTBfFIyCsl2gkp6f@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Oct 2023 10:12:57 +0200
Message-ID: <CACRpkdZ0cnJpYuzU=47-oW-7N_YGMo2vXpKOeXeNi5PhPY7QMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:41=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Linus, BTW, I think there are more problems there with pinctrl lookup,
> because, if we assume there are concurrent accesses to pinctrl_get(),
> the fact that we did not find an instance while scanning the list does
> not mean we will not find it when we go to insert a newly created one.

I'm not surprised. Pinctrl comes from a time when the probing was
mostly serial, and since subsystems (such as MMC) has increasingly
added asynchronous probing, accompanied by rework of device tree
core etc (device tree didn't even exist when we started pin control)
to parallelize probing based on device hierarchy topology etc.

The people making probes ever more asynchronous probably just
tested if the system still boots and did not bother to go and look at
any rough edges in resource supplying subsystems, including clk,
regulator, gpio, reset, pin control...

There is a reason to why it mostly works, which I explain below:

> Another problem, as far as I can see, that there is not really a defined
> owner of pinctrl structure, it is created on demand, and destroyed when
> last user is gone. So if we execute last pintctrl_put() and there is
> another pinctrl_get() running simultaneously, we may get and bump up the
> refcount, and then release (pinctrl_free) will acquire the mutex, and
> zap the structure.

You mean we need to acquire the mutex in the code that calls
find_pinctrl() instead of inside find_pinctrl()? Yes I think you're right,
wanna do a patch?

It is largely theoretical because of the following:

A pin control handle is
usually taken by a driver for a device, it is usually unique
for that exact hardware (in difference from a clock, or a regulator,
which is often shared), so the scenario you are designing for here
would be that the driver for a device is probing the *same* hardware
on two runpaths, which is not going happen, right?

So while the software is not race-safe, the nature of the hardware
makes it safe: there is just one device instance per pin control
handle.

I haven't thought it through in detail so there may be corner
cases.

> Given that there are more issues in that code, maybe we should revert
> the patch for now so Andy has a chance to convert to UUID/LABEL booting?

Yeah I reverted it, the above elaboration may apply to this patch
too and makes me feel we are "mostly safe" in this regard anyway.

Yours,
Linus Walleij
