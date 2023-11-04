Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FE7E0DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 05:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbjKDE6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 00:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjKDE62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 00:58:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A16187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 21:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699073905; x=1730609905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aPLRYk5QUvQYFtjovs40Fby56lpJMdToSR9hdT/plsE=;
  b=clggQI1iZEqbMBT5RnkTq8W3eRv/Ju7m4Rrb+GF/+LhwWWIShrT+l/Q8
   X6EEcsPnMNRqb31OyQMVB5vLHCo7Ro6o4nDFTyoVkyZUroQfmJs1sScFj
   BHZ0fN3YwSwx18PsjUcK0l6s1mJwJU6PmI6CsA5A57h4nQ5kO2IBLvMPN
   MGbLxTu7hI8ybpdrVWXozyVbJOayktHzgDVgNPn5ax4d9zNdXJ3tRl4O6
   A7XDg1RndjdrXHhHUlwFTZr3Vl/qsR/nm/lFc1GUmfvI6qmJv7njL6Hbx
   9USMFA35tWsKjWcxxFyx4ZH8aVX1x6mwdpw4s3ihnNUvlZkt4nh2+ZOhc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="7694138"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="7694138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 21:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="905551057"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="905551057"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2023 21:58:21 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz8jj-0003Rw-2M;
        Sat, 04 Nov 2023 04:58:19 +0000
Date:   Sat, 4 Nov 2023 12:57:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>
Subject: include/linux/netlink.h:116:13: warning: ' TXQs for network stack
 (tot...' directive output truncated writing 31 bytes into a region of size
 between 0 and 14
Message-ID: <202311041206.ZG6Mb1tm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2c40c1c6adab90ee4660caf03722b3a3ec67767b
commit: 800db2d125c2bc22c448e2386c3518e663d6db71 net: enetc: ensure we always have a minimum number of TXQs for stack
date:   9 months ago
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311041206.ZG6Mb1tm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041206.ZG6Mb1tm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041206.ZG6Mb1tm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from drivers/net/ethernet/freescale/enetc/enetc.h:6,
                    from drivers/net/ethernet/freescale/enetc/enetc.c:4:
   In function 'enetc_setup_xdp_prog',
       inlined from 'enetc_setup_bpf' at drivers/net/ethernet/freescale/enetc/enetc.c:2733:10:
>> include/linux/netlink.h:116:13: warning: ' TXQs for network stack (tot...' directive output truncated writing 31 bytes into a region of size between 0 and 14 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:2713:17: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    2713 |                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 65535]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:2713:17: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    2713 |                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 110 and 134 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:2713:17: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    2713 |                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +116 include/linux/netlink.h

2d4bc93368f5a0 Johannes Berg 2017-04-12  107  
51c352bdbcd23d Edward Cree   2022-10-18  108  /* We splice fmt with %s at each end even in the snprintf so that both calls
51c352bdbcd23d Edward Cree   2022-10-18  109   * can use the same string constant, avoiding its duplication in .ro
51c352bdbcd23d Edward Cree   2022-10-18  110   */
51c352bdbcd23d Edward Cree   2022-10-18  111  #define NL_SET_ERR_MSG_FMT(extack, fmt, args...) do {			       \
51c352bdbcd23d Edward Cree   2022-10-18  112  	struct netlink_ext_ack *__extack = (extack);			       \
51c352bdbcd23d Edward Cree   2022-10-18  113  									       \
51c352bdbcd23d Edward Cree   2022-10-18  114  	if (!__extack)							       \
51c352bdbcd23d Edward Cree   2022-10-18  115  		break;							       \
51c352bdbcd23d Edward Cree   2022-10-18 @116  	if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,	       \
51c352bdbcd23d Edward Cree   2022-10-18  117  		     "%s" fmt "%s", "", ##args, "") >=			       \
51c352bdbcd23d Edward Cree   2022-10-18  118  	    NETLINK_MAX_FMTMSG_LEN)					       \
51c352bdbcd23d Edward Cree   2022-10-18  119  		net_warn_ratelimited("%s" fmt "%s", "truncated extack: ",      \
51c352bdbcd23d Edward Cree   2022-10-18  120  				     ##args, "\n");			       \
51c352bdbcd23d Edward Cree   2022-10-18  121  									       \
51c352bdbcd23d Edward Cree   2022-10-18  122  	do_trace_netlink_extack(__extack->_msg_buf);			       \
51c352bdbcd23d Edward Cree   2022-10-18  123  									       \
51c352bdbcd23d Edward Cree   2022-10-18  124  	__extack->_msg = __extack->_msg_buf;				       \
51c352bdbcd23d Edward Cree   2022-10-18  125  } while (0)
51c352bdbcd23d Edward Cree   2022-10-18  126  

:::::: The code at line 116 was first introduced by commit
:::::: 51c352bdbcd23d7ce46b06c1e64c82754dc44044 netlink: add support for formatted extack messages

:::::: TO: Edward Cree <ecree.xilinx@gmail.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
