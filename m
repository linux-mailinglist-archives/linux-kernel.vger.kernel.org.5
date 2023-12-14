Return-Path: <linux-kernel+bounces-204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C2813D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE471C209F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E866AC9;
	Thu, 14 Dec 2023 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5d5XN2A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369266ACF;
	Thu, 14 Dec 2023 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702593753; x=1734129753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KU/A3jUQKGkyim74DOJB+aBrQP+MMoH4ytEotxAxkqA=;
  b=g5d5XN2ANud21J+s4McQv+VnYI0ibHvekwEzN77TlQ5eLl4g6TVSPHwG
   6scRWheT2vc9IXUmBdtFmWNNuIYtVh6UHRsL6t/MBKfZVdq+7Tn7fh6qZ
   jvppptoo4AjQJ52KCc1QLn8/adUg8XnlXDZJzINgONfN751lFihdPOCUp
   wgnXzoTn4jApE80d+2oVqNtrTjeBh5Sv5lyhdTpyrz8WotlDOEzGbXFNj
   bcKAJ/HGudGq6TS8iBKpGGu/ucO68+fn4owX6ej9D/wwo4GX15mXdHUCo
   z+dPHlo0DsoU6QQhnyblgwYy6WVOB5Qds4HBsB3DH7LKeZDWQbExiTwlW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2017244"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2017244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:42:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778052218"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="778052218"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 14:42:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDuPS-000MgM-0L;
	Thu, 14 Dec 2023 22:42:26 +0000
Date: Fri, 15 Dec 2023 06:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: Tomer Maimon <tmaimon77@gmail.com>, arnd@arndb.de,
	pmenzel@molgen.mpg.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	j.neuschaefer@gmx.net
Cc: oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v3 3/3] soc: nuvoton: add NPCM BPC driver
Message-ID: <202312150632.EzPYbn6l-lkp@intel.com>
References: <20231213190528.3751583-4-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213190528.3751583-4-tmaimon77@gmail.com>

Hi Tomer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-soc-nuvoton-Add-NPCM-BPC/20231214-030714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231213190528.3751583-4-tmaimon77%40gmail.com
patch subject: [PATCH v3 3/3] soc: nuvoton: add NPCM BPC driver
config: arm64-randconfig-r123-20231215 (https://download.01.org/0day-ci/archive/20231215/202312150632.EzPYbn6l-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312150632.EzPYbn6l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150632.EzPYbn6l-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/nuvoton/npcm-bpc.c:105:25: sparse: sparse: cast to restricted __poll_t
   drivers/soc/nuvoton/npcm-bpc.c:108:26: sparse: sparse: cast to restricted __poll_t

vim +105 drivers/soc/nuvoton/npcm-bpc.c

    97	
    98	static __poll_t npcm_bpc_poll(struct file *file, struct poll_table_struct *pt)
    99	{
   100		struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
   101		__poll_t mask = 0;
   102	
   103		poll_wait(file, &chan->wq, pt);
   104		if (!kfifo_is_empty(&chan->fifo))
 > 105			mask = (__poll_t)POLLIN;
   106	
   107		if (chan->host_reset) {
   108			mask |= (__poll_t)POLLHUP;
   109			chan->host_reset = false;
   110		}
   111	
   112		return mask;
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

