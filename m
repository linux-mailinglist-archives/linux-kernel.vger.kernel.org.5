Return-Path: <linux-kernel+bounces-454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31240814153
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F5A1F229CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389746FC6;
	Fri, 15 Dec 2023 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2RwMasC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E431101D5;
	Fri, 15 Dec 2023 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702618575; x=1734154575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQYnkpHiwKIoqWNiUmwvIj6Vuov6yxGJFadHRiuq7/E=;
  b=D2RwMasCXBcjAG6AaPJh8kJlVtxULjvUh+DIWz+ejWMnEB5Hol3F6Sg4
   tj1z4PTNTkxosByWn8gdJVz5BlikUKPs+vsvPWVJwvpAhOyWOcokgWv/N
   MueB4kX2Irwz1E8G3a+thzu7SbSX4IZBUbuhvg/vzc5PJIMuoQ2uImQxE
   1Y9br5Yh6eN9D7k2MXp7leul2vAOUais6UDNBgu26n0bzkMXUBY5o15wn
   1VUoW7vgIuzJ5pnIt/XspyJCg1tsAuSpIJWcWWtUaothzAYElbMkPuCbG
   itsm9euxH/ecncddoXR00lOLfmPZ1rnRg+upK9dc1FU5XZ+8o4DfS6huk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2389774"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2389774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="16165895"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Dec 2023 21:36:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE0rm-000N9F-0q;
	Fri, 15 Dec 2023 05:36:07 +0000
Date: Fri, 15 Dec 2023 13:35:45 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Message-ID: <202312151356.OZmUHKRx-lkp@intel.com>
References: <20231214070200.24405-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214070200.24405-1-rdunlap@infradead.org>

Hi Randy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/scripts-kernel-doc-restore-warning-for-Excess-struct-union/20231214-150722
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20231214070200.24405-1-rdunlap%40infradead.org
patch subject: [PATCH] scripts/kernel-doc: restore warning for Excess struct/union
config: arm-randconfig-r081-20231214 (https://download.01.org/0day-ci/archive/20231215/202312151356.OZmUHKRx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312151356.OZmUHKRx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312151356.OZmUHKRx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-syscon.c:46: warning: Excess struct member 'compatible' description in 'syscon_gpio_data'
--
>> drivers/gpio/gpio-xilinx.c:75: warning: Excess struct member 'irqchip' description in 'xgpio_instance'
--
>> net/tipc/link.c:228: warning: Excess struct member 'media_addr' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'timer' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'refcnt' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'proto_msg' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'pmsg' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'backlog_limit' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'exp_msg_count' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'reset_rcv_checkpt' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'transmitq' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'snt_nxt' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'deferred_queue' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'unacked_window' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'next_out' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'long_msg_seq_no' description in 'tipc_link'
>> net/tipc/link.c:228: warning: Excess struct member 'bc_rcvr' description in 'tipc_link'
--
>> net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
>> net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'
--
>> net/tipc/socket.c:143: warning: Excess struct member 'blocking_link' description in 'tipc_sock'
--
>> drivers/hte/hte.c:90: warning: Excess struct member 'ei' description in 'hte_device'
--
>> drivers/i2c/i2c-atr.c:98: warning: Excess struct member 'adapter' description in 'i2c_atr'
--
>> drivers/leds/leds-lm3697.c:93: warning: Excess struct member 'leds' description in 'lm3697'
--
>> drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'
--
>> drivers/of/property.c:1240: warning: Excess struct member 'parse_prop.np' description in 'supplier_bindings'
>> drivers/of/property.c:1240: warning: Excess struct member 'parse_prop.prop_name' description in 'supplier_bindings'
>> drivers/of/property.c:1240: warning: Excess struct member 'parse_prop.index' description in 'supplier_bindings'
--
>> drivers/reset/core.c:64: warning: Excess struct member 'rstc' description in 'reset_control_array'
..


vim +46 drivers/gpio/gpio-syscon.c

6a8a0c1d87377c Alexander Shiyan  2014-03-11  23  
6a8a0c1d87377c Alexander Shiyan  2014-03-11  24  /**
6a8a0c1d87377c Alexander Shiyan  2014-03-11  25   * struct syscon_gpio_data - Configuration for the device.
5f3beb67b5d1c5 Lee Jones         2020-06-30  26   * @compatible:		SYSCON driver compatible string.
5f3beb67b5d1c5 Lee Jones         2020-06-30  27   * @flags:		Set of GPIO_SYSCON_FEAT_ flags:
6a8a0c1d87377c Alexander Shiyan  2014-03-11  28   *			GPIO_SYSCON_FEAT_IN:	GPIOs supports input,
6a8a0c1d87377c Alexander Shiyan  2014-03-11  29   *			GPIO_SYSCON_FEAT_OUT:	GPIOs supports output,
6a8a0c1d87377c Alexander Shiyan  2014-03-11  30   *			GPIO_SYSCON_FEAT_DIR:	GPIOs supports switch direction.
5f3beb67b5d1c5 Lee Jones         2020-06-30  31   * @bit_count:		Number of bits used as GPIOs.
5f3beb67b5d1c5 Lee Jones         2020-06-30  32   * @dat_bit_offset:	Offset (in bits) to the first GPIO bit.
5f3beb67b5d1c5 Lee Jones         2020-06-30  33   * @dir_bit_offset:	Optional offset (in bits) to the first bit to switch
6a8a0c1d87377c Alexander Shiyan  2014-03-11  34   *			GPIO direction (Used with GPIO_SYSCON_FEAT_DIR flag).
5f3beb67b5d1c5 Lee Jones         2020-06-30  35   * @set:		HW specific callback to assigns output value
2c341d62eb4b69 Grygorii Strashko 2014-09-03  36   *			for signal "offset"
6a8a0c1d87377c Alexander Shiyan  2014-03-11  37   */
6a8a0c1d87377c Alexander Shiyan  2014-03-11  38  
6a8a0c1d87377c Alexander Shiyan  2014-03-11  39  struct syscon_gpio_data {
6a8a0c1d87377c Alexander Shiyan  2014-03-11  40  	unsigned int	flags;
6a8a0c1d87377c Alexander Shiyan  2014-03-11  41  	unsigned int	bit_count;
6a8a0c1d87377c Alexander Shiyan  2014-03-11  42  	unsigned int	dat_bit_offset;
6a8a0c1d87377c Alexander Shiyan  2014-03-11  43  	unsigned int	dir_bit_offset;
2c341d62eb4b69 Grygorii Strashko 2014-09-03  44  	void		(*set)(struct gpio_chip *chip,
2c341d62eb4b69 Grygorii Strashko 2014-09-03  45  			       unsigned offset, int value);
6a8a0c1d87377c Alexander Shiyan  2014-03-11 @46  };
6a8a0c1d87377c Alexander Shiyan  2014-03-11  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

