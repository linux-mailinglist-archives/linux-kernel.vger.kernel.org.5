Return-Path: <linux-kernel+bounces-16903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3508245BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F751C21DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234124B42;
	Thu,  4 Jan 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+QZd+Gf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12C24B29;
	Thu,  4 Jan 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704384249; x=1735920249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0AFkTq8W4WlL14fDd9NkfIdML6QaTZbBm5y83F+lCQg=;
  b=Z+QZd+Gf6y0eanUSjprkdQxhRMlCO+bWG6d/xVgaAEywzKGAyXJ2MvO2
   bm6qm/Zz2SUqTXcp/w9TXFlq3MY97mbb+/T1OyiYQXSTpznVajH1cBKEU
   Sqq5Pyc1HLpEM4EeuMqagpJNVpe/uPG0iZPv/wAJeg0NmGCubowNggD2z
   HvnptupsWsodiyfsx64kgLWtfo5Cq5K9vXB4D9cLTvn6pdzDfoi1dOsdJ
   DmkrH3epVco9u76OTOok35yiaBeEsGgw7b8Rtr43dmiYLOxKJexkInuPA
   kSNk2gwMaveO34mhwseNQVr4GHfw8EkmY1a6YRCvBhzigTqdrEKks4r0O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4650255"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4650255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="756655432"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="756655432"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2024 08:04:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLQCQ-00008e-1Q;
	Thu, 04 Jan 2024 16:04:02 +0000
Date: Fri, 5 Jan 2024 00:03:45 +0800
From: kernel test robot <lkp@intel.com>
To: Zack Rusin <zack.rusin@broadcom.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Zack Rusin <zack.rusin@broadcom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] input/vmmouse: Fix device name copies
Message-ID: <202401042305.WdnDeo57-lkp@intel.com>
References: <20240104050605.1773158-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104050605.1773158-1-zack.rusin@broadcom.com>

Hi Zack,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus linus/master v6.7-rc8 next-20240104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zack-Rusin/input-vmmouse-Fix-device-name-copies/20240104-130724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20240104050605.1773158-1-zack.rusin%40broadcom.com
patch subject: [PATCH v2] input/vmmouse: Fix device name copies
config: i386-buildonly-randconfig-001-20240104 (https://download.01.org/0day-ci/archive/20240104/202401042305.WdnDeo57-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401042305.WdnDeo57-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401042305.WdnDeo57-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/mouse/vmmouse.c:77:7: error: variably modified 'phys' at file scope
     char phys[sizeof_field(struct serio, phys) +
          ^~~~


vim +/phys +77 drivers/input/mouse/vmmouse.c

    67	
    68	/**
    69	 * struct vmmouse_data - private data structure for the vmmouse driver
    70	 *
    71	 * @abs_dev: "Absolute" device used to report absolute mouse movement.
    72	 * @phys: Physical path for the absolute device.
    73	 * @dev_name: Name attribute name for the absolute device.
    74	 */
    75	struct vmmouse_data {
    76		struct input_dev *abs_dev;
  > 77		char phys[sizeof_field(struct serio, phys) +
    78			  strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
    79		char dev_name[128];
    80	};
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

