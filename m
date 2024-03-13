Return-Path: <linux-kernel+bounces-101695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84087AAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11311C231B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ADA481C6;
	Wed, 13 Mar 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmGuABx4"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6339481BE;
	Wed, 13 Mar 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344786; cv=none; b=CZaj1CmzMKdEYUMAM8Si5M+WtIRR2+iM/uyvbrrq/A0jHndozuUpv4hiBLJVOL8cHHDe6sTHQYjup1x7RXr/HGgPC4n9Setqk3txvPRLaAwii2Z2JHaKWCZ7d9r8xEZ0Ik/dDFA7aUtJ+3BWgoMzotsyi3HMvtK9Y9FQwI2SCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344786; c=relaxed/simple;
	bh=kbZTvKIUyKrKVMm68AL0IRPNR5dRypdr5syArylXTQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjDPg4j9JfgcWA/0JsHLFLVTnquFoR5EDt4yp/WzhlSUXibLAVpbyJRxWrYZ5QT05LgLewYuhsQnvhfx7OJtXGLKTFV5FK+JVAXTSpK1AtPK4nCx9V4l9wX6un+u6DrjL8aaqvkogMWzCUYA/OeRYQwTPy7gQFiqoJYBKAR6zeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmGuABx4; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-474cb4bcd3dso480047137.2;
        Wed, 13 Mar 2024 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710344784; x=1710949584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WwWvBD5JICifAC4LRXMA04LWk4FKdSKpZw2yIN4sdE=;
        b=HmGuABx4O/wZG+k/PL/LrQeb2mH3ckkZfUO8aST2cJOP99FOyxTlTm/WufZi7T3W2K
         L9ZL4HDC6tC58In+wHc+KuuHvMghPiWX8dajECeatG3XYtFZtyCtm/kKlMfXtC3IYEsf
         p29ju9YNZdhE8w7Jx8k02gRC5ozzXHl0Gr9ePkRMSvGJN7V+qHHZ7FyWBWu8wtWfPDhh
         B8nxZXnlw1/QKgV+fkauw8tSgNMKU/6T9gf6wAKdCBViZcO16hPWN1Y2/7bVSQtcjvej
         D8nDTDAXYGY498fmgx3T7hKI8zAHhfolTz2qsHsq/dEdTSu+WNbfbblb9dm+vMfmtiG1
         VXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344784; x=1710949584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WwWvBD5JICifAC4LRXMA04LWk4FKdSKpZw2yIN4sdE=;
        b=L7D7YfqhNYhSe/vcd0pc0brkvwb91zAS0gMaHqHc8BkVZX/s/EdHcRMhHPF7KtvchM
         CeiOHAbWB6MrZsxfqyz6SCuZO7JiPPZXpP849C4K+qkqyvcAXRA9xZtoKVSle06h1crX
         Jn3hbw+Crfsn1I3nI2GMTBPXI9LjGD+BMpbtsaeQNkX/LWSnJ/JbuDLucWup/Un0wagf
         zsE7AVW4c3gWzpJ+M5QgJdHPIjWLrK7UYoyQqPxT6+hJp/cM/BwQXlkoJTAAKHP69Ffp
         zWIfCGINs3hxUnMOkugy9jtDk5iWJU9nzxIttPxLV2ddGABEFvm35n8p4Z3QOX/ukAP+
         dKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMN0zNz/sMd41nj9gu1Zcjnr4t5qO7ocP7jw6dLeQBa9QK7ByGEzobv1f1E3kenXgbjworXjgxP4gTzGoMouW1hGIXglab1ffz883yEl54BtQM/xku+CFQE24rij7S545KzhvI
X-Gm-Message-State: AOJu0YykD1HD6uKLekvaujWMXFFmnfxvQ7tRicWGVfJQYjEo8AMxqDW9
	7Wba19IbyfIQ0+Wevxm6e+uMQebKJIi+AE8SM6Sz3MTeQRDdKjpTZ4lh+OM1C5eK3azZB9lu2/d
	xTnFpxAARbmNXIQq5HPEG2mJYc6G6TWiI1SbUM0D+
X-Google-Smtp-Source: AGHT+IFGHRcrxRbJ7IkrOHJ9dEOBwd36JeW/1VRvpXj3t1+JiaWxKzxiSsLNwmCzWmgYo/CJd3XJFKFJb2MzqgPNSmE=
X-Received: by 2002:a05:6102:227a:b0:472:e8a6:ad0 with SMTP id
 v26-20020a056102227a00b00472e8a60ad0mr251000vsd.18.1710344783671; Wed, 13 Mar
 2024 08:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6@epcas1p2.samsung.com>
 <20240313112620.1061463-1-s_min.jeong@samsung.com> <20240313112620.1061463-2-s_min.jeong@samsung.com>
In-Reply-To: <20240313112620.1061463-2-s_min.jeong@samsung.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 13 Mar 2024 08:46:12 -0700
Message-ID: <CACOAw_wvVbJD0cCHXsToQmda7oHm5dLG89e_PeWU4_Hy5ivKCw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: truncate page cache before clearing
 flags when aborting atomic write
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Mar 13, 2024 at 4:29=E2=80=AFAM Sunmin Jeong <s_min.jeong@samsung.c=
om> wrote:
>
> In f2fs_do_write_data_page, FI_ATOMIC_FILE flag selects the target inode
> between the original inode and COW inode. When aborting atomic write and
> writeback occur simultaneously, invalid data can be written to original
> inode if the FI_ATOMIC_FILE flag is cleared meanwhile.
>
> To prevent the problem, let's truncate all pages before clearing the flag
>
> Atomic write thread              Writeback thread
>   f2fs_abort_atomic_write
>     clear_inode_flag(inode, FI_ATOMIC_FILE)
>                                   __writeback_single_inode
>                                     do_writepages
>                                       f2fs_do_write_data_page
>                                         - use dn of original inode
>     truncate_inode_pages_final
>
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>  fs/f2fs/segment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7901ede58113..7e47b8054413 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -192,6 +192,9 @@ void f2fs_abort_atomic_write(struct inode *inode, boo=
l clean)
>         if (!f2fs_is_atomic_file(inode))
>                 return;
>
> +       if (clean)
> +               truncate_inode_pages_final(inode->i_mapping);
> +
>         release_atomic_write_cnt(inode);
>         clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
>         clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> @@ -201,7 +204,6 @@ void f2fs_abort_atomic_write(struct inode *inode, boo=
l clean)
>         F2FS_I(inode)->atomic_write_task =3D NULL;
>
>         if (clean) {
> -               truncate_inode_pages_final(inode->i_mapping);
>                 f2fs_i_size_write(inode, fi->original_i_size);
>                 fi->original_i_size =3D 0;
>         }
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

