Return-Path: <linux-kernel+bounces-147750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153968A7893
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462C51C20E80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8D13A86B;
	Tue, 16 Apr 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h78knIKr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0213A41B;
	Tue, 16 Apr 2024 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310106; cv=none; b=XqZtDkKLNLHRWUXtrIudd09NFkLGg7xi0QWoP+P8aaPQdbsRcagU2ATPyYDCQ9ZHgOnq/1xPpZ/rEdtup7MsRW/d9bRPqde7hcZI+dpRlAVYNeeZaW25+ETnQoyE2ZviD7PG51niINiuOsk0nGGYIimctcKaQU/Zw13xLGx4Cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310106; c=relaxed/simple;
	bh=RWjT95QphPZ5AOknCIiCxI3mE5E53bV0YbYg4KQf3RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHQG9iUfOIO1HsFzwHprtlITSKfZQ2YfFrfVNxx3cR46DN/gdu4O+bJLoQFZwdE1MF8kV0p4Px73pIMnzCw21v3iC+4stMosuN+dVPuH5/fQljUeVpt86Wc9i22XLmiRTHk7x3qyEogOnxQbA+bN/kPPu/sBZUpO3Q72fZN5a7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h78knIKr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713310104; x=1744846104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWjT95QphPZ5AOknCIiCxI3mE5E53bV0YbYg4KQf3RQ=;
  b=h78knIKr/ZjKUgK6sV9HLmgvLDdw+UcVTUzM/MdQqpwJF/sdmKcYApPp
   d7iLFTG4vxWgwZZ3cKN6l7pXM2GSrMSmN4pEhdd0AUtQ8xdAHRXVZIsFC
   VOoWRnWxOe3Nxmzf/jA6jT8kt0Qbo7IjhqCY4BFMMlcrHFruNd+8R/EpF
   8QiCp6Dhp0OnQPzyc5awLqPl4QLMriVGgIVjxym3gVPNpsjEpExG+0x/v
   zeQk3GtglTEPBNMZZmtBPvrIndnZ5aFBKtZ1UDCDRn1iu005gLac+BZks
   kSdjfBTjhysosD1R9NXPA9Ws3f4DRiOe9UJvzCGHjnTDDbtORzxHWtmdj
   w==;
X-CSE-ConnectionGUID: ohl2ZBz3RAac/o8kfZFKOA==
X-CSE-MsgGUID: 1OSof5m0TX+rOrzrN0NfoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26294546"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26294546"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:28:20 -0700
X-CSE-ConnectionGUID: H/mRELqoQU6ABXfhBxqDvQ==
X-CSE-MsgGUID: EjFeB3IYQ/2rC9oO8AUjYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22478448"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2024 16:28:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwsDm-0005qD-2G;
	Tue, 16 Apr 2024 23:28:14 +0000
Date: Wed, 17 Apr 2024 07:27:50 +0800
From: kernel test robot <lkp@intel.com>
To: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kate Hsuan <hpa@redhat.com>
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
Message-ID: <202404170705.Or8MFKNi-lkp@intel.com>
References: <20240416053909.256319-5-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416053909.256319-5-hpa@redhat.com>

Hi Kate,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on lee-leds/for-leds-next linus/master v6.9-rc4]
[cannot apply to next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kate-Hsuan/platform-x86-android-tablets-other-Add-swnode-for-Xiaomi-pad2-indicator-LED/20240416-134240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240416053909.256319-5-hpa%40redhat.com
patch subject: [PATCH v6 4/5] power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240417/202404170705.Or8MFKNi-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170705.Or8MFKNi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170705.Or8MFKNi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/power_supply_leds.c:42:3: error: implicit declaration of function 'led_mc_trigger_event' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   led_mc_trigger_event(psy->charging_orange_full_green_trig,
                   ^
   drivers/power/supply/power_supply_leds.c:42:3: note: did you mean 'led_trigger_event'?
   include/linux/leds.h:489:6: note: 'led_trigger_event' declared here
   void led_trigger_event(struct led_trigger *trigger,  enum led_brightness event);
        ^
   1 error generated.


vim +/led_mc_trigger_event +42 drivers/power/supply/power_supply_leds.c

    21	
    22	static void power_supply_update_bat_leds(struct power_supply *psy)
    23	{
    24		union power_supply_propval status;
    25		unsigned int intensity_green[3] = {255, 0, 0};
    26		unsigned int intensity_orange[3] = {128, 0, 255};
    27		unsigned int intensity_red[3] = {0, 0, 255};
    28	
    29		if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
    30			return;
    31	
    32		dev_dbg(&psy->dev, "%s %d\n", __func__, status.intval);
    33	
    34		switch (status.intval) {
    35		case POWER_SUPPLY_STATUS_FULL:
    36			led_trigger_event(psy->charging_full_trig, LED_FULL);
    37			led_trigger_event(psy->charging_trig, LED_OFF);
    38			led_trigger_event(psy->full_trig, LED_FULL);
    39			/* Going from blink to LED on requires a LED_OFF event to stop blink */
    40			led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
    41			led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
  > 42			led_mc_trigger_event(psy->charging_orange_full_green_trig,
    43					     intensity_green,
    44					     ARRAY_SIZE(intensity_green),
    45					     LED_FULL);
    46			break;
    47		case POWER_SUPPLY_STATUS_CHARGING:
    48			led_trigger_event(psy->charging_full_trig, LED_FULL);
    49			led_trigger_event(psy->charging_trig, LED_FULL);
    50			led_trigger_event(psy->full_trig, LED_OFF);
    51			led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
    52			led_mc_trigger_event(psy->charging_orange_full_green_trig,
    53					     intensity_orange,
    54					     ARRAY_SIZE(intensity_orange),
    55					     LED_FULL);
    56			break;
    57		default:
    58			led_trigger_event(psy->charging_full_trig, LED_OFF);
    59			led_trigger_event(psy->charging_trig, LED_OFF);
    60			led_trigger_event(psy->full_trig, LED_OFF);
    61			led_trigger_event(psy->charging_blink_full_solid_trig,
    62				LED_OFF);
    63			led_mc_trigger_event(psy->charging_orange_full_green_trig,
    64					     intensity_red,
    65					     ARRAY_SIZE(intensity_red),
    66					     LED_OFF);
    67			break;
    68		}
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

