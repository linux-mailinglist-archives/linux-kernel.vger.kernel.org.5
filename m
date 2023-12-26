Return-Path: <linux-kernel+bounces-11331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4281E4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 04:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B7282C38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637B107B2;
	Tue, 26 Dec 2023 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQKwbJYM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F310793
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703560078; x=1735096078;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4sOfdLjctTbsDq9TJboZiHNGXoyeVfXJBH3M0tpQ1L0=;
  b=IQKwbJYMMMo4EjVbMalAATs3G2Jeck2P0EfuPQHIi0L+mjndPZDOGdKF
   0WlKpSEMb+DHihoGhHHCG4xOqaWtRp9J8k/lL5uhfayJBzLP21OeiAe45
   CakXgUmuSIfaDvUcu4pMtq895jhVIfPBVdIgZYEiuVdfr7Kb2nZSz6fBq
   Z4G1kFYQn/sDdFCPKO/tTt074DPdvdjpzoLLHVTJwvNGTS00/p+6FqKWX
   oLv2ni4HNqHZZWnBBU0jZKFe/9MjllLULAidN1ObvozhJkVd87yDQentG
   L43wyo45Jje8ir9zKqSh4EYOfuXq/n1zhUExQnnuVbvz6lvJd138CZ119
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3399530"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3399530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 19:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848323553"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="848323553"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Dec 2023 19:07:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHxnM-000Dwb-2T;
	Tue, 26 Dec 2023 03:07:52 +0000
Date: Tue, 26 Dec 2023 11:07:51 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-magicmouse.c:146: warning: Function parameter or
 member 'battery_timer' not described in 'magicmouse_sc'
Message-ID: <202312261056.AmFPDIL5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 0b91b4e4dae63cd43871fc2012370b86ee588f91 HID: magicmouse: Report battery level over USB
date:   2 years, 1 month ago
config: x86_64-randconfig-x066-20230529 (https://download.01.org/0day-ci/archive/20231226/202312261056.AmFPDIL5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261056.AmFPDIL5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261056.AmFPDIL5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hid/hid-magicmouse.c:146: warning: Function parameter or member 'hdev' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:146: warning: Function parameter or member 'work' not described in 'magicmouse_sc'
>> drivers/hid/hid-magicmouse.c:146: warning: Function parameter or member 'battery_timer' not described in 'magicmouse_sc'


vim +146 drivers/hid/hid-magicmouse.c

4f6fdf08681cecd Chase Douglas 2011-08-05   89  
4f6fdf08681cecd Chase Douglas 2011-08-05   90  #define TRACKPAD_DIMENSION_X (float)13000
4f6fdf08681cecd Chase Douglas 2011-08-05   91  #define TRACKPAD_MIN_X -2909
4f6fdf08681cecd Chase Douglas 2011-08-05   92  #define TRACKPAD_MAX_X 3167
4f6fdf08681cecd Chase Douglas 2011-08-05   93  #define TRACKPAD_RES_X \
4f6fdf08681cecd Chase Douglas 2011-08-05   94  	((TRACKPAD_MAX_X - TRACKPAD_MIN_X) / (TRACKPAD_DIMENSION_X / 100))
4f6fdf08681cecd Chase Douglas 2011-08-05   95  #define TRACKPAD_DIMENSION_Y (float)11000
4f6fdf08681cecd Chase Douglas 2011-08-05   96  #define TRACKPAD_MIN_Y -2456
4f6fdf08681cecd Chase Douglas 2011-08-05   97  #define TRACKPAD_MAX_Y 2565
4f6fdf08681cecd Chase Douglas 2011-08-05   98  #define TRACKPAD_RES_Y \
4f6fdf08681cecd Chase Douglas 2011-08-05   99  	((TRACKPAD_MAX_Y - TRACKPAD_MIN_Y) / (TRACKPAD_DIMENSION_Y / 100))
4f6fdf08681cecd Chase Douglas 2011-08-05  100  
9d7b18668956c41 Sean O'Brien  2018-10-02  101  #define TRACKPAD2_DIMENSION_X (float)16000
9d7b18668956c41 Sean O'Brien  2018-10-02  102  #define TRACKPAD2_MIN_X -3678
9d7b18668956c41 Sean O'Brien  2018-10-02  103  #define TRACKPAD2_MAX_X 3934
9d7b18668956c41 Sean O'Brien  2018-10-02  104  #define TRACKPAD2_RES_X \
9d7b18668956c41 Sean O'Brien  2018-10-02  105  	((TRACKPAD2_MAX_X - TRACKPAD2_MIN_X) / (TRACKPAD2_DIMENSION_X / 100))
9d7b18668956c41 Sean O'Brien  2018-10-02  106  #define TRACKPAD2_DIMENSION_Y (float)11490
9d7b18668956c41 Sean O'Brien  2018-10-02  107  #define TRACKPAD2_MIN_Y -2478
9d7b18668956c41 Sean O'Brien  2018-10-02  108  #define TRACKPAD2_MAX_Y 2587
9d7b18668956c41 Sean O'Brien  2018-10-02  109  #define TRACKPAD2_RES_Y \
9d7b18668956c41 Sean O'Brien  2018-10-02  110  	((TRACKPAD2_MAX_Y - TRACKPAD2_MIN_Y) / (TRACKPAD2_DIMENSION_Y / 100))
9d7b18668956c41 Sean O'Brien  2018-10-02  111  
128537cea464d91 Michael Poole 2010-02-06  112  /**
128537cea464d91 Michael Poole 2010-02-06  113   * struct magicmouse_sc - Tracks Magic Mouse-specific data.
128537cea464d91 Michael Poole 2010-02-06  114   * @input: Input device through which we report events.
128537cea464d91 Michael Poole 2010-02-06  115   * @quirks: Currently unused.
128537cea464d91 Michael Poole 2010-02-06  116   * @ntouches: Number of touches in most recent touch report.
128537cea464d91 Michael Poole 2010-02-06  117   * @scroll_accel: Number of consecutive scroll motions.
128537cea464d91 Michael Poole 2010-02-06  118   * @scroll_jiffies: Time of last scroll motion.
128537cea464d91 Michael Poole 2010-02-06  119   * @touches: Most recent data for a touch, indexed by tracking ID.
128537cea464d91 Michael Poole 2010-02-06  120   * @tracking_ids: Mapping of current touch input data to @touches.
128537cea464d91 Michael Poole 2010-02-06  121   */
128537cea464d91 Michael Poole 2010-02-06  122  struct magicmouse_sc {
128537cea464d91 Michael Poole 2010-02-06  123  	struct input_dev *input;
128537cea464d91 Michael Poole 2010-02-06  124  	unsigned long quirks;
128537cea464d91 Michael Poole 2010-02-06  125  
128537cea464d91 Michael Poole 2010-02-06  126  	int ntouches;
128537cea464d91 Michael Poole 2010-02-06  127  	int scroll_accel;
128537cea464d91 Michael Poole 2010-02-06  128  	unsigned long scroll_jiffies;
128537cea464d91 Michael Poole 2010-02-06  129  
128537cea464d91 Michael Poole 2010-02-06  130  	struct {
128537cea464d91 Michael Poole 2010-02-06  131  		short x;
128537cea464d91 Michael Poole 2010-02-06  132  		short y;
c04266889b59116 Chase Douglas 2010-06-20  133  		short scroll_x;
128537cea464d91 Michael Poole 2010-02-06  134  		short scroll_y;
d4b9f10a0eb64c6 José Expósito 2021-07-07  135  		short scroll_x_hr;
d4b9f10a0eb64c6 José Expósito 2021-07-07  136  		short scroll_y_hr;
128537cea464d91 Michael Poole 2010-02-06  137  		u8 size;
9d60648c607a2bf José Expósito 2021-07-07  138  		bool scroll_x_active;
9d60648c607a2bf José Expósito 2021-07-07  139  		bool scroll_y_active;
128537cea464d91 Michael Poole 2010-02-06  140  	} touches[16];
128537cea464d91 Michael Poole 2010-02-06  141  	int tracking_ids[16];
c0dc5582812dfaf John Chen     2021-03-30  142  
c0dc5582812dfaf John Chen     2021-03-30  143  	struct hid_device *hdev;
c0dc5582812dfaf John Chen     2021-03-30  144  	struct delayed_work work;
0b91b4e4dae63cd José Expósito 2021-11-18  145  	struct timer_list battery_timer;
128537cea464d91 Michael Poole 2010-02-06 @146  };
128537cea464d91 Michael Poole 2010-02-06  147  

:::::: The code at line 146 was first introduced by commit
:::::: 128537cea464d919febeaea2000e256749f317eb HID: add a device driver for the Apple Magic Mouse.

:::::: TO: Michael Poole <mdpoole@troilus.org>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

