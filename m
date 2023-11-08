Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229067E4E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbjKHBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjKHBLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:11:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D0513A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699405904; x=1730941904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yt5Lz1qZJCsnETRFFuaoTPBBUeDRXLQb0wowEMz6SWY=;
  b=dD87DZOQxYakEB29T/forn9l1hBrrbFC+24pUUjtJfYCcJbrNsye3f9V
   mPMX6o32+9n5l+m0r3ol8xkYK/0X5zjcTe1rajipC2gwjAnI4OJw5eId9
   IuxaEqyl6/6RgfjQjRokYQ72oug2zZo23KARWXIZ5DT1g3j1eK5HcX/uF
   ieFDB4FaPo7kixekaOt4SsNE4nDN4+aBIY1gyWJfCP7GvOinj7bDWyu1Z
   VvfKIb4+TFi+JRkKcI3TBz/YbgarKRfCt3gw7yRKXNBwu/KPeA2gufjHG
   v/vY4eIML/JDEAO2cV6bhZxNtMG2DU7pQeamhvuE5AwamNIqpU9rE6+F/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456159489"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="456159489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 17:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="739337363"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="739337363"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2023 17:11:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0X6a-0007Xg-1C;
        Wed, 08 Nov 2023 01:11:40 +0000
Date:   Wed, 8 Nov 2023 09:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: drivers/nvme/common/keyring.c:117:3: sparse: sparse: symbol
 'nvme_tls_psk_prio' was not declared. Should it be static?
Message-ID: <202311080803.T1Rc5Q3B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13d88ac54ddd1011b6e94443958e798aa06eb835
commit: be8e82caa685997b524dc7e4932853fd2fbe6199 nvme-tcp: enable TLS handshake upcall
date:   4 weeks ago
config: i386-randconfig-061-20231108 (https://download.01.org/0day-ci/archive/20231108/202311080803.T1Rc5Q3B-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080803.T1Rc5Q3B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080803.T1Rc5Q3B-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/common/keyring.c:117:3: sparse: sparse: symbol 'nvme_tls_psk_prio' was not declared. Should it be static?

vim +/nvme_tls_psk_prio +117 drivers/nvme/common/keyring.c

3bac969b16b7bc Hannes Reinecke 2023-08-24  106  
501cc6f4aca8dc Hannes Reinecke 2023-08-24  107  /*
501cc6f4aca8dc Hannes Reinecke 2023-08-24  108   * NVMe PSK priority list
501cc6f4aca8dc Hannes Reinecke 2023-08-24  109   *
501cc6f4aca8dc Hannes Reinecke 2023-08-24  110   * 'Retained' PSKs (ie 'generated == false')
501cc6f4aca8dc Hannes Reinecke 2023-08-24  111   * should be preferred to 'generated' PSKs,
501cc6f4aca8dc Hannes Reinecke 2023-08-24  112   * and SHA-384 should be preferred to SHA-256.
501cc6f4aca8dc Hannes Reinecke 2023-08-24  113   */
501cc6f4aca8dc Hannes Reinecke 2023-08-24  114  struct nvme_tls_psk_priority_list {
501cc6f4aca8dc Hannes Reinecke 2023-08-24  115  	bool generated;
501cc6f4aca8dc Hannes Reinecke 2023-08-24  116  	enum nvme_tcp_tls_cipher cipher;
501cc6f4aca8dc Hannes Reinecke 2023-08-24 @117  } nvme_tls_psk_prio[] = {
501cc6f4aca8dc Hannes Reinecke 2023-08-24  118  	{ .generated = false,
501cc6f4aca8dc Hannes Reinecke 2023-08-24  119  	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
501cc6f4aca8dc Hannes Reinecke 2023-08-24  120  	{ .generated = false,
501cc6f4aca8dc Hannes Reinecke 2023-08-24  121  	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
501cc6f4aca8dc Hannes Reinecke 2023-08-24  122  	{ .generated = true,
501cc6f4aca8dc Hannes Reinecke 2023-08-24  123  	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
501cc6f4aca8dc Hannes Reinecke 2023-08-24  124  	{ .generated = true,
501cc6f4aca8dc Hannes Reinecke 2023-08-24  125  	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
501cc6f4aca8dc Hannes Reinecke 2023-08-24  126  };
501cc6f4aca8dc Hannes Reinecke 2023-08-24  127  

:::::: The code at line 117 was first introduced by commit
:::::: 501cc6f4aca8dc0958c4d9716f0233ba7cff4830 nvme-keyring: implement nvme_tls_psk_default()

:::::: TO: Hannes Reinecke <hare@suse.de>
:::::: CC: Keith Busch <kbusch@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
