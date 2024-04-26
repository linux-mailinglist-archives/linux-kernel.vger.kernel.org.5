Return-Path: <linux-kernel+bounces-159771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB738B33C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218041F22BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473413DB90;
	Fri, 26 Apr 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6+f6lgr"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BD282EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123233; cv=none; b=CpX4Lw2DRCsReVnKsxEzHdIf6JJ+HXA6G/2smnKh7ngc7m9S1dj4pH6I+MP4kBqoDdrMbTs7Mcw9N8RrSdQE/G5RYfG+kzWnkKNUkkZCKa3YG+9mN08Jzkff4I8+mpKa1bUZZTarvCHKw9S1EPADeGxq/FQy3EPYVFzrDlpyIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123233; c=relaxed/simple;
	bh=UXH7vkMVz9Qr8wjk2cH7wap4outoAOPM4GoB7kdUvV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEd2rUkkYNY7gqCik6gAJdjUJWAUrItHwd80tCMlDr2qV2n5jTQEhygFq+HnszSC6iiFKXAcbHfOGHW634CJPlj5SIeRdMujOQuEEagmLEP68pKJCqckP8a06Xy/12W3Va3xAOE78RePqGzAibtc9Pc8lC0QYqntTwh7nUZ3boY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6+f6lgr; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-234f5e54446so894401fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714123230; x=1714728030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEGoLxUkWwDTn+Odyi6lg3eK/cudTzIim330VH70exg=;
        b=K6+f6lgraaQQnOb/BxI1PJPXCJpn09OoBWIPOmQSbxjEIk91UAl8mSfB0CKokRvP0h
         7NAnPYNB8GW2W93V8xckklwJkL1J9UvoAdu3MBs5utG3BVTTnWo3t+KCzL40o6eqy5zz
         RyLgNV+FkxZFPwR1ZxfG74iDPzk2G1R/oDW7qtcpRvaQsFh8ar/g2BqJnr6wkY8LysVt
         APD7yMmKsvv+H6UUrqUWevOh5i5E4q1AZT1CFQ7xUNFOWpGD0xFJlmer62fQjVuiewrP
         nSALXT5aKvXLzYdKqCu/P4nE0Mfjw6HqJEwUS1u69VyMUAnw3AsV2sBpjyORuuGX1+pN
         o4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123230; x=1714728030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEGoLxUkWwDTn+Odyi6lg3eK/cudTzIim330VH70exg=;
        b=ByczgBdTYKgwXgGFYYZiSj/xOZbcHOquZxQwWzS47PufhMlgo+P6YZfCRYCPfDYQVc
         Pe5l7M9ME9CUl7Bf8t1c8KYMyaY1o/5aIoH9tz8bRf5ayMnV0pL979XK8rMYA65xyUue
         ilLeAItVLPqHnrilW3t5HbVM2BfGTcAFG9qieZQpSCoceoutTvERd8umFAbAot6K9ycN
         zoSJizeP9jfWIRxX0OoGbtTrcuG39DE0Z7nL56Bt6x87KTTGD5JmhLLczrq8gW6mh67z
         tEG+D/I5yHhkHImexRdJWwC4urQ9BFy2CLvuxWNgEUvch67Kihdj2ohN294goRuGQE0H
         teQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnloGO7L5uqpBXOHee9HBxAw92ihqefGvJ3/8q7sDQDYCIgVGThE8fWQFmnC7owwqrXF4XcDRj9BC2KYDsWZibUJwRn5XiIUVp5XUw
X-Gm-Message-State: AOJu0YwEArGNpvWHz56BnMfO/SeUS56kHfEe+0C9nSqVzJuM+JftDGx+
	obAVws7c1yqsVxwlwDk7gwkt/9dnPyu3QSME6Slx3zhGcCZRPdaTNzBCbQ1K4B4+WogeuV3efEt
	CSwCKZAabOR8CHQuMUMsBTv9E+s0=
X-Google-Smtp-Source: AGHT+IGKkWnDPhZbKeVeOePz1PtuqYkJhmTMbe1AbOipYv5BGs5ZkYUUkdQ91bVvtP5fnG6ltjsHXuBfuDGhrdoCiLY=
X-Received: by 2002:a05:6870:8a0f:b0:235:3e77:49b4 with SMTP id
 p15-20020a0568708a0f00b002353e7749b4mr2567306oaq.0.1714123230026; Fri, 26 Apr
 2024 02:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zij_fGjRS_rK-65r@archlinux>
In-Reply-To: <Zij_fGjRS_rK-65r@archlinux>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Fri, 26 Apr 2024 17:20:03 +0800
Message-ID: <CAEVVKH8Oagbih8E8YNPpNhyh75fWnBLdod+eEGQm9i8ciNv7sQ@mail.gmail.com>
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:48=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@clip-os.org> wrote:
>
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
> separately") splits single and bulk object freeing in two functions
> slab_free() and slab_free_bulk() which leads slab_free() to call
> slab_free_hook() directly instead of slab_free_freelist_hook().
>
> If `init_on_free` is set, slab_free_hook() zeroes the object.
> Afterward, if `slub_debug=3DF` and `CONFIG_SLAB_FREELIST_HARDENED` are
> set, the do_slab_free() slowpath executes freelist consistency
> checks and try to decode a zeroed freepointer which leads to a
> "Freepointer corrupt" detection in check_object().
>
> Object's freepointer thus needs to be properly set using
> set_freepointer() after init_on_free.
>
> To reproduce, set `slub_debug=3DFU init_on_free=3D1 log_level=3D7` on the
> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=3Dy`.
>
> dmesg sample log:
> [   10.708715] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Free=
pointer corrupt
> [   10.712695] ----------------------------------------------------------=
-------------------
> [   10.712695]
> [   10.712695] Slab 0xffffd8bdc400d580 objects=3D32 used=3D4 fp=3D0xffff9=
d9a80356f80 flags=3D0x200000000000a00(workingset|slab|node=3D0|zone=3D2)
> [   10.716698] Object 0xffff9d9a80356600 @offset=3D1536 fp=3D0x7ee4f480ce=
0ecd7c

If init_on_free is set,  slab_free_hook() zeros the object first, then
do_slab_free() calls
set_freepointer() to set the fp value, so there are 8 bytes non-zero
at the moment?
Hence, the issue is not related to init_on_free?

The fp=3D0x7ee4f480ce0ecd7c here is beyond kernel memory space, is the issu=
e from
CONFIG_SLAB_FREELIST_HARDENED enabled?

Thanks,
Xiongwei

> [   10.716698]
> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                    =
                  ....
> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not fr=
eed
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  mm/slub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 3aa12b9b323d9..71dbff9ad8f17 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>                unsigned long addr)
>  {
> +       bool init =3D false;
> +
>         memcg_slab_free_hook(s, slab, &object, 1);
> +       init =3D slab_want_init_on_free(s);
>
> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> +       if (likely(slab_free_hook(s, object, init))) {
> +               if (init)
> +                       set_freepointer(s, object, NULL);
>                 do_slab_free(s, slab, object, object, 1, addr);
> +       }
>  }
>
>  static __fastpath_inline
> --
> 2.44.0
>
>

