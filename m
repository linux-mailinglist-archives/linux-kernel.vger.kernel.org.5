Return-Path: <linux-kernel+bounces-15863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FA82346E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F81D1F2444D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1B1CF92;
	Wed,  3 Jan 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ao+ZXOop"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699401CA96;
	Wed,  3 Jan 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704306352; x=1735842352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTyozBGsJ68X6VYIDd0NVpbOWs1o6mrsQLngawoY/Og=;
  b=ao+ZXOop3h0hZMUIXVwXt49hlkdcCVNcltHBIygOtMXngwcCt20DvzHZ
   HKPNToHB3gCGUPbVdtOdxcxdx3Gdmh4ZfvmtaYjDbkq+t8cTjtQFwWi9m
   nUbJKbTeegQuOJDtRQPumteAr3UZYYOZ11hp7ctJThbyu/0s7FbrWbzCo
   NvHDh9fH4Ez2bTEkPwKalnCOXRbUO59z2hE8GurYvoXp4aQv36kEpI0VU
   28FE51KcVKjuxqa4kTg9OkqpYKMefaBdCbljIbwKpfoUDFwTNRZH5QsXb
   D4wV0A9nIYbA/Znk/UrT7Ywdu22o6BsqLr1qKgralkGM7xCHQPArhn3Vx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10641291"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10641291"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:25:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="773208655"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="773208655"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2024 10:25:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL5vz-000MQw-2u;
	Wed, 03 Jan 2024 18:25:43 +0000
Date: Thu, 4 Jan 2024 02:25:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, olteanv@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk, kabel@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Message-ID: <202401040103.bTPaACUE-lkp@intel.com>
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228072350.1294425-1-yajun.deng@linux.dev>

Hi Yajun,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/net-phy-Cleanup-struct-mdio_driver_common/20231228-152806
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231228072350.1294425-1-yajun.deng%40linux.dev
patch subject: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
config: s390-randconfig-002-20240103 (https://download.01.org/0day-ci/archive/20240104/202401040103.bTPaACUE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040103.bTPaACUE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040103.bTPaACUE-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/phy/mdio_bus.o: in function `mdio_bus_match':
>> mdio_bus.c:(.text+0xecc): undefined reference to `is_phy_driver'
   s390-linux-ld: drivers/net/phy/mdio_device.o: in function `mdio_device_bus_match':
>> mdio_device.c:(.text+0x934): undefined reference to `is_phy_driver'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

