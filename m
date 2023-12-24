Return-Path: <linux-kernel+bounces-10719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92E81DAD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6F1C20E75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858ED5677;
	Sun, 24 Dec 2023 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT5IX2m2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68853A0;
	Sun, 24 Dec 2023 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703427829; x=1734963829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ryI2ILCT9BZHm98daCtmT5DUgurYrkulnFER/y9ghkE=;
  b=UT5IX2m28/fLO0of6EeTOOn4P6kacHspor3SQM7wfEuAebC26JUzTv0q
   XWT6hXN59qE44Tz06uleCXlEuRt1jUpAt/PyQ3uawR2XG3FqHyp1XRH7M
   OKTTcN1v/0/2+KycoW0mCkS99gqYPotv+md6lOaQIsoAXQxgexTNPHOLe
   dUvb4HLV/20NlGG59pst3UD+bqdww/xJXvTrQ3OH0O37wIz7oEf4HKSIl
   53NuGPinPCqWERGdTi0zIJcZy9kQYmZi5FVDb9BaJPqgSmR01S4pzNC5L
   urajryGsc4NLoY6TMteqyW+OC8AirT0AbgNFFpUIOmBjKv8goQ2ZvuX+s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482416260"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="482416260"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 06:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777537126"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="777537126"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Dec 2023 06:23:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHPNu-000CKD-1W;
	Sun, 24 Dec 2023 14:23:30 +0000
Date: Sun, 24 Dec 2023 22:22:19 +0800
From: kernel test robot <lkp@intel.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org, corbet@lwn.net,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, anandakumar.balasubramaniam@sony.com,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Subject: Re: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Message-ID: <202312242257.5c0xsTqe-lkp@intel.com>
References: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221133953.1507021-1-sreenath.vijayan@sony.com>

Hi Sreenath,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sreenath-Vijayan/tty-sysrq-Dump-kernel-ring-buffer-messages-via-sysrq/20231222-172636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231221133953.1507021-1-sreenath.vijayan%40sony.com
patch subject: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231224/202312242257.5c0xsTqe-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312242257.5c0xsTqe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312242257.5c0xsTqe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/sysrq.c:455:13: warning: stack frame size (1088) exceeds limit (1024) in 'dmesg_dump_callback' [-Wframe-larger-than]
   static void dmesg_dump_callback(struct work_struct *work)
               ^
   1 warning generated.


vim +/dmesg_dump_callback +455 drivers/tty/sysrq.c

   454	
 > 455	static void dmesg_dump_callback(struct work_struct *work)
   456	{
   457		struct kmsg_dump_iter iter;
   458		size_t len;
   459		char buf[1024];
   460		struct console *con;
   461		int cookie;
   462	
   463		kmsg_dump_rewind(&iter);
   464		while (kmsg_dump_get_line(&iter, 1, buf, sizeof(buf), &len)) {
   465			/*
   466			 * Since using printk() or pr_*() will append the message to the
   467			 * kernel ring buffer, they cannot be used to display the retrieved
   468			 * message. Hence console_write() of serial drivers is used.
   469			 */
   470			console_lock();
   471			cookie = console_srcu_read_lock();
   472			for_each_console_srcu(con) {
   473				if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)
   474					con->write(con, buf, len);
   475			}
   476			console_srcu_read_unlock(cookie);
   477			console_unlock();
   478		}
   479	}
   480	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

