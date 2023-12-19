Return-Path: <linux-kernel+bounces-4824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FF818284
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E77283A14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397FC8E0;
	Tue, 19 Dec 2023 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf8oR7ve"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D6C2D5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F455C433C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702971928;
	bh=0yhIdF83SvlKvcfOUfED/VuBoVXBPBniiBY53TSs5gg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=sf8oR7vePGTdtownyILtuwUS4XfLMtP1M5f7ZnIMdhoW4QXNs0qr3ZFCJOahl11XW
	 zzGn8L6A8wsQsDo6nY3AfxlClcMUrXmFDxdboAGVt9reG8ITrwRGlABJFTIJ1OTJw0
	 8qk4cw+QEgDc+juFQ7yOqqCx/z4MrcupxQlATnFamZvMtv4UpeZadi6CmbvKE1GOLM
	 YuqsFRI1jlO+rK4eIcXrcBSUmq/KRxrPh5laptKBlUK75n+FLMva8hoBf9KRcMAx2H
	 gpcDE5HaPQrnmQZ2RkAW3XdVQskiKj1EN05gHaJA442vnouzsapq1ThKrCMTULxxN+
	 6fLgMbJhjp75A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1721425fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:45:28 -0800 (PST)
X-Gm-Message-State: AOJu0YwDQWvCX8q44f6FVkr1dAv+imMjmifSBHSAjLrTuHphEBP1Zn4p
	oT7PfVYPmqE4GhcLeG6pq8CASAM/zZK4zcodYBE=
X-Google-Smtp-Source: AGHT+IGWpMyZrzsgBFQEmfedcmWbX0ZdkN9kKdn/VbDYin9z3hpoShCxhCTp12i6DjZX6ZVX20X1S3HoloE9iyRAQRE=
X-Received: by 2002:a05:6871:70b:b0:203:4ca1:ba1e with SMTP id
 f11-20020a056871070b00b002034ca1ba1emr247540oap.36.1702971922691; Mon, 18 Dec
 2023 23:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:746:0:b0:507:5de0:116e with HTTP; Mon, 18 Dec 2023
 23:45:21 -0800 (PST)
In-Reply-To: <20231219045414.24670-1-rdunlap@infradead.org>
References: <20231219045414.24670-1-rdunlap@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 Dec 2023 16:45:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_n+bQfD-249T59+EASZU1zHVSP7ukVDMyiebXWEv5AbA@mail.gmail.com>
Message-ID: <CAKYAXd_n+bQfD-249T59+EASZU1zHVSP7ukVDMyiebXWEv5AbA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: dir.c: fix kernel-doc function parameter warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Anton Altaparmakov <anton@tuxera.com>, 
	linux-ntfs-dev@lists.sourceforge.net, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-19 13:54 GMT+09:00, Randy Dunlap <rdunlap@infradead.org>:
> Correct the kernel-doc function parameter warnings for function
> ntfs_dir_fsync() to prevent the following kernel-doc warnings:
>
> dir.c:1489: warning: Function parameter or member 'start' not described in
> 'ntfs_dir_fsync'
> dir.c:1489: warning: Function parameter or member 'end' not described in
> 'ntfs_dir_fsync'
> dir.c:1489: warning: Excess function parameter 'dentry' description in
> 'ntfs_dir_fsync'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: linux-ntfs-dev@lists.sourceforge.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
As you may already know, the same warning is probably coming from
ntfs_file_fsync() in file.c.
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
> ---
>  fs/ntfs/dir.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff -- a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -1462,7 +1462,8 @@ static int ntfs_dir_open(struct inode *v
>  /**
>   * ntfs_dir_fsync - sync a directory to disk
>   * @filp:	directory to be synced
> - * @dentry:	dentry describing the directory to sync
> + * @start:	offset in bytes of the beginning of data range to sync
> + * @end:	offset in bytes of the end of data range (inclusive)
>   * @datasync:	if non-zero only flush user data and not metadata
>   *
>   * Data integrity sync of a directory to disk.  Used for fsync, fdatasync,
> and
>

