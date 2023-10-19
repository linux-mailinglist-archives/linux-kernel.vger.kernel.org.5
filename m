Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E557CF1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJSIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjJSIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:01:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC10136
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697702461; x=1729238461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B+lp5B9vgqwKTLDaoIaBIhccSw1ySPvIDxywTOA1zCw=;
  b=Z0Jul1ZUcDrEn+EohHnaDSrKfB28s0tH8B8NTNZPROs8tzudNxmcQC/Y
   ckXtv5oEgYaZ50ROfRB1yl2ZaFMcUlXFKnM8YaNjkVk1iCBeVukFdYodh
   ThlCG30SGXEeQz53w1yYXn2cJi+wNysbFT1k5Aor2DZ2HAVj3cDpkX5lB
   OhKqCIgaQ/enZsFWo/5noK1yeqgaPgOeExUjqVK7KZlAsOZMPTdo0tqxG
   HuhG9gGZdlNh+l55OlU5La2AQDHOLYUShivI24p0PYsEeKGdDS+OLYbps
   ZfesttUjjH8hBTyLfiyMex/JMfS7zh14coP8b7/HR7OCspIHPKwvHvuzv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="385070609"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="385070609"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4867864"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2023 01:01:02 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtNxh-0001qE-1Q;
        Thu, 19 Oct 2023 08:00:57 +0000
Date:   Thu, 19 Oct 2023 16:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/netlink.h:115:13: warning: ' conflicts with existing
 pse...' directive output truncated writing 53 bytes into a region of size
 between 28 and 33
Message-ID: <202310191526.qzRRtPnw-lkp@intel.com>
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
head:   dd72f9c7e512da377074d47d990564959b772643
commit: b6583d5e9e94adce1be61ec59fef4e129f0bc68a sfc: support TC decap rules matching on enc_src_port
date:   5 months ago
config: x86_64-randconfig-x013-20230730 (https://download.01.org/0day-ci/archive/20231019/202310191526.qzRRtPnw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191526.qzRRtPnw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191526.qzRRtPnw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:46,
                    from include/net/sch_generic.h:5,
                    from include/net/pkt_cls.h:7,
                    from drivers/net/ethernet/sfc/tc.c:12:
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_flower_record_encap_match':
>> include/linux/netlink.h:115:13: warning: ' conflicts with existing pse...' directive output truncated writing 53 bytes into a region of size between 28 and 33 [-Wformat-truncation=]
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:518:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     518 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:13: note: directive argument in the range [0, 65535]
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:518:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     518 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:13: note: 'snprintf' output between 102 and 112 bytes into a destination of size 80
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:518:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     518 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:13: warning: ' conflicts with existing pse...' directive output truncated writing 57 bytes into a region of size 39 [-Wformat-truncation=]
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:511:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     511 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:13: note: directive argument in the range [0, 255]
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:511:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     511 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:115:13: note: 'snprintf' output 103 bytes into a destination of size 80
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:130:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:511:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     511 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~


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
