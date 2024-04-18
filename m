Return-Path: <linux-kernel+bounces-150144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A79D8A9AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481B22861E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC99E13247D;
	Thu, 18 Apr 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xRtHf3pm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D215E7E7;
	Thu, 18 Apr 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446024; cv=none; b=VQH1NCuxNk8navVYtdI+PhPPFfZfX4Y5XbhmSQ0kJk7K/C/xgL7Kf8gUKSPvwC85iZC295TmupY8llwQZhBC+Xg7Ex4F3WZgMrngHXCvWWF9w1wQB5jPxGWXHLbmP595Cza28QB185QN3gvP5+gfa9msTo2ekWwx6EJ+VXoRCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446024; c=relaxed/simple;
	bh=unmE9WX3yu0dRqCyi5xEkwpL6qg4NFksQCD7kpO6y1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBMZU9YjPOYoSGAoouiVQPORzrondovXKZqhrQyoWyvZuZAcl//ouMER1LNOmMOfLdXdccxI4tvl9qQXn/LWomkGnobCWwh+8WT+Zzr0ZiSruglSDW7ZX3CbWwd95ZNZXV7CEI5Lx18ZeOFP4bMWoZ8aXLFGei21fD5nU6AZeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xRtHf3pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03848C3277B;
	Thu, 18 Apr 2024 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713446023;
	bh=unmE9WX3yu0dRqCyi5xEkwpL6qg4NFksQCD7kpO6y1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xRtHf3pmqHQeoYPbJdjcXCu99UxLGzcWYnwjuoUI61m5JN5gWat/uvjuB1i8Le8L9
	 EylZsoQhkgv7v3bCUM8NUJlo6SAvX/Sz77o/aOkmmXneNmBl979apffDZf9hGeCt2j
	 VdzNE5ewuXRai+mHSnAgxtrhijqSZt8vP0cu3XKk=
Date: Thu, 18 Apr 2024 15:13:40 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-cve-announce@vger.kernel.org" <linux-cve-announce@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: CVE-2024-26920: tracing/trigger: Fix to return
 error if failed to alloc snapshot
Message-ID: <2024041811-freeing-licking-bd94@gregkh>
References: <2024041738-CVE-2024-26920-a681@gregkh>
 <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>
 <2024041805-rippling-entourage-1a72@gregkh>
 <92ec3ce16c7e640de19b44165e2bb88b63dd2478.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ec3ce16c7e640de19b44165e2bb88b63dd2478.camel@oracle.com>

On Thu, Apr 18, 2024 at 01:06:42PM +0000, Siddh Raman Pant wrote:
> On Thu, Apr 18 2024 at 14:34:57 +0200, gregkh@linuxfoundation.org
> wrote:
> > On Thu, Apr 18, 2024 at 11:59:41AM +0000, Siddh Raman Pant wrote:
> > > Hi Greg,
> > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > tracing/trigger: Fix to return error if failed to alloc snapshot
> > > > 
> > > > Fix register_snapshot_trigger() to return error code if it failed to
> > > > allocate a snapshot instead of 0 (success). Unless that, it will register
> > > > snapshot trigger without an error.
> > > 
> > > This commit is problematic on 4.19.y, 5.4.y, 5.10.y, and 5.15.y,
> > > and should be reversed, and this CVE should be rejected for those
> > > versions.
> > 
> > Then please submit a patch for this.
> 
> Sure.
> 
> 
> > But note, CVEs are not for specific versions, sorry.  We give a hint as
> > to what kernel versions might be affected, but we don not assign CVE to
> > versions.
> 
> Cool.
> 
> > > 
> > > The return value should be 0 on failure, because in the functions
> > > event_trigger_callback() and event_enable_trigger_func(), we have:
> > > 
> > > 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> > > 	/*
> > > 	 * The above returns on success the # of functions enabled,
> > > 	 * but if it didn't find any functions it returns zero.
> > > 	 * Consider no functions a failure too.
> > > 	 */
> > > 	if (!ret) {
> > > 		ret = -ENOENT;
> > > 
> > > Thus, the commit breaks this assumption.
> > > 
> > > This commit needs b8cc44a4d3c1 ("tracing: Remove logic for registering
> > > multiple event triggers at a time") as a prerequisite, as it removes
> > > the above.
> > 
> > Should we just take that patch instead?
> 
> The series in which the patch is posted is here:
> - https://lore.kernel.org/lkml/cover.1644010575.git.zanussi@kernel.org/
> - https://lore.kernel.org/lkml/cover.1641823001.git.zanussi@kernel.org/
> 
> Seems like some good tracing subsystem refactoring. So if I understand
> Documentation/process/stable-kernel-rules.rst correctly, I would say we
> should not.

So the documentation on the commit here is wrong (i.e. wrong Fixes:
tag?)  If so, that needs to be said somewhere...

thanks,

greg k-h

