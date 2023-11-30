Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127E7FF7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjK3RLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjK3RLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:11:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0ED7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701364266; x=1732900266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M69x9RIUTe9+LZrrbX3iaxtwDRPEr868pnZuRCa9kIA=;
  b=gPvvaBUO3DvqbKaTFbOfjsUuyLZVfa3mk0ywGLi1KllXUVtqj+3HWuJ3
   UVHo8Ckggvc0aHDMoGexdvpo8EUJ1a1oPX+iAY5VNcAVwzMPwq1m5yvQ9
   QkA+WDQ4+F6cVgYdK+lwxPlYjzZbyvcdB649q02IL6NXsU5dCqQaKaGxE
   4QIbdV7gBpn1urV2VcuxZVSghiG7wXBX/J+pfDmDrkMPD/Q9fZBYShWq3
   sBVp54Myrny020Z3hU/y8yYOSpqmSejs6CuRahhhzEsOgzWrO6bj2QcXR
   IDfVbZkpXk22ywPD3uEwrMopjPtL8/0Mi88qy8671uo7xiv0lDMUhHZwH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="14905768"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="14905768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="773115022"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="773115022"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2023 09:11:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8kZ3-0002R6-20;
        Thu, 30 Nov 2023 17:11:01 +0000
Date:   Fri, 1 Dec 2023 01:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: drivers/scsi/elx/libefc/efc_node.c:254:65: warning: 'snprintf'
 output may be truncated before the last format character
Message-ID: <202312010138.o5on1HtR-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: ebc076b3eddc807729bd81f7bc48e798a3ddc477 scsi: elx: efct: Tie into kernel Kconfig and build process
date:   2 years, 6 months ago
config: x86_64-randconfig-014-20230906 (https://download.01.org/0day-ci/archive/20231201/202312010138.o5on1HtR-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010138.o5on1HtR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010138.o5on1HtR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/elx/libefc/efc_node.c: In function 'efc_node_update_display_name':
>> drivers/scsi/elx/libefc/efc_node.c:254:65: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
                                                                    ^
   drivers/scsi/elx/libefc/efc_node.c:254:2: note: 'snprintf' output 2 or more bytes (assuming 33) into a destination of size 32
     snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       nport->display_name, portid_display);
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +254 drivers/scsi/elx/libefc/efc_node.c

6bc6180d7b5c97 James Smart 2021-06-01  244  
6bc6180d7b5c97 James Smart 2021-06-01  245  void
6bc6180d7b5c97 James Smart 2021-06-01  246  efc_node_update_display_name(struct efc_node *node)
6bc6180d7b5c97 James Smart 2021-06-01  247  {
6bc6180d7b5c97 James Smart 2021-06-01  248  	u32 port_id = node->rnode.fc_id;
6bc6180d7b5c97 James Smart 2021-06-01  249  	struct efc_nport *nport = node->nport;
6bc6180d7b5c97 James Smart 2021-06-01  250  	char portid_display[16];
6bc6180d7b5c97 James Smart 2021-06-01  251  
6bc6180d7b5c97 James Smart 2021-06-01  252  	efc_node_fcid_display(port_id, portid_display, sizeof(portid_display));
6bc6180d7b5c97 James Smart 2021-06-01  253  
6bc6180d7b5c97 James Smart 2021-06-01 @254  	snprintf(node->display_name, sizeof(node->display_name), "%s.%s",
6bc6180d7b5c97 James Smart 2021-06-01  255  		 nport->display_name, portid_display);
6bc6180d7b5c97 James Smart 2021-06-01  256  }
6bc6180d7b5c97 James Smart 2021-06-01  257  

:::::: The code at line 254 was first introduced by commit
:::::: 6bc6180d7b5c972c10a2f5392621921de32ce5bc scsi: elx: libefc: Remote node state machine interfaces

:::::: TO: James Smart <jsmart2021@gmail.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
