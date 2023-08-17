Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92559780148
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355873AbjHQWtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355876AbjHQWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:49:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10432722
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692312582; x=1723848582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n//xZJgF+fdbBXtZJSi3l8HgglzPGjRalK3RG40kkdU=;
  b=iIPA5JUfbZZ0gZy1js07+HQc9QiwifyN48tEB+yRufFjeOaYYwI6TYPd
   rZTXBnbUabUH0I9Mle+5VVLmDrqcm/BB20saVlh+YNjr+U5Wi5utltCnB
   KKgFOs9WO/Q8AJ64uS/q4qk3auNSoC+uHiK/Gjc7MoWiScjZyDQoc3XQ9
   s1EALQ2MVzmoR/YRd4s8u1asU/Lw4oVjSHMnnBJ/GKWLbOjXEMLmvdgQn
   Thz9H3CoXeubhDXpuNYNkxj16WaZR0pyx77ylXBgXLJBJAptQ3b+eOTZi
   qzSQ0J6dS2mf8SaztBLRw0J/ohQj3eVEIqBMKBGKzP0+oPSvdPd3len23
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403931303"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="403931303"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 15:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858411464"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="858411464"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 15:49:39 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWloB-0001XF-0A;
        Thu, 17 Aug 2023 22:49:39 +0000
Date:   Fri, 18 Aug 2023 06:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108: warning: Function
 parameter or member 'rcfw' not described in 'bnxt_re_is_fw_stalled'
Message-ID: <202308180600.oOnkIAQV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: f0c875ff6293965a30aaeb02a0d19b293e11bc2b RDMA/bnxt_re: use firmware provided max request timeout
date:   10 weeks ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308180600.oOnkIAQV-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180600.oOnkIAQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180600.oOnkIAQV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:73: warning: Function parameter or member 'opcode' not described in 'bnxt_qplib_map_rc'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108: warning: Function parameter or member 'rcfw' not described in 'bnxt_re_is_fw_stalled'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108: warning: Function parameter or member 'cookie' not described in 'bnxt_re_is_fw_stalled'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108: warning: Function parameter or member 'opcode' not described in 'bnxt_re_is_fw_stalled'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108: warning: Function parameter or member 'cbit' not described in 'bnxt_re_is_fw_stalled'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:140: warning: Function parameter or member 'rcfw' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:140: warning: Function parameter or member 'cookie' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:140: warning: Function parameter or member 'opcode' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:188: warning: Function parameter or member 'rcfw' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:188: warning: Function parameter or member 'cookie' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:188: warning: Function parameter or member 'opcode' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:386: warning: Function parameter or member 'rcfw' not described in '__poll_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:386: warning: Function parameter or member 'cookie' not described in '__poll_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:386: warning: Function parameter or member 'opcode' not described in '__poll_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:484: warning: Function parameter or member 'rcfw' not described in '__bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:484: warning: Function parameter or member 'msg' not described in '__bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:566: warning: Function parameter or member 'rcfw' not described in 'bnxt_qplib_rcfw_send_message'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:566: warning: Function parameter or member 'msg' not described in 'bnxt_qplib_rcfw_send_message'


vim +108 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

    55	
    56	/**
    57	 * bnxt_qplib_map_rc  -  map return type based on opcode
    58	 * @opcode    -  roce slow path opcode
    59	 *
    60	 * In some cases like firmware halt is detected, the driver is supposed to
    61	 * remap the error code of the timed out command.
    62	 *
    63	 * It is not safe to assume hardware is really inactive so certain opcodes
    64	 * like destroy qp etc are not safe to be returned success, but this function
    65	 * will be called when FW already reports a timeout. This would be possible
    66	 * only when FW crashes and resets. This will clear all the HW resources.
    67	 *
    68	 * Returns:
    69	 * 0 to communicate success to caller.
    70	 * Non zero error code to communicate failure to caller.
    71	 */
    72	static int bnxt_qplib_map_rc(u8 opcode)
  > 73	{
    74		switch (opcode) {
    75		case CMDQ_BASE_OPCODE_DESTROY_QP:
    76		case CMDQ_BASE_OPCODE_DESTROY_SRQ:
    77		case CMDQ_BASE_OPCODE_DESTROY_CQ:
    78		case CMDQ_BASE_OPCODE_DEALLOCATE_KEY:
    79		case CMDQ_BASE_OPCODE_DEREGISTER_MR:
    80		case CMDQ_BASE_OPCODE_DELETE_GID:
    81		case CMDQ_BASE_OPCODE_DESTROY_QP1:
    82		case CMDQ_BASE_OPCODE_DESTROY_AH:
    83		case CMDQ_BASE_OPCODE_DEINITIALIZE_FW:
    84		case CMDQ_BASE_OPCODE_MODIFY_ROCE_CC:
    85		case CMDQ_BASE_OPCODE_SET_LINK_AGGR_MODE:
    86			return 0;
    87		default:
    88			return -ETIMEDOUT;
    89		}
    90	}
    91	
    92	/**
    93	 * bnxt_re_is_fw_stalled   -	Check firmware health
    94	 * @rcfw      -   rcfw channel instance of rdev
    95	 * @cookie    -   cookie to track the command
    96	 * @opcode    -   rcfw submitted for given opcode
    97	 * @cbit      -   bitmap entry of cookie
    98	 *
    99	 * If firmware has not responded any rcfw command within
   100	 * rcfw->max_timeout, consider firmware as stalled.
   101	 *
   102	 * Returns:
   103	 * 0 if firmware is responding
   104	 * -ENODEV if firmware is not responding
   105	 */
   106	static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
   107					 u16 cookie, u8 opcode, u16 cbit)
 > 108	{
   109		struct bnxt_qplib_cmdq_ctx *cmdq;
   110	
   111		cmdq = &rcfw->cmdq;
   112	
   113		if (time_after(jiffies, cmdq->last_seen +
   114			      (rcfw->max_timeout * HZ))) {
   115			dev_warn_ratelimited(&rcfw->pdev->dev,
   116					     "%s: FW STALL Detected. cmdq[%#x]=%#x waited (%d > %d) msec active %d ",
   117					     __func__, cookie, opcode,
   118					     jiffies_to_msecs(jiffies - cmdq->last_seen),
   119					     rcfw->max_timeout * 1000,
   120					     test_bit(cbit, cmdq->cmdq_bitmap));
   121			return -ENODEV;
   122		}
   123	
   124		return 0;
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
