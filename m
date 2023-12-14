Return-Path: <linux-kernel+bounces-126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F6813C91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08E51C21C25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1400697B1;
	Thu, 14 Dec 2023 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKzMtX3W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2F282E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b0a9876c8so702655a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702589145; x=1703193945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxuQnaXteQq89l339+5l0KY/hocadQszL6EzwA8eJ60=;
        b=OKzMtX3W/YoGLHlIHBNbKgxf8Onn9/EGjlrpSuc4wzexLDMZIZUxQCCShPMDxmOrOJ
         YR9gtcxJPpWRk7DvgmDfBIB+OVtYbR6v215q5Kg6LcgaruLL23mZ7hAYF+LKLuP2IKPW
         PnC/vDO7rRnV8iTioUfjhQxReOs67z+2ptgRWyhTh9EVYSO/CeXY9N/AjVkuzLTB0m84
         5YUn2x+kmQDuzwS+cJdcqonVXTH4cGVSjOXJCK5QhI3F6rTApC9t9JCUBAs02QXXs2fC
         /HIW0deDE9vq0YQ30zAagArL1pWWpMloZMbO4RwUPQ/i8lBEEPxSV7aGTKOcYxiamtS0
         vnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589145; x=1703193945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxuQnaXteQq89l339+5l0KY/hocadQszL6EzwA8eJ60=;
        b=NxIIPPMs9nORQr6zizlwQgRJmWhpRloz0JBWB1KFHYW3uQhrOWY6q5+BbExhszUEJ3
         WbSQYQT7R9jLln/0a9Sg1IgIGEAN2b5AZtoxvxKafWxfRPj+jwgFpHlHWAT+N3U7Zddh
         uuh6pF1miYM1QEzGPGKsL7mLoBuMX5WpL3VzmfXlEBsshOBrytL7e7tsPZfNZFJtO2Jd
         FIndXlnVs/d+IahwCx1Potm+fXjTuqCLilRbsckA7epfCLcl0MdeELb6QzyfMVAydbLY
         1czEtnp0y4bGEceKApRVONBAAG4Bba+jKAOVEc4C5O/MjlXRmXKWVvelCO6zOLHskxeH
         cVYw==
X-Gm-Message-State: AOJu0YwmuK1Io3RisTYCtxkujpM+StVyYu1lOHsK+1dSJZ8tFHpwrNb+
	Dp1clPVjINjETLPl6XWWN4kTDIX/VPjnIFRwTwQ=
X-Google-Smtp-Source: AGHT+IEz6Oc0qDl/FTiX5clWOZpBKNwxvLdeqOc87+NcfBi6p2Uq2y1i5kjm8lRQfMFKdMbBBNc++a/Sf5PMbwHOQt8=
X-Received: by 2002:a17:90a:4942:b0:286:bf89:5db7 with SMTP id
 c60-20020a17090a494200b00286bf895db7mr5229758pjh.39.1702589145408; Thu, 14
 Dec 2023 13:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214164423.6202-1-npache@redhat.com>
In-Reply-To: <20231214164423.6202-1-npache@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 14 Dec 2023 22:25:34 +0100
Message-ID: <CA+fCnZcwS+8CKQEQGsNHU0zzkAVMBy7yiP=2wSuXMa2REzniKg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, akpm@linux-foundation.org, 
	vincenzo.frascino@arm.com, dvyukov@google.com, glider@google.com, 
	ryabinin.a.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:44=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
> FORTIFY_SOURCE") the kernel is panicing in kmalloc_oob_memset_*.
>
> This is due to the `ptr` not being hidden from the optimizer which would
> disable the runtime fortify string checker.
>
> kernel BUG at lib/string_helpers.c:1048!
> Call Trace:
> [<00000000272502e2>] fortify_panic+0x2a/0x30
> ([<00000000272502de>] fortify_panic+0x26/0x30)
> [<001bffff817045c4>] kmalloc_oob_memset_2+0x22c/0x230 [kasan_test]
>
> Hide the `ptr` variable from the optimizer to fix the kernel panic.
> Also define a memset_size variable and hide that as well. This cleans up
> the code and follows the same convention as other tests.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/kasan/kasan_test.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 8281eb42464b..34515a106ca5 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -493,14 +493,17 @@ static void kmalloc_oob_memset_2(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t memset_size =3D 2;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
> +       OPTIMIZER_HIDE_VAR(memset_size);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, memset_si=
ze));
>         kfree(ptr);
>  }
>
> @@ -508,14 +511,17 @@ static void kmalloc_oob_memset_4(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t memset_size =3D 4;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
> +       OPTIMIZER_HIDE_VAR(memset_size);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, memset_si=
ze));
>         kfree(ptr);
>  }
>
> @@ -523,14 +529,17 @@ static void kmalloc_oob_memset_8(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t memset_size =3D 8;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
> +       OPTIMIZER_HIDE_VAR(memset_size);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, memset_si=
ze));
>         kfree(ptr);
>  }
>
> @@ -538,14 +547,17 @@ static void kmalloc_oob_memset_16(struct kunit *tes=
t)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t memset_size =3D 16;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
> +       OPTIMIZER_HIDE_VAR(memset_size);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, memset_s=
ize));
>         kfree(ptr);
>  }
>
> --
> 2.43.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

