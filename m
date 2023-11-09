Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BB7E6C79
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKIOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:34:09 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EBD2D78
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:34:06 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7bae0c07086so427951241.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699540446; x=1700145246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1pa0v/X7UL1G6d0YgW+ZV2uzr9bDeP0CswrdUk62h0=;
        b=OoEy1H0GENwUpNrwm1yFuQZclJk89mzjyjM8y0Z0RWzQncfUpCKBy2pGrIaHwXGg9h
         3Fw4M7u7AoijDQpdvqfQd+mb2zvB9GlMu0lGsKIPaO0f7nFsWFS/WaXKo1l/vxuUBZ39
         aIYhSlG2hP7DL/LBRldK8JTgxMdhrKhZTCDra7Y8xOIvuwP0zGN7ZN0x82O0yp4wYtPU
         Mk5x+sN1D6ixEgWJCE0wUoxSv8L77ZtANyXi2AZJU1j4PWjw/BhJy5+1KODa+MaD2y1R
         fwvPuhTkDms7Wh0nYB7Kk8K+zBmRdeN2Qx/tADsNDZ4TpwpDlZsbxsS7Hb7LEIZuu5FP
         CU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540446; x=1700145246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1pa0v/X7UL1G6d0YgW+ZV2uzr9bDeP0CswrdUk62h0=;
        b=UrdqEzWAKUbgcheUnjlNm3dzyEq4HmzsrwBrG+2sT34f5dfWRJIvrlcDHsL1zmqPpu
         Qo6b5Vjz1qKHw4VPftJYXl8CfVt0tdaqR7/1osWyw0JzPpmRUbXHSQ2M0pzFbdCkEVWt
         jgWJmayRvpL1afeUczXQDotro/90PbryB9tcK2QTMHW46iK6KOtsThgnBixsnDQIEQkg
         m968WWzpBemlFQ/c7pF7KPyJ8cfdB6e0IjeGQ3LUqNDJjwycFWtJENjVYQ2/SlyyJXrL
         VyxqDCxaebe0kM9gMA3AvNPpLOCVCvZYgYN2PcZSf6LK2EI7iIjmMesfcF5vaxlyRoSi
         NpjA==
X-Gm-Message-State: AOJu0YwcnkVFE6j+FBS0TefUv9e21q9E0Eu/yflgfD272ES6MdxSeDw2
        xmEnFKusjbjWwV7QkCJRYHZ1YVLAvQ/SmuBRr7bpcw==
X-Google-Smtp-Source: AGHT+IF6/SKb9tnG09SVJDC2YZw83HQI5NrFow5lKduMeIis/nLu15+6OXST1tbD5YFM40N7jd6Q4wzjCwruYdW5sh8=
X-Received: by 2002:a67:c314:0:b0:45e:3e66:56ee with SMTP id
 r20-20020a67c314000000b0045e3e6656eemr4761621vsj.17.1699540445802; Thu, 09
 Nov 2023 06:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20231030153210.139512-1-glider@google.com> <20231030153210.139512-2-glider@google.com>
 <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com> <CAG_fn=W3LqtdDoUDDVGn_=2+gvKNeCusH6yUzWmVmMmOLZp9jA@mail.gmail.com>
 <27f5d15b-28da-469b-9625-1c840f33b60d@intel.com>
In-Reply-To: <27f5d15b-28da-469b-9625-1c840f33b60d@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Nov 2023 15:33:25 +0100
Message-ID: <CAG_fn=V2v41qFK8LRGX4j3-+is-pODu_FHVU0K5tsDVWoWopfw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 3:32=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
> Date: Thu, 9 Nov 2023 15:28:56 +0100
>
> >>
> >> Could we maybe rather extend __check_eq_uint to take ulongs? Doesn't
> >> seem like they differ a lot.
> >
> > We could redefine expect_eq_uint as:
> >
> > #define expect_eq_uint(x, y)           expect_eq_ulong((unsigned
> > int)(x), (unsigned int)(y))
>
> Do we need explicit casts here tho?
>
> >
> > and throw __expect_eq_uint away.
> >
> >
> >>> +     }
> >>> +     time =3D ktime_get() - time;
> >>> +     pr_err("Time spent in %s:\t%llu\n", __func__, time);
> >>
> >> pr_err() is for printing errors and is shown in red by some log reader=
s.
> >> Maybe use pr_info() or pr_notice()? Definitely not an error or even wa=
rning.
> >
> > Note that test_bitmap.c has 17 calls of pr_err() and 7 calls of
> > pr_warn(), which aren't really consistent (e.g. they are used in
> > certain __check helpers instead of pr_err()), and the existing
> > performance tests are calling pr_err().
>
> Correct, and that's what caught my attention: visual grepping for bitmap
> messages makes no sense because some of them are red even thought all
> tests pass correctly.
>
> > I can change that in a separate patch, if you think it's worth the
> > effort: the error messages should probably remain pr_err(), but the
> > informational ones could be made pr_info().
>
> Sounds good to be, would be nice to see!
>
> [...]
>
> >>> @@ -1237,6 +1411,9 @@ static void __init selftest(void)
> >>>       test_bitmap_cut();
> >>>       test_bitmap_print_buf();
> >>>       test_bitmap_const_eval();
> >>> +     test_bitmap_read_write();
> >>> +     test_bitmap_read_perf();
> >>> +     test_bitmap_write_perf();
> >>>
> >>>       test_find_nth_bit();
> >>>       test_for_each_set_bit();
> >>
> >> Thanks,
> >> Olek
> >
> >
> >
> > --
> > Alexander Potapenko
> > Software Engineer
> >
> > Google Germany GmbH
> > Erika-Mann-Stra=C3=9Fe, 33
> > 80636 M=C3=BCnchen
> >
> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > Registergericht und -nummer: Hamburg, HRB 86891
> > Sitz der Gesellschaft: Hamburg
>
> Thanks,
> Olek



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
