Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A979139E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbjIDIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjIDIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:38:53 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C5693;
        Mon,  4 Sep 2023 01:38:49 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57129417cecso635242eaf.1;
        Mon, 04 Sep 2023 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693816729; x=1694421529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euVcaqc3iNOhFXGuAHhzwKfsbwhKtrApFarhHmN/bFU=;
        b=WYW06ibCdolEx0ERW4mR2ZA3zwWgL/26YmJcZBGhZYWpEnc4NZF5HRyZP/E/jZQ6Mi
         IBHOdHDJ37RTz+N0WozySPHWLiKta2CB2BXMMlOTZ/H/BhEYDPmZu8oDgaDxMeALBcXo
         XjmctkI+mYANtXCbHIyUPyqV2iUx8alZQpdJi4wamxPpfypvGdyOVwAHzFTSsoqqbDc6
         i1sG4TyDEy/8xwfgVfjpsbRiDwEfd8CjN98DFjdU8tHxGfjZaeQS/En9Gyg3ncBWozG6
         Aexou+yw7JTzjHLJYezcAXJvkfkv1V5RYXoYBWi3vZ+cowPuYGp6uGpFL/Rm/1kKDMwt
         BL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816729; x=1694421529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euVcaqc3iNOhFXGuAHhzwKfsbwhKtrApFarhHmN/bFU=;
        b=LsJVvNWG3Rh95XC2JgZJxHKR6NG6kZ77azSSdkKRqXiWy3h2O027D+//WKon10fNjn
         krUHSUvw4XQsQQnyPb+sfGrjkmodY/NBkob7X9HQhRQ47J+GBlGQEWRYusEReF9bp/zf
         xZ0wceBwsxGt3C0CYkhkzC1O0PaOz2ZWzYQjEGObDl9I3ajZYbXKS3CxMqqlwTl7/c8r
         5G0y4rG7AMejLPPyHsf05xxmdeIQJdrLOSWJXkx6kyVq95T7NOTL4pBHJ+2yXbCfpHUx
         qHfbeukkXpNDCZT1KKds4bP/yk319Tg/NpvCNp37YaNUPRj9iibCq784xWt255bbhZV6
         VFeg==
X-Gm-Message-State: AOJu0YzNNCHWvXqy8UOX4xO5H212ThlU6o8MI170VMXhy9OFRkbsBubW
        kn0AawHrLCLXeWxWJ5IxlVEmXcW5PK9zuiRvwQI=
X-Google-Smtp-Source: AGHT+IFX7qxLdNGURdvBoB5gOSf2pVNaey+i0s2bY8CspEQOdYHoGeEZZ9KVcGeayVpOANmK3vv4tCo8wiJZevvj8UQ=
X-Received: by 2002:a4a:a591:0:b0:560:b9f0:b9fc with SMTP id
 d17-20020a4aa591000000b00560b9f0b9fcmr7621230oom.0.1693816729048; Mon, 04 Sep
 2023 01:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-9-andriy.shevchenko@linux.intel.com> <CAMRc=Md0K2MxLKtJ2c1JB4GF-2L7THCN-maCqFVFGZ+qYM1Uaw@mail.gmail.com>
In-Reply-To: <CAMRc=Md0K2MxLKtJ2c1JB4GF-2L7THCN-maCqFVFGZ+qYM1Uaw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Sep 2023 11:38:12 +0300
Message-ID: <CAHp75VcAoHEaRyA0UZWTNVFr2MThmD_uhjFghj+ZT8Awih1akw@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] gpio: pca953x: Get rid of useless goto label
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 10:41=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Fri, Sep 1, 2023 at 3:40=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > In a few functions goto label is useless as there are no locking,

are --> is (that's I missed)

> > no nothing that may justify its usage. Get rid of it.
>
> I guess it was supposed to be "so nothing" but I'll fix it when applying.

Either will work, while original is incorrect grammatically, the de
facto use of it is common
https://www.urbandictionary.com/define.php?term=3Dno%20nothing


--=20
With Best Regards,
Andy Shevchenko
