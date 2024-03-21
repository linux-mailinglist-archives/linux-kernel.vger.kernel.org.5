Return-Path: <linux-kernel+bounces-110785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E018863E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FE61C22441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59B13AC3;
	Thu, 21 Mar 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exaWkcBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4749479;
	Thu, 21 Mar 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063143; cv=none; b=JFjpO32MkvqfFci0Dd+c59Ujn3xjZWwJ/WJA2UUhquhjE8FQL0Rwo+vg9y28Kp067R4mTWRK/cYDZoVaGj+pheiCBFYjYfyu5W4sYRaFcx7TepqSx+xEC/uwXyf4fXOe6AzejlcwfDgRN3EWGJWb0aioS3pGGYSsaoK3awgf0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063143; c=relaxed/simple;
	bh=Dmd+mCkMdzOBfLoCIqupDpw6bX8EVsUtBnynEtaFeLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlhu7mF+V5NO1ie/Qt1KAydXFgFcnFzBExvqDZCQJ4pqaDhTGAZ6/MnI06uN0NXHMs5fifibal+0z1nerLtWCyaa2SbTDig/4G+YMHDQP4qrAYtb753vJJmTEcRd3M3ryKvP2DE1HZ+sQQi1PYPpeFl3wma5rMdhSxg+/44kJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exaWkcBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21529C433C7;
	Thu, 21 Mar 2024 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711063143;
	bh=Dmd+mCkMdzOBfLoCIqupDpw6bX8EVsUtBnynEtaFeLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exaWkcBR8akeLm0+giy7UqCFRJdyIbMpOQq5TXujd0+j0oHVLGH+wBJfWH8U7306U
	 xx4p37mtD+eR9sBe6gOAnXzSd3p+VtL9YhTUcrKk8+3RhNQoGhzsvznpnr7PLFNFVy
	 29WpVYJLs6xgqwZfvakds8IZQbCiagbZQg0pLHCawOYnSilklNM6ub4IPmYWH2zQXB
	 KuU29YuSEkzYavCuRMXsUjSU01lWj4XKuswD0kEYMm+rTuaARCx8gbvMdaUj2ti8Km
	 2OHlzS8Wo8F+fDVzRfEhOAY+NFnbgQHqRx2QmV3ly2ErW5xFldblZ6msdJ8EmLLxf/
	 WGOstHQsaa9Kg==
Date: Thu, 21 Mar 2024 20:19:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZfzAZJmrBwVi5e28@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
 <ZfzAKMlYY7IkWXUg@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfzAKMlYY7IkWXUg@x1>

On Thu, Mar 21, 2024 at 08:18:03PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 22, 2024 at 08:41:31AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the perf tree, today's linux-next build (native perf)
> > failed like this:
> > 
> > make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.

About this specific problem, was this done on over a previous build? Can
you try after a 'make -C tools/perf clean' ?

> > Caused by commit
> > 
> >   f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument")

> > Are all these new commits today really destined for the current merge
> > window?
> > 
> > I have used the perf tree from next-20240321 for today.
> 
> Ok, maybe I opened perf-tools-next for the next merge window too early?
> 
> For this merge window I think Namhyung is switching to perf-tools,
> right?
> 
> From your reaction I think I made a mistake and should have opened
> perf-tools-next for v6.10 stuff only when the v6.9-rc1 gets released...
> 
> - Arnaldo

