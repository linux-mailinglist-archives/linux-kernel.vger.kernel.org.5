Return-Path: <linux-kernel+bounces-29554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BED831023
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FEF1F27483
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AAD286BD;
	Wed, 17 Jan 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWhznDBk"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EF21A12;
	Wed, 17 Jan 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534768; cv=none; b=POaYoqf2sOqFvmJp7ca0NgGBqFxep2cMRXy2shqTRHxoCE/LufLbSztAgOY+2UmDG9AHPIubGWPuwilJ5c+xO0qPwUNXLEYvJX2G+1H3R38LyzAGUniNH6KvhWkNhgvjqah4tS6baMDc7OMmH8G+wlVcb7rEwvY+f7Ot/qAZalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534768; c=relaxed/simple;
	bh=Ha+Y2jJWGNPZTGT0umJ9IwMknizBN0icFUzmICDOFJc=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ltgMxaLTjQtNj3Qh69jrKz3P3kpgCtJMhQu/JgLhKryTe7C+KtNR1JionYtUT5qofKFsTTsWdE/al8i8M6b84hy0WXG/8QlfHjtv8kII1JE6navnDqgT1WnW8wsRMWNGabTkgeS/NvGXbF19kcwiAuueD+Y49wPNUtzmmANvBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWhznDBk; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705534766; x=1737070766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ha+Y2jJWGNPZTGT0umJ9IwMknizBN0icFUzmICDOFJc=;
  b=hWhznDBkYhYHiPF4jqC+DpfjHZVZ3lyqFd0REX1u3w9wpB5CrNzROKFA
   /9OJBkvb5LH3KRsGEtIg/k/0FPQwMArytWiFNHqWORqhJhB7Ky3zqOX6D
   NK3XgdZX+8tN19JQ/FomWVd0g7t3jaZtljH759PBgA9gsawDu8ikwPhW6
   6gt9EPXWaKRUeY/bUEc2xjZFO/IHL7xCuH+VRWZtiAwgnvlAy0TtRCac8
   iTYZ6zw1aP//uG7JCXNw3YZDp9WDC95iTEB1Bt9du9PsqNxkvGNZL8k8x
   StabWKcmKsmmkYnvg/4On8yctl/GLnd6E3rENKD3JwRR8qIRh70BvGQY0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404068181"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404068181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 15:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818645809"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="818645809"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2024 15:39:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQFV9-0002R0-1V;
	Wed, 17 Jan 2024 23:39:19 +0000
Date: Thu, 18 Jan 2024 07:38:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: ucsi_acpi: Quirk to ack a connector change ack
 cmd
Message-ID: <202401180751.BuI4xr2p-lkp@intel.com>
References: <20240116224041.220740-4-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116224041.220740-4-lk@c--e.de>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-A-Ehrhardt/usb-ucsi-Add-missing-ppm_lock/20240117-064726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240116224041.220740-4-lk%40c--e.de
patch subject: [PATCH 3/3] usb: ucsi_acpi: Quirk to ack a connector change ack cmd
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240118/202401180751.BuI4xr2p-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401180751.BuI4xr2p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180751.BuI4xr2p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/ucsi_acpi.c:132: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Some Dell laptops expect that an ACK command with the


vim +132 drivers/usb/typec/ucsi/ucsi_acpi.c

   130	
   131	/**
 > 132	 * Some Dell laptops expect that an ACK command with the
   133	 * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
   134	 * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
   135	 * If this is not done events are not delivered to OSPM and
   136	 * subsequent commands will timeout.
   137	 */
   138	static int
   139	ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
   140			     const void *val, size_t val_len)
   141	{
   142		struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
   143		u64 cmd = *(u64*)val, ack = 0;
   144		int ret;
   145	
   146		if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
   147		    cmd & UCSI_ACK_CONNECTOR_CHANGE)
   148			ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
   149	
   150		ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
   151		if (ret != 0)
   152			return ret;
   153		if (ack == 0)
   154			return ret;
   155	
   156		if (!ua->dell_quirk_probed) {
   157			ua->dell_quirk_probed = true;
   158	
   159			cmd = UCSI_GET_CAPABILITY;
   160			ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
   161						   sizeof(cmd));
   162			if (ret == 0)
   163				return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
   164							    &ack, sizeof(ack));
   165			if (ret != -ETIMEDOUT)
   166				return ret;
   167	
   168			ua->dell_quirk_active = true;
   169		}
   170	
   171		if (!ua->dell_quirk_active)
   172			return ret;
   173	
   174		return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

