Return-Path: <linux-kernel+bounces-17569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A656F824F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA55B23A32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6120323;
	Fri,  5 Jan 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DItoaDyD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80120306;
	Fri,  5 Jan 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704442242; x=1735978242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWVz+R9ZTDJwoY4KhCcey0RALa2whPoaCXKx0Sx4Pg0=;
  b=DItoaDyD7cU25TuP2d0JFKJq7VOkece5pq45kPbqBIOlRUdl/vgKpYix
   7b3wA5mkKTAsjl6Wzwyvfo/CDFltc5pd7CsxUJmMkN+bbvH4LdMIh8/5p
   mX7wqe4EnxbpcU8C971wrHtGdmSRyI9ymxMJM02/udkWzD9YqTR8NwOJQ
   mEw6i66Qg7dAhtjiMZSnNp8yxfstxqK+NoYX5V9I0sqOhPnxgdGepyJjY
   FKQTt6x+5gx8cmFvmcmWEBQu8bmK/Eig5B/bwwkw7Hhn8/DrMf2uHRDUg
   xlelJhxQVeRnHUghpFBFg0WDEJxPG+nlKXC6qbNEa08vjMS46LRD8cYCj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4828272"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="4828272"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 00:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899588668"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="899588668"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2024 00:10:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLfHp-0000yy-1c;
	Fri, 05 Jan 2024 08:10:37 +0000
Date: Fri, 5 Jan 2024 16:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux@roeck-us.net
Cc: oe-kbuild-all@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Message-ID: <202401051544.T4aBavV5-lkp@intel.com>
References: <20240104024819.848979-2-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104024819.848979-2-kai.heng.feng@canonical.com>

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on groeck-staging/hwmon-next rafael-pm/acpi-bus rafael-pm/devprop linus/master v6.7-rc8 next-20240104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/hwmon-acpi_power_meter-Ensure-IPMI-space-handler-is-ready-on-Dell-systems/20240104-105227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240104024819.848979-2-kai.heng.feng%40canonical.com
patch subject: [PATCH v3 2/2] hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems
config: i386-randconfig-r133-20240104 (https://download.01.org/0day-ci/archive/20240105/202401051544.T4aBavV5-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401051544.T4aBavV5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051544.T4aBavV5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: acpi_wait_for_acpi_ipmi
   >>> referenced by acpi_power_meter.c:888 (drivers/hwmon/acpi_power_meter.c:888)
   >>>               drivers/hwmon/acpi_power_meter.o:(acpi_power_meter_add) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

