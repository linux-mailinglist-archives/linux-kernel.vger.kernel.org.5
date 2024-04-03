Return-Path: <linux-kernel+bounces-129410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C04896A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ED0288A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DD7172C;
	Wed,  3 Apr 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6uXK3Jc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685A6EB51;
	Wed,  3 Apr 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135979; cv=none; b=SeK0zW9GK1yY5OzsvTkaFh4852YLof1zbm5gTsGbQffzFZ5ewDft1/yMTAEo2Egsv/ZxMo1KwmVv7lovC61MfZ7RfRgyjxYevA2P8dGySQbJVlbhlYKFyGpJUexsLvN9eyJr2oR8ZU8xrh335nj0JnCPn05BkF3Qxou23DTQOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135979; c=relaxed/simple;
	bh=jLaiPCmPe3/Dh5xqGhZGPjsJ3JFRuGCZ91x8CsOZSQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBOZFxQt3a+nJOSEerFRmtWGErqtxvOht/O+9xuFCh0Qcd1bYvSG4Ex5duPYtCpX3My/aTfji0BZeIG/grDdQVf/mWkxxUfU46L1hSKntHHvjDJfiDKB5lX5ossSbcz+XJWuEdkrp8JhkIC+994sKn1DMBheECj/thmq2zImFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6uXK3Jc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135978; x=1743671978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jLaiPCmPe3/Dh5xqGhZGPjsJ3JFRuGCZ91x8CsOZSQo=;
  b=m6uXK3Jc5SxnBrKto8iJKH3xRualjQSN/G/t8USvpjrXxO0DQF5QplWG
   hhOzAdR2eJkk7EMZWf/UMdRFajvb04y4fUM6BAxIYnIMFv4QRxwcirNJc
   FYzbQveXHGhm2CeMn0447wV5VIb4jyhY9RpJfe6D9BGTsao5nuPiGIoPV
   pkyqmNYF1CPIRMTfsN6nAGaV3CLxWSG9jbTYjAkzY7U/zLz8EBPJsifXl
   481cIpdE6YzT2v4AdsBJI9E+c9GUMqf01vKnR71M6esKGugAPpL23ltsA
   HbQCdDX+Z4dYM+muCsQatP8LX1OysxiqRmhy+PoR+hEHnIIk7+Krmh0ax
   g==;
X-CSE-ConnectionGUID: 6edddy5hTkOQXAdA8vSY4Q==
X-CSE-MsgGUID: mlFekX4RSGmUq9TXl3z2Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7217727"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7217727"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915175517"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915175517"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:19:34 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrwmK-000000014YC-3TUE;
	Wed, 03 Apr 2024 12:19:32 +0300
Date: Wed, 3 Apr 2024 12:19:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 34/34] kbuild: always enable -Wunused-const-variable
Message-ID: <Zg0fJPx_LTXAWT_I@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-35-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-35-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:52AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The last such warnings are fixed now, so the option can be enabled by default.

> @@ -96,7 +96,6 @@ else
>  # Some diagnostics enabled by default are noisy.
>  # Suppress them by using -Wno... except for W=1.
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)

What about line #43 in this file?

Citing 40-43 below:

# These warnings generated too much noise in a regular build.
# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)

-- 
With Best Regards,
Andy Shevchenko



