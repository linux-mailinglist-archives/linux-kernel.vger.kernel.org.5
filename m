Return-Path: <linux-kernel+bounces-10946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F581DF06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DA01F21DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00720F7;
	Mon, 25 Dec 2023 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq2mzm4p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93601C14;
	Mon, 25 Dec 2023 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703491769; x=1735027769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2aChuv2hSCHAdNRDTEHx6SASmQDX/0FLKZ+/kzJ26Qo=;
  b=Wq2mzm4pPXfRnp3qY1wpyHNxUEoSA6YQ2IWv5njvNG3B1XnIIVTkaZna
   lM3ov/E1D8SXjgKyrDwSwIBuQkpuu7j2ePMnd9rc2uMuLuMkwAlqhgRWQ
   uiwSaL6DLevdR9TJPmStNhDVjmwedsLhMZ9wqyHWeU++nYKb8phSCi78Z
   Wj5y9t915fdKeB1gcixNTKrllsdBLVpfcYvmdegCq6WaYAeeSqm7eieY3
   qEEBGYH8CBiIjopkvblGk62wz/tYv6WqmdM8Ex8hhdWF7c9mjQrk2YNp8
   wkpBHn7xYm/n/3jxa8UFhaElmtDVbJ+F0M/bLIkgDu0serlZyg/+oupXY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3107834"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3107834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="19397032"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Dec 2023 00:09:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHg1Z-000D8v-1B;
	Mon, 25 Dec 2023 08:09:21 +0000
Date: Mon, 25 Dec 2023 16:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: Aahil Awatramani <aahila@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to
 include a Collecting State.
Message-ID: <202312251524.jjgo5nFR-lkp@intel.com>
References: <20231221023650.3208767-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221023650.3208767-1-aahila@google.com>

Hi Aahil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231222]

url:    https://github.com/intel-lab-lkp/linux/commits/Aahil-Awatramani/bonding-Extending-LACP-MUX-State-Machine-to-include-a-Collecting-State/20231222-174732
base:   next-20231222
patch link:    https://lore.kernel.org/r/20231221023650.3208767-1-aahila%40google.com
patch subject: [PATCH next] bonding: Extending LACP MUX State Machine to include a Collecting State.
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231225/202312251524.jjgo5nFR-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251524.jjgo5nFR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251524.jjgo5nFR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/bonding/bond_3ad.c:2016: warning: Excess function parameter 'update_slave_arr' description in 'ad_enable_collecting'


vim +2016 drivers/net/bonding/bond_3ad.c

  2007	
  2008	/**
  2009	 * ad_enable_collecting - enable a port's receive
  2010	 * @port: the port we're looking at
  2011	 * @update_slave_arr: Does slave array need update?
  2012	 *
  2013	 * Enable @port if it's in an active aggregator
  2014	 */
  2015	static void ad_enable_collecting(struct port *port)
> 2016	{
  2017		if (port->aggregator->is_active) {
  2018			struct slave *slave = port->slave;
  2019	
  2020			slave_dbg(slave->bond->dev, slave->dev,
  2021				  "Enabling collecting on port %d (LAG %d)\n",
  2022				  port->actor_port_number,
  2023				  port->aggregator->aggregator_identifier);
  2024			__enable_collecting_port(port);
  2025		}
  2026	}
  2027	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

