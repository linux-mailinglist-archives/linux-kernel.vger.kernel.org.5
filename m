Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2626980930B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443938AbjLGVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjLGVGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:06:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCD1728;
        Thu,  7 Dec 2023 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701983219; x=1733519219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6wLJvnYVZuqFU6wsOOkiefEh9B/YqDJrTu7OOqvU+c=;
  b=jnJHIaOyI3/S4stS9irnVVCG1/KEQzf0xs/NyO9bIrz946eQZznga6VE
   953efm6PyMYzPtyy6k0SaKYuk8jqDkSXFsFVw8IcfuOtNEi0hH0a4pD0Y
   6z5lkbPSndcS7D0p2GjyuNWSg/LaB85wzGicKKqZly05Pn7iz6P5zixel
   IOHcqT+PcdTNlUH0QTTIg/P/rAdN8B34lW9SHyWmV8YttVM6qWwcgt+4l
   bDUx6xEB/2pbJWqKAKQeD6QACy7ERh6za/AoUybdtpu7svVgZNdQI8C/g
   8wdMZ+0R+yRchW9B+vxUJRpiQd9tvWmeKL/FpbwagIOk1rD1nC64SSCls
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460789358"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="460789358"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889871123"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889871123"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2023 13:06:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBLa8-000CpH-1e;
        Thu, 07 Dec 2023 21:06:52 +0000
Date:   Fri, 8 Dec 2023 05:06:01 +0800
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
Message-ID: <202312080453.iQ1jSiLY-lkp@intel.com>
References: <20231207090738.15721-13-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207090738.15721-13-rdbabiera@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231208/202312080453.iQ1jSiLY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080453.iQ1jSiLY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080453.iQ1jSiLY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/cros_typec_vdm.c:89:82: error: too few arguments to function call, expected 5, have 4
           ret = typec_altmode_vdm(amode, hdr, &resp.vdm_response[1], resp.vdm_data_objects);
                 ~~~~~~~~~~~~~~~~~                                                         ^
   include/linux/usb/typec_altmode.h:84:5: note: 'typec_altmode_vdm' declared here
   int typec_altmode_vdm(struct typec_altmode *altmode,
       ^
   1 error generated.


vim +89 drivers/platform/chrome/cros_typec_vdm.c

f54c013e7eef29 Prashant Malani 2023-01-26  55  
50ed638bbc47ba Prashant Malani 2022-12-28  56  /*
50ed638bbc47ba Prashant Malani 2022-12-28  57   * Retrieves a VDM response from the EC and forwards it to the altmode driver based on SVID.
50ed638bbc47ba Prashant Malani 2022-12-28  58   */
50ed638bbc47ba Prashant Malani 2022-12-28  59  void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int port_num)
50ed638bbc47ba Prashant Malani 2022-12-28  60  {
50ed638bbc47ba Prashant Malani 2022-12-28  61  	struct ec_response_typec_vdm_response resp;
50ed638bbc47ba Prashant Malani 2022-12-28  62  	struct ec_params_typec_vdm_response req = {
50ed638bbc47ba Prashant Malani 2022-12-28  63  		.port = port_num,
50ed638bbc47ba Prashant Malani 2022-12-28  64  	};
50ed638bbc47ba Prashant Malani 2022-12-28  65  	struct typec_altmode *amode;
50ed638bbc47ba Prashant Malani 2022-12-28  66  	u16 svid;
50ed638bbc47ba Prashant Malani 2022-12-28  67  	u32 hdr;
50ed638bbc47ba Prashant Malani 2022-12-28  68  	int ret;
50ed638bbc47ba Prashant Malani 2022-12-28  69  
50ed638bbc47ba Prashant Malani 2022-12-28  70  	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_VDM_RESPONSE, &req,
50ed638bbc47ba Prashant Malani 2022-12-28  71  			  sizeof(req), &resp, sizeof(resp));
50ed638bbc47ba Prashant Malani 2022-12-28  72  	if (ret < 0) {
50ed638bbc47ba Prashant Malani 2022-12-28  73  		dev_warn(typec->dev, "Failed VDM response fetch, port: %d\n", port_num);
50ed638bbc47ba Prashant Malani 2022-12-28  74  		return;
50ed638bbc47ba Prashant Malani 2022-12-28  75  	}
50ed638bbc47ba Prashant Malani 2022-12-28  76  
50ed638bbc47ba Prashant Malani 2022-12-28  77  	hdr = resp.vdm_response[0];
50ed638bbc47ba Prashant Malani 2022-12-28  78  	svid = PD_VDO_VID(hdr);
50ed638bbc47ba Prashant Malani 2022-12-28  79  	dev_dbg(typec->dev, "Received VDM header: %x, port: %d\n", hdr, port_num);
50ed638bbc47ba Prashant Malani 2022-12-28  80  
50ed638bbc47ba Prashant Malani 2022-12-28  81  	amode = typec_match_altmode(typec->ports[port_num]->port_altmode, CROS_EC_ALTMODE_MAX,
50ed638bbc47ba Prashant Malani 2022-12-28  82  				    svid, PD_VDO_OPOS(hdr));
50ed638bbc47ba Prashant Malani 2022-12-28  83  	if (!amode) {
50ed638bbc47ba Prashant Malani 2022-12-28  84  		dev_err(typec->dev, "Received VDM for unregistered altmode (SVID:%x), port: %d\n",
50ed638bbc47ba Prashant Malani 2022-12-28  85  			svid, port_num);
50ed638bbc47ba Prashant Malani 2022-12-28  86  		return;
50ed638bbc47ba Prashant Malani 2022-12-28  87  	}
50ed638bbc47ba Prashant Malani 2022-12-28  88  
50ed638bbc47ba Prashant Malani 2022-12-28 @89  	ret = typec_altmode_vdm(amode, hdr, &resp.vdm_response[1], resp.vdm_data_objects);
50ed638bbc47ba Prashant Malani 2022-12-28  90  	if (ret)
50ed638bbc47ba Prashant Malani 2022-12-28  91  		dev_err(typec->dev, "Failed to forward VDM to altmode (SVID:%x), port: %d\n",
50ed638bbc47ba Prashant Malani 2022-12-28  92  			svid, port_num);
50ed638bbc47ba Prashant Malani 2022-12-28  93  }
50ed638bbc47ba Prashant Malani 2022-12-28  94  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
