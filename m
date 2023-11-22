Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1257F3B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjKVBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKVBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:25:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D351A3;
        Tue, 21 Nov 2023 17:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700616331; x=1732152331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8oT6RUsi73gqqA7YznCIrpliumT0ylzF6sXsPx7xLk=;
  b=gb0fzyw1SpfYez0a5WJQtg2x6KTxCkaUiE9YLB5IhJ/jsq8M1r8Lql4s
   cV7X1sY24EoxBtKnQbT1L0mNlNYq7FoxR1R3P4LN4EULb5DI5XNtLis4A
   l5c17LBfhtcNhlorL6JmhRhRL57HAVcd2NOw5CSRfu59kBSxM/0Mugmbz
   gXIzIcner2p8k+zgtqAt3LOxuWekVGTzPOKk8TbsHu6r+bMGY2Z0cv+in
   URnmWn38M0aVaQNEMj7p9t2iRau2b5ALFwCsCmSy5P94qw7cnrlQK8nLN
   pkNUN55bwmHYjObvRXlo6QzQesBxHRi4Au8RlJ35E3a0wbdO0V3fsehv0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382354354"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="382354354"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766827289"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="766827289"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2023 17:25:27 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5bzH-0008UM-0y;
        Wed, 22 Nov 2023 01:25:24 +0000
Date:   Wed, 22 Nov 2023 09:24:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Sanath S <Sanath.S@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
Subject: Re: [Patch] thunderbolt: Add quirk to reset downstream port
Message-ID: <202311220931.2IqiKNXr-lkp@intel.com>
References: <20231121174701.3922587-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121174701.3922587-1-Sanath.S@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanath,

kernel test robot noticed the following build warnings:

[auto build test WARNING on westeri-thunderbolt/next]
[also build test WARNING on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sanath-S/thunderbolt-Add-quirk-to-reset-downstream-port/20231122-014913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git next
patch link:    https://lore.kernel.org/r/20231121174701.3922587-1-Sanath.S%40amd.com
patch subject: [Patch] thunderbolt: Add quirk to reset downstream port
config: x86_64-buildonly-randconfig-003-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220931.2IqiKNXr-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220931.2IqiKNXr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220931.2IqiKNXr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thunderbolt/switch.c:1556:2: warning: variable 'ret' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           tb_switch_for_each_port(sw, port) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/tb.h:821:7: note: expanded from macro 'tb_switch_for_each_port'
                (p) <= &(sw)->ports[(sw)->config.max_port_number]; (p)++)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/switch.c:1564:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/thunderbolt/switch.c:1556:2: note: remove the condition if it is always true
           tb_switch_for_each_port(sw, port) {
           ^
   drivers/thunderbolt/tb.h:821:7: note: expanded from macro 'tb_switch_for_each_port'
                (p) <= &(sw)->ports[(sw)->config.max_port_number]; (p)++)
                ^
   drivers/thunderbolt/switch.c:1554:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1556 drivers/thunderbolt/switch.c

  1549	
  1550	static int tb_switch_reset_downstream_port(struct tb_switch *sw)
  1551	{
  1552		struct tb_port *port;
  1553		uint32_t val = 0;
  1554		int ret;
  1555	
> 1556		tb_switch_for_each_port(sw, port) {
  1557			if (port->config.type == TB_TYPE_PORT) {
  1558				val = val | PORT_CS_19_DPR;
  1559				ret = tb_port_write(port, &val, TB_CFG_PORT,
  1560						port->cap_usb4 + PORT_CS_19, 1);
  1561				break;
  1562			}
  1563		}
  1564		return ret;
  1565	}
  1566	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
