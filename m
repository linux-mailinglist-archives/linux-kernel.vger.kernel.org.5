Return-Path: <linux-kernel+bounces-1982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71808156B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2D61C247EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64491875;
	Sat, 16 Dec 2023 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp0KRbbW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01231C3B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702696682; x=1734232682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eHeryBGsJXOFEcY8WhTugHf+0DtcnaZL7hV4Fgt3spU=;
  b=gp0KRbbWYWNuIL3m/cGxHPlFkZZkw6DRS7zQHz0GkduXMeTGltB8kd4+
   doSesOVMbBd5RlMTjB0Ah4rzCnyh8XVd03/yRK5MPTDjpSvGUo8HIqRZs
   QPrAnWOlAxAQvyrZlRPOL5XcxJLiI80KMZEkKSTk9fBBfbT5FRaPVvi6r
   WI6/72CHXvgVDVjS42KGse/0sX76RMqB2fMo2HmCiqUzEWTAdEFj/Jopv
   B37teTdi5LyBKF0vjIae5t9/p+gj6BIRnwtoEu10kSmyopflf6W+nv51D
   3Yk8Ee761g6uq0PvTfR3j0F0k5lFhnmo+nXSnLsBUXoOhdfmYeKbE79KT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="16911377"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16911377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="803908457"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="803908457"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2023 19:17:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELBc-00015u-2N;
	Sat, 16 Dec 2023 03:17:56 +0000
Date: Sat, 16 Dec 2023 11:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/leds/rgb/leds-qcom-lpg.c:177: warning: Excess struct member
 'channels' description in 'lpg_led'
Message-ID: <202312161115.HrJPGKhQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 0847c33bafe5b58f2f223153c007c1e185f84f48 leds: qcom-lpg: Annotate struct lpg_led with __counted_by
date:   6 weeks ago
config: arm-randconfig-r081-20231214 (https://download.01.org/0day-ci/archive/20231216/202312161115.HrJPGKhQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161115.HrJPGKhQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161115.HrJPGKhQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/leds/rgb/leds-qcom-lpg.c:177: warning: Excess struct member 'channels' description in 'lpg_led'


vim +177 drivers/leds/rgb/leds-qcom-lpg.c

24e2d05d1b68981 Bjorn Andersson 2022-03-03  160  
24e2d05d1b68981 Bjorn Andersson 2022-03-03  161  /**
24e2d05d1b68981 Bjorn Andersson 2022-03-03  162   * struct lpg_led - logical LED object
24e2d05d1b68981 Bjorn Andersson 2022-03-03  163   * @lpg:		lpg context reference
24e2d05d1b68981 Bjorn Andersson 2022-03-03  164   * @cdev:		LED class device
24e2d05d1b68981 Bjorn Andersson 2022-03-03  165   * @mcdev:		Multicolor LED class device
24e2d05d1b68981 Bjorn Andersson 2022-03-03  166   * @num_channels:	number of @channels
24e2d05d1b68981 Bjorn Andersson 2022-03-03  167   * @channels:		list of channels associated with the LED
24e2d05d1b68981 Bjorn Andersson 2022-03-03  168   */
24e2d05d1b68981 Bjorn Andersson 2022-03-03  169  struct lpg_led {
24e2d05d1b68981 Bjorn Andersson 2022-03-03  170  	struct lpg *lpg;
24e2d05d1b68981 Bjorn Andersson 2022-03-03  171  
24e2d05d1b68981 Bjorn Andersson 2022-03-03  172  	struct led_classdev cdev;
24e2d05d1b68981 Bjorn Andersson 2022-03-03  173  	struct led_classdev_mc mcdev;
24e2d05d1b68981 Bjorn Andersson 2022-03-03  174  
24e2d05d1b68981 Bjorn Andersson 2022-03-03  175  	unsigned int num_channels;
0847c33bafe5b58 Kees Cook       2023-09-15  176  	struct lpg_channel *channels[] __counted_by(num_channels);
24e2d05d1b68981 Bjorn Andersson 2022-03-03 @177  };
24e2d05d1b68981 Bjorn Andersson 2022-03-03  178  

:::::: The code at line 177 was first introduced by commit
:::::: 24e2d05d1b68981f22c984c766fabc5a93c83dba leds: Add driver for Qualcomm LPG

:::::: TO: Bjorn Andersson <bjorn.andersson@linaro.org>
:::::: CC: Pavel Machek <pavel@ucw.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

