Return-Path: <linux-kernel+bounces-101694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD587AA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76007B23E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2747A64;
	Wed, 13 Mar 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TooCd4A5"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED446535;
	Wed, 13 Mar 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344778; cv=none; b=gj5KGKSoe0BqQwC72tvYmF5Pdx6T1H+9bYOUncXfdmxdpNy1B+BtoBZRBs29DWIn5eQWZTXuSnCfk7+Ssi/vYACQZKyb8BfVrA6vc/3ORtWYQazdGXBkk1KJT3oM2CKz8+SFbOHW7uDOErtU4/tRFf/Y9ubHTi3NRoYlu0/qyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344778; c=relaxed/simple;
	bh=Fs3Y+T1dpjuEOnokFWEWbaWzxLPxHzpZWkjD905nFkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ7HmND+w9NoVmQdH5XXX/B5HkXWY3DhAkf2t6kRDBaX9DcF8JzGj6ftCcrsjwx6UNF2tc4ChviGcu5AlLtFBHVV8LrFqwtl2QIjtjgvKsWY3NBPfRetDEcnqFg8+eR0qsauS1qnbxfL+j5vP6jUXNMGWawqZE2oFvTHA8780BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TooCd4A5; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7dc1d027ca8so576707241.2;
        Wed, 13 Mar 2024 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710344776; x=1710949576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGwxmqFwO1mvnSpSmoipMpLxUDWbyvTiCSsDIpsLb+c=;
        b=TooCd4A5hq0BhfpIfYH9q49cMFZ4bEg9jw15weetMx9eccHCK2JCtnCkY3qcsCCTt2
         Co5KdQJa0T4nrLtTIsF83uuNZKDFp1KZketsep8talOZW0K29cAwWf4YUMaeyBo1PVpR
         QX5J0nj130h6pv5S87nICSCBTSl38Gb3GSEm+Q4mkFp7+pCUVL6al8s9e+ZZELNd2ILT
         Lch9GbDS6lDDdA6L76zF3pd69LhjkypalmE4DRYk+DK0BlUhj/l4ptG/llhkfyoebL2L
         ZzSrn6Z/Hi7q+KkHrQwWBWmFiOdVBZKDnwIdp3+ICEwSu7mVg2p44+PbqivvhpTvjhA1
         8X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344776; x=1710949576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGwxmqFwO1mvnSpSmoipMpLxUDWbyvTiCSsDIpsLb+c=;
        b=tIzAH8/Sj7Or2EtHEyQhtrD8wCxOZp6LTutFkO5ORJQ6yY6EVNpoxgU18hRjaw07Qc
         hdHfb4wEFCIcNFBLhT/fg1MWk5z3FrJrtocwoWhnH6CPtBeYf5fiARF285tIi3J4FiYU
         x+3eOQzQ6Go+4EkIq/V8mAFN/89hjVvV7Sd1QNxcklrKaGw9GGnpT9iG3Y39BaOHRSGg
         Qu/pXVBx7thlOBX2PEp9N5QcXX46GYjvdZEbHx6ExXvLGa5dCH/UtRExrNaZhDu3mx7i
         BYaJZDAV7L/rsVcs8nY8jroqQnEPtchBYAHfSiVMNBA2ZT6rJhqmDRx4TVBWBasf08+X
         0Qng==
X-Forwarded-Encrypted: i=1; AJvYcCVAVf1KFLNV54T+0HUGE+8i8lN+RAXPpqeb4J3PHMHy1YEX0ubItwUyX7tXATUP7m6c+VtjEHREaltThPfpCgGkHxUszGAvalIlSY85iIqEDp+OfwK16xIcAVJxzl+20akS+Ys8
X-Gm-Message-State: AOJu0Yzo8DEhEp175hXVp4pRZq+yLaByPB6CLwYZs3TWHgFwUfjBt5QC
	5JGJcnL/P3/3VhrQJ+B5YJdgsIBwWVvXeXSKlZ4BNxoM8rbomPTzMbnxVP5PcHCFu8oj47CUycM
	xw/uHuZKna6Rrq4Boit029Vg6OOA=
X-Google-Smtp-Source: AGHT+IF0sJ3VgTNC/pkl0UrGOsYQkAjEU0lUMb93ytZfaLzDn9zGQlZtaMC1E/aWH2b9zLlfMYC0kUj2hz7Vv/wwYho=
X-Received: by 2002:a67:f8cd:0:b0:474:5f25:58a3 with SMTP id
 c13-20020a67f8cd000000b004745f2558a3mr218263vsp.19.1710344776177; Wed, 13 Mar
 2024 08:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28@epcas1p3.samsung.com>
 <20240313112620.1061463-1-s_min.jeong@samsung.com>
In-Reply-To: <20240313112620.1061463-1-s_min.jeong@samsung.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 13 Mar 2024 08:46:04 -0700
Message-ID: <CACOAw_xeAmGXt_ZZ=6wC1mKmpo+R-a8KaNUVvXYQPa3rCpqQYw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: mark inode dirty for
 FI_ATOMIC_COMMITTED flag
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Mar 13, 2024 at 4:37=E2=80=AFAM Sunmin Jeong <s_min.jeong@samsung.c=
om> wrote:
>
> In f2fs_update_inode, i_size of the atomic file isn't updated until
> FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
> after the writeback of the inode, i_size of the raw inode will not be
> updated. It can cause the atomicity corruption due to a mismatch between
> old file size and new data.
>
> To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED
>
> Atomic write thread                   Writeback thread
>                                         __writeback_single_inode
>                                           write_inode
>                                             f2fs_update_inode
>                                               - skip i_size update
>   f2fs_ioc_commit_atomic_write
>     f2fs_commit_atomic_write
>       set_inode_flag(inode, FI_ATOMIC_COMMITTED)
>     f2fs_do_sync_file
>       f2fs_fsync_node_pages
>         - skip f2fs_update_inode since the inode is clean
>
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>  fs/f2fs/f2fs.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 543898482f8b..a000cb024dbe 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3039,6 +3039,7 @@ static inline void __mark_inode_dirty_flag(struct i=
node *inode,
>         case FI_INLINE_DOTS:
>         case FI_PIN_FILE:
>         case FI_COMPRESS_RELEASED:
> +       case FI_ATOMIC_COMMITTED:
>                 f2fs_mark_inode_dirty_sync(inode, true);
>         }
>  }
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

