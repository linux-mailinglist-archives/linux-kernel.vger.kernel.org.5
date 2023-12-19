Return-Path: <linux-kernel+bounces-5902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151AA81914A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481111C2408A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFC3987C;
	Tue, 19 Dec 2023 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HayGrfPb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EB15494;
	Tue, 19 Dec 2023 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703017525; x=1734553525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/3HjixKss5fvVmEUClEL2EJFxrnmh9GCua2vOP2nJg=;
  b=HayGrfPbM76TE8OKrRQBWk9/BnJ+qIFAovVm6YNituw9vHAFosYAguBr
   do+c8YPDluVnbF56F+F8+sk4f3EHe9vV8N+etakVOfvpa8+hR7wMq7byd
   Ash7ub/F7dyePbokt5k6CjeLGFvA6X1rnFeHD6FrNe8QxLti1hb1H7CBs
   aZtGTqJUPE+rsWlZfbmQ/dXoU4L6ZIgH/Tv+Bdwh3PeAs6V+pB/hQ8Bkm
   DhlXfjyeMrdnbcDJTh9Ff5oFVRJvTfhBfy4UU2C24+3bT3ed7obLbXmZ0
   Xq74vCOb5pujYf6OkGgq5WvgQprmRIF1buMaTXRgQcBM3od+EhCrx5Ibu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2537663"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2537663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="919730521"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="919730521"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2023 12:25:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFgeU-0005v0-07;
	Tue, 19 Dec 2023 20:25:18 +0000
Date: Wed, 20 Dec 2023 04:25:17 +0800
From: kernel test robot <lkp@intel.com>
To: baneric926@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net
Cc: oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Message-ID: <202312200427.FGvpu8DB-lkp@intel.com>
References: <20231219080021.2048889-2-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219080021.2048889-2-kcfeng0@nuvoton.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc6 next-20231219]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/baneric926-gmail-com/dt-bindings-hwmon-Add-NCT7363Y-documentation/20231219-160534
base:   linus/master
patch link:    https://lore.kernel.org/r/20231219080021.2048889-2-kcfeng0%40nuvoton.com
patch subject: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312200427.FGvpu8DB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200427.FGvpu8DB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

