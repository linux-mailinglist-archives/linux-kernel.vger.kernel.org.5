Return-Path: <linux-kernel+bounces-147278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E08A71E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425EF1F23B18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCA12E1E8;
	Tue, 16 Apr 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHfqTx0T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73B6CDC8;
	Tue, 16 Apr 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287012; cv=none; b=U2kH9QoXRDbkGjdL4nRGka0tqefkgQ+VJZbi4+hO1AykKPbPQYX1h9IJWJ2mIhRw8OhZDnYfiqurfQfn/dTDuMoca9QdfzjPY5/ntayr+TKMtC+y93WvWGo/u+J2HQFnQSwJQSywB9aMk3742nYhdD9WBrCOorUouQ5oczdp7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287012; c=relaxed/simple;
	bh=Un2VWB9hTUioCrHHhwGGPMwy0QcEr+HIPdn95f2YV34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjuDthjU/FMlvrYHCys42ySKPPaw50LFrpikbbps9+cbYmgQ5ecx3ZfP3TP2jr8eeTZTixSmFSi4YmRLupdMvif1SnMs27eEMkcilWhnFLs7L7jLnUI3BNTRGpBLHBnjkdrR6YWIsin7WIYqJQh55JkEvnGImITK/YSu/3GuK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHfqTx0T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713287008; x=1744823008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Un2VWB9hTUioCrHHhwGGPMwy0QcEr+HIPdn95f2YV34=;
  b=LHfqTx0TZirpNG+DWFwUTiRa+/sMvO9rfKYEwBtefhJ1Qc0MCe5Md0St
   vVfkG529/auTAvXrndVL9xXzCs1QMI4/6EVkGHN3VLBWCBaJJVDCxuvmd
   H2vAR9hX8I03PSKEzzEYFloa8Qpzh/KuWP/IxGYRwP1fEhMm/wJyRkoMI
   1Ge6cKV+t3ODxDhwDy3thoKKGtcfDxr8A24yGK09qKuJkCfIk6Bv81QeR
   XMRnZQ7JXPKQsBsqoboPQUr6fNkiXyQEWqvEDCsWQS2oybXotNwMf5KF6
   IYwd11TcVNDIR7HLLg5Xeri4omTLLofFpyOZPFIvL/YNrbrxdo1kcxkLC
   w==;
X-CSE-ConnectionGUID: EaoaVZ78TgyahtouOLhlwA==
X-CSE-MsgGUID: eWDjk97gSBaIW3VZsOFz/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8605567"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8605567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:03:27 -0700
X-CSE-ConnectionGUID: 77d0qG4rT22sClB14gS1Gw==
X-CSE-MsgGUID: bxNqqc0xS0Ola9R2Pq5ehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22729400"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Apr 2024 10:03:23 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwmDJ-0005b0-0h;
	Tue, 16 Apr 2024 17:03:21 +0000
Date: Wed, 17 Apr 2024 01:03:13 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, Kate Hsuan <hpa@redhat.com>
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
Message-ID: <202404170023.1zEGO9ja-lkp@intel.com>
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
[cannot apply to pavel-leds/for-next next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kate-Hsuan/platform-x86-android-tablets-other-Add-swnode-for-Xiaomi-pad2-indicator-LED/20240416-134240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240416053909.256319-5-hpa%40redhat.com
patch subject: [PATCH v6 4/5] power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20240417/202404170023.1zEGO9ja-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170023.1zEGO9ja-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170023.1zEGO9ja-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/supply/power_supply_leds.c: In function 'power_supply_update_bat_leds':
>> drivers/power/supply/power_supply_leds.c:42:17: error: implicit declaration of function 'led_mc_trigger_event'; did you mean 'led_trigger_event'? [-Werror=implicit-function-declaration]
      42 |                 led_mc_trigger_event(psy->charging_orange_full_green_trig,
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 led_trigger_event
   cc1: some warnings being treated as errors


vim +42 drivers/power/supply/power_supply_leds.c

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

