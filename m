Return-Path: <linux-kernel+bounces-69838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF13858F58
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A3EB217F0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A67A703;
	Sat, 17 Feb 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI4RXhH/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A3171A4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173332; cv=none; b=ZZLQhRDUKlVy2jFZdT3Vnh36vQE9VtnhMVlv9seB2KdQuIB30vzbalLfZd9HLr9Mu74GiT84Q5rsSbpTqVQ5e65bvZu7Gwsj2T7yEskQLVA8hr9Ckq8KMTZ39XQqMwmIi5FquMPxBnAxJ+Cgs8KZhrItj1q4VzHLM0WhY8Uclhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173332; c=relaxed/simple;
	bh=dxYmYjvFhU5nWz52Hqun3yHSuCsp6TLZ1/ueI0sBGp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8xDyVcrf5K6aAXUeq5KAejzXQTF0/fyoICXDKVVwEYIiRl/d0w+eZfNGgyr4pWCfhaQkhpoUJTxEvxsr6nawsmmEPl0Icrj0LrESduI5NOxIqBBgYCmCYsdlMmBWxcLyzQpewsGHjOcX6tURv3ZibEsdmAKNR6lA2cnMN81LgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI4RXhH/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708173329; x=1739709329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dxYmYjvFhU5nWz52Hqun3yHSuCsp6TLZ1/ueI0sBGp0=;
  b=jI4RXhH/rSLE9f6ESarxlMnPg80Sk3PcDOmcR47BkQhOX0gVCBOa2yXg
   9Uspd9IKXJJvc/isWM06YRoUCvmefr6Wl3QUPApI2V+yrMFNWoDD7Hy8F
   nAiAl1bdDyH9VoNpowJPi9mCDUg9KhoVywXfFwpBF1RyNeHSHRqomMwP3
   kkVx178Dh24ypJeXmUm+kF6uoQJgTTbw6cW+cu5cOMkF177VwVGndYQRx
   Ylieg2PGpKIe3rQMpBxvXLku/aBL93/LgTQ5ZcicJlrqtfREp5DCKMTdB
   xld06M86JyaVX6RnoSoI9bwXA+6LfclNmjvMV2fmYZ89luRNoU01R9BQy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12925712"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="12925712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 04:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="935994551"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="935994551"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2024 04:35:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AFA0C2E9; Sat, 17 Feb 2024 14:35:23 +0200 (EET)
Date: Sat, 17 Feb 2024 14:35:23 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>, 
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"keescook@chromium.org" <keescook@chromium.org>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/8] mm: Use get_unmapped_area_vmflags()
Message-ID: <35rzsyepg3wx5vjsyd5n5pix2c5oo6pibzfmdvlfbpmf2mvvgy@icrlxlydgs6z>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-4-rick.p.edgecombe@intel.com>
 <gs2yekj24y5jedpvpwvsfdhnr23epkpcatmwhcmyaerke7ooon@55dgxhlf5llq>
 <6d034d561dcab4300a7eb66e34e2a03aaf17ea79.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d034d561dcab4300a7eb66e34e2a03aaf17ea79.camel@intel.com>

On Fri, Feb 16, 2024 at 10:15:05PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-02-16 at 14:56 +0200, Kirill A. Shutemov wrote:
> > > +unsigned long
> > > +get_unmapped_area(struct file *file, unsigned long addr, unsigned
> > > long len,
> > > +               unsigned long pgoff, unsigned long flags)
> > > +{
> > > +       return __get_unmapped_area(file, addr, len, pgoff, flags,
> > > 0);
> > > +}
> > >   EXPORT_SYMBOL(get_unmapped_area);
> > 
> > Any reason it is not a static inline function in the header file?
> 
> get_unmapped_area() doesn't seem to be referenced from any modules. I
> don't think it needs to be exported actually. Maybe it used to be?
> 
> It could be a static inline it seems. Why are you thinking it would be
> better?

That's just what I would do for legacy interface wrapper for new function
interface. And save a function call for caller (it shouldn't matter in
this case, but still).

> I think maybe get_unmapped_area() should stay as is, static-inline
> wise, but remove the export, and the newly added __get_unmapped_area()
> should be made static. Does it sound reasonable?

Up to you.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

