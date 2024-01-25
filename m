Return-Path: <linux-kernel+bounces-39367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E783CF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D811C21876
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600E1426C;
	Thu, 25 Jan 2024 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbz0wiCT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE717BBD;
	Thu, 25 Jan 2024 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222145; cv=none; b=KLZ9lM9mV9vlGeOzb3yBi/Fl5jGnsmM8T7Q58mKL5Gkf47GTHMTYhj3YzwK3ZyvFbzSUHsVfWfo3ddDq61ZxgFGSmZKxPiL4RoLiIxX7Qp/gyWhSEwCoimmjYqe7X9Te0Vm8N9EaG4/2wBFZH2ya8XT5hVLrMzRgaq/HzAbyD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222145; c=relaxed/simple;
	bh=ex8mhBFlVK+qlM04iw6etLe9+Jq4rqLuEQofIRhu8RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2Rgbqefy3snkCC2ySC6ovN7w6igYOyFuok9KftvSpI7QyBE01YI3jeyc5qfuMtEbILazUmN3rSJQaq3d2DiwsSuDICVuKN9Brf30wKvPxv9R3aynW3103kOzP48nhpjdJ1uVkJEpivTR9HkWVmUqrG4v2EdiFBlrCrKvJHGts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbz0wiCT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33922b66bd7so4953008f8f.2;
        Thu, 25 Jan 2024 14:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222142; x=1706826942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMyr1t75aVIHFmn0P1+tdWxst8vu4zQ4wyJGjRe6tPg=;
        b=Tbz0wiCTlqTU6V8V4e1pfdbmDodkUOW4z3HndnO6Celr9Hmn9XactWH9z3dvvf4dCg
         toeJnLOcP+EL+XfvoRRnxupWGxBYmBtysbHANeJBupbs7bOw+XxaGsiuRQ2p3641e0f7
         EAf1pCWvM2JmA4AeD5wDmMg2umz3/jZLS9Yif9DQAzw6X0VwmD7Sa55efvuQmIG2p6e+
         TGdxH+t9kQ7RhNeS7BHiW9uonOEjF5bi3uCVCTbHtWz9oFrzR3on5bCo46ClkIBGcyeS
         CeqKpKLfplxTdAYWhEdmq/oEVXv20W9k0jTuDNEgtVqfTKJEGi0vOx7uHFmF7Mg8vbco
         PVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222142; x=1706826942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMyr1t75aVIHFmn0P1+tdWxst8vu4zQ4wyJGjRe6tPg=;
        b=rOiWVVH1tv6AY/Fm3OxeTeZV6e8VuEV3QBAiOLaj1SZpVXqe8cAR+qov0q1CWMNKWo
         5TyeB//mkdOpR4eZN+t40YpdqTlH1ZYRWbf0+dHUIEqJRjOFMxT5GjsNzkuib/aEm0+S
         m1IwEMrM/MWxnC4K+QdVBtfIgcz3CItDkAndKgZy1kbFC2bG00Q9j1fQUFkyjX4PBDx/
         5lHEHl05v+zYA/UWmEcblrwz3AP72Jgab7Ck6BRuAY7kWo+zb6qQOS4qgWLoahO3CyIP
         AluD1NNVfe7snhHCC1b/cAwXDYWcn9RIIHmL9PDiZSzEV9DNPOW1VKhfjlbwY6k4HEUH
         RQMg==
X-Gm-Message-State: AOJu0YxnlCcPVcG6nVjKxaUei7+z5LQLVduclrYT9Vtu9TEBmPgu4cBJ
	u7mwo/qfJakvj54rCQzBro+wd8hyw9SVo3+n7jTJoOTKz4uWpgWsxuQgMeTX2lVztXtXZ316vP0
	yepthWeqvqwhvaYRpy06L63i1nY0=
X-Google-Smtp-Source: AGHT+IGhVj/6x7OyXp2FMLV7vv0nMhRTznm1M7um663p1SrHbtCiDFQuWt+g/3+DqsAxqMIiV+hSSlsuJcbPhCj6d6U=
X-Received: by 2002:adf:e350:0:b0:339:2b28:32dc with SMTP id
 n16-20020adfe350000000b003392b2832dcmr314421wrj.53.1706222141699; Thu, 25 Jan
 2024 14:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-55-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-55-keescook@chromium.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 25 Jan 2024 23:35:30 +0100
Message-ID: <CA+fCnZdiLCDTcOmc7x_eHV9oNQhNq_sU1_w+rafoBA1FVEbwrA@mail.gmail.com>
Subject: Re: [PATCH 55/82] kasan: Refactor intentional wrap-around test
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:29=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow()=
.
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/kasan/generic.c | 2 +-
>  mm/kasan/sw_tags.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index df6627f62402..f9bc29ae09bd 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -171,7 +171,7 @@ static __always_inline bool check_region_inline(const=
 void *addr,
>         if (unlikely(size =3D=3D 0))
>                 return true;
>
> -       if (unlikely(addr + size < addr))
> +       if (unlikely(add_would_overflow(addr, size)))
>                 return !kasan_report(addr, size, write, ret_ip);
>
>         if (unlikely(!addr_has_metadata(addr)))
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 220b5d4c6876..79a3bbd66c32 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -80,7 +80,7 @@ bool kasan_check_range(const void *addr, size_t size, b=
ool write,
>         if (unlikely(size =3D=3D 0))
>                 return true;
>
> -       if (unlikely(addr + size < addr))
> +       if (unlikely(add_would_overflow(addr, size)))
>                 return !kasan_report(addr, size, write, ret_ip);
>
>         tag =3D get_tag((const void *)addr);
> --
> 2.34.1
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

