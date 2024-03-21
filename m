Return-Path: <linux-kernel+bounces-110316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58D885D14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BD9288155
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C412C54F;
	Thu, 21 Mar 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmLA+WYg"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDF12C531;
	Thu, 21 Mar 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037488; cv=none; b=GYekPuDQJnA3AQBixVPtQKpYXCkPnfBAJCqkepH/nPyG4fVN4g73Rt+EzLDVje+v/9HhiydNejq+JRW4aWEMyDBna764dhkpVkSiKalGMMZ5eRQhnXZImTRafJ5qa+u7XsV8HeP/bKuMlYM1eXcz5GTojz9TFgfjVSutMhBMnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037488; c=relaxed/simple;
	bh=GXzDY6aQIzbC3/65zz7zxM+4qBX0ieLULr+Gd+ARJ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AozL81S/C/sDGLv1YQihhmz8fZ1Jnx/Gu8u2eeUmJ0KqbraMRoN5EF7jbKLtdl705P3MjG0a4LbpWXtyrxNTT1w+YOOJYoY8k3dt1Cct/5PhuWHAlju2nlXLfAu8ZnVBVmYZM8F+upCuHUZfpu8yyUOPo0prZdcdW+FZH2nskTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmLA+WYg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e01c38f98cso7581955ad.3;
        Thu, 21 Mar 2024 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711037486; x=1711642286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ4Ih7l6K3kM42eSjSiX1HZ7od3Xj13k1HeO4ATrU/E=;
        b=lmLA+WYgZKiZLzChOCWEP+mbQdFa90PDX1vCQ8NDc9L3jjnlS92p30Z4kBEh/j1GjL
         H9xACE4dV4CaJEAnIKU02nEV4wc4QFouosEV2PvNmw5/Jq+6ccbevt5NcYli5rSp8t7E
         hZa95M+ep+p9gYwrXxvRJWLcWd1JX+q+2M+AbECycAIsm5yl57z8K70pt6yHZYsCaa6G
         UnXkxQXqfxRdEu4znN1yQ8Jk6uCV8RsFD3ORP0JP8Qn6xpfjAVW8eg7xDq6rBzCMpUaE
         JJ5k1FLGeoWErs92nnL8dl5TEeoxGJUQddBzpI6iiJUiXEng1LUlFG2E2futdYXzSCnw
         SCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037486; x=1711642286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ4Ih7l6K3kM42eSjSiX1HZ7od3Xj13k1HeO4ATrU/E=;
        b=l3PEWDt1ohSlfsie7FlUuzWoIYLLeQ1QZ/CaRRnChUp7dO/YY1qOt9DhKvL4yVygjK
         VIVg/5yKDuKX48Qd9chrkzd2IRhz71BQ/tZOyf5FgaBcSt8W/2GTMRidsB32FEONAnPH
         Bk1iIRGKw5RN574wOAO8hk/kV5gj2PLYl/KeeS55c7080STcT6l/XmEynAJCjOLwJpvD
         lIzKOCySlbo6B/sapWkW9He53lgRghqQc8SWJwcPuWLxJhVPOTr3vgEHv93me3fV3rOT
         /OY0/LjPh6WNE4I6oSV0XfpfHv48u5XXucv+5zAFyfD+yDGL49RWq3j2DgNS7mPwKrhk
         jFVg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Z4JXd7vAlDYVsbKdLIb/DNVFOExZ6sINFialB8seq2Ce7Ww2OS7oP3wdvLj49gjINyOJj54s/1McVngbFSeev22FeDySYKIBJ8X+p/riuBPuzvclcRXhr7Lmo03pzy3POwVu0JEkZKaA++kLP3Zw04C9h06xOvbjJ0vElwNGWAOUjg==
X-Gm-Message-State: AOJu0YxtF8jmSaanDxEg5JptbKUBf08slYIzc4JRZbLc6VcvDxg9v2MT
	wBLtWdphqNXyma7ibKbjq2Yg6qOmufANWIDFBtvmV7pc8rvCK2eMjD+UAB/8PO4mRbDaNgMWmz8
	rX2A+tLXF1f9TvmeFw77QJuctauc=
X-Google-Smtp-Source: AGHT+IHDPeFBzIGiNXonW5nWzq3MXfueHO6nXYor8nCmrNu//8R7Jtu6D6mspudJPCoU7Zd/7+sAnxFndjEpFpwsUQw=
X-Received: by 2002:a17:903:1c4:b0:1dd:6781:49ab with SMTP id
 e4-20020a17090301c400b001dd678149abmr3174875plh.59.1711037486471; Thu, 21 Mar
 2024 09:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
In-Reply-To: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 09:11:14 -0700
Message-ID: <CAEf4BzZnf-ibDHuS_RqSgpe1nC+2HBkQ7RYD-qGjRL18rOa7RA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Jonathan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:57=E2=80=AFAM Jonathan Haslam
<jonathan.haslam@gmail.com> wrote:
>
> Active uprobes are stored in an RB tree and accesses to this tree are
> dominated by read operations. Currently these accesses are serialized by
> a spinlock but this leads to enormous contention when large numbers of
> threads are executing active probes.
>
> This patch converts the spinlock used to serialize access to the
> uprobes_tree RB tree into a reader-writer spinlock. This lock type
> aligns naturally with the overwhelmingly read-only nature of the tree
> usage here. Although the addition of reader-writer spinlocks are
> discouraged [0], this fix is proposed as an interim solution while an
> RCU based approach is implemented (that work is in a nascent form). This
> fix also has the benefit of being trivial, self contained and therefore
> simple to backport.

Yep, makes sense, I think we'll want to backport this ASAP to some of
the old kernels we have. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> This change has been tested against production workloads that exhibit
> significant contention on the spinlock and an almost order of magnitude
> reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs=
).
>
> [0] https://docs.kernel.org/locking/spinlocks.html
>
> Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> ---
>  kernel/events/uprobes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 929e98c62965..42bf9b6e8bc0 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
>   */
>  #define no_uprobe_events()     RB_EMPTY_ROOT(&uprobes_tree)
>
> -static DEFINE_SPINLOCK(uprobes_treelock);      /* serialize rbtree acces=
s */
> +static DEFINE_RWLOCK(uprobes_treelock);        /* serialize rbtree acces=
s */
>
>  #define UPROBES_HASH_SZ        13
>  /* serialize uprobe->pending_list */
> @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode=
, loff_t offset)
>  {
>         struct uprobe *uprobe;
>
> -       spin_lock(&uprobes_treelock);
> +       read_lock(&uprobes_treelock);
>         uprobe =3D __find_uprobe(inode, offset);
> -       spin_unlock(&uprobes_treelock);
> +       read_unlock(&uprobes_treelock);
>
>         return uprobe;
>  }
> @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *up=
robe)
>  {
>         struct uprobe *u;
>
> -       spin_lock(&uprobes_treelock);
> +       write_lock(&uprobes_treelock);
>         u =3D __insert_uprobe(uprobe);
> -       spin_unlock(&uprobes_treelock);
> +       write_unlock(&uprobes_treelock);
>
>         return u;
>  }
> @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
>         if (WARN_ON(!uprobe_is_active(uprobe)))
>                 return;
>
> -       spin_lock(&uprobes_treelock);
> +       write_lock(&uprobes_treelock);
>         rb_erase(&uprobe->rb_node, &uprobes_tree);
> -       spin_unlock(&uprobes_treelock);
> +       write_unlock(&uprobes_treelock);
>         RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>         put_uprobe(uprobe);
>  }
> @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
>         min =3D vaddr_to_offset(vma, start);
>         max =3D min + (end - start) - 1;
>
> -       spin_lock(&uprobes_treelock);
> +       read_lock(&uprobes_treelock);
>         n =3D find_node_in_range(inode, min, max);
>         if (n) {
>                 for (t =3D n; t; t =3D rb_prev(t)) {
> @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
>                         get_uprobe(u);
>                 }
>         }
> -       spin_unlock(&uprobes_treelock);
> +       read_unlock(&uprobes_treelock);
>  }
>
>  /* @vma contains reference counter, not the probed instruction. */
> @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigne=
d long start, unsigned long e
>         min =3D vaddr_to_offset(vma, start);
>         max =3D min + (end - start) - 1;
>
> -       spin_lock(&uprobes_treelock);
> +       read_lock(&uprobes_treelock);
>         n =3D find_node_in_range(inode, min, max);
> -       spin_unlock(&uprobes_treelock);
> +       read_unlock(&uprobes_treelock);
>
>         return !!n;
>  }
> --
> 2.43.0
>

