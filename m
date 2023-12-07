Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE038088C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379488AbjLGNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjLGNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:04:01 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C310CB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AaGbtQfX3lZgbXDWL8hwGL3u5VTR+vXqXaa76kVDuFc=;
  b=Ei3qAXIUFXj9j7FGAXRUfHN7uAPW7aPLwasRuQRRW2TFULdJlUglsS1M
   pRV+LAy+BYOd+3AAWlulZcJ4FdgnncO6KMhvwjAIA7WnfHx+8dTZhVnKP
   /yKEy5AyfP063mm1b89DpaZTOcq5+76NtKP8XZAirz9rNfXORVcmj/Y4t
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,256,1695679200"; 
   d="scan'208";a="73710244"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:04:04 +0100
Date:   Thu, 7 Dec 2023 14:04:03 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
cc:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/intel/ice/ice_devlink.c:447:8-49: WARNING avoid
 newline at end of message in NL_SET_ERR_MSG_MOD (fwd)
Message-ID: <72d40e8-458-52f8-9bc9-ccd72d2ec298@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know the details around this, but you may want to look into it.

thanks,
julia

---------- Forwarded message ----------
Date: Thu, 7 Dec 2023 20:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/ethernet/intel/ice/ice_devlink.c:447:8-49: WARNING avoid
    newline at end of message in NL_SET_ERR_MSG_MOD

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 31c8db2c4fa799f5981451a6ce2b38320069d8ef ice: implement devlink reinit action
date:   10 months ago
:::::: branch date: 3 days ago
:::::: commit date: 10 months ago
config: x86_64-randconfig-102-20231207 (https://download.01.org/0day-ci/archive/20231207/202312072049.R5nMAfYw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312072049.R5nMAfYw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312072049.R5nMAfYw-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_devlink.c:447:8-49: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
   drivers/net/ethernet/intel/ice/ice_devlink.c:457:8-46: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
   drivers/net/ethernet/intel/ice/ice_devlink.c:452:8-44: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

vim +447 drivers/net/ethernet/intel/ice/ice_devlink.c

399e27dbbd9e94 Jacob Keller       2021-10-27  426
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  427  /**
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  428   * ice_devlink_reload_down - prepare for reload
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  429   * @devlink: pointer to the devlink instance to reload
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  430   * @netns_change: if true, the network namespace is changing
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  431   * @action: the action to perform
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  432   * @limit: limits on what reload should do, such as not resetting
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  433   * @extack: netlink extended ACK structure
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  434   */
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  435  static int
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  436  ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  437  			enum devlink_reload_action action,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  438  			enum devlink_reload_limit limit,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  439  			struct netlink_ext_ack *extack)
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  440  {
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  441  	struct ice_pf *pf = devlink_priv(devlink);
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  442
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  443  	switch (action) {
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  444  	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  445  		if (ice_is_eswitch_mode_switchdev(pf)) {
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  446  			NL_SET_ERR_MSG_MOD(extack,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21 @447  					   "Go to legacy mode before doing reinit\n");
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  448  			return -EOPNOTSUPP;
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  449  		}
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  450  		if (ice_is_adq_active(pf)) {
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  451  			NL_SET_ERR_MSG_MOD(extack,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  452  					   "Turn off ADQ before doing reinit\n");
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  453  			return -EOPNOTSUPP;
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  454  		}
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  455  		if (ice_has_vfs(pf)) {
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  456  			NL_SET_ERR_MSG_MOD(extack,
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  457  					   "Remove all VFs before doing reinit\n");
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  458  			return -EOPNOTSUPP;
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  459  		}
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  460  		ice_unload(pf);
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  461  		return 0;
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  462  	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  463  		return ice_devlink_reload_empr_start(pf, extack);
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  464  	default:
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  465  		WARN_ON(1);
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  466  		return -EOPNOTSUPP;
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  467  	}
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  468  }
31c8db2c4fa799 Michal Swiatkowski 2022-12-21  469

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
