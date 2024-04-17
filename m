Return-Path: <linux-kernel+bounces-148527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472358A83FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B6F2854D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635F13D299;
	Wed, 17 Apr 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfYHVyGa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6713D265;
	Wed, 17 Apr 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359641; cv=none; b=l3egTsOkcnyB1noCl81Rx6Nl8Q6KLFkDlXV8O2A2/T3NdVNBPoYhTopOh1kACKfONDUcQOICbQsyCkX7j6Xco0T+1DPvyA+jhHw/FgfG0DJJZ2X3EXv02D9ak03Ekq0k9UttoNCXwvfsNoK89i1p7f6EilfSSkca8o2w+8DFMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359641; c=relaxed/simple;
	bh=XVrBhz63k5iaVlC5eR2S2TPWPIQYlVoRr+xpqxATrpI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JEQI9PyqeIWntHaVcr1p27v/imn8c/ODhI3A9R6yyv4fIm7i45qQsowDDY/oFBMeS64LzqaoV7dcYP+SHqM5yFDtwuhdi4ten9AZ6FGhrSnBIiPXwz89FvmRb75p/GFVAtHC5bg/h9al5SaO4Tm3bqYMwCDuf4WQ+uM1omVaRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfYHVyGa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713359640; x=1744895640;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XVrBhz63k5iaVlC5eR2S2TPWPIQYlVoRr+xpqxATrpI=;
  b=cfYHVyGaKA0Bev7C0yUGEbwZGowPLigpyUSBgZjLlQ/OYkTFzMwFqTVI
   Dn8mF2+R5wmFQv2yaGcIHatnbaQLR8vAPAXA+ZD/9JUlHNj59IBYjPjZ9
   ESljf0Qdy9KG+KItOXGv5WznKUkcCuTED7czaryoCkr3nTDvWkSSAccAo
   L0/CBWMHHUBpRWNUcrXXeNUgr7Xg2Lziq1vRZmIrxk67K8D/RCVnARaYy
   xfZoKrbNkrRolXlas96jIS4uQbW1PnwDT6zvkaHBbxKq8t1SEfUrSEISj
   uPWtRfhKcC2wWxCeAqKii7GzCPuOw6LIhkJPXuSiGIRGHSLmivGUicSvb
   w==;
X-CSE-ConnectionGUID: JO/GsW+vSr61kaChutsJvw==
X-CSE-MsgGUID: mMnS+j1CQRWnGzeZb3tcdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19997295"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="19997295"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:13:59 -0700
X-CSE-ConnectionGUID: wHxRZ53gS9ChLi8YcqDuLw==
X-CSE-MsgGUID: lft0N95FSa6MO+oU/IOQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="45919609"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:13:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 16:13:52 +0300 (EEST)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] Documentation/ABI: Add document for Mellanox PMC
 driver
In-Reply-To: <b2a3ca5502008dbe4d07a5d07493022c04c135d6.1713334019.git.shravankr@nvidia.com>
Message-ID: <fd7c3b6c-8e5a-6112-b825-ba17763a8094@linux.intel.com>
References: <cover.1713334019.git.shravankr@nvidia.com> <b2a3ca5502008dbe4d07a5d07493022c04c135d6.1713334019.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Apr 2024, Shravan Kumar Ramani wrote:

> The sysfs interface is created for programming and monitoring the
> performance counters in various HW blocks of Mellanox BlueField-1,
> BlueField-2 and BlueField-3.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---

This documents the existing sysfs files? Which is good, thank you!

However, there's still no PATCH 4/ which would document the new interface 
added by this series, namely use_odd_counter and count_clock, am I 
correct?

-- 
 i.

>  .../ABI/testing/sysfs-platform-mellanox-pmc   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> new file mode 100644
> index 000000000000..47094024dbeb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> @@ -0,0 +1,49 @@
> +HID           Driver         Description
> +MLNXBFD0      mlxbf-pmc      Performance counters (BlueField-1)
> +MLNXBFD1      mlxbf-pmc      Performance counters (BlueField-2)
> +MLNXBFD2      mlxbf-pmc      Performance counters (BlueField-3)
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event_list
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		List of events supported by the counters in the specific block.
> +		It is used to extract the event number or ID associated with
> +		each event.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event<N>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Event monitored by corresponding counter. This is used to
> +		program or read back the event that should be or is currently
> +		being monitored by counter<N>.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/counter<N>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Counter value of the event being monitored. This is used to
> +		read the counter value of the event which was programmed using
> +		event<N>. This is also used to clear or reset the counter value.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/enable
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Start or stop counters. This is used to start the counters
> +		for monitoring the programmed events and also to stop the
> +		counters after the desired duration.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/<reg>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Value of register. This is used to read or reset the registers
> +		where various performance statistics are counted for each block.
> +
> 

