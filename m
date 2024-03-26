Return-Path: <linux-kernel+bounces-119414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F062788C85F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F9032229B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C313C909;
	Tue, 26 Mar 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+AVg4pM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D22574B;
	Tue, 26 Mar 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468923; cv=none; b=kcpIp+7zWp/Mv55on3hZsV9BTNCOgMvCjpuNoUUGWZYmGTCKWvU9VMXUuhnOXGBLnMyK/T6zWFiRXZxcR6aQj0a1DOjBI1CF4ZSZfKPJTsET6FR5IbYvQ2qrXlLVHntK5cPCuMhdmgN6JVQVXCSeZ+UH/y2afyd1wcLdyHIYjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468923; c=relaxed/simple;
	bh=IjbfE8tFOdfjNx4MkilscMXL9i5JKvzYqCkq93qx1DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf5WFUFs7oZtBkbymupksJMDJybJRaTyr9w2hwOcqYhdjSwITBs52Kb3mRkThvz07TDrWen+eerCvo6NG5Glqx4BEIyyiwEtN/lmt+4RLCQudPzKUp5akd5lb+XRGCC+1kgga6bAubw5LBpvRTuKlw/DU8TU9TZoK0tJZrKBdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+AVg4pM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0f2798b47so5211775ad.1;
        Tue, 26 Mar 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711468920; x=1712073720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQJPy88vBYo4nQyyX6JO+jPm5JtOURILAq3nriLwYbQ=;
        b=I+AVg4pMGd1gzfEoz6Uq8v/9YC+YvYSeTaAiyRhtTnNeYvxqaxCXtahDtSH0Yzxl0b
         dPokTHz6GZQWZ6JqdpOrNc8I7LabJejcpMu8vuxFYRiZLuXgtt8bU6ZIKP3hmgB02A20
         8QrbargXJ2GlhYvGsxEespqzME3YB4IorZq46woaCh5JVeRiZTqcQ0JbTwU1w+VFi//2
         Max75S5+Ya+pdOpTe67owOLHLSlM6IMdvG7CG2+1ONmjT8BpM0Wttev6gV8GnFC0KbSB
         64ztF3PZTfkkJ3LzW6ieamFi1X+wHyVdPlA+VXzR3nK+tglXrmzZsj2UEVVB2BFdzTwu
         ZJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711468920; x=1712073720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQJPy88vBYo4nQyyX6JO+jPm5JtOURILAq3nriLwYbQ=;
        b=wTWmj+E0pMc+2kBqXP/5Sh6+hjiM0ob1QgOaOEujSgKmgt/5iwRTpesSGUOY4kg/kU
         2/nfjGdq0wMqqxF8p88iayWs1IijDFrdtVM2IReM61NvUkCJceMdH7F/gze1HiVcetWg
         K+zdF2cWIgpJaDXCAxi5TvGG4OivweCiHV7c13KO/mCvbGryQbXeH7ekRo9sGrnjOTVd
         S/83Gl33d9VbnUqgelQS3R8Wzg3tqBYeqVtj3xP92XBEN17Q69gTOuxbo6oJunck9lCE
         jWr1KVyFlFDAs0fHIy3F7h8jZ52jcOuBJYcU6jn/iEn95l8VXnxt23C8M3UaHDm/yXoU
         JM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuGvkc4rfpLe5NHyZtl36fj8QLiRmT0XBcj9YV3vBf6iW5YG7XOUoMu+VpTLMLZ+qlaCRC/eDY8pmQDMpm0U6/Hl5XFAG0rNDjpx8K6BUFf/phLszpVpK7E5KVZd6yQfTmGdvRVhZ7PVwQURSPhx6NJak5xElLK/E7W8zRfJZzb32B7IB8UZLgnI2uTcKmn2RUpTik/tju2qYjT6aLs1toZNzIs+B2mA==
X-Gm-Message-State: AOJu0YxI2Ua17tn5tN/pxuvLnoKanWJFlgh70WAFA18jE6OjwksuHhwX
	NJIEvI5zHk7dx4kdB+uAS5W24qDC/hg7cEE8y9ByFEmQx7F1JiOuum2Kpt2Bkx+TtuzfwUW9lqZ
	+Ho+VwnvMcbxATsqZ3C8tsWwpk+w=
X-Google-Smtp-Source: AGHT+IHtfConeE4djnAj96ZFcg6gNNv5l9VculGG8dY053dAspbyKZxpxh/zkIuAVWRiJAqk6iJIDniUnCwGli8dbQg=
X-Received: by 2002:a17:902:e748:b0:1e0:e011:e3cb with SMTP id
 p8-20020a170902e74800b001e0e011e3cbmr3326261plf.15.1711468919504; Tue, 26 Mar
 2024 09:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com> <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
In-Reply-To: <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Mar 2024 09:01:47 -0700
Message-ID: <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Haslam <jonathan.haslam@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 8:03=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 21 Mar 2024 07:57:35 -0700
> Jonathan Haslam <jonathan.haslam@gmail.com> wrote:
>
> > Active uprobes are stored in an RB tree and accesses to this tree are
> > dominated by read operations. Currently these accesses are serialized b=
y
> > a spinlock but this leads to enormous contention when large numbers of
> > threads are executing active probes.
> >
> > This patch converts the spinlock used to serialize access to the
> > uprobes_tree RB tree into a reader-writer spinlock. This lock type
> > aligns naturally with the overwhelmingly read-only nature of the tree
> > usage here. Although the addition of reader-writer spinlocks are
> > discouraged [0], this fix is proposed as an interim solution while an
> > RCU based approach is implemented (that work is in a nascent form). Thi=
s
> > fix also has the benefit of being trivial, self contained and therefore
> > simple to backport.
> >
> > This change has been tested against production workloads that exhibit
> > significant contention on the spinlock and an almost order of magnitude
> > reduction for mean uprobe execution time is observed (28 -> 3.5 microse=
cs).
>
> Looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Masami,

Given the discussion around per-cpu rw semaphore and need for
(internal) batched attachment API for uprobes, do you think you can
apply this patch as is for now? We can then gain initial improvements
in scalability that are also easy to backport, and Jonathan will work
on a more complete solution based on per-cpu RW semaphore, as
suggested by Ingo.

>
> BTW, how did you measure the overhead? I think spinlock overhead
> will depend on how much lock contention happens.
>
> Thank you,
>
> >
> > [0] https://docs.kernel.org/locking/spinlocks.html
> >
> > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > ---
> >  kernel/events/uprobes.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 929e98c62965..42bf9b6e8bc0 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
> >   */
> >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> >
> > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree acces=
s */
> > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree acces=
s */
> >
> >  #define UPROBES_HASH_SZ      13
> >  /* serialize uprobe->pending_list */
> > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *ino=
de, loff_t offset)
> >  {
> >       struct uprobe *uprobe;
> >
> > -     spin_lock(&uprobes_treelock);
> > +     read_lock(&uprobes_treelock);
> >       uprobe =3D __find_uprobe(inode, offset);
> > -     spin_unlock(&uprobes_treelock);
> > +     read_unlock(&uprobes_treelock);
> >
> >       return uprobe;
> >  }
> > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *=
uprobe)
> >  {
> >       struct uprobe *u;
> >
> > -     spin_lock(&uprobes_treelock);
> > +     write_lock(&uprobes_treelock);
> >       u =3D __insert_uprobe(uprobe);
> > -     spin_unlock(&uprobes_treelock);
> > +     write_unlock(&uprobes_treelock);
> >
> >       return u;
> >  }
> > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> >       if (WARN_ON(!uprobe_is_active(uprobe)))
> >               return;
> >
> > -     spin_lock(&uprobes_treelock);
> > +     write_lock(&uprobes_treelock);
> >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > -     spin_unlock(&uprobes_treelock);
> > +     write_unlock(&uprobes_treelock);
> >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> >       put_uprobe(uprobe);
> >  }
> > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> >       min =3D vaddr_to_offset(vma, start);
> >       max =3D min + (end - start) - 1;
> >
> > -     spin_lock(&uprobes_treelock);
> > +     read_lock(&uprobes_treelock);
> >       n =3D find_node_in_range(inode, min, max);
> >       if (n) {
> >               for (t =3D n; t; t =3D rb_prev(t)) {
> > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> >                       get_uprobe(u);
> >               }
> >       }
> > -     spin_unlock(&uprobes_treelock);
> > +     read_unlock(&uprobes_treelock);
> >  }
> >
> >  /* @vma contains reference counter, not the probed instruction. */
> > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsig=
ned long start, unsigned long e
> >       min =3D vaddr_to_offset(vma, start);
> >       max =3D min + (end - start) - 1;
> >
> > -     spin_lock(&uprobes_treelock);
> > +     read_lock(&uprobes_treelock);
> >       n =3D find_node_in_range(inode, min, max);
> > -     spin_unlock(&uprobes_treelock);
> > +     read_unlock(&uprobes_treelock);
> >
> >       return !!n;
> >  }
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

