Return-Path: <linux-kernel+bounces-165889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5978B92FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CC1F226C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD110A24;
	Thu,  2 May 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAowEpm0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE8D52F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611358; cv=none; b=CAFko8GHi89SxVqvL+kMDcc+w7/QIGSJXKLdI9LokCPx/CPHQkUquWOM1oAgemQmU+bn0Oh4zf0CglxfI8XKVkzL1BgLdqVy5WAg2GZsDJraVURLto2tekxJgj4kaDKg+Poxm7Qu7mDBEvFBlJKihn13RpuCIVuoVZlg2OMj3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611358; c=relaxed/simple;
	bh=x0UvXqrNcm//KRGLol15h/MgzHEjrpbwFcPhFHmhE7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz4u+5U7AJrkzxvtybTdLrmoDGdC1o6SfE2cUEkjABt8vF5wKYqmgzRQsJ1i1WYvSeXoLvCoL6H+7giTg1g0QA2X9f3DKfmW5daE96xL3giyewhn9JTyNhOH5MDw7iT+HAxwx/Hzqdfp1jUCRw9DAgxNVNjISBQP2ke8mf4hcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAowEpm0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714611356; x=1746147356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x0UvXqrNcm//KRGLol15h/MgzHEjrpbwFcPhFHmhE7w=;
  b=EAowEpm0vfZc09UhuctxfmvV9DvpG71gfwTZMPSlA3YTgTIrpwncRN89
   8iMotjPYyXcX3TtN3IMJpngkq6UFIaB3SgPB+qEvUpaSLChRujmw5+CaF
   czNTlWrywNA14EobNZIQNukFh+a9ToycuFl5zvGkJSwEaCpBKXQgtUCeU
   i2SH5bwSeGcY+IL5ry3h0XvNk40wiW+milpM9MWtZevV7vWeaEosmlz6c
   Gn2kwygW9inuAFV0Pk9mJ3Ryrl51saacRyWA/XQrYv1vJHG33HXtvY/jm
   4ySbJgwpqGNNGb4zXDq8lB0hnuXkEBmisbtmIoA3iZROn2oHu5F3JRK2+
   A==;
X-CSE-ConnectionGUID: xywWB032S96x9Q1a4YqSAA==
X-CSE-MsgGUID: y0td94G9TxKfsEEtKKqRwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10532941"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="10532941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 17:55:55 -0700
X-CSE-ConnectionGUID: Jreuta6ySGqrRpaJMlRpRw==
X-CSE-MsgGUID: TuBljbkGT9uB6NL8DLthpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="27064007"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 May 2024 17:55:50 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2Kjj-000AFw-20;
	Thu, 02 May 2024 00:55:47 +0000
Date: Thu, 2 May 2024 08:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	frank.li@nxp.com, daniel.baluta@nxp.com,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: Re: [PATCH 3/4] soc: imx: secvio: Add support for SNVS secvio and
 tamper via SCFW
Message-ID: <202405020818.2mTfooXt-lkp@intel.com>
References: <20240501053205.1737248-4-vabhav.sharma@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501053205.1737248-4-vabhav.sharma@nxp.com>

Hi Vabhav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on robh/for-next krzk/for-next krzk-dt/for-next linus/master v6.9-rc6 next-20240501]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vabhav-Sharma/dt-bindings-firmware-secvio-Add-documentation/20240501-133607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20240501053205.1737248-4-vabhav.sharma%40nxp.com
patch subject: [PATCH 3/4] soc: imx: secvio: Add support for SNVS secvio and tamper via SCFW
config: hexagon-randconfig-r131-20240502 (https://download.01.org/0day-ci/archive/20240502/202405020818.2mTfooXt-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce: (https://download.01.org/0day-ci/archive/20240502/202405020818.2mTfooXt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405020818.2mTfooXt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/imx/secvio/imx-secvio-sc.c:381:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/soc/imx/secvio/imx-secvio-sc.c:381:37: sparse:     expected void [noderef] __user *to
   drivers/soc/imx/secvio/imx-secvio-sc.c:381:37: sparse:     got void *
>> drivers/soc/imx/secvio/imx-secvio-sc.c:393:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/soc/imx/secvio/imx-secvio-sc.c:393:46: sparse:     expected void const [noderef] __user *from
   drivers/soc/imx/secvio/imx-secvio-sc.c:393:46: sparse:     got void *

vim +381 drivers/soc/imx/secvio/imx-secvio-sc.c

   368	
   369	static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   370	{
   371		struct device *dev = file->private_data;
   372		struct secvio_sc_notifier_info info;
   373		int ret;
   374	
   375		switch (cmd) {
   376		case IMX_SECVIO_SC_GET_STATE:
   377			ret = imx_secvio_sc_get_state(dev, &info);
   378			if (ret)
   379				return ret;
   380	
 > 381			ret = copy_to_user((void *)arg, &info, sizeof(info));
   382			if (ret) {
   383				dev_err(dev, "Fail to copy info to user\n");
   384				return -EFAULT;
   385			}
   386			break;
   387		case IMX_SECVIO_SC_CHECK_STATE:
   388			ret = imx_secvio_sc_check_state(dev);
   389			if (ret)
   390				return ret;
   391			break;
   392		case IMX_SECVIO_SC_CLEAR_STATE:
 > 393			ret = copy_from_user(&info, (void *)arg, sizeof(info));
   394			if (ret) {
   395				dev_err(dev, "Fail to copy info from user\n");
   396				return -EFAULT;
   397			}
   398	
   399			ret = imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
   400							    info.lptds);
   401			if (ret)
   402				return ret;
   403			break;
   404		default:
   405			ret = -ENOIOCTLCMD;
   406		}
   407	
   408		return ret;
   409	}
   410	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

