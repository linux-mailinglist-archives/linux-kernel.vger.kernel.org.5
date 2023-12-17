Return-Path: <linux-kernel+bounces-2674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF91816054
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A657283701
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB045972;
	Sun, 17 Dec 2023 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKkZ076V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024A44C85
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702829125; x=1734365125;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lTnW+D7yPgL5KEPxerB59gw+6XLk/VgEk/ADte8O/us=;
  b=NKkZ076VsTkudP48CnxUECFgX+7MKvx1pAy37N/LiM1/VlGlbNYLF3Y1
   XYVYb663YAOVpYFhBUKyHLCt5pIfIuDo2UZJAufEh5ooc+WaKAUVY67+h
   /QFdNqnmkrajen0JO+AR0H0vRt9MijrZcM5zYTfTDZEKqzisTCY6HYo/g
   IlVczY2wui/8nq2RahFhjFhItEXKeldQS/9PWPlDE4BjXN+05CbrOEk26
   TDoMSnuxEdW7jGIp6eicutEsLSAaclht3wWZMPdSjhAwUnvzBL55Z0XEW
   GQEN+z8swC6tQO5XUFP/FtC9BBn+qnvFKrhqvUswrlLGITLCoy8KpxQOw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="16979045"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="16979045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 08:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919004565"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="919004565"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2023 08:05:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEtdo-0003CA-1M;
	Sun, 17 Dec 2023 16:05:20 +0000
Date: Mon, 18 Dec 2023 00:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/power/supply/ucs1002_power.c:185:29: sparse: sparse: cast to
 restricted __be32
Message-ID: <202312172352.HLNLQ0pr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 9a2688e42638f2e057dbdfce82e221b38bfba0a7 power: supply: Add driver for Microchip UCS1002
date:   4 years, 8 months ago
config: parisc-randconfig-m041-20230821 (https://download.01.org/0day-ci/archive/20231217/202312172352.HLNLQ0pr-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312172352.HLNLQ0pr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172352.HLNLQ0pr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/power/supply/ucs1002_power.c: note: in included file (through arch/parisc/include/uapi/asm/unistd.h, arch/parisc/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/parisc/include/generated/uapi/asm/unistd_32.h:367:41: sparse: sparse: no newline at end of file
>> drivers/power/supply/ucs1002_power.c:185:29: sparse: sparse: cast to restricted __be32

vim +185 drivers/power/supply/ucs1002_power.c

   131	
   132	static int ucs1002_get_charge(struct ucs1002_info *info,
   133				      union power_supply_propval *val)
   134	{
   135		/*
   136		 * To fit within 32 bits some values are rounded (uA/h)
   137		 *
   138		 * For Total Accumulated Charge Middle Low Byte register, addr
   139		 * 03h, byte 2
   140		 *
   141		 *   B0: 0.01084 mA/h rounded to 11 uA/h
   142		 *   B1: 0.02169 mA/h rounded to 22 uA/h
   143		 *   B2: 0.04340 mA/h rounded to 43 uA/h
   144		 *   B3: 0.08676 mA/h rounded to 87 uA/h
   145		 *   B4: 0.17350 mA/h rounded to 173 uÁ/h
   146		 *
   147		 * For Total Accumulated Charge Low Byte register, addr 04h,
   148		 * byte 3
   149		 *
   150		 *   B6: 0.00271 mA/h rounded to 3 uA/h
   151		 *   B7: 0.005422 mA/h rounded to 5 uA/h
   152		 */
   153		static const int bit_weights_uAh[BITS_PER_TYPE(u32)] = {
   154			/*
   155			 * Bit corresponding to low byte (offset 0x04)
   156			 * B0 B1 B2 B3 B4 B5 B6 B7
   157			 */
   158			0, 0, 0, 0, 0, 0, 3, 5,
   159			/*
   160			 * Bit corresponding to middle low byte (offset 0x03)
   161			 * B0 B1 B2 B3 B4 B5 B6 B7
   162			 */
   163			11, 22, 43, 87, 173, 347, 694, 1388,
   164			/*
   165			 * Bit corresponding to middle high byte (offset 0x02)
   166			 * B0 B1 B2 B3 B4 B5 B6 B7
   167			 */
   168			2776, 5552, 11105, 22210, 44420, 88840, 177700, 355400,
   169			/*
   170			 * Bit corresponding to high byte (offset 0x01)
   171			 * B0 B1 B2 B3 B4 B5 B6 B7
   172			 */
   173			710700, 1421000, 2843000, 5685000, 11371000, 22742000,
   174			45484000, 90968000,
   175		};
   176		unsigned long total_acc_charger;
   177		unsigned int reg;
   178		int i, ret;
   179	
   180		ret = regmap_bulk_read(info->regmap, UCS1002_REG_TOTAL_ACC_CHARGE,
   181				       &reg, sizeof(u32));
   182		if (ret)
   183			return ret;
   184	
 > 185		total_acc_charger = be32_to_cpu(reg); /* BE as per offsets above */
   186		val->intval = 0;
   187	
   188		for_each_set_bit(i, &total_acc_charger, ARRAY_SIZE(bit_weights_uAh))
   189			val->intval += bit_weights_uAh[i];
   190	
   191		return 0;
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

