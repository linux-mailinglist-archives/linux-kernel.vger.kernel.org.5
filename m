Return-Path: <linux-kernel+bounces-87396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876486D3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1EB1F23910
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F013F436;
	Thu, 29 Feb 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOtieByr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91477A125;
	Thu, 29 Feb 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236847; cv=none; b=O7Jo/jdfRjVlVbiBVBx+FbtWlcxA4ppy2XE8dPdI/mcCPgwzcje42/L+tKz/WXnypFaez39pZGnd2hxh6eadG7mdhwxWp8RaUwBH8HXQ7D6Ad5MJ2ZfTjVS3KJXLcyTa4jEdhzAvNips+7RP54Rx1YgrEwK3ppsKcHKLNuolE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236847; c=relaxed/simple;
	bh=pgMPjnzpWVwWRax5G9fKHRUUN5IDvl4E8Lqx/QZdIyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVTUL59uxV1CE6szegIC3tXYRey9Mj8UjSYSE5I1RCX+beB8ypyh/dzCIT2XJuVT59F5dA1zixix/uEVGVnDHCknzX/AbIFP9nCd3Fp2UoAPx1vdacUrUpmeO8ebTbpa62eGRIq5wXH+AFc2WeXaigJXgfUAoMy9Bfo3ksFqxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOtieByr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709236846; x=1740772846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pgMPjnzpWVwWRax5G9fKHRUUN5IDvl4E8Lqx/QZdIyg=;
  b=ZOtieByr5ATnyeWbDDZNXYNcuY1EKzMZ7MNGtb5wJ7AS/EZ7FappYSQd
   LLxSKjeEQYp/Fg8N/Z0rDmI0rhYBlHx/oK1eFKYJ2Sm5hihaXCltClz9v
   8+0HLzDDiGqpCuApERqcNkkt9srbHbQnvIWNlHbGKn5asYGYXvN4EyNPQ
   vLHsRXSmg01RC+4Jy1+3+0FQNL/EvyA8WTApPifEr14k2cmt6Otz/BlNY
   Vgv/ccEezonpqBt5OE7JgAQmMMClppNn3c1RxcIcKaL3IHJs8E8PNdYGv
   RQKNysq4XX/bPZa8JRdgCFmNq2u6qn/OzzEXuzNasT9DOPvwmrcVqeHRx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14376081"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14376081"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913991086"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913991086"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:00:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfma6-00000008m8s-3tH6;
	Thu, 29 Feb 2024 22:00:38 +0200
Date: Thu, 29 Feb 2024 22:00:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Message-ID: <ZeDiZrrLuqkvxrIY@smile.fi.intel.com>
References: <20240223165942.work.950-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223165942.work.950-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 08:59:45AM -0800, Kees Cook wrote:
> The UBSAN instrumentation cannot work in the vDSO since it is executing
> in userspace, so disable it in the Makefile. Fixes the build failures
> such as:
> 
> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: sparclinux@vger.kernel.org

I dunno how you applied patches, but these Cc seems to appear in a few commits
in your hardening branch.

I formatted patch from 9fd54b08040669, checked out the new branch just before
this commit and run `git am 0001-...`. I don't see them.

-- 
With Best Regards,
Andy Shevchenko



