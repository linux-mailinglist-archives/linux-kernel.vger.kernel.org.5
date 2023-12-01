Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A528014FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379649AbjLAVMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:12:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F7D54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701465126; x=1733001126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NajvDAoej6nYtsrD/P/03GV/eqbAHAjlAcsm+d8u8fI=;
  b=S3n4DLmgC2qMvp2m1iILJFOeyy/6EZctGMvdUuAz1b9hpHw637q8IcV9
   zYMrFGba3q+Ixyq17HOaP/Mg/dpQTi/erg/ZyvDkKkRk9vCYud0zS/csy
   6V3PnYAZcXBGZc7438zVwA5Gyz18i8XTw2BLS+8uiOxxgINt0+a+gyy5Q
   z46HjHDHrll2Mtp4Sdp2M2rjObQNfPBiqgg7cG8rb0LPHbi/ifPghqIkk
   /728boQ4ekj9reimFkxU1Fg9KGgGQbbq78nXgPSxMK+7kU/nfsazt4m2k
   TZKQzaxqYyflc+Ofd25xRIyYPTcG2tenqyPwoqbTHs/8e1oL3jcMfSiPy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="566167"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="566167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 13:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804192221"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="804192221"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2023 13:12:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9Ano-0004Ie-2B;
        Fri, 01 Dec 2023 21:12:00 +0000
Date:   Sat, 2 Dec 2023 05:11:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Carroll <David.Carroll@microsemi.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: drivers/scsi/aacraid/aachba.c:4000:51: sparse: sparse: cast
 truncates bits from constant value (1000000 becomes 0)
Message-ID: <202312020508.bVNi56GG-lkp@intel.com>
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
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: ab5d129f93c91fff74100bcd898d605da461f4a6 scsi: aacraid: Add task management functionality
date:   7 years ago
config: powerpc-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231202/202312020508.bVNi56GG-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020508.bVNi56GG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020508.bVNi56GG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/aacraid/aachba.c:3849:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addrHigh @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3849:47: sparse:     expected unsigned int [usertype] addrHigh
   drivers/scsi/aacraid/aachba.c:3849:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3850:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addrLow @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3850:46: sparse:     expected unsigned int [usertype] addrLow
   drivers/scsi/aacraid/aachba.c:3850:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3851:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_size @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3851:34: sparse:     expected unsigned int [usertype] cur_size
   drivers/scsi/aacraid/aachba.c:3851:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3856:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] sgeFirstSize @@     got unsigned int [usertype] cur_size @@
   drivers/scsi/aacraid/aachba.c:3856:52: sparse:     expected restricted __le32 [usertype] sgeFirstSize
   drivers/scsi/aacraid/aachba.c:3856:52: sparse:     got unsigned int [usertype] cur_size
   drivers/scsi/aacraid/aachba.c:3858:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] sgeNominalSize @@     got unsigned int [usertype] cur_size @@
   drivers/scsi/aacraid/aachba.c:3858:54: sparse:     expected restricted __le32 [usertype] sgeNominalSize
   drivers/scsi/aacraid/aachba.c:3858:54: sparse:     got unsigned int [usertype] cur_size
   drivers/scsi/aacraid/aachba.c:3860:68: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/aachba.c:3870:36: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/aachba.c:3872:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3872:47: sparse:     expected unsigned int [usertype] length
   drivers/scsi/aacraid/aachba.c:3872:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3876:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] sgeCnt @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3876:30: sparse:     expected unsigned char [usertype] sgeCnt
   drivers/scsi/aacraid/aachba.c:3876:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3974:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3974:30: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/aacraid/aachba.c:3974:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3975:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3975:30: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/aacraid/aachba.c:3975:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3976:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_size @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3976:26: sparse:     expected unsigned int [usertype] cur_size
   drivers/scsi/aacraid/aachba.c:3976:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3988:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/aachba.c:3990:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3990:26: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aacraid/aachba.c:3990:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3995:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] emb_data_desc_count @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3995:45: sparse:     expected unsigned char [usertype] emb_data_desc_count
   drivers/scsi/aacraid/aachba.c:3995:45: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3996:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3996:28: sparse:     expected unsigned int [usertype] flags
   drivers/scsi/aacraid/aachba.c:3996:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3999:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3999:38: sparse:     expected unsigned int [usertype] flags
   drivers/scsi/aacraid/aachba.c:3999:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:4000:48: sparse: sparse: cast from restricted __le32
   drivers/scsi/aacraid/aachba.c:4001:43: sparse: sparse: cast from restricted __le32
   drivers/scsi/aacraid/aachba.c:4002:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:4002:40: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/aacraid/aachba.c:4002:40: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3938:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] sgeCnt @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:3938:22: sparse:     expected unsigned char [usertype] sgeCnt
   drivers/scsi/aacraid/aachba.c:3938:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:3940:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] sgeNominalSize @@     got unsigned long @@
   drivers/scsi/aacraid/aachba.c:3940:30: sparse:     expected restricted __le32 [usertype] sgeNominalSize
   drivers/scsi/aacraid/aachba.c:3940:30: sparse:     got unsigned long
   drivers/scsi/aacraid/aachba.c:243:5: sparse: sparse: symbol 'aac_convert_sgl' was not declared. Should it be static?
   drivers/scsi/aacraid/aachba.c:287:5: sparse: sparse: symbol 'acbsize' was not declared. Should it be static?
   drivers/scsi/aacraid/aachba.c:318:5: sparse: sparse: symbol 'aac_wwn' was not declared. Should it be static?
   drivers/scsi/aacraid/aachba.c:632:76: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] block_size @@     got int @@
   drivers/scsi/aacraid/aachba.c:632:76: sparse:     expected restricted __le32 [usertype] block_size
   drivers/scsi/aacraid/aachba.c:632:76: sparse:     got int
   drivers/scsi/aacraid/aachba.c:988:63: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/aachba.c:1009:71: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] Serial @@     got restricted __le32 [usertype] uid @@
   drivers/scsi/aacraid/aachba.c:1009:71: sparse:     expected unsigned int [addressable] [assigned] [usertype] Serial
   drivers/scsi/aacraid/aachba.c:1009:71: sparse:     got restricted __le32 [usertype] uid
   drivers/scsi/aacraid/aachba.c:1176:27: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/aachba.c:1307:27: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/aachba.c:1478:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char @@     got restricted __le32 [usertype] @@
   drivers/scsi/aacraid/aachba.c:1478:24: sparse:     expected unsigned char
   drivers/scsi/aacraid/aachba.c:1478:24: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aacraid/aachba.c:1585:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/aachba.c:1706:61: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rmw_nexus @@     got unsigned int [assigned] [usertype] nexus @@
   drivers/scsi/aacraid/aachba.c:1706:61: sparse:     expected restricted __le32 [usertype] rmw_nexus
   drivers/scsi/aacraid/aachba.c:1706:61: sparse:     got unsigned int [assigned] [usertype] nexus
   drivers/scsi/aacraid/aachba.c:1672:6: sparse: sparse: symbol 'aac_update_hba_map' was not declared. Should it be static?
   drivers/scsi/aacraid/aachba.c:1836:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] VirtDeviceBus @@     got int @@
   drivers/scsi/aacraid/aachba.c:1836:52: sparse:     expected restricted __le16 [usertype] VirtDeviceBus
   drivers/scsi/aacraid/aachba.c:1836:52: sparse:     got int
   drivers/scsi/aacraid/aachba.c:1904:53: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/aacraid/aachba.c:3507:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rmw_nexus @@     got unsigned int @@
   drivers/scsi/aacraid/aachba.c:3507:58: sparse:     expected restricted __le32 [usertype] rmw_nexus
   drivers/scsi/aacraid/aachba.c:3507:58: sparse:     got unsigned int
>> drivers/scsi/aacraid/aachba.c:4000:51: sparse: sparse: cast truncates bits from constant value (1000000 becomes 0)
   drivers/scsi/aacraid/aachba.c: In function 'aac_probe_container':
   drivers/scsi/aacraid/aachba.c:796:30: warning: cast between incompatible function types from 'int (*)(struct scsi_cmnd *)' to 'void (*)(struct scsi_cmnd *)' [-Wcast-function-type]
     796 |         scsicmd->scsi_done = (void (*)(struct scsi_cmnd*))aac_probe_container_callback1;
         |                              ^
   drivers/scsi/aacraid/aachba.c: At top level:
   drivers/scsi/aacraid/aachba.c:1672:6: warning: no previous prototype for 'aac_update_hba_map' [-Wmissing-prototypes]
    1672 | void aac_update_hba_map(struct aac_dev *dev,
         |      ^~~~~~~~~~~~~~~~~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_report_phys_luns':
   drivers/scsi/aacraid/aachba.c:1791:19: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
    1791 |         if (rcode >= 0 && phys_luns->resp_flag == 2) {
         |                   ^~
   drivers/scsi/aacraid/aachba.c: In function 'aac_srb_callback':
   drivers/scsi/aacraid/aachba.c:3250:25: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
    3250 |         struct aac_dev *dev;
         |                         ^~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_build_sg':
   drivers/scsi/aacraid/aachba.c:3694:25: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
    3694 |         struct aac_dev *dev;
         |                         ^~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_build_sg64':
   drivers/scsi/aacraid/aachba.c:3737:25: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
    3737 |         struct aac_dev *dev;
         |                         ^~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_scsi_cmd':
   drivers/scsi/aacraid/aachba.c:2667:63: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2666 |                                         if (!(dev->raw_io_interface) ||
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2667 |                                             !(dev->raw_io_64) ||
         |                                             ~~~~~~~~~~~~~~~~~~^~
    2668 |                                             ((scsicmd->cmnd[1] & 0x1f) != SAI_READ_CAPACITY_16))
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/aacraid/aachba.c:2670:33: note: here
    2670 |                                 case INQUIRY:
         |                                 ^~~~
   drivers/scsi/aacraid/aachba.c:2749:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2749 |                 if ((aac_cache & 6) != 2)
         |                    ^
   drivers/scsi/aacraid/aachba.c:2751:9: note: here
    2751 |         case INQUIRY:
         |         ^~~~
   drivers/scsi/aacraid/aachba.c:3080:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    3080 |                 if (fsa_dev_ptr[cid].sense_data.sense_key == NOT_READY) {
         |                    ^
   drivers/scsi/aacraid/aachba.c:3093:9: note: here
    3093 |         case RESERVE:
         |         ^~~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_convert_sgraw2.isra':
   drivers/scsi/aacraid/aachba.c:3923:42: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds=]
    3923 |                 for (j = 0; j < rio2->sge[i].length / (pages * PAGE_SIZE); ++j) {
         |                                 ~~~~~~~~~^~~
   In file included from drivers/scsi/aacraid/aachba.c:44:
   drivers/scsi/aacraid/aacraid.h:1845:33: note: while referencing 'sge'
    1845 |         struct sge_ieee1212     sge[1];
         |                                 ^~~
   drivers/scsi/aacraid/aachba.c:3924:45: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds=]
    3924 |                         addr_low = rio2->sge[i].addrLow + j * pages * PAGE_SIZE;
         |                                    ~~~~~~~~~^~~
   drivers/scsi/aacraid/aacraid.h:1845:33: note: while referencing 'sge'
    1845 |         struct sge_ieee1212     sge[1];
         |                                 ^~~
   drivers/scsi/aacraid/aachba.c:3926:54: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds=]
    3926 |                         sge[pos].addrHigh = rio2->sge[i].addrHigh;
         |                                             ~~~~~~~~~^~~
   drivers/scsi/aacraid/aacraid.h:1845:33: note: while referencing 'sge'
    1845 |         struct sge_ieee1212     sge[1];
         |                                 ^~~
   drivers/scsi/aacraid/aachba.c:3927:49: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds=]
    3927 |                         if (addr_low < rio2->sge[i].addrLow)
         |                                        ~~~~~~~~~^~~
   drivers/scsi/aacraid/aacraid.h:1845:33: note: while referencing 'sge'
    1845 |         struct sge_ieee1212     sge[1];
         |                                 ^~~
   drivers/scsi/aacraid/aachba.c: In function 'aac_build_sgraw2':
   drivers/scsi/aacraid/aachba.c:3885:54: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds=]
    3885 |                                         if (rio2->sge[j].length % (i*PAGE_SIZE)) {
         |                                             ~~~~~~~~~^~~
   drivers/scsi/aacraid/aacraid.h:1845:33: note: while referencing 'sge'
    1845 |         struct sge_ieee1212     sge[1];
         |                                 ^~~

vim +4000 drivers/scsi/aacraid/aachba.c

  3943	
  3944	static long aac_build_sghba(struct scsi_cmnd *scsicmd,
  3945				struct aac_hba_cmd_req *hbacmd,
  3946				int sg_max,
  3947				u64 sg_address)
  3948	{
  3949		unsigned long byte_count = 0;
  3950		int nseg;
  3951		struct scatterlist *sg;
  3952		int i;
  3953		u32 cur_size;
  3954		struct aac_hba_sgl *sge;
  3955	
  3956	
  3957	
  3958		nseg = scsi_dma_map(scsicmd);
  3959		if (nseg <= 0) {
  3960			byte_count = nseg;
  3961			goto out;
  3962		}
  3963	
  3964		if (nseg > HBA_MAX_SG_EMBEDDED)
  3965			sge = &hbacmd->sge[2];
  3966		else
  3967			sge = &hbacmd->sge[0];
  3968	
  3969		scsi_for_each_sg(scsicmd, sg, nseg, i) {
  3970			int count = sg_dma_len(sg);
  3971			u64 addr = sg_dma_address(sg);
  3972	
  3973			WARN_ON(i >= sg_max);
  3974			sge->addr_hi = cpu_to_le32((u32)(addr>>32));
  3975			sge->addr_lo = cpu_to_le32((u32)(addr & 0xffffffff));
  3976			cur_size = cpu_to_le32(count);
  3977			sge->len = cur_size;
  3978			sge->flags = 0;
  3979			byte_count += count;
  3980			sge++;
  3981		}
  3982	
  3983		sge--;
  3984		/* hba wants the size to be exact */
  3985		if (byte_count > scsi_bufflen(scsicmd)) {
  3986			u32 temp;
  3987	
  3988			temp = le32_to_cpu(sge->len) - byte_count
  3989							- scsi_bufflen(scsicmd);
  3990			sge->len = cpu_to_le32(temp);
  3991			byte_count = scsi_bufflen(scsicmd);
  3992		}
  3993	
  3994		if (nseg <= HBA_MAX_SG_EMBEDDED) {
  3995			hbacmd->emb_data_desc_count = cpu_to_le32(nseg);
  3996			sge->flags = cpu_to_le32(0x40000000);
  3997		} else {
  3998			/* not embedded */
  3999			hbacmd->sge[0].flags = cpu_to_le32(0x80000000);
> 4000			hbacmd->emb_data_desc_count = (u8)cpu_to_le32(1);
  4001			hbacmd->sge[0].addr_hi = (u32)cpu_to_le32(sg_address >> 32);
  4002			hbacmd->sge[0].addr_lo =
  4003				cpu_to_le32((u32)(sg_address & 0xffffffff));
  4004		}
  4005	
  4006		/* Check for command underflow */
  4007		if (scsicmd->underflow && (byte_count < scsicmd->underflow)) {
  4008			pr_warn("aacraid: cmd len %08lX cmd underflow %08X\n",
  4009					byte_count, scsicmd->underflow);
  4010		}
  4011	out:
  4012		return byte_count;
  4013	}
  4014	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
