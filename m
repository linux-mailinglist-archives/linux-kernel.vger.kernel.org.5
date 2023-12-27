Return-Path: <linux-kernel+bounces-12278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E681F23F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816661F23018
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4147F68;
	Wed, 27 Dec 2023 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnIXgEgZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0B481AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336990fb8fbso3810917f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703713372; x=1704318172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDLD4+/i2vMq1fQYbzWj7QeJ4PZ6TaAuPhlpaYobBH0=;
        b=bnIXgEgZQ7rYP/WBTdqaSqtEn8o4o/Xq1JZE+94+edsOwyKdYru4u6fdbw5aEXwjDn
         GxaYGxmDaQ6HWUY01t/Yl277WTxEVCCpXJDUJrbfqOi59o/nL4QJu9gR9w1hT77ejHN8
         bhJuv6XUBp5aNQcOPa9P1OscAZM3ZAPm3SfHFoB2/TUsCvYmmOEwLLY1V13Ad8y2MPJz
         LAXjxwRN5hp+14uhT2S28K1y3bXwlNC5kXnXFN6gMYYCEaEnxs9hyprdSeWrHFpRuZmP
         g1JHXPznDxIenwVPCXeHnQLoCKChcS+bG0GoS+QhK1TQSY73rQmr5+U1frEmNt6DJHje
         mWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703713372; x=1704318172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDLD4+/i2vMq1fQYbzWj7QeJ4PZ6TaAuPhlpaYobBH0=;
        b=L6ZDrECBCDokrh2BBVUh7yi0KODZQlvQwiB/+p1vg0RoSIq8HJFv7uQOGCT49KrKb7
         oa9cq5j2q+HWObYT20T3HVQ1LCKTrx75FxQHToyqZ6ffGBeNSYob28lfKntBVJb96y39
         mDjTHMaDI9FR0RmBaEBLdgmtWqtKDmO5LcwYl9P2tmW01sRc5NwNUiqgCjs5dQnY5R41
         6JGCTSuTZnZ97jfMe03exMe5GLrpbBULDmh7E96Dy924SH/CKz5xhT0UVUmOc/5daRq2
         n78csEvEWXJUypg2gRpVocZ9N9qeQA8fjTmqrx/O/ptaU/EQIjrtPx+TtWfS3W7dehZz
         r1Tw==
X-Gm-Message-State: AOJu0YwTqViq7IzOzFOevaKoEca/Ohq7rvmyI9HRbhTjNHGGm9k+0Azk
	VIGttU/r9WFkocLDrQOxelI1yi7A1BL2ag3RUtw=
X-Google-Smtp-Source: AGHT+IGgAO7AFAZan3TC+1/9LKYfUXC+HyHtjJ/qCR7SSlhOKpX4cDm/waGRD608xGQ/bf1FuGvPMzJSEc/Y1XJQO9A=
X-Received: by 2002:a5d:598c:0:b0:336:e8da:e17f with SMTP id
 n12-20020a5d598c000000b00336e8dae17fmr1859975wri.113.1703713371579; Wed, 27
 Dec 2023 13:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226225121.235865-1-andrey.konovalov@linux.dev>
 <202312280213.6j147JJb-lkp@intel.com> <20231227132311.557c302e92bdc9ffb88b42d5@linux-foundation.org>
In-Reply-To: <20231227132311.557c302e92bdc9ffb88b42d5@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 27 Dec 2023 22:42:40 +0100
Message-ID: <CA+fCnZfZMhkqOvsvavJ-YTddY4kniP+sWFZRYy+nd3+8_C9hPA@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: stop leaking stack trace handles
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, andrey.konovalov@linux.dev, 
	Marco Elver <elver@google.com>, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 10:23=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Thanks, I added this fix:
>
> --- a/mm/kasan/generic.c~kasan-stop-leaking-stack-trace-handles-fix
> +++ a/mm/kasan/generic.c
> @@ -503,7 +503,7 @@ void kasan_init_object_meta(struct kmem_
>          */
>  }
>
> -void release_alloc_meta(struct kasan_alloc_meta *meta)
> +static void release_alloc_meta(struct kasan_alloc_meta *meta)
>  {
>         /* Evict the stack traces from stack depot. */
>         stack_depot_put(meta->alloc_track.stack);
> @@ -514,7 +514,7 @@ void release_alloc_meta(struct kasan_all
>         __memset(meta, 0, sizeof(*meta));
>  }
>
> -void release_free_meta(const void *object, struct kasan_free_meta *meta)
> +static void release_free_meta(const void *object, struct kasan_free_meta=
 *meta)
>  {
>         /* Check if free meta is valid. */
>         if (*(u8 *)kasan_mem_to_shadow(object) !=3D KASAN_SLAB_FREE_META)
> _
>

Could you mark them as "static inline" even?

I'll fix this if I end up sending v2.

Thank you, Andrew!

