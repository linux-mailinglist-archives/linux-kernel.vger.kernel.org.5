Return-Path: <linux-kernel+bounces-100832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED5879DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984E21F22C05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7D144057;
	Tue, 12 Mar 2024 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrBkFL6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3713B2BF;
	Tue, 12 Mar 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280087; cv=none; b=QjCwjHxaKMI9I1+jKp/qcWZYvMh56rODPav6ICTaTf38a74bEn15vzgz3ywd0ahETFAOaca+1xnBuqOeBodz1jwEHsWCjtSPhz7djKTLE4LlxNSHjCQ6FVYIcfcsc8XewoCaVJobMN9jKWVl3kYukbFRdLDPjyBewMnKLk+v3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280087; c=relaxed/simple;
	bh=/29e+s2YsPn/3RubcJskOJ3JbuCTi7M0bCO0bG/DGy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noohhlH902FH+Fpzu/5iotXWWJGGq35fv41cDuHv9v0C+skrC7z8ADUZCkJliEjvvfOYYjI79EFWbMp7894hY3uR1oKbvqP6KLpPqNnzYLhhAPktj31BpaJabmHAOubdobcrEchPiEHFxXZ8hFIjNZgUF8vWkcQ3n152W9tmQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrBkFL6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F3C433F1;
	Tue, 12 Mar 2024 21:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710280087;
	bh=/29e+s2YsPn/3RubcJskOJ3JbuCTi7M0bCO0bG/DGy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrBkFL6tJxUURZimf/zd4qlmU4t6HGkSsyYQBdk1f9/VmdSqYpM3tWmELXwgiA1jx
	 tibKp/uhT93xMcV8vLbEpRQacPIj3gUOdfTK6lan8cVbQsin4UNckId7BeEZZY8knO
	 eFpFBvjQSHgL6E44UOPYlboBuylhTEX+hmVHO6Q1LQxPgS/fo5Rs72HJ+FRAV/5k4i
	 TCSCXYZiuoBXbvcBeowdmUBgCtpTeLtJb5cVeMnF64Be3Pue9qq3JDGo9KUfVY9zDp
	 JO0GaW/weUyqLuq1Lzd8g5I4Dc2RSAOuxpZSH6iUQ7WPwGzoaL4M9Ygf/hZbzHIm6Q
	 BfmY8OboVwclw==
Date: Tue, 12 Mar 2024 14:48:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, Tejun
 Heo <tj@kernel.org>
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312144806.5f9c5d8e@kernel.org>
In-Reply-To: <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
References: <20240312042504.1835743-1-kuba@kernel.org>
	<CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
	<20240312133427.1a744844@kernel.org>
	<20240312134739.248e6bd3@kernel.org>
	<CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
	<39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 15:40:07 -0600 Jens Axboe wrote:
> Hmm, I wonder if the below will fix it. At least from the timer side,
> we should not be using the cached clock.
> 
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 9a85bfbbc45a..646b50e1c914 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
>  	unsigned seq;
>  	u64 vrate;
>  
> -	now->now_ns = blk_time_get_ns();
> +	now->now_ns = ktime_get_ns();
>  	now->now = ktime_to_us(now->now_ns);
>  	vrate = atomic64_read(&ioc->vtime_rate);

Let me try this, 'cause doing the revert while listening to some
meeting is beyond me :)

