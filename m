Return-Path: <linux-kernel+bounces-2389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF2815C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F5E1C2160F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7236B13;
	Sat, 16 Dec 2023 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMPo5g+U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF810358B9;
	Sat, 16 Dec 2023 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702765446; x=1734301446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TD+KsvHnLB4deKJ8XgtkJMBFv7hW5Pc5jeJVAl6Ta9g=;
  b=lMPo5g+UaTJtBN2QooODmuuH2WkmL3mZzfh92LT4Ln8Q6DJA9I59MoBN
   GMwsOxm2tMMDqG4nvlM+tGAOb94Tzg8QeWpb50c74fsPxoKaYZLGHZaGH
   tsL1mDD59C1OhNnDPbdAAbIwjweJ/nBa6HewsgI++4AXBwZExsygT97rP
   vxvi/zgOwv6JeorIcpIHdKWkV7CiNW59tMTRz3ZeEmyGpys4vVmiTocFW
   du7md76lwykdJKRkj78cCTCqqpckkEyEV2rHdJaQbcntMDCbLb/4kgRnN
   lY+wcJMFE287InPdHWtdYXyrN1Mi39PwGcdIm/SUaLzipEcBMRwY5yRgj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="16947076"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="16947076"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 14:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="778662987"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="778662987"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2023 14:24:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEd4h-0002Gy-1o;
	Sat, 16 Dec 2023 22:23:59 +0000
Date: Sun, 17 Dec 2023 06:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <202312170606.NWH5SzQD-lkp@intel.com>
References: <20231214122041.17439-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214122041.17439-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[cannot apply to net-next/main net/main linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/docs-ABI-sysfs-class-led-trigger-netdev-Document-now-hidable-link_/20231214-202215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20231214122041.17439-1-ansuelsmth%40gmail.com
patch subject: [PATCH v3 1/2] leds: trigger: netdev: display only supported link speed attribute
config: i386-randconfig-011-20231217 (https://download.01.org/0day-ci/archive/20231217/202312170606.NWH5SzQD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170606.NWH5SzQD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170606.NWH5SzQD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/leds/trigger/ledtrig-netdev.o: in function `get_device_state':
>> drivers/leds/trigger/ledtrig-netdev.c:230: undefined reference to `phy_speeds'


vim +230 drivers/leds/trigger/ledtrig-netdev.c

   211	
   212	static void get_device_state(struct led_netdev_data *trigger_data)
   213	{
   214		struct ethtool_link_ksettings cmd;
   215		int speeds_num;
   216	
   217		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
   218	
   219		if (__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
   220			return;
   221	
   222		if (trigger_data->carrier_link_up) {
   223			trigger_data->link_speed = cmd.base.speed;
   224			trigger_data->duplex = cmd.base.duplex;
   225		}
   226	
   227		/* Have a local copy of the link speed supported to not rtnl lock every time
   228		 * Modes are refreshed on any change event to handle mode changes
   229		 */
 > 230		speeds_num = phy_speeds(trigger_data->supported_link_speeds,
   231					ARRAY_SIZE(trigger_data->supported_link_speeds),
   232					cmd.link_modes.supported);
   233		trigger_data->supported_link_speeds_num = speeds_num;
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

