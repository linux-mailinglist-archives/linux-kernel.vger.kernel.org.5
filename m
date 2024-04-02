Return-Path: <linux-kernel+bounces-127323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE458949AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276732840B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E717597;
	Tue,  2 Apr 2024 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUeqBLyK"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EC17589
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026565; cv=none; b=hQH4mPE64IA40Y4azWaP0aM1YFzxVMbvXvt2Kz0C9NtBkhi4Hy4+BFmg4BrLNgxKN+z0gRLhxJmrZfeGncBL+ZMylGVk3ocvspjB8UriASaicNcuIAvaov3grLXVLgzjVUMTHTDCglFi+lsGgO3t3gRAGdeRegVPJObbL5SVlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026565; c=relaxed/simple;
	bh=xURg2q9cINBFrvUw1DAqxR9mcJsxmWIcZZENGnVqybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz02tJ3kuiYmzXx4qvEf7dNYEC+nGqLOXh3rWJzuplb041JV9rS4ZeXw3uvPdWQ5/NSex6k33c8tsA9eWyBN2GsrItmsS21wEIWTk00ZPtZ8tQhc94CET+p3fx5dOltSL2184Bde967NVQiLvC36lpVlizi86yYi71CvONDn+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUeqBLyK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Apr 2024 19:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712026560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYSqIFiwGGtcDOZBDsw+9RR8EOi7+ataFBzYA1KAuI=;
	b=IUeqBLyKZQqdy7WMTYBSYvGVlJX/NL+9BXvnQT3FAYEegaJus1eYOltymBQkb2wweOtMGP
	dcLLM6zejySv2DxKrhd3PlOp8+Tx5Pw+2ZTYqx7GVJOL/F5YQ0IYGIz7SND+yjdrNpYBnf
	a7kcIAmXAFDkoXhk81O5Nf4U5QKz9aw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	hannes <hannes@cmpxchg.org>, mhocko <mhocko@kernel.org>,
	"shakeel.butt" <shakeel.butt@linux.dev>
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJh?= =?utf-8?Q?l?= protection fault
 in refill_obj_stock
Message-ID: <Zgtzup7T4TMZWPuz@P9FQF9L96D>
References: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
 <ZgtIuBlUVE1Lj_Tc@P9FQF9L96D>
 <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 09:50:54AM +0800, Ubisectech Sirius wrote:
> > On Mon, Apr 01, 2024 at 03:04:46PM +0800, Ubisectech Sirius wrote:
> > Hello.
> > We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> 
> > Thank you for the report!
> 
> > I tried to compile and run your test program for about half an hour
> > on a virtual machine running 6.7 with enabled KASAN, but wasn't able
> > to reproduce the problem.
> 
> > Can you, please, share a bit more information? How long does it take
> > to reproduce? Do you mind sharing your kernel config? Is there anything special
> > about your setup? What are exact steps to reproduce the problem?
> > Is this problem reproducible on 6.6?
> 
> Hi. 
>    The .config of linux kernel 6.7 has send to you as attachment.

Thanks!

How long it takes to reproduce a problem? Do you just start your reproducer and wait?

> And The problem is reproducible on 6.6.

Hm, it rules out my recent changes.
Did you try any older kernels? 6.5? 6.0? Did you try to bisect the problem?
If it's fast to reproduce, it might be the best option.

Also, are you running vanilla kernels or you do have some custom changes on top?

Thanks!

