Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C07DFD8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjKCAXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCAXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:23:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6D191;
        Thu,  2 Nov 2023 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698970979; x=1730506979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRcO1ajPVbh/cusEJQxYTj2Fddx+LSNylJw5TDJVCgc=;
  b=ZVz2EQip0QDYQyP7OY/hod05adiMbOtWgRL2Yw5aYE3z6cTik8FB56qZ
   zfuHDk96pqM39jIHH4l0b53JNjL9W1uIqXAvM2vee7eEbEFVEQGgrklQK
   C8NhMSmEbh7tnZNCfUzDtz8gs6KzEgvT+unlEhjysq1xSRHCG2FKkjpmo
   UD86OxQiIVnQGgcVFEARpgBisVdJqi7tdIgbZq4xJkSWbbzYzIdjR0soX
   O8/mrzf7TOjRNGvCaCytYPjwC1kiiXrFRPY9YD04D0xBmO8S/n+rBEOEY
   vdf8AUjYrZiq7Cq0QHW0Hk0SMAYQj5DuiDE++dHwSU2u8M4ZvGTtApEGT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391718695"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="391718695"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008651143"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1008651143"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2023 17:22:56 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyhxe-000238-1P;
        Fri, 03 Nov 2023 00:22:54 +0000
Date:   Fri, 3 Nov 2023 08:22:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viacheslav Bocharov <adeep@lexina.in>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/4] firmware: meson_sm: use meson_gx_socinfo for
 compatibility
Message-ID: <202311030839.2qiIuOUl-lkp@intel.com>
References: <20231102074916.3280809-5-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102074916.3280809-5-adeep@lexina.in>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viacheslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.6 next-20231102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Bocharov/firmware-meson-sm-change-sprintf-to-scnprintf/20231102-172556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231102074916.3280809-5-adeep%40lexina.in
patch subject: [PATCH 4/4] firmware: meson_sm: use meson_gx_socinfo for compatibility
config: arm64-randconfig-003-20231103 (https://download.01.org/0day-ci/archive/20231103/202311030839.2qiIuOUl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030839.2qiIuOUl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030839.2qiIuOUl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/meson/meson_sm.c: In function 'chipid_show':
>> drivers/firmware/meson/meson_sm.c:328:19: error: 'uint32' undeclared (first use in this function); did you mean 'uint32_t'?
     328 |                 ((uint32)t *)buff)[0] = 0;
         |                   ^~~~~~
         |                   uint32_t
   drivers/firmware/meson/meson_sm.c:328:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/firmware/meson/meson_sm.c:328:26: error: expected ')' before 't'
     328 |                 ((uint32)t *)buff)[0] = 0;
         |                 ~        ^
         |                          )
>> drivers/firmware/meson/meson_sm.c:328:30: error: expected ';' before 'buff'
     328 |                 ((uint32)t *)buff)[0] = 0;
         |                              ^~~~
         |                              ;
>> drivers/firmware/meson/meson_sm.c:328:34: error: expected statement before ')' token
     328 |                 ((uint32)t *)buff)[0] = 0;
         |                                  ^
>> drivers/firmware/meson/meson_sm.c:328:35: error: expected expression before '[' token
     328 |                 ((uint32)t *)buff)[0] = 0;
         |                                   ^
   drivers/firmware/meson/meson_sm.c:331:17: error: 'ch' undeclared (first use in this function)
     331 |                 ch = (uint8_t *)(id_buf + 4);
         |                 ^~
   drivers/firmware/meson/meson_sm.c:332:22: error: 'i' undeclared (first use in this function)
     332 |                 for (i = 0; i < 12; i++)
         |                      ^


vim +328 drivers/firmware/meson/meson_sm.c

   281	
   282	static ssize_t chipid_show(struct device *dev, struct device_attribute *attr,
   283				 char *buf)
   284	{
   285		struct platform_device *pdev = to_platform_device(dev);
   286		struct meson_sm_firmware *fw;
   287		uint8_t *id_buf;
   288		int ret;
   289	
   290		fw = platform_get_drvdata(pdev);
   291	
   292		id_buf = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
   293		if (!id_buf)
   294			return -ENOMEM;
   295	
   296		ret = meson_sm_call_read(fw, id_buf, SM_CHIP_ID_LENGTH, SM_GET_CHIP_ID,
   297					 2, 0, 0, 0, 0);
   298		if (ret < 0) {
   299			kfree(id_buf);
   300			return ret;
   301		}
   302	
   303		int version = *((unsigned int *)id_buf);
   304	
   305		if (version == 2)
   306			ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
   307		else {
   308			/**
   309			 * Legacy 12-byte chip ID read out, transform data
   310			 * to expected order format.
   311			 */
   312			uint8_t *buff;
   313	
   314			buff = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
   315			if (!buff)
   316				return -ENOMEM;
   317	#ifdef CONFIG_MESON_GX_SOCINFO
   318			uint8_t *ch;
   319			int i;
   320	
   321			((uint32_t *)buff)[0] =
   322				((meson_gx_socinfo & 0xff000000)        |       // Family ID
   323				((meson_gx_socinfo << 8) & 0xff0000)    |       // Chip Revision
   324				((meson_gx_socinfo >> 8) & 0xff00));            // Package ID
   325	
   326			((uint32_t *)buff)[0] = htonl(((uint32_t *)buff)[0]);
   327	#else
 > 328			((uint32)t *)buff)[0] = 0;
   329	#endif
   330			/* Transform into expected order for display */
   331			ch = (uint8_t *)(id_buf + 4);
   332			for (i = 0; i < 12; i++)
   333				buff[i + 4] = ch[11 - i];
   334			ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &buff);
   335			kfree(buff);
   336		}
   337	
   338		kfree(id_buf);
   339		return ret;
   340	}
   341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
