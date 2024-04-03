Return-Path: <linux-kernel+bounces-129026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA47F89635C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF368B23E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3FC43AB4;
	Wed,  3 Apr 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5cOOgqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8D5235;
	Wed,  3 Apr 2024 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712117461; cv=none; b=cjmCKAAwAq5ytihICiHlSslOFYLKnAOVz4KiXiR58ey0kG8KVN7tMiUvBwDU/vy80/NzwJY9nBFIBJBPY7cYWzujQs3mf6dHIQ6r39faMJGO7/m8m2Qp+W2/QgIVD5ln/8ppYL3n3TbkM37tre5OIxLnwbORntSQE3JtjWzHYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712117461; c=relaxed/simple;
	bh=H45nGWOPuI7LoZ/AO3xadw9naJQhXiS9zxu8lyEyAGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK6AfZZByPIaEWYhnvS+50h4p6GFClencI2OnWHFYlcmHey0kT1FBZ9JMo6PEWLpDRc3pwC60Co+p05vb0NO5AgfBBNjq4OvE+tlRO5AiCd51dccgyb/xRZLIojAUQR+l5cJRlS+cM2KnhFHNfWM8HffaGf3tuOV1E70PiZC8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5cOOgqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE4EC433C7;
	Wed,  3 Apr 2024 04:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712117461;
	bh=H45nGWOPuI7LoZ/AO3xadw9naJQhXiS9zxu8lyEyAGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5cOOgqzeZTVhgi+J8oKU2tClKmR5x98VGD13CodzcshhKAaajlI32qkosA+Zvo+0
	 hjYwnbZHxBKvvnzlpyLYZulzfkFXUAObJET/dzoBoYlgkJdA9UXtHuszyaIRqH73F3
	 lbp51pNxqD9mzo9KzhGDbZkQMtJZOXrNu3E0ytM7tpsfpnv2vT2O6SecPElxfsjvto
	 IcYIOOr3o6MTH3Z4kJsAb0oZG4Rlup22z9dIiUE2U0UcN56FTaOAp1cYhXaTjtTKoq
	 JeWjmfkmZ0/HKejqEt+tE8N9lFz81xpMmjMygCnh1wI9SHYbvJx0od8wHqX7VA00g3
	 PENqr2YBcIh7A==
Date: Tue, 2 Apr 2024 21:11:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: cleanup deprecated uses of strncpy
Message-ID: <20240403041100.GQ6390@frogsfrogsfrogs>
References: <20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com>

On Mon, Apr 01, 2024 at 11:01:38PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> In xfs_ioctl.c:
> The current code has taken care NUL-termination by memset()'ing @label.
> This is followed by a strncpy() to perform the string copy.
> 
> Use strscpy_pad() to get both 1) NUL-termination and 2) NUL-padding
> which may be needed as this is copied out to userspace.
> 
> Note that this patch uses the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> In xfs_xattr.c:
> There's a lot of manual memory management to get a prefix and name into
> a string. Let's use an easier to understand and more robust interface in
> scnprintf() to accomplish the same task.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.

fstested would be better. ;)

Anyway I guess that looks ok so let's find out:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Found with: $ rg "strncpy\("
> ---
>  fs/xfs/xfs_ioctl.c | 4 +---
>  fs/xfs/xfs_xattr.c | 6 +-----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d0e2cec6210d..abef9707a433 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1755,10 +1755,8 @@ xfs_ioc_getlabel(
>  	/* Paranoia */
>  	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
>  
> -	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
> -	memset(label, 0, sizeof(label));
>  	spin_lock(&mp->m_sb_lock);
> -	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
> +	strscpy_pad(label, sbp->sb_fname);
>  	spin_unlock(&mp->m_sb_lock);
>  
>  	if (copy_to_user(user_label, label, sizeof(label)))
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 364104e1b38a..b9256988830f 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -220,11 +220,7 @@ __xfs_xattr_put_listent(
>  		return;
>  	}
>  	offset = context->buffer + context->count;
> -	memcpy(offset, prefix, prefix_len);
> -	offset += prefix_len;
> -	strncpy(offset, (char *)name, namelen);			/* real name */
> -	offset += namelen;
> -	*offset = '\0';
> +	scnprintf(offset, prefix_len + namelen + 1, "%s%s", prefix, name);
>  
>  compute_size:
>  	context->count += prefix_len + namelen + 1;
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240401-strncpy-fs-xfs-xfs_ioctl-c-8af7a895bff0
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

