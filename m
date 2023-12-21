Return-Path: <linux-kernel+bounces-9031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C810A81BF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CC5B24864
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159ED74087;
	Thu, 21 Dec 2023 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IewbGzjc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2DE6EB7D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-203ae9903a6so719308fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189277; x=1703794077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utqNK2Z5ebr5Ah9is9CZfM+/3gvjCU4Z0H/FEO7/fZM=;
        b=IewbGzjcrcEfRLswxcZBbtsCm901klEClFCHlEl9pi5TZTG9p043elx66D313jg37+
         gQDRYPDjbPyJBAyteDfUa0+OfJww2mrbVT5QsXZ3+t7ynVwlYslDSoKIoKZXAMFZvoc1
         fGmNzbG8sCH5/6/ijNx4S7ic9MphJzUlhNuCw6a3kXn5muG4B1zRcyjrQ5c8FtIO/sa3
         NnEdjxHe7ju1FCtQyKOEWvVI2V7H8DTC4YKPphD4/Sv9/tmaBl471VjLsDlj97FyjYpw
         ylL066KoCjrG6cKYysPgNSxMXpbtSqI0I2vdCZyz06z03foGkIi/ERvCzCnMSuXrg+sE
         6DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189277; x=1703794077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utqNK2Z5ebr5Ah9is9CZfM+/3gvjCU4Z0H/FEO7/fZM=;
        b=I4TpiipqFRGP7z4vNfhn7oTbVmoEw3/wdiwISqhPAIU2bOy/WqKGMNiWv07g3X4F2Y
         +4g73jGgXNiyQj6o5WSvHOSngrTtGwRS/XC2u7jIFqk3nU0bOGvdM2YYZ5jMKjsIxWQ1
         XS2n+ZprZxr3IKk9l/wvwRVhbpsaENk50YOhni+15kqgwkHihoh/wHlAi/FOCMN6pmuD
         PgR9I6lfTl3pFKx+pzpvkmC1l9Zq+g4DuvqVYqkPVp5MRLenx7UoLgzdREchvAH/yv8h
         vRvsFFebok0RLmrOGGI1x2wtIg+MpfDv8dtJ34S3jGoYoYuXaVRcI20o0J8SethRBOZx
         khQQ==
X-Gm-Message-State: AOJu0Yz/SH6TSm6w3eodIpCtfvVkZIXYdjbXx9Mnjo83ZCm7582IbNsb
	4wWzx1c3CaZMQuVbcLw8pffGa4QBR9UPlgWOjTtyYLK/g99o
X-Google-Smtp-Source: AGHT+IGpMLVUaZzsKBY0xBIQjvSt9huCNWw3hwHRpN3+6T2gMLLFvYaByZqI8RdgR888zFFk3Fjw5FTebhgaEGINsKU=
X-Received: by 2002:a05:6870:a192:b0:203:7cb2:35 with SMTP id
 a18-20020a056870a19200b002037cb20035mr406025oaf.60.1703189276982; Thu, 21 Dec
 2023 12:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221180042.104694-1-andrey.konovalov@linux.dev>
In-Reply-To: <20231221180042.104694-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:07:20 +0100
Message-ID: <CANpmjNPkZQEp-jCVvbmcPBh2x=Q9jvBNtr0fPMoR+--_Oo4MCA@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: Mark unpoison_slab_object() as static
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kasan-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 19:00, <andrey.konovalov@linux.dev> wrote:
>
> From: Nathan Chancellor <nathan@kernel.org>
>
> With -Wmissing-prototypes enabled, there is a warning that
> unpoison_slab_object() has no prototype, breaking the build with
> CONFIG_WERROR=y:
>
>   mm/kasan/common.c:271:6: error: no previous prototype for 'unpoison_slab_object' [-Werror=missing-prototypes]
>     271 | void unpoison_slab_object(struct kmem_cache *cache, void *object, gfp_t flags,
>         |      ^~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>
> Mark the function as static, as it is not used outside of this
> translation unit, clearing up the warning.
>
> Fixes: 3f38c3c5bc40 ("kasan: save alloc stack traces for mempool")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> Changes v1->v2:
> - Mark as "static inline" instead of just "static".
> ---
>  mm/kasan/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ebb1b23d6480..f4255e807b74 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -277,8 +277,8 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
>         /* The object will be poisoned by kasan_poison_pages(). */
>  }
>
> -void unpoison_slab_object(struct kmem_cache *cache, void *object, gfp_t flags,
> -                         bool init)
> +static inline void unpoison_slab_object(struct kmem_cache *cache, void *object,
> +                                       gfp_t flags, bool init)
>  {
>         /*
>          * Unpoison the whole object. For kmalloc() allocations,
> --
> 2.25.1
>

