Return-Path: <linux-kernel+bounces-24146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AAF82B837
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F9C1C23E85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273157870;
	Thu, 11 Jan 2024 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHIHvSsE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B456B7B;
	Thu, 11 Jan 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705016775; x=1736552775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDQ+Y25+9tjVLydR7nv5+2kZe3IxdEqqQlgXmpvEyYk=;
  b=RHIHvSsEPzFRWIFgr9oRd6kW32Ma9nxWMD0ICAKI64dDQsS7Qy8WJSQ1
   W6LdQYm//UvglP4rXnYHsRRY0KW6Tf1pY5TZPipqPVnnMqWR0lguyv0nD
   pNhIgTcQ+VPXIzU8DWdZA/jlhJ3ifg32aGB6cs2Rz+j+kVhfy0vbuuXV2
   kJ9eAzlmvhGaWfDKOco8WaiN8EKxA7mBmK03rZ5cPqL0PRE4W4v8M6/Fv
   H5mcKGdy3HonIzbocfAs9H4AEGocx7IRk5AT+rXA651UEGZRm731JJMl5
   2DUVYjH4OnTySIX0WM2u2DRtD5dKrMMhlndgLbFdcjiMh33/0Zc2ijoNe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20500691"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="20500691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 15:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="17208593"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jan 2024 15:46:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO4kR-0008rG-0N;
	Thu, 11 Jan 2024 23:46:07 +0000
Date: Fri, 12 Jan 2024 07:45:07 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 3/7] Documentation: i3c: Add I3C target mode
 controller and function
Message-ID: <202401120713.p7a3HyFl-lkp@intel.com>
References: <20240110175221.2335480-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110175221.2335480-4-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-target-mode-support/20240111-015711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240110175221.2335480-4-Frank.Li%40nxp.com
patch subject: [PATCH v2 3/7] Documentation: i3c: Add I3C target mode controller and function
reproduce: (https://download.01.org/0day-ci/archive/20240112/202401120713.p7a3HyFl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120713.p7a3HyFl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/driver-api/i3c/target/i3c-target-cfs.rst references a file that doesn't exist: Documentation/I3C/target/pci-target.rst
>> Documentation/driver-api/i3c/target/i3c-target.rst:38: WARNING: Title underline too short.
>> Documentation/driver-api/i3c/target/i3c-target-cfs.rst:73: WARNING: Title underline too short.
>> Documentation/driver-api/i3c/target/i3c-tty-howto.rst:45: WARNING: Title underline too short.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

