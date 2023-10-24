Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5217D4396
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJXAHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6509110;
        Mon, 23 Oct 2023 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698106047; x=1729642047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrjV4WGvbvWR86sSD3Ua1QhLRp1hvz/gEx/hUAAe/8U=;
  b=U1GE9vi47lhBEYm9XwQhLw5ZIczUjJyYkrF43WrZAX3wE1TAp4cbk3DB
   cz8OOczQtezSqeyUkN1fXm5Mcvip0OLjlWaxpwAgHNUdiKC8K+Ltyt3bd
   ZSZAVAUBJymqbrj+CmpO4jUS+GXS5t+th4T/9WGknKcKxOEZvNX0IAylZ
   UD2GVif38Dw87HmcBB/zXX5CE9/sbGRiBqR6Ln8sLYNxduTNLexsB6qCn
   +fLwe/0LuScdeNqAJAZ3fnzaMPzg76/ibCaQ4GBndGmaDM2ApxeLQU6Jx
   zhcjaFzmIq1TfFtAPUpDdqjpOAyqJakY8/bjjcDIRU3EjGXJEg2ItKy0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386762742"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386762742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881938260"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="881938260"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2023 17:07:25 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv4x8-0007OX-2q;
        Tue, 24 Oct 2023 00:07:22 +0000
Date:   Tue, 24 Oct 2023 08:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Ai Chao <aichao@kylinos.cn>
Subject: Re: [PATCH v4] platform/x86: inspur-wmi: Add platform profile support
Message-ID: <202310240736.pU47RVwI-lkp@intel.com>
References: <20231019030534.157971-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019030534.157971-1-aichao@kylinos.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc7 next-20231023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ai-Chao/platform-x86-inspur-wmi-Add-platform-profile-support/20231019-110800
base:   linus/master
patch link:    https://lore.kernel.org/r/20231019030534.157971-1-aichao%40kylinos.cn
patch subject: [PATCH v4] platform/x86: inspur-wmi: Add platform profile support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310240736.pU47RVwI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310240736.pU47RVwI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240736.pU47RVwI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/inspur-wmi.c:27: warning: cannot understand function prototype: 'enum inspur_tmp_profile '
   drivers/platform/x86/inspur-wmi.c:74: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
   drivers/platform/x86/inspur-wmi.c:123: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,


vim +27 drivers/platform/x86/inspur-wmi.c

    20	
    21	/**
    22	 * Power Mode:
    23	 *           0x0: Balance Mode
    24	 *           0x1: Performance Mode
    25	 *           0x2: Power Saver Mode
    26	 */
  > 27	enum inspur_tmp_profile {
    28		INSPUR_TMP_PROFILE_BALANCE	= 0,
    29		INSPUR_TMP_PROFILE_PERFORMANCE	= 1,
    30		INSPUR_TMP_PROFILE_POWERSAVE	= 2,
    31	};
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
