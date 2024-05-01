Return-Path: <linux-kernel+bounces-165514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B841E8B8D72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B381C216D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E612FB1E;
	Wed,  1 May 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaUaKNVz"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02524F898
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578298; cv=none; b=UQLRX/C/OP4efdsOrnvDualZqsXPEmJCc5DseLCl1SfUVRklIrXUDAmNUZK+FRCTFhwzFoWCBsCDNq812Yum9S2j6mIlRu0j9r8NIjy7JerxgTARA46x9mpIHI/T6na5rBbWjrIEKyXZEpCHSUN8Zv9n907x9HVBvyp5sKSxQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578298; c=relaxed/simple;
	bh=c2OtfQ7pBTZN6pP1Xp5PeLOplqCKSfOMbAjaFDsmFlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLIL23QdVG6Yiy/A+Cdm9J06tJZjKhbVxRrCgruRi7gPi6+VGJberv1SVTqHRJBQ+XmLEKJ8V0QpTABJzysKvOz8IMaktwCyYx5B6FFvkf9LznKjM9dxKhBZKVqnwchnSPAa2hu7K15SO1E6fEzMl9Hs9vFSVlOKbu/qMnbhGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaUaKNVz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f103d9f64so66304985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714578295; x=1715183095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC8US8zol/yb8tjvLb5M0Qn8qmdzxZDnXFO7sbqgY2U=;
        b=PaUaKNVzhRszkFNWPyrrGSuNbkifLa9GfrD45u6Kvi2mlamh2qrEBcjNr4NkUUQSfw
         dxRkq656pAz6oTdtFJHITXtWelsEtQ+c5udyxLdq8y3lhlfnmFZXLMW17wRCQMCtfgW5
         Mk5tzdPY/D/YnH57NefDDZVOau5XdZPIb1Mjv9eZOiv+V7JyrdT6nYhrHa5tmnVfaVoa
         uUrHfCHiO8Q/gijV3UxsD/+Jac10hTjF4n2unF4ZU7QWJ6GL8IzhEGGZ0xKWuQW4zVwp
         vxByRB0Yzzjt10+o8HacFk01AIO3cV7JeVyoF6hK4C/UcRXzLKmvD8h5YhigkktLCeJD
         w46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578295; x=1715183095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC8US8zol/yb8tjvLb5M0Qn8qmdzxZDnXFO7sbqgY2U=;
        b=A1Kev2oD9qddHz4TwLN0D01FzJx1yf9nXsxEFPphnyG4c2S2voZOFNW7X16XYnMUNw
         agdvJj1Lwv0+BQSQD0pEdxQxmw3hpgL8kNY1Xn34ug7Hlb0qzV8EB2So/zPWHI4os/Tg
         ovmpDlXkhTzpo7hjGTe6xQB6Ggv1gRJMhHZTLWAMj5zB/qjNyujdWdtu5b6DnpIxeKEW
         BU9RRMLGqYs3Ldh10pw/TUJASbnG2JKRCQZp5nCtAjhs/SrUslzLuRqRJdtEhKnIFtuk
         a5uYZQ+QRV14WZJ2U4SDmrlXvL0a12dbV4asB0ukZhhlJouKWziQbV/u4QfSuNCKfzSh
         cFMg==
X-Forwarded-Encrypted: i=1; AJvYcCU1JyAdl0q5p4Lpgt2UMDlBIHJRwv7hBU1kKhE5NMsLToUdZjQkVoKxZgavilw2QzntYJGPQfSRV0PT0zPjEHbygYMqvgMbFWB3kwRR
X-Gm-Message-State: AOJu0Yz4F/rZn/rQ3DHYXz3zK6X8NRC2RLPR4T4v5Ya4EyzKLvBT8eMz
	2yL5KI3PAcPiLssteZp1JKazCK3f4vFaLjbo43I1000DnQZ3JWGTdOK8Us+AQ6Zf6+yoikuL3xG
	Yx4jti5pj/1TfRWfIKY2N+ujSFUw=
X-Google-Smtp-Source: AGHT+IF3EGxuWVKHuHy3OXH0g4H/nbl1Vs9oLcMOr/2/LCZSd8+Ytw/9AuCX0u+xvshJ/BU4ulSodFpuLP+7OMzfH4E=
X-Received: by 2002:a05:6214:5651:b0:6a0:f637:667 with SMTP id
 mh17-20020a056214565100b006a0f6370667mr70464qvb.12.1714578295498; Wed, 01 May
 2024 08:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
In-Reply-To: <20240501100446.1454264-1-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 1 May 2024 08:44:42 -0700
Message-ID: <CAKEwX=NKMOJQ2KuiBcs-62NzqAhRDOvEhWvAzjsAbUtg=65fvA@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> The condition for writeback can be triggered by allocating random
> memory more than memory.high to push memory into zswap, more than
> zswap.max to trigger writeback if enabled, but less than memory.max
> so that OOM is not triggered. Both values of memory.zswap.writeback
> are tested.

Thanks for adding the test, Usama :) A couple of suggestions below.

>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index f0e488ed90d8..fe0e7221525c 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *ar=
g)
>         return 0;
>  }
>
> +static int allocate_random_bytes(const char *cgroup, void *arg)
> +{
> +       size_t size =3D (size_t)arg;
> +       char *mem =3D (char *)malloc(size);
> +
> +       if (!mem)
> +               return -1;
> +       for (int i =3D 0; i < size; i++)
> +               mem[i] =3D rand() % 128;
> +       free(mem);
> +       return 0;
> +}
> +
>  static char *setup_test_group_1M(const char *root, const char *name)
>  {
>         char *group_name =3D cg_name(root, name);
> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>         return ret;
>  }
>
> +/* Test to verify the zswap writeback path */
> +static int test_zswap_writeback(const char *root, bool wb)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *test_group;
> +       long zswpwb_before, zswpwb_after;
> +
> +       test_group =3D cg_name(root,
> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_di=
sabled_test");
> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +       if (cg_write(test_group, "memory.max", "8M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.high", "2M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"=
))
> +               goto out;
> +
> +       zswpwb_before =3D cg_read_key_long(test_group, "memory.stat", "zs=
wpwb ");
> +       if (zswpwb_before < 0) {
> +               ksft_print_msg("failed to get zswpwb_before\n");
> +               goto out;
> +       }
> +
> +       /*
> +        * Allocate more than memory.high to push memory into zswap,
> +        * more than zswap.max to trigger writeback if enabled,
> +        * but less than memory.max so that OOM is not triggered
> +        */
> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
> +               goto out;

I think we should document better why we allocate random bytes (rather
than just using the existing allocation helper).

This random allocation pattern (rand() % 128) is probably still
compressible by zswap, albeit poorly. I assume this is so that zswap
would not be able to just absorb all the swapped out pages?

> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D cg_read_key_long(test_group, "memory.stat", "zsw=
pwb ");
> +       if (wb) {
> +               if (zswpwb_after <=3D zswpwb_before) {
> +                       ksft_print_msg("writeback enabled and zswpwb_afte=
r <=3D zswpwb_before\n");
> +                       goto out;
> +               }
> +       } else {
> +               if (zswpwb_after !=3D zswpwb_before) {
> +                       ksft_print_msg("writeback disabled and zswpwb_aft=
er !=3D zswpwb_before\n");
> +                       goto out;
> +               }

It'd be nice if we can check that in this case, the number of pages
that are "swapped out" matches the cgroup's zswpout stats :)


> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +out:
> +       cg_destroy(test_group);
> +       free(test_group);
> +       return ret;
> +}
> +
> +static int test_zswap_writeback_enabled(const char *root)
> +{
> +       return test_zswap_writeback(root, true);
> +}
> +
> +static int test_zswap_writeback_disabled(const char *root)
> +{
> +       return test_zswap_writeback(root, false);
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
>   * limit in zswap, writeback should affect only the zswapped pages of th=
at
> @@ -425,6 +506,8 @@ struct zswap_test {
>         T(test_zswap_usage),
>         T(test_swapin_nozswap),
>         T(test_zswapin),
> +       T(test_zswap_writeback_enabled),
> +       T(test_zswap_writeback_disabled),
>         T(test_no_kmem_bypass),
>         T(test_no_invasive_cgroup_shrink),
>  };
> --
> 2.43.0
>

