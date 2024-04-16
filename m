Return-Path: <linux-kernel+bounces-147669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 897EF8A7774
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D257AB21A14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554F78B49;
	Tue, 16 Apr 2024 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FI5YlVQU"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810536E61A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305352; cv=none; b=Gb75EffkseY0OsExtJJDRL85DvZ7PYqh4JlCgA0+XMTzWTzbyxAaur8GZSk9Vt3nYqFsf65d8/TrqqcVNYSWVRmj+xYDUlBFFRDzDEA++9qdaL3YNsrexglwxtzpUEUy8TAL5XchUxmnO02Rqc75O65QrCFykrY+VLjBgkvirC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305352; c=relaxed/simple;
	bh=cceio2i2g+XpMA67ZaweBAe8aJQ465GCa8o/ranK5qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IakaKyIOtQTBZf8cEDAlX6xbTJornVZuctURRvM8oDudo3sXHzYlH+BX7uxvfQDV9DoYFonUqCb0jSzXw+dQgVrwnXCvvH13rEjy8ANKnaRXdYWWy/leA48h/zgSXPhdLe50lQNeV/NELgZ1Gg3rNdOMJtH0s7hv9l66hRdk5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FI5YlVQU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Apr 2024 18:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713305348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4a0PGrEMu5XdQTilCmMwlfM2e10kXfm2bWbg/3JQ9fE=;
	b=FI5YlVQU7/PZdq56uBNG41rfudamqGUdSMoeKgpiy+XntCQV87bD7yZTFCey4SzZ1+1XFH
	FyGrHrXmsoC9bfh84x2/qCOhy3JZXpf5na6M8NPndnzBKC0hmzMvSd9Hk90/sYyR5fp1nF
	8k7rJcky9EPu15hEPYS/3Q00EKGt5ws=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nathan Chancellor <nathan@kernel.org>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] bcachefs: Fix format specifier in validate_bset_keys()
Message-ID: <xznpzlnjcf3goexunm6azwercgwz7ikgum3i4gpdyxwykb4e4l@ascd3uztphq3>
References: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 16, 2024 at 08:16:02AM -0700, Nathan Chancellor wrote:
> When building for 32-bit platforms, for which size_t is 'unsigned int',
> there is a warning from a format string in validate_bset_keys():
> 
>   fs/bcachefs/btree_io.c: In function 'validate_bset_keys':
>   fs/bcachefs/btree_io.c:891:34: error: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werror=format=]
>     891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/bcachefs/btree_io.c:603:32: note: in definition of macro 'btree_err'
>     603 |                                msg, ##__VA_ARGS__);                     \
>         |                                ^~~
>   fs/bcachefs/btree_io.c:887:21: note: in expansion of macro 'btree_err_on'
>     887 |                 if (btree_err_on(!bkeyp_u64s_valid(&b->format, k),
>         |                     ^~~~~~~~~~~~
>   fs/bcachefs/btree_io.c:891:64: note: format string is defined here
>     891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
>         |                                                              ~~^
>         |                                                                |
>         |                                                                long unsigned int
>         |                                                              %u
>   cc1: all warnings being treated as errors
> 
> BKEY_U64s is size_t so the entire expression is promoted to size_t. Use
> the '%zu' specifier so that there is no warning regardless of the width
> of size_t.
> 
> Fixes: 031ad9e7dbd1 ("bcachefs: Check for packed bkeys that are too big")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404130747.wH6Dd23p-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202404131536.HdAMBOVc-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, applied

