Return-Path: <linux-kernel+bounces-17269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA613824AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81796283A49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF22C863;
	Thu,  4 Jan 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8oLuABc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AB2C84F;
	Thu,  4 Jan 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704405688; x=1735941688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otgbQ7H1iBSZqJ3vnujFkHluxQ0XxaU4/8325jzHr+8=;
  b=f8oLuABcGnWQNiIUZ1iv8qGbfDQyKucdHznj9Pfy7YnBT6UpgObxSKCu
   NhMG+UrEkI04onGt1tsdKRq5Moc++HERqogZkUK/rN2Y2ozlNaqvNpR4j
   Uq8v1gV8nT0mpmQSiCdrDAxC8O5pLlFLaJsq8yFP+x8+tTnNhBnb2jpJ0
   4SmNGvLzAQE3Xv+SarvNXu2Ei4jAHsylTB1QV8/sTjLANkf6JkfmnFUqC
   8q/LDIZ7CFF+WZjoTjEZFlquMR81vBAkytfQ85gayVVXTI9XQNNqHf4kH
   ivchovDw72QSR14w+ojKp/+khMukDcsva2otXeSVWB4xYyM5hBugFozNM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="394553013"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="394553013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 14:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846378376"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="846378376"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2024 14:01:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLVmB-0000Sy-08;
	Thu, 04 Jan 2024 22:01:19 +0000
Date: Fri, 5 Jan 2024 06:01:10 +0800
From: kernel test robot <lkp@intel.com>
To: Zack Rusin <zack.rusin@broadcom.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] input/vmmouse: Fix device name copies
Message-ID: <202401050506.N1aMF9sD-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240105/202401050506.N1aMF9sD-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401050506.N1aMF9sD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050506.N1aMF9sD-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/input/mouse/vmmouse.c:78:5: warning: variable length array used [-Wvla]
      77 |         char phys[sizeof_field(struct serio, phys) +
         |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      78 |                   strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/input/mouse/vmmouse.c:77:7: error: fields must have a constant size: 'variable length array in structure' extension will never be supported
      77 |         char phys[sizeof_field(struct serio, phys) +
         |              ^
   1 warning and 1 error generated.


vim +77 drivers/input/mouse/vmmouse.c

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
  > 78			  strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
    79		char dev_name[128];
    80	};
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

