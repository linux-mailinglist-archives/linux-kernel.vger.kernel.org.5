Return-Path: <linux-kernel+bounces-73678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFA85C5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6361F21BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D614AD13;
	Tue, 20 Feb 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtI62mJS"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF6137C41
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460938; cv=none; b=VX7HMTNshd+n6U56W9E+604lYXB3JUBjFmuIJMKCmNsqPhgjxT5V6hKQnIhtM0G4ssDu5osOLv5hQSeiq2maSk1AcwLhAq9lxPoT+5G6UHFh+MtzT5SjnWKgxMD+x2JWsSt7BH6B2i3MrkBKn6A/rqbzi8K9/thI682k3ZpIltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460938; c=relaxed/simple;
	bh=Z8hH+nUkdKI4/djCjmnhxLyTG/4N2RSHJGrU/nJxrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aum5y54sYqsxWzBCvK9qQdhnBH9jdDCIbCQhitIFWF9BybHB7h3k/KrpKsIIrYHjvX1hoD5O5H6IbKgCm+2UZZw2KqB0Lqbi+51PpS8hbU6LapoiXsWDQuUzb/G8r7MuK9S1SXhzugmanE0Zf/t+6lisD5Ynwok3xDParaGzCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtI62mJS; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so3157561241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460936; x=1709065736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJVLT75WajL6t4L9YIZZCclZPhvgAF8k7gyY0UcPW3w=;
        b=GtI62mJStiE4IlQiIJYzPZrriIRb7nYPTtxkQzYel9ZwoA7rRsnb+mWlm0Ev/BPzH9
         GYIVJauB5eXip/riCytP54Aq3A27hfOo/hpWTesN4kxjlydWt66ZJdmuXasIuWzqFEtG
         VtT8hVhgdfplzj6YqITeC4gBBPWcm00cnSDGeOTD8UFyFkV8PciPMQjYfEEFvo3vvLS/
         Tgta5aQTEOnGUa7Qh6Vky7nKHUUeYycfmMOhaPPOYXBSSaM0PGmSiw8vDdgaHQuKDe3a
         hZRc4gjjxAnFuca5QBtbraVH5GWQrr9sa9o6R88qNV0roTkrV8NBQWQgG/zNybFMZgDT
         zNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460936; x=1709065736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJVLT75WajL6t4L9YIZZCclZPhvgAF8k7gyY0UcPW3w=;
        b=S75CaHeTvZ5wwQ/bnWy41q3gRQYWJvmMt/2vAPISd3DSB+YHDUYJ1+itdKU9JgzM/z
         CZYyWktscCDFnVXEMfaVwJqXUVSLSWRG6QqwYWXpyufFfg+0JX5LHQxRheDd1YkYQ9XR
         7hhlAtrGcfim1idqNEw/1SmA9pT7CQThk69TMjj16i4NbII3YjZdN4gatJ/VxVI2I3Sy
         0+6IVRWPMpNFZMizsHCYNAwB8/F5lw8stzdP9VP5/Iv1638lCXejieMFfiV84dhJUmWq
         L+OFXMqrEAaG/vdJnKNfKyQwUW0WmAcGGd2JXT2eowsq89SvWxyehfEYCCViVQn0hzf2
         L2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUF/ueUboVz4HEoL3eAlFDMlNfbKFBIlAtKI/lfAiPgtYj0ZmMXmvngZ1578ICxowjj78njofLVm2zySie3UETMcch5l37s2tKkbE5C
X-Gm-Message-State: AOJu0Yx0NEvjriFSa/SXhhB2lUygw8pazOpMqreHSvhBbYtB4MkKsD95
	xFdSNvvfd+BMN4bSmWXq4UeJWAaxykS8DLfanGtIALtmFhYux1DpBatdjC2CUglvP5WwKONBS7R
	FW91xeoKai/kWyR1sms05bzDThAE=
X-Google-Smtp-Source: AGHT+IFBjP/m9hY+L9Ae17EXOU2oBF+9rKDSjBrKJ8GEBbRzI2SC33AHgZImHGXoyc1z5a39h+PHDI8G5giXKXWvkl8=
X-Received: by 2002:a67:f3cb:0:b0:470:41e7:bd75 with SMTP id
 j11-20020a67f3cb000000b0047041e7bd75mr6853615vsn.5.1708460935696; Tue, 20 Feb
 2024 12:28:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b@epcms2p6>
 <20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b@epcms2p6>
In-Reply-To: <20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b@epcms2p6>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 20 Feb 2024 12:28:44 -0800
Message-ID: <CACOAw_wS0SS8xhoKkK9aBz2mquVw4fYwfJFqGUJ4QUk08XfxdA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: New victim selection for GC
To: yonggil.song@samsung.com
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>, 
	Daejun Park <daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:36=E2=80=AFPM Yonggil Song <yonggil.song@samsung.=
com> wrote:
>
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch introduces a new way to preference data sections when selectin=
g
> GC victims. Migration of data blocks causes invalidation of node blocks.
> Therefore, in situations where GC is frequent, selecting data blocks as
> victims can reduce unnecessary block migration by invalidating node block=
s.

Your approach will allocate new node blocks despite invalidating
current node blocks while moving data blocks, though. While your
approach may work well relating to WAF in a specific scenario, such as
randomly overwriting an entire storage space with a huge file, it is
important to consider its general applicability. For example, how
about the test performance? Performance optimization should encompass
a wide range of user scenarios. However, I am not convinced that this
is the most efficient solution for most users. Can you provide more
information about how your approach addresses the performance needs of
a broader spectrum of user scenarios?

> For exceptional situations where free sections are insufficient, node blo=
cks
> are selected as victims instead of data blocks to get extra free sections=
.
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D
>
> If the total amount of nodes is larger than the size of one section, node=
s
> occupy multiple sections, and node victims are often selected because the
> gc cost is lowered by data block migration in GC. Since moving the data
> section causes frequent node victim selection, victim threshing occurs in
> the node section. This results in an increase in WAF.
>
> Experiment
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Test environment is as follows.
>
>         System info
>           - 3.6GHz, 16 core CPU
>           - 36GiB Memory
>         Device info
>           - a conventional null_blk with 228MiB
>           - a sequential null_blk with 4068 zones of 8MiB
>         Format
>           - mkfs.f2fs <conv null_blk> -c <seq null_blk> -m -Z 8 -o 3.89
>         Mount
>           - mount <conv null_blk> <mount point>
>         Fio script
>           - fio --rw=3Drandwrite --bs=3D4k --ba=3D4k --filesize=3D31187m =
--norandommap --overwrite=3D1 --name=3Djob1 --filename=3D./mnt/sustain --io=
_size=3D128g
>         WAF calculation
>           - (IOs on conv. null_blk + IOs on seq. null_blk) / random write=
 IOs
>
> Conclusion
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This experiment showed that the WAF was reduced by 29% (18.75 -> 13.3) wh=
en
> the data section was selected first when selecting GC victims. This was
> achieved by reducing the migration of the node blocks by 69.4%
> (253,131,743 blks -> 77,463,278 blks). It is possible to achieve low WAF
> performance with the GC victim selection method in environments where the
> section size is relatively small.
>
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/gc.c   | 96 +++++++++++++++++++++++++++++++++++++++-----------
>  fs/f2fs/gc.h   |  6 ++++
>  3 files changed, 82 insertions(+), 21 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..b129f62ba541 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1654,6 +1654,7 @@ struct f2fs_sb_info {
>         struct f2fs_mount_info mount_opt;       /* mount options */
>
>         /* for cleaning operations */
> +       bool require_node_gc;                   /* flag for node GC */
>         struct f2fs_rwsem gc_lock;              /*
>                                                  * semaphore for GC, avoi=
d
>                                                  * race between GC and GC=
 or CP
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a079eebfb080..53a51a668567 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -341,6 +341,14 @@ static unsigned int get_cb_cost(struct f2fs_sb_info =
*sbi, unsigned int segno)
>         unsigned int i;
>         unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi,=
 segno);
>
> +       /*
> +        * When BG_GC selects victims based on age, it prevents node vict=
ims
> +        * from being selected. This is because node blocks can be invali=
dated
> +        * by moving data blocks.
> +        */
> +       if (__skip_node_gc(sbi, segno))
> +               return UINT_MAX;
> +
>         for (i =3D 0; i < usable_segs_per_sec; i++)
>                 mtime +=3D get_seg_entry(sbi, start + i)->mtime;
>         vblocks =3D get_valid_blocks(sbi, segno, true);
> @@ -369,10 +377,24 @@ static inline unsigned int get_gc_cost(struct f2fs_=
sb_info *sbi,
>                 return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
>
>         /* alloc_mode =3D=3D LFS */
> -       if (p->gc_mode =3D=3D GC_GREEDY)
> -               return get_valid_blocks(sbi, segno, true);
> -       else if (p->gc_mode =3D=3D GC_CB)
> +       if (p->gc_mode =3D=3D GC_GREEDY) {
> +               /*
> +                * If the data block that the node block pointed to is GC=
ed,
> +                * the node block is invalidated. For this reason, we add=
 a
> +                * weight to cost of node victims to give priority to dat=
a
> +                * victims during the gc process. However, in a situation
> +                * where we run out of free sections, we remove the weigh=
t
> +                * because we need to clean up node blocks.
> +                */
> +               unsigned int weight =3D 0;
> +
> +               if (__skip_node_gc(sbi, segno))
> +                       weight =3D BLKS_PER_SEC(sbi);
> +
> +               return get_valid_blocks(sbi, segno, true) + weight;
> +       } else if (p->gc_mode =3D=3D GC_CB) {
>                 return get_cb_cost(sbi, segno);
> +       }
>
>         f2fs_bug_on(sbi, 1);
>         return 0;
> @@ -557,6 +579,14 @@ static void atgc_lookup_victim(struct f2fs_sb_info *=
sbi,
>         if (ve->mtime >=3D max_mtime || ve->mtime < min_mtime)
>                 goto skip;
>
> +       /*
> +        * When BG_GC selects victims based on age, it prevents node vict=
ims
> +        * from being selected. This is because node blocks can be invali=
dated
> +        * by moving data blocks.
> +        */
> +       if (__skip_node_gc(sbi, ve->segno))
> +               goto skip;
> +
>         /* age =3D 10000 * x% * 60 */
>         age =3D div64_u64(accu * (max_mtime - ve->mtime), total_time) *
>                                                                 age_weigh=
t;
> @@ -1827,8 +1857,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_=
gc_control *gc_control)
>                 goto stop;
>         }
>
> +       __get_secs_required(sbi, NULL, &upper_secs, NULL);
> +
> +       /*
> +        * Write checkpoint to reclaim prefree segments.
> +        * We need more three extra sections for writer's data/node/dentr=
y.
> +        */
> +       if (free_sections(sbi) <=3D upper_secs + NR_GC_CHECKPOINT_SECS) {
> +               sbi->require_node_gc =3D true;
> +
> +               if (prefree_segments(sbi)) {
> +                       stat_inc_cp_call_count(sbi, TOTAL_CALL);
> +                       ret =3D f2fs_write_checkpoint(sbi, &cpc);
> +                       if (ret)
> +                               goto stop;
> +                       /* Reset due to checkpoint */
> +                       sec_freed =3D 0;
> +               }
> +       }
> +
>         /* Let's run FG_GC, if we don't have enough space. */
> -       if (has_not_enough_free_secs(sbi, 0, 0)) {
> +       if (gc_type =3D=3D BG_GC && has_not_enough_free_secs(sbi, 0, 0)) =
{
>                 gc_type =3D FG_GC;
>
>                 /*
> @@ -1863,6 +1912,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_=
gc_control *gc_control)
>                 goto stop;
>         }
>
> +       if (sbi->require_node_gc &&
> +           IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
> +               /*
> +                * We need to clean node sections. but, data victim
> +                * cost is the lowest. If free sections are enough,
> +                * stop cleaning node victim. If not, it goes on
> +                * by GCing data victims.
> +                */
> +               if (has_enough_free_secs(sbi, sec_freed, 0))
> +                       goto stop;
> +       }
> +
>         seg_freed =3D do_garbage_collect(sbi, segno, &gc_list, gc_type,
>                                 gc_control->should_migrate_blocks);
>         if (seg_freed < 0)
> @@ -1882,7 +1943,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_=
gc_control *gc_control)
>                         if (!gc_control->no_bg_gc &&
>                             total_sec_freed < gc_control->nr_free_secs)
>                                 goto go_gc_more;
> -                       goto stop;
> +                       /*
> +                        * If require_node_gc flag is set even though the=
re
> +                        * are enough free sections, node cleaning will
> +                        * continue.
> +                        */
> +                       if (!sbi->require_node_gc)
> +                               goto stop;
>                 }
>                 if (sbi->skipped_gc_rwsem)
>                         skipped_round++;
> @@ -1897,21 +1964,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_=
gc_control *gc_control)
>                 goto stop;
>         }
>
> -       __get_secs_required(sbi, NULL, &upper_secs, NULL);
> -
> -       /*
> -        * Write checkpoint to reclaim prefree segments.
> -        * We need more three extra sections for writer's data/node/dentr=
y.
> -        */
> -       if (free_sections(sbi) <=3D upper_secs + NR_GC_CHECKPOINT_SECS &&
> -                               prefree_segments(sbi)) {
> -               stat_inc_cp_call_count(sbi, TOTAL_CALL);
> -               ret =3D f2fs_write_checkpoint(sbi, &cpc);
> -               if (ret)
> -                       goto stop;
> -               /* Reset due to checkpoint */
> -               sec_freed =3D 0;
> -       }
>  go_gc_more:
>         segno =3D NULL_SEGNO;
>         goto gc_more;
> @@ -1920,8 +1972,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_=
gc_control *gc_control)
>         SIT_I(sbi)->last_victim[ALLOC_NEXT] =3D 0;
>         SIT_I(sbi)->last_victim[FLUSH_DEVICE] =3D gc_control->victim_segn=
o;
>
> -       if (gc_type =3D=3D FG_GC)
> +       if (gc_type =3D=3D FG_GC) {
>                 f2fs_unpin_all_sections(sbi, true);
> +               sbi->require_node_gc =3D false;
> +       }
>
>         trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
>                                 get_pages(sbi, F2FS_DIRTY_NODES),
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 28a00942802c..cd07bf125177 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -166,3 +166,9 @@ static inline bool has_enough_invalid_blocks(struct f=
2fs_sb_info *sbi)
>                 free_user_blocks(sbi) <
>                         limit_free_user_blocks(invalid_user_blocks));
>  }
> +
> +static inline bool __skip_node_gc(struct f2fs_sb_info *sbi, unsigned int=
 segno)
> +{
> +       return (IS_NODESEG(get_seg_entry(sbi, segno)->type) &&
> +               !sbi->require_node_gc);
> +}
> --
> 2.34.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

