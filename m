Return-Path: <linux-kernel+bounces-126941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE588944B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D12C1C21776
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520C4F217;
	Mon,  1 Apr 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5Ct1mh8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E544D5A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995541; cv=none; b=Vvqgz/fmNLCRZZTP37dFLIv1Js2WCKDl4nAuJ0k/NUMhjz2PBI5RpNAp3X1eIUdZW0kTtk+suKvetMqv3mppFHhHks5s7FcLxslA89yLLzRGcchwzP9bl+Y2uI+UuDngK2x6poztRyl/wQp0daweZfWOhtqpDL4nZEy24GyLeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995541; c=relaxed/simple;
	bh=s1LuEzTGRMEfdpCmX5j5fPzRsUox6WEKCEEwRqhKz60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOHjuBSq01SpUdi79fs3JLQFN3NCQZCJtZdPUTXFzQDqGBL7AVBnOD11rUXOUPHVgm1cWSdCoK+Xw7w3wQU3uGYnMyuVBzKWI1qz3R8S9tvdpOA7kXv61QI4MPcLoleU+YWaQQTQqENbzT0kXoLKS4u0QeFj2i5QNgpzs2IeDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5Ct1mh8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711995539; x=1743531539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s1LuEzTGRMEfdpCmX5j5fPzRsUox6WEKCEEwRqhKz60=;
  b=c5Ct1mh8EJcmrQinKrGwqOc70K82Bs6dbpAAs8crjF0x18Q/7EjZadda
   DzUtCgrSenb2M0saeBySt/kK4kJO7v06K2n7BD8+rZZbmqxTkXTWsxKDt
   PhWN2HLovsDIVTsM9U7pFKwrUJ9YU2NowA0GsNAzPlmJxGCDoQsqMemiJ
   MGd6L5Y4Hiidg2stPbplpcRbryN6tYnmNH41pjQJHJsewfO88oDuDZPPQ
   lmDDykyWX6bl/4wJUCVrXEhctB4WpZbEHMWdiHSG2AgdUoOffwPYMmdxN
   VFkLkSlIFi2j0HJln0aS45dhfGXeyP5uOQg8yKSvHTa08NLL2XDp4slJ7
   g==;
X-CSE-ConnectionGUID: fNn76pUqQu2H74kLNuPgbg==
X-CSE-MsgGUID: 37v5wNgQTIyVSeMNKLVbGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18494955"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18494955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="48998734"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:18:58 -0700
Date: Mon, 1 Apr 2024 11:18:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <Zgr6kT8oULbnmEXx@agluck-desk3>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>

On Fri, Mar 29, 2024 at 12:40:07PM +0100, Borislav Petkov wrote:
> Because from looking at your set, I don't see a slick way to check
> whether a concrete f/m/s tuple belongs to a range without involved
> checking.
> 
> For example, models:
> 
>                 case 0x30 ... 0x4f:
>                 case 0x60 ... 0x7f:
>                 case 0x90 ... 0x91:
>                 case 0xa0 ... 0xaf:
> 
> are all Zen2. I could do a X86_MATCH_VF_MODEL_RANGE and we even had
> a patch like that at some point but it didn't go in. But even if I did
> that, I'd still need to do x86_match_cpu() instead of the current
> X86_FEATURE_ZEN* checks we're doing.

I realized the problem with ranges is the order I put the bits into the
x86_vfm field. If I swap around to put the vendor in high bits, family
in the middle, model in low bits like this:

struct cpuinfo_x86 {
        union {
                struct {
                        __u8    x86_model;
                        __u8    x86;            /* CPU family */
                        __u8    x86_vendor;     /* CPU vendor */
                        __u8    x86_reserved;
                };
                __u32           x86_vfm;        /* combined vendor, family, model */
        };

Then ranges of models within (or across) familiies can work.  E.g. the
AMD Zen generation checking could be changed from:


	/* Figure out Zen generations: */
	switch (c->x86) {
	case 0x17:
		switch (c->x86_model) {
		case 0x00 ... 0x2f:
		case 0x50 ... 0x5f:
			setup_force_cpu_cap(X86_FEATURE_ZEN1);
			break;
		case 0x30 ... 0x4f:
		case 0x60 ... 0x7f:
		case 0x90 ... 0x91:
		case 0xa0 ... 0xaf:
			setup_force_cpu_cap(X86_FEATURE_ZEN2);
			break;
		default:
			goto warn;
		}
		break;

	case 0x19:
		switch (c->x86_model) {
		case 0x00 ... 0x0f:
		case 0x20 ... 0x5f:
			setup_force_cpu_cap(X86_FEATURE_ZEN3);
			break;
		case 0x10 ... 0x1f:
		case 0x60 ... 0xaf:
			setup_force_cpu_cap(X86_FEATURE_ZEN4);
			break;
		default:
			goto warn;
		}
		break;

	case 0x1a:
		switch (c->x86_model) {
		case 0x00 ... 0x0f:
		case 0x20 ... 0x2f:
		case 0x40 ... 0x4f:
		case 0x70 ... 0x7f:
			setup_force_cpu_cap(X86_FEATURE_ZEN5);
			break;
		default:
			goto warn;
		}
		break;

	default:
		break;
	}

to:

	/* Figure out Zen generations: */
	switch (c->x86_vfm) {
	case AFM(0x17, 0x00) ... AFM(0x17, 0x2f):
	case AFM(0x17, 0x50) ... AFM(0x17, 0x5f):
		setup_force_cpu_cap(X86_FEATURE_ZEN1);
		break;
	case AFM(0x17, 0x30) ... AFM(0x17, 0x4f):
	case AFM(0x17, 0x60) ... AFM(0x17, 0x7f):
	case AFM(0x17, 0x90) ... AFM(0x17, 0x91):
	case AFM(0x17, 0xa0) ... AFM(0x17, 0xaf):
		setup_force_cpu_cap(X86_FEATURE_ZEN2);
		break;
	case AFM(0x19, 0x00) ... AFM(0x19, 0x0f):
	case AFM(0x19, 0x20) ... AFM(0x19, 0x5f):
		setup_force_cpu_cap(X86_FEATURE_ZEN3);
		break;
	case AFM(0x19, 0x10) ... AFM(0x19, 0x1f):
	case AFM(0x19, 0x60) ... AFM(0x19, 0xaf):
		setup_force_cpu_cap(X86_FEATURE_ZEN4);
		break;
	case AFM(0x1a, 0x00) ... AFM(0x1a, 0x0f):
	case AFM(0x1a, 0x20) ... AFM(0x1a, 0x2f):
	case AFM(0x1a, 0x40) ... AFM(0x1a, 0x4f):
	case AFM(0x1a, 0x70) ... AFM(0x1a, 0x7f):
		setup_force_cpu_cap(X86_FEATURE_ZEN5);
		break;
	default:
		goto warn;
	}


That's more visually more compact, but maybe not any more readable.
But you would have the *option* to do this.

I'll post V2 of parts 1 & 2 with the re-ordered fields. None of the rest
of the patches need to change.

-Tony

