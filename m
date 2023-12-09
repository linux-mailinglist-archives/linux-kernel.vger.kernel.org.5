Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9526F80B5AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjLIRkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLIRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:40:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5BA1706
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702143604; x=1733679604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HoFX/ohkmRkbuT4jjzXQ1KjXIAXiBi9dJf8gOQcMr/k=;
  b=cH50JHQf2ao2msKDc7RUjfjuXljBuvMIBjK8A5h1oPVT/ztQc2LZl6KU
   Ay56t2VDUqUzYYSn24RlfAFcePhMy0ARYtHlIiDsULhshNqpjbyLir/2K
   9NUuUv6wp3t7+jvBbSUFwTLUnUo2u6k6drs72G2lFuW82lNrfEuBgRMrH
   MrFZdJ+tthAL0UlOYv8XjCm2gJHxvyJTzbpib97zFi6d6VDr878pGjvhw
   RpVpnDishxPPhjTM6bMuHPOrQ7ZnXB5gEaIfmIDqNosO1wUB60ePmnXmB
   fM3RpQASuDdxg2ZgttFOJ59D6Dl3h4WQD6UrTfwiYAXMGpyUDyE20JACK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1621710"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1621710"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 09:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="20459848"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 09 Dec 2023 09:40:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC1J1-000Fgv-0u;
        Sat, 09 Dec 2023 17:39:59 +0000
Date:   Sun, 10 Dec 2023 01:39:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shai Malin <smalin@marvell.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manish Rangankar <mrangankar@marvell.com>
Subject: drivers/scsi/qedi/qedi_fw.c:932:40: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202312100102.CwhXG2Il-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 9757f8af04423f60b6ecbd6802ff4e3f618fbb44 scsi: qedi: Add support for fastpath doorbell recovery
date:   2 years, 4 months ago
config: x86_64-randconfig-123-20231025 (https://download.01.org/0day-ci/archive/20231210/202312100102.CwhXG2Il-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100102.CwhXG2Il-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100102.CwhXG2Il-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/qedi/qedi_fw.c:52:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:53:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:55:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] t2wait @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse:     expected restricted __be16 [usertype] t2wait
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:56:30: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] t2retain @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse:     expected restricted __be16 [usertype] t2retain
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:105:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:105:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:105:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:109:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:111:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ttt @@     got restricted __le32 [usertype] ttt @@
   drivers/scsi/qedi/qedi_fw.c:111:27: sparse:     expected restricted __be32 [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:111:27: sparse:     got restricted __le32 [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:112:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:113:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:114:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:116:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:211:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:211:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:211:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:214:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:216:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:217:36: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:218:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:285:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:287:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] tsih @@     got restricted __le16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:287:28: sparse:     expected restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:287:28: sparse:     got restricted __le16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:288:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:289:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:290:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:293:37: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:331:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:331:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:331:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:366:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:366:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:366:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:384:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] opaque @@     got restricted __le32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:384:41: sparse:     expected restricted __le16 [usertype] opaque
   drivers/scsi/qedi/qedi_fw.c:384:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:427:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:434:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:435:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:436:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:437:20: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:453:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:497:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:513:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:513:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:513:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:513:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:514:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:514:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:514:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:514:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:516:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:517:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:518:28: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:523:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:524:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:525:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:548:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:563:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:563:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:563:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:565:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:566:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:567:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:590:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:590:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:590:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:623:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:624:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:625:20: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:629:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:632:38: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:734:28: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] proto_itt @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:734:28: sparse:     expected unsigned int [usertype] proto_itt
   drivers/scsi/qedi/qedi_fw.c:734:28: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:744:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:744:19: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:744:19: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:795:9: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:857:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:857:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:857:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:888:50: sparse: sparse: cast from restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:888:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:893:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:892:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] itid @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:892:49: sparse:     expected restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:892:49: sparse:     got unsigned int
>> drivers/scsi/qedi/qedi_fw.c:932:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] sq_prod @@     got unsigned short [usertype] fw_sq_prod_idx @@
   drivers/scsi/qedi/qedi_fw.c:932:40: sparse:     expected restricted __le16 [usertype] sq_prod
   drivers/scsi/qedi/qedi_fw.c:932:40: sparse:     got unsigned short [usertype] fw_sq_prod_idx
   drivers/scsi/qedi/qedi_fw.c:1008:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:1008:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc
   drivers/scsi/qedi/qedi_fw.c:1008:40: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:1009:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] isid_d @@     got unsigned short @@
   drivers/scsi/qedi/qedi_fw.c:1009:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] isid_d
   drivers/scsi/qedi/qedi_fw.c:1009:37: sparse:     got unsigned short
   drivers/scsi/qedi/qedi_fw.c:1011:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tsih @@     got restricted __be16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:1011:35: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1011:35: sparse:     got restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1012:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1012:47: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1012:47: sparse:     got int
   drivers/scsi/qedi/qedi_fw.c:1015:36: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1015:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1015:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1015:34: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1016:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] cid @@     got unsigned int [usertype] iscsi_conn_id @@
   drivers/scsi/qedi/qedi_fw.c:1016:34: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] cid
   drivers/scsi/qedi/qedi_fw.c:1016:34: sparse:     got unsigned int [usertype] iscsi_conn_id
   drivers/scsi/qedi/qedi_fw.c:1017:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1017:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1017:37: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1018:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1018:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1018:42: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1024:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1024:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1024:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1026:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1026:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hi
   drivers/scsi/qedi/qedi_fw.c:1026:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1033:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1033:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1033:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1035:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1035:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hi
   drivers/scsi/qedi/qedi_fw.c:1035:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1037:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size @@     got restricted __le32 [usertype] sge_len @@
   drivers/scsi/qedi/qedi_fw.c:1037:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size
   drivers/scsi/qedi/qedi_fw.c:1037:46: sparse:     got restricted __le32 [usertype] sge_len
   drivers/scsi/qedi/qedi_fw.c:1046:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] rx_io_size @@     got restricted __le32 [usertype] sge_len @@
   drivers/scsi/qedi/qedi_fw.c:1046:32: sparse:     expected unsigned int [addressable] [assigned] [usertype] rx_io_size
   drivers/scsi/qedi/qedi_fw.c:1046:32: sparse:     got restricted __le32 [usertype] sge_len
   drivers/scsi/qedi/qedi_fw.c:1109:33: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1109:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1109:31: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1109:31: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1110:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1110:39: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1110:39: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1111:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1111:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1111:34: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1112:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] cid @@     got unsigned int [usertype] iscsi_conn_id @@
   drivers/scsi/qedi/qedi_fw.c:1112:31: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] cid
   drivers/scsi/qedi/qedi_fw.c:1112:31: sparse:     got unsigned int [usertype] iscsi_conn_id
   drivers/scsi/qedi/qedi_fw.c:1186:33: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1359:9: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1589:39: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1589:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1589:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1589:37: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1590:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] ttt @@     got restricted __be32 [usertype] ttt @@
   drivers/scsi/qedi/qedi_fw.c:1590:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:1590:37: sparse:     got restricted __be32 [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:1591:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1591:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1591:40: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1592:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1592:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1592:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1593:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1593:50: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1593:50: sparse:     got int
   drivers/scsi/qedi/qedi_fw.c:1598:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1598:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1598:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1600:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1600:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hi
   drivers/scsi/qedi/qedi_fw.c:1600:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1602:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size @@     got restricted __le32 [usertype] sge_len @@
   drivers/scsi/qedi/qedi_fw.c:1602:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size
   drivers/scsi/qedi/qedi_fw.c:1602:46: sparse:     got restricted __le32 [usertype] sge_len
   drivers/scsi/qedi/qedi_fw.c:1607:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1607:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1607:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1609:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1609:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hi
   drivers/scsi/qedi/qedi_fw.c:1609:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1611:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size @@     got restricted __le32 [usertype] sge_len @@
   drivers/scsi/qedi/qedi_fw.c:1611:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] total_buffer_size
   drivers/scsi/qedi/qedi_fw.c:1611:46: sparse:     got restricted __le32 [usertype] sge_len
   drivers/scsi/qedi/qedi_fw.c:1620:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] rx_io_size @@     got restricted __le32 [usertype] sge_len @@
   drivers/scsi/qedi/qedi_fw.c:1620:32: sparse:     expected unsigned int [addressable] [assigned] [usertype] rx_io_size
   drivers/scsi/qedi/qedi_fw.c:1620:32: sparse:     got restricted __le32 [usertype] sge_len
   drivers/scsi/qedi/qedi_fw.c:1689:37: sparse: sparse: cast to restricted __be32
   drivers/scsi/qedi/qedi_fw.c:1689:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1689:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo

vim +932 drivers/scsi/qedi/qedi_fw.c

   929	
   930	static void qedi_ring_doorbell(struct qedi_conn *qedi_conn)
   931	{
 > 932		qedi_conn->ep->db_data.sq_prod = qedi_conn->ep->fw_sq_prod_idx;
   933	
   934		/* wmb - Make sure fw idx is coherent */
   935		wmb();
   936		writel(*(u32 *)&qedi_conn->ep->db_data, qedi_conn->ep->p_doorbell);
   937	
   938		/* Make sure fw write idx is coherent, and include both memory barriers
   939		 * as a failsafe as for some architectures the call is the same but on
   940		 * others they are two different assembly operations.
   941		 */
   942		wmb();
   943		QEDI_INFO(&qedi_conn->qedi->dbg_ctx, QEDI_LOG_MP_REQ,
   944			  "prod_idx=0x%x, fw_prod_idx=0x%x, cid=0x%x\n",
   945			  qedi_conn->ep->sq_prod_idx, qedi_conn->ep->fw_sq_prod_idx,
   946			  qedi_conn->iscsi_conn_id);
   947	}
   948	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
