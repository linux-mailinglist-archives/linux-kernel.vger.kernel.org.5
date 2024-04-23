Return-Path: <linux-kernel+bounces-155242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369738AE745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A1B2514B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D8131BAA;
	Tue, 23 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfYkjj06"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8612C480;
	Tue, 23 Apr 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877360; cv=none; b=WMNeedjr11V9H6RbZ6LXkAHbia77cdSpTv2WaxBmHl1nImcNoGGs2T6ZyB0ASfkQGqDZ5ncdg0zvWI/4n5kc6CN296xBCusSOiEUlHpBxfm0BW3kEAPT9zzfruNZOCFdj5StaVVFWaz8UXd7YqL7wP6nGm7LqBJZcEK7eCr0Mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877360; c=relaxed/simple;
	bh=Lf/VZpOXMtdpoc8yxRU42eTMQeq66xPwEA/meTc985Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osaqWcQuSEU8IyDEopZmiw4vQLnk092yot4OphpHlEfWmdRADStv5Mkbt7S6zmetltfZRZbXfGDrDS9qG6Tbhqkcok+ZrV/NJaSjkcU6K2Fx5rcTxbRCLyymVce0fS5VQJgdYpTRDZnjp9FtIBCdu0S4wjVgMX00kCxF75QB85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfYkjj06; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713877356; x=1745413356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Lf/VZpOXMtdpoc8yxRU42eTMQeq66xPwEA/meTc985Y=;
  b=cfYkjj06KtBxmiPqAeffpY+shx3xb5/cU/0+17ItcVsn9nAgubJVF0MM
   UeuFv1vpWeD3Ec3YBbngL8gcSTjNnwid5RuwdiR3WV3zTWNMJ4uQzO/o6
   OPsljGvD1ulegs43RiA3IVh0caMo0ZWApKxU1HTgmYlC//JMyQxDly1hd
   lBBjOJcvwiQqOsJnyo4p8yQGDkinvBYMiHKTR9ImaqfZCM+EmfF4u1a1C
   bO1zVAwGKd4XOzN/SM1akTsSV0tCNmVbY/1DJi6wYabUdzJ2gjzlQWHYd
   FEco1BCnZR8XVY8joZeMggWC+JF56PPdJg9qBzQ//h7hA1V8CDw/6ykYK
   g==;
X-CSE-ConnectionGUID: BSo7a4TTQNuFia3OIey9RQ==
X-CSE-MsgGUID: WG7mHzGXTTeJAPsiH2qppg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9328505"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9328505"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:02:35 -0700
X-CSE-ConnectionGUID: UiApD3IFSGKsjMEreBdFcg==
X-CSE-MsgGUID: 8R3xj71WRL+fsTKqcnzhcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24964845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:02:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzFn4-00000000L4m-2gJO;
	Tue, 23 Apr 2024 16:02:30 +0300
Date: Tue, 23 Apr 2024 16:02:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86
 is enabled
Message-ID: <ZiexZnmbLqPy11d1@smile.fi.intel.com>
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0hqt6+1AvDWb0BYw0z9burVQfdkOF1qUGzRRuPmvq4qQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hqt6+1AvDWb0BYw0z9burVQfdkOF1qUGzRRuPmvq4qQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 06:37:59PM +0200, Rafael J. Wysocki wrote:
> On Sun, Apr 7, 2024 at 8:33 AM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

..

> Applied (as 6.10 material), but it looks to me like this declaration
> could be moved away from this header file at all, as the function is
> only used in one place in arch-x86 code.

Yes, we probably may move it to asm/acpi.h for x86.

I don't remember if I ever expressed that idea, but I definitely was thinking
about this.

-- 
With Best Regards,
Andy Shevchenko



