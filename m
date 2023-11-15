Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28127EC776
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKOPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:37:48 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633612C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:37:44 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6cf65093780so4020005a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700062664; x=1700667464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxWKE0RnE67ZCac+DE3wf0+WlhQHwaxB8ToZtgmVZwY=;
        b=pBDRktK76id6NpKj3jlCs/xMSpWkPsLSPwkT+oitTZfn0ctMgfSu3Cj3lbVGNtzSVl
         JnDunYOnaj8kozNVwM9OxPo9AtRtqJaOpXbPsaly16Z9gUGxtgJZ/LivykVi5zgTeVYE
         Eg6okvKXfe4AYLB2Rw391JlzhG2NXJF+xfe+pEVblOydZOfQSlxZsPao3Nz0VK2Lo/zS
         lfBb1NMozCh+QRcsMT0lexpxwe4Zll4na8lEHLIftatwZPm27lE5Ih9xehsv8azYIvoT
         4bD42ibE65tdd/f8ddjIyaGGjAql5tAf81PGYn2KetJnvcDj21wpf0zQANRTSKH6hiZe
         QXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062664; x=1700667464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxWKE0RnE67ZCac+DE3wf0+WlhQHwaxB8ToZtgmVZwY=;
        b=hdo4ay+ADbEVK7sG5S4MxyM9Ew++QdMUvPM9Tw32p8UQxkx1wN6SpT9gihexYt+aE7
         ojkzphIJKfrfb+NKwOZumGA5H4pjG7VAfEmRRm7tJON4HFBAE8/lDDR7pMUolZltMns2
         rd+cxGZr3+le9NALEspKwKKmmBIo3jMRaRCMsVaBoc8LyaDs177iU33SOCr2I9uMvVGn
         68ag4nWlA+XhzVifGb0jcefmPwwZ9YNaVpIjUaSsfiD8JA2Ze/cpX1Uhe29KQ+0gd8DO
         wxRMqy8q+0szpy6v2lSUxvTfS452G+zCuB1XompDCosCNMIpRni1EQWTwNJnE9FVlhng
         w/vA==
X-Gm-Message-State: AOJu0Yz6e0SYoDp6FZGiwgRrlvTCSp9kS2/duEplm13PtQwfu9l3pLPJ
        jdmou9ixgZfeNqEX2/rMHFIPt0S9yVDk5LDnl3VrHw==
X-Google-Smtp-Source: AGHT+IGO8zAnm0zIxz1rZhEvNk250XK6A18NgKyait+fesnXkzrYw4HG90ngI8KHEvMDRK2dAwrF7to4ErqNn8RuSQ0=
X-Received: by 2002:a05:6358:590c:b0:168:e69b:538c with SMTP id
 g12-20020a056358590c00b00168e69b538cmr6106636rwf.3.1700062663887; Wed, 15 Nov
 2023 07:37:43 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com> <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
 <ZJHWdcP+PDaNrw07@smile.fi.intel.com> <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>
 <ZVQh_nvgqMkd3tN6@surfacebook.localdomain>
In-Reply-To: <ZVQh_nvgqMkd3tN6@surfacebook.localdomain>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Nov 2023 21:07:32 +0530
Message-ID: <CA+G9fYujHuwn_AFDeFHbt0DMx7A63fjLR25aX7pkoMcVmmxbog@mail.gmail.com>
Subject: Re: selftests: gpio: crash on arm64
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 07:12, <andy.shevchenko@gmail.com> wrote:
>
> Tue, Nov 07, 2023 at 07:21:32PM +0530, Naresh Kamboju kirjoitti:
> > On Tue, 20 Jun 2023 at 22:11, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Apr 11, 2023 at 10:57:28AM +0200, Linus Walleij wrote:
> > > > On Mon, Apr 10, 2023 at 11:16=E2=80=AFAM Naresh Kamboju
> > > > <naresh.kamboju@linaro.org> wrote:
>
> ...
>
> > > > Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-de=
vres.c
> > > > and see if the callback is even called. I think this could be the
> > > > problem: if that isn't cleaned up, there will be dangling reference=
s.
> > >
> > > Side note: Since we have devres tracepoints, your patch seems an over=
kill :-)
> > > Just enable devres tracepoints and filter out by the function name. I=
 believe
> > > that should work.
> >
> > Since I have been tracking open issues on the stable-rc kernel,
> > The reported problem on stable-rc linux.6.3.y has been solved
> > on the stable-rc linux.6.6.y branch.
> >
> > Thanks for fixing this reported issue.
> >
> > Upstream links about this fix and discussion,
>
> I'm a bit lost. Is the [3] fixed? Is the fix the below mentioned commit?

As per my understanding on this,
The reported issue has been fixed with the below commit.

>
> > Commit daecca4b8433
> > gpiolib: Do not alter GPIO chip fwnode member
> >
> > [1] https://lore.kernel.org/linux-gpio/20230703142308.5772-4-andriy.she=
vchenko@linux.intel.com/
> > [2] https://lore.kernel.org/linux-gpio/CAMRc=3DMfFEBSeJ78NO7XeuzAMJ0Kez=
EPAYWsWnFXXaRyQPAf3dA@mail.gmail.com/
> > [3] https://lore.kernel.org/linux-gpio/CA+G9fYv94gx8+-JMzbmQaue3q3y6QdB=
msGUCdD-26X5XavL3Ag@mail.gmail.com/
>
> --
> With Best Regards,
> Andy Shevchenko

- Naresh
