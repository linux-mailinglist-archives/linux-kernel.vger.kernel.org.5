Return-Path: <linux-kernel+bounces-61033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F1850C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13C2B21C98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC651388;
	Mon, 12 Feb 2024 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uEf+bQOG"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60193A47
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707698205; cv=none; b=MTfvycVOqX3E1Pa4XwwfwS23rHD+zE5spy5aijv/a/kOCq1b50FRNQuRde9+JxsrfVw4Fg1OZmBN2H7qDmNGJUk+ly4iDsKB7EAHuEQp9Lmx9S8/VYYIkJcKTnf5TQ+BalLRYhTEAJDSPej0jvbLrUSUVA/OsnQr1OuZJIBWeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707698205; c=relaxed/simple;
	bh=g649aErR/2B0RxY+2/m+NkPBYwEtXoTNpmSXe9Zerqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzOqGdIkV9XJxgZdSnWRlaI0PcNOh0TPeX5XlmI42IkZWgCALvzV0za0ys6XCizUvm2fnuclErdGc4ZdRmUoMyS6H6F19YLyGfZivuMDkIe98wJ4+WBMI6m6jkclRMk4aRFXUtnztKNL0+vcfua0pR5gRwS3W4/vu5dGo0iLpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uEf+bQOG; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 11 Feb 2024 19:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707698200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kxCWW4/t2o4u58TNsbaiigtWHWeIl8inY0YU8ADFLOA=;
	b=uEf+bQOGQH2hry9IKEdbIU1wp7u9xQ5M2nWnAPZtDcsVdc/5fhFaovF0JN4hukFASQ46e5
	b7qLDRv9q6roKlfGZBkBsqL+3fzOC2pq54ZFLlhiBJoq/xjVr4kHiZAJMYUzomZJjYJX+w
	grPt2va8YBNlc3GwKZ0YlBFk2XNl1lU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <fu2jp7i7sdu6dwe3nsc647dtm2ejblf3j2yelgrpkzukfufegy@4krvb7wqpv4y>
References: <20240212105237.674e6fcb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212105237.674e6fcb@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 10:52:37AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-brauner tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/highmem.h:5,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from fs/btrfs/super.c:6:
> include/linux/fs.h: In function 'super_set_sysfs_name_generic':
> include/linux/fs.h:2597:9: error: function 'super_set_sysfs_name_generic' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>  2597 |         vsnprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), fmt, args);
>       |         ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> and many more similar.
> 
> Caused by commit
> 
>   eeea5d25d4a7 ("fs: add FS_IOC_GETFSSYSFSPATH")
> 
> This new finction is not used anywhere, so just remove it for now?

Let's not drop it; people adding support for other filesystems will
probably want it. Here's a fixup patch:

-- >8 --

From baf60243a686b0dca9236110491694bd03378063 Mon Sep 17 00:00:00 2001
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Sun, 11 Feb 2024 19:34:56 -0500
Subject: [PATCH] fixup! fs: FS_IOC_GETSYSFSPATH


diff --git a/include/linux/fs.h b/include/linux/fs.h
index fb003d9d05af..c6d9e1b7032c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2574,6 +2574,7 @@ static inline void super_set_sysfs_name_id(struct super_block *sb)
 }
 
 /* try to use something standard before you use this */
+__printf(2, 3)
 static inline void super_set_sysfs_name_generic(struct super_block *sb, const char *fmt, ...)
 {
 	va_list args;

