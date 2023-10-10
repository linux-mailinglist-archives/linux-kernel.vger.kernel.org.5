Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917EE7BF578
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442712AbjJJIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbjJJIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:17:10 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9087A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:17:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b0e623189so30245056d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696925828; x=1697530628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ91x7U3rirUbkyYioXuLdImi+LNXots2Inn4nnzz1I=;
        b=xkkOduAEopymSa0l3aRiFtcS9GGR57GfY+5TGgNuiun2g9q5Md2sVwnJ+lbvOokQzb
         +2wKAaaC4Kkg8Tty8nrZkb1pDY+9/k6EjnKpzCE2dapnW3iWvkVGqgdh2XyKp/OM6MkA
         JdKX3FwP9hHkvWHaeErNrOeib8uOyL1uS4qe3+BxhF/077I1vMHlfSogNR8B0XiHJV5H
         HIPF6Z5hz9zhi1Gc2SbJ4ugrlTxLQ3zCdZiBIp5sZtTLHLKw1StMXahjBpKBig9dtFoZ
         yqCLShsG1b06km2FvdjOQU3oz1utXmhOyAAyq9J02vqJBzTdejTa7NUfOfF3co1ubvAh
         Tmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925828; x=1697530628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ91x7U3rirUbkyYioXuLdImi+LNXots2Inn4nnzz1I=;
        b=rTV8Ekt4OqCZ1tnsbgIgx0PEg1nzOZ8L2YBRhK/EyZx3Yy47S+4udHzru/2ZQmqMBG
         0kmk2xxXy6PaN/LuqQJopB8GmGV/CLlG+/oNi8rz5LyrJaJwJW4bY0LDRvWI9gT84cNt
         LP4Tzv5X5keJ9dB2x7tT0I65UWUypj9Oev1MO7KrGvv56XNMx+zPSdo7kbYqrupkrHcQ
         m2THgR91liVgUgomHDPlKYVPx1zpa/4yC3fc+kfjFjoCRaXsDm2JBJJY3YYX6HL8DM4C
         uxqoO2MCBQhQjwCo4VUvERDsgPhlHPlSbL61IpAiUQJnsWcaEtlvREiL+WlnzNWEUoeF
         4hSQ==
X-Gm-Message-State: AOJu0Yw/yy+pGiPp+IHnZWvd77Aa7rPGaQ1FEGBAayuANnqWbr5PqLgk
        upMq/7ZHLw+hU6ZJy2NV6RiXHXbBuXG0HznmR9JhgQ==
X-Google-Smtp-Source: AGHT+IFK6ESdIQlWQSS3hsV5F+BhTOfGzqFxe4qKC6bCYg5DvF/0qYBHmU6gSy2VorcRViwOR63GjqkmqBXv18ZQL4g=
X-Received: by 2002:a05:6214:3a03:b0:658:2037:718b with SMTP id
 nw3-20020a0562143a0300b006582037718bmr19876973qvb.51.1696925827788; Tue, 10
 Oct 2023 01:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231006134529.2816540-1-glider@google.com> <20231006134529.2816540-2-glider@google.com>
 <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com>
In-Reply-To: <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Oct 2023 10:16:26 +0200
Message-ID: <CAG_fn=UxSUEcj9wWexakd-F0-Dh+WjeKEaqwMKfD8AEOnkRTsQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 4:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 06, 2023 at 03:45:25PM +0200, Alexander Potapenko wrote:
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> >
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro=
"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
>
> ...
>
> > v6:
> >  - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
> >    return 0.
>
> Hmm... See below.
>
> ...
>
> >   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to=
 u32[] dst
> >   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to=
 u64[] dst
>
> With the grouping as below I would add a blank line here. But was the int=
ention
> to group _arrXX() to these groups?

Note that there's no single blank line in this long list.
What if I swap bitmap_read with bitmap_set_value8(), would the
grouping become more logical?

I.e.
*  bitmap_get_value8(map, start)               Get 8bit value from map at s=
tart
*  bitmap_set_value8(map, value, start)        Set 8bit value to map at sta=
rt
*  bitmap_read(map, start, nbits)              Read an nbits-sized value fr=
om
*                                              map at start
*  bitmap_write(map, value, start, nbits)      Write an nbits-sized value t=
o
*                                              map at start

> > +     if (unlikely(!nbits))
> > +             return 0;
>
> Hmm... I didn't get was the comment to add or to remove these checks?

As Yury said, we should not require the return value to be 0, so I
added "nonzero" to the descriptions of the @nbits parameter.
The check stays in place, but the users relying on it is now a mistake.

>
> > +     if (space >=3D nbits)
> > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
>
> And don't you want to replace this GENMASK() as well?

See my next reply to Yury, tl;dr this is a stale code version :(
