Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0C800B58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378914AbjLAM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLAM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:59:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0510E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701435566; x=1732971566;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5Kqdmd55kIhS9SwDbQZlx9iiKpwsGiJGuBjRxOl5VQM=;
  b=MN1wBbJjCEC27eazxc/TLbe0K2mfrim3wH3c5CkfhVa2BYjh2Hid6NyD
   uEZo1FODXexj+IsSQF/ztCj+1nv/lyxPomn3u3lIADE1WSgMDlfqHNPYD
   anOt4jV+t4o5oxXy9LMW/+G56i3pXHS2A+jGazJ5/UFFYwJ1tndqh19uW
   WH26wcKb9sOHnuh5dY2xEU+Qwoz/KIPjBp3tEZiMMN/AHI5jYq5ZmFu8K
   75MPzP9piGxyCt6SzRBIjJvPshk6MqhRDFSP7QiVl/Ng0ekkqT7EDoE5H
   Se5v3b4DlrUrr7dwXsAUvSK66uPZbGjERslk1WLBFhorKhIBWLlC0VQE5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="393229477"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="393229477"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 04:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="893212259"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="893212259"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 04:59:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9373-0003hQ-2D;
        Fri, 01 Dec 2023 12:59:21 +0000
Date:   Fri, 1 Dec 2023 20:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: drivers/pci/pci.h:343:17: sparse: sparse: cast from restricted
 pci_channel_state_t
Message-ID: <202312012039.pWgQURKD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: c82458101d5490230d735caecce14c9c27b1010c PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume
date:   9 weeks ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231201/202312012039.pWgQURKD-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312012039.pWgQURKD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312012039.pWgQURKD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/pci/pci-driver.c:522:42: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:522:61: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:757:28: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:757:46: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c: note: in included file:
>> drivers/pci/pci.h:343:17: sparse: sparse: cast from restricted pci_channel_state_t
>> drivers/pci/pci.h:343:17: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:346:23: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pci.h:350:23: sparse: sparse: cast to restricted pci_channel_state_t

vim +343 drivers/pci/pci.h

ac04840350e2c2 Lukas Wunner         2023-03-11  324  
a6bd101b8f84f9 Keith Busch          2018-09-20  325  /**
a6bd101b8f84f9 Keith Busch          2018-09-20  326   * pci_dev_set_io_state - Set the new error state if possible.
a6bd101b8f84f9 Keith Busch          2018-09-20  327   *
347269c113f10f Krzysztof Wilczyński 2021-07-03  328   * @dev: PCI device to set new error_state
347269c113f10f Krzysztof Wilczyński 2021-07-03  329   * @new: the state we want dev to be in
a6bd101b8f84f9 Keith Busch          2018-09-20  330   *
74ff8864cc842b Lukas Wunner         2023-01-20  331   * If the device is experiencing perm_failure, it has to remain in that state.
74ff8864cc842b Lukas Wunner         2023-01-20  332   * Any other transition is allowed.
a6bd101b8f84f9 Keith Busch          2018-09-20  333   *
a6bd101b8f84f9 Keith Busch          2018-09-20  334   * Returns true if state has been changed to the requested state.
a6bd101b8f84f9 Keith Busch          2018-09-20  335   */
a6bd101b8f84f9 Keith Busch          2018-09-20  336  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
a6bd101b8f84f9 Keith Busch          2018-09-20  337  					pci_channel_state_t new)
a6bd101b8f84f9 Keith Busch          2018-09-20  338  {
74ff8864cc842b Lukas Wunner         2023-01-20  339  	pci_channel_state_t old;
a6bd101b8f84f9 Keith Busch          2018-09-20  340  
a6bd101b8f84f9 Keith Busch          2018-09-20  341  	switch (new) {
a6bd101b8f84f9 Keith Busch          2018-09-20  342  	case pci_channel_io_perm_failure:
74ff8864cc842b Lukas Wunner         2023-01-20 @343  		xchg(&dev->error_state, pci_channel_io_perm_failure);
74ff8864cc842b Lukas Wunner         2023-01-20  344  		return true;
a6bd101b8f84f9 Keith Busch          2018-09-20  345  	case pci_channel_io_frozen:
74ff8864cc842b Lukas Wunner         2023-01-20  346  		old = cmpxchg(&dev->error_state, pci_channel_io_normal,
74ff8864cc842b Lukas Wunner         2023-01-20  347  			      pci_channel_io_frozen);
74ff8864cc842b Lukas Wunner         2023-01-20  348  		return old != pci_channel_io_perm_failure;
a6bd101b8f84f9 Keith Busch          2018-09-20  349  	case pci_channel_io_normal:
74ff8864cc842b Lukas Wunner         2023-01-20  350  		old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
74ff8864cc842b Lukas Wunner         2023-01-20  351  			      pci_channel_io_normal);
74ff8864cc842b Lukas Wunner         2023-01-20  352  		return old != pci_channel_io_perm_failure;
74ff8864cc842b Lukas Wunner         2023-01-20  353  	default:
74ff8864cc842b Lukas Wunner         2023-01-20  354  		return false;
a6bd101b8f84f9 Keith Busch          2018-09-20  355  	}
a6bd101b8f84f9 Keith Busch          2018-09-20  356  }
89ee9f7680031d Keith Busch          2017-03-29  357  

:::::: The code at line 343 was first introduced by commit
:::::: 74ff8864cc842be994853095dba6db48e716400a PCI: hotplug: Allow marking devices as disconnected during bind/unbind

:::::: TO: Lukas Wunner <lukas@wunner.de>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
