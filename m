Return-Path: <linux-kernel+bounces-29529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E5830FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B1DB256E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1F22F17;
	Wed, 17 Jan 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg6XmowG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3B1E869
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532570; cv=none; b=rqWXfT9a1KUZ3zOrS24TX2stF7tTwGRXy7iMetUew0Ah9fsovuYbZjBHwYLLwstqFsPlQk9ct2ovsMYPwNdOixIezU3mSabVpwPdtH3293OsVE5oYXZVAN2Pzg84qPTFq40atvRyDagpr+BnMINRWe7khRE7WIYHY7GPdzls5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532570; c=relaxed/simple;
	bh=R6Z768pxNr5yyVGSluCeuT3pGLf2eU2IFAhfg14PA5g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=nnCPLxYkc+7uaxK0XBeM2aL/Y2ehXKRj9XzHn0p0NeGDxZR+NgVgBAiqMvWYDLt6C7jBvOxTY9sDdVJXph4JeqlwRbgDi8JxSrgC3cs808KxodQ1P+4IMKShOXkHjdETU89OUejNtp+rg3/ftWtjHWWcdNOshe8eTEYiN+P7X+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg6XmowG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337c4f0f9daso828355f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705532567; x=1706137367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVVQzIfswVI0WmMOjZbZ5Dux+OT+J5EfPrfiCiPsc9s=;
        b=Yg6XmowGYF/UCiVrVp8Q0l1ueVqZkC33fT49S121eGEs+CxsgJ8nXBLSYIzQEX+Fhd
         LpmYCeALYCYOzH+MZ+zGhy0qS6X5zFWQvhlj05/92evkLCt7THz/UpwR7KcaDezEcVLL
         f9o3fOSLY0eQjaVIB9d3BuUjJWb03AeQsQhxlWDWw318FQP4XDUjCH1UIYaBX018jgJc
         avEqn1f/Sd1C4pYnEBC9LtMCkQ7kd/RbAKHwzDEYTbkTdnr7DbOQq8SxfNKvyjX1Fvt6
         XdeHU1ey/RCXDjuXSjj+IChAU7Z4hM/5IV7O+GUw95yQLqmuOqFk97obzt91ffDAMAqN
         hAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532567; x=1706137367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVVQzIfswVI0WmMOjZbZ5Dux+OT+J5EfPrfiCiPsc9s=;
        b=Z8JhDyZ22M2OAVBUYxI3O2qtDBwopL2vL/55cWpvM92/+UPGbwZ4FSwy/D8CwS1GW2
         ZSwc+0BiXFL2/LkEjyx1XdA27CumPs3Dt1ELnFC1oNLdPJmU+yXgouug3Dqc8XVsTzGN
         6SHLbZiDB8pfiJ0ySoAeff2qSUrNDINxj4Ybuym1G5Lr6zK9+vtis6ncLvXj+BY5uKVz
         /mDLgDpALz7Kz7RLYm4hef5ou+5HnABKlCFOyJdvjBHWPTHLQ2Nrsmxxq/TJPeHkWOAC
         cv1NyHM4X3hY2PXK4/GEK5UyZLygpLu0abZBsC2UM+ooKeE29mZ2DZP+2syhK55kNgM0
         KA8Q==
X-Gm-Message-State: AOJu0YxGfBPZ5b8f7kUQBrjNdEVLNmq1TcaNveQbNN1IOh2EyZUX+0f2
	2PQRlDPa9j+bsU+8SrxHxCn4BVpqU7xfQNdFlz8=
X-Google-Smtp-Source: AGHT+IGKXhri/qncW9CJmeZeQxGwRCvCoOF9C5QFwqE6RccIiypikFPUjckqIIkg7HskriVt/1PbKzgwijKxkc/ZQZg=
X-Received: by 2002:a5d:6446:0:b0:337:bebc:3f4a with SMTP id
 d6-20020a5d6446000000b00337bebc3f4amr1662482wrw.81.1705532566755; Wed, 17 Jan
 2024 15:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115092727.888096-1-elver@google.com>
In-Reply-To: <20240115092727.888096-1-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 18 Jan 2024 00:02:35 +0100
Message-ID: <CA+fCnZfUiB67N_csOQuUMoLQ97WChaBm+FHdntmD63sL8xueyA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] stackdepot: add stats counters exported via debugfs
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 10:27=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> Add a few basic stats counters for stack depot that can be used to derive=
 if
> stack depot is working as intended. This is a snapshot of the new stats a=
fter
> booting a system with a KASAN-enabled kernel:
>
>  $ cat /sys/kernel/debug/stackdepot/stats
>  pools: 838
>  allocations: 29861
>  frees: 6561
>  in_use: 23300
>  freelist_size: 1840
>
> Generally, "pools" should be well below the max; once the system is boote=
d,
> "in_use" should remain relatively steady.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/stackdepot.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index a0be5d05c7f0..80a8ca24ccc8 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -14,6 +14,7 @@
>
>  #define pr_fmt(fmt) "stackdepot: " fmt
>
> +#include <linux/debugfs.h>
>  #include <linux/gfp.h>
>  #include <linux/jhash.h>
>  #include <linux/kernel.h>
> @@ -115,6 +116,23 @@ static bool new_pool_required =3D true;
>  /* Lock that protects the variables above. */
>  static DEFINE_RWLOCK(pool_rwlock);
>
> +/* Statistics counters for debugfs. */
> +enum depot_counter_id {
> +       DEPOT_COUNTER_ALLOCS,
> +       DEPOT_COUNTER_FREES,
> +       DEPOT_COUNTER_INUSE,
> +       DEPOT_COUNTER_FREELIST_SIZE,
> +       DEPOT_COUNTER_COUNT,
> +};
> +static long counters[DEPOT_COUNTER_COUNT];
> +static const char *const counter_names[] =3D {
> +       [DEPOT_COUNTER_ALLOCS]          =3D "allocations",
> +       [DEPOT_COUNTER_FREES]           =3D "frees",
> +       [DEPOT_COUNTER_INUSE]           =3D "in_use",
> +       [DEPOT_COUNTER_FREELIST_SIZE]   =3D "freelist_size",
> +};
> +static_assert(ARRAY_SIZE(counter_names) =3D=3D DEPOT_COUNTER_COUNT);
> +
>  static int __init disable_stack_depot(char *str)
>  {
>         return kstrtobool(str, &stack_depot_disabled);
> @@ -277,6 +295,7 @@ static void depot_init_pool(void *pool)
>                 stack->handle.extra =3D 0;
>
>                 list_add(&stack->list, &free_stacks);
> +               counters[DEPOT_COUNTER_FREELIST_SIZE]++;
>         }
>
>         /* Save reference to the pool to be used by depot_fetch_stack(). =
*/
> @@ -376,6 +395,7 @@ depot_alloc_stack(unsigned long *entries, int size, u=
32 hash, void **prealloc)
>         /* Get and unlink the first entry from the freelist. */
>         stack =3D list_first_entry(&free_stacks, struct stack_record, lis=
t);
>         list_del(&stack->list);
> +       counters[DEPOT_COUNTER_FREELIST_SIZE]--;
>
>         /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. =
*/
>         if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
> @@ -394,6 +414,8 @@ depot_alloc_stack(unsigned long *entries, int size, u=
32 hash, void **prealloc)
>          */
>         kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
>
> +       counters[DEPOT_COUNTER_ALLOCS]++;
> +       counters[DEPOT_COUNTER_INUSE]++;
>         return stack;
>  }
>
> @@ -426,6 +448,10 @@ static void depot_free_stack(struct stack_record *st=
ack)
>         lockdep_assert_held_write(&pool_rwlock);
>
>         list_add(&stack->list, &free_stacks);
> +
> +       counters[DEPOT_COUNTER_FREELIST_SIZE]++;
> +       counters[DEPOT_COUNTER_FREES]++;
> +       counters[DEPOT_COUNTER_INUSE]--;
>  }
>
>  /* Calculates the hash for a stack. */
> @@ -690,3 +716,30 @@ unsigned int stack_depot_get_extra_bits(depot_stack_=
handle_t handle)
>         return parts.extra;
>  }
>  EXPORT_SYMBOL(stack_depot_get_extra_bits);
> +
> +static int stats_show(struct seq_file *seq, void *v)
> +{
> +       /*
> +        * data race ok: These are just statistics counters, and approxim=
ate
> +        * statistics are ok for debugging.
> +        */
> +       seq_printf(seq, "pools: %d\n", data_race(pools_num));
> +       for (int i =3D 0; i < DEPOT_COUNTER_COUNT; i++)
> +               seq_printf(seq, "%s: %ld\n", counter_names[i], data_race(=
counters[i]));
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(stats);
> +
> +static int depot_debugfs_init(void)
> +{
> +       struct dentry *dir;
> +
> +       if (stack_depot_disabled)
> +               return 0;
> +
> +       dir =3D debugfs_create_dir("stackdepot", NULL);
> +       debugfs_create_file("stats", 0444, dir, NULL, &stats_fops);
> +       return 0;
> +}
> +late_initcall(depot_debugfs_init);
> --
> 2.43.0.275.g3460e3d667-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

