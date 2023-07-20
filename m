Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CED75A4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGTDLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:11:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF11739
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689822697; x=1721358697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qMUt/Zn8Wqfs3BUxuYekUMjKWcdkYqvs0TeWUj7OU5A=;
  b=JodIdIcMvCLk9dXWKRtjOPXVOdmt8skzCkICC4ZUrsYAoNl7eEQVbEJI
   peM3CQyBGGD3dX92DI/MBo6GqW4rg2xFxYF/lk0gHY9saUZk9Ddj/aibT
   XsxcuMojUwMjOYwBkBx9c79ObR1uoOSVhtnw+ThRJeR61aX5olyDrCHfe
   eRiYWn5ckn7l/cPAlrlAt+xLrk5Qb5h/JlOv+pkGYtWzzTEmiOVX+lHB2
   HGK7MN3He23A/3wxxfxi4mbZmc3wJNivcBoUdniOLWEfxrwvYnDJ87pva
   NhnzGOQ1awqmSvfd8S0S+40nF06vMMKNJV6uZ28qJP8hUKHsIahnz++k5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356584874"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356584874"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 20:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718218558"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="718218558"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 20:11:34 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMK4Z-0005jE-1M;
        Thu, 20 Jul 2023 03:11:24 +0000
Date:   Thu, 20 Jul 2023 11:10:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Varun Prakash <varun@chelsio.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256)
 exceeds limit (2048) in 'nvme_tcp_recv_skb'
Message-ID: <202307201141.PYWS6ird-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: c2700d2886a87f83f31e0a301de1d2350b52c79b nvme-tcp: send H2CData PDUs based on MAXH2CDATA
date:   1 year, 5 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307201141.PYWS6ird-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201141.PYWS6ird-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307201141.PYWS6ird-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256) exceeds limit (2048) in 'nvme_tcp_recv_skb' [-Wframe-larger-than]
     835 | static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
         |            ^
   1 warning generated.


vim +/nvme_tcp_recv_skb +835 drivers/nvme/host/tcp.c

3f2304f8c6d6ed Sagi Grimberg 2018-12-03  834  
3f2304f8c6d6ed Sagi Grimberg 2018-12-03 @835  static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  836  			     unsigned int offset, size_t len)
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  837  {
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  838  	struct nvme_tcp_queue *queue = desc->arg.data;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  839  	size_t consumed = len;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  840  	int result;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  841  
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  842  	while (len) {
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  843  		switch (nvme_tcp_recv_state(queue)) {
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  844  		case NVME_TCP_RECV_PDU:
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  845  			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  846  			break;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  847  		case NVME_TCP_RECV_DATA:
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  848  			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  849  			break;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  850  		case NVME_TCP_RECV_DDGST:
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  851  			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  852  			break;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  853  		default:
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  854  			result = -EFAULT;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  855  		}
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  856  		if (result) {
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  857  			dev_err(queue->ctrl->ctrl.device,
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  858  				"receive failed:  %d\n", result);
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  859  			queue->rd_enabled = false;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  860  			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  861  			return result;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  862  		}
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  863  	}
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  864  
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  865  	return consumed;
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  866  }
3f2304f8c6d6ed Sagi Grimberg 2018-12-03  867  

:::::: The code at line 835 was first introduced by commit
:::::: 3f2304f8c6d6ed97849057bd16fee99e434ca796 nvme-tcp: add NVMe over TCP host driver

:::::: TO: Sagi Grimberg <sagi@lightbitslabs.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
