Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543D97EAE89
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKNLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:01:33 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DBD1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:01:30 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9dc928868so1378562241.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699959689; x=1700564489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWHrJu1S5UhWNIqA9ni22z01xZVMyORc9pLCUHXauxA=;
        b=y+UcYb7CU6iGWZAsr6Wpt6RsDk8WEgebGlZSI0mdK1quLpENet0GPyBmjIwG+jJLXs
         WGOvGRzjaM9FPMgTvldVYkEYaGKZR95YgfuhJCv+xPzbfv6NvxD7CVI+78qTwVfj88j6
         AQwPgEzdL8HQrJIP/UXcZZyOOnFQT+jHdv+33jifwjUvfeFyde2fgffUjnxffgKl8voo
         Kt8PQG6EIlh7bwlDq2UpnByRk11KmCsTSpwavtdjsY0xCiGsv9ffVnaOOd5ZhdiOWy3Q
         vF0YZJ2KK4vMNKg7Sc3mrSjW3Gffxvs9reuwphuvcVNBLqzmQdUvSg2Ky6MjloQtZZ7J
         r6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699959689; x=1700564489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWHrJu1S5UhWNIqA9ni22z01xZVMyORc9pLCUHXauxA=;
        b=Ha/UZ9mD6vY0Dnq2BuDuBZt/RtrtYJm16ea33ck52Qu2rPh88ftl9TUdOcWyBwEPBu
         uiCmdRBNA+x9XF4zpqQz5R7r28AubrMuWEeWXIyQIMC6c4a6YiABjbLcXGpDY9XBPRI0
         pnXe5jgD7R7P3tGkTjFVZHRHc+O9zub9aiEE/3c9U3JNLWFUTgdW8u9wm4BwbN91/tQc
         9n9IRvYqBj+oQabZqx7zOqY0EAnW6ksQHb5FOSRUgg6B+FO8kttOYTgLbRrA4LaQco4N
         yj5yPE8qygFPvup4IFCKrH6q6s5J0kxBJnDHQfglBJILGceh5xhy8TeoLnnv6hEkStIJ
         IVDg==
X-Gm-Message-State: AOJu0YysvEb8NrVEeKeXNPBlh88Y8kWwAUmkNh1XxEJ+CWMALK4Uh0aC
        W3HjkKacACdptDsymrHL4wQR7v/RiOjfsQdpD02cZQ==
X-Google-Smtp-Source: AGHT+IEYrAG/c7kfNif6Scjc4apETM96fyJTnRaPSX+XoQRXBME+CTIsDSOkE8a95byZlHI9aP9lBFQQgm7cnGxizP4=
X-Received: by 2002:a67:c283:0:b0:458:6173:8d4 with SMTP id
 k3-20020a67c283000000b00458617308d4mr4973730vsj.20.1699959688830; Tue, 14 Nov
 2023 03:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20231109155101.186028-1-paul.heidekrueger@tum.de> <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
In-Reply-To: <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Nov 2023 12:00:49 +0100
Message-ID: <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Thu, 9 Nov 2023 at 22:08, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 4:51=E2=80=AFPM Paul Heidekr=C3=BCger
> <paul.heidekrueger@tum.de> wrote:
> >
> > KASan inline instrumentation can yield up to a 2x performance gain at
> > the cost of a larger binary.
> >
> > Make inline instrumentation the default, as suggested in the bug report
> > below.
> >
> > When an architecture does not support inline instrumentation, it should
> > set ARCH_DISABLE_KASAN_INLINE, as done by PowerPC, for instance.
> >
> > CC: Dmitry Vyukov <dvyukov@google.com>
> > Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D203495
> > Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>
> > ---
> >  lib/Kconfig.kasan | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index fdca89c05745..935eda08b1e1 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -134,7 +134,7 @@ endchoice
> >  choice
> >         prompt "Instrumentation type"
> >         depends on KASAN_GENERIC || KASAN_SW_TAGS
> > -       default KASAN_OUTLINE
> > +       default KASAN_INLINE if !ARCH_DISABLE_KASAN_INLINE
> >
> >  config KASAN_OUTLINE
> >         bool "Outline instrumentation"
> > --
> > 2.40.1
> >
>
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Thank you for taking care of this!

Reviewed-by: Marco Elver <elver@google.com>

+Cc Andrew (get_maintainers.pl doesn't add Andrew automatically for
KASAN sources in lib/)

Thanks,
-- Marco
