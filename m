Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C57B0DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjI0U7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0U7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:59:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EF121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695848374; x=1727384374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G7VPodXYdowt4In3HIrR5vUz5WkTjUn67Tb/g7qTa1U=;
  b=Qk97ZNSWkycMnAVn/p3XA1St9abnZi3uQhXFx0613Nnfk2+TtjdgFtCI
   dlKpe+fksfXGgSn9TX2eGRp1GK3svdSrDfdx6SJrKe5XKuLG+Ctu42ksI
   T05ummVs5Z/F0Qy6p6jseiYzt19zUO388paUapkC3MFSlXC2aeqxPUJKo
   AIYGjFagg9QOc71x5FWr4VhEDYBvy167ISqQ/eXz88/dT3Js3kwo64Kix
   0P1ew2FO8ghLmAOAbiHU4DPd6ieX8bKdZ1CLRL9MUvt9O2qxwVVw3ynBc
   x9NtdsCpgGwH0GZhZuInhMFbk0rlIZRspTwNqO6mjNcUgheaV/bgKN4Yt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379198925"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="379198925"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 13:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="699025227"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="699025227"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2023 13:59:32 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlbd4-0000fZ-0L;
        Wed, 27 Sep 2023 20:59:30 +0000
Date:   Thu, 28 Sep 2023 04:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: drivers/platform/chrome/cros_ec_typec.c:900:39: sparse: sparse: cast
 to restricted __le16
Message-ID: <202309280431.VyAxysqB-lkp@intel.com>
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
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: 3b3dd1f0dbfe92781c60f36ea5c22b26360f9909 platform/chrome: cros_ec_typec: Report SOP' PD revision from status
date:   2 years, 8 months ago
config: x86_64-randconfig-121-20230928 (https://download.01.org/0day-ci/archive/20230928/202309280431.VyAxysqB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309280431.VyAxysqB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309280431.VyAxysqB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/chrome/cros_ec_typec.c:900:39: sparse: sparse: cast to restricted __le16

vim +900 drivers/platform/chrome/cros_ec_typec.c

   870	
   871	static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
   872	{
   873		struct ec_response_typec_status resp;
   874		struct ec_params_typec_status req = {
   875			.port = port_num,
   876		};
   877		int ret;
   878	
   879		ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
   880					    &resp, sizeof(resp));
   881		if (ret < 0) {
   882			dev_warn(typec->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
   883			return;
   884		}
   885	
   886		/* Handle any events appropriately. */
   887		if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
   888			ret = cros_typec_handle_sop_disc(typec, port_num);
   889			if (ret < 0)
   890				dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
   891			else
   892				typec->ports[port_num]->sop_disc_done = true;
   893		}
   894	
   895		if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
   896		    !typec->ports[port_num]->sop_prime_disc_done) {
   897			u16 sop_prime_revision;
   898	
   899			/* Convert BCD to the format preferred by the TypeC framework */
 > 900			sop_prime_revision = (le16_to_cpu(resp.sop_prime_revision) & 0xff00) >> 4;
   901			ret = cros_typec_handle_sop_prime_disc(typec, port_num, sop_prime_revision);
   902			if (ret < 0)
   903				dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
   904			else
   905				typec->ports[port_num]->sop_prime_disc_done = true;
   906		}
   907	}
   908	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
