Return-Path: <linux-kernel+bounces-133184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DA89A00F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4368D1C21B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B416F299;
	Fri,  5 Apr 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXIsGZFI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954416F282;
	Fri,  5 Apr 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328332; cv=none; b=oaAkHS+xhuafWzQIu6kM6xY9omsBJJKpdGaxeFGRtloENCXAak4DsNDtvOUjDMzgp3U1dZfC1QS8sivF9hr497LjqVxkmEs0fu2k7dI03YHx7EtKzwfkUgA04UktWuONcz47dh4y2/X2TZDZRyUdRryqS3E2nQf1KvzqdaodVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328332; c=relaxed/simple;
	bh=wx0o2Z5tSAT890BrFAAEPL/keq/8qKXJCb6Gvx7H1Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaxTjeWcuPS5xKeyPnNsPF0X8zVu+wimCtL6jtY+pEZ3hzwD1ql21nxTRtqj5BlZYLsiXf5IMSvj0jx4y4XKxFBNap9iq9Lgi2KY5Rvz8Gq1jojIXlCzrxRbbl0R4EJFgnruwJ9m0rXp7ZOEh3yiCaHkoooEoB5/B4hfB02OKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXIsGZFI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328331; x=1743864331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wx0o2Z5tSAT890BrFAAEPL/keq/8qKXJCb6Gvx7H1Tc=;
  b=FXIsGZFImr95O8Yqc0f3lyrwNhz3I76k+cdclf9CH0jLCeXBZRXqBPXH
   UI7zPo1lRDsXcHdNUTY+xDekDLYij456hZc03bqjpSeySpTqW49anNmR8
   K/w015mxfeSfjTNlMAG8FAD77Ad6VU4GJ3ZfCtvZXy0T8f/NbYMfQ57Dp
   y+Injtu97ZMIWQDb7Mb4zsBFHDP+t8yAvkhTwD/L5YYEdEmYcfE128OV1
   quhyHHEhrzplY9VgG15FCqBePMrqV3XPgS6+BPIW2e7tzC0U88Qj6cdBn
   vwESVS9br+vMWD0x4PJZHO4Xf0qUWMXfmxBeJG8ibTwQFOPFOxQGksGi3
   w==;
X-CSE-ConnectionGUID: FtTfUEq3SeuK3Y/6GJobPg==
X-CSE-MsgGUID: KIHBIVVdQNad4if/mS2tKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10629563"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="10629563"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:45:30 -0700
X-CSE-ConnectionGUID: 0coRnFRuQImk/HMaCOpNkw==
X-CSE-MsgGUID: lvWCND/2RpmQWbUDm286kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19750839"
Received: from mdawoo-mobl.amr.corp.intel.com (HELO [10.212.152.63]) ([10.212.152.63])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:45:30 -0700
Message-ID: <aac4b3ea-72dc-4afd-8f1f-06821de953c4@linux.intel.com>
Date: Fri, 5 Apr 2024 07:45:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ACPI: x86: Move x86 stuff into dedicated folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 11:23 AM, Andy Shevchenko wrote:
> Move x86 related modules (which are solely for x86) to the dedicated
> folder.
> Note, there are more modules, but they are related to tables and
> potentially might be used for other architectures in the future.
> Hence touched only non-table related code.

Except the blacklisted patch Nit, rest looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> In v2:
> - fixed acpi_lpss_init() stub visibility (LKP)
>
> Andy Shevchenko (4):
>   ACPI: x86: Introduce a Makefile
>   ACPI: x86: Move acpi_cmos_rtc to x86 folder
>   ACPI: x86: Move blacklist to x86 folder
>   ACPI: x86: Move LPSS to x86 folder
>
>  drivers/acpi/Makefile                            | 7 +------
>  drivers/acpi/internal.h                          | 3 ++-
>  drivers/acpi/x86/Makefile                        | 8 ++++++++
>  drivers/acpi/{ => x86}/blacklist.c               | 2 +-
>  drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} | 2 +-
>  drivers/acpi/{acpi_lpss.c => x86/lpss.c}         | 2 +-
>  6 files changed, 14 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/acpi/x86/Makefile
>  rename drivers/acpi/{ => x86}/blacklist.c (99%)
>  rename drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} (98%)
>  rename drivers/acpi/{acpi_lpss.c => x86/lpss.c} (99%)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


