Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E07A0F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjINUla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjINUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:41:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0432120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:41:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so23435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694724082; x=1695328882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAwsTmQ+ELNb0oAFR4fBQd1wUmizG7i6iQSI6zVD64o=;
        b=GQMC9NylM7Jke0NBxQNZUFUxktVW53igNbkF+Ky6UuIQ5jmHLi/MkkTmKJT8eKloSq
         0m2N1nQm0aaJTOE0cv5Ob8M1N8QEPHgUfU2DIOym6qLpkrLPaplLUeGFLGWKuBto534u
         u162zKpRPuXQwEvLFSGn1DBuTDkSJjdU4GQpFIlHb4J7MgTPC0EW91QtPrjFe3slw3of
         Unxfciuc9Ptd6L/NSdwz+Diz/CSOvG5uqD9VAEhuNWYxyjblI0u7OXUHcdA6OLuKi5Sl
         I8g8cKKNrNepJfc/I5OpgsIUHJMeVN1Z/ek5Z0b1kupaeMZA8KFVQUjyOPOaU1eDXnnl
         +Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724082; x=1695328882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAwsTmQ+ELNb0oAFR4fBQd1wUmizG7i6iQSI6zVD64o=;
        b=OsHi/3jWkQkHTNct4KPZXUG+iMz0Wt4yFpprs0pC+rv/HQLvLtoTGMx3iRLL5xuJ07
         KiBpkSgGU2MZV9SSzU4pyMNMyMCnZRx9FCcOukVbYzH/er/vSuHWwsrF7vlXleAh81ey
         kV/tWK/imiT1movBEJsKDmn4LW87e2nan1su0gPnYMRsHv47q6HgEgu8vD93u9j72TfO
         YOhTDiPuqXX/2ziJZMRgl58xzwLu3bB8s1Coe9CiPkxfEviSK2fiJuAs+1D9eBk1JHC6
         uUnfjlEyaZy4B1Udk0zEngM9zqDfXbYrwGs+GQe8iH8Y/GetYzMz4Y6nAmY2LSBc2mbb
         XE0w==
X-Gm-Message-State: AOJu0Yw7AAe5+XiLXFJ2V8Y+tmLcBOYsxRVXUoe3Ms2Hyyqz/yYWh8YQ
        cL5hkQnEu+DPakG8fVsu4ILZB38BS/rxdMck/wL7Rw==
X-Google-Smtp-Source: AGHT+IHsHkVsQuKN291JYs5H+1PLqW9iIMxkotXRW4DbVVL1elJDo88rYPVS0anHPmaVmfAA+Q/VHLHfVqUdniinZt8=
X-Received: by 2002:a05:600c:1e05:b0:3fe:dd72:13ae with SMTP id
 ay5-20020a05600c1e0500b003fedd7213aemr45137wmb.0.1694724082359; Thu, 14 Sep
 2023 13:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230914080833.50026-1-haibo.li@mediatek.com> <20230914112915.81f55863c0450195b4ed604a@linux-foundation.org>
 <CA+fCnZemM-jJxX+=2W162NJkUC6aZXNJiVLa-=ia=L3CmE8ZTQ@mail.gmail.com>
In-Reply-To: <CA+fCnZemM-jJxX+=2W162NJkUC6aZXNJiVLa-=ia=L3CmE8ZTQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Sep 2023 22:40:43 +0200
Message-ID: <CAG48ez0aenPmr=d35UGa4_BiCwYU1-JHhD_2ygThvjOEXEM7bQ@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org,
        xiaoming.yu@mediatek.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:35=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
> On Thu, Sep 14, 2023 at 8:29=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> > > --- a/mm/kasan/kasan.h
> > > +++ b/mm/kasan/kasan.h
> > > @@ -304,8 +304,17 @@ static __always_inline bool addr_has_metadata(co=
nst void *addr)
> > >  #ifdef __HAVE_ARCH_SHADOW_MAP
> > >       return (kasan_mem_to_shadow((void *)addr) !=3D NULL);
> > >  #else
> > > -     return (kasan_reset_tag(addr) >=3D
> > > -             kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> > > +     u8 *shadow, shadow_val;
> > > +
> > > +     if (kasan_reset_tag(addr) <
> > > +             kasan_shadow_to_mem((void *)KASAN_SHADOW_START))
> > > +             return false;
> > > +     /* use read with nofault to check whether the shadow is accessi=
ble */
> > > +     shadow =3D kasan_mem_to_shadow((void *)addr);
> > > +     __get_kernel_nofault(&shadow_val, shadow, u8, fault);
> > > +     return true;
> > > +fault:
> > > +     return false;
> > >  #endif
> > >  }
> >
> > Are we able to identify a Fixes: target for this?
> > 9d7b7dd946924de43021f57a8bee122ff0744d93 ("kasan: split out
> > print_report from __kasan_report") altered the code but I expect the
> > bug was present before that commit.
> >
> > Seems this bug has been there for over a year.  Can you suggest why it
> > has been discovered after such a lengthy time?
>
> Accessing unmapped memory with KASAN always led to a crash when
> checking shadow memory. This was reported/discussed before. To improve
> crash reporting for this case, Jann added kasan_non_canonical_hook and
> Mark integrated it into arm64. But AFAIU, for some reason, it stopped
> working.
>
> Instead of this patch, we need to figure out why
> kasan_non_canonical_hook stopped working and fix it.
>
> This approach taken by this patch won't work for shadow checks added
> by compiler instrumentation. It only covers explicitly checked
> accesses, such as via memcpy, etc.

FWIW, AFAICS kasan_non_canonical_hook() currently only does anything
under CONFIG_KASAN_INLINE; I think the idea when I added that was that
it assumes that when KASAN checks an access in out-of-line
instrumentation or a slowpath, it will do the required checks to avoid
this kind of fault?
