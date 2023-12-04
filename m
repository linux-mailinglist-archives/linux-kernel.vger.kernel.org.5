Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1023803E94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjLDTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjLDTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:41:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F154134
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701718892; x=1733254892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eX/UwbFr/TdwMvmVc/c3IWuZs2xuSFsBCtQFLK84w9Y=;
  b=WgV4GS/Dr+DBvPLsx3QL1OD0xtY73bONSXcI7156HMWNjoNjY6TJQi5B
   meV+aSkFHNAteI1CVEHvLqUyvASNHUJOiHPhwoMHpBY0oCi98xIc6Sa7X
   aWhDwKGkSj4Yab/Urik48wP44TyySxtnear/l4bFFlTUb3YiLlLSspXPS
   WQ2eBO648Ci6WpdMCP1hMhVv7flYga0l35bogzTHjmVgtvb9eKxt1T5vO
   HRHXh6TcQLtgCy5aqGKO6fwVZ67e6J9k75hW1uj8zyGoYWL+HSbwD42el
   Ked+fyMkF1w6zA8jFIjQuRZoUk/FueFgRnjY/2ZIg0q+uZ80v7d2+u2+t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="855401"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="855401"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861492962"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="861492962"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 11:41:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAEoi-00081o-19;
        Mon, 04 Dec 2023 19:41:22 +0000
Date:   Tue, 5 Dec 2023 03:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312050259.TaopJEnL-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   3 years ago
config: powerpc-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231205/202312050259.TaopJEnL-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050259.TaopJEnL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050259.TaopJEnL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *inb_read_pointer @@
   drivers/scsi/mvumi.c:407:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:40: sparse:     got void *inb_read_pointer
>> drivers/scsi/mvumi.c:429:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:30: sparse:     got void *ib_shadow
>> drivers/scsi/mvumi.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:31: sparse:     got void *ib_shadow
>> drivers/scsi/mvumi.c:459:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:48: sparse:     got void *inb_write_pointer
>> drivers/scsi/mvumi.c:496:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:41: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:41: sparse:     got void *outb_copy_pointer
>> drivers/scsi/mvumi.c:497:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:48: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:48: sparse:     got void *ob_shadow
>> drivers/scsi/mvumi.c:516:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:33: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:33: sparse:     got void *outb_copy_pointer
>> drivers/scsi/mvumi.c:578:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:42: sparse:     got void *outb_read_pointer
>> drivers/scsi/mvumi.c:585:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:26: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:586:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:26: sparse:     got void *arm_to_pciea_msg1
>> drivers/scsi/mvumi.c:589:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:40: sparse:     got void *pciea_to_arm_drbl_reg
>> drivers/scsi/mvumi.c:1281:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:28: sparse:     got void *arm_to_pciea_drbl_reg
>> drivers/scsi/mvumi.c:1282:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:28: sparse:     got void *arm_to_pciea_drbl_reg
>> drivers/scsi/mvumi.c:1284:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:48: sparse:     got void *arm_to_pciea_mask_reg
>> drivers/scsi/mvumi.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:28: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:46: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:46: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:36: sparse:     got void *arm_to_pciea_msg1
>> drivers/scsi/mvumi.c:670:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:32: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:32: sparse:     got void *reset_enable
>> drivers/scsi/mvumi.c:671:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:34: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:673:35: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:674:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:674:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:674:35: sparse:     got void *reset_request
>> drivers/scsi/mvumi.c:1100:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg0 @@
   drivers/scsi/mvumi.c:1100:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1100:36: sparse:     got void *arm_to_pciea_msg0
>> drivers/scsi/mvumi.c:1115:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1115:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1115:52: sparse:     got void *pciea_to_arm_msg1
>> drivers/scsi/mvumi.c:1116:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1116:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1116:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1117:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1117:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1117:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1122:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1122:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1122:45: sparse:     got void *pciea_to_arm_msg1
>> drivers/scsi/mvumi.c:1124:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1124:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1124:45: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1127:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1127:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1127:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1128:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1128:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1128:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1168:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1168:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1168:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1169:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1169:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1169:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1174:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1174:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1174:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1176:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1176:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1176:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1177:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:1177:50: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1177:50: sparse:     got void *ib_shadow
>> drivers/scsi/mvumi.c:1180:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *inb_aval_count_basel @@
   drivers/scsi/mvumi.c:1180:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1180:45: sparse:     got void *inb_aval_count_basel
>> drivers/scsi/mvumi.c:1182:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *inb_aval_count_baseh @@
   drivers/scsi/mvumi.c:1182:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1182:45: sparse:     got void *inb_aval_count_baseh
>> drivers/scsi/mvumi.c:1188:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:1188:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1188:61: sparse:     got void *ob_shadow
>> drivers/scsi/mvumi.c:1190:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_copy_basel @@
   drivers/scsi/mvumi.c:1190:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1190:61: sparse:     got void *outb_copy_basel
>> drivers/scsi/mvumi.c:1192:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_copy_baseh @@
   drivers/scsi/mvumi.c:1192:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1192:61: sparse:     got void *outb_copy_baseh
   drivers/scsi/mvumi.c:1244:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1244:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1244:34: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1248:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1248:51: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1248:51: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1256:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1256:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1256:42: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1849:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_low_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1849:35: sparse:     expected unsigned int [usertype] src_low_addr
   drivers/scsi/mvumi.c:1849:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1851:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_high_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1851:36: sparse:     expected unsigned int [usertype] src_high_addr
   drivers/scsi/mvumi.c:1851:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1903:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1903:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1903:48: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1904:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1904:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1904:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1906:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1906:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1906:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1918:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1918:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1918:26: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1919:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1919:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1919:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1922:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1922:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1922:29: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:1931:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *main_int_cause_reg @@
   drivers/scsi/mvumi.c:1931:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1931:31: sparse:     got void *main_int_cause_reg
>> drivers/scsi/mvumi.c:1935:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1935:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1935:36: sparse:     got void *outb_isr_cause
>> drivers/scsi/mvumi.c:1939:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1939:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1939:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1945:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1945:53: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1945:53: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1951:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1951:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1951:36: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1953:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1953:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1953:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1956:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1956:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1956:43: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1958:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1958:51: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1958:51: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1975:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1975:37: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1975:37: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1977:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1977:45: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1977:45: sparse:     got void *arm_to_pciea_drbl_reg

vim +407 drivers/scsi/mvumi.c

f0c568a478f0353 Jianyun Li 2011-05-11  401  
bd756ddea18e02c Shun Fu    2012-09-23  402  static unsigned int mvumi_check_ib_list_9143(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  403  {
bd756ddea18e02c Shun Fu    2012-09-23  404  	unsigned int ib_rp_reg;
bd756ddea18e02c Shun Fu    2012-09-23  405  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  406  
bd756ddea18e02c Shun Fu    2012-09-23 @407  	ib_rp_reg = ioread32(mhba->regs->inb_read_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  408  
bd756ddea18e02c Shun Fu    2012-09-23  409  	if (unlikely(((ib_rp_reg & regs->cl_slot_num_mask) ==
bd756ddea18e02c Shun Fu    2012-09-23  410  			(mhba->ib_cur_slot & regs->cl_slot_num_mask)) &&
bd756ddea18e02c Shun Fu    2012-09-23  411  			((ib_rp_reg & regs->cl_pointer_toggle)
bd756ddea18e02c Shun Fu    2012-09-23  412  			 != (mhba->ib_cur_slot & regs->cl_pointer_toggle)))) {
bd756ddea18e02c Shun Fu    2012-09-23  413  		dev_warn(&mhba->pdev->dev, "no free slot to use.\n");
bd756ddea18e02c Shun Fu    2012-09-23  414  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  415  	}
f0c568a478f0353 Jianyun Li 2011-05-11  416  	if (atomic_read(&mhba->fw_outstanding) >= mhba->max_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  417  		dev_warn(&mhba->pdev->dev, "firmware io overflow.\n");
bd756ddea18e02c Shun Fu    2012-09-23  418  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  419  	} else {
bd756ddea18e02c Shun Fu    2012-09-23  420  		return mhba->max_io - atomic_read(&mhba->fw_outstanding);
bd756ddea18e02c Shun Fu    2012-09-23  421  	}
f0c568a478f0353 Jianyun Li 2011-05-11  422  }
f0c568a478f0353 Jianyun Li 2011-05-11  423  
bd756ddea18e02c Shun Fu    2012-09-23  424  static unsigned int mvumi_check_ib_list_9580(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu    2012-09-23  425  {
bd756ddea18e02c Shun Fu    2012-09-23  426  	unsigned int count;
bd756ddea18e02c Shun Fu    2012-09-23  427  	if (atomic_read(&mhba->fw_outstanding) >= (mhba->max_io - 1))
bd756ddea18e02c Shun Fu    2012-09-23  428  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23 @429  	count = ioread32(mhba->ib_shadow);
bd756ddea18e02c Shun Fu    2012-09-23  430  	if (count == 0xffff)
bd756ddea18e02c Shun Fu    2012-09-23  431  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  432  	return count;
f0c568a478f0353 Jianyun Li 2011-05-11  433  }
f0c568a478f0353 Jianyun Li 2011-05-11  434  
bd756ddea18e02c Shun Fu    2012-09-23  435  static void mvumi_get_ib_list_entry(struct mvumi_hba *mhba, void **ib_entry)
bd756ddea18e02c Shun Fu    2012-09-23  436  {
bd756ddea18e02c Shun Fu    2012-09-23  437  	unsigned int cur_ib_entry;
bd756ddea18e02c Shun Fu    2012-09-23  438  
bd756ddea18e02c Shun Fu    2012-09-23  439  	cur_ib_entry = mhba->ib_cur_slot & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li 2011-05-11  440  	cur_ib_entry++;
f0c568a478f0353 Jianyun Li 2011-05-11  441  	if (cur_ib_entry >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  442  		cur_ib_entry -= mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  443  		mhba->ib_cur_slot ^= mhba->regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  444  	}
bd756ddea18e02c Shun Fu    2012-09-23  445  	mhba->ib_cur_slot &= ~mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  446  	mhba->ib_cur_slot |= (cur_ib_entry & mhba->regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu    2012-09-23  447  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu    2012-09-23  448  		*ib_entry = mhba->ib_list + cur_ib_entry *
bd756ddea18e02c Shun Fu    2012-09-23  449  				sizeof(struct mvumi_dyn_list_entry);
bd756ddea18e02c Shun Fu    2012-09-23  450  	} else {
f0c568a478f0353 Jianyun Li 2011-05-11  451  		*ib_entry = mhba->ib_list + cur_ib_entry * mhba->ib_max_size;
bd756ddea18e02c Shun Fu    2012-09-23  452  	}
f0c568a478f0353 Jianyun Li 2011-05-11  453  	atomic_inc(&mhba->fw_outstanding);
f0c568a478f0353 Jianyun Li 2011-05-11  454  }
f0c568a478f0353 Jianyun Li 2011-05-11  455  
f0c568a478f0353 Jianyun Li 2011-05-11  456  static void mvumi_send_ib_list_entry(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  457  {
bd756ddea18e02c Shun Fu    2012-09-23 @458  	iowrite32(0xffff, mhba->ib_shadow);
bd756ddea18e02c Shun Fu    2012-09-23 @459  	iowrite32(mhba->ib_cur_slot, mhba->regs->inb_write_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  460  }
f0c568a478f0353 Jianyun Li 2011-05-11  461  
f0c568a478f0353 Jianyun Li 2011-05-11  462  static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li 2011-05-11  463  		unsigned int cur_obf, struct mvumi_rsp_frame *p_outb_frame)
f0c568a478f0353 Jianyun Li 2011-05-11  464  {
f0c568a478f0353 Jianyun Li 2011-05-11  465  	unsigned short tag, request_id;
f0c568a478f0353 Jianyun Li 2011-05-11  466  
f0c568a478f0353 Jianyun Li 2011-05-11  467  	udelay(1);
f0c568a478f0353 Jianyun Li 2011-05-11  468  	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li 2011-05-11  469  	request_id = p_outb_frame->request_id;
f0c568a478f0353 Jianyun Li 2011-05-11  470  	tag = p_outb_frame->tag;
f0c568a478f0353 Jianyun Li 2011-05-11  471  	if (tag > mhba->tag_pool.size) {
f0c568a478f0353 Jianyun Li 2011-05-11  472  		dev_err(&mhba->pdev->dev, "ob frame data error\n");
f0c568a478f0353 Jianyun Li 2011-05-11  473  		return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  474  	}
f0c568a478f0353 Jianyun Li 2011-05-11  475  	if (mhba->tag_cmd[tag] == NULL) {
f0c568a478f0353 Jianyun Li 2011-05-11  476  		dev_err(&mhba->pdev->dev, "tag[0x%x] with NO command\n", tag);
f0c568a478f0353 Jianyun Li 2011-05-11  477  		return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  478  	} else if (mhba->tag_cmd[tag]->request_id != request_id &&
f0c568a478f0353 Jianyun Li 2011-05-11  479  						mhba->request_id_enabled) {
f0c568a478f0353 Jianyun Li 2011-05-11  480  			dev_err(&mhba->pdev->dev, "request ID from FW:0x%x,"
f0c568a478f0353 Jianyun Li 2011-05-11  481  					"cmd request ID:0x%x\n", request_id,
f0c568a478f0353 Jianyun Li 2011-05-11  482  					mhba->tag_cmd[tag]->request_id);
f0c568a478f0353 Jianyun Li 2011-05-11  483  			return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  484  	}
f0c568a478f0353 Jianyun Li 2011-05-11  485  
f0c568a478f0353 Jianyun Li 2011-05-11  486  	return 0;
f0c568a478f0353 Jianyun Li 2011-05-11  487  }
f0c568a478f0353 Jianyun Li 2011-05-11  488  
bd756ddea18e02c Shun Fu    2012-09-23  489  static int mvumi_check_ob_list_9143(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu    2012-09-23  490  			unsigned int *cur_obf, unsigned int *assign_obf_end)
f0c568a478f0353 Jianyun Li 2011-05-11  491  {
bd756ddea18e02c Shun Fu    2012-09-23  492  	unsigned int ob_write, ob_write_shadow;
bd756ddea18e02c Shun Fu    2012-09-23  493  	struct mvumi_hw_regs *regs = mhba->regs;
f0c568a478f0353 Jianyun Li 2011-05-11  494  
f0c568a478f0353 Jianyun Li 2011-05-11  495  	do {
bd756ddea18e02c Shun Fu    2012-09-23 @496  		ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu    2012-09-23 @497  		ob_write_shadow = ioread32(mhba->ob_shadow);
bd756ddea18e02c Shun Fu    2012-09-23  498  	} while ((ob_write & regs->cl_slot_num_mask) != ob_write_shadow);
f0c568a478f0353 Jianyun Li 2011-05-11  499  
bd756ddea18e02c Shun Fu    2012-09-23  500  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  501  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li 2011-05-11  502  
bd756ddea18e02c Shun Fu    2012-09-23  503  	if ((ob_write & regs->cl_pointer_toggle) !=
bd756ddea18e02c Shun Fu    2012-09-23  504  			(mhba->ob_cur_slot & regs->cl_pointer_toggle)) {
bd756ddea18e02c Shun Fu    2012-09-23  505  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  506  	}
bd756ddea18e02c Shun Fu    2012-09-23  507  	return 0;
f0c568a478f0353 Jianyun Li 2011-05-11  508  }
f0c568a478f0353 Jianyun Li 2011-05-11  509  
bd756ddea18e02c Shun Fu    2012-09-23  510  static int mvumi_check_ob_list_9580(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu    2012-09-23  511  			unsigned int *cur_obf, unsigned int *assign_obf_end)
bd756ddea18e02c Shun Fu    2012-09-23  512  {
bd756ddea18e02c Shun Fu    2012-09-23  513  	unsigned int ob_write;
bd756ddea18e02c Shun Fu    2012-09-23  514  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  515  
bd756ddea18e02c Shun Fu    2012-09-23 @516  	ob_write = ioread32(regs->outb_read_pointer);
bd756ddea18e02c Shun Fu    2012-09-23  517  	ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu    2012-09-23  518  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  519  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  520  	if (*assign_obf_end < *cur_obf)
bd756ddea18e02c Shun Fu    2012-09-23  521  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  522  	else if (*assign_obf_end == *cur_obf)
bd756ddea18e02c Shun Fu    2012-09-23  523  		return -1;
bd756ddea18e02c Shun Fu    2012-09-23  524  	return 0;
bd756ddea18e02c Shun Fu    2012-09-23  525  }
bd756ddea18e02c Shun Fu    2012-09-23  526  
bd756ddea18e02c Shun Fu    2012-09-23  527  static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu    2012-09-23  528  {
bd756ddea18e02c Shun Fu    2012-09-23  529  	unsigned int cur_obf, assign_obf_end, i;
bd756ddea18e02c Shun Fu    2012-09-23  530  	struct mvumi_ob_data *ob_data;
bd756ddea18e02c Shun Fu    2012-09-23  531  	struct mvumi_rsp_frame *p_outb_frame;
bd756ddea18e02c Shun Fu    2012-09-23  532  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  533  
bd756ddea18e02c Shun Fu    2012-09-23  534  	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
bd756ddea18e02c Shun Fu    2012-09-23  535  		return;
bd756ddea18e02c Shun Fu    2012-09-23  536  
f0c568a478f0353 Jianyun Li 2011-05-11  537  	for (i = (assign_obf_end - cur_obf); i != 0; i--) {
f0c568a478f0353 Jianyun Li 2011-05-11  538  		cur_obf++;
f0c568a478f0353 Jianyun Li 2011-05-11  539  		if (cur_obf >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  540  			cur_obf -= mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  541  			mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  542  		}
f0c568a478f0353 Jianyun Li 2011-05-11  543  
f0c568a478f0353 Jianyun Li 2011-05-11  544  		p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li 2011-05-11  545  
f0c568a478f0353 Jianyun Li 2011-05-11  546  		/* Copy pointer may point to entry in outbound list
f0c568a478f0353 Jianyun Li 2011-05-11  547  		*  before entry has valid data
f0c568a478f0353 Jianyun Li 2011-05-11  548  		*/
f0c568a478f0353 Jianyun Li 2011-05-11  549  		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
f0c568a478f0353 Jianyun Li 2011-05-11  550  			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
f0c568a478f0353 Jianyun Li 2011-05-11  551  			p_outb_frame->request_id !=
f0c568a478f0353 Jianyun Li 2011-05-11  552  				mhba->tag_cmd[p_outb_frame->tag]->request_id))
f0c568a478f0353 Jianyun Li 2011-05-11  553  			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
f0c568a478f0353 Jianyun Li 2011-05-11  554  				continue;
f0c568a478f0353 Jianyun Li 2011-05-11  555  
f0c568a478f0353 Jianyun Li 2011-05-11  556  		if (!list_empty(&mhba->ob_data_list)) {
f0c568a478f0353 Jianyun Li 2011-05-11  557  			ob_data = (struct mvumi_ob_data *)
f0c568a478f0353 Jianyun Li 2011-05-11  558  				list_first_entry(&mhba->ob_data_list,
f0c568a478f0353 Jianyun Li 2011-05-11  559  					struct mvumi_ob_data, list);
f0c568a478f0353 Jianyun Li 2011-05-11  560  			list_del_init(&ob_data->list);
f0c568a478f0353 Jianyun Li 2011-05-11  561  		} else {
f0c568a478f0353 Jianyun Li 2011-05-11  562  			ob_data = NULL;
f0c568a478f0353 Jianyun Li 2011-05-11  563  			if (cur_obf == 0) {
f0c568a478f0353 Jianyun Li 2011-05-11  564  				cur_obf = mhba->list_num_io - 1;
bd756ddea18e02c Shun Fu    2012-09-23  565  				mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  566  			} else
f0c568a478f0353 Jianyun Li 2011-05-11  567  				cur_obf -= 1;
f0c568a478f0353 Jianyun Li 2011-05-11  568  			break;
f0c568a478f0353 Jianyun Li 2011-05-11  569  		}
f0c568a478f0353 Jianyun Li 2011-05-11  570  
f0c568a478f0353 Jianyun Li 2011-05-11  571  		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
f0c568a478f0353 Jianyun Li 2011-05-11  572  		p_outb_frame->tag = 0xff;
f0c568a478f0353 Jianyun Li 2011-05-11  573  
f0c568a478f0353 Jianyun Li 2011-05-11  574  		list_add_tail(&ob_data->list, &mhba->free_ob_list);
f0c568a478f0353 Jianyun Li 2011-05-11  575  	}
bd756ddea18e02c Shun Fu    2012-09-23  576  	mhba->ob_cur_slot &= ~regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  577  	mhba->ob_cur_slot |= (cur_obf & regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu    2012-09-23 @578  	iowrite32(mhba->ob_cur_slot, regs->outb_read_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  579  }
f0c568a478f0353 Jianyun Li 2011-05-11  580  
bd756ddea18e02c Shun Fu    2012-09-23  581  static void mvumi_reset(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  582  {
bd756ddea18e02c Shun Fu    2012-09-23  583  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  584  
bd756ddea18e02c Shun Fu    2012-09-23 @585  	iowrite32(0, regs->enpointa_mask_reg);
bd756ddea18e02c Shun Fu    2012-09-23 @586  	if (ioread32(regs->arm_to_pciea_msg1) != HANDSHAKE_DONESTATE)
f0c568a478f0353 Jianyun Li 2011-05-11  587  		return;
f0c568a478f0353 Jianyun Li 2011-05-11  588  
bd756ddea18e02c Shun Fu    2012-09-23 @589  	iowrite32(DRBL_SOFT_RESET, regs->pciea_to_arm_drbl_reg);
f0c568a478f0353 Jianyun Li 2011-05-11  590  }
f0c568a478f0353 Jianyun Li 2011-05-11  591  

:::::: The code at line 407 was first introduced by commit
:::::: bd756ddea18e02ccea8b29496b2fe3bd91af8eb7 [SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580

:::::: TO: Shun Fu <fushun@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
