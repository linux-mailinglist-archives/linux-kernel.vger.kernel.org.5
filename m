Return-Path: <linux-kernel+bounces-25059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631FB82C70B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25A0B23CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2717730;
	Fri, 12 Jan 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWq9gfbW"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A41772D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b71e8790efso1634799e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097732; x=1705702532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZLcBXN1VISPyK9csvDi01+514yu9ykhkUQUMngzxPc=;
        b=LWq9gfbWpdnBml2v1CcITvhS7Njz7l/1gmgRqwG//WNhYjt861bFy+GbkiizHrcIGO
         M04+r8QwsMBnlP9FPJ53A4RIv7t35Xryh3tHcwCup+ci6C4lE3Cb+H03uJsxdVsTWHMi
         R2SHmBNygFMcLkwr+kUHRXZthNeH6PHl1UB6IRS+xRDqSdlvhXrjtQmtz8fBYDU8ugyZ
         owZecSktkBgJti4MRkdoCl1v0Uuwbkv0RUQxFmbpQEIuM+2Q+hIWIQJNYLzC7pBqb8pw
         eLo00yCOC4HPWucvEp9q867qRNg3sjZ7bC6e9P2jIfKWkG4LrAKRIH7kSGkY2sPl1lRq
         lLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097732; x=1705702532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZLcBXN1VISPyK9csvDi01+514yu9ykhkUQUMngzxPc=;
        b=eSJ3mXOeMcb7TyPI7Ng7S1ndSUspBz7WU54JxU5M9Dx1qNvqZhYyqh1LCoJcPLw5mo
         GaMVLYEjOQcNP1yeUkeE+gSIT6/BxYwOThPvGsjTIR4njBzbFYIpqlYI3mMzg/zcdl7f
         hbs+Ylt8yMhZnhW+osL9gZyI+qDteQ4C91wBpUKubtw+sX9UhKtH6EXXFgpRc1wYSBpJ
         NBVzWLAJjxUqZQx1On7pQF2bdOPalKZ1nDXoKFLuoheXd4NGOSfYYn3hG33quMkyOUZI
         S8vhlop2S4owTGMPZGHM0Un2EwnYkf4p8DEmELricAdajadQ0FAni5UXTd8TQ3VYNgeS
         3Arw==
X-Gm-Message-State: AOJu0YxTNz61EfdmEze8cpDWpf57YMh7JAxjgV3eo5l7CLwv+SLMGs2g
	nzhamrVoWizqoqLMECBF9mZJ7lD6WrJ1UfimjjpYdm/oDcKoCw==
X-Google-Smtp-Source: AGHT+IHHuqY0GhkSlzBBxqUM8EnRdHKfLdtdAhi/wUWxG1H3uryUyFZNmTG47dvVCuK3mbQ+YtZIPdv9kUf7SQ229rY=
X-Received: by 2002:a05:6122:4490:b0:4b7:8d7c:3483 with SMTP id
 cz16-20020a056122449000b004b78d7c3483mr1713549vkb.19.1705097732196; Fri, 12
 Jan 2024 14:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111064208.2969599-1-chao@kernel.org> <20240111064208.2969599-2-chao@kernel.org>
In-Reply-To: <20240111064208.2969599-2-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:15:21 -0800
Message-ID: <CACOAw_xnOKPeFQ7u5o17coYkpVepYT8DBQPoi1okuR8VvjfMvg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 2/6] f2fs: compress: fix to cover normal
 cluster write with cp_rwsem
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Jan 10, 2024 at 10:43=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> When we overwrite compressed cluster w/ normal cluster, we should
> not unlock cp_rwsem during f2fs_write_raw_pages(), otherwise data
> will be corrupted if partial blocks were persisted before CP & SPOR,
> due to cluster metadata wasn't updated atomically.
>
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 20 ++++++++++++++------
>  fs/f2fs/data.c     |  3 ++-
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 9940b7886e5d..bf4cfab67aec 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1448,7 +1448,8 @@ static int f2fs_write_raw_pages(struct compress_ctx=
 *cc,
>                                         enum iostat_type io_type)
>  {
>         struct address_space *mapping =3D cc->inode->i_mapping;
> -       int _submitted, compr_blocks, ret, i;
> +       struct f2fs_sb_info *sbi =3D F2FS_M_SB(mapping);
> +       int _submitted, compr_blocks, ret =3D 0, i;
>
>         compr_blocks =3D f2fs_compressed_blocks(cc);
>
> @@ -1463,6 +1464,10 @@ static int f2fs_write_raw_pages(struct compress_ct=
x *cc,
>         if (compr_blocks < 0)
>                 return compr_blocks;
>
> +       /* overwrite compressed cluster w/ normal cluster */
> +       if (compr_blocks > 0)
> +               f2fs_lock_op(sbi);
> +
>         for (i =3D 0; i < cc->cluster_size; i++) {
>                 if (!cc->rpages[i])
>                         continue;
> @@ -1495,26 +1500,29 @@ static int f2fs_write_raw_pages(struct compress_c=
tx *cc,
>                                 unlock_page(cc->rpages[i]);
>                                 ret =3D 0;
>                         } else if (ret =3D=3D -EAGAIN) {
> +                               ret =3D 0;
>                                 /*
>                                  * for quota file, just redirty left page=
s to
>                                  * avoid deadlock caused by cluster updat=
e race
>                                  * from foreground operation.
>                                  */
>                                 if (IS_NOQUOTA(cc->inode))
> -                                       return 0;
> -                               ret =3D 0;
> +                                       goto out;
>                                 f2fs_io_schedule_timeout(DEFAULT_IO_TIMEO=
UT);
>                                 goto retry_write;
>                         }
> -                       return ret;
> +                       goto out;
>                 }
>
>                 *submitted +=3D _submitted;
>         }
>
> -       f2fs_balance_fs(F2FS_M_SB(mapping), true);
> +out:
> +       if (compr_blocks > 0)
> +               f2fs_unlock_op(sbi);
>
> -       return 0;
> +       f2fs_balance_fs(sbi, true);
> +       return ret;
>  }
>
>  int f2fs_write_multi_pages(struct compress_ctx *cc,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 81f9e2cc49e2..b171a9980f6a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2839,7 +2839,7 @@ int f2fs_write_single_data_page(struct page *page, =
int *submitted,
>                 .encrypted_page =3D NULL,
>                 .submitted =3D 0,
>                 .compr_blocks =3D compr_blocks,
> -               .need_lock =3D LOCK_RETRY,
> +               .need_lock =3D compr_blocks ? LOCK_DONE : LOCK_RETRY,
>                 .post_read =3D f2fs_post_read_required(inode) ? 1 : 0,
>                 .io_type =3D io_type,
>                 .io_wbc =3D wbc,
> @@ -2920,6 +2920,7 @@ int f2fs_write_single_data_page(struct page *page, =
int *submitted,
>         if (err =3D=3D -EAGAIN) {
>                 err =3D f2fs_do_write_data_page(&fio);
>                 if (err =3D=3D -EAGAIN) {
> +                       f2fs_bug_on(sbi, compr_blocks);
>                         fio.need_lock =3D LOCK_REQ;
>                         err =3D f2fs_do_write_data_page(&fio);
>                 }
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

