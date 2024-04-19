Return-Path: <linux-kernel+bounces-151477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8358AAF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEED1C22779
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD8128826;
	Fri, 19 Apr 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXMJLVNv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3278614B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533507; cv=none; b=khNLPL95Gwbl3C+V9vJ76DoT2Kts1kvDrqVtszhoUSnXgWJvK9cxvmrf4bB9Gk8gWTWfA72FzWKs1TN5aMuRkqPZrDkFitqo37G++tFJiJOoHWJeh+NziMzu0rnqQ/QdyQoF6iOaZUAlVXgdf1VzUQK1sv51XdiTAFgF5nsfqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533507; c=relaxed/simple;
	bh=q8sLxUQXTmO+zQlO+Nq2zQY8GKJ0uOrx6YdkifWv8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjl6rDNn2MO+9sC+KNUh8zeW7k6jj0JYm/DtoNfTvSex8Lxnm5YxD5mZfUw/Q0grd2EQuqHHzgBKwcYBKKo7VmCoLv3oKFOJKKZdvXhTj9AS+3IjuuPbwa9Y9oLY3H/Ww9lexOhLf3m8DeXAO5cEmMPDwGOF5m3UXyOTQ3bdQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXMJLVNv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533506; x=1745069506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8sLxUQXTmO+zQlO+Nq2zQY8GKJ0uOrx6YdkifWv8s8=;
  b=LXMJLVNvMh7kLIg+OQpGV3kIW52FsgOxk4V2z9Zj+eo63+Wvzc4hxwEh
   DcCUGRysIJ82uybKP+4zUq9Xbjt90+A62OCQeyhmKT2QUVzuc1xMvF9gD
   ZMlkpJsAIgYuduZTNGC3yh+N2mJUTh3DcKiIo4mAmn10SLaBnhRjVwzSP
   s0XDpCfZdosoXZRq+ELaRLYZZO5w59wHEWnc59x9Mm8+wE7K2g1VxTqKu
   E5oRqWgoe4M2CVtARlJ2jSZdS7L/vL20DFIV0HCOWStGQySy7PSF8auAw
   eOo579oO/oxKfcizcMBUPL6oWIhcd+qaHTMw0Rrsz/PsW3Sex9Zs8Yt3q
   A==;
X-CSE-ConnectionGUID: AVVUO5QTRmqvkOo623zoqA==
X-CSE-MsgGUID: wno5hSyyTtuRb1DDxPJzqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19829820"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19829820"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:31:45 -0700
X-CSE-ConnectionGUID: 8EhFIYEkSGmj4XmvSB/OuA==
X-CSE-MsgGUID: 32PEEwedQ4ewi5StWKTDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23411447"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2024 06:31:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CEE59FD; Fri, 19 Apr 2024 16:31:39 +0300 (EEST)
Date: Fri, 19 Apr 2024 16:31:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 03/18] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-4-kirill.shutemov@linux.intel.com>
 <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>

On Thu, Apr 18, 2024 at 04:37:09PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:55PM +0300, Kirill A. Shutemov wrote:
> > +/* Declare CPU offlining not supported */
> > +void cpu_hotplug_disable_offlining(void)
> > +{
> > +	cpu_maps_update_begin();
> 
> "/*
>  * The following two APIs (cpu_maps_update_begin/done) must be used when
>  * attempting to serialize the updates to cpu_online_mask & cpu_present_mask.
>  */
> void cpu_maps_update_begin(void)
> ..."
> 
> > +	cpu_hotplug_offline_disabled = true;
> 
> but this doesn't do that here.
> 
> Are we doing a one-off here for that variable or what?

Yes, it is one-off. I guess we could use READ_ONCE()/WRITE_ONCE() to
access the variable with the same result. I am not sure why it would be
better.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

