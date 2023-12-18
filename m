Return-Path: <linux-kernel+bounces-4114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343481780D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779142842F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149895A866;
	Mon, 18 Dec 2023 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWtUr8QK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AC5BF80;
	Mon, 18 Dec 2023 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702918874; x=1734454874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGQ0G6lJV8wNzSBABFy+OTts9y2BZfj1wdkFcSdtY4w=;
  b=nWtUr8QKhdfEGj3n4Oc4/cvVAxyvhaKiHZZXWXOhrGwLgY0D2pbU9yo+
   krbTQmD6ComUL7/HgcQL8w/HKTr/USxJNHXksXuC33xTqbOsgQ4EpAmII
   PgaUMu/6gzn2S84Nh3UXCwchHBNGrWhxw1ufign97zd5dIxkTJHtN7cp0
   kbcUoVREe2CFYAoZd8rYzzGnqcZhNqOERgMNqO2LCMOblnwqwzV5L6ZWF
   myXfJTywUUDg+DmEOBUW4j4X8Eu4LWMcQAXwG+2vfcL3cm5/Vu7eaoxNE
   qLtVI3wbKlXqRkVkp5mD3hbUSzDFECf2AkLO/vcVyXKU4BYArDJceY5wy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2745130"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2745130"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809903347"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809903347"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 09:01:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFGzJ-0004Ll-2W;
	Mon, 18 Dec 2023 17:01:05 +0000
Date: Tue, 19 Dec 2023 01:00:25 +0800
From: kernel test robot <lkp@intel.com>
To: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Message-ID: <202312190037.v9VmHXF6-lkp@intel.com>
References: <a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor@gmail.com>

Hi Abdel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc6 next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdel-Alkuor/hwmon-lm75-Add-AMS-AS6200-temperature-sensor/20231218-125552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor%40gmail.com
patch subject: [PATCH v2 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231219/202312190037.v9VmHXF6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312190037.v9VmHXF6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190037.v9VmHXF6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/lm75.c:95: warning: Function parameter or member 'config_reg_16bits' not described in 'lm75_params'
>> drivers/hwmon/lm75.c:95: warning: Function parameter or member 'alarm' not described in 'lm75_params'


vim +95 drivers/hwmon/lm75.c

9ebd3d822efeca David Brownell                  2008-05-03  57  
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  58  /**
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  59   * struct lm75_params - lm75 configuration parameters.
08760063a75ca5 Abdel Alkuor                    2023-12-17  60   * @config_reg_16bits	Configure register size is 2 bytes.
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  61   * @set_mask:		Bits to set in configuration register when configuring
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  62   *			the chip.
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  63   * @clr_mask:		Bits to clear in configuration register when configuring
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  64   *			the chip.
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  65   * @default_resolution:	Default number of bits to represent the temperature
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  66   *			value.
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  67   * @resolution_limits:	Limit register resolution. Optional. Should be set if
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  68   *			the resolution of limit registers does not match the
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  69   *			resolution of the temperature register.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  70   * @resolutions:	List of resolutions associated with sample times.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  71   *			Optional. Should be set if num_sample_times is larger
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  72   *			than 1, and if the resolution changes with sample times.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  73   *			If set, number of entries must match num_sample_times.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  74   * @default_sample_time:Sample time to be set by default.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  75   * @num_sample_times:	Number of possible sample times to be set. Optional.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  76   *			Should be set if the number of sample times is larger
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  77   *			than one.
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  78   * @sample_times:	All the possible sample times to be set. Mandatory if
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  79   *			num_sample_times is larger than 1. If set, number of
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  80   *			entries must match num_sample_times.
08760063a75ca5 Abdel Alkuor                    2023-12-17  81   * @alarm		Alarm is supported.
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  82   */
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  83  
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  84  struct lm75_params {
08760063a75ca5 Abdel Alkuor                    2023-12-17  85  	bool			config_reg_16bits;
08760063a75ca5 Abdel Alkuor                    2023-12-17  86  	u16			set_mask;
08760063a75ca5 Abdel Alkuor                    2023-12-17  87  	u16			clr_mask;
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  88  	u8			default_resolution;
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  89  	u8			resolution_limits;
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  90  	const u8		*resolutions;
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  91  	unsigned int		default_sample_time;
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  92  	u8			num_sample_times;
7f1a300f8abd11 Iker Perez del Palomar Sustatxa 2019-08-08  93  	const unsigned int	*sample_times;
08760063a75ca5 Abdel Alkuor                    2023-12-17  94  	bool			alarm;
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08 @95  };
dcb12653875e7c Iker Perez del Palomar Sustatxa 2019-08-08  96  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

