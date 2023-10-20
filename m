Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5497D13C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjJTQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:13:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80685114;
        Fri, 20 Oct 2023 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697818417; x=1729354417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eWAftVHC6HQVNtnpPsRWMbqa+BXYoeOA9V5JeSTXPSw=;
  b=mvijJ6uPkYnQA0UrE4t5QRRloe560suYdVFJnAxx8le/Bps88SfyTycP
   C0wN5WTWMq2RrKcblV6vPceHpK1bMoZJ6ziUNL1YthBJdODRL4sC39fQ9
   0uAZUamkdWWekHOH+OMsJfbCHaHRERI0GTtQ+fWj77RMH0QPpgxbpzW+e
   PLMswcuUgM0v9yOD+JF9AeGeudoybLjsF8+68jsHNUR2z6zbb5f7C2Yqj
   b4KDYOdoEv9yaAlZFS1qGK/SFIjUIdtEBzizM4oXbQdno36VOWAvszTKP
   0id8WFzZ9jbcO+RgwvRHTEyhbggHl0oyJ+xZWA+rW0oyCz3JkMEMKIgrz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8088547"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8088547"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5427967"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Oct 2023 09:13:19 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qts7g-0003k2-0n;
        Fri, 20 Oct 2023 16:13:16 +0000
Date:   Sat, 21 Oct 2023 00:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Ai Chao <aichao@kylinos.cn>
Subject: Re: [PATCH v2] platform/x86: support to store/show powermode value
 for Inspur
Message-ID: <202310202354.NjaAKTX2-lkp@intel.com>
References: <20231014032844.3823198-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014032844.3823198-1-aichao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ai-Chao/platform-x86-support-to-store-show-powermode-value-for-Inspur/20231017-125537
base:   linus/master
patch link:    https://lore.kernel.org/r/20231014032844.3823198-1-aichao%40kylinos.cn
patch subject: [PATCH v2] platform/x86: support to store/show powermode value for Inspur
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310202354.NjaAKTX2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310202354.NjaAKTX2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310202354.NjaAKTX2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/inspur-wmi.c:70: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
   drivers/platform/x86/inspur-wmi.c:111: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,


vim +70 drivers/platform/x86/inspur-wmi.c

    68	
    69	/**
  > 70	 * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
    71	 * return error
    72	 * Method ID: 0x3
    73	 * Arg: 4 Bytes
    74	 * Byte [0]: Power Mode:
    75	 *         0x0: Balance Mode
    76	 *         0x1: Performance Mode
    77	 *         0x2: Power Saver Mode
    78	 * Return Value: 4 Bytes
    79	 * Byte [0]: Return Code
    80	 *         0x0: No Error
    81	 *         0x1: Error
    82	 */
    83	static ssize_t powermode_store(struct device *dev,
    84				       struct device_attribute *attr,
    85				       const char *buf, size_t count)
    86	{
    87		struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
    88		int ret;
    89		u32 mode;
    90		u8 *ret_code;
    91	
    92		ret = kstrtoint(buf, 0, &mode);
    93		if (ret)
    94			return ret;
    95	
    96		ret = inspur_wmi_perform_query(priv->wdev,
    97					       INSPUR_WMI_SET_POWERMODE,
    98					       &mode, sizeof(mode), sizeof(mode));
    99	
   100		if (ret < 0)
   101			return ret;
   102	
   103		ret_code = (u8 *)(&mode);
   104		if (ret_code[0])
   105			return -EBADRQC;
   106	
   107		return count;
   108	}
   109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
