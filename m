Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8470E7C9BE5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjJOVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:23:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC6EA1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697404992; x=1728940992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VGBrghuAbJWEZ6I+7hMQvb2K7LItDBGRQq5uhfYN1IQ=;
  b=hciJvJF3dL6ZqyXHef2/MiZ6IWSe7alf9aB0DaRi1GCnD7jnMffIF4VV
   jl9B+arnGuVNl3LqesRfif81Tdq7BDIxaq58rPJoPBYsFkdgDLfADWvKu
   qk9Wl6d8cnduZ2vnbB+h2VvRBsIH2SKKHma/t2OxI+SgGjaLJKFrIEMYK
   vaRKqvsWz+hlAPHXoLF6ekvAB3wO/V6l8NxYqc7mQHzTvyFSwHfHgdTLz
   2RkI45bT4Cnm87qhHHFkPv1+jlbVElLF24tzvV5W9XukMNLNtu9+QrpjP
   b/ra3lPSWwvUmbY29Vb21eXkEKjMSHOBn4MFN/fkmOaGHCCww0MRJ5AlW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449623322"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="449623322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 14:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="821347497"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="821347497"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2023 14:23:09 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qs8Zn-0007pP-0F;
        Sun, 15 Oct 2023 21:23:07 +0000
Date:   Mon, 16 Oct 2023 05:22:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202310160545.Ki0maVw0-lkp@intel.com>
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
head:   fbe1bf1e5ff1e3b298420d7a8434983ef8d72bd1
commit: 045c58c87560b2f9e44fe84e62ce68625a937fa7 scsi: lpfc: Rework FDMI attribute registration for unintential padding
date:   1 year, 1 month ago
config: i386-randconfig-062-20231016 (https://download.01.org/0day-ci/archive/20231016/202310160545.Ki0maVw0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310160545.Ki0maVw0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310160545.Ki0maVw0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/lpfc/lpfc_ct.c:3581:15: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:3590:20: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3624:42: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:198:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:199:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:202:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:510:32: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:511:32: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:531:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:532:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:534:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:880:33: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:882:40: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1032:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1047:28: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1251:21: sparse: sparse: restricted __be16 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:1266:28: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1369:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1395:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1518:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1534:30: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1535:30: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:1623:19: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1685:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1706:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1727:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1748:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1781:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:1951:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1952:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1976:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] port_id @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     expected unsigned int [usertype] port_id
   drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortId @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     expected unsigned int [usertype] PortId
   drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2280:16: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_ct.c:2281:25: sparse: sparse: restricted __be16 degrades to integer
   drivers/scsi/lpfc/lpfc_ct.c:3113:5: sparse: sparse: symbol 'lpfc_fdmi_hba_action' was not declared. Should it be static?
   drivers/scsi/lpfc/lpfc_ct.c:3137:5: sparse: sparse: symbol 'lpfc_fdmi_port_action' was not declared. Should it be static?
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] EntryCnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     expected unsigned int [usertype] EntryCnt
   drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Size:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     expected unsigned int [usertype] Size:16
   drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3532:34: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CmdRsp:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     expected unsigned int [usertype] CmdRsp:16
   drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] no_of_objects @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     expected unsigned int [usertype] no_of_objects
   drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] no_of_objects @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     expected unsigned int [usertype] no_of_objects
   drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PortID @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     expected unsigned int [usertype] PortID
   drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Size:16 @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     expected unsigned int [usertype] Size:16
   drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     got restricted __be16 [usertype]

vim +3258 drivers/scsi/lpfc/lpfc_ct.c

4258e98ee3862c James Smart         2015-12-16  3165  
4258e98ee3862c James Smart         2015-12-16  3166  /**
4258e98ee3862c James Smart         2015-12-16  3167   * lpfc_fdmi_cmd - Build and send a FDMI cmd to the specified NPort
4258e98ee3862c James Smart         2015-12-16  3168   * @vport: pointer to a host virtual N_Port data structure.
4258e98ee3862c James Smart         2015-12-16  3169   * @ndlp: ndlp to send FDMI cmd to (if NULL use FDMI_DID)
6265bc4a41cd86 Lee Jones           2020-07-21  3170   * @cmdcode: FDMI command to send
6265bc4a41cd86 Lee Jones           2020-07-21  3171   * @new_mask: Mask of HBA or PORT Attributes to send
4258e98ee3862c James Smart         2015-12-16  3172   *
4258e98ee3862c James Smart         2015-12-16  3173   * Builds and sends a FDMI command using the CT subsystem.
4258e98ee3862c James Smart         2015-12-16  3174   */
4258e98ee3862c James Smart         2015-12-16  3175  int
4258e98ee3862c James Smart         2015-12-16  3176  lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
4258e98ee3862c James Smart         2015-12-16  3177  	      int cmdcode, uint32_t new_mask)
4258e98ee3862c James Smart         2015-12-16  3178  {
4258e98ee3862c James Smart         2015-12-16  3179  	struct lpfc_hba *phba = vport->phba;
d8cdd33a66dc8c James Smart         2022-09-11  3180  	struct lpfc_dmabuf *rq, *rsp;
4258e98ee3862c James Smart         2015-12-16  3181  	struct lpfc_sli_ct_request *CtReq;
d8cdd33a66dc8c James Smart         2022-09-11  3182  	struct ulp_bde64_le *bde;
4258e98ee3862c James Smart         2015-12-16  3183  	uint32_t bit_pos;
045c58c87560b2 James Smart         2022-09-11  3184  	uint32_t size, addsz;
4258e98ee3862c James Smart         2015-12-16  3185  	uint32_t rsp_size;
4258e98ee3862c James Smart         2015-12-16  3186  	uint32_t mask;
4258e98ee3862c James Smart         2015-12-16  3187  	struct lpfc_fdmi_reg_hba *rh;
4258e98ee3862c James Smart         2015-12-16  3188  	struct lpfc_fdmi_port_entry *pe;
2649809cd1b432 James Smart         2022-09-11  3189  	struct lpfc_fdmi_reg_portattr *pab = NULL, *base = NULL;
4258e98ee3862c James Smart         2015-12-16  3190  	struct lpfc_fdmi_attr_block *ab = NULL;
045c58c87560b2 James Smart         2022-09-11  3191  	int  (*func)(struct lpfc_vport *vport, void *attrbuf);
045c58c87560b2 James Smart         2022-09-11  3192  	void (*cmpl)(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
045c58c87560b2 James Smart         2022-09-11  3193  		     struct lpfc_iocbq *rspiocb);
4258e98ee3862c James Smart         2015-12-16  3194  
307e338097dc32 James Smart         2020-11-15  3195  	if (!ndlp)
4258e98ee3862c James Smart         2015-12-16  3196  		return 0;
4258e98ee3862c James Smart         2015-12-16  3197  
4258e98ee3862c James Smart         2015-12-16  3198  	cmpl = lpfc_cmpl_ct_disc_fdmi; /* called from discovery */
4258e98ee3862c James Smart         2015-12-16  3199  
4258e98ee3862c James Smart         2015-12-16  3200  	/* fill in BDEs for command */
4258e98ee3862c James Smart         2015-12-16  3201  	/* Allocate buffer for command payload */
d8cdd33a66dc8c James Smart         2022-09-11  3202  	rq = kmalloc(sizeof(*rq), GFP_KERNEL);
d8cdd33a66dc8c James Smart         2022-09-11  3203  	if (!rq)
4258e98ee3862c James Smart         2015-12-16  3204  		goto fdmi_cmd_exit;
4258e98ee3862c James Smart         2015-12-16  3205  
d8cdd33a66dc8c James Smart         2022-09-11  3206  	rq->virt = lpfc_mbuf_alloc(phba, 0, &rq->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3207  	if (!rq->virt)
d8cdd33a66dc8c James Smart         2022-09-11  3208  		goto fdmi_cmd_free_rq;
4258e98ee3862c James Smart         2015-12-16  3209  
4258e98ee3862c James Smart         2015-12-16  3210  	/* Allocate buffer for Buffer ptr list */
d8cdd33a66dc8c James Smart         2022-09-11  3211  	rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
d8cdd33a66dc8c James Smart         2022-09-11  3212  	if (!rsp)
d8cdd33a66dc8c James Smart         2022-09-11  3213  		goto fdmi_cmd_free_rqvirt;
4258e98ee3862c James Smart         2015-12-16  3214  
d8cdd33a66dc8c James Smart         2022-09-11  3215  	rsp->virt = lpfc_mbuf_alloc(phba, 0, &rsp->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3216  	if (!rsp->virt)
d8cdd33a66dc8c James Smart         2022-09-11  3217  		goto fdmi_cmd_free_rsp;
4258e98ee3862c James Smart         2015-12-16  3218  
d8cdd33a66dc8c James Smart         2022-09-11  3219  	INIT_LIST_HEAD(&rq->list);
d8cdd33a66dc8c James Smart         2022-09-11  3220  	INIT_LIST_HEAD(&rsp->list);
4258e98ee3862c James Smart         2015-12-16  3221  
2649809cd1b432 James Smart         2022-09-11  3222  	/* mbuf buffers are 1K in length - aka LPFC_BPL_SIZE */
2649809cd1b432 James Smart         2022-09-11  3223  	memset(rq->virt, 0, LPFC_BPL_SIZE);
2649809cd1b432 James Smart         2022-09-11  3224  	rsp_size = LPFC_BPL_SIZE;
2649809cd1b432 James Smart         2022-09-11  3225  
4258e98ee3862c James Smart         2015-12-16  3226  	/* FDMI request */
4258e98ee3862c James Smart         2015-12-16  3227  	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
de3ec318fee323 James Smart         2022-05-05  3228  			 "0218 FDMI Request x%x mask x%x Data: x%x x%x x%x\n",
de3ec318fee323 James Smart         2022-05-05  3229  			 cmdcode, new_mask, vport->fdmi_port_mask,
de3ec318fee323 James Smart         2022-05-05  3230  			 vport->fc_flag, vport->port_state);
de3ec318fee323 James Smart         2022-05-05  3231  
d8cdd33a66dc8c James Smart         2022-09-11  3232  	CtReq = (struct lpfc_sli_ct_request *)rq->virt;
4258e98ee3862c James Smart         2015-12-16  3233  
4258e98ee3862c James Smart         2015-12-16  3234  	/* First populate the CT_IU preamble */
4258e98ee3862c James Smart         2015-12-16  3235  	CtReq->RevisionId.bits.Revision = SLI_CT_REVISION;
4258e98ee3862c James Smart         2015-12-16  3236  	CtReq->RevisionId.bits.InId = 0;
4258e98ee3862c James Smart         2015-12-16  3237  
4258e98ee3862c James Smart         2015-12-16  3238  	CtReq->FsType = SLI_CT_MANAGEMENT_SERVICE;
4258e98ee3862c James Smart         2015-12-16  3239  	CtReq->FsSubType = SLI_CT_FDMI_Subtypes;
4258e98ee3862c James Smart         2015-12-16  3240  
4258e98ee3862c James Smart         2015-12-16  3241  	CtReq->CommandResponse.bits.CmdRsp = cpu_to_be16(cmdcode);
2649809cd1b432 James Smart         2022-09-11  3242  
4258e98ee3862c James Smart         2015-12-16  3243  	size = 0;
4258e98ee3862c James Smart         2015-12-16  3244  
4258e98ee3862c James Smart         2015-12-16  3245  	/* Next fill in the specific FDMI cmd information */
4258e98ee3862c James Smart         2015-12-16  3246  	switch (cmdcode) {
4258e98ee3862c James Smart         2015-12-16  3247  	case SLI_MGMT_RHAT:
4258e98ee3862c James Smart         2015-12-16  3248  	case SLI_MGMT_RHBA:
2649809cd1b432 James Smart         2022-09-11  3249  		rh = (struct lpfc_fdmi_reg_hba *)&CtReq->un;
4258e98ee3862c James Smart         2015-12-16  3250  		/* HBA Identifier */
4258e98ee3862c James Smart         2015-12-16  3251  		memcpy(&rh->hi.PortName, &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3252  		       sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3253  		size += sizeof(struct lpfc_fdmi_hba_ident);
4258e98ee3862c James Smart         2015-12-16  3254  
4258e98ee3862c James Smart         2015-12-16  3255  		if (cmdcode == SLI_MGMT_RHBA) {
4258e98ee3862c James Smart         2015-12-16  3256  			/* Registered Port List */
4258e98ee3862c James Smart         2015-12-16  3257  			/* One entry (port) per adapter */
4258e98ee3862c James Smart         2015-12-16 @3258  			rh->rpl.EntryCnt = cpu_to_be32(1);
4cb9e1ddaa145b James Smart         2020-01-27  3259  			memcpy(&rh->rpl.pe.PortName,
4cb9e1ddaa145b James Smart         2020-01-27  3260  			       &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3261  			       sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3262  			size += sizeof(struct lpfc_fdmi_reg_port_list);
4258e98ee3862c James Smart         2015-12-16  3263  		}
2649809cd1b432 James Smart         2022-09-11  3264  
4258e98ee3862c James Smart         2015-12-16  3265  		ab = (struct lpfc_fdmi_attr_block *)((uint8_t *)rh + size);
4258e98ee3862c James Smart         2015-12-16  3266  		ab->EntryCnt = 0;
2649809cd1b432 James Smart         2022-09-11  3267  		size += FOURBYTES;	/* add length of EntryCnt field */
2649809cd1b432 James Smart         2022-09-11  3268  
4258e98ee3862c James Smart         2015-12-16  3269  		bit_pos = 0;
4258e98ee3862c James Smart         2015-12-16  3270  		if (new_mask)
4258e98ee3862c James Smart         2015-12-16  3271  			mask = new_mask;
4258e98ee3862c James Smart         2015-12-16  3272  		else
4258e98ee3862c James Smart         2015-12-16  3273  			mask = vport->fdmi_hba_mask;
4258e98ee3862c James Smart         2015-12-16  3274  
4258e98ee3862c James Smart         2015-12-16  3275  		/* Mask will dictate what attributes to build in the request */
4258e98ee3862c James Smart         2015-12-16  3276  		while (mask) {
4258e98ee3862c James Smart         2015-12-16  3277  			if (mask & 0x1) {
4258e98ee3862c James Smart         2015-12-16  3278  				func = lpfc_fdmi_hba_action[bit_pos];
045c58c87560b2 James Smart         2022-09-11  3279  				addsz = func(vport, ((uint8_t *)rh + size));
045c58c87560b2 James Smart         2022-09-11  3280  				if (addsz) {
4258e98ee3862c James Smart         2015-12-16  3281  					ab->EntryCnt++;
045c58c87560b2 James Smart         2022-09-11  3282  					size += addsz;
045c58c87560b2 James Smart         2022-09-11  3283  				}
2649809cd1b432 James Smart         2022-09-11  3284  				/* check if another attribute fits */
045c58c87560b2 James Smart         2022-09-11  3285  				if ((size + FDMI_MAX_ATTRLEN) >
4258e98ee3862c James Smart         2015-12-16  3286  				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
4258e98ee3862c James Smart         2015-12-16  3287  					goto hba_out;
4258e98ee3862c James Smart         2015-12-16  3288  			}
4258e98ee3862c James Smart         2015-12-16  3289  			mask = mask >> 1;
4258e98ee3862c James Smart         2015-12-16  3290  			bit_pos++;
4258e98ee3862c James Smart         2015-12-16  3291  		}
4258e98ee3862c James Smart         2015-12-16  3292  hba_out:
4258e98ee3862c James Smart         2015-12-16  3293  		ab->EntryCnt = cpu_to_be32(ab->EntryCnt);
4258e98ee3862c James Smart         2015-12-16  3294  		/* Total size */
2649809cd1b432 James Smart         2022-09-11  3295  		size += GID_REQUEST_SZ - 4;
4258e98ee3862c James Smart         2015-12-16  3296  		break;
4258e98ee3862c James Smart         2015-12-16  3297  
4258e98ee3862c James Smart         2015-12-16  3298  	case SLI_MGMT_RPRT:
de3ec318fee323 James Smart         2022-05-05  3299  		if (vport->port_type != LPFC_PHYSICAL_PORT) {
de3ec318fee323 James Smart         2022-05-05  3300  			ndlp = lpfc_findnode_did(phba->pport, FDMI_DID);
de3ec318fee323 James Smart         2022-05-05  3301  			if (!ndlp)
de3ec318fee323 James Smart         2022-05-05  3302  				return 0;
de3ec318fee323 James Smart         2022-05-05  3303  		}
de3ec318fee323 James Smart         2022-05-05  3304  		fallthrough;
4258e98ee3862c James Smart         2015-12-16  3305  	case SLI_MGMT_RPA:
2649809cd1b432 James Smart         2022-09-11  3306  		/* Store base ptr right after preamble */
2649809cd1b432 James Smart         2022-09-11  3307  		base = (struct lpfc_fdmi_reg_portattr *)&CtReq->un;
2649809cd1b432 James Smart         2022-09-11  3308  
4258e98ee3862c James Smart         2015-12-16  3309  		if (cmdcode == SLI_MGMT_RPRT) {
2649809cd1b432 James Smart         2022-09-11  3310  			rh = (struct lpfc_fdmi_reg_hba *)base;
4258e98ee3862c James Smart         2015-12-16  3311  			/* HBA Identifier */
4258e98ee3862c James Smart         2015-12-16  3312  			memcpy(&rh->hi.PortName,
4258e98ee3862c James Smart         2015-12-16  3313  			       &phba->pport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3314  			       sizeof(struct lpfc_name));
4258e98ee3862c James Smart         2015-12-16  3315  			pab = (struct lpfc_fdmi_reg_portattr *)
2649809cd1b432 James Smart         2022-09-11  3316  				((uint8_t *)base + sizeof(struct lpfc_name));
2649809cd1b432 James Smart         2022-09-11  3317  			size += sizeof(struct lpfc_name);
2649809cd1b432 James Smart         2022-09-11  3318  		} else {
2649809cd1b432 James Smart         2022-09-11  3319  			pab = base;
4258e98ee3862c James Smart         2015-12-16  3320  		}
4258e98ee3862c James Smart         2015-12-16  3321  
4258e98ee3862c James Smart         2015-12-16  3322  		memcpy((uint8_t *)&pab->PortName,
4258e98ee3862c James Smart         2015-12-16  3323  		       (uint8_t *)&vport->fc_sparam.portName,
4258e98ee3862c James Smart         2015-12-16  3324  		       sizeof(struct lpfc_name));
4258e98ee3862c James Smart         2015-12-16  3325  		pab->ab.EntryCnt = 0;
2649809cd1b432 James Smart         2022-09-11  3326  		/* add length of name and EntryCnt field */
2649809cd1b432 James Smart         2022-09-11  3327  		size += sizeof(struct lpfc_name) + FOURBYTES;
2649809cd1b432 James Smart         2022-09-11  3328  
4258e98ee3862c James Smart         2015-12-16  3329  		bit_pos = 0;
4258e98ee3862c James Smart         2015-12-16  3330  		if (new_mask)
4258e98ee3862c James Smart         2015-12-16  3331  			mask = new_mask;
4258e98ee3862c James Smart         2015-12-16  3332  		else
4258e98ee3862c James Smart         2015-12-16  3333  			mask = vport->fdmi_port_mask;
4258e98ee3862c James Smart         2015-12-16  3334  
4258e98ee3862c James Smart         2015-12-16  3335  		/* Mask will dictate what attributes to build in the request */
4258e98ee3862c James Smart         2015-12-16  3336  		while (mask) {
4258e98ee3862c James Smart         2015-12-16  3337  			if (mask & 0x1) {
4258e98ee3862c James Smart         2015-12-16  3338  				func = lpfc_fdmi_port_action[bit_pos];
045c58c87560b2 James Smart         2022-09-11  3339  				addsz = func(vport, ((uint8_t *)base + size));
045c58c87560b2 James Smart         2022-09-11  3340  				if (addsz) {
76b2c34aeb947a James Smart         2015-04-07  3341  					pab->ab.EntryCnt++;
045c58c87560b2 James Smart         2022-09-11  3342  					size += addsz;
045c58c87560b2 James Smart         2022-09-11  3343  				}
2649809cd1b432 James Smart         2022-09-11  3344  				/* check if another attribute fits */
045c58c87560b2 James Smart         2022-09-11  3345  				if ((size + FDMI_MAX_ATTRLEN) >
4258e98ee3862c James Smart         2015-12-16  3346  				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
4258e98ee3862c James Smart         2015-12-16  3347  					goto port_out;
4258e98ee3862c James Smart         2015-12-16  3348  			}
4258e98ee3862c James Smart         2015-12-16  3349  			mask = mask >> 1;
4258e98ee3862c James Smart         2015-12-16  3350  			bit_pos++;
4258e98ee3862c James Smart         2015-12-16  3351  		}
76b2c34aeb947a James Smart         2015-04-07  3352  port_out:
76b2c34aeb947a James Smart         2015-04-07  3353  		pab->ab.EntryCnt = cpu_to_be32(pab->ab.EntryCnt);
2649809cd1b432 James Smart         2022-09-11  3354  		size += GID_REQUEST_SZ - 4;
dea3101e0a5c89 James Bottomley     2005-04-17  3355  		break;
dea3101e0a5c89 James Bottomley     2005-04-17  3356  
76b2c34aeb947a James Smart         2015-04-07  3357  	case SLI_MGMT_GHAT:
76b2c34aeb947a James Smart         2015-04-07  3358  	case SLI_MGMT_GRPL:
76b2c34aeb947a James Smart         2015-04-07  3359  		rsp_size = FC_MAX_NS_RSP;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3360  		fallthrough;
dea3101e0a5c89 James Bottomley     2005-04-17  3361  	case SLI_MGMT_DHBA:
76b2c34aeb947a James Smart         2015-04-07  3362  	case SLI_MGMT_DHAT:
2649809cd1b432 James Smart         2022-09-11  3363  		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un;
dea3101e0a5c89 James Bottomley     2005-04-17  3364  		memcpy((uint8_t *)&pe->PortName,
2e0fef85e098f6 James Smart         2007-06-17  3365  		       (uint8_t *)&vport->fc_sparam.portName,
dea3101e0a5c89 James Bottomley     2005-04-17  3366  		       sizeof(struct lpfc_name));
dea3101e0a5c89 James Bottomley     2005-04-17  3367  		size = GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
dea3101e0a5c89 James Bottomley     2005-04-17  3368  		break;
dea3101e0a5c89 James Bottomley     2005-04-17  3369  
76b2c34aeb947a James Smart         2015-04-07  3370  	case SLI_MGMT_GPAT:
76b2c34aeb947a James Smart         2015-04-07  3371  	case SLI_MGMT_GPAS:
76b2c34aeb947a James Smart         2015-04-07  3372  		rsp_size = FC_MAX_NS_RSP;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3373  		fallthrough;
dea3101e0a5c89 James Bottomley     2005-04-17  3374  	case SLI_MGMT_DPRT:
de3ec318fee323 James Smart         2022-05-05  3375  		if (vport->port_type != LPFC_PHYSICAL_PORT) {
de3ec318fee323 James Smart         2022-05-05  3376  			ndlp = lpfc_findnode_did(phba->pport, FDMI_DID);
de3ec318fee323 James Smart         2022-05-05  3377  			if (!ndlp)
de3ec318fee323 James Smart         2022-05-05  3378  				return 0;
de3ec318fee323 James Smart         2022-05-05  3379  		}
de3ec318fee323 James Smart         2022-05-05  3380  		fallthrough;
76b2c34aeb947a James Smart         2015-04-07  3381  	case SLI_MGMT_DPA:
2649809cd1b432 James Smart         2022-09-11  3382  		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un;
dea3101e0a5c89 James Bottomley     2005-04-17  3383  		memcpy((uint8_t *)&pe->PortName,
2e0fef85e098f6 James Smart         2007-06-17  3384  		       (uint8_t *)&vport->fc_sparam.portName,
dea3101e0a5c89 James Bottomley     2005-04-17  3385  		       sizeof(struct lpfc_name));
dea3101e0a5c89 James Bottomley     2005-04-17  3386  		size = GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
dea3101e0a5c89 James Bottomley     2005-04-17  3387  		break;
76b2c34aeb947a James Smart         2015-04-07  3388  	case SLI_MGMT_GRHL:
76b2c34aeb947a James Smart         2015-04-07  3389  		size = GID_REQUEST_SZ - 4;
76b2c34aeb947a James Smart         2015-04-07  3390  		break;
76b2c34aeb947a James Smart         2015-04-07  3391  	default:
76b2c34aeb947a James Smart         2015-04-07  3392  		lpfc_printf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
76b2c34aeb947a James Smart         2015-04-07  3393  				 "0298 FDMI cmdcode x%x not supported\n",
76b2c34aeb947a James Smart         2015-04-07  3394  				 cmdcode);
d8cdd33a66dc8c James Smart         2022-09-11  3395  		goto fdmi_cmd_free_rspvirt;
dea3101e0a5c89 James Bottomley     2005-04-17  3396  	}
76b2c34aeb947a James Smart         2015-04-07  3397  	CtReq->CommandResponse.bits.Size = cpu_to_be16(rsp_size);
dea3101e0a5c89 James Bottomley     2005-04-17  3398  
d8cdd33a66dc8c James Smart         2022-09-11  3399  	bde = (struct ulp_bde64_le *)rsp->virt;
d8cdd33a66dc8c James Smart         2022-09-11  3400  	bde->addr_high = cpu_to_le32(putPaddrHigh(rq->phys));
d8cdd33a66dc8c James Smart         2022-09-11  3401  	bde->addr_low = cpu_to_le32(putPaddrLow(rq->phys));
d8cdd33a66dc8c James Smart         2022-09-11  3402  	bde->type_size = cpu_to_le32(ULP_BDE64_TYPE_BDE_64 <<
d8cdd33a66dc8c James Smart         2022-09-11  3403  				     ULP_BDE64_TYPE_SHIFT);
d8cdd33a66dc8c James Smart         2022-09-11  3404  	bde->type_size |= cpu_to_le32(size);
dea3101e0a5c89 James Bottomley     2005-04-17  3405  
76b2c34aeb947a James Smart         2015-04-07  3406  	/*
76b2c34aeb947a James Smart         2015-04-07  3407  	 * The lpfc_ct_cmd/lpfc_get_req shall increment ndlp reference count
e47c9093531d34 James Smart         2008-02-08  3408  	 * to hold ndlp reference for the corresponding callback function.
e47c9093531d34 James Smart         2008-02-08  3409  	 */
d8cdd33a66dc8c James Smart         2022-09-11  3410  	if (!lpfc_ct_cmd(vport, rq, rsp, ndlp, cmpl, rsp_size, 0))
dea3101e0a5c89 James Bottomley     2005-04-17  3411  		return 0;
dea3101e0a5c89 James Bottomley     2005-04-17  3412  
d8cdd33a66dc8c James Smart         2022-09-11  3413  fdmi_cmd_free_rspvirt:
d8cdd33a66dc8c James Smart         2022-09-11  3414  	lpfc_mbuf_free(phba, rsp->virt, rsp->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3415  fdmi_cmd_free_rsp:
d8cdd33a66dc8c James Smart         2022-09-11  3416  	kfree(rsp);
d8cdd33a66dc8c James Smart         2022-09-11  3417  fdmi_cmd_free_rqvirt:
d8cdd33a66dc8c James Smart         2022-09-11  3418  	lpfc_mbuf_free(phba, rq->virt, rq->phys);
d8cdd33a66dc8c James Smart         2022-09-11  3419  fdmi_cmd_free_rq:
d8cdd33a66dc8c James Smart         2022-09-11  3420  	kfree(rq);
dea3101e0a5c89 James Bottomley     2005-04-17  3421  fdmi_cmd_exit:
dea3101e0a5c89 James Bottomley     2005-04-17  3422  	/* Issue FDMI request failed */
e8b62011d88d6f James Smart         2007-08-02  3423  	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
e8b62011d88d6f James Smart         2007-08-02  3424  			 "0244 Issue FDMI request failed Data: x%x\n",
e8b62011d88d6f James Smart         2007-08-02  3425  			 cmdcode);
dea3101e0a5c89 James Bottomley     2005-04-17  3426  	return 1;
dea3101e0a5c89 James Bottomley     2005-04-17  3427  }
dea3101e0a5c89 James Bottomley     2005-04-17  3428  

:::::: The code at line 3258 was first introduced by commit
:::::: 4258e98ee3862ca7036654b43c839ab7668043e0 lpfc: Modularize and cleanup FDMI code in driver

:::::: TO: James Smart <james.smart@avagotech.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
