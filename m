Return-Path: <linux-kernel+bounces-40970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A683E91F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FB5B265DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E375947A;
	Sat, 27 Jan 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W15xlWoR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD915944D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320260; cv=none; b=XL5o7bFTmFR5eBnhfp097+kIUqoGnZ0mP39sQ/x6uDBAqceMwnGNxjUYGol473seFO16gdCKdQK4/Oi1gWk3HIdcRNqPG71/v4G6m0Cv06MO4yfBUpWT/eQVETAoR0pVS0YRwhuJS5HoXmcUyA1c59O+MjE9na09C0SnFgexdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320260; c=relaxed/simple;
	bh=BnnJeZ4BTM80PQPwIVpnYMr36VU4wyw4EydrHn9OuFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFUufOL3Vr17vRDiHGTxGNRRWgpm7hE1IgFXz+jor/Gy4aBHBcNQHRb8eR8W+MkwYzjzHVNrr+lNZUtN5N3pbukuKLqIfJgwOW9ah/2TJi/4pUu/QlS3EU89tvs5IIcnB/hwcIkSKa0cQ5S8h9t9EyXJJKJc0OBcPcXGk/qsNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W15xlWoR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33924df7245so1305058f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706320257; x=1706925057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3KL7omzR2YR5H0m3wzbipCveRvJiJv/pASMUWh3gAY=;
        b=W15xlWoRS25VMrTYcKTxfF8U200qnP01XW8oqzqxN6wsuWLpqQ9qo5oFesf4SLkkMR
         QuSjrGsVJd2n/7fMqkiAviwJdznxbK/vGQ+bgJjIYS6quwDeD+GVZ1+aYtAXlpLZp85k
         /r5vlt+Ry+cobdg0hUmTJV/PrpeBlD11DnQHysH3NuHBouUMCYD16Kv1DqYfPjBnTTj+
         wszeoUNTNMM2BuHLEQrd/E381glJwAAyETwk5HWVl409bVjR/iNau9/UQojPjR/s9udL
         d4sBOBHPywCl4X+s251+R394BHLkNEkeJfG4Oj3mPsDW3XJ1b29GHGov9zj2TCeO/G83
         4gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320257; x=1706925057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3KL7omzR2YR5H0m3wzbipCveRvJiJv/pASMUWh3gAY=;
        b=r61JIvROHJoKDslhFisWMnBFuXJLuVtpClirp6rISM430altM/fw+jyk66PWa7fdSe
         256JgP1+QhqQ7MbPex1lDzDIBe1BnEu3zrVIX0/4HPn0eTqn65X2tDwcL2wx8IlwpaC+
         9T6TC90WnQTiPzHO4+U0W8frR5nOQhgd8EiUfP6PuuULtZkFUw8YpSQA2MAIZ9te6Kx1
         bcS2dKp0H/gepCcUXIVZh9It9G3hyYL8TBYPfOf9AfN/NVoVH8XQq7t+xaHPqA6ekaEu
         dJ5LoLS/reups4E0DftiYgDK2TD9/ouhOwupWULAV1d15KS9xwT2MIN/rFn+FYpcIUUh
         BZXg==
X-Gm-Message-State: AOJu0YxNEqR0RzX+RdHVnfnMpDPleZwCfrMrJz5dvo//O1pStQPwkBLz
	hrA6uEfp9+Os1dNnDvQ9Bre/T93jV+JRpbqiIGCVOhk86oR/gE/dLHWVr9tK1UB6i9OaB6CHd5Y
	cLjLDqkq9bSUfMz0cU7xRkq7LEpA=
X-Google-Smtp-Source: AGHT+IF6EA1uHHXa9SQzgottx81xTzWh22Lm6Qzcn2k1JqhAXulDIjCqtrzFoKMaNwIXTXd1psxtsOcvSmftc4z3UtQ=
X-Received: by 2002:adf:e34e:0:b0:337:a81a:a92 with SMTP id
 n14-20020adfe34e000000b00337a81a0a92mr381731wrj.16.1706320256834; Fri, 26 Jan
 2024 17:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125094815.2041933-1-elver@google.com> <CA+fCnZfzpPvg3UXKfxhe8n-tT2Pqhfysy_HdrMb6MxaEtnJ2BQ@mail.gmail.com>
 <ZbO8yD_ofPQ1Z2NT@elver.google.com>
In-Reply-To: <ZbO8yD_ofPQ1Z2NT@elver.google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 27 Jan 2024 02:50:46 +0100
Message-ID: <CA+fCnZeD_UpKw+hMUY3rkTAkPqYvhFe85HP8LSZOHrv1DyQ-Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] stackdepot: use variable size records for
 non-evictable entries
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:08=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, Jan 25, 2024 at 11:35PM +0100, Andrey Konovalov wrote:
> [...]
> > I wonder if we should separate the stat counters for
> > evictable/non-evictable cases. For non-evictable, we could count the
> > amount of consumed memory.
> [...]
> >
> > We can also now drop the special case for DEPOT_POOLS_CAP for KMSAN.
> >
> > Otherwise, looks good to me.
> >
> > Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Thank you for cleaning this up!
>
> Thanks - probably will add this change for v2:
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 1b0d948a053c..8f3b2c84ec2d 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -44,17 +44,7 @@
>  #define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_A=
LIGN)
>  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
>                                STACK_DEPOT_EXTRA_BITS)
> -#if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >=3D 32
> -/*
> - * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of=
 stack
> - * traces. As KMSAN does not support evicting stack traces from the stac=
k
> - * depot, the stack depot capacity might be reached quickly with large s=
tack
> - * records. Adjust the maximum number of stack depot pools for this case=
.
> - */
> -#define DEPOT_POOLS_CAP (8192 * (CONFIG_STACKDEPOT_MAX_FRAMES / 16))
> -#else
>  #define DEPOT_POOLS_CAP 8192
> -#endif
>  #define DEPOT_MAX_POOLS \
>         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
>          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> @@ -128,18 +118,22 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
>
>  /* Statistics counters for debugfs. */
>  enum depot_counter_id {
> -       DEPOT_COUNTER_ALLOCS,
> -       DEPOT_COUNTER_FREES,
> -       DEPOT_COUNTER_INUSE,
> +       DEPOT_COUNTER_REFD_ALLOCS,
> +       DEPOT_COUNTER_REFD_FREES,
> +       DEPOT_COUNTER_REFD_INUSE,
>         DEPOT_COUNTER_FREELIST_SIZE,
> +       DEPOT_COUNTER_PERSIST_COUNT,
> +       DEPOT_COUNTER_PERSIST_BYTES,
>         DEPOT_COUNTER_COUNT,
>  };
>  static long counters[DEPOT_COUNTER_COUNT];
>  static const char *const counter_names[] =3D {
> -       [DEPOT_COUNTER_ALLOCS]          =3D "allocations",
> -       [DEPOT_COUNTER_FREES]           =3D "frees",
> -       [DEPOT_COUNTER_INUSE]           =3D "in_use",
> +       [DEPOT_COUNTER_REFD_ALLOCS]     =3D "refcounted_allocations",
> +       [DEPOT_COUNTER_REFD_FREES]      =3D "refcounted_frees",
> +       [DEPOT_COUNTER_REFD_INUSE]      =3D "refcounted_in_use",
>         [DEPOT_COUNTER_FREELIST_SIZE]   =3D "freelist_size",
> +       [DEPOT_COUNTER_PERSIST_COUNT]   =3D "persistent_count",
> +       [DEPOT_COUNTER_PERSIST_BYTES]   =3D "persistent_bytes",
>  };
>  static_assert(ARRAY_SIZE(counter_names) =3D=3D DEPOT_COUNTER_COUNT);
>
> @@ -388,7 +382,7 @@ static struct stack_record *depot_pop_free_pool(void =
**prealloc, size_t size)
>         return stack;
>  }
>
> -/* Try to find next free usable entry. */
> +/* Try to find next free usable entry from the freelist. */
>  static struct stack_record *depot_pop_free(void)
>  {
>         struct stack_record *stack;
> @@ -466,9 +460,13 @@ depot_alloc_stack(unsigned long *entries, int nr_ent=
ries, u32 hash, depot_flags_
>
>         if (flags & STACK_DEPOT_FLAG_GET) {
>                 refcount_set(&stack->count, 1);
> +               counters[DEPOT_COUNTER_REFD_ALLOCS]++;
> +               counters[DEPOT_COUNTER_REFD_INUSE]++;
>         } else {
>                 /* Warn on attempts to switch to refcounting this entry. =
*/
>                 refcount_set(&stack->count, REFCOUNT_SATURATED);
> +               counters[DEPOT_COUNTER_PERSIST_COUNT]++;
> +               counters[DEPOT_COUNTER_PERSIST_BYTES] +=3D record_size;
>         }
>
>         /*
> @@ -477,8 +475,6 @@ depot_alloc_stack(unsigned long *entries, int nr_entr=
ies, u32 hash, depot_flags_
>          */
>         kmsan_unpoison_memory(stack, record_size);
>
> -       counters[DEPOT_COUNTER_ALLOCS]++;
> -       counters[DEPOT_COUNTER_INUSE]++;
>         return stack;
>  }
>
> @@ -546,8 +542,8 @@ static void depot_free_stack(struct stack_record *sta=
ck)
>         list_add_tail(&stack->free_list, &free_stacks);
>
>         counters[DEPOT_COUNTER_FREELIST_SIZE]++;
> -       counters[DEPOT_COUNTER_FREES]++;
> -       counters[DEPOT_COUNTER_INUSE]--;
> +       counters[DEPOT_COUNTER_REFD_FREES]++;
> +       counters[DEPOT_COUNTER_REFD_INUSE]--;
>
>         printk_deferred_exit();
>         raw_spin_unlock_irqrestore(&pool_lock, flags);

Looks good to me, thanks!

