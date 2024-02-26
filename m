Return-Path: <linux-kernel+bounces-81761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C78679D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1628C1C2B84F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9912BF0A;
	Mon, 26 Feb 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qtwjxk3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DA12FF83
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960018; cv=none; b=FznCUfI0ZFbs7FZHcDPpm5WtD15zsLHiP+4NCAUW52HBGxku84StSmT+NTZ/Tgr5CWQcKTg9L63Ktv+TfNT71hQqaUvPBzwAG3M2H28noVDFyzNKRQIFRGxuPOvuLJ1er7yld0mEipwPyZCkE3LpIJvWJ9V1HLVrfkJcMLk26rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960018; c=relaxed/simple;
	bh=nC/HNevsj+Y1+O/yDGBtbFausYvDBCTRzB+f3qASm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC/0nWvOGFSV+XqvFVNZNrSnm2j00gXsvxF2SsgtU27sYv7MOpM1qz00/Gxmi2NFcH1ekKv/2/fppPmj9xdF3+AwYCOuHS+iaS6R5uxAL61DLh2Zobgr0KY5rqtGX9Xt0F81Ysruvl2E98cjh24eXGeqGltqNc2Pu2Ey0tbNbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qtwjxk3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3840EC433F1;
	Mon, 26 Feb 2024 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708960018;
	bh=nC/HNevsj+Y1+O/yDGBtbFausYvDBCTRzB+f3qASm+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qtwjxk3bnNHWkbrckTgbw3Jey17dZvhSSADRUykG2op3iqZrY2MWJut21c7rNwoW0
	 HUDMgcpGRaehomjZMG57fdYPhQh3T8Sl77dtK7+BLR+gNpzj/ut22QyHjDADXpAB0h
	 R8GGQckiaEqFWj0pf6tTBkudEELngUQUWL/aPVfA=
Date: Mon, 26 Feb 2024 16:06:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022639-wronged-grafted-6777@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdylmz28rZ-mCeiN@tiehlicka>

On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> On Thu 22-02-24 17:21:58, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > 
> > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > drmem lmb array when the LMB lookup fails to match an entry with the
> > given DRC index. When the search fails, the cursor is left pointing to
> > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > last valid entry in the array. The debug message at the end of the
> > function then dereferences this pointer:
> > 
> >         pr_debug("Failed to hot-remove memory at %llx\n",
> >                  lmb->base_addr);
> 
> While this is a reasonable fix and the stable material it is really
> unclear to me why it has gained a CVE. Memory hotplug is a privileged
> operation. Could you clarify please?

As you know, history has shown us that accessing out of your allocated
memory can cause problems, and we can not assume use-cases, as we don't
know how everyone uses our codebase, so marking places where we fix
out-of-bound memory accesses is resolving a weakness in the codebase,
hence a CVE assignment.

If your systems are not vulnerable to this specific issue, wonderful, no
need to take it, but why wouldn't you want to take a fix that resolves a
known weakness?

thanks,

greg k-h

