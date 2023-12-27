Return-Path: <linux-kernel+bounces-12172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3481F0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0ED2B221E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615246528;
	Wed, 27 Dec 2023 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3YtY6Y9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB246521;
	Wed, 27 Dec 2023 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698190; x=1735234190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aldfr7OGlFepgVjQLG4ahYMsoND2AkgxRVR/eA9MgBw=;
  b=S3YtY6Y9+wVXd341JyxqEJTB7vYu6C3VWvWJasTU5cpuK9UIgqAEBcRw
   F3L+wglEfRMaACA1oLCh8hBRUohjq3TI8pziX/It/gCxgzGmQvUWPX9PK
   v9Qc1hZQ35SYhSZW6qxDEGtAvYXOiXmhxtoOakdGYqbYu8pRn2OyZb0BO
   hb2b11Ru7MoGxb2pfgR8InLLX5hKHtXbKvqEIrJLkWPKuZlsMMUE3tcXd
   ZTaWWt7o/yumE0KGSJD/cteOKZLVVMnvbPS/I+aJYhjFAEP3yJP3v1Wfr
   94PnesReWbRd3MSnClHxIKH0wHRolwlGdl5CNBXn+/v5Notq60M0LEGNH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3770555"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3770555"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1025435720"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1025435720"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Dec 2023 09:29:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIXiz-000Fbl-11;
	Wed, 27 Dec 2023 17:29:45 +0000
Date: Thu, 28 Dec 2023 01:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux@roeck-us.net
Cc: oe-kbuild-all@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler
 is ready on Dell systems
Message-ID: <202312280116.QtpZzDTy-lkp@intel.com>
References: <20231227040401.548977-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227040401.548977-1-kai.heng.feng@canonical.com>

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on rafael-pm/linux-next rafael-pm/acpi-bus linus/master v6.7-rc7 next-20231222]
[cannot apply to rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/hwmon-acpi_power_meter-Ensure-IPMI-space-handler-is-ready-on-Dell-systems/20231227-120900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20231227040401.548977-1-kai.heng.feng%40canonical.com
patch subject: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231228/202312280116.QtpZzDTy-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312280116.QtpZzDTy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312280116.QtpZzDTy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/acpi_ipmi.c:585:6: error: redefinition of 'wait_for_acpi_ipmi'
     585 | void wait_for_acpi_ipmi(void)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/acpi.h:35,
                    from drivers/acpi/acpi_ipmi.c:11:
   include/acpi/acpi_bus.h:676:20: note: previous definition of 'wait_for_acpi_ipmi' with type 'void(void)'
     676 | static inline void wait_for_acpi_ipmi(void)
         |                    ^~~~~~~~~~~~~~~~~~


vim +/wait_for_acpi_ipmi +585 drivers/acpi/acpi_ipmi.c

   584	
 > 585	void wait_for_acpi_ipmi(void)
   586	{
   587		wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
   588	}
   589	EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

