Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D57E6C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKIO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:29:41 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BC184
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:29:38 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a82f176860so11037797b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699540178; x=1700144978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+ysJxXCGkzYAyNTjirW6IMPasF92mdcvanVUcbxAss=;
        b=SbyaKCr8UjaB6OCswnoRhhnXBfrggrI57IocImEMgDILONxzT5S6l50PS//kJFBckr
         88tCzqAyoA6+q46CoT35vvS/x9ApIAq6TYnWdeWo+sKKBanVnK5oJi7r6NHqnBYwBPlj
         LrZG6PySzmZoOVP2gkAP4lkeB2NcPzucLxprAXCk5bXgHVzOJTQWzJ+9e7eIcoicXG4K
         LAbOWA62LCI0MGpfUiETSGECVTHbdmiT/xnHZhm0JZcRqTrk5Zvh8Fk+tBm7xWKRXIUb
         9DMjA7AGz5BkSPG92Djex2GwQxyenbtmOWWbQihCiyqAMiPoWZbCPnk/1s6ZU2p86R2T
         7tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540178; x=1700144978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+ysJxXCGkzYAyNTjirW6IMPasF92mdcvanVUcbxAss=;
        b=OfdLmC0RwI6mGd/lTPdOUUZ9RAxEhVN4jsaH6HVY2Gj2SMYfwr2UL2dhi1oZjIqbGi
         +d4Yhry9dwjhSA+YyD9UAMe0YK6L0pxFUNRqyvhfllvanYaFsBhvkH47ig1kc0HQaBjx
         neEvUbHB2OMTB435ytnHPWP4nvN5RLU8u+EvNMiJz6jlqIRA/YesAYzvYvs2HAh/mlBh
         ZqGWuxlsZP0KLu+I88jDtoc2Ejo/cYh5OrobwIu3RVIGmZjVSVmYzGwcCCxs/f+V/EOZ
         EwpT+bgmc1xBfB5Ff31Sm+UqkrETSDxXlZKW6n05S1SgK3aBaR9uuKi2u/C/l+9udjwZ
         up3A==
X-Gm-Message-State: AOJu0YxuSxvQqf/ClSkAPs2ZCEoHRsjVkz8snU4/UhT7Tp6oBI+jyQZT
        hK5/DXlcTholXliCk5rTt/oeAoP3jVJHNW/zo9gaAw==
X-Google-Smtp-Source: AGHT+IHl5tYyTHcqIOqg6H0DhbNAV+DpwblE0+FOnbjYkd8O5/V9yKGeyyC0yoIwjPabZPYsyXHA5x+Mi1QW8U46siQ=
X-Received: by 2002:a0d:cb55:0:b0:5a7:c8a9:79e8 with SMTP id
 n82-20020a0dcb55000000b005a7c8a979e8mr5323660ywd.4.1699540177733; Thu, 09 Nov
 2023 06:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20231030153210.139512-1-glider@google.com> <20231030153210.139512-2-glider@google.com>
 <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com>
In-Reply-To: <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Nov 2023 15:28:56 +0100
Message-ID: <CAG_fn=W3LqtdDoUDDVGn_=2+gvKNeCusH6yUzWmVmMmOLZp9jA@mail.gmail.com>
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

>
> Could we maybe rather extend __check_eq_uint to take ulongs? Doesn't
> seem like they differ a lot.

We could redefine expect_eq_uint as:

#define expect_eq_uint(x, y)           expect_eq_ulong((unsigned
int)(x), (unsigned int)(y))

and throw __expect_eq_uint away.


> > +     }
> > +     time =3D ktime_get() - time;
> > +     pr_err("Time spent in %s:\t%llu\n", __func__, time);
>
> pr_err() is for printing errors and is shown in red by some log readers.
> Maybe use pr_info() or pr_notice()? Definitely not an error or even warni=
ng.

Note that test_bitmap.c has 17 calls of pr_err() and 7 calls of
pr_warn(), which aren't really consistent (e.g. they are used in
certain __check helpers instead of pr_err()), and the existing
performance tests are calling pr_err().
I can change that in a separate patch, if you think it's worth the
effort: the error messages should probably remain pr_err(), but the
informational ones could be made pr_info().


>
> > +}
> > +
> > +static void __init test_bitmap_write_perf(void)
> > +{
> > +     DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> > +     unsigned int cnt, nbits, i;
> > +     unsigned long val =3D 0xfeedface;
> > +     ktime_t time;
> > +
> > +     bitmap_zero(bitmap, TEST_BIT_LEN);
> > +     time =3D ktime_get();
> > +     for (cnt =3D 0; cnt < 5; cnt++) {
> > +             for (nbits =3D 1; nbits <=3D BITS_PER_LONG; nbits++) {
> > +                     for (i =3D 0; i < TEST_BIT_LEN; i++) {
> > +                             if (i + nbits > TEST_BIT_LEN)
> > +                                     break;
> > +                             bitmap_write(bitmap, val, i, nbits);
> > +                     }
> > +             }
> > +     }
> > +     time =3D ktime_get() - time;
> > +     pr_err("Time spent in %s:\t%llu\n", __func__, time);
>
> (same)
>
> > +}
> > +
> > +#undef TEST_BIT_LEN
> > +
> >  static void __init selftest(void)
> >  {
> >       test_zero_clear();
> > @@ -1237,6 +1411,9 @@ static void __init selftest(void)
> >       test_bitmap_cut();
> >       test_bitmap_print_buf();
> >       test_bitmap_const_eval();
> > +     test_bitmap_read_write();
> > +     test_bitmap_read_perf();
> > +     test_bitmap_write_perf();
> >
> >       test_find_nth_bit();
> >       test_for_each_set_bit();
>
> Thanks,
> Olek



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
