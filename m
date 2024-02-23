Return-Path: <linux-kernel+bounces-78546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C178614CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D46B2276B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E83823BD;
	Fri, 23 Feb 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUp2xV4e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A74A3D;
	Fri, 23 Feb 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699997; cv=none; b=XWLo3r2PNEN0saoyqQPUlPNUwltNF4ql0f/1JgNLVn0hGvMrsZL5RFxVjmeHEu/PcW0udcUWOaQTW9IOZyNy22yCZCnau9nufTv7CQoo/ltdgaA4GvqJhBAMv55NwtM56RpHcQGQUXQg9OT8WnuY6XX7SaZ5nnlxohiA0DTvJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699997; c=relaxed/simple;
	bh=AqDovNM/l/yDTDZSEvPhskD0UTZzJaMi+UZpX8JqnYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhP7H6PJJTpnKG3LEdhh8M5tnPpcDXJuoFq1ue6x6aB6NQrb04pQAnYzsq90Em1Ju+jUKB6UVHXktVtsTjArIxKKMcWWyPUqyQbvvdk1yKoK33sh0WEx5mJIRVS67b57XQEcoALpnbw7Sdwob1UcFUP+d3qpSC0x7Lfo55md0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUp2xV4e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708699996; x=1740235996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AqDovNM/l/yDTDZSEvPhskD0UTZzJaMi+UZpX8JqnYE=;
  b=cUp2xV4eZ6w7i5Xu2lKGMXOqgGJKC9MdNZ5q9ti3kBvJp7yQ02ol0iz/
   q6TgEwICNGdstRcvvPRMjOM2nhDadVXxMiq0SOAHwEj6JHz8+wGVtmwK2
   m/Aug0SOEFUqvHQ+JoUOTLcHziMmREM8K9JYf+n2ZpYrz6oGWqg7uWtQc
   G2NxLSUSce2FcSFyqJjzdlXkn0yiBfPuHQ4PS++T2mD1x6LjAgBj0OCs5
   a3cIBVzHR/Z9eaJzVsqpPG7RrfBzWXsiKrE2upAzfSg713ynzOlzVNPQN
   4Ln5S5Y0VLMz0GpNxouHLSqXf9+UrgI/0ICWzg+kRrw0uYqn9cNfAHYaI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3524218"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3524218"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748140"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748140"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:53:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdWvF-00000006vYW-3li0;
	Fri, 23 Feb 2024 16:53:09 +0200
Date: Fri, 23 Feb 2024 16:53:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it
 belongs
Message-ID: <ZdixVesIli2D943J@smile.fi.intel.com>
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
 <ZdXxNFB8bMMFPoki@smile.fi.intel.com>
 <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
 <CAGETcx9akN315asPP=e8xieHqs7gKXvHP-BwRxD=vCBuhh8_Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9akN315asPP=e8xieHqs7gKXvHP-BwRxD=vCBuhh8_Jw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 04:54:39PM -0800, Saravana Kannan wrote:
> On Wed, Feb 21, 2024 at 4:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 21, 2024 at 02:48:52PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 20, 2024 at 06:08:56PM -0800, Saravana Kannan wrote:
> > > > On Tue, Feb 20, 2024 at 8:10 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > The rest of the functions here are related to parents and children of
> > > > a fwnode. So, why is this function considered to be in the wrong
> > > > place?
> > >
> > > When devlink was added it made a few fields in struct fwnode_handle.
> > > These fields have no common grounds with device properties. In particular
> > > struct device pointer is solely for devlinks and shouldn't be used with
> > > them. Hence this patch. TL;DR: they semantically do _not_ belong to
> > > the device property APIs.
> 
> But fwnode_is_ancestor_of() uses none of those new fields and seems
> like a very reasonable API to provide. I understand if you want to
> make the "device link only" argument for fwnode_get_next_parent_dev().

Nobody is using that except devlink. That API can be and should be hidden
(we do not add APIs without users). On itself it's useless.

> > On top of that for the 4+ years no new users appeared, so exporting them was
> > a clear mistake. Hence Fixes tags.
> 
> We have plenty of APIs in .h files (not the same as export to modules)
> -- that have only 1 user. And even some with no users. You don't move
> a string function out of lib/string.c just because there's only one
> user of that function. We put functions in C files that make sense.

You understand that this is a weak argument, right? There are generic
functions, there are more specific ones. Here we are talking about niche
APIs without (other / new) users for all this time!

Now about generic one (as string.h is a bad example here), yes we do move
functions from the headers out if we have only one static user. We even target
killing some generic functions (strlcpy() is one and strlcat() is rumored to
follow same destiny.

> I think Fixes is a bit of an overkill. It's not a bug. Fixes get
> propagated to LTS. This is certainly not LTS worthy. I'm not going to
> NACK or push back on this patch for these reasons, but just letting
> you know that you come off as unreasonably grumpy when you do these
> things even for fwnode_is_ancestor_of() :)

I can drop Fixes it won't affect much as as I said there is no (other) user for
it anyway for all these years.

TL;DR: I will drop Fixes for the next version and that's it. I'm not okay of
leaving functions in the header and be exported just for the sake of exporting.

-- 
With Best Regards,
Andy Shevchenko



