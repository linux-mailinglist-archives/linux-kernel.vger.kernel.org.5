Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F879CC49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjILJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjILJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:48:43 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2261BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:48:39 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44ee1123667so4045004137.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694512118; x=1695116918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XegseyGbBhwk1GzmJtqKu3s4esIjMwTsj/hm4IRRIfo=;
        b=qoKR+jaOCiFSEeZ/9seWwqcpiKb7omlqsCgSrFOCrRHVPJhbUneIa8dt1W2WXMzs7l
         cT0YgDquNWwf58QVohDygdh0mLQleI1Cpxm/xnn1ftu08HBbD+YXXEuToUasxLYI39VI
         MXWUf55leSztRDwXpUClsIPrDF39eRDkJHQ5nC+l1d3e5Za6L3VgyhU8g0xRA1yw2I6m
         nNcm5GwgUP7j85nrXt3AbryTSSbBtytpcLpMILV+bZngvU1Jh4I/NuDn+NtoRtWTdduO
         9aa19yhjtBl0+/MmvCSOEX+Fde1rcvqclbA0LVBqH3ikwv1VfLo1D9ZLUGuKURWu8FOn
         vJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512118; x=1695116918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XegseyGbBhwk1GzmJtqKu3s4esIjMwTsj/hm4IRRIfo=;
        b=PVRr1hR16J0EyUz+vivzJo0GXbqfgnrwKF8onU/FRgVM8ic3doO7rpIecqEmXN0fsT
         jDuM9uRdhD08qns5KWaPlGxqnGsAf+PR+ozjfCKO/taqhW4BX6LyFBdPOdNhVFSUlNm+
         Jng87jWejJ+4R7LYzL5E8WNRoYueGLgf0lRXlNxxDXOBzuA5dEaLTvO/PAfoNZBV7102
         +v3N9uzGPfMJuXGoVtGQhe2nV7V4k8PqGxBUBAd2pTnC4jCZKR3gAUSRxEUbK+GMlyMO
         BZ1nqr31gkx0GQPTr48kLUB9bPnTGayx/QCNJXN7pq2LsqV5JCQKwBSRZww8MZtIbm1d
         lTrQ==
X-Gm-Message-State: AOJu0Yyh0Aaj+ob6Byp0shLQO3cYcPvuRa2PYYrNslAmGcmB70S5oswm
        265aNLToFKjmBw58xrS6/X7OsJTzd1H3BBiW9FHZFgjUf703KEAO
X-Google-Smtp-Source: AGHT+IEJwf3nugnFKEbsWlJdXzncq+YA9WBmt/gWJIffz95iuIU5iY+aqvxZEgfxykDF3xkesvO+tHW+zDPuL+uP6Xc=
X-Received: by 2002:a67:ea87:0:b0:44d:5c17:d065 with SMTP id
 f7-20020a67ea87000000b0044d5c17d065mr1033528vso.13.1694512118510; Tue, 12 Sep
 2023 02:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdboT46oadZJZTde=ze2vEvC9aUGjO5-MjDdVwCNijFqDw@mail.gmail.com> <ZQAv8wJuS7t0RV+m@smile.fi.intel.com>
In-Reply-To: <ZQAv8wJuS7t0RV+m@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 11:48:27 +0200
Message-ID: <CAMRc=MdgNxt4wobVLU5kqcnyW6J-=bMRLBk5cAmaEmucV-t0Pw@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct pca953x_platform_data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:31=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 09:50:06AM +0200, Linus Walleij wrote:
> > On Fri, Sep 1, 2023 at 3:40=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > New code should solely use firmware nodes for the specifics and
> > > not any callbacks.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Patches look good to me:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > for all patches.
>
> Thank you!
>
> > Patch 8 looks HTML on my gmail but I guess the problem
> > is on my side.
>
> The entire series has been sent in the same way, it's quite unlikely that
> the only patch got mangled while others are okay.
>

I'm using cmdg - a command-line interface to gmail - and all patches
look fine. Surprisingly, the web interface indeed does mangle patch 8
for some reason.

Bart
