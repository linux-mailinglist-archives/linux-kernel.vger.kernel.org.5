Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32CA77FDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354422AbjHQS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354442AbjHQS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:27:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4930E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692296853; x=1723832853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dt8h/8n5UJTdKWXMvYhRQf/2cMAAght/SDEcy9FkWX8=;
  b=cDfW1jTh/Pzthsfyh0Cz9qc2QYaYWUvzBj0wlr4Bc3BmR38CmOOpEx2c
   y59gOM9wwOjE9gulWcgFH+qbA9r5EYSOOvhVnvJ4jcfA/yyfwGLixLaNf
   kP/Q4DysgQrgb6ICMb6hk47QH3gMgiqXHbXykS3YHIYKP3dzEb7DNCQeA
   asIsDUwD0PzjX9FC3n9L8LNhzFpXPgq3pZyeogFy0s6w2xmmkmVc9GnPk
   tLwF8u3FU2S7uSIyDnRnjtEmgBMT2ncD6aNOdfEoUUziy6fmfIdFH3Yp4
   meDq0BLuGhO0PARYg0LLMEgw+Ol4PXkGGDpz33AxIDzZH6JzOAkXs85WS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="357861829"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="357861829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 11:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684535991"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="684535991"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 11:26:37 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWhhc-0001Nt-0c;
        Thu, 17 Aug 2023 18:26:36 +0000
Date:   Fri, 18 Aug 2023 02:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:299: warning: Function
 parameter or member 'rcfw' not described in '__bnxt_qplib_rcfw_send_message'
Message-ID: <202308180214.Lt9NAhbM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: 65288a22ddd81422a2a2a10c15df976a5332e41b RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
date:   9 weeks ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308180214.Lt9NAhbM-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180214.Lt9NAhbM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180214.Lt9NAhbM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:73: warning: Function parameter or member 'opcode' not described in 'bnxt_qplib_map_rc'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'rcfw' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'cookie' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:105: warning: Function parameter or member 'opcode' not described in '__wait_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'rcfw' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'cookie' not described in '__block_for_resp'
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:147: warning: Function parameter or member 'opcode' not described in '__block_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:299: warning: Function parameter or member 'rcfw' not described in '__bnxt_qplib_rcfw_send_message'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:299: warning: Function parameter or member 'msg' not described in '__bnxt_qplib_rcfw_send_message'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:375: warning: Function parameter or member 'rcfw' not described in 'bnxt_qplib_rcfw_send_message'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:375: warning: Function parameter or member 'msg' not described in 'bnxt_qplib_rcfw_send_message'


vim +299 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

3022cc15119733 Kashyap Desai 2023-06-09   91  
8cf1d12ad56beb Kashyap Desai 2023-06-09   92  /**
8cf1d12ad56beb Kashyap Desai 2023-06-09   93   * __wait_for_resp   -	Don't hold the cpu context and wait for response
8cf1d12ad56beb Kashyap Desai 2023-06-09   94   * @rcfw      -   rcfw channel instance of rdev
8cf1d12ad56beb Kashyap Desai 2023-06-09   95   * @cookie    -   cookie to track the command
3022cc15119733 Kashyap Desai 2023-06-09   96   * @opcode    -   rcfw submitted for given opcode
8cf1d12ad56beb Kashyap Desai 2023-06-09   97   *
8cf1d12ad56beb Kashyap Desai 2023-06-09   98   * Wait for command completion in sleepable context.
8cf1d12ad56beb Kashyap Desai 2023-06-09   99   *
8cf1d12ad56beb Kashyap Desai 2023-06-09  100   * Returns:
8cf1d12ad56beb Kashyap Desai 2023-06-09  101   * 0 if command is completed by firmware.
8cf1d12ad56beb Kashyap Desai 2023-06-09  102   * Non zero error code for rest of the case.
8cf1d12ad56beb Kashyap Desai 2023-06-09  103   */
3022cc15119733 Kashyap Desai 2023-06-09  104  static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
1ac5a404797523 Selvin Xavier 2017-02-10 @105  {
cee0c7bba48691 Devesh Sharma 2020-02-15  106  	struct bnxt_qplib_cmdq_ctx *cmdq;
1ac5a404797523 Selvin Xavier 2017-02-10  107  	u16 cbit;
8cf1d12ad56beb Kashyap Desai 2023-06-09  108  	int ret;
1ac5a404797523 Selvin Xavier 2017-02-10  109  
cee0c7bba48691 Devesh Sharma 2020-02-15  110  	cmdq = &rcfw->cmdq;
bd1c24ccf9eb07 Devesh Sharma 2018-12-12  111  	cbit = cookie % rcfw->cmdq_depth;
8cf1d12ad56beb Kashyap Desai 2023-06-09  112  
8cf1d12ad56beb Kashyap Desai 2023-06-09  113  	do {
3022cc15119733 Kashyap Desai 2023-06-09  114  		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
3022cc15119733 Kashyap Desai 2023-06-09  115  			return bnxt_qplib_map_rc(opcode);
3022cc15119733 Kashyap Desai 2023-06-09  116  
8cf1d12ad56beb Kashyap Desai 2023-06-09  117  		/* Non zero means command completed */
8cf1d12ad56beb Kashyap Desai 2023-06-09  118  		ret = wait_event_timeout(cmdq->waitq,
cee0c7bba48691 Devesh Sharma 2020-02-15  119  					 !test_bit(cbit, cmdq->cmdq_bitmap),
8cf1d12ad56beb Kashyap Desai 2023-06-09  120  					 msecs_to_jiffies(10000));
8cf1d12ad56beb Kashyap Desai 2023-06-09  121  
8cf1d12ad56beb Kashyap Desai 2023-06-09  122  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09  123  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09  124  
8cf1d12ad56beb Kashyap Desai 2023-06-09  125  		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
8cf1d12ad56beb Kashyap Desai 2023-06-09  126  
8cf1d12ad56beb Kashyap Desai 2023-06-09  127  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09  128  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09  129  
8cf1d12ad56beb Kashyap Desai 2023-06-09  130  	} while (true);
1ac5a404797523 Selvin Xavier 2017-02-10  131  };
1ac5a404797523 Selvin Xavier 2017-02-10  132  
8cf1d12ad56beb Kashyap Desai 2023-06-09  133  /**
8cf1d12ad56beb Kashyap Desai 2023-06-09  134   * __block_for_resp   -	hold the cpu context and wait for response
8cf1d12ad56beb Kashyap Desai 2023-06-09  135   * @rcfw      -   rcfw channel instance of rdev
8cf1d12ad56beb Kashyap Desai 2023-06-09  136   * @cookie    -   cookie to track the command
3022cc15119733 Kashyap Desai 2023-06-09  137   * @opcode    -   rcfw submitted for given opcode
8cf1d12ad56beb Kashyap Desai 2023-06-09  138   *
8cf1d12ad56beb Kashyap Desai 2023-06-09  139   * This function will hold the cpu (non-sleepable context) and
8cf1d12ad56beb Kashyap Desai 2023-06-09  140   * wait for command completion. Maximum holding interval is 8 second.
8cf1d12ad56beb Kashyap Desai 2023-06-09  141   *
8cf1d12ad56beb Kashyap Desai 2023-06-09  142   * Returns:
8cf1d12ad56beb Kashyap Desai 2023-06-09  143   * -ETIMEOUT if command is not completed in specific time interval.
8cf1d12ad56beb Kashyap Desai 2023-06-09  144   * 0 if command is completed by firmware.
8cf1d12ad56beb Kashyap Desai 2023-06-09  145   */
3022cc15119733 Kashyap Desai 2023-06-09  146  static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
1ac5a404797523 Selvin Xavier 2017-02-10  147  {
8cf1d12ad56beb Kashyap Desai 2023-06-09  148  	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
8cf1d12ad56beb Kashyap Desai 2023-06-09  149  	unsigned long issue_time = 0;
1ac5a404797523 Selvin Xavier 2017-02-10  150  	u16 cbit;
1ac5a404797523 Selvin Xavier 2017-02-10  151  
bd1c24ccf9eb07 Devesh Sharma 2018-12-12  152  	cbit = cookie % rcfw->cmdq_depth;
8cf1d12ad56beb Kashyap Desai 2023-06-09  153  	issue_time = jiffies;
8cf1d12ad56beb Kashyap Desai 2023-06-09  154  
1ac5a404797523 Selvin Xavier 2017-02-10  155  	do {
3022cc15119733 Kashyap Desai 2023-06-09  156  		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
3022cc15119733 Kashyap Desai 2023-06-09  157  			return bnxt_qplib_map_rc(opcode);
3022cc15119733 Kashyap Desai 2023-06-09  158  
b9b43ad3ce883f Selvin Xavier 2021-09-15  159  		udelay(1);
8cf1d12ad56beb Kashyap Desai 2023-06-09  160  
53c2a706ae7858 Allen Pais    2020-09-03  161  		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
8cf1d12ad56beb Kashyap Desai 2023-06-09  162  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09  163  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09  164  
8cf1d12ad56beb Kashyap Desai 2023-06-09  165  	} while (time_before(jiffies, issue_time + (8 * HZ)));
8cf1d12ad56beb Kashyap Desai 2023-06-09  166  
8cf1d12ad56beb Kashyap Desai 2023-06-09  167  	return -ETIMEDOUT;
1ac5a404797523 Selvin Xavier 2017-02-10  168  };
1ac5a404797523 Selvin Xavier 2017-02-10  169  
ff015bcd213b5d Selvin Xavier 2023-03-30  170  static int __send_message(struct bnxt_qplib_rcfw *rcfw,
ff015bcd213b5d Selvin Xavier 2023-03-30  171  			  struct bnxt_qplib_cmdqmsg *msg)
1ac5a404797523 Selvin Xavier 2017-02-10  172  {
cee0c7bba48691 Devesh Sharma 2020-02-15  173  	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
cee0c7bba48691 Devesh Sharma 2020-02-15  174  	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
cee0c7bba48691 Devesh Sharma 2020-02-15  175  	struct bnxt_qplib_crsqe *crsqe;
fddcbbb02af42a Devesh Sharma 2020-04-02  176  	struct bnxt_qplib_cmdqe *cmdqe;
1ac5a404797523 Selvin Xavier 2017-02-10  177  	u32 sw_prod, cmdq_prod;
cee0c7bba48691 Devesh Sharma 2020-02-15  178  	struct pci_dev *pdev;
1ac5a404797523 Selvin Xavier 2017-02-10  179  	unsigned long flags;
f13bcef04ba046 Selvin Xavier 2023-03-30  180  	u32 bsize, opcode;
1ac5a404797523 Selvin Xavier 2017-02-10  181  	u16 cookie, cbit;
1ac5a404797523 Selvin Xavier 2017-02-10  182  	u8 *preq;
1ac5a404797523 Selvin Xavier 2017-02-10  183  
cee0c7bba48691 Devesh Sharma 2020-02-15  184  	pdev = rcfw->pdev;
cee0c7bba48691 Devesh Sharma 2020-02-15  185  
c682c6eda08140 Selvin Xavier 2023-03-30  186  	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
cee0c7bba48691 Devesh Sharma 2020-02-15  187  	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
1ac5a404797523 Selvin Xavier 2017-02-10  188  	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
2fc68543f2ab8d Selvin Xavier 2018-01-11  189  	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
2fc68543f2ab8d Selvin Xavier 2018-01-11  190  	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
cee0c7bba48691 Devesh Sharma 2020-02-15  191  		dev_err(&pdev->dev,
08920b8f5d2d3b Joe Perches   2018-08-10  192  			"RCFW not initialized, reject opcode 0x%x\n", opcode);
cc1ec769b87c7d Devesh Sharma 2017-05-22  193  		return -EINVAL;
1ac5a404797523 Selvin Xavier 2017-02-10  194  	}
1ac5a404797523 Selvin Xavier 2017-02-10  195  
cee0c7bba48691 Devesh Sharma 2020-02-15  196  	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
1ac5a404797523 Selvin Xavier 2017-02-10  197  	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
cee0c7bba48691 Devesh Sharma 2020-02-15  198  		dev_err(&pdev->dev, "RCFW already initialized!\n");
cc1ec769b87c7d Devesh Sharma 2017-05-22  199  		return -EINVAL;
1ac5a404797523 Selvin Xavier 2017-02-10  200  	}
1ac5a404797523 Selvin Xavier 2017-02-10  201  
cee0c7bba48691 Devesh Sharma 2020-02-15  202  	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
2b6376305dcb2c Somnath Kotur 2017-08-31  203  		return -ETIMEDOUT;
2b6376305dcb2c Somnath Kotur 2017-08-31  204  
1ac5a404797523 Selvin Xavier 2017-02-10  205  	/* Cmdq are in 16-byte units, each request can consume 1 or more
1ac5a404797523 Selvin Xavier 2017-02-10  206  	 * cmdqe
1ac5a404797523 Selvin Xavier 2017-02-10  207  	 */
cee0c7bba48691 Devesh Sharma 2020-02-15  208  	spin_lock_irqsave(&hwq->lock, flags);
ff015bcd213b5d Selvin Xavier 2023-03-30  209  	if (msg->req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
cee0c7bba48691 Devesh Sharma 2020-02-15  210  		dev_err(&pdev->dev, "RCFW: CMDQ is full!\n");
cee0c7bba48691 Devesh Sharma 2020-02-15  211  		spin_unlock_irqrestore(&hwq->lock, flags);
cc1ec769b87c7d Devesh Sharma 2017-05-22  212  		return -EAGAIN;
1ac5a404797523 Selvin Xavier 2017-02-10  213  	}
1ac5a404797523 Selvin Xavier 2017-02-10  214  
1ac5a404797523 Selvin Xavier 2017-02-10  215  
cee0c7bba48691 Devesh Sharma 2020-02-15  216  	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
bd1c24ccf9eb07 Devesh Sharma 2018-12-12  217  	cbit = cookie % rcfw->cmdq_depth;
ff015bcd213b5d Selvin Xavier 2023-03-30  218  	if (msg->block)
1ac5a404797523 Selvin Xavier 2017-02-10  219  		cookie |= RCFW_CMD_IS_BLOCKING;
cc1ec769b87c7d Devesh Sharma 2017-05-22  220  
cee0c7bba48691 Devesh Sharma 2020-02-15  221  	set_bit(cbit, cmdq->cmdq_bitmap);
c682c6eda08140 Selvin Xavier 2023-03-30  222  	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
cc1ec769b87c7d Devesh Sharma 2017-05-22  223  	crsqe = &rcfw->crsqe_tbl[cbit];
cc1ec769b87c7d Devesh Sharma 2017-05-22  224  	if (crsqe->resp) {
cee0c7bba48691 Devesh Sharma 2020-02-15  225  		spin_unlock_irqrestore(&hwq->lock, flags);
cc1ec769b87c7d Devesh Sharma 2017-05-22  226  		return -EBUSY;
cc1ec769b87c7d Devesh Sharma 2017-05-22  227  	}
d37b1e534071ab Selvin Xavier 2019-08-22  228  
d37b1e534071ab Selvin Xavier 2019-08-22  229  	/* change the cmd_size to the number of 16byte cmdq unit.
d37b1e534071ab Selvin Xavier 2019-08-22  230  	 * req->cmd_size is modified here
d37b1e534071ab Selvin Xavier 2019-08-22  231  	 */
f13bcef04ba046 Selvin Xavier 2023-03-30  232  	bsize = bnxt_qplib_set_cmd_slots(msg->req);
d37b1e534071ab Selvin Xavier 2019-08-22  233  
ff015bcd213b5d Selvin Xavier 2023-03-30  234  	memset(msg->resp, 0, sizeof(*msg->resp));
ff015bcd213b5d Selvin Xavier 2023-03-30  235  	crsqe->resp = (struct creq_qp_event *)msg->resp;
f13bcef04ba046 Selvin Xavier 2023-03-30  236  	crsqe->resp->cookie = cpu_to_le16(cookie);
c682c6eda08140 Selvin Xavier 2023-03-30  237  	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
c682c6eda08140 Selvin Xavier 2023-03-30  238  	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
ff015bcd213b5d Selvin Xavier 2023-03-30  239  		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
c682c6eda08140 Selvin Xavier 2023-03-30  240  		__set_cmdq_base_resp_addr(msg->req, msg->req_sz, cpu_to_le64(sbuf->dma_addr));
c682c6eda08140 Selvin Xavier 2023-03-30  241  		__set_cmdq_base_resp_size(msg->req, msg->req_sz,
c682c6eda08140 Selvin Xavier 2023-03-30  242  					  ALIGN(sbuf->size, BNXT_QPLIB_CMDQE_UNITS));
1ac5a404797523 Selvin Xavier 2017-02-10  243  	}
cc1ec769b87c7d Devesh Sharma 2017-05-22  244  
ff015bcd213b5d Selvin Xavier 2023-03-30  245  	preq = (u8 *)msg->req;
1ac5a404797523 Selvin Xavier 2017-02-10  246  	do {
1ac5a404797523 Selvin Xavier 2017-02-10  247  		/* Locate the next cmdq slot */
cee0c7bba48691 Devesh Sharma 2020-02-15  248  		sw_prod = HWQ_CMP(hwq->prod, hwq);
fddcbbb02af42a Devesh Sharma 2020-04-02  249  		cmdqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
1ac5a404797523 Selvin Xavier 2017-02-10  250  		if (!cmdqe) {
cee0c7bba48691 Devesh Sharma 2020-02-15  251  			dev_err(&pdev->dev,
08920b8f5d2d3b Joe Perches   2018-08-10  252  				"RCFW request failed with no cmdqe!\n");
1ac5a404797523 Selvin Xavier 2017-02-10  253  			goto done;
1ac5a404797523 Selvin Xavier 2017-02-10  254  		}
1ac5a404797523 Selvin Xavier 2017-02-10  255  		/* Copy a segment of the req cmd to the cmdq */
1ac5a404797523 Selvin Xavier 2017-02-10  256  		memset(cmdqe, 0, sizeof(*cmdqe));
f13bcef04ba046 Selvin Xavier 2023-03-30  257  		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
f13bcef04ba046 Selvin Xavier 2023-03-30  258  		preq += min_t(u32, bsize, sizeof(*cmdqe));
f13bcef04ba046 Selvin Xavier 2023-03-30  259  		bsize -= min_t(u32, bsize, sizeof(*cmdqe));
cee0c7bba48691 Devesh Sharma 2020-02-15  260  		hwq->prod++;
f13bcef04ba046 Selvin Xavier 2023-03-30  261  	} while (bsize > 0);
cee0c7bba48691 Devesh Sharma 2020-02-15  262  	cmdq->seq_num++;
1ac5a404797523 Selvin Xavier 2017-02-10  263  
0af91306e17ef3 Kashyap Desai 2023-06-09  264  	cmdq_prod = hwq->prod & 0xFFFF;
cee0c7bba48691 Devesh Sharma 2020-02-15  265  	if (test_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags)) {
cc1ec769b87c7d Devesh Sharma 2017-05-22  266  		/* The very first doorbell write
cc1ec769b87c7d Devesh Sharma 2017-05-22  267  		 * is required to set this flag
cc1ec769b87c7d Devesh Sharma 2017-05-22  268  		 * which prompts the FW to reset
cc1ec769b87c7d Devesh Sharma 2017-05-22  269  		 * its internal pointers
1ac5a404797523 Selvin Xavier 2017-02-10  270  		 */
a0ddc2ec8f2912 Somnath Kotur 2017-10-13  271  		cmdq_prod |= BIT(FIRMWARE_FIRST_FLAG);
cee0c7bba48691 Devesh Sharma 2020-02-15  272  		clear_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
1ac5a404797523 Selvin Xavier 2017-02-10  273  	}
1ac5a404797523 Selvin Xavier 2017-02-10  274  	/* ring CMDQ DB */
cc1ec769b87c7d Devesh Sharma 2017-05-22  275  	wmb();
cee0c7bba48691 Devesh Sharma 2020-02-15  276  	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
cee0c7bba48691 Devesh Sharma 2020-02-15  277  	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
1ac5a404797523 Selvin Xavier 2017-02-10  278  done:
cee0c7bba48691 Devesh Sharma 2020-02-15  279  	spin_unlock_irqrestore(&hwq->lock, flags);
1ac5a404797523 Selvin Xavier 2017-02-10  280  	/* Return the CREQ response pointer */
cc1ec769b87c7d Devesh Sharma 2017-05-22  281  	return 0;
cc1ec769b87c7d Devesh Sharma 2017-05-22  282  }
cc1ec769b87c7d Devesh Sharma 2017-05-22  283  
65288a22ddd814 Kashyap Desai 2023-06-09  284  /**
65288a22ddd814 Kashyap Desai 2023-06-09  285   * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
65288a22ddd814 Kashyap Desai 2023-06-09  286   * and complete rcfw command.
65288a22ddd814 Kashyap Desai 2023-06-09  287   * @rcfw      -   rcfw channel instance of rdev
65288a22ddd814 Kashyap Desai 2023-06-09  288   * @msg      -    qplib message internal
65288a22ddd814 Kashyap Desai 2023-06-09  289   *
65288a22ddd814 Kashyap Desai 2023-06-09  290   * This function does not account shadow queue depth. It will send
65288a22ddd814 Kashyap Desai 2023-06-09  291   * all the command unconditionally as long as send queue is not full.
65288a22ddd814 Kashyap Desai 2023-06-09  292   *
65288a22ddd814 Kashyap Desai 2023-06-09  293   * Returns:
65288a22ddd814 Kashyap Desai 2023-06-09  294   * 0 if command completed by firmware.
65288a22ddd814 Kashyap Desai 2023-06-09  295   * Non zero if the command is not completed by firmware.
65288a22ddd814 Kashyap Desai 2023-06-09  296   */
65288a22ddd814 Kashyap Desai 2023-06-09  297  static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
ff015bcd213b5d Selvin Xavier 2023-03-30  298  					  struct bnxt_qplib_cmdqmsg *msg)
cc1ec769b87c7d Devesh Sharma 2017-05-22 @299  {
ff015bcd213b5d Selvin Xavier 2023-03-30  300  	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
cc1ec769b87c7d Devesh Sharma 2017-05-22  301  	u16 cookie;
cc1ec769b87c7d Devesh Sharma 2017-05-22  302  	u8 opcode, retry_cnt = 0xFF;
cc1ec769b87c7d Devesh Sharma 2017-05-22  303  	int rc = 0;
cc1ec769b87c7d Devesh Sharma 2017-05-22  304  
6845485f9ed015 Selvin Xavier 2021-03-17  305  	/* Prevent posting if f/w is not in a state to process */
6845485f9ed015 Selvin Xavier 2021-03-17  306  	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
6845485f9ed015 Selvin Xavier 2021-03-17  307  		return 0;
6845485f9ed015 Selvin Xavier 2021-03-17  308  
cc1ec769b87c7d Devesh Sharma 2017-05-22  309  	do {
c682c6eda08140 Selvin Xavier 2023-03-30  310  		opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
ff015bcd213b5d Selvin Xavier 2023-03-30  311  		rc = __send_message(rcfw, msg);
c682c6eda08140 Selvin Xavier 2023-03-30  312  		cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz)) &
c682c6eda08140 Selvin Xavier 2023-03-30  313  				RCFW_MAX_COOKIE_VALUE;
cc1ec769b87c7d Devesh Sharma 2017-05-22  314  		if (!rc)
cc1ec769b87c7d Devesh Sharma 2017-05-22  315  			break;
cc1ec769b87c7d Devesh Sharma 2017-05-22  316  		if (!retry_cnt || (rc != -EAGAIN && rc != -EBUSY)) {
cc1ec769b87c7d Devesh Sharma 2017-05-22  317  			/* send failed */
08920b8f5d2d3b Joe Perches   2018-08-10  318  			dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x send failed\n",
cc1ec769b87c7d Devesh Sharma 2017-05-22  319  				cookie, opcode);
cc1ec769b87c7d Devesh Sharma 2017-05-22  320  			return rc;
1ac5a404797523 Selvin Xavier 2017-02-10  321  		}
ff015bcd213b5d Selvin Xavier 2023-03-30  322  		msg->block ? mdelay(1) : usleep_range(500, 1000);
cc1ec769b87c7d Devesh Sharma 2017-05-22  323  
cc1ec769b87c7d Devesh Sharma 2017-05-22  324  	} while (retry_cnt--);
1ac5a404797523 Selvin Xavier 2017-02-10  325  
ff015bcd213b5d Selvin Xavier 2023-03-30  326  	if (msg->block)
3022cc15119733 Kashyap Desai 2023-06-09  327  		rc = __block_for_resp(rcfw, cookie, opcode);
cc1ec769b87c7d Devesh Sharma 2017-05-22  328  	else
3022cc15119733 Kashyap Desai 2023-06-09  329  		rc = __wait_for_resp(rcfw, cookie, opcode);
cc1ec769b87c7d Devesh Sharma 2017-05-22  330  	if (rc) {
cc1ec769b87c7d Devesh Sharma 2017-05-22  331  		/* timed out */
08920b8f5d2d3b Joe Perches   2018-08-10  332  		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
cc1ec769b87c7d Devesh Sharma 2017-05-22  333  			cookie, opcode, RCFW_CMD_WAIT_TIME_MS);
cee0c7bba48691 Devesh Sharma 2020-02-15  334  		set_bit(FIRMWARE_TIMED_OUT, &rcfw->cmdq.flags);
cc1ec769b87c7d Devesh Sharma 2017-05-22  335  		return rc;
cc1ec769b87c7d Devesh Sharma 2017-05-22  336  	}
cc1ec769b87c7d Devesh Sharma 2017-05-22  337  
cc1ec769b87c7d Devesh Sharma 2017-05-22  338  	if (evnt->status) {
cc1ec769b87c7d Devesh Sharma 2017-05-22  339  		/* failed with status */
08920b8f5d2d3b Joe Perches   2018-08-10  340  		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
cc1ec769b87c7d Devesh Sharma 2017-05-22  341  			cookie, opcode, evnt->status);
cc1ec769b87c7d Devesh Sharma 2017-05-22  342  		rc = -EFAULT;
cc1ec769b87c7d Devesh Sharma 2017-05-22  343  	}
cc1ec769b87c7d Devesh Sharma 2017-05-22  344  
cc1ec769b87c7d Devesh Sharma 2017-05-22  345  	return rc;
cc1ec769b87c7d Devesh Sharma 2017-05-22  346  }
65288a22ddd814 Kashyap Desai 2023-06-09  347  
65288a22ddd814 Kashyap Desai 2023-06-09  348  /**
65288a22ddd814 Kashyap Desai 2023-06-09  349   * bnxt_qplib_rcfw_send_message   -	qplib interface to send
65288a22ddd814 Kashyap Desai 2023-06-09  350   * and complete rcfw command.
65288a22ddd814 Kashyap Desai 2023-06-09  351   * @rcfw      -   rcfw channel instance of rdev
65288a22ddd814 Kashyap Desai 2023-06-09  352   * @msg      -    qplib message internal
65288a22ddd814 Kashyap Desai 2023-06-09  353   *
65288a22ddd814 Kashyap Desai 2023-06-09  354   * Driver interact with Firmware through rcfw channel/slow path in two ways.
65288a22ddd814 Kashyap Desai 2023-06-09  355   * a. Blocking rcfw command send. In this path, driver cannot hold
65288a22ddd814 Kashyap Desai 2023-06-09  356   * the context for longer period since it is holding cpu until
65288a22ddd814 Kashyap Desai 2023-06-09  357   * command is not completed.
65288a22ddd814 Kashyap Desai 2023-06-09  358   * b. Non-blocking rcfw command send. In this path, driver can hold the
65288a22ddd814 Kashyap Desai 2023-06-09  359   * context for longer period. There may be many pending command waiting
65288a22ddd814 Kashyap Desai 2023-06-09  360   * for completion because of non-blocking nature.
65288a22ddd814 Kashyap Desai 2023-06-09  361   *
65288a22ddd814 Kashyap Desai 2023-06-09  362   * Driver will use shadow queue depth. Current queue depth of 8K
65288a22ddd814 Kashyap Desai 2023-06-09  363   * (due to size of rcfw message there can be actual ~4K rcfw outstanding)
65288a22ddd814 Kashyap Desai 2023-06-09  364   * is not optimal for rcfw command processing in firmware.
65288a22ddd814 Kashyap Desai 2023-06-09  365   *
65288a22ddd814 Kashyap Desai 2023-06-09  366   * Restrict at max #RCFW_CMD_NON_BLOCKING_SHADOW_QD Non-Blocking rcfw commands.
65288a22ddd814 Kashyap Desai 2023-06-09  367   * Allow all blocking commands until there is no queue full.
65288a22ddd814 Kashyap Desai 2023-06-09  368   *
65288a22ddd814 Kashyap Desai 2023-06-09  369   * Returns:
65288a22ddd814 Kashyap Desai 2023-06-09  370   * 0 if command completed by firmware.
65288a22ddd814 Kashyap Desai 2023-06-09  371   * Non zero if the command is not completed by firmware.
65288a22ddd814 Kashyap Desai 2023-06-09  372   */
65288a22ddd814 Kashyap Desai 2023-06-09  373  int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
65288a22ddd814 Kashyap Desai 2023-06-09  374  				 struct bnxt_qplib_cmdqmsg *msg)
65288a22ddd814 Kashyap Desai 2023-06-09 @375  {
65288a22ddd814 Kashyap Desai 2023-06-09  376  	int ret;
65288a22ddd814 Kashyap Desai 2023-06-09  377  
65288a22ddd814 Kashyap Desai 2023-06-09  378  	if (!msg->block) {
65288a22ddd814 Kashyap Desai 2023-06-09  379  		down(&rcfw->rcfw_inflight);
65288a22ddd814 Kashyap Desai 2023-06-09  380  		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
65288a22ddd814 Kashyap Desai 2023-06-09  381  		up(&rcfw->rcfw_inflight);
65288a22ddd814 Kashyap Desai 2023-06-09  382  	} else {
65288a22ddd814 Kashyap Desai 2023-06-09  383  		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
65288a22ddd814 Kashyap Desai 2023-06-09  384  	}
65288a22ddd814 Kashyap Desai 2023-06-09  385  
65288a22ddd814 Kashyap Desai 2023-06-09  386  	return ret;
65288a22ddd814 Kashyap Desai 2023-06-09  387  }
65288a22ddd814 Kashyap Desai 2023-06-09  388  

:::::: The code at line 299 was first introduced by commit
:::::: cc1ec769b87c7dea9092fb537c512e0b6b7a5dac RDMA/bnxt_re: Fixing the Control path command and response handling

:::::: TO: Devesh Sharma <devesh.sharma@broadcom.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
