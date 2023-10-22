Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CE7D2566
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJVSnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjJVSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:43:14 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D61E5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:43:12 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so748934241.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698000191; x=1698604991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFBzhBHfJGAdxrzBo65ARLhrUEXHoWpeGGwEKhF39R8=;
        b=bQxnGHiX0sSHbZ8WYNusXjOlanQ+jVD4vXzI68f0EwDZPjcFO0iP8R5atIsNQf4RzL
         MDd4OKDV9HOlSb2EYOxoeObvC9p3kkYeDjfNrZFaJfzM9LDtSDQrQYzjQn90L2K5gUX9
         HjJiN4DmE6bnVKysDpKjQKrG/heSPeo/PcKLQSIBjvcDXXbHGXQ9piFRIE8fVInN0vwe
         nzO9i4mUBDi9u7QPDSiQWHcOJGvdLGftJm1Q3M4ekQxNjr0zZBdi2M7PDRfjYMpseDEe
         Fhe7VkRsxUhTKRQuJIt9B05vtHB1g93Vu0pFlkgdGK9QzpaADFbuxyKqd4EhjQ5jFzU8
         rarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698000191; x=1698604991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFBzhBHfJGAdxrzBo65ARLhrUEXHoWpeGGwEKhF39R8=;
        b=qLtYIE4K04ZEVyeIKLKSnrwlOrdzjqUcNMAJVPbtA0zPzzP9dqhN0ktedQTVqqjjiN
         thxH/D2cCWnpuB9NWsZYMRoKcZiyqR0GQncPO1eMd+GdLN5a1QQyu4oA6JL/pA+WbY6J
         sIZqHpaT3uajz2uobPNa08eqQ/7Kc6c+7rixrM+4gehbAvorX0UkWRTaYvOlE5JRBym4
         uDqEmVohPUUUVt5Twdigg6/Qwe1ltm3u4Sy1Jmm//Cvz3wIPMh9ICltCV30xI30W2O/+
         FUoGvYQdaEkgCAHYoB50K92AVa012M6mSW/U8BOofZs2bI/rqDMHbGCVHrpzTlJueT1b
         fb4Q==
X-Gm-Message-State: AOJu0YyhtvDhB1rjWGXxqkDiChgH0Y7ICtUuTZ4zl5lXZxuKwBwpiiam
        14dOg1MWn2qg2KLqHXnt98ywleHK4R0Mj+tmWCavjA==
X-Google-Smtp-Source: AGHT+IGiZKxzKxcabuTtjw9YgtwMX4YfPKb1BC7tx2cMURaMOAYnK+6uOptvRh9ClEI8Hk0rSt471/51wbmQo8a0AY0=
X-Received: by 2002:a05:6102:160d:b0:452:6b50:1e7e with SMTP id
 cu13-20020a056102160d00b004526b501e7emr5749208vsb.35.1698000191741; Sun, 22
 Oct 2023 11:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231021183925.22831-1-brgl@bgdev.pl> <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
 <CAMRc=Mc-oz4e4d9pJbvki3kGgMj1DzSS1EDKcycswJKCNAbqOQ@mail.gmail.com> <CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 22 Oct 2023 20:43:00 +0200
Message-ID: <CAMRc=MezGuMdd=H_vdSmdm++YDm59gB6TK2HbqDQypqDOSjj8A@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Sun, Oct 22, 2023 at 4:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 22 Oct 2023 at 06:12, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > I have diff.algorithm =3D patience in my gitconfig. Typically this
> > results in better diffs but not this time for some reason.
>
> Yeah, that picks a really odd diff in this case.
>
> May I actually suggest the 'histogram' diff algorithm to you? It's
> kind of a "smarter patience" version, and at least for me it's been
> the best of the choices.
>
> Of course, there's always going to be some odd case where for one
> reason or another one of the diff algorithms does better than the
> others, but histogram does seem to result in good diffs most of the
> time.
>

Sure, I'll use it from now on.

Thanks,
Bartosz
