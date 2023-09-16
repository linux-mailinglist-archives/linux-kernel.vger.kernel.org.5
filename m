Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0087A2D92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 05:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjIPC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjIPC6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B61BD2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694833081; x=1726369081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QN+AskX5mnsZ2YgthJWGHpcnAD7b/tv2M5x66BEJ8po=;
  b=LRyOaLqL/Pl/UZTWTiicUHD2SLTClV2gWZrj5jn/iLb5KV/fgMj5laLE
   fDiYSIjs2BCugIK4JT/LU6rHiCDXhxQKM23nhWgKo0FRw0h56wIVecn1K
   8j4GEv/VhD/w18VI4fJOA2YV4zMqSO+41S6K/16+BNFnZAphUveyVtc3v
   uxTyWWlElPCadHAlrY2wJghsVsTzQOpSUCHx8Q6hXBwumU3SV/ebNyM6X
   vGoVi45rcSXmuxAxi+fS/yMULuDKSitWV3J1NkJaReejxSnCnQyLAo93j
   xLPYmpGmoaG7cu1iRJvpSqO1CDn+3rbg8EtBvzcoOm8TYTP9MYCC8uL4U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="382112597"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="382112597"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 19:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075978066"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="1075978066"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2023 19:57:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhLVN-0003lw-18;
        Sat, 16 Sep 2023 02:57:57 +0000
Date:   Sat, 16 Sep 2023 10:57:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for
 'pcap_init_kern'
Message-ID: <202309161042.yT9kbpWB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8d7cd656361529c334e3b90535e81d818fc1157
commit: 2c4d3841a82b88ae8a7b518dc6206f84f68e705a um: Avoid pcap multiple definition errors
date:   7 months ago
config: um-randconfig-001-20230916 (https://download.01.org/0day-ci/archive/20230916/202309161042.yT9kbpWB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309161042.yT9kbpWB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309161042.yT9kbpWB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for 'pcap_init_kern' [-Wmissing-prototypes]
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         |      ^~~~~~~~~~~~~~
   arch/um/drivers/pcap_kern.c:53:5: warning: no previous prototype for 'pcap_setup' [-Wmissing-prototypes]
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         |     ^~~~~~~~~~


vim +/pcap_init_kern +18 arch/um/drivers/pcap_kern.c

    17	
  > 18	void pcap_init_kern(struct net_device *dev, void *data)
    19	{
    20		struct uml_net_private *pri;
    21		struct pcap_data *ppri;
    22		struct pcap_init *init = data;
    23	
    24		pri = netdev_priv(dev);
    25		ppri = (struct pcap_data *) pri->user;
    26		ppri->host_if = init->host_if;
    27		ppri->promisc = init->promisc;
    28		ppri->optimize = init->optimize;
    29		ppri->filter = init->filter;
    30	
    31		printk("pcap backend, host interface %s\n", ppri->host_if);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
