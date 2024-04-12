Return-Path: <linux-kernel+bounces-141927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD968A252C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACEA1C212E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09C4182DF;
	Fri, 12 Apr 2024 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="agtHApzR"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8055182C3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896155; cv=none; b=jz13QCHmv/4AjmGhqCNDda7zGLqL9AOe4y8q/TZb38CoXl1Z4qR/Cchd+TLGJkT9Z/22wm2vtidvvxqMoR8DS7nEIaJg+dzNv7lrivA7/hAoFH7t7fDJ4KMmRPhcBGLlOdZ28/4Ob+r4XFR9p0Fza3A2UHARjjqc+EeyejT3ZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896155; c=relaxed/simple;
	bh=DHM6nAj7Jy+55xoiSG9PHnUuCFZzkPIfgyOUGfjMPfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD/wVZDUdRdp9c9Q9Bs+A8RWY5VggMlZUGsMdKA+NHy6vYjIny1xSh8j6M5Ka+O0PkqDei6SE55xq0UxrJxWRMZnUXEEg0BefWGJmkfxyl65kuMsah7IeH+QcHAmoboNsw8TZh4x9bPjMc2CQvUulkP/w86YAK3Z3bOon1ZZBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=agtHApzR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SN8hBhDzhEUTSap+6csDB4UNd+5T+CN0+lWmQ/p4FDc=; b=agtHApzRQofGYkGfLMtOs1d/+m
	hlYU+4xuzwyVQ3OuNO3ibmzlpuOQDWqWTS/9e8ZWgzm+oWfm/otMmAnqaQ04RGkZ6V4IFRWm5bwPh
	i2DOVo13NVlZwFkXefjz84zAZ8VhwpqCPN3HnnlYQCvalyfsyYlbs2Dnl7N1tL+r0DpSP1r/8e66x
	YC1RO1EIQPeMgUSeQRvACcySK3DpNkSpTU+W5t2YZf1FfIRrhRQ6f/srEDN4wVhagRdYNr4bVPfHP
	EKSIMWETcJx914O80SSxpJFP5W9V4Ozd80f1pXF3zDldTW/d2PEVYpvVuqD9tvIMmEtRaTYQM7h+N
	JfVwrktA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rv8XG-00Avx6-2A;
	Fri, 12 Apr 2024 04:29:10 +0000
Date: Fri, 12 Apr 2024 05:29:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET RFC 0/437] Kill off old fops ->read() and ->write()
Message-ID: <20240412042910.GK2118490@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 11, 2024 at 09:12:20AM -0600, Jens Axboe wrote:
> Hi,
> 
> This patchset will obviously be split, commit messages updated, and
> specific driver patches targeted to where they belong. But I figured
> it'd be useful to blast out the full set at least once for reference,
> and then I'll continue down the right path for the next one.
> 
> Subject line says it all, really. 10 years ago we added ->read_iter()
> and ->write_iter() to struct file_operations. These are great, as they
> pass in an iov_iter rather than a user buffer + length, and they also
> take a struct kiocb rather than just a file. Since then we've had two
> paths for any read or write - one legacy one that can't do per-IO hints
> like "This read should be non-blocking", they strictly only work with
> O_NONBLOCK on the file, and a newer one that supports everything the
> old path does and a bunch more. We've had a few issues with the
> iov_iter based path being slower, but those have basically been
> resolved with solutions like ITER_UBUF to optimize the single segment
> case that is often the fast path.
> 
> There are basically three parts to this series:
> 
> 1) Add generic helpers that we need to convert drivers.
> 2) Convert any use of fops->read() and ->write()
> 3) Kill off old cruft.
> 3a) Profit.

The fundamental problem with that is that a bunch of drivers
do care about the vector boundaries.  Very much so.  It's very
common to have this kind of situation:
	write() parses the buffer sloppily, and ignores the junk in
the end, claiming that everything that been written.
	writev() feeds each vector to write().

From a cursory look through that pile, you seem to have broken
writev() on at least some (if not all) of those.

