Return-Path: <linux-kernel+bounces-88330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F149286E018
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675D6B23DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC96CDCE;
	Fri,  1 Mar 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bentQlJr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFF6F086;
	Fri,  1 Mar 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292080; cv=none; b=CMk/WJE7aOI+KnH/Ko3rNghDMMqUevqmC0kPawWoI5UMmJe1LVFIMTDuKs2v4xaNRpanSo1lq3tpqpyi5K5Jq6qLmwbDFfLRDZNfGepCdwwxBMqjl3mXkL4i8DSYgrvd/0Go91zCaV1WFoFUWklZ0dz5OCglAMuxRS18+ZgqjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292080; c=relaxed/simple;
	bh=vA3/4HTET5hlOfgf4Er+i75H30eqdFAZ2HnhpOI4/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz1Qgpb3tTiFFq2HWJtwiwOGQsmXR4C+O4OLN88fB5buEbUheFDzqdh8pFZj4GocOjpT7Kd4/xCu9+wZZONqpeEGb847duo+tt8xMnXg7+tiAx0Mv29pi3jXjtti05HCLsFzV5Tnh+4cMvvpOZW2AWLYDtCjKWMbMV0sPnuHzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bentQlJr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso273609266b.1;
        Fri, 01 Mar 2024 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292077; x=1709896877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ082j2pJr1xgZJEiUaLG5/NIzCLBAKQRVFYYUvjL+0=;
        b=bentQlJrvE0dPKhYI+gT16K6Stuws2E3ASGPo7sgOB9H1QvqHulAS7eS6yaqzucuGc
         wjhKGFlcuoKUWPFn6F1HICHXfU4N/pd9/4QnaUqrf0o0hXodjYI+z+xeez2z12iEb6o7
         0CbkOuOuVUWjMivAZgxPTW9at3SG4UAyVA8quzkCAbv5N/tqZtMstN4plRX4UtvRTRIO
         Kbhh+OvnMGS00TRHeBkjEBofr4LZ9yU4zlA9lEwWfvUPz7zKxn7R4i5Oowv60xyTzp4a
         v9xh8kj+whdUipYczuA5WJSsgggK6t1Eg5pdcjmDa1selzRG6OF5Ann1t7ENomMlnUSN
         wI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292077; x=1709896877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ082j2pJr1xgZJEiUaLG5/NIzCLBAKQRVFYYUvjL+0=;
        b=QiuonvhVFV2JE4g7887luIKDkBdrB/Zhp50nfALYdJg0B1u/zu/4kafQNJ8W1ySeyW
         BuniXrL3Bkh7FmRfb8oKGocv3HEoClgchTVphOEdOy18r4T4F71CnA3WslPUcwRFN8hD
         qveiFKPgjxOWD1FTYdDX3vGXnpvq1G/B3Tn6UzU4bcgkFPYxAcCZIVEyQ2dLxyoCFeIt
         ekxPhcB1PF6HEBx484HNoyKhrdrvGzTbZwSfOncFdXOukXbBxv2rRNu1ZwAy/Ej7Jm+S
         oUt9hBdUYSIabEOuGjjxBzP+fTofzTYCkwwFHiiPKXoMholx9m3cWrFWCxWcxRzN82Es
         naIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJNNAF6hQnUz/1BOziLIZMt5Sk0i6F12ktQ6uxHCQE2gu3xHPiyu363wzb4p3Aqr8SXL3IxLBWPjBaewBku2N7qgytYUYF7WeGh8xRo17RO7RPNUhAMW0CDu719w9Wyn3UGodHZWOdN449Uugq
X-Gm-Message-State: AOJu0Yz9bH3gu7CLLhAVZkouAzKk1UsK/8l0XGI4JbVutxq+m4Cqcjow
	OMvmoOhVHQroWpDCOcDV1FO0NgvpldzeK6+a4hiCULkbAv4rL7r7aDbwSdEhz+DAJqOO7n7861O
	9Ao/pfzcu+VmfEi6Q3sGZ7ME93Ik=
X-Google-Smtp-Source: AGHT+IHf+UFnAy49eXiWgM1CQ2tYsMoXzCUQ9lacA0t3m/W3EkX1XWzroBij+/7xXm94vJohOSbmhtl0KGUTOIOuCMw=
X-Received: by 2002:a17:906:6817:b0:a40:189d:c5bd with SMTP id
 k23-20020a170906681700b00a40189dc5bdmr923163ejr.13.1709292077266; Fri, 01 Mar
 2024 03:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301002416.it.092-kees@kernel.org> <20240301002650.1544829-2-keescook@chromium.org>
In-Reply-To: <20240301002650.1544829-2-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Mar 2024 13:20:41 +0200
Message-ID: <CAHp75Vf+zzVyVZ=fcXgdCMsp1MZdHmJ1aBTKFE4jHai2pWi27g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] string: Convert helpers selftest to KUnit
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:26=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Convert test-string_helpers.c to KUnit so it can be easily run with
> everything else.

..

> -#include <linux/array_size.h>
>  #include <linux/init.h>
> +#include <kunit/test.h>

I know the order is broken here, but don't make it worse, please. And
stick with one schema where to put kunit/test.h always before
everything else and somewhere else (like always after linux/*).

> +#include <linux/array_size.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>

..

> +static void test_string_check_buf(struct kunit *test,
> +                                 const char *name, unsigned int flags,
> +                                 char *in, size_t p,
> +                                 char *out_real, size_t q_real,
> +                                 char *out_test, size_t q_test)
>  {
> -       if (q_real =3D=3D q_test && !memcmp(out_test, out_real, q_test))
> -               return true;
> +       int result;
> +
> +       KUNIT_EXPECT_EQ(test, q_real, q_test);

This needs a message.

> +       result =3D memcmp(out_test, out_real, q_test);

> +       KUNIT_EXPECT_EQ(test, 0, result);

Why do we need this assertion? We have a dump below to show what's wrong.

> +       if (q_real =3D=3D q_test && result =3D=3D 0)
> +               return;

I'm not sure this is an equivalent change. IIRC KUnit assertions do
not continue on failure. (Long time last time I run KUnit test)

>
>         pr_warn("Test '%s' failed: flags =3D %#x\n", name, flags);
>
> @@ -28,8 +37,6 @@ static __init bool test_string_check_buf(const char *na=
me, unsigned int flags,
>                        out_test, q_test, true);
>         print_hex_dump(KERN_WARNING, "Got: ", DUMP_PREFIX_NONE, 16, 1,
>                        out_real, q_real, true);
> -
> -       return false;
>  }

..

> +static void
> +test_string_escape_overflow(struct kunit *test,
> +                           const char *in, int p, unsigned int flags, co=
nst char *esc,
>                             int q_test, const char *name)
>  {
>         int q_real;
>
>         q_real =3D string_escape_mem(in, p, NULL, 0, flags, esc);
> -       if (q_real !=3D q_test)
> -               pr_warn("Test '%s' failed: flags =3D %#x, osz =3D 0, expe=
cted %d, got %d\n",
> -                       name, flags, q_test, q_real);
> +       KUNIT_EXPECT_EQ(test, q_real, q_test);

You killed the message, not good.

>  }

..

> +#define test_string_get_size_one(size, blk_size, exp_result10, exp_resul=
t2)      \
> +       do {                                                             =
        \
> +               BUILD_BUG_ON(sizeof(exp_result10) >=3D string_get_size_ma=
xbuf);    \
> +               BUILD_BUG_ON(sizeof(exp_result2) >=3D string_get_size_max=
buf);     \

No analogous assertions in KUnit?

> +               __test_string_get_size(test, (size), (blk_size), (exp_res=
ult10), \
> +                                      (exp_result2));                   =
        \
>         } while (0)

..

>  {
> -       if (!memcmp(res, exp, strlen(exp) + 1))
> +       int result =3D memcmp(res, exp, strlen(exp) + 1);

> +       KUNIT_EXPECT_EQ(test, 0, result);

As per above, what's the added value of this assertion?

> +       if (!result)
>                 return;

..

> @@ -590,65 +604,68 @@ static void __init test_string_upper_lower(void)
>         for (i =3D 0; i < ARRAY_SIZE(strings_upper); i++) {
>                 const char *s =3D strings_upper[i].in;
>                 int len =3D strlen(strings_upper[i].in) + 1;
> +               int result;
>
>                 dst =3D kmalloc(len, GFP_KERNEL);
> -               if (!dst)
> -                       return;
> +               KUNIT_ASSERT_NOT_NULL(test, dst);
>
>                 string_upper(dst, s);
> -               if (memcmp(dst, strings_upper[i].out, len)) {
> +               result =3D memcmp(dst, strings_upper[i].out, len);
> +               KUNIT_EXPECT_EQ(test, 0, result);

Ditto.

> +               if (result)
>                         pr_warn("Test 'string_upper' failed : expected %s=
, got %s!\n",
>                                 strings_upper[i].out, dst);
> -                       kfree(dst);
> -                       return;
> -               }
>                 kfree(dst);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(strings_lower); i++) {
>                 const char *s =3D strings_lower[i].in;
>                 int len =3D strlen(strings_lower[i].in) + 1;
> +               int result;
>
>                 dst =3D kmalloc(len, GFP_KERNEL);
> -               if (!dst)
> -                       return;
> +               KUNIT_ASSERT_NOT_NULL(test, dst);
>
>                 string_lower(dst, s);
> -               if (memcmp(dst, strings_lower[i].out, len)) {
> +               result =3D memcmp(dst, strings_lower[i].out, len);
> +               KUNIT_EXPECT_EQ(test, 0, result);

Ditto.

> +               if (result)
>                         pr_warn("Test 'string_lower failed : : expected %=
s, got %s!\n",
>                                 strings_lower[i].out, dst);
> -                       kfree(dst);
> -                       return;
> -               }
>                 kfree(dst);
>         }
>  }


--=20
With Best Regards,
Andy Shevchenko

