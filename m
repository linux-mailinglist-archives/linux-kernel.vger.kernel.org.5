Return-Path: <linux-kernel+bounces-20131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC195827A43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C154282985
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77456442;
	Mon,  8 Jan 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ITQDZ6iq";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ITQDZ6iq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F156450
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 97CB6C01C; Mon,  8 Jan 2024 22:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704749850; bh=T6pq3oYZAwBjvYhcZTgNrAtF5tCRRgkDFhYs7BfLir8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITQDZ6iqaLfLHC5UUsHqjfFvbktxVVqYvTxfWjlL41MS8MMqR47N4UEeUwszv2tEG
	 m0VVtwgBombUEUOH5wNIannU7ZRT3RSf3Mo2tDf4DLrOPKL7dsAuuBm8zIZ338IYal
	 UcMBOAe1j/2eudAhTBXPgAevEemDm7AtA4bvVniJmjJtjdVK5D0xFrndUjXklSB62G
	 rLhKozO5UgF5lcx0jYCInqIqRfF0rd5I3djmnsxlkFWnW5NZp+DiqbJJv90u7DkZMY
	 UBIyFGFUfaEMUlEyaB37QEXPfWNmuNK/G7K1he3T+N7OF4KHwBk6ij2dNuq/uOf8or
	 XFHphi5/bLXrw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 2FE59C009;
	Mon,  8 Jan 2024 22:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704749850; bh=T6pq3oYZAwBjvYhcZTgNrAtF5tCRRgkDFhYs7BfLir8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITQDZ6iqaLfLHC5UUsHqjfFvbktxVVqYvTxfWjlL41MS8MMqR47N4UEeUwszv2tEG
	 m0VVtwgBombUEUOH5wNIannU7ZRT3RSf3Mo2tDf4DLrOPKL7dsAuuBm8zIZ338IYal
	 UcMBOAe1j/2eudAhTBXPgAevEemDm7AtA4bvVniJmjJtjdVK5D0xFrndUjXklSB62G
	 rLhKozO5UgF5lcx0jYCInqIqRfF0rd5I3djmnsxlkFWnW5NZp+DiqbJJv90u7DkZMY
	 UBIyFGFUfaEMUlEyaB37QEXPfWNmuNK/G7K1he3T+N7OF4KHwBk6ij2dNuq/uOf8or
	 XFHphi5/bLXrw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 1df35907;
	Mon, 8 Jan 2024 21:37:25 +0000 (UTC)
Date: Tue, 9 Jan 2024 06:37:09 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, rminnich@gmail.com, lucho@ionkov.net
Subject: Re: [PATCH] fs/9p: fix inode nlink accounting
Message-ID: <ZZxrBbR2YHz0E5v0@codewreck.org>
References: <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
 <8004884.rDQMAZhJ5Z@silver>
 <CAFkjPTn0HFnnZk8rt7m+mfLyPofMxZC6EzaoFChoyRVdVnwM6Q@mail.gmail.com>
 <7785659.j189Hiylts@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7785659.j189Hiylts@silver>

Christian Schoenebeck wrote on Mon, Jan 08, 2024 at 03:55:53PM +0100:
> > I'm good with adding local wrapper functions,

(Agreed having a local wrapper that locks + use these is better than this
current patch -- v2 looks much better, thanks!)

> > I imagine these aren't
> > used in the kernel because for regular file-systems maybe you want the
> > warning that your inode link accounting is wrong.
> > I suppose we could be naughty and not use the kernel functions (which
> > themselves are basically wrappers).
> 
> Well, one half of that code is actually using atomic operations to increment/
> decrement the private counter. Which means to me those kernel functions were
> intended to be called from a concurrent context. So I don't get why the other
> variable is not atomic there. They should be I think.

I think the key difference is inode level vs superblock level -- the
inode is local and holding a lock can be faster if manipulations are
grouped together (x atomic operations are usually slower than a spinlock
and x normal operations), while the sb potentially has contentions and
would be more likely to use atomic...

> I would probably try and send a patch for changing those kernel functions and
> see if people are fine with that. But up to you.

With that said I just checked ext4 and it looks just as racy as we do in
particular the rmdir/unlink case doesn't seem to take any lock, so it's
definitely worth raising the subject on fsdevel!
I'll see how work is busy and ask later today if time allows


-- 
Dominique Martinet | Asmadeus

