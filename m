Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66167AA316
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjIUVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjIUVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403AD436E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695320694; x=1726856694;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fL+P7k6flZa4Y05ProscO2uT6EhCl0QkrIRmdJycMZ8=;
  b=SbPWz42mSV0uK2psFeHLywHAbEQ3QB2p6gge+MeVoLxYwaqMsxRTBrUJ
   nWD9Le/9YS0SjvLvELuypCT7rfyPPPSeMA0RH+CN8JzVQCJK211aZ78I1
   SwZ0mxh68KTs3gNUkDmCO/TxSuoJyBZpBNH9cUfT4VboqXc313fVBp2bx
   ew4OpJ/s/Z4Ey3369tu/VvVUx2cU9xiycQaOFHlZlLUbhwut4rLMAksq0
   ooXLKIapr1cDGvbHwfwecZo8VeU6LGZwjlhsvHq509aKuDeSK7moJxqR/
   8OQi+d6OVoWX2hZ4eRwk3uDG2gkStl82JCJD8lcj3Z6PEydVLmRc1LetE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377911915"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="377911915"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 11:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1078000751"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="1078000751"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2023 11:24:50 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjOM4-0000Ed-2U;
        Thu, 21 Sep 2023 18:24:48 +0000
Date:   Fri, 22 Sep 2023 02:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202309220231.kOEgrcCu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42dc814987c1feb6410904e58cfd4c36c4146150
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   2 years, 5 months ago
config: i386-randconfig-062-20230916 (https://download.01.org/0day-ci/archive/20230922/202309220231.kOEgrcCu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309220231.kOEgrcCu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309220231.kOEgrcCu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/usb/lan78xx.c:2963:29: sparse: sparse: cast to restricted __be16
>> drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short [usertype] @@
   drivers/net/usb/lan78xx.c:2963:27: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/usb/lan78xx.c:2963:27: sparse:     got unsigned short [usertype]
--
   drivers/scsi/bfa/bfa_svc.c:753:21: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/bfa/bfa_svc.c:760:48: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_svc.c:765:41: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_svc.c:770:33: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_svc.c:3175:33: sparse: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3178:9: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_svc.c:3179:9: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_svc.c:4485:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:4487:25: sparse: sparse: cast to restricted __be32
>> drivers/scsi/bfa/bfa_svc.c:680:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] rsp_len @@     got unsigned int [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:680:27: sparse:     expected restricted __be32 [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:680:27: sparse:     got unsigned int [usertype]
>> drivers/scsi/bfa/bfa_svc.c:689:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] residue_len @@     got unsigned int [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:689:39: sparse:     expected restricted __be32 [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:689:39: sparse:     got unsigned int [usertype]
   drivers/scsi/bfa/bfa_svc.c:701:71: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int [usertype] rsp_len @@     got restricted __be32 [usertype] rsp_len @@
   drivers/scsi/bfa/bfa_svc.c:701:71: sparse:     expected unsigned int [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:701:71: sparse:     got restricted __be32 [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:702:49: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [usertype] resid_len @@     got restricted __be32 [usertype] residue_len @@
   drivers/scsi/bfa/bfa_svc.c:702:49: sparse:     expected unsigned int [usertype] resid_len
   drivers/scsi/bfa/bfa_svc.c:702:49: sparse:     got restricted __be32 [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:709:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] rsp_len @@     got restricted __be32 [usertype] rsp_len @@
   drivers/scsi/bfa/bfa_svc.c:709:39: sparse:     expected unsigned int [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:709:39: sparse:     got restricted __be32 [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:710:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] residue_len @@     got restricted __be32 [usertype] residue_len @@
   drivers/scsi/bfa/bfa_svc.c:710:43: sparse:     expected unsigned int [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:710:43: sparse:     got restricted __be32 [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:3529:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] maxfrsize @@     got unsigned short [usertype] maxfrsize @@
   drivers/scsi/bfa/bfa_svc.c:3529:39: sparse:     expected restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3529:39: sparse:     got unsigned short [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3564:41: sparse: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3565:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] path_tov @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:3565:54: sparse:     expected unsigned short [usertype] path_tov
   drivers/scsi/bfa/bfa_svc.c:3565:54: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_svc.c:3567:53: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] q_depth @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:3567:53: sparse:     expected unsigned short [usertype] q_depth
   drivers/scsi/bfa/bfa_svc.c:3567:53: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_svc.c:3903:9: sparse: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3913:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] maxfrsize @@     got unsigned short [usertype] maxfrsize @@
   drivers/scsi/bfa/bfa_svc.c:3913:31: sparse:     expected restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3913:31: sparse:     got unsigned short [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3922:27: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] maxfrsize @@
   drivers/scsi/bfa/bfa_svc.c:3922:27: sparse:     expected unsigned short
   drivers/scsi/bfa/bfa_svc.c:3922:27: sparse:     got restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:5525:22: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5526:22: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6516:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum bfa_status status @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6516:21: sparse:     expected unsigned int enum bfa_status status
   drivers/scsi/bfa/bfa_svc.c:6516:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c:6567:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] roundtrip_latency @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6567:49: sparse:     expected unsigned int [usertype] roundtrip_latency
   drivers/scsi/bfa/bfa_svc.c:6567:49: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c:6569:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] est_cable_distance @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6569:50: sparse:     expected unsigned int [usertype] est_cable_distance
   drivers/scsi/bfa/bfa_svc.c:6569:50: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c:6572:25: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6574:39: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6601:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lpcnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6601:30: sparse:     expected unsigned int [usertype] lpcnt
   drivers/scsi/bfa/bfa_svc.c:6601:30: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c:5854:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:5855:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:5856:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:5857:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:5858:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6493:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lpcnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6493:26: sparse:     expected unsigned int [usertype] lpcnt
   drivers/scsi/bfa/bfa_svc.c:6493:26: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c:6494:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] payload @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_svc.c:6494:28: sparse:     expected unsigned int [usertype] payload
   drivers/scsi/bfa/bfa_svc.c:6494:28: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_svc.c: note: in included file (through drivers/scsi/bfa/bfa.h, drivers/scsi/bfa/bfa_modules.h, drivers/scsi/bfa/bfad_drv.h):
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
--
   drivers/scsi/bfa/bfa_ioc.c:1800:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:1800:28: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/scsi/bfa/bfa_ioc.c:1800:28: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:1802:29: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:1813:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:1813:29: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/scsi/bfa/bfa_ioc.c:1813:29: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:1815:30: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:1780:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:1780:24: sparse:     expected unsigned int val
   drivers/scsi/bfa/bfa_ioc.c:1780:24: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:1963:31: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:1964:31: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:1965:31: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:1967:27: sparse: sparse: cast to restricted __be16
>> drivers/scsi/bfa/bfa_ioc.c:2066:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] r32 @@     got unsigned int [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:2066:21: sparse:     expected restricted __be32 [usertype] r32
   drivers/scsi/bfa/bfa_ioc.c:2066:21: sparse:     got unsigned int [usertype]
   drivers/scsi/bfa/bfa_ioc.c:2067:26: sparse: sparse: cast from restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:2989:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:2989:22: sparse:     expected unsigned short [usertype] clscode
   drivers/scsi/bfa/bfa_ioc.c:2989:22: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:3265:52: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:3267:58: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:3269:59: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:3271:54: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:3273:54: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:3440:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] pers @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:3440:17: sparse:     expected unsigned short [usertype] pers
   drivers/scsi/bfa/bfa_ioc.c:3440:17: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:3441:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] bw_min @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:3441:19: sparse:     expected unsigned short [usertype] bw_min
   drivers/scsi/bfa/bfa_ioc.c:3441:19: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:3442:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] bw_max @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:3442:19: sparse:     expected unsigned short [usertype] bw_max
   drivers/scsi/bfa/bfa_ioc.c:3442:19: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:3565:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] bw_min @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:3565:19: sparse:     expected unsigned short [usertype] bw_min
   drivers/scsi/bfa/bfa_ioc.c:3565:19: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:3566:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] bw_max @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:3566:19: sparse:     expected unsigned short [usertype] bw_max
   drivers/scsi/bfa/bfa_ioc.c:3566:19: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:4268:21: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4270:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4273:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4301:21: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4303:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4306:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4325:21: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4364:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4372:40: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4373:39: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4378:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4380:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4382:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4384:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4386:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4388:41: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4395:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4401:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4412:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4418:35: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4435:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:4441:33: sparse: sparse: cast to restricted __be32
>> drivers/scsi/bfa/bfa_ioc.c:4829:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] count @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:4829:27: sparse:     expected unsigned int [usertype] count
   drivers/scsi/bfa/bfa_ioc.c:4829:27: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:4924:36: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:4933:33: sparse: sparse: cast to restricted __be16
>> drivers/scsi/bfa/bfa_ioc.c:4979:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] freq @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:4979:19: sparse:     expected unsigned short [usertype] freq
   drivers/scsi/bfa/bfa_ioc.c:4979:19: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/bfa/bfa_ioc.c:5006:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] period @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5006:21: sparse:     expected unsigned int [usertype] period
   drivers/scsi/bfa/bfa_ioc.c:5006:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:5301:27: sparse: sparse: cast to restricted __be32
>> drivers/scsi/bfa/bfa_ioc.c:5367:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5367:21: sparse:     expected unsigned int [usertype] offset
   drivers/scsi/bfa/bfa_ioc.c:5367:21: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/bfa/bfa_ioc.c:5370:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5370:21: sparse:     expected unsigned int [usertype] length
   drivers/scsi/bfa/bfa_ioc.c:5370:21: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/bfa/bfa_ioc.c:5383:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5383:24: sparse:     expected unsigned short [usertype]
   drivers/scsi/bfa/bfa_ioc.c:5383:24: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:5405:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5405:21: sparse:     expected unsigned int [usertype] offset
   drivers/scsi/bfa/bfa_ioc.c:5405:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:5408:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:5408:21: sparse:     expected unsigned int [usertype] length
   drivers/scsi/bfa/bfa_ioc.c:5408:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:5722:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:5740:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:5757:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:5771:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:5780:35: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:5789:42: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_ioc.c:6222:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:6222:21: sparse:     expected unsigned int [usertype] offset
   drivers/scsi/bfa/bfa_ioc.c:6222:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:6225:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:6225:21: sparse:     expected unsigned int [usertype] length
   drivers/scsi/bfa/bfa_ioc.c:6225:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:6256:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:6256:21: sparse:     expected unsigned int [usertype] offset
   drivers/scsi/bfa/bfa_ioc.c:6256:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:6259:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.c:6259:21: sparse:     expected unsigned int [usertype] length
   drivers/scsi/bfa/bfa_ioc.c:6259:21: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.c:6571:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:6591:26: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c:6600:35: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_ioc.c: note: in included file (through drivers/scsi/bfa/bfa.h, drivers/scsi/bfa/bfa_modules.h, drivers/scsi/bfa/bfad_drv.h):
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     expected unsigned int [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:190:22: sparse:     got restricted __be32 [usertype]

vim +2963 drivers/net/usb/lan78xx.c

55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2949  
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2950  static void lan78xx_rx_csum_offload(struct lan78xx_net *dev,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2951  				    struct sk_buff *skb,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2952  				    u32 rx_cmd_a, u32 rx_cmd_b)
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2953  {
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2954  	/* HW Checksum offload appears to be flawed if used when not stripping
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2955  	 * VLAN headers. Drop back to S/W checksums under these conditions.
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2956  	 */
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2957  	if (!(dev->net->features & NETIF_F_RXCSUM) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2958  	    unlikely(rx_cmd_a & RX_CMD_A_ICSM_) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2959  	    ((rx_cmd_a & RX_CMD_A_FVTG_) &&
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2960  	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2961  		skb->ip_summed = CHECKSUM_NONE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2962  	} else {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30 @2963  		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2964  		skb->ip_summed = CHECKSUM_COMPLETE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2965  	}
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2966  }
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2967  

:::::: The code at line 2963 was first introduced by commit
:::::: 55d7de9de6c30adce8d675c7ce513e283829c2ff Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver

:::::: TO: Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
