Return-Path: <linux-kernel+bounces-2661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E3816018
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F071C21BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEA44C8F;
	Sun, 17 Dec 2023 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSiOqj8K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF945BE8;
	Sun, 17 Dec 2023 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702825945; x=1734361945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dJX5pfKYAiGx8FugnRaJiWi30ZLLXxn6+pf118Vs8SI=;
  b=mSiOqj8KPgV3CL0+8i6OGEXY2FDs67gJ6NMsvHfpGMnjJQvRbvnQh/Nj
   cRXR3VGyclEJ4CGwhp4L1y1V7jrU2j9RjHAJtPpZMrJ77xB3AtfhOjFIg
   UWZKLiRfUAMxC0FX2NahkhtJt/jEzLxTjhNqGvzcNtmK82bngAWncyqMv
   Cnhs+kLCDDCZPxNled75gQCYK98bN0w/1ge4ACEDuCcl9rphd4vqqSnv7
   HoSmt0gN2mnHBlC9tbPvYDNGTmoGxCIDv0cYDKjK5Izz5LhlYTUeY0XZF
   oBGhTPti21LeKhLtMGtjVs/1Bn86HpRkg8Ehz7zpJzwnTqgqy7/SxTVWr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375570792"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="375570792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 07:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804261923"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="804261923"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2023 07:12:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEsoU-00038y-1T;
	Sun, 17 Dec 2023 15:12:18 +0000
Date: Sun, 17 Dec 2023 23:11:41 +0800
From: kernel test robot <lkp@intel.com>
To: RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, badhri@google.com,
	bryan.odonoghue@linaro.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 01/12] usb: typec: altmodes: add typec_cable_ops to
 typec_altmode
Message-ID: <202312172234.6in6om5p-lkp@intel.com>
References: <20231214230850.379863-15-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-15-rdbabiera@google.com>

Hi RD,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/RD-Babiera/usb-typec-altmodes-add-typec_cable_ops-to-typec_altmode/20231215-071339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231214230850.379863-15-rdbabiera%40google.com
patch subject: [PATCH v2 01/12] usb: typec: altmodes: add typec_cable_ops to typec_altmode
config: arc-randconfig-001-20231215 (https://download.01.org/0day-ci/archive/20231217/202312172234.6in6om5p-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172234.6in6om5p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172234.6in6om5p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/usb/typec/bus.c:260: warning: expecting prototype for typec_altmode_enter(). Prototype was for typec_cable_altmode_enter() instead
>> scripts/kernel-doc: drivers/usb/typec/bus.c:290: warning: expecting prototype for typec_altmode_exit(). Prototype was for typec_cable_altmode_exit() instead
>> scripts/kernel-doc: drivers/usb/typec/bus.c:323: warning: expecting prototype for typec_altmode_vdm(). Prototype was for typec_cable_altmode_vdm() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

