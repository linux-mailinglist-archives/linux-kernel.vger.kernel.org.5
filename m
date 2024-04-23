Return-Path: <linux-kernel+bounces-155609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE88AF4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FEC1C20F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287D13D8A3;
	Tue, 23 Apr 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGtrQDbg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7813BC33;
	Tue, 23 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891623; cv=none; b=AybwaoFp9zBshnrBQYm245rXnPgUOyisceutuVaIsfbgGD8QJwLywCYcqd0C8wAT12/Y1y7wJi3RnwCi0KIDIwfBxlgrJdSgSKV/Tpt6OiXQaXhA8PC7XHIOijXsokgJcbAE4duISf/ofayWqUXTRJfPK1qVWgtn9j4lGX/SUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891623; c=relaxed/simple;
	bh=TNJhzILGTBg6kieLxm1Kg7dynO7L6kmC+09K5zyThmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fi37i/NmG1fi1no7E9/5butZ87XrKX922VKQlb0OiELOpskTxdISk//j2GALyWf+DtZGwoyUKSsd3FDOT/TwyJriwGObja0aMLgaq5FF7O3tzm06WR/FqKF2UuPTkt/31asft2MDFbWZUPJIIJ/dOJRqAb+yjjsA28K9FrtmD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGtrQDbg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713891622; x=1745427622;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TNJhzILGTBg6kieLxm1Kg7dynO7L6kmC+09K5zyThmM=;
  b=AGtrQDbg0CkE3UUxRPeUYYB9qma2+XlQ2VcXuC2xwkLpVo/X//bsg7t/
   1GgYj1GNBhaChWQ4LqZeb+OrKe7PYbGUxCOZlSznYTxbVvx84LmO5tIQa
   XQ8iSAlMJcbgKf9UdoJJn/rQthCaPH/E3WA3GWuWzTdtdEuayDLIdrW66
   ovK0wlwhoTD6PHAmU/6QVcT3XxCEY23D9b44daodQQlwVtmoXsLFnN5sj
   6I/+3dqb6p8OvodN0rayUZNIx0Ru5pJwfb1XPfsKsEb6scV16PC7pSvQi
   WaR42l+qjSteONmdeTBtpo3fqCChwReta15ZdprIB9G7FmwkUj6OCL7Tm
   A==;
X-CSE-ConnectionGUID: xZB5/88JS1aqODnCdhkfYw==
X-CSE-MsgGUID: BB8sBbftTTOQMKJdYK/tBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9412794"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9412794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:00:22 -0700
X-CSE-ConnectionGUID: lSTUKt2QS/y51qNJJbjw8Q==
X-CSE-MsgGUID: 6wxuYxu9QpO1cmzDM3CmNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24467843"
Received: from fpirou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.117])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:00:19 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc:
 tags after cutter '---' line
In-Reply-To: <Ziflr9ag4Nl2lTic@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com> <ZifHnw1cxgP77MKx@smile.fi.intel.com>
 <87ttjsqbld.fsf@intel.com> <Ziflr9ag4Nl2lTic@smile.fi.intel.com>
Date: Tue, 23 Apr 2024 20:00:16 +0300
Message-ID: <87mspkqajj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Apr 23, 2024 at 07:37:34PM +0300, Jani Nikula wrote:
>> On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Tue, Apr 23, 2024 at 05:30:49PM +0300, Jani Nikula wrote:
>> >> The Cc's on the mailing list archive are harder to dig up, and do not
>> >> accurately reflect the same information.
>> >
>> > How comes? These Cc: are 1:1 mapped to the Cc: email headers.
>> 
>> Patch Cc's get mapped to email Cc's depending on personal git sendemail
>> configuration.
>> 
>> People can add more Cc's in the emails when sending.
>
> So, which exactly a proof why email headers are better for that, as they
> reflect _reality_.

No, I think the point is, commit message Cc != email message Cc, they
just have the same name.

Similar to, say, Reviewed-by, a commit message Cc may turn into an email
message Cc. But you can't make assumptions about it one way or the
other.

Imagine the commit message Cc was named "Attn:" and handled
appropriately. That probably reflects a lot of commit message Cc usage.

BR,
Jani.


>
>> Mailing list Cc's actually present in the archives depend on mailing
>> list manager configuration, and, in some cases, even the personal list
>> preferences of individual subscribers.

-- 
Jani Nikula, Intel

