Return-Path: <linux-kernel+bounces-17118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F283824884
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABEFB21B38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F828E3C;
	Thu,  4 Jan 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ite9pqD8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58632C18C;
	Thu,  4 Jan 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704394939; x=1735930939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rUMvGvL6YB+Sg9CHINyeLAItR2uRWwb2yiVVnAXKvo=;
  b=Ite9pqD8PVpBehoUBHD/lOxhZrPkdFj7nOUBoepMwVkOBx9qKHSnENiA
   5hWsw5RiPxpbOB2uF3dX+fPFGjM5VjzMg4NFwSldjmAYnOIr1VL3aeI6i
   mTY1Ol1Oa/KgvSJdn0XbEzU9xMQ/PoEgwiZ2kDLIgAnFzIHX2AkZ4yG5t
   i3AMkwZ1qTCme/HrbOqrrRlkaFzAAAxY4TPg21l5wUc3gzIcXe7oGcAxp
   7CJl9t2gBKO3joq3oF0N7TDuvONHb7nMt9YrRuwq2GKN46P1zZetUskZU
   tb/YYA4l7/uJsChmCVHuPPntSYgAQunAi07H3V76vA8ra0o+1keD2iiX1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4707778"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4707778"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111857269"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111857269"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2024 11:02:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLSyo-0000LI-1z;
	Thu, 04 Jan 2024 19:02:10 +0000
Date: Fri, 5 Jan 2024 03:01:51 +0800
From: kernel test robot <lkp@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
	linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
	corbet@lwn.net, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v11 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Message-ID: <202401050234.nDBceclJ-lkp@intel.com>
References: <20240104034120.3516290-4-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104034120.3516290-4-billy_tsai@aspeedtech.com>

Hi Billy,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.7-rc8 next-20240104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-fan-Add-fan-binding-to-schema/20240104-114552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240104034120.3516290-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v11 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240105/202401050234.nDBceclJ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401050234.nDBceclJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050234.nDBceclJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:270:3: error: field designator 'owner' does not refer to any field in type 'const struct pwm_ops'
     270 |         .owner = THIS_MODULE,
         |         ~^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +270 drivers/hwmon/aspeed-g6-pwm-tach.c

   266	
   267	static const struct pwm_ops aspeed_pwm_ops = {
   268		.apply = aspeed_pwm_apply,
   269		.get_state = aspeed_pwm_get_state,
 > 270		.owner = THIS_MODULE,
   271	};
   272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

