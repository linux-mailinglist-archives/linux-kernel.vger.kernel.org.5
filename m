Return-Path: <linux-kernel+bounces-21481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F9829002
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6441F251FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA13DB90;
	Tue,  9 Jan 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S26wdiHr"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23723B789
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b7480a80ceso2547340e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704839800; x=1705444600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wkqH0kvhJZgtpeoRvV3BZL+94wcGjMIJhbLOpqO3e68=;
        b=S26wdiHr3gll1lQYzMZvgU6aOqfge4fxGoo3F1c86bHV6q0zdJhLUrzgGvPtPacEcp
         db4wks8x8jyA8WLtRugTf/xpTGC/5GoJWJtKnib7NVrjEMOoOAirxaLX39Hd/ydUsKLI
         Yfp2pldFb1oyXMG621s0PxNtBc6vijdnJB3+uJxai+SAmvQxemGfHNq0wrLLqiUZqVHN
         nWZAfpSpoGs4wQNhDC37+ZqJ7RIBKJWIm7hNK6P5ysz4X03vlrc/FMBMW/nutWRls4RH
         ViSWbp5gHnpJBvkUQDSFF+uuFAXRoKbBVfE6krWJ/f4nZlzH8Lfiu36wy/CdR5HZbfen
         sZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839800; x=1705444600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkqH0kvhJZgtpeoRvV3BZL+94wcGjMIJhbLOpqO3e68=;
        b=CuH4gABplGojSyMDpgZcaaAbB+cKyVwalU2mlPEA1jWrmePSiLRuE0mX2ZOMTO1vzu
         NQfOQQCyTvP+SPC/RIfNpQXIDYBq225t9lT9HJvvtS/wY+waBUf6jtHZVie724CzENHH
         WwqNzfZ/R3SF+rISHZBhW8UapEfZMPy9arODmE4YwwjXaWpnMvNjajJXFUnwCKxVOfDD
         Nfx3UubppBYRtzqkmLcmqwn/OyomTUYh4oum60db7SkmLk02xIIHRHy7DHfY8egXMVHf
         eIsQ7UVTGDyBHvMjDoVejMxxlMuW/u6jVwXa0LVbQ+y3AbRtYGjpPsI6CPhpsJdd8XDR
         3sbA==
X-Gm-Message-State: AOJu0YwYpFOeTIfSr73cFQNAAwmYLKHNWpdfSg0R6pdJlZ0ZorRhZ3u9
	vXPZqsSejZQme8k/mch0EUrv2QiJa2imfEGqK6st2ZNQ4CVz
X-Google-Smtp-Source: AGHT+IFECzmkLvfxrqZ0QdatYe2GventwvLCaluPFt7FZ6mP5qF51G87ZKLIGTpMNa6ivHh0xrvU2idK4W63ISnwyYg=
X-Received: by 2002:a05:6122:2a0e:b0:4b2:c554:ccfe with SMTP id
 fw14-20020a0561222a0e00b004b2c554ccfemr156571vkb.10.1704839800511; Tue, 09
 Jan 2024 14:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109221234.90929-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240109221234.90929-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Jan 2024 23:36:01 +0100
Message-ID: <CANpmjNMvixmGviZ+NTXdnBXxDxotXbjQ1Q9uB3kERX8rXN+Wkw@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: avoid resetting aux_lock
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 23:12, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> With commit 63b85ac56a64 ("kasan: stop leaking stack trace handles"),
> KASAN zeroes out alloc meta when an object is freed. The zeroed out data
> purposefully includes alloc and auxiliary stack traces but also
> accidentally includes aux_lock.
>
> As aux_lock is only initialized for each object slot during slab
> creation, when the freed slot is reallocated, saving auxiliary stack
> traces for the new object leads to lockdep reports when taking the
> zeroed out aux_lock.
>
> Arguably, we could reinitialize aux_lock when the object is reallocated,
> but a simpler solution is to avoid zeroing out aux_lock when an object
> gets freed.
>
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/linux-next/5cc0f83c-e1d6-45c5-be89-9b86746fe731@paulmck-laptop/
> Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/generic.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 24c13dfb1e94..df6627f62402 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -487,6 +487,7 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
>
>                 /*
> +                * Prepare the lock for saving auxiliary stack traces.
>                  * Temporarily disable KASAN bug reporting to allow instrumented
>                  * raw_spin_lock_init to access aux_lock, which resides inside
>                  * of a redzone.
> @@ -510,8 +511,13 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
>         stack_depot_put(meta->aux_stack[0]);
>         stack_depot_put(meta->aux_stack[1]);
>
> -       /* Zero out alloc meta to mark it as invalid. */
> -       __memset(meta, 0, sizeof(*meta));
> +       /*
> +        * Zero out alloc meta to mark it as invalid but keep aux_lock
> +        * initialized to avoid having to reinitialize it when another object
> +        * is allocated in the same slot.
> +        */
> +       __memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
> +       __memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
>  }
>
>  static void release_free_meta(const void *object, struct kasan_free_meta *meta)
> --
> 2.25.1
>

