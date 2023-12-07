Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1F809266
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443912AbjLGUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjLGUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:33:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82241722;
        Thu,  7 Dec 2023 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701981237; x=1733517237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SPK2zasUPN95+NP/auAttA6k+ge4mGcg7RBWFAT4m1U=;
  b=kCt1qvDaMdXsMYqR0qzhCWCKPUUfuiAzshqVcRXmHgikn76HdK0wlGkI
   9U7HmXo+1Bx3xakelD7zytH+1A7VPpQG9AfBUMk/yn6H6Hca4rPyTzfim
   635cwVzfMmA9jUpo04nsII6FES1qpU46dDovJLA0ftkjhoxC6jKwpbCWa
   O5g5WbEAsy2nAmc5O6FaMpfnjCYUQy8CiOMuH+gUndBYgjrcv8WdVglQF
   i1Jigwt2F13MHh3hkXUqOPZQ+aVZrrWRzWk/XsMQXUxbTTYcQqZ2XZtYp
   q8YJpXGdoTJZPO40aLv5oYD/087+V3yRQ//a4zlZN6muW14+id4VukKq7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="379306318"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="379306318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915695873"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="915695873"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2023 12:33:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBL4B-000Cnh-1q;
        Thu, 07 Dec 2023 20:33:51 +0000
Date:   Fri, 8 Dec 2023 04:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
        linux@roeck-us.net, gregkh@linuxfoundation.org,
        pmalani@chromium.org, bleung@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        badhri@google.com, tzungbi@kernel.org, utkarsh.h.patel@intel.com,
        andriy.shevchenko@linux.intel.com,
        RD Babiera <rdbabiera@google.com>
Subject: Re: [PATCH v1 01/10] usb: typec: bus: provide transmit type for
 alternate mode drivers
Message-ID: <202312080436.1iwq0THA-lkp@intel.com>
References: <20231207090738.15721-13-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207090738.15721-13-rdbabiera@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RD,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5e4c8814a431d21bfaf20b464134f40f2f81e152]

url:    https://github.com/intel-lab-lkp/linux/commits/RD-Babiera/usb-typec-bus-provide-transmit-type-for-alternate-mode-drivers/20231207-171114
base:   5e4c8814a431d21bfaf20b464134f40f2f81e152
patch link:    https://lore.kernel.org/r/20231207090738.15721-13-rdbabiera%40google.com
patch subject: [PATCH v1 01/10] usb: typec: bus: provide transmit type for alternate mode drivers
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20231208/202312080436.1iwq0THA-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080436.1iwq0THA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080436.1iwq0THA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/displayport.c:293:31: error: too few arguments to function call, expected 5, have 4
                                   dp->vdo_data, dp->vdo_size);
                                                             ^
   include/linux/usb/typec_altmode.h:84:5: note: 'typec_altmode_vdm' declared here
   int typec_altmode_vdm(struct typec_altmode *altmode,
       ^
   1 error generated.


vim +293 drivers/usb/typec/ucsi/displayport.c

af8622f6a585d8 Heikki Krogerus 2019-04-23  284  
af8622f6a585d8 Heikki Krogerus 2019-04-23  285  static void ucsi_displayport_work(struct work_struct *work)
af8622f6a585d8 Heikki Krogerus 2019-04-23  286  {
af8622f6a585d8 Heikki Krogerus 2019-04-23  287  	struct ucsi_dp *dp = container_of(work, struct ucsi_dp, work);
af8622f6a585d8 Heikki Krogerus 2019-04-23  288  	int ret;
af8622f6a585d8 Heikki Krogerus 2019-04-23  289  
af8622f6a585d8 Heikki Krogerus 2019-04-23  290  	mutex_lock(&dp->con->lock);
af8622f6a585d8 Heikki Krogerus 2019-04-23  291  
af8622f6a585d8 Heikki Krogerus 2019-04-23  292  	ret = typec_altmode_vdm(dp->alt, dp->header,
af8622f6a585d8 Heikki Krogerus 2019-04-23 @293  				dp->vdo_data, dp->vdo_size);
af8622f6a585d8 Heikki Krogerus 2019-04-23  294  	if (ret)
af8622f6a585d8 Heikki Krogerus 2019-04-23  295  		dev_err(&dp->alt->dev, "VDM 0x%x failed\n", dp->header);
af8622f6a585d8 Heikki Krogerus 2019-04-23  296  
af8622f6a585d8 Heikki Krogerus 2019-04-23  297  	dp->vdo_data = NULL;
af8622f6a585d8 Heikki Krogerus 2019-04-23  298  	dp->vdo_size = 0;
af8622f6a585d8 Heikki Krogerus 2019-04-23  299  	dp->header = 0;
af8622f6a585d8 Heikki Krogerus 2019-04-23  300  
af8622f6a585d8 Heikki Krogerus 2019-04-23  301  	mutex_unlock(&dp->con->lock);
af8622f6a585d8 Heikki Krogerus 2019-04-23  302  }
af8622f6a585d8 Heikki Krogerus 2019-04-23  303  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
