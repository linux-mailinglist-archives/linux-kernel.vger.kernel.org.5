Return-Path: <linux-kernel+bounces-514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081B81424F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BB31F231F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6110948;
	Fri, 15 Dec 2023 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkD+o86L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0C101C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so8749a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625070; x=1703229870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar1/QaxuZM6RP2byX2TH29qNuqN+lLyFuf9z+BnTVrk=;
        b=FkD+o86LBHX4w202GY6540tAmzmUEnqUqJ2qDiHwI8ZXiP66qdqAp9+5RsXEW2HTEV
         +mhM23fgb5GzeWgZRq6CcYoVNBIEnuL+N3Mp4mgrhtt3TiPGLxTH+Mg3pro4z5k12nOd
         kgXIzhUYnxPJcIe2p4cyc8No0ngtG6S7qcLEcx3ik8rayo71PfKp9Z4TWADOv2sn5vx8
         RJtTdQ3dWfigzsGqNmPTKF68U71Pn/oITmtd6FPxv1Q2stlMUVlFlSR461jsSf4gXyX/
         /jLTta/FsAMSU2fLDAvDXaG1qCnKBnEWiW7IDB9cobtP+QAPqEQGgBxn6Zdx4CvdKTEX
         9/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625070; x=1703229870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar1/QaxuZM6RP2byX2TH29qNuqN+lLyFuf9z+BnTVrk=;
        b=Y1eAA9bTS3Swwnnghdisy7oRVTBDvLzfJJSQx5SQscn33CVU1AcUQrZCsfJYeDx2xg
         gEt56tIhMuw0nsa0Vi6HTYiC6wWe6Ny0M8xzEx2wtx2Qah8+22OsCdIJ124oDoeoq8k+
         PQyEvisVGfRK36by2Ya89Ztanyt1m9Hnv3BNcKRt6SCtsyUF+n91PXUws3D4WbPImO9E
         iqusJSUXG+WsQ6xOdTCATyb8IZGdI+DKjD3cDOv2lQiottrmE3SMspvlcoLLIHaMrO5G
         qvPjZkTdbFB7fTmm+C1wtW1waWyFcTlueGuUo9oT+DNrNFPq9IB3fkOq7YYCnTjPdRuz
         XyIA==
X-Gm-Message-State: AOJu0YxievKyMq2Xr1WhnE3QIPWEaWovZ25XDFZcUTEZcm9sjh2M+B8H
	AL0jOArJJg8rSuNMgGoa9bMdbDqasniDm+ohsPoEYw==
X-Google-Smtp-Source: AGHT+IHuw2pFMJRAc/0G8aVaiU/P0CRJh2c6oR4wxF46Uv67s/swnBCz1A657gIOTw9m6By51s/dkit8N3mEzPMCOSM=
X-Received: by 2002:a05:6402:35c5:b0:551:9870:472 with SMTP id
 z5-20020a05640235c500b0055198700472mr517917edc.1.1702625069994; Thu, 14 Dec
 2023 23:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701853894.git.henry.hj@antgroup.com> <951fb7edab535cf522def4f5f2613947ed7b7d28.1701853894.git.henry.hj@antgroup.com>
In-Reply-To: <951fb7edab535cf522def4f5f2613947ed7b7d28.1701853894.git.henry.hj@antgroup.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 15 Dec 2023 00:23:52 -0700
Message-ID: <CAOUHufavCOqwkm4BJJzHY+RUOafFBLH7t0O+KRbw=ns-RdYwdA@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 5:51=E2=80=AFAM Henry Huang <henry.hj@antgroup.com> =
wrote:
>
> Multi-Gen LRU page-table walker clears pte young flag, but it doesn't
> clear page idle flag. When we use /sys/kernel/mm/page_idle/bitmap to chec=
k
> whether one page is accessed, it would tell us this page is idle,
> but actually this page has been accessed.
>
> For those unmapped filecache pages, page idle flag would not been
> cleared in folio_mark_accessed if Multi-Gen LRU is enabled.
> So we couln't use /sys/kernel/mm/page_idle/bitmap to check whether
> a filecache page is read or written.
>
> What's more, /sys/kernel/mm/page_idle/bitmap also clears pte young flag.
> If one page is accessed, it would set page young flag. Multi-Gen LRU
> page-table walker should check both page&pte young flags.
>
> how-to-reproduce-problem
>
> idle_page_track
>    a tools to track process accessed memory during a specific time
> usage
>    idle_page_track $pid $time
> how-it-works
>    1. scan process vma from /proc/$pid/maps
>    2. vfn --> pfn from /proc/$pid/pagemap
>    3. write /sys/kernel/mm/page_idle/bitmap to
>       mark phy page idle flag and clear pte young flag
>    4. sleep $time
>    5. read /sys/kernel/mm/page_idle/bitmap to
>       test_and_clear pte young flag and
>       return whether phy page is accessed
>
> test ---- test program
>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
>
>  int main(int argc, const char *argv[])
>  {
>      char *buf =3D NULL;
>      char pipe_info[4096];
>      int n;
>      int fd =3D -1;
>
>      buf =3D malloc(1024*1024*1024UL);
>      memset(buf, 0, 1024*1024*1024UL);
>      fd =3D open("access.pipe", O_RDONLY);
>      if (fd < 0)
>          goto out;
>      while (1) {
>          n =3D read(fd, pipe_info, sizeof(pipe_info));
>          if (!n) {
>              sleep(1);
>              continue;
>          } else if (n < 0) {
>              break;
>          }
>          memset(buf, 0, 1024*1024*1024UL);
>          puts("finish access");
>       }
>  out:
>      if (fd >=3D0)
>          close(fd);
>      if (buf)
>          free(buf);
>
>      return 0;
>  }
>
> prepare:
> mkfifo access.pipe
> ./test
> ps -ef | grep test
> root       4106   3148  8 06:47 pts/0    00:00:01 ./test
>
> We use /sys/kernel/debug/lru_gen to simulate mglru page-table scan.
>
> case 1: mglru walker break page_idle
> ./idle_page_track 4106 60 &
> sleep 5; echo 1 > access.pipe
> sleep 5;  echo '+ 8 0 6 1 1' > /sys/kernel/debug/lru_gen
>
> the output of idle_page_track is:
> Est(s)     Ref(MB)
> 64.822        1.00
> only found 1MB were accessed during 64.822s, but actually 1024MB were
> accessed.
>
> case 2: page_idle break mglru walker
> echo 1 > access.pipe
> ./idle_page_track 4106 10
> echo '+ 8 0 7 1 1' > /sys/kernel/debug/lru_gen
> lru gen status:
> memcg     8     /user.slice
>  node     0
>           5     772458       1065        9735
>           6     737435     262244          72
>           7     538053       1184         632
>           8      59404       6422           0
> almost pages should be in max_seq-1 queue, but actually not.
>
> Signed-off-by: Henry Huang <henry.hj@antgroup.com>

Regarding the change itself, it'd cause a slight regression to other
use cases (details below).

> @@ -3355,6 +3359,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned lon=
g start, unsigned long end,
>                 unsigned long pfn;
>                 struct folio *folio;
>                 pte_t ptent =3D ptep_get(pte + i);
> +               bool is_pte_young;
>
>                 total++;
>                 walk->mm_stats[MM_LEAF_TOTAL]++;
> @@ -3363,16 +3368,20 @@ static bool walk_pte_range(pmd_t *pmd, unsigned l=
ong start, unsigned long end,
>                 if (pfn =3D=3D -1)
>                         continue;
>
> -               if (!pte_young(ptent)) {
> -                       walk->mm_stats[MM_LEAF_OLD]++;

Most overhead from page table scanning normally comes from
get_pfn_folio() because it almost always causes a cache miss. This is
like a pointer dereference, whereas scanning PTEs is like streaming an
array (bad vs good cache performance).

pte_young() is here to avoid an unnecessary cache miss from
get_pfn_folio(). Also see the first comment in get_pfn_folio(). It
should be easy to verify the regression -- FlameGraph from the
memcached benchmark in the original commit message should do it.

Would a tracepoint here work for you?



> +               is_pte_young =3D !!pte_young(ptent);
> +               folio =3D get_pfn_folio(pfn, memcg, pgdat, walk->can_swap=
, is_pte_young);
> +               if (!folio) {
> +                       if (!is_pte_young)
> +                               walk->mm_stats[MM_LEAF_OLD]++;
>                         continue;
>                 }
>
> -               folio =3D get_pfn_folio(pfn, memcg, pgdat, walk->can_swap=
);
> -               if (!folio)
> +               if (!folio_test_clear_young(folio) && !is_pte_young) {
> +                       walk->mm_stats[MM_LEAF_OLD]++;
>                         continue;
> +               }
>
> -               if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
> +               if (is_pte_young && !ptep_test_and_clear_young(args->vma,=
 addr, pte + i))
>                         VM_WARN_ON_ONCE(true);
>
>                 young++;

