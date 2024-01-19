Return-Path: <linux-kernel+bounces-31586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56412833064
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3441C23C05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D25821D;
	Fri, 19 Jan 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nImPMnLU"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DC58213
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700438; cv=none; b=MA/iftjy0mO9tbkQJNpJ6qZvw3xvO9hsmkEWx5bUpB4JoEjrjL6y80PAz1wT0zT0kNVFKzDZCJn/acc3eBjMgiFCz5WIi+NiQbAPG1Zuu9Zc+RsxiwID6iQUuXsVGAFZ9d7GNJNoekDdQo+h/q0UF6sL2pXSurET8lJ0oBuGlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700438; c=relaxed/simple;
	bh=nAC89f8X8johnpv+URotV+e2rcj2kEeyMjs6mLBR+Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzuE0tbD2H6nyFBT9TqtGdsoAKWgRdOj9qaJiqnl3jmCRnSATAea553rXZX33NhwyWsslBosjfzam5Ef2AUMvgiLdbIaig+HpoppKsPN7HOGnt+hFSV9ethOLKGtKWC6Cpm6W1N7jCDmHEl7G6tqUPJB1L468HN8QE6ogwDzBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nImPMnLU; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Jan 2024 16:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705700435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CL7Fqi9wJdDJQ7mbKqAQUb1dIye7tr1dS4PuVlo2Y4k=;
	b=nImPMnLUgKWOVj1e2odWGZyr47SQmvvPDoVjYia1NEhMH8RNywJ6QcznO/fVoOvY1wafM1
	quzLTeGQsSE8/rLGE84QDDcKa5lUJRwnR+QQHIp/qlBd1NESLGnQ4RzaMQV91AOHcVWt1L
	T0NMaCKZtYXjXP7IFlf3l2KSn0hKZ2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: fs/bcachefs/bkey_methods.c:46:5-8: Unneeded variable: "ret".
 Return "  0" on line 53
Message-ID: <tmj24xougircv23l2kmsxkzoj3j5yyyclzcujysiatavvre4fo@luejm2g2kcxx>
References: <202401192156.IvrA7iSY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401192156.IvrA7iSY-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 19, 2024 at 09:31:24PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
> commit: b65db750e2bb9252321fd54c284edd73c1595a09 bcachefs: Enumerate fsck errors
> date:   3 months ago
> config: hexagon-randconfig-r061-20240117 (https://download.01.org/0day-ci/archive/20240119/202401192156.IvrA7iSY-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401192156.IvrA7iSY-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> fs/bcachefs/bkey_methods.c:46:5-8: Unneeded variable: "ret". Return "  0" on line 53
>    fs/bcachefs/bkey_methods.c:219:5-8: Unneeded variable: "ret". Return "  0" on line 229
> 
> vim +46 fs/bcachefs/bkey_methods.c
> 
>     42	
>     43	static int empty_val_key_invalid(struct bch_fs *c, struct bkey_s_c k,
>     44					 enum bkey_invalid_flags flags, struct printbuf *err)
>     45	{
>   > 46		int ret = 0;
>     47	
>     48		bkey_fsck_err_on(bkey_val_bytes(k.k), c, err,
>     49				 bkey_val_size_nonzero,
>     50				 "incorrect value size (%zu != 0)",
>     51				 bkey_val_bytes(k.k));
>     52	fsck_err:
>   > 53		return ret;
>     54	}
>     55	

This isn't an actual bug; ret and the fsck_err: labels are used by
fsck_err() and related macros - we need a way to annotate that ret isn't
unused if we want to silence this.

