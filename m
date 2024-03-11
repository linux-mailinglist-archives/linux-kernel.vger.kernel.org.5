Return-Path: <linux-kernel+bounces-98513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283A877B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96D31F21EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000A10782;
	Mon, 11 Mar 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB7nofvc"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54843FC1E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710141567; cv=none; b=c1GD60nwjl/3zjH70bjVNC+xwiK9HGt6b5pd4MvQYFhtfYNvZvZ/6Em8qJSozFC+DjO6DtgZ/zVi4EhK3I8Grkcv7CP2qbKSmd5tESvtH6GOSyT9tsszBLnv6bn33SHlWq213nShs3Ly0WVpuyyCRE9u9cNOvUvaw6asgRvukPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710141567; c=relaxed/simple;
	bh=WC5+8tDR91+xKnRO/tE7XqH4sSwR2eYjal+Fn+1msgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBkumCaUxz+GQMfbyZEr1+ntM26uENTjV7KTL7xBsbkbe+4hqXY+Qsjt8JeAbF+BybJ0p3wCiDfWeXdYe5+CLwAKc4/LeauAJ9DAd8c5QIh45LPsXqpKW9gayGWLFteevMQCDxdx4FWYF4LeDIQAPZOP+exEy7/1CiOBsab4NXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB7nofvc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so1740758a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710141563; x=1710746363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NubNxNAwDlfGvOJkZd2n4klGKQ1hS4tYI5czjw3valc=;
        b=UB7nofvc8sd3CqtvHiE7vnpkVsuzRU+GJgBfbyeGe9QY63l8kHhZQphbHbPL42q+H9
         nopH1MOmfejazPin/r53Szph65ezu3XiBHNJVvGHC/yMIbSAJ6HOLYY5z14ZvoOy0gs5
         X+4H6569EtEmbdaOXZb40gqeIht/IF661fC2n+P9uBRaFCDUGDhDsl0CV4ohQ4FmTtHq
         9+cFIl10uwNJR87+BlqUpIKKPbF2TlAxO7MFLkLA7i0grpIzLzOoa+/53BUS8WU/blEM
         a5KKF9pi52T79UV+JVJtjfLMWbDOOSZA8DfSheek0duGsCArvLJEv2I46jTo0sem6H53
         2bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710141563; x=1710746363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NubNxNAwDlfGvOJkZd2n4klGKQ1hS4tYI5czjw3valc=;
        b=dcof8IbXCQ7KonukvvnxRXS7w8l9w8LFiqb7cW+KHniXqC6nVoHg2E4wyHuLBMKF6f
         KkCWYa4ixKOFio0ZBMYBqq6N8AgMptO+5sxIqAiLEpZS23zNh/m6SU/tkUGFxuSsejSf
         FhHKrTrSSI3xigi02Fe813LaPvANyTEgaH6hT41YGfupOm50ZwLBm9gqmt/xBa7ny3Z6
         Uyzm932sCPN9h2YX5Cyn8NDMVeuDqauLux5bYZkXAHOpJfWYam+hdhD+Uwru84B/w5TR
         mAtIZX/lCJyhjJebbD6j0+GH0hYDFT7+sS0D6NmARROe9JEmXFELaHuNdG912wePJgcd
         EPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlXBjigrNuz4E9DRsFiNw6nvqp5HPyz6WYb6T3OYpg4BsQe4WPVEArB6d9lKdgqJH+/BYLDFiys79X19TRIobzsRFUggfD8RVf3HdA
X-Gm-Message-State: AOJu0YytK96sceSnDp8Slf6hVHZ8zzfC0BX4s6soseGoK+DbE2VeZhlt
	o+ojyC+orwaUqDUVEBMjh22qVbxfYvHVFqMbvA9ejH1S9o9EF+6cOqxCQqxBjIYr3lFZRpx5h3B
	D0xbgeWIzjvQzlDxrjaa7JUngZOo=
X-Google-Smtp-Source: AGHT+IEDGRFbWDhEu2lC9Fr4uWuBzqU/pDLBZ67AIQYHtRGmQzHu09AydfxnXnaDymo+HcFHCvLHOHDmQ9hnHTTq6lM=
X-Received: by 2002:a50:d5c2:0:b0:565:c814:d891 with SMTP id
 g2-20020a50d5c2000000b00565c814d891mr3847602edj.0.1710141562481; Mon, 11 Mar
 2024 00:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
 <1709892753-27461-2-git-send-email-zhiguo.niu@unisoc.com> <ce37ca70-6c84-4a6f-8057-1770a00574d3@kernel.org>
In-Reply-To: <ce37ca70-6c84-4a6f-8057-1770a00574d3@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 11 Mar 2024 15:19:11 +0800
Message-ID: <CAHJ8P3KQg+gtpuX9rbLZafuMBzwvFW4J25RuzTCWM6+RNZd=0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: fix to handle error paths of {new,change}_curseg()
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:09=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/8 18:12, Zhiguo Niu wrote:
> > {new,change}_curseg() may return error in some special cases,
> > error handling should be did in their callers, and this will also
> > facilitate subsequent error path expansion in {new,change}_curseg().
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   fs/f2fs/extent_cache.c |  2 +-
> >   fs/f2fs/f2fs.h         |  4 ++--
> >   fs/f2fs/gc.c           |  7 +++++--
> >   fs/f2fs/segment.c      | 57 +++++++++++++++++++++++++++++++----------=
---------
> >   fs/f2fs/super.c        |  4 +++-
> >   5 files changed, 46 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 48048fa..dce00cf 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -988,7 +988,7 @@ bool f2fs_lookup_read_extent_cache_block(struct ino=
de *inode, pgoff_t index,
> >
> >   void f2fs_update_read_extent_cache(struct dnode_of_data *dn)
> >   {
> > -     return __update_extent_cache(dn, EX_READ);
> > +     __update_extent_cache(dn, EX_READ);
>
> Above change is not related to this patch?
>
> Otherwise, it looks good to me.
>
> Thanks,
Dear Chao,

Okay, I see that both functions here are void type, so there is no
need to use return^^.
I will remove this part and update.

By the way, I did a stability test on this patch and the result passed
thanks!

>
> >   }
> >
> >   void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4836e7c..7beb074 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3700,10 +3700,10 @@ void f2fs_clear_prefree_segments(struct f2fs_sb=
_info *sbi,
> >   void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
> >   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_=
ra);
> >   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
> > -void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > +int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> > +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int typ=
e,
> >                                       unsigned int start, unsigned int =
end);
> >   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, boo=
l force);
> >   int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index ca1bf41..8852814 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -2035,8 +2035,11 @@ static int free_segment_range(struct f2fs_sb_inf=
o *sbi,
> >       mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> >
> >       /* Move out cursegs from the target range */
> > -     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++)
> > -             f2fs_allocate_segment_for_resize(sbi, type, start, end);
> > +     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++) {
> > +             err =3D f2fs_allocate_segment_for_resize(sbi, type, start=
, end);
> > +             if (err)
> > +                     goto out;
> > +     }
> >
> >       /* do GC to move out valid blocks in the range */
> >       err =3D f2fs_gc_range(sbi, start, end, dry_run, 0);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 4e4a51a..c1c1308 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2863,7 +2863,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_in=
fo *sbi, int segno)
> >    * This function always allocates a used segment(from dirty seglist) =
by SSR
> >    * manner, so it should recover the existing segment information of v=
alid blocks
> >    */
> > -static void change_curseg(struct f2fs_sb_info *sbi, int type)
> > +static int change_curseg(struct f2fs_sb_info *sbi, int type)
> >   {
> >       struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> > @@ -2888,21 +2888,23 @@ static void change_curseg(struct f2fs_sb_info *=
sbi, int type)
> >       if (IS_ERR(sum_page)) {
> >               /* GC won't be able to use stale summary pages by cp_erro=
r */
> >               memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
> > -             return;
> > +             return PTR_ERR(sum_page);
> >       }
> >       sum_node =3D (struct f2fs_summary_block *)page_address(sum_page);
> >       memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
> >       f2fs_put_page(sum_page, 1);
> > +     return 0;
> >   }
> >
> >   static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
> >                               int alloc_mode, unsigned long long age);
> >
> > -static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
> > +static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
> >                                       int target_type, int alloc_mode,
> >                                       unsigned long long age)
> >   {
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> > +     int ret =3D 0;
> >
> >       curseg->seg_type =3D target_type;
> >
> > @@ -2910,38 +2912,41 @@ static void get_atssr_segment(struct f2fs_sb_in=
fo *sbi, int type,
> >               struct seg_entry *se =3D get_seg_entry(sbi, curseg->next_=
segno);
> >
> >               curseg->seg_type =3D se->type;
> > -             change_curseg(sbi, type);
> > +             ret =3D change_curseg(sbi, type);
> >       } else {
> >               /* allocate cold segment by default */
> >               curseg->seg_type =3D CURSEG_COLD_DATA;
> > -             new_curseg(sbi, type, true);
> > +             ret =3D new_curseg(sbi, type, true);
> >       }
> >       stat_inc_seg_type(sbi, curseg);
> > +     return ret;
> >   }
> >
> > -static void __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> > +static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >   {
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC=
);
> > +     int ret =3D 0;
> >
> >       if (!sbi->am.atgc_enabled)
> > -             return;
> > +             return 0;
> >
> >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >
> >       mutex_lock(&curseg->curseg_mutex);
> >       down_write(&SIT_I(sbi)->sentry_lock);
> >
> > -     get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC, CURSEG_COLD_DATA, SS=
R, 0);
> > +     ret =3D get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC,
> > +                                     CURSEG_COLD_DATA, SSR, 0);
> >
> >       up_write(&SIT_I(sbi)->sentry_lock);
> >       mutex_unlock(&curseg->curseg_mutex);
> >
> >       f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > -
> > +     return ret;
> >   }
> > -void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> > +int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >   {
> > -     __f2fs_init_atgc_curseg(sbi);
> > +     return __f2fs_init_atgc_curseg(sbi);
> >   }
> >
> >   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int ty=
pe)
> > @@ -3069,11 +3074,12 @@ static bool need_new_seg(struct f2fs_sb_info *s=
bi, int type)
> >       return false;
> >   }
> >
> > -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> > +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int typ=
e,
> >                                       unsigned int start, unsigned int =
end)
> >   {
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> >       unsigned int segno;
> > +     int ret =3D 0;
> >
> >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >       mutex_lock(&curseg->curseg_mutex);
> > @@ -3084,9 +3090,9 @@ void f2fs_allocate_segment_for_resize(struct f2fs=
_sb_info *sbi, int type,
> >               goto unlock;
> >
> >       if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
> > -             change_curseg(sbi, type);
> > +             ret =3D change_curseg(sbi, type);
> >       else
> > -             new_curseg(sbi, type, true);
> > +             ret =3D new_curseg(sbi, type, true);
> >
> >       stat_inc_seg_type(sbi, curseg);
> >
> > @@ -3100,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs=
_sb_info *sbi, int type,
> >
> >       mutex_unlock(&curseg->curseg_mutex);
> >       f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > +     return ret;
> >   }
> >
> >   static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
> > @@ -3486,14 +3493,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_inf=
o *sbi, struct page *page,
> >       bool from_gc =3D (type =3D=3D CURSEG_ALL_DATA_ATGC);
> >       struct seg_entry *se =3D NULL;
> >       bool segment_full =3D false;
> > +     int ret =3D 0;
> >
> >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >
> >       mutex_lock(&curseg->curseg_mutex);
> >       down_write(&sit_i->sentry_lock);
> >
> > -     if (curseg->segno =3D=3D NULL_SEGNO)
> > +     if (curseg->segno =3D=3D NULL_SEGNO) {
> > +             ret =3D -ENOSPC;
> >               goto out_err;
> > +     }
> >
> >       if (from_gc) {
> >               f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) =3D=3D NULL_=
SEGNO);
> > @@ -3546,17 +3556,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_inf=
o *sbi, struct page *page,
> >               }
> >
> >               if (from_gc) {
> > -                     get_atssr_segment(sbi, type, se->type,
> > +                     ret =3D get_atssr_segment(sbi, type, se->type,
> >                                               AT_SSR, se->mtime);
> >               } else {
> >                       if (need_new_seg(sbi, type))
> > -                             new_curseg(sbi, type, false);
> > +                             ret =3D new_curseg(sbi, type, false);
> >                       else
> > -                             change_curseg(sbi, type);
> > +                             ret =3D change_curseg(sbi, type);
> >                       stat_inc_seg_type(sbi, curseg);
> >               }
> >
> > -             if (curseg->segno =3D=3D NULL_SEGNO)
> > +             if (ret)
> >                       goto out_err;
> >       }
> >
> > @@ -3599,7 +3609,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info =
*sbi, struct page *page,
> >       up_write(&sit_i->sentry_lock);
> >       mutex_unlock(&curseg->curseg_mutex);
> >       f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > -     return -ENOSPC;
> > +     return ret;
> >
> >   }
> >
> > @@ -3829,7 +3839,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *s=
bi, struct f2fs_summary *sum,
> >       /* change the current segment */
> >       if (segno !=3D curseg->segno) {
> >               curseg->next_segno =3D segno;
> > -             change_curseg(sbi, type);
> > +             if (change_curseg(sbi, type))
> > +                     goto out_unlock;
> >       }
> >
> >       curseg->next_blkoff =3D GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
> > @@ -3855,12 +3866,14 @@ void f2fs_do_replace_block(struct f2fs_sb_info =
*sbi, struct f2fs_summary *sum,
> >       if (recover_curseg) {
> >               if (old_cursegno !=3D curseg->segno) {
> >                       curseg->next_segno =3D old_cursegno;
> > -                     change_curseg(sbi, type);
> > +                     if (change_curseg(sbi, type))
> > +                             goto out_unlock;
> >               }
> >               curseg->next_blkoff =3D old_blkoff;
> >               curseg->alloc_type =3D old_alloc_type;
> >       }
> >
> > +out_unlock:
> >       up_write(&sit_i->sentry_lock);
> >       mutex_unlock(&curseg->curseg_mutex);
> >       f2fs_up_write(&SM_I(sbi)->curseg_lock);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 78a7658..f2b6d3f 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4685,7 +4685,9 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
> >       if (err)
> >               goto free_meta;
> >
> > -     f2fs_init_inmem_curseg(sbi);
> > +     err =3D f2fs_init_inmem_curseg(sbi);
> > +     if (err)
> > +             goto sync_free_meta;
> >
> >       /* f2fs_recover_fsync_data() cleared this already */
> >       clear_sbi_flag(sbi, SBI_POR_DOING);

