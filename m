Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939D808745
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379126AbjLGMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:02:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67CA9;
        Thu,  7 Dec 2023 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701950562; x=1733486562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjebZ/3jB6yBXogRzbFTiLh94dgst6N2OkVomZJsYDM=;
  b=e1kHBT/7BJgXcqzrs/jrvqLQ4Yp52BY+Gy3o52oUg5sNOHkONa3UZP/m
   I7E09f+JZOkTb7mq0yVAQL1lKtagUbboirWmr7V6ORQ9ISiz6EhPGEldF
   mvd5SHA2v7JJRxJEHzoxZ7S3iYkFiQ9N6amZ124j/0u8xPCpI/VU56NU/
   5qccJlkaYVn3YSkT0JNH2rdX65eCbKRx4ZBj0lxFVPNGUaNBWCS8jlXne
   MnwP6vTE7R6zrylT9QIh4HtBoOi7LseKFlq5ktOfywZOfgm6HotudyKR9
   SqMFBrWeS7zSKFD7hgNGqYmfwmI1+9naaPTPThtallN4OvuV/qZYALqDO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12933467"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12933467"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1103177243"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103177243"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2023 04:02:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBD5O-000CCM-02;
        Thu, 07 Dec 2023 12:02:34 +0000
Date:   Thu, 7 Dec 2023 20:01:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, majun@amd.com,
        Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v15 1/9] Documentation/driver-api: Add document about
 WBRF mechanism
Message-ID: <202312071941.JXQXsK1C-lkp@intel.com>
References: <20231206072947.1331729-2-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206072947.1331729-2-Jun.Ma2@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc4 next-20231207]
[cannot apply to drm-misc/drm-misc-next wireless-next/main wireless/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Jun/Documentation-driver-api-Add-document-about-WBRF-mechanism/20231206-153327
base:   linus/master
patch link:    https://lore.kernel.org/r/20231206072947.1331729-2-Jun.Ma2%40amd.com
patch subject: [PATCH v15 1/9] Documentation/driver-api: Add document about WBRF mechanism
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312071941.JXQXsK1C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312071941.JXQXsK1C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/wbrf.rst:28: WARNING: Unexpected indentation.
>> Documentation/driver-api/wbrf.rst:61: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/driver-api/wbrf.rst: WARNING: document isn't included in any toctree

vim +28 Documentation/driver-api/wbrf.rst

    25	
    26	Producer: such component who can produce high-powered radio frequency
    27	Consumer: such component who can adjust its in-use frequency in
  > 28	           response to the radio frequencies of other components to
    29	           mitigate the possible RFI.
    30	
    31	To make the mechanism function, those producers should notify active use
    32	of their particular frequencies so that other consumers can make relative
    33	internal adjustments as necessary to avoid this resonance.
    34	
    35	ACPI interface
    36	==============
    37	
    38	Although initially used by for wifi + dGPU use cases, the ACPI interface
    39	can be scaled to any type of device that a platform designer discovers
    40	can cause interference.
    41	
    42	The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
    43	
    44	3 functions are available in this _DSM:
    45	
    46	* 0: discover # of functions available
    47	* 1: record RF bands in use
    48	* 2: retrieve RF bands in use
    49	
    50	Driver programming interface
    51	============================
    52	
    53	.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
    54	
    55	Sample Usage
    56	=============
    57	
    58	The expected flow for the producers:
    59	1. During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
    60	   can be enabled for the device.
  > 61	2. On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
    62	   param to get other consumers properly notified.
    63	3. Or on stopping using some frequency band, call
    64	   `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
    65	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
