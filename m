Return-Path: <linux-kernel+bounces-62531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC288852268
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489551F21C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AF4F897;
	Mon, 12 Feb 2024 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlGqYTCV"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032547A53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780276; cv=none; b=ieMSqwfMXG1cHn+NoYLUikSjxDY6beuKAPXJacHJxwdaE12manA+v4w/hi5hDBkW3MViIFqPFzp6FeKpnSTv264rNaSW394dIzKSrCC9vIHDu5EWg5xa7gJ5+Vp4x46fka0ojIhA3TB00AVbVuXrqh541/S6GOv1dsZre8Ggk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780276; c=relaxed/simple;
	bh=a6nc+3qyzd0ncRKH0wcaUkfQSgN4smezZYXaySqw3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIxBS/vgHA+mZj0EgJEAc6LuashbAx73/6yDodWrpIHB8+ImNSz19VkEsOIG2+7E3Y9/B6h3lFKekwHu7lraeLsJNxHa+txev04LfMeUkCBIuHQ8khMnObYIB+IJZQR4Qlo84NV+o0Aj5CtlGDhbe69LAicgBoBl3wf441PBGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlGqYTCV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 18:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707780271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8LTEJsnNRxTlSfm0V04u+FcTgFAby+QvIqqprQ6pTo=;
	b=LlGqYTCVqUS063bmbGYMGCZw9mFEL3KEhLQSJK0hLiOSD0VJzSZaSRWh4q7Bx/S8mATGA3
	trFImMn+yQBiuSO+qOkDK7YrkloLMhOm8zUAimwjr1ljeh73tXpXy7L95j+80N51H/F55q
	IdNZSCLdxIzMSQxbQw5orrkhpYrOIck=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <3yuohpx2vcnl5kjs54h5med3q2525xzkxvzxqqctrgadptytww@36kyayedfnbs>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240207174009.GF119530@mit.edu>
 <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>
 <20240212224740.GA394352@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212224740.GA394352@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 05:47:40PM -0500, Theodore Ts'o wrote:
> On Wed, Feb 07, 2024 at 03:26:55PM -0500, Kent Overstreet wrote:
> > You've still got the ext4 version, we're not taking that away. But I
> > don't think other filesystems will want to deal with the hassle of
> > changing UUIDs at runtime, since that's effectively used for API access
> > via sysfs and debugfs.
> 
> Thanks. I misunderstood the log.  I didn't realize this was just about
> not hoisting the ioctl to the VFS level, and dropping the generic uuid
> set.
> 
> I'm not convinced that we should be using the UUID for kernel API
> access, if for no other reason that not all file systems have UUID's.
> Sure, modern file systems have UUID's, and individual file systems
> might have to have specific features that don't play well with UUID's
> changing while the file system is mounted.  But I'm hoping that we
> don't add any new interfaces that rely on using the UUID for API
> access at the VFS layer.  After all, ext2 (not just ext3 and ext4) has
> supported changing the UUID while the file system has been mounted for
> *decades*.

*nod*

The intention isn't for every filesystem to be using the UUID for API
access - there's no reason to for single device filesystems, after all.

The intent is rather - for filesystems that _do_ need the UUID as a
stable identifier, let's try to standardize how's it's exposed and
used...

