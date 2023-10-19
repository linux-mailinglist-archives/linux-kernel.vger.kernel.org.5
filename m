Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B67CFAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbjJSN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345923AbjJSN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:26:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF3106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697721966; x=1729257966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=efPmX5A8B5ZfWF3vAqZbcwFs2e935indB1OtsnCxIco=;
  b=LjZhPrsoLtKtUKIYqxldJJffF2SwGfFiRzbJmKjPSTAlYnBl/h03I0Vc
   vHzyGg49vQr7g6b7cm+kuIHgJzYw6Nvxhh/kQ4jB8DkNzm3TGYxeRTqa+
   h71tInrQxD278qc1jgLzO3u5HdP4z4IXidoqnON/fv5CPdsCUaHz52iYT
   KhwNqd8Xm3W0zhRyQQk+F1N9QtQdUDyxxFv7I6zJlTGOGhmSONNkSRzCd
   JQPNTI6rjYv47QJe0f22xstWULthkxYM9hnqmXUzfExlQjEUvfos/7Ewh
   ZuZ8jx3wK2LrjGdBdiob2O8FRnlY01knNxXM3tiAZk3X0HVu96Xf+OlbZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450471234"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="450471234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792000256"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="792000256"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2023 06:22:11 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtSyX-00028h-0s;
        Thu, 19 Oct 2023 13:22:09 +0000
Date:   Thu, 19 Oct 2023 21:21:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Edward Cree <ecree.xilinx@gmail.com>
Subject: include/linux/netlink.h:116:13: warning: 'sfc: Unsupported: only
 suppo...' directive output truncated writing 104 bytes into a region of size
 80
Message-ID: <202310192117.YEwbmOWC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 66f728872636e1167aedc5a18be6760083911900 sfc: add decrement ttl by offloading set ipv4 ttl actions
date:   8 weeks ago
config: x86_64-randconfig-x013-20230730 (https://download.01.org/0day-ci/archive/20231019/202310192117.YEwbmOWC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192117.YEwbmOWC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192117.YEwbmOWC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sch_generic.h:5,
                    from include/net/pkt_cls.h:7,
                    from drivers/net/ethernet/sfc/tc.c:12:
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_mangle':
>> include/linux/netlink.h:116:13: warning: 'sfc: Unsupported: only suppo...' directive output truncated writing 104 bytes into a region of size 80 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1155:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1155 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 254]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1155:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1155 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 107 and 110 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1155:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1155 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_flower_record_encap_match':
   include/linux/netlink.h:116:13: warning: ' conflicts with existing pse...' directive output truncated writing 53 bytes into a region of size between 28 and 33 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:632:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     632 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 65535]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:632:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     632 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 102 and 112 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:632:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     632 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: warning: ' conflicts with existing pse...' directive output truncated writing 57 bytes into a region of size 39 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:625:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     625 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 255]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:625:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     625 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output 103 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:625:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     625 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~


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
