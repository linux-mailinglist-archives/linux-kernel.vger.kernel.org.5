Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895BE7590C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGSJAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGSJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:00:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68535172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:00:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7835971026fso290066439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689757244; x=1692349244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SamseihHveHRCFRV/VFLPEZGl+SZA6Yk6XZ5fusUv5A=;
        b=Ugkye6s2X/gZoq0X/CqbIIbknRu6ceke7LB3VJV2qKUB+lYDKlMeJcDzRr18+F8AnN
         N+OaA12F2ivp9Mvj7JlfebFrEgNX+JVs6+IVDXRCsjRF02dYmgJswuLn/FF5j+XwDrQQ
         px0aA2Yd8yiLlA4qmllanjQu23cZmoiyG0RoXZbvXQlhepE8/KWxwptTPCMXGmIPecUX
         r2Jk6K8f89P1mMWR9Xnwk85YYtKSdSr8KptSnm0+G2oiPRwk3u8v5XJW4qQCMs6mIGLi
         mW8nzAyr2TVhHomboZhUzkolSweyQ9nSv1lKQKKwyH5XcqV6i2OYWVfYUz6pgYOUqcpp
         JNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757244; x=1692349244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SamseihHveHRCFRV/VFLPEZGl+SZA6Yk6XZ5fusUv5A=;
        b=Uu1t3cb4EJ6zEtlh5gRXjeFrXu8GLY4Tqd8pWsEpZmBm+osHLsFCMNFGXqUoj0QWsf
         hFNDRVFLciyuD022pGL587U92MgUew1JVY9o/IT+8IpWXTU/M0l019+6j32c0FEOdNiZ
         W9oQ8Q+Xl1Ra4/jFKgPVHRO5zUB4XBxSS800uvXVfs4YmwnYf06KJxm5UIeEInldG7vA
         m1cvhxeKV2QWrBvmgukbOvn7M3NGI64CO4H9zsc4znVFEaerT+MxM9Dj0ZHzQsj9K5MW
         rv8z/KN9EbKdwbuC0HLrczgyOPdX2jWuZ2ILQB7VuEePCo+Ad5t4xfwJsHtqCgeAwGVm
         aa7g==
X-Gm-Message-State: ABy/qLYHeAO/PBCjrycahuWNjr/Vsa5DMtgxSgnnTJWbFgeFw280ieZf
        S7zzlIKIO1HyFOakAZt2lv6jPa9fHXDWb/XoKu6rsg==
X-Google-Smtp-Source: APBJJlHajI9KppsTh5EhXdoDW+nqB3D4QiZ11D3kIMCJmcCRAUOfsoDPIA/7xvfcugvLcKeOSwiHcI2OT+NeGSC+Ggw=
X-Received: by 2002:a6b:730c:0:b0:786:2125:a034 with SMTP id
 e12-20020a6b730c000000b007862125a034mr1912720ioh.18.1689757243703; Wed, 19
 Jul 2023 02:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-2-glider@google.com>
 <ZLVjYzuxlJAQVpIO@yury-ThinkPad> <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
 <ZLabOHmNQm2EOXWR@smile.fi.intel.com> <ZLbF3ZO7TvJGJOeo@yury-ThinkPad>
In-Reply-To: <ZLbF3ZO7TvJGJOeo@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Jul 2023 11:00:06 +0200
Message-ID: <CAG_fn=Wk8qSx0VWjzAs5Mks_1QK6JYbc=auhjhSD7vxvyP3-yg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks to GENMASK() implementation, you'll be warned by GENMASK_INPUT_CHE=
CK()
> if nbits is a compile-time variable. In case of runtime, it's a pure unde=
f,
> not mentioning useless, expensive and dangerous fetch.
>
> > >  - we anyway need a dynamic check for the case nbits is not constant
> > > (for both bitmap_get_value() and bitmap_set_value(), I assume).
> > >
> > > What do you think?
>
> I think that instead of speculations, it's better to cover nbits =3D=3D 0
> with the explicit tests for run- and compile-time. That way you're
> always on a safe side.

You are right. I added tests for these cases.

> bitmap_get_val(NULL, 0, 0) shouldn't crash the kernel.

Haha, the compiler is smart enough to not crash the kernel in this case.
But passing zero via a volatile variable did the trick.

>
> > The idea behind is to eliminate the code completely for the cases nbits=
 !=3D 0.
> > In your case the dynamic check will be there. That's what we want to av=
oid.
>
> Alexander is right - we can't avoid testing against 0 if we need to
> test for 0... In case of other functions we have inline and outline
> implementations, controlled by small_const_nbits().
>
> As you can see, the small_const_nbits() tests against 0 explicitly,
> although it's free at compile time. But if nbits =3D=3D 0, we pick
> outline version of a function regardless.
>
> On their turn, outline versions again do their test against nbits =3D=3D =
0,
> but most of the time implicitly.
>
> In case of bitmap_set_val, we are touching at max 2 words, and there's
> no reason for outline version, so we have to test nbits against 0
> inside inline code.
>
> Having all that in mind, and because nbits =3D=3D 0 is most likely an
> error we'd follow the following rules:
>  - no memory must be touched as we're potentially in error condition,
>    and pointer may be corrupted;
>  - the cost of the check must be as minimal as possible.
>
> So I suggest:
>
>         if (unlikely(nbits =3D=3D 0))
>                 return;

Sounds good, I'll add unlikely() around the check.
Thanks for the explanation!

>
> For readers that would literally mean: we don't expect that, and we find
> it suspicious, but we'll handle that as correct as we can.
>
> By the way, Alexander, please drop that 'const' things. Those are for
> pointers or some global variables, not for inline functions with 4
> lines of code. (If you think it helps the code to be safe than no - it's
> unsafe even with consts.)

These consts are from the original Syed's patch and were probably
added for consistency with bitmap_{set,get}_value8().
But, okay, I'll remove them.




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
