Return-Path: <linux-kernel+bounces-161939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B38B5397
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90A3281237
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549151805E;
	Mon, 29 Apr 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USY0V7BX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEE17C61;
	Mon, 29 Apr 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381083; cv=none; b=OXp89+BV6VrdkINdV4fh2NTzElg5vOs3ZS48fA0aSMRhfk1F5yrIu8Geg2zCLAK7XdpG25QEYmlsMXpzSSJe0vhwtnOQBuAULOe330LY971hlp+VGGcdEarLFR3ISAVaWb17FhHe+jy4aVT7WgVD70X+du8FRvpfmp+k4OLPcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381083; c=relaxed/simple;
	bh=M4a//tB14SY34//ET05IxTBHfSZ0qWozPe6V/QGR5G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K41i45rheVd1uotf+kmDtra4muPzJl1DrEV0KLyiv3YSk1+HH8YEqAAPNFjCV3vhXtc7CMIYr7/GYdKU7PUTDQHQ+txg8T3HZ9kgdfnoLOcozBcdL5jfBeoYjXd9zaVIksbcjNoA5Af94AHisy/8NRI0RGbxrQbgvcJvcG19p34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USY0V7BX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714381082; x=1745917082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4a//tB14SY34//ET05IxTBHfSZ0qWozPe6V/QGR5G0=;
  b=USY0V7BXnEai50hd5NcAB4c2cjp3aDAHETqitegFGYiJmRi3d4dS9Ez+
   3N520+wC3GLgqplTgJBloiYq2wEUgr2Ysi3bW0kb8VwVMjIxZFdYP95rm
   SRO9HFdVVgfH5J39EBjoeTyfvTVuPl255zam3l3+TdjycBmNszD26rQU7
   fE9v+7GfAvoYfL7uzYWXAz/W+Si65XY8/5xtebcVxsE56wINkUf3M6sWH
   egBdd726hmia2OOy6t3P2TiVfT5ilT/Vvpf831QDTcaiwzXMwqjeHtsOe
   Gs+IPq0Bjti/3lmZ7x79OsMnxp+oMF2+AfZGvMdOG/JfJ96ZBftwbCgn0
   Q==;
X-CSE-ConnectionGUID: ZVXIlvQvQ+OTQg1NTXBnig==
X-CSE-MsgGUID: 6Y1dhmgbQa2xdojczxBf9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13821087"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13821087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:58:01 -0700
X-CSE-ConnectionGUID: yOtsl2o6RJuzC0Pn19N3sg==
X-CSE-MsgGUID: 84T2sAI1Slenx/37+HTUTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26035129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:58:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Mph-00000002GMQ-2bOl;
	Mon, 29 Apr 2024 11:57:57 +0300
Date: Mon, 29 Apr 2024 11:57:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] ACPI: Move acpi_blacklisted() declaration to
 asm/acpi.h
Message-ID: <Zi9hFbrIfyDhrA5R@smile.fi.intel.com>
References: <20240429040441.748479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429040441.748479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 28, 2024 at 09:04:41PM -0700, Kuppuswamy Sathyanarayanan wrote:
> The function acpi_blacklisted() is defined only when CONFIG_X86 is
> enabled and is only used by X86 arch code. To align with its usage and
> definition conditions, move its declaration to asm/acpi.h

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

..

>  extern char acpi_video_backlight_string[];
>  extern long acpi_is_video_device(acpi_handle handle);
> -extern int acpi_blacklisted(void);

I would replace it with a blank line (to me it seems the above and below are
different groups from semantic point of view, but Rafael may correct me).

>  extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);

-- 
With Best Regards,
Andy Shevchenko



