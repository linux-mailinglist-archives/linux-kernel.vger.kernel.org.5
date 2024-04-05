Return-Path: <linux-kernel+bounces-133182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028389A00C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13961B21BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622116F298;
	Fri,  5 Apr 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lew1hGE3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A41CD2B;
	Fri,  5 Apr 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328258; cv=none; b=kpIJFhU8XHsR3WXEtEDEUeJ2J4e1fEkP58H8V21KWfcAE6kWI2MYTWs4b0aSQGj8gw8iID3CAX065WRMWP6cnvEY2zUPwRVobeEtbv9uoQ+5gHbLBmc04Zf70vP+B9tns1NbQiU+CJHqogQR/7zmWlgmWQ4+yeqY36uAXGAtiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328258; c=relaxed/simple;
	bh=9dpbmAJPM0JfLCrP3RmJsaVOlpVPAps6eS3B5ySdjTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2AmlTZ5tqDCft0tywr5yZUATxkpJBVxSZP9BqVY9xeQsSUhW5RHn/Dw4sLvsMXsBk7k970geYqhlj3W8mA99eiQyPFdse3+LV8ppTa1O6hdVHBFukjo0rlMylGma4h2Tf998Ig3w7GthIgdeLeZT3CdG34DVNivyLVowFtO0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lew1hGE3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328257; x=1743864257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9dpbmAJPM0JfLCrP3RmJsaVOlpVPAps6eS3B5ySdjTc=;
  b=Lew1hGE3FSZiccajWNoBfKOL4GYvTZpq0ZXxeDzKkIiesinQEXU5ohcf
   dZHfTuroXI3NATqy3H7lf0vh31K06yMpp7E3IK6iei6SNqngTjWgP0zaq
   aRpv4jc7T2AxsbF5MQ0kU1sFUu6axGFHVXBQGXjlw2YLOrAMibI1o1tVT
   skXwYm3dTAS7zTgBATOQwn+IHg34ZBIOwEdxpOVN/ejtfRS5zNmZ5kCbZ
   XE3fKt7+prIqDHqSPprb8wRoHw3yXA47SxJbsoFiiYXCohY2TEkblaKhy
   HbbvsG1X4XUGFSX05FsktMaHfER8GI08hA8LrsViKRI8rsBpk3hX98YJ2
   w==;
X-CSE-ConnectionGUID: i33PHZTWRY2yCWP4QrP8Aw==
X-CSE-MsgGUID: WDc7KlI/QuW6mgMyde/ivg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10629400"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="10629400"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:44:16 -0700
X-CSE-ConnectionGUID: F1r6EvQCTdO8Pmwg7qg/6g==
X-CSE-MsgGUID: 0gjku4KHQB6Chw+uu1oUGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19750711"
Received: from mdawoo-mobl.amr.corp.intel.com (HELO [10.212.152.63]) ([10.212.152.63])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:44:16 -0700
Message-ID: <311c6f62-4232-417a-beb8-df9ca8a732ec@linux.intel.com>
Date: Fri, 5 Apr 2024 07:44:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ACPI: x86: Move blacklist to x86 folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
 <20240404183448.3310449-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240404183448.3310449-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 11:23 AM, Andy Shevchenko wrote:
> blacklist is built solely for x86, move it to the respective folder.

Don't you need #ifdef CONFIG_X86 for acpi_blacklisted() in
include/linux/acpi.h

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/Makefile              | 1 -
>  drivers/acpi/x86/Makefile          | 2 ++
>  drivers/acpi/{ => x86}/blacklist.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>  rename drivers/acpi/{ => x86}/blacklist.c (99%)
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 413c18e2bf61..6f4187a34f41 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -14,7 +14,6 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
>  endif
>  
>  obj-$(CONFIG_ACPI)		+= tables.o
> -obj-$(CONFIG_X86)		+= blacklist.o
>  
>  #
>  # ACPI Core Subsystem (Interpreter)
> diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
> index b97b1bcf8404..1f3c5fa84f9e 100644
> --- a/drivers/acpi/x86/Makefile
> +++ b/drivers/acpi/x86/Makefile
> @@ -3,3 +3,5 @@ acpi-x86-y		+= apple.o
>  acpi-x86-y		+= cmos_rtc.o
>  acpi-x86-y		+= s2idle.o
>  acpi-x86-y		+= utils.o
> +
> +obj-$(CONFIG_X86)	+= blacklist.o
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/x86/blacklist.c
> similarity index 99%
> rename from drivers/acpi/blacklist.c
> rename to drivers/acpi/x86/blacklist.c
> index a558d24fb788..55214d0a12b1 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/x86/blacklist.c
> @@ -17,7 +17,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  
> -#include "internal.h"
> +#include "../internal.h"
>  
>  #ifdef CONFIG_DMI
>  static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


