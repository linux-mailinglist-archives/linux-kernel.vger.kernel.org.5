Return-Path: <linux-kernel+bounces-134131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D189ADFF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39481F21B34
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E83D6A;
	Sun,  7 Apr 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCNMCJ8V"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974D1849
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455876; cv=none; b=DT9/7oQ8I5a/Gj6Zzcl43LaPaVidA6ytBJ/AapVnkWMzJxsPktkgXX1f2p/PUXc6sjkFqctFh3exQHnldMINtduv8gwbJWt28K8u4q2/2i6S4SN3xcUNPylB7E+JyyMC2snkQ3FIIYPTMiEWV9GsHN5yOfkZMgx9hP+E29Kd4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455876; c=relaxed/simple;
	bh=U3CIsfS0uapBLtqqgm+UGMPYYIIjXwPDosif4MIcgHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5OqcJ/X2dxwCeCaOK6oTfaTSJ3+vRtuxasAQbb/4GTInUMMqm42VwntGq3Mv+lBL6xY2HwGu2N1AboeJ2AYRSZNAzWnAOXbbo9sBUyUtYyKajE5jwesVbZeik17/DG3mNHjz41cFC0wOg+ISwwEN+UMIG7Zd8zfwvzdh8xPQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCNMCJ8V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3458b699d6cso31456f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712455873; x=1713060673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=;
        b=WCNMCJ8VHJUWq/jLv83A1sSeB8CdTE636mlPk3odUsH22ucFxbiocCXHdUuD+APU4g
         aIbflPCNc8pFynbnhcYKmWtGqqTxUOIe9srQuad1mm7geq5veRKBzH4C9wzrlooQ39hb
         P8GrhbPzEWU9fFClpxcxMOann71J8+9+NpkWEEP4HNNQV5D9S21/sbtZJVvgsbT+ZPU2
         /Dxu0fYHdHirrinYZEp51KcMLcMgTmZuLFsnCD5jjK4ulj5UB1pDLYmai1EPpgmzUid5
         U0Ag3yGOkxE2cZ1zFJImOZ/y5HOO+Kk4TntK9+tRSK/Gbi8k4Pq2EVh7Q/wBV11Ff8FG
         Xiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712455873; x=1713060673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=;
        b=Y4VwYUgfRrCg7jgfZkMJ9crP+V8gEEI4JxjQkornzLiv2dOMNp7HnUH7ekru3fAwkZ
         wGfdacChzYZyc5pUaDL7uBqa2ttXYxCA8MabGxCHiSqYbzJlbZD0Higq+7tpOEsgPSDy
         P95VpUi4nEmB40FfA+eqbbq6ADhs54oY5A60DpeZ7iieCcm4YhThJE1BfzwqHT85ukNm
         pKXxcZsj43vnBKvVTEm1g1MrsSt39bpTfQALMWUG/I5bKIO3Bdm9Pv/rfAybvjfpPfgh
         5Pfx1GgTjW3Mu4ysKpIXVMrTFKTt2jG5WD3wwU2rR0aodLR6cI3BD5DHNKwMwbLs20Sz
         cRgA==
X-Forwarded-Encrypted: i=1; AJvYcCXGAY8L4WKlgIlY5TGL4iNbktliiWQuHbajN4BbKXLaSuwJ7gjsUWTOMZ7Itzpi0rSW7Wu3kDsze5AuzcjKVvOsIsMOR0aog84CtGfF
X-Gm-Message-State: AOJu0YzyYn+kGHGDlho1DcNKl3a50H3F/AEyg2ml0Sl/JKsWPO9tkgN8
	lxatcZ86fmo8aXisKPnUR8rwpPOSwg/xPklXF6rNhIEH+oXVN/uwhCLy0mVa58hH1IpNtcRgs+o
	4JGXXO3xXqRcGRn7miAxJLGT5Xo9kWHrXbCU=
X-Google-Smtp-Source: AGHT+IED4Bbg+uo4kDv4OZPLlWb7h5V+M5g2fKRAH686W10d2St4Vdl1mOPGYwYWHzTAQ2nW7DIrgcpcOT9ED5gpmpA=
X-Received: by 2002:a5d:51c2:0:b0:341:e4f4:4399 with SMTP id
 n2-20020a5d51c2000000b00341e4f44399mr3912457wrv.68.1712455873210; Sat, 06 Apr
 2024 19:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403142420.2042498-1-chao@kernel.org>
In-Reply-To: <20240403142420.2042498-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Sun, 7 Apr 2024 10:11:02 +0800
Message-ID: <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in f2fs_fallocate()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> compress and pinfile flag should be checked after inode lock held to
> avoid race condition, fix it.
>
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned fil=
e")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 148bfe3effdf..83a807e25e31 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1820,15 +1820,6 @@ static long f2fs_fallocate(struct file *file, int =
mode,
>                 (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANG=
E)))
>                 return -EOPNOTSUPP;
>
> -       /*
> -        * Pinned file should not support partial truncation since the bl=
ock
> -        * can be used by applications.
> -        */
> -       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &=
&
> -               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE =
|
> -                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
> -               return -EOPNOTSUPP;
> -
>         if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>                         FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>                         FALLOC_FL_INSERT_RANGE))
> @@ -1836,6 +1827,17 @@ static long f2fs_fallocate(struct file *file, int =
mode,
>
>         inode_lock(inode);
>
> +       /*
> +        * Pinned file should not support partial truncation since the bl=
ock
> +        * can be used by applications.
> +        */
> +       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &=
&
> +               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE =
|
> +                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) =
{
> +               ret =3D -EOPNOTSUPP;
> +               goto out;
> +       }
> +
Dear Chao,
I see  the judgment code "if(!f2fs_compressed_file(inode))" also is
before inode_lock in functions
f2fs_ioc_decompress_file/f2fs_ioc_compress_file/f2fs_reserve_compress_block=
s/f2fs_release_compress_blocks.
should they are changed together?
thanks=EF=BC=81
>         ret =3D file_modified(file);
>         if (ret)
>                 goto out;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

