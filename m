Return-Path: <linux-kernel+bounces-155580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27B8AF440
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E828A9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4C13D27E;
	Tue, 23 Apr 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0gpaPKa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DE160
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890108; cv=none; b=T7C1ji/b++/cZFrjPrpqiISnSc60Oxj0AwZJggtgc46/t9TfCdDF7xidRG3LRrKRppca2qtgy6E7YHLZZ1NQFKO5XQQk4otJn2lW0HcdswaKs476knntKCv31NLfXFIYGU53AFzZFdEXfLnaV+RJaqWv3Pl1zuEavXPUeio2/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890108; c=relaxed/simple;
	bh=qQBo4zHx7NAn4ligmo6PXa4158dfnWCSpwcTjigSiFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ato3YDlEpNIY/xs0V1pRZF30L8Js+NRtxNRsH8ke4RKpO5pW8ghPvKFUR5xtT/jbvpkemzB68i2ChTNshvRLN/FU4mpiJ91VQGplaAkFJ1LxQQ9vHudxw+qCwWUL2UcYqrL1qaGUvd/q3+slcPU5C6JyQJc8SL5mNPnoNKWhqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0gpaPKa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890107; x=1745426107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qQBo4zHx7NAn4ligmo6PXa4158dfnWCSpwcTjigSiFA=;
  b=X0gpaPKas51doi7njfEd3HMnRhXA2StW4d7zGQqDqropaScaEiQG3TaH
   kk2eVVONT8rqk3T5jzMFGGZsfjaU1KYO2HS/siP6h5GjDb9GpxMIGE2Cy
   E14KlBz9l9RuNnQu8Nq/JJ6O/bpYWSoVac1y5heAH1r79Y2/huzP82dqf
   Ae25mm6eno79R+LcX6eWenKdZlU2D3ZpWD11i0evxXelbGnz4AVahOFQk
   DNLyz5NsNZRfPh5/FTjsbOYdqjSsCmn6XY6G4cqstSl7ItKtd20ny013l
   iNo9gd9SDpy1V8UDila3Y1B2an3zjbm1IVKloNvqT6n6bA77gaAqUYSu5
   w==;
X-CSE-ConnectionGUID: jEY+UHMXReWulQYIb2Ge2Q==
X-CSE-MsgGUID: 7STnRJVxRSWmR5cz12S+AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9704992"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9704992"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:35:06 -0700
X-CSE-ConnectionGUID: 7VuuzHMyT2iPnevWCzGU5A==
X-CSE-MsgGUID: zNeoL/DjSZajhbOmwZZWyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28914883"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:35:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzJ6k-00000000Og4-44xN;
	Tue, 23 Apr 2024 19:35:02 +0300
Date: Tue, 23 Apr 2024 19:35:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] auxdisplay: charlcd: Provide a forward declaration
Message-ID: <ZifjNpEetImWWcOb@smile.fi.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
 <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
 <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
 <Zhe7wK-OhvHtGTHH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhe7wK-OhvHtGTHH@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 01:30:25PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 09:30:31AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Apr 9, 2024 at 6:15 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > While there is no compilation error, strictly speaking compiler
> > > should know about used types beforehand. Provide a forward decoration
> > 
> > declaration
> 
> Thanks, I updated locally. Please, see my answer below.
> 
> > > for struct charlcd_ops before using it in struct charlcd.

..

> > > +struct charlcd_ops;
> > > +
> > >  struct charlcd {
> > >         const struct charlcd_ops *ops;
> > 
> > No forward declaration is needed at this point, as ops is a _pointer_ to
> > the structure.
> 
> The same way as in all other cases. We may drop all of them, but strictly
> speaking (as I mentioned in the commit message) this is a good practice.
> 
> I.o.w. a forward declaration of custom data types is used for _pointers_.
> 
> > >         const unsigned char *char_conv; /* Optional */

Hmm, so what's the conclusion?

-- 
With Best Regards,
Andy Shevchenko



