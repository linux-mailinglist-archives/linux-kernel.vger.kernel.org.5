Return-Path: <linux-kernel+bounces-59160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555284F259
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BFC1F236C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF6679FE;
	Fri,  9 Feb 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOfso3v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D76773D;
	Fri,  9 Feb 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471518; cv=none; b=Nv62CjNjAbZpkU38g3bWlpiwOnP+MxgaBzxVXbww7hqIPN2Sw/RbgIcQy6lhhkOAy5On1dm3NX+0jaKzCgEfzI+QC3+Y+RrLUa4hztvHFSU5lN4PamqEqrzoWP978AOA/Xy8qkV9/ifpHi5ugHijQitbsNwpxAr1a0r6fxEJFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471518; c=relaxed/simple;
	bh=v1CpEvVc3TTPxG4UcaRDR9Ujy6DXuxaJpfcJWSI60Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq+VJ0P+sd9HU56Dg+Atp6etAJzYpW8uoAPb9BgsZCAbAyqxixCHhtEGVUrGm39lNio845OjSkE5unPQ8Z5utFehKT15vHFTub5AQSnhNWKBr+byVyuTtcC81utemdj81pgPMWeffkHiLtgNONDCGPxDb5d9V5J562Ledze43jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOfso3v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5D7C433F1;
	Fri,  9 Feb 2024 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471517;
	bh=v1CpEvVc3TTPxG4UcaRDR9Ujy6DXuxaJpfcJWSI60Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOfso3v7kUekiZWqjHHNC96JKgemm006jykeCyM1Wrp3/C28g6EW2yWOufCSFAeDs
	 NTMLaJ/OsHC1XLvGQoKkCL2z3Y+V75OUQpt/eBUh2qd6VHo47uLUoZ9Nbo2nV45vdG
	 SWvuLVEN/oYV7o+IrsZ1Ii1fPBJ6QSFqBQWDAIiRWGrvWdwjICwn5B65CD//4R5tc6
	 VWFgFawINVwcSupQ2qdxwjixqbaoQWy4UDn+JxuZe17wpYdWv1EVR02ooBHvXf0BZ7
	 8gE1ufeFFljcqzban/q2pFHrN2eHCeEwh1i/NnT6dg1M7B8iaRLKJ4lef6EFS4HcZi
	 nNsVDtC01usnw==
Date: Fri, 9 Feb 2024 10:38:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: filesystems: fix typo in docs
Message-ID: <20240209-apathisch-lustig-c2f17bdd74ed@brauner>
References: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>

On Thu, Feb 08, 2024 at 05:20:32PM +0100, Vincenzo Mezzela wrote:
> This patch resolves a spelling error in the filesystem documentation.
> 
> It is submitted as part of my application to the "Linux Kernel Bug
> Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
> Foundation.
> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  Documentation/filesystems/files.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
> index 9e38e4c221ca..eb770f891b27 100644
> --- a/Documentation/filesystems/files.rst
> +++ b/Documentation/filesystems/files.rst
> @@ -116,7 +116,7 @@ before and after the reference count increment. This pattern can be seen
>  in get_file_rcu() and __files_get_rcu().
>  
>  In addition, it isn't possible to access or check fields in struct file
> -without first aqcuiring a reference on it under rcu lookup. Not doing
> +without first acquiring a reference on it under rcu lookup. Not doing

I stared at this for way too long to figure out that there's actually a
spelling mistake in there. Thanks! I've snagged it. Jon, let me know if
you prefer to take it.

