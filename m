Return-Path: <linux-kernel+bounces-130508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953A89790E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B928B266EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4E15539A;
	Wed,  3 Apr 2024 19:34:32 +0000 (UTC)
Received: from sxb1plsmtpa01-01.prod.sxb1.secureserver.net (sxb1plsmtpa01-01.prod.sxb1.secureserver.net [188.121.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561115530E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172871; cv=none; b=cCUF8kiTaclFJ0oj8D5Yxznsl5PnZB8WMCet06zECs1+lvb87jfDK0nMr0KMOt9pKq6tBh+pV5Y680j+XdwM5c1uOx++5Je8f/R4d2Z+I6a7CsqsUnFVaZ2SaKXzpdYE510RuekOkubSMN879WK53jb4kmCamuJtlPy+zoHmRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172871; c=relaxed/simple;
	bh=Gra+M5CB4uOQynVC1KnQiQy8k+PPo+HZFGgQ020BswM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw048jJORJFTgVUnsPGxdyi86Sz83CuStoVzdQiX9eK/swYGma9Un5YOCNQyyjEp9JInwDuO2DwrzJ+7Lr94KPtU5C3daE8k8qqKSbxayLJLDxdEYhmJSQW9mpAT5WCAH3aMF+GrI9kB3meaBVwi0nWiB616M7QH2SmogjXtGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id s6L2rzWS7NGvls6L4rKxRo; Wed, 03 Apr 2024 12:32:03 -0700
X-CMAE-Analysis: v=2.4 cv=b5F54cGx c=1 sm=1 tr=0 ts=660daeb4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=FXvPX3liAAAA:8 a=NEAV23lmAAAA:8
 a=xNf9USuDAAAA:8 a=1XWaLZrsAAAA:8 a=U6Lr9aP-yIEcLLY-FxMA:9 a=QEXdDO2ut3YA:10
 a=1F1461vogZIA:10 a=wSuxAcp8fc4A:10 a=5kKzt1m56AEA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=SEwjQc04WA-l_NiBhQ7s:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
Date: Wed, 3 Apr 2024 20:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJJxit0+HRHsEUq/5aS2mkZDiwx38H+++8a4oMEZ6Huc+oyQckaWaErbke77kwdsmlfnzXmOch6vzOYPQY8XJnCBmTxmRnUEZ3JbR0QwEuqOvW6GQ0HT
 D/wiQojzLZxkhr84Q7jz4fksvWkUfDlNMVux9D1dg6IDRli+Yu0O8RT9YPKz7g/H5pU4QbAPkRgvqIAF8YPGybv7PMsVj4sGHUQ7W6chU6wQ7cg1kqD4ceWU
 NhO9gHJVo1/ZojmK0/y0Ninxvc/cb8EuGFH1v/DwaTqoP4I2BB5bZ3/pD3KJ86a8

On 28/03/2024 21:52, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The previous code took special care of NUL-terminating the destination
> buffer via a manual assignment. As such, there is no bug in the current
> implementation. However, in an effort to rid the kernel of strscpy()
> [2], Let's instead use strscpy() which guarantees this behavior [3]. To
> ensure we can copy the same number of bytes as before, add 1 to the
> length argument provided to strscpy().
> 

Squashfs copies the passed string into a temporary buffer to ensure it
is NUL-terminated.  This however is completely unnecessary as the
string is already NUL-terminated.

A better way to remove the strncpy() is to remove the unnecessary string
copy, which I have done in this patch here:

https://lore.kernel.org/lkml/20240403183352.391308-1-phillip@squashfs.org.uk/T/#u

Phillip

> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html  [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   fs/squashfs/namei.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
> index 11e4539b9eae..6c4704ba8f42 100644
> --- a/fs/squashfs/namei.c
> +++ b/fs/squashfs/namei.c
> @@ -80,8 +80,7 @@ static int get_dir_index_using_name(struct super_block *sb,
>   	}
>   
>   	str = &index->name[SQUASHFS_NAME_LEN + 1];
> -	strncpy(str, name, len);
> -	str[len] = '\0';
> +	strscpy(str, name, len + 1);
>   
>   	for (i = 0; i < i_count; i++) {
>   		err = squashfs_read_metadata(sb, index, &index_start,
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240328-strncpy-fs-squashfs-namei-c-9d01b8975e53
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 


