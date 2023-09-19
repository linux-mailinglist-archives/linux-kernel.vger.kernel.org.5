Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7C7A6B34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjISTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:10:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13DB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695150607; x=1726686607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aMuofLrrJXedSGiAELisp9bPZXomRUaSBqDF7zBR9Z0=;
  b=TWmdSONSO16remRMhYzZEgW1K0blhQ/JKOGyVwY0hr1AIn8tzNMLu5Ko
   V9p+6BTiQxczSbdRWvgMnIjL2Fjz9nESmUXPg/ZdVCH4ig3TvzsHk9e9F
   cTdczm2BbMrT7lMOvitTUNz+mhxgfHF5T7dBLIPqkf4Slcenxo3WC0D0o
   VdYCE3xKYBO5IF/ipiEnIyq9LSqbW64C+B0varS0XkUlXdwwshUS/46NW
   3r3A24Zz1XSgaF14FU4JECQMzsl+AU+7u/6qBQQ2vB5Gq1mLf685Rl60t
   qBXaixe25BC57Hup34x+V9UfFTOBmQZLAF24/MIACXAQfw8ZBJxBG1+zO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="378922433"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="378922433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861662635"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="861662635"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2023 12:10:05 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qig6l-0007p8-2H;
        Tue, 19 Sep 2023 19:10:03 +0000
Date:   Wed, 20 Sep 2023 03:10:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/netlink.h:115:6: warning: ' conflicts with existing
 pseudo(MASK) entry for TOS mask ' directive output truncated writing 57
 bytes into a region of size between 33 and 39
Message-ID: <202309200308.Eu2HF6Md-lkp@intel.com>
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
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 3c9561c0a5b988be3dfd24ea1de2301b95efc640 sfc: support TC decap rules matching on enc_ip_tos
date:   4 months ago
config: x86_64-randconfig-014-20230906 (https://download.01.org/0day-ci/archive/20230920/202309200308.Eu2HF6Md-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200308.Eu2HF6Md-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200308.Eu2HF6Md-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6:0,
                    from include/linux/netdevice.h:46,
                    from include/net/sch_generic.h:5,
                    from include/net/pkt_cls.h:7,
                    from drivers/net/ethernet/sfc/tc.c:12:
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_flower_record_encap_match':
>> include/linux/netlink.h:115:6: warning: ' conflicts with existing pseudo(MASK) entry for TOS mask ' directive output truncated writing 57 bytes into a region of size between 33 and 39 [-Wformat-truncation=]
     if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,        \
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           "%s" fmt "%s", "", ##args, "") >=          \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:2: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
     ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:507:5: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
        NL_SET_ERR_MSG_FMT_MOD(extack,
        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:6: note: directive argument in the range [0, 2147483647]
     if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,        \
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           "%s" fmt "%s", "", ##args, "") >=          \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:2: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
     ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:507:5: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
        NL_SET_ERR_MSG_FMT_MOD(extack,
        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:6: note: 'snprintf' output between 103 and 115 bytes into a destination of size 80
     if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,        \
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           "%s" fmt "%s", "", ##args, "") >=          \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:2: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
     ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:507:5: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
        NL_SET_ERR_MSG_FMT_MOD(extack,
        ^~~~~~~~~~~~~~~~~~~~~~


vim +115 include/linux/netlink.h

2d4bc93368f5a0 Johannes Berg 2017-04-12  106  
51c352bdbcd23d Edward Cree   2022-10-18  107  /* We splice fmt with %s at each end even in the snprintf so that both calls
51c352bdbcd23d Edward Cree   2022-10-18  108   * can use the same string constant, avoiding its duplication in .ro
51c352bdbcd23d Edward Cree   2022-10-18  109   */
51c352bdbcd23d Edward Cree   2022-10-18  110  #define NL_SET_ERR_MSG_FMT(extack, fmt, args...) do {			       \
51c352bdbcd23d Edward Cree   2022-10-18  111  	struct netlink_ext_ack *__extack = (extack);			       \
51c352bdbcd23d Edward Cree   2022-10-18  112  									       \
51c352bdbcd23d Edward Cree   2022-10-18  113  	if (!__extack)							       \
51c352bdbcd23d Edward Cree   2022-10-18  114  		break;							       \
51c352bdbcd23d Edward Cree   2022-10-18 @115  	if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,	       \
51c352bdbcd23d Edward Cree   2022-10-18  116  		     "%s" fmt "%s", "", ##args, "") >=			       \
51c352bdbcd23d Edward Cree   2022-10-18  117  	    NETLINK_MAX_FMTMSG_LEN)					       \
51c352bdbcd23d Edward Cree   2022-10-18  118  		net_warn_ratelimited("%s" fmt "%s", "truncated extack: ",      \
51c352bdbcd23d Edward Cree   2022-10-18  119  				     ##args, "\n");			       \
51c352bdbcd23d Edward Cree   2022-10-18  120  									       \
51c352bdbcd23d Edward Cree   2022-10-18  121  	do_trace_netlink_extack(__extack->_msg_buf);			       \
51c352bdbcd23d Edward Cree   2022-10-18  122  									       \
51c352bdbcd23d Edward Cree   2022-10-18  123  	__extack->_msg = __extack->_msg_buf;				       \
51c352bdbcd23d Edward Cree   2022-10-18  124  } while (0)
51c352bdbcd23d Edward Cree   2022-10-18  125  

:::::: The code at line 115 was first introduced by commit
:::::: 51c352bdbcd23d7ce46b06c1e64c82754dc44044 netlink: add support for formatted extack messages

:::::: TO: Edward Cree <ecree.xilinx@gmail.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
