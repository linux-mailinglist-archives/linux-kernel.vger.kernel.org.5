Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB477F631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbjHQMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350790AbjHQMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:15:54 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8338B2136
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:15:53 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79de5f5c5f3so1321577241.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692274552; x=1692879352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpoPG9r5aLlMUihxVNUoSLd7j+JxqcKSn36H4Uz/EpY=;
        b=QSxcAdxK6wSmqFsOB6vBhCuyjy2/A+qN1AaDr+A0avXp/YC5wIhNk1oN+OOPst7xfT
         2G/iGC375cKsbJ/Tm6ldBuA6MVxwnCnL7kzAcOf3kVi3ReAnMuxkogiLsZC5F0PgPVdP
         k0fk5djKaWYMHzemnVeReyI/nt+iJ0oPFFe30DfZ/kOksIa//psfXz49nlnoNtNKdd5D
         FGKrXDZKgzS0qlclqkJd2KR0FHVgk2j1UxiStJYxQ9GdsajH8LvarT+ZRH4obz8TB2oX
         3KlgLyqDADyiJsC52R2J55+KH4lfpqK3YQfKUSRG+cUiMMUfhrnMk7pj6et5knzbzo4E
         aOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692274552; x=1692879352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpoPG9r5aLlMUihxVNUoSLd7j+JxqcKSn36H4Uz/EpY=;
        b=cXhz9dl7NaEmc9y33xnaC4ShBHXOP30W43KABhahi0KG4YXYPq1EupN57KdanP0uyf
         D4i929fQ6tkI9j5E1zlOTIlunuaGeDBuhme7yWnLBreq8ZS1cG7S16fitQ5l7kMOauP5
         1MqoodlobnagHRvPKZkbSSHXRQ9ZAD3rGBm5x3fFVvrZiHBPvGLplrmpkJk9sSFI1Toe
         dxm27CoOc0awBiApZUYu78gr+AQ77OqkSloe7Omfn/xZEMoRIScBpewGz3W2LqR6AxCJ
         TUG4SpTdMqXxLcP2ZBHJ+2422zlA1gF8LczLjJaYVba/jfzvjlVwgkwl1eb8VCmBFJdr
         NdnA==
X-Gm-Message-State: AOJu0Yx23iJhet+AqXoDq00i5KefVNtzGdVI//DjI2Lk3XKTzl++HJij
        D31LAKYYBO0TRi9UTCm2iJiz7T/AJF3QTv35Sh9hyQ==
X-Google-Smtp-Source: AGHT+IGTM4088o4qj1zm5IRZJM+9ZxZx6lPUqwnT25zoswoW2BrihSPfBo18GPPiGwFm85j/1N+b00aWLNC3zPh6ZIU=
X-Received: by 2002:a67:f991:0:b0:447:583b:acaf with SMTP id
 b17-20020a67f991000000b00447583bacafmr4723806vsq.31.1692274552670; Thu, 17
 Aug 2023 05:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230812183635.5478-1-brgl@bgdev.pl> <ZNtT37d3eR6FcQyR@smile.fi.intel.com>
 <CAMRc=McqdnBBSe1QhyNEFCs3E+Qb_K-z1dT+B8+n2KvWajj5hA@mail.gmail.com> <ZN3ncVjDn9ZXHOS5@smile.fi.intel.com>
In-Reply-To: <ZN3ncVjDn9ZXHOS5@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Aug 2023 14:15:41 +0200
Message-ID: <CAMRc=MeNvd7_g0ZpCDt5pceLFm7bbsyx4G9XQ5GzP8qUR+vAwA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sim: simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 15, 2023 at 09:09:55PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Aug 15, 2023 at 12:31=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Aug 12, 2023 at 08:36:35PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > -     mutex_lock(&chip->lock);
> > > > -     __assign_bit(offset, chip->value_map, value);
> > > > -     mutex_unlock(&chip->lock);
> > > > +     scoped_guard(mutex, &chip->lock)
> > > > +             __assign_bit(offset, chip->value_map, value);
> > >
> > > But this can also be guarded.
> > >
> > >         guard(mutex)(&chip->lock);
> > >
> > >         __assign_bit(offset, chip->value_map, value);
> >
> > Come on, this is total bikeshedding! I could produce ten arguments in
> > favor of the scoped variant.
> >
> > Linus acked even the previous version and Peter says it looks right. I
> > will queue it unless some *real* issues come up.
>
> I still think this will be, besides being shorter and nicer to read,
> more consistent with other simple use of "guard(); return ..." cases.
>

Scoped guards have the advantage of making it very obvious where the
critical section ends. It's really down to personal preference,
there's nothing wrong with either option.

Bart
