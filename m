Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973FB7A2FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjIPLWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjIPLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:21:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BD199
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694863295; x=1726399295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iJUoTarQuPdQ1OYBFpOd5J1cbMPNiY4X3NNi3nft7bg=;
  b=SI9b//ahaE1lpRvTDdbpFe+DzPcMDOGckfMT7kuCsT94HKb39zaf+1a/
   Xo45Ux57HBCtvyBVEB0NdY7oWTtkI6VDI3R+8FlamZpWdgT2PHbvwfERF
   52OCLmIhyw9r+6xwqR00cXt2UQBIRremTThHXxEy+cP83iL1emWpwT6Br
   z4FIxWWMSngy5v8z5hoEfcanxUrwnW3iQnDkLy7OXAaMJc30UTcfUkgbz
   M/v3W1erV1vICc8IZYq5j3uTEIVDxtlp6DTV3Fuv1AMYFnoaQHLRVhqw3
   PIWIgazaP80OJ31ndhB0BmmLcUikFYU2jRHe9yng31TJ2isaV0OZxbRo5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410361396"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="410361396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 04:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810824897"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="810824897"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2023 04:21:33 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhTMh-0004Ee-1c;
        Sat, 16 Sep 2023 11:21:31 +0000
Date:   Sat, 16 Sep 2023 19:21:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse: sparse: incorrect type
 in initializer (different base types)
Message-ID: <202309161958.cn3ZKYOD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57d88e8a5974644039fbc47806bac7bb12025636
commit: 2e5a6c3baccd31476ed00c3fbc413b48ddd87993 scsi: bfa: Convert bfad_reset_sdev_bflags() from a macro into a function
date:   10 months ago
config: i386-randconfig-062-20230916 (https://download.01.org/0day-ci/archive/20230916/202309161958.cn3ZKYOD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309161958.cn3ZKYOD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309161958.cn3ZKYOD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/bfa/bfad_bsg.c:2391:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfad_bsg.c:2414:38: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfad_bsg.c:2415:38: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfad_bsg.c:2417:33: sparse: sparse: cast to restricted __be32
>> drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int const [usertype] scan_flags @@     got restricted blist_flags_t @@
   drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse:     expected unsigned int const [usertype] scan_flags
   drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse:     got restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse: sparse: invalid assignment: |=
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse:    left side has type restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse:    right side has type unsigned int
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse: sparse: invalid assignment: &=
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse:    left side has type restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse:    right side has type unsigned int
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse:     expected void const [noderef] __user *from
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse:     got void *
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse:     expected void [noderef] __user *to
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse:     got void *

vim +2553 drivers/scsi/bfa/bfad_bsg.c

  2542	
  2543	/*
  2544	 * Set the SCSI device sdev_bflags - sdev_bflags are used by the
  2545	 * SCSI mid-layer to choose LUN Scanning mode REPORT_LUNS vs. Sequential Scan
  2546	 *
  2547	 * Internally iterates over all the ITNIM's part of the im_port & sets the
  2548	 * sdev_bflags for the scsi_device associated with LUN #0.
  2549	 */
  2550	static void bfad_reset_sdev_bflags(struct bfad_im_port_s *im_port,
  2551					   int lunmask_cfg)
  2552	{
> 2553		const u32 scan_flags = BLIST_NOREPORTLUN | BLIST_SPARSELUN;
  2554		struct bfad_itnim_s *itnim;
  2555		struct scsi_device *sdev;
  2556	
  2557		list_for_each_entry(itnim, &im_port->itnim_mapped_list, list_entry) {
  2558			sdev = scsi_device_lookup(im_port->shost, itnim->channel,
  2559						  itnim->scsi_tgt_id, 0);
  2560			if (sdev) {
  2561				if (lunmask_cfg == BFA_TRUE)
  2562					sdev->sdev_bflags |= scan_flags;
  2563				else
  2564					sdev->sdev_bflags &= ~scan_flags;
  2565				scsi_device_put(sdev);
  2566			}
  2567		}
  2568	}
  2569	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
