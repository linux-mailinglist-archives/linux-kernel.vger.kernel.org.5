Return-Path: <linux-kernel+bounces-164623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B978B803F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA65B21EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1CF19DF5E;
	Tue, 30 Apr 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Saj7fmUk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A388199E8F;
	Tue, 30 Apr 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503658; cv=none; b=FHDtthbKThQUuqUIitBtxiIJuQioXa9XLpctdbYUyJSGtM1riCvDJRP09ZMzqoPzsFwwa9tOwVlYngN9b6muW57fp2GJTbSiGpV2kCH9AqmR3YihsFgV9/fbfZattXBfEiILWXK7HMywd0Z3FV4kXHbKZ3WESH3qPfSaXfjzvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503658; c=relaxed/simple;
	bh=6vpoXVf7eLhq/+mEugFcz1ms7uxrk4ZN8/G8lQEO6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zytv6exyxhAYk2a4rBDsIN8lbdCBrd67SyahyoFzsQXdF4GL4mqfeYRW4mWU4shArjzMjF8Rq/4LNwmkwmEEti+dUEOBaNCdHAwWR8v8Wj1zdCsxGVHZ+i8XHUGzt0j3xynpAmym2i0czRstFJCIj+zdbDZBUuJd+05xWet+U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Saj7fmUk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714503657; x=1746039657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vpoXVf7eLhq/+mEugFcz1ms7uxrk4ZN8/G8lQEO6Zo=;
  b=Saj7fmUk8ublpLzHLZbQizDehq2/MyWfIQuOI1gwtWc7iW+hkc0l4rar
   eIj0XcqjmII+l2RnLCBqgraJfNCmQNERIz1y+4/8kpNLmX4jdt3+Rt2TB
   Pag/BuC/Q0YHISI1I6BARbMqaYniv3d3K1XjQgXGQaebC+q5yDCNS6TXd
   3WiPk1xevY94JSJPStMAKYPZj6x/PvZ6qlJFQYCVf54W8iI90BaL20Irm
   v9jnKIPROhEtDNtvkWGU9zjCROWJF+0q+Zk1RAtTJ4gL/MP+W6kvIsGCn
   WA8mgHmP1O+K1I932nYUos7iuZOoXIrRm6ZGhs30U5mTlLx5EKC9B6plG
   g==;
X-CSE-ConnectionGUID: +55SzSd3QJmbnXcq2YUvQg==
X-CSE-MsgGUID: Ee53Mr+yRSWtBaKqCVZbLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10768721"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10768721"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:00:56 -0700
X-CSE-ConnectionGUID: I4auB1S+R+KhMPHolm3aSg==
X-CSE-MsgGUID: Oj3iJeVxQxeG6oBJ649sFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="27052817"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:00:56 -0700
Date: Tue, 30 Apr 2024 12:00:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in COMPUTE EXPRESS LINK
Message-ID: <ZjE/5VW95v54Tv94@aschofie-mobl2>
References: <20240411062443.47372-1-lukas.bulwahn@redhat.com>
 <ZhgPe5mDt2ocXovz@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhgPe5mDt2ocXovz@aschofie-mobl2>

On Thu, Apr 11, 2024 at 09:27:39AM -0700, Alison Schofield wrote:
> On Thu, Apr 11, 2024 at 08:24:43AM +0200, Lukas Bulwahn wrote:
> > Commit 12fb28ea6b1c ("EINJ: Add CXL error type support") adds the header
> > file include/linux/einj-cxl.h, but then adds a file entry with cxl-einj.h
> > (note the swapping of words) to the COMPUTE EXPRESS LINK (CXL) section.
> > 
> > Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> > broken reference.
> > 
> > Repair the file entry in COMPUTE EXPRESS LINK (CXL).
> 
> How about stating the impact, something like:
> 
> get_maintainer.pl can only return commit_signer history for file
> include/linux/einj-cxl.h because the entry in MAINTAINERS is wrong.
> Correct the entry so that the full MAINTAINER list is returned.

Hi Dave,

Perhaps you can amend the commit log with this suggestion upon applying.

With that done, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> It is interesting how you found it and I'm not suggesting deleting
> that.
> 
> Thanks,
> Alison
> 
> 
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index edf6176a5530..03204db05027 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5415,7 +5415,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
> >  L:	linux-cxl@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/cxl/
> > -F:	include/linux/cxl-einj.h
> > +F:	include/linux/einj-cxl.h
> >  F:	include/linux/cxl-event.h
> >  F:	include/uapi/linux/cxl_mem.h
> >  F:	tools/testing/cxl/
> > -- 
> > 2.44.0
> > 
> > 
> 

