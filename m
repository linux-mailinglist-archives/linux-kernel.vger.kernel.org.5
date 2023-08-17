Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E12777FF25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354942AbjHQUdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354997AbjHQUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:33:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB47213F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692304384; x=1723840384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KcgHj5Qjj0c85hF6Y5AA7W2wEkSXNArLp+5A/d1tEQY=;
  b=lIB2NiIcLqdDMnSZeeogTpxcTRwqMhv5K2Ligf+hkI3A7u3VT9cZzgPS
   1+JKmfbDeO+pfmZ3Y9Z+Ew3yn5UAcTKLbJoPzb380DOpQhLR/CUodENQw
   WXh8DAK6nSM5p4E22OTkIi7VP60WJjorgl0JEvPpEafVSXylIRteaFLDJ
   2Jpu41AFySaDxAEYbiEpiMDsxxc4clfziJwHEjWbsembeG2KsjLv4t5m0
   tj3EdNus1G0jpEuvanPnAwvD9XZ2zbYeTAunGy+VQuYv4ptcnhmECSQZJ
   tbpa1qP8DfoDl3M/Q7iQL5kdDOiAe7h/dj51y5ylS7f3HusCSruauo8Ou
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436842292"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436842292"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 13:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824791123"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="824791123"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 13:32:57 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWjfs-0001Sb-28;
        Thu, 17 Aug 2023 20:32:56 +0000
Date:   Fri, 18 Aug 2023 04:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:279: warning: Function
 parameter or member 'rcfw' not described in '__poll_for_resp'
Message-ID: <202308180401.iaj2ktTc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: 354f5bd985af9515190828bc642ebdf59acea121 RDMA/bnxt_re: add helper function __poll_for_resp
date:   10 weeks ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308180401.iaj2ktTc-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180401.iaj2ktTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180401.iaj2ktTc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:73: warning: Function parameter or member 'opcode' not described in 'bnxt_qplib_map_rc'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'rcfw' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'cookie' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'opcode' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'rcfw' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'cookie' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'opcode' not described in '__block_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:279: warning: Function parameter or member 'rcfw' not described in '__poll_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:279: warning: Function parameter or member 'cookie' not described in '__poll_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:279: warning: Function parameter or member 'opcode' not described in '__poll_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:348: warning: Function parameter or member 'rcfw' not described in '__bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:348: warning: Function parameter or member 'msg' not described in '__bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:418: warning: Function parameter or member 'rcfw' not described in 'bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:418: warning: Function parameter or member 'msg' not described in 'bnxt_qplib_rcfw_send_message'


vim +279 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

   262	
   263	/**
   264	 * __poll_for_resp   -	self poll completion for rcfw command
   265	 * @rcfw      -   rcfw channel instance of rdev
   266	 * @cookie    -   cookie to track the command
   267	 * @opcode    -   rcfw submitted for given opcode
   268	 *
   269	 * It works same as __wait_for_resp except this function will
   270	 * do self polling in sort interval since interrupt is disabled.
   271	 * This function can not be called from non-sleepable context.
   272	 *
   273	 * Returns:
   274	 * -ETIMEOUT if command is not completed in specific time interval.
   275	 * 0 if command is completed by firmware.
   276	 */
   277	static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
   278				   u8 opcode)
 > 279	{
   280		struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
   281		unsigned long issue_time;
   282		u16 cbit;
   283	
   284		cbit = cookie % rcfw->cmdq_depth;
   285		issue_time = jiffies;
   286	
   287		do {
   288			if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
   289				return bnxt_qplib_map_rc(opcode);
   290	
   291			usleep_range(1000, 1001);
   292	
   293			bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
   294			if (!test_bit(cbit, cmdq->cmdq_bitmap))
   295				return 0;
   296			if (jiffies_to_msecs(jiffies - issue_time) > 10000)
   297				return -ETIMEDOUT;
   298		} while (true);
   299	};
   300	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
