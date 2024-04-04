Return-Path: <linux-kernel+bounces-130812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73171897D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD461C22842
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BE101CA;
	Thu,  4 Apr 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x+BYGjbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86562D52F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193802; cv=none; b=b38CkaJSc81neaaOywmnLyNjJridcTpBcIsoOE1QLhsqR+DHT5UYR8M/nD2104M96Hez1HBxqvL+2kpNB5rI7Es5bb1EiFYHKh3lwXEI2pORw6tv9jBlJEKxelzHpDMB/a5YmSA98jD2MotqBlpxAp+7iuV8sxmOTVbl8O72n20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193802; c=relaxed/simple;
	bh=9URrAD4orwea2h0JUDYqZmyPdfENFD+fErFvc2LrXQk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m2OgKLNRaw1YvCVz2FeBEpoAjWiIuh/MjfJzGHxV85gt/CF2fciATjwVjXpg382i7sjAWc1TV+mprMPZojvqKyDN8Af34pt0uJkkU/h4W5HHbit5P43Fp7YW7CEiI5Y49q5Vw1yZktc/XdPmH9IoNK2kBH3G5rK3r/avG8yn35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x+BYGjbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE4C433F1;
	Thu,  4 Apr 2024 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712193802;
	bh=9URrAD4orwea2h0JUDYqZmyPdfENFD+fErFvc2LrXQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x+BYGjbY91XJTlptfwwpdhOxujYVJoHL83l7liK4etCRE4+klynk2MQ4AVH118p1z
	 PXCKTuU5+3PMd5iEQGfMJXoueP76m9i1+jb2EWzPBEUoPqtc5DRKvtXNyUqFiydAF6
	 8Y2t0d2vZlLwJC3MW3pgjAgpLIylLJv1mtHb3NVg=
Date: Wed, 3 Apr 2024 18:23:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>, Suren Baghdasaryan
 <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm/slab_common: Modify mismatched function name
Message-Id: <20240403182320.93491c23ed5ae19e94158ceb@linux-foundation.org>
In-Reply-To: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com>
References: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 10:07:11 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> No functional modification involved.
> 
> mm/slab_common.c:1215: warning: expecting prototype for krealloc(). Prototype was for krealloc_noprof() instead.
> 
> ...
>
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1199,7 +1199,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  }
>  
>  /**
> - * krealloc - reallocate memory. The contents will remain unchanged.
> + * krealloc_noprof - reallocate memory. The contents will remain unchanged.
>   * @p: object to reallocate memory for.
>   * @new_size: how many bytes of memory are required.
>   * @flags: the type of memory to allocate.

Well ok, but krealloc_noprof() is just an internal implementation
detail.  I suggest this documentation be moved to the new krealloc()
wrapper site.  Because krealloc() remains the thing which people
actually call.

Presumably the same applies to more of the new _noprof functions.

