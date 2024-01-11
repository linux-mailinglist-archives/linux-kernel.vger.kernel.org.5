Return-Path: <linux-kernel+bounces-22921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1682A57B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63141C23048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552CEC8;
	Thu, 11 Jan 2024 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO4Aqbrd"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF5EA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598a32d05ffso460963eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704935892; x=1705540692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHtMusYzsiQkjwSqtRZvJBvHhlKunDRXowWcJK81xTQ=;
        b=XO4AqbrdJYVUV0hTb7FimrImSxweBpfIz4E2NqC8QwTa/p8CrsTRcra20nTSEevUDp
         c3mSqZG28OhD8DG9+gvaianwDarfrTmx92T/1CqA87vdfbldN+iT9qM3RENSHHXhHX5U
         d7QbZKA3ZI39JVmygWhq50OWIZLce+v8hQ73mbcP74j/QMKdCH01opbDUSPPOJZOJSQP
         0xNoLPQQzsm55Xqj3gqcwX+IEIBnj+egYhEst9FEQSaj6jgkJaykvDNO0jeKyCXB8E7H
         5w4YGU/eCPxYMqDOpCLgVKAbcdnzkjCH0i337rhg+ZuytbHrauxj6JSiT3zEnifisuQd
         QT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704935892; x=1705540692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHtMusYzsiQkjwSqtRZvJBvHhlKunDRXowWcJK81xTQ=;
        b=u34yUZ07N2ZKcQJli7AyWxITbfTPNLEuJoAYsY5QkAEUlX/vhqCTO/oWdQbG7uuTE/
         JUv59rqsXH2T2+46Qip09rjZDdrkhEnBr9dl3MdXtbQUYky9OYPxJT7pNeoXTexgvNw/
         g51w/jnwG4wX2tSyKI7Pi8C2mPrNCYzju32UMfEf9bIEXJvqRBfGwxK/j26NOJewO9Lk
         CsGnhZqsVktlmbVST7f4hOo65FBKHv8uH4WMPDpqqgQ5B72UAiiCWNcS995jvK9L6Mqn
         TiZLrBvUhGPMsX0duk/Mu8xCl1uLzSuF0DjvKQWaH3ZSHYkaTVZEff45Ie6r4xdOFouO
         +c6Q==
X-Gm-Message-State: AOJu0YwaJN8UfpBkq0B38aJdbseeLgbEamOiAz3DAqpT50+yXPsNZ7DF
	WjQLaeP4nrE5jmaf/GooHB6EGkKM1DS8Uso/nmQiQnDApWtsrnJS
X-Google-Smtp-Source: AGHT+IEvKshnTrh2QgjWN7AOHq0wbwBMsfXT7k0ve+ddB7HaOYLRctzfDG+J09zPwElVyIIuhw9PlE2exOj7I/8Gu9k=
X-Received: by 2002:a05:6808:448c:b0:3bd:4264:32aa with SMTP id
 eq12-20020a056808448c00b003bd426432aamr558283oib.96.1704935892069; Wed, 10
 Jan 2024 17:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org> <20231228143152.1543509-3-chao@kernel.org>
In-Reply-To: <20231228143152.1543509-3-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 10 Jan 2024 17:18:01 -0800
Message-ID: <CACOAw_xCfOtJaC3FbOhvbrEzyUwecdSujFo4-f--dz+33BC+Sg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 3/6] f2fs: compress: fix to check unreleased
 compressed cluster
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> From: Sheng Yong <shengyong@oppo.com>
>
> Compressed cluster may not be released due to we can fail in
> release_compress_blocks(), fix to handle reserved compressed
> cluster correctly in reserve_compress_blocks().
>
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 026d05a7edd8..782ae3be48f6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3624,6 +3624,15 @@ static int reserve_compress_blocks(struct dnode_of=
_data *dn, pgoff_t count)
>                                 goto next;
>                         }
>
> +                       /*
> +                        * compressed cluster was not released due to
> +                        * it fails in release_compress_blocks().
> +                        */
> +                       if (blkaddr =3D=3D NEW_ADDR) {
> +                               compr_blocks++;
> +                               continue;
> +                       }
> +
>                         if (__is_valid_data_blkaddr(blkaddr)) {
>                                 compr_blocks++;
>                                 continue;

How about merging two conditions like "blkaddr =3D=3D NEW_ADDR ||
__is_valid_data_blkaddr(blkaddr)"?

> @@ -3633,6 +3642,9 @@ static int reserve_compress_blocks(struct dnode_of_=
data *dn, pgoff_t count)
>                 }
>
>                 reserved =3D cluster_size - compr_blocks;
> +               if (!reserved)
> +                       goto next;
> +

How can the reserved variable be zero?

>                 ret =3D inc_valid_block_count(sbi, dn->inode, &reserved);
>                 if (ret)
>                         return ret;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

