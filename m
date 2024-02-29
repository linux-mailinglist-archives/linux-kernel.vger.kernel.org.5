Return-Path: <linux-kernel+bounces-87223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44186D14A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D444B1F25BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C563C460;
	Thu, 29 Feb 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Qe5OyE"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84B16063E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229536; cv=none; b=LxiJUpBamJ4txb0UoC5GmAfBNomUD03W0apgsvYBY6ymuFLylD5HTKFRWJ/1Wyyg90OYUHhRZ7u9ZRmi1ZzuwR3/SjAta1SO2cpDZX2r2QpQlKdIPxpCW+dkvtAnuCcpjLcClU58RM8sD++bZfcTMrMqzuotjUmARhrsI0KrjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229536; c=relaxed/simple;
	bh=dAkN5nx3ELejm9KAgl5dlkP/kYHieFw5OJ8MYAf+PBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxpWNzbZKKtQAbBpvjd4fxIu3+aIP2enYT5J7XhrExZ/GMigIaEmpgmaM+QHv/swBmT96m/ovkLPbZSKMnqjX/WVVTveW78I4rfYuSK+LMueQVTsulakK2BZJxa8L9+BNcUTdo/qybrKkxWPYFu/uQYHh+Z7n5Dah1veSynriUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Qe5OyE; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7dad8437347so492483241.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709229534; x=1709834334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzIXC93M4QSZLUGOvxdd7AD7/8w/GqyAU4gK+DPYWBY=;
        b=g6Qe5OyEk7iXqLTl0Isx+uxjXW5KcEgJ3HyPpIyE/1ikc/8lB5N03vbbfiuLuduOWd
         UfNhOS49oK0/KlFyP35RmK3hsl+CEcL2I5bN6XPnp1sQDmJVId2LDVB9OoMtyEtl77K2
         nTWPj1k5K4rQlXu62el0gh4cUp3LrKKm5aUaMoiVJq8C8lRtoHFc4SWjBnStHydp4OfS
         zbpPjH5ZuE7iwgRDAxGfHklCvSJ4zkefCQdS4ZEZQHMnejPjIvsH3ncgRRJCrSgqzm4i
         w//Hg0Ayh9AKLrTQlR/OVLJ/Ugkf7JUwZGvcmEqYCV8LBcWcFu7BQoX5ScThQY6MJF/u
         b5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229534; x=1709834334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzIXC93M4QSZLUGOvxdd7AD7/8w/GqyAU4gK+DPYWBY=;
        b=GdfPREArrFcLzT5obh5/7kihSf0N+KQtdGqnGe1KxdRwupMeshnSoesBVuh8sZRJo9
         S38TIl3N8lCq11N4Hgtvr3x+hNEbHCEAgFM8ovYU0MlfqqCKoadbYNFX1572CnlxKqjk
         0rwNjb0JZk7RtEOdCagEkk72l1SaEiakXXV02589mCV/cRRGgFW3ZjjxcJNvSmH5YrcB
         sp4KIajEo4ReicffpLj4HVwImzjZcw9rdpnfsdEHLp2ucFuksz9M96RffNU3JzCdfvLH
         dhA8+xOmIjcudv/1H7JIGCT23ciGEXjGBW5+zONCo61jvxwDOOXpvE5JF8P1bsp/ZXu0
         sTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwGQZ/6nAqpuanWt4IHqDlRwhRJbOwglzhjbXG1frPGtMXB2FuYrTK96kMCez5qeDpLNxsyAb4s3nexODKQT7IYm0uiuxxjsgYrn5d
X-Gm-Message-State: AOJu0Ywun/lM8c1TTYJ2PlMn9DwIMdPeFhwKhVxV3GGNfm76izdW//oa
	6W1lNurbUjxm87YGmOX6WqyYLeWrza+6I/qDTwT3loej3GvHJIYdR8Plk15OLrWoMQKksLwvxZK
	lNQ3pTYHMcDc9/L+D8qL5m9yeqJ8=
X-Google-Smtp-Source: AGHT+IE+bklgMnSPBe75G1/kO6+0yrz8rklNofbjQi5tPjR1OFixJxMWemrObfo7sk5fPyKHmWzuhtlqpJfLdSjovXE=
X-Received: by 2002:a05:6102:3093:b0:472:6e7f:888b with SMTP id
 l19-20020a056102309300b004726e7f888bmr2722097vsb.32.1709229534095; Thu, 29
 Feb 2024 09:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226013208.2389246-1-chao@kernel.org> <20240226013208.2389246-3-chao@kernel.org>
In-Reply-To: <20240226013208.2389246-3-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 29 Feb 2024 09:58:43 -0800
Message-ID: <CACOAw_xQnfFpvWn18tu-T-m0+P+xxPFxwguG2k8VodvxFd42XA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: clean up new_curseg()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Sun, Feb 25, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> Move f2fs_valid_pinned_area() check logic from new_curseg() to
> get_new_segment(), it can avoid calling __set_free() if it fails
> to find free segment in conventional zone for pinned file.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 847fe0b7f29f..c159b0985596 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2715,12 +2715,19 @@ static int get_new_segment(struct f2fs_sb_info *s=
bi,
>  got_it:
>         /* set it as dirty segment in free segmap */
>         f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
> +
> +       /* no free section in conventional zone */
> +       if (new_sec && pinning &&
> +               !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
> +               ret =3D -EAGAIN;
> +               goto out_unlock;
> +       }
>         __set_inuse(sbi, segno);
>         *newseg =3D segno;
>  out_unlock:
>         spin_unlock(&free_i->segmap_lock);
>
> -       if (ret) {
> +       if (ret =3D=3D -ENOSPC) {
>                 f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMEN=
T);
>                 f2fs_bug_on(sbi, 1);
>         }
> @@ -2796,19 +2803,17 @@ static int new_curseg(struct f2fs_sb_info *sbi, i=
nt type, bool new_sec)
>         struct curseg_info *curseg =3D CURSEG_I(sbi, type);
>         unsigned int segno =3D curseg->segno;
>         bool pinning =3D type =3D=3D CURSEG_COLD_DATA_PINNED;
> +       int ret;
>
>         if (curseg->inited)
>                 write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, s=
egno));
>
>         segno =3D __get_next_segno(sbi, type);
> -       if (get_new_segment(sbi, &segno, new_sec, pinning)) {
> -               curseg->segno =3D NULL_SEGNO;
> -               return -ENOSPC;
> -       }
> -       if (new_sec && pinning &&
> -           !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
> -               __set_free(sbi, segno);
> -               return -EAGAIN;
> +       ret =3D get_new_segment(sbi, &segno, new_sec, pinning);
> +       if (ret) {
> +               if (ret =3D=3D -ENOSPC)
> +                       curseg->segno =3D NULL_SEGNO;
> +               return ret;
>         }
>
>         curseg->next_segno =3D segno;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

