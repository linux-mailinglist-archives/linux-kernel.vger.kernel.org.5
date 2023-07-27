Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFDF765207
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjG0LOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG0LOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:14:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729699C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690456469; x=1721992469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o5gjD9Iz92cm+CwQnnm7g/hF8ymOaKKLMjAlOhwg/24=;
  b=RkuzIIsX2p4lfJhWwTy1nTI8mWpMK6nPCodR9VKmuzhuuWP2xLRelWSl
   Ue28cMfuOugBKbWP32rjT8b3ztOeK9RcnTmhIZFBX4jMQxASbWskLU3Ad
   GWaoPrVvd4BCwy+Acj+zapnCZAb0A71BqNDDzHJ1Ed33U9W13LxGobztc
   0j1b9v4HMkAVAkIn08kwLJUnyFviCwBBXSze1rvbQYvNA8jsuL85b1+6k
   BoH2yCAP06QUz7HyH1JPE+qzUR5gD9ELvHi78du7COv1dC/AgVRuO/bnR
   p9L3OLcUiy2zQ5I1adGBnLt1G2NksqZ1wYzquPSBrJSXddxiFlbaRStqo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="348561483"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="348561483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 04:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840739050"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840739050"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2023 04:14:27 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOywl-0002DV-2Z;
        Thu, 27 Jul 2023 11:14:26 +0000
Date:   Thu, 27 Jul 2023 19:13:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202307271907.kj7vV86A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
commit: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h
date:   2 years, 2 months ago
config: i386-randconfig-i062-20230727 (https://download.01.org/0day-ci/archive/20230727/202307271907.kj7vV86A-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271907.kj7vV86A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271907.kj7vV86A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 x @@     got unsigned short [usertype] @@
   drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse:     expected restricted __le16 x
   drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse:     got unsigned short [usertype]
--
>> drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 x @@     got unsigned short [usertype] @@
   drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse:     expected restricted __le16 x
   drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse:     got unsigned short [usertype]

vim +241 drivers/net/wireless/ath/ath6kl/htc_pipe.c

636f828844fad9 Kalle Valo    2012-03-25  202  
636f828844fad9 Kalle Valo    2012-03-25  203  static int htc_issue_packets(struct htc_target *target,
636f828844fad9 Kalle Valo    2012-03-25  204  			     struct htc_endpoint *ep,
636f828844fad9 Kalle Valo    2012-03-25  205  			     struct list_head *pkt_queue)
636f828844fad9 Kalle Valo    2012-03-25  206  {
636f828844fad9 Kalle Valo    2012-03-25  207  	int status = 0;
636f828844fad9 Kalle Valo    2012-03-25  208  	u16 payload_len;
636f828844fad9 Kalle Valo    2012-03-25  209  	struct sk_buff *skb;
636f828844fad9 Kalle Valo    2012-03-25  210  	struct htc_frame_hdr *htc_hdr;
636f828844fad9 Kalle Valo    2012-03-25  211  	struct htc_packet *packet;
636f828844fad9 Kalle Valo    2012-03-25  212  
636f828844fad9 Kalle Valo    2012-03-25  213  	ath6kl_dbg(ATH6KL_DBG_HTC,
636f828844fad9 Kalle Valo    2012-03-25  214  		   "%s: queue: 0x%p, pkts %d\n", __func__,
636f828844fad9 Kalle Valo    2012-03-25  215  		   pkt_queue, get_queue_depth(pkt_queue));
636f828844fad9 Kalle Valo    2012-03-25  216  
636f828844fad9 Kalle Valo    2012-03-25  217  	while (!list_empty(pkt_queue)) {
636f828844fad9 Kalle Valo    2012-03-25  218  		packet = list_first_entry(pkt_queue, struct htc_packet, list);
636f828844fad9 Kalle Valo    2012-03-25  219  		list_del(&packet->list);
636f828844fad9 Kalle Valo    2012-03-25  220  
636f828844fad9 Kalle Valo    2012-03-25  221  		skb = packet->skb;
636f828844fad9 Kalle Valo    2012-03-25  222  		if (!skb) {
636f828844fad9 Kalle Valo    2012-03-25  223  			WARN_ON_ONCE(1);
636f828844fad9 Kalle Valo    2012-03-25  224  			status = -EINVAL;
636f828844fad9 Kalle Valo    2012-03-25  225  			break;
636f828844fad9 Kalle Valo    2012-03-25  226  		}
636f828844fad9 Kalle Valo    2012-03-25  227  
636f828844fad9 Kalle Valo    2012-03-25  228  		payload_len = packet->act_len;
636f828844fad9 Kalle Valo    2012-03-25  229  
636f828844fad9 Kalle Valo    2012-03-25  230  		/* setup HTC frame header */
d58ff35122847a Johannes Berg 2017-06-16  231  		htc_hdr = skb_push(skb, sizeof(*htc_hdr));
636f828844fad9 Kalle Valo    2012-03-25  232  		if (!htc_hdr) {
636f828844fad9 Kalle Valo    2012-03-25  233  			WARN_ON_ONCE(1);
636f828844fad9 Kalle Valo    2012-03-25  234  			status = -EINVAL;
636f828844fad9 Kalle Valo    2012-03-25  235  			break;
636f828844fad9 Kalle Valo    2012-03-25  236  		}
636f828844fad9 Kalle Valo    2012-03-25  237  
636f828844fad9 Kalle Valo    2012-03-25  238  		packet->info.tx.flags |= HTC_FLAGS_TX_FIXUP_NETBUF;
636f828844fad9 Kalle Valo    2012-03-25  239  
636f828844fad9 Kalle Valo    2012-03-25  240  		/* Endianess? */
636f828844fad9 Kalle Valo    2012-03-25 @241  		put_unaligned((u16) payload_len, &htc_hdr->payld_len);
636f828844fad9 Kalle Valo    2012-03-25  242  		htc_hdr->flags = packet->info.tx.flags;
636f828844fad9 Kalle Valo    2012-03-25  243  		htc_hdr->eid = (u8) packet->endpoint;
636f828844fad9 Kalle Valo    2012-03-25  244  		htc_hdr->ctrl[0] = 0;
636f828844fad9 Kalle Valo    2012-03-25  245  		htc_hdr->ctrl[1] = (u8) packet->info.tx.seqno;
636f828844fad9 Kalle Valo    2012-03-25  246  
636f828844fad9 Kalle Valo    2012-03-25  247  		spin_lock_bh(&target->tx_lock);
636f828844fad9 Kalle Valo    2012-03-25  248  
636f828844fad9 Kalle Valo    2012-03-25  249  		/* store in look up queue to match completions */
636f828844fad9 Kalle Valo    2012-03-25  250  		list_add_tail(&packet->list, &ep->pipe.tx_lookup_queue);
636f828844fad9 Kalle Valo    2012-03-25  251  		ep->ep_st.tx_issued += 1;
636f828844fad9 Kalle Valo    2012-03-25  252  		spin_unlock_bh(&target->tx_lock);
636f828844fad9 Kalle Valo    2012-03-25  253  
636f828844fad9 Kalle Valo    2012-03-25  254  		status = ath6kl_hif_pipe_send(target->dev->ar,
636f828844fad9 Kalle Valo    2012-03-25  255  					      ep->pipe.pipeid_ul, NULL, skb);
636f828844fad9 Kalle Valo    2012-03-25  256  
636f828844fad9 Kalle Valo    2012-03-25  257  		if (status != 0) {
636f828844fad9 Kalle Valo    2012-03-25  258  			if (status != -ENOMEM) {
636f828844fad9 Kalle Valo    2012-03-25  259  				/* TODO: if more than 1 endpoint maps to the
636f828844fad9 Kalle Valo    2012-03-25  260  				 * same PipeID, it is possible to run out of
636f828844fad9 Kalle Valo    2012-03-25  261  				 * resources in the HIF layer.
636f828844fad9 Kalle Valo    2012-03-25  262  				 * Don't emit the error
636f828844fad9 Kalle Valo    2012-03-25  263  				 */
636f828844fad9 Kalle Valo    2012-03-25  264  				ath6kl_dbg(ATH6KL_DBG_HTC,
636f828844fad9 Kalle Valo    2012-03-25  265  					   "%s: failed status:%d\n",
636f828844fad9 Kalle Valo    2012-03-25  266  					   __func__, status);
636f828844fad9 Kalle Valo    2012-03-25  267  			}
636f828844fad9 Kalle Valo    2012-03-25  268  			spin_lock_bh(&target->tx_lock);
636f828844fad9 Kalle Valo    2012-03-25  269  			list_del(&packet->list);
636f828844fad9 Kalle Valo    2012-03-25  270  
636f828844fad9 Kalle Valo    2012-03-25  271  			/* reclaim credits */
636f828844fad9 Kalle Valo    2012-03-25  272  			ep->cred_dist.credits += packet->info.tx.cred_used;
636f828844fad9 Kalle Valo    2012-03-25  273  			spin_unlock_bh(&target->tx_lock);
636f828844fad9 Kalle Valo    2012-03-25  274  
636f828844fad9 Kalle Valo    2012-03-25  275  			/* put it back into the callers queue */
636f828844fad9 Kalle Valo    2012-03-25  276  			list_add(&packet->list, pkt_queue);
636f828844fad9 Kalle Valo    2012-03-25  277  			break;
636f828844fad9 Kalle Valo    2012-03-25  278  		}
636f828844fad9 Kalle Valo    2012-03-25  279  	}
636f828844fad9 Kalle Valo    2012-03-25  280  
636f828844fad9 Kalle Valo    2012-03-25  281  	if (status != 0) {
636f828844fad9 Kalle Valo    2012-03-25  282  		while (!list_empty(pkt_queue)) {
636f828844fad9 Kalle Valo    2012-03-25  283  			if (status != -ENOMEM) {
636f828844fad9 Kalle Valo    2012-03-25  284  				ath6kl_dbg(ATH6KL_DBG_HTC,
636f828844fad9 Kalle Valo    2012-03-25  285  					   "%s: failed pkt:0x%p status:%d\n",
636f828844fad9 Kalle Valo    2012-03-25  286  					   __func__, packet, status);
636f828844fad9 Kalle Valo    2012-03-25  287  			}
636f828844fad9 Kalle Valo    2012-03-25  288  
636f828844fad9 Kalle Valo    2012-03-25  289  			packet = list_first_entry(pkt_queue,
636f828844fad9 Kalle Valo    2012-03-25  290  						  struct htc_packet, list);
636f828844fad9 Kalle Valo    2012-03-25  291  			list_del(&packet->list);
636f828844fad9 Kalle Valo    2012-03-25  292  			packet->status = status;
636f828844fad9 Kalle Valo    2012-03-25  293  			send_packet_completion(target, packet);
636f828844fad9 Kalle Valo    2012-03-25  294  		}
636f828844fad9 Kalle Valo    2012-03-25  295  	}
636f828844fad9 Kalle Valo    2012-03-25  296  
636f828844fad9 Kalle Valo    2012-03-25  297  	return status;
636f828844fad9 Kalle Valo    2012-03-25  298  }
636f828844fad9 Kalle Valo    2012-03-25  299  

:::::: The code at line 241 was first introduced by commit
:::::: 636f828844fad9421ea6e7df053bba995febdecf ath6kl: Add HTC pipe implementation

:::::: TO: Kalle Valo <kvalo@qca.qualcomm.com>
:::::: CC: Kalle Valo <kvalo@qca.qualcomm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
