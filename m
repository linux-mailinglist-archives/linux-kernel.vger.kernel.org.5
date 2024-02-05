Return-Path: <linux-kernel+bounces-54045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C3E84A9A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0811F24967
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A5481BF;
	Mon,  5 Feb 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUJRph/B"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567C1EB3B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173792; cv=none; b=EOKwufmgziSgRbGEF2pOWVe0TmlVfu+We5pdJkz718UXFTcRY9QfXe4k3pCLQj8XAaBaI3QUK+N1l/PxKzokM3DWQU+ZoXZyl/FI34YsL6IfOD+Of3Br47kVMufpZIcQ1KFEYaE+YtEA2SA2UDOy6xZVMb4aPDGL9+JeSOGjXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173792; c=relaxed/simple;
	bh=5Drkk1LxOHXAWjDy7FEREOApjq8Kex+jv6emR7dDYi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSB/bSs0worhDDr+p+dk8SOuMLEERK38jrGi9J/m9O+fQlPF+hFtuOZsXKwLf4D4/NX1Ib0Om3aVoyyLzy6lJygf9H/0QFW/bvaKxiY0NAQeGzVLFqVW3JQQP5zp0n2aKTh5p2JKijcvR5Y9fYQNe+E0jjX772HAD9iEvvxPxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PUJRph/B; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 17:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707173788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yneXKAl76UfBB4G/b+Ka6wc01rtEX0msSH9gfV0s6M8=;
	b=PUJRph/BCxVzc6ntkk5bZNVG+jySNFceLeDgdY8W23/c3O0QL4z2a62jAa7U0JmPJglLLm
	TjAeNC6HDy3zEGrBOFEA/UP7FLc0VOwJnJGXAoF+i6YnFgLRRPWrhEEDY8gvmgonEuI4q/
	HRmqAT6CQlgOSsH0QCyfnBjyIwkg2xI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: super_block->s_uuid_len
Message-ID: <lhwi5t3kysofbcgnz72mqcpexplr5zjn3ywzhfes4rx6hn7rlf@56e4tghhewz5>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-2-kent.overstreet@linux.dev>
 <ZcFaGRV08WQOxCzb@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcFaGRV08WQOxCzb@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 06, 2024 at 08:58:49AM +1100, Dave Chinner wrote:
> On Mon, Feb 05, 2024 at 03:05:12PM -0500, Kent Overstreet wrote:
> > Some weird old filesytems have UUID-like things that we wish to expose
> > as UUIDs, but are smaller; add a length field so that the new
> > FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  fs/super.c         | 1 +
> >  include/linux/fs.h | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index d35e85295489..ed688d2a58a7 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -375,6 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
> >  	s->s_time_gran = 1000000000;
> >  	s->s_time_min = TIME64_MIN;
> >  	s->s_time_max = TIME64_MAX;
> > +	s->s_uuid_len = sizeof(s->s_uuid);
> 
> So if the filesystem doesn't copy a uuid into sb->s_uuid, then we
> allow those 16 bytes to be pulled from userspace?
> 
> Shouldn't this only get set when the filesystem copies it's uuid
> to the superblock?
> 
> And then in the get uuid  ioctl, if s_uuid_len is zero we can return
> -ENOENT to indicate the filesystem doesn't have a UUID, rather that
> require userspace to determine a filesystem doesn't have a valid
> UUID somehow...

*nod* this all falls out of your super_set_uuid() suggestion

