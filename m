Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B777DFC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377456AbjKBWUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:20:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC33F0;
        Thu,  2 Nov 2023 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698963598; x=1730499598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pOomK60vReoHoxtpV622grZQ+xKJAZalF61nf6xRPAw=;
  b=JayFoCKIfHsNbnTUatfzK6rIetAxVx/N6+yf2Dz3TIMj5bqpBwXj0c97
   ormbuzHvE9KS1Sr5wClAf+fRG6i9uo9vkXjtKzeLffGZvx+Il8kEDgYNB
   lH74c9RbilYZ8umnzGrajLlTWw5+/qR2omXql6P+w5EWeIqpzKAZnhQU6
   oEWvnreesG7OXyxWZ76s7gsma3ZCbPBLBxIirldTdD3lzks4fBrlKfZYF
   5dcQO+U5st6mXBS4jqQaE3ETAkdW5FCrRdQxOECwSd0zvi5zNmU07f9Fv
   VaB+qnrdESJ81tCN32ntXLfJ1dJuYhlJxaHQMP8+yFibcYL6NUbg5VJ1w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387718234"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387718234"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="885020179"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="885020179"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2023 15:11:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyfuX-0001ui-02;
        Thu, 02 Nov 2023 22:11:33 +0000
Date:   Fri, 3 Nov 2023 06:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viacheslav Bocharov <adeep@lexina.in>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] firmware: meson_sm: Add chipid number sysfs entry
Message-ID: <202311030513.HxyDUCuc-lkp@intel.com>
References: <20231102074916.3280809-3-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102074916.3280809-3-adeep@lexina.in>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231102074916.3280809-3-adeep%40lexina.in
patch subject: [PATCH 2/4] firmware: meson_sm: Add chipid number sysfs entry
config: arm64-randconfig-003-20231103 (https://download.01.org/0day-ci/archive/20231103/202311030513.HxyDUCuc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030513.HxyDUCuc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030513.HxyDUCuc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/meson/meson_sm.c: In function 'chipid_show':
>> drivers/firmware/meson/meson_sm.c:315:17: error: 'ch' undeclared (first use in this function)
     315 |                 ch = (uint8_t *)(id_buf + 4);
         |                 ^~
   drivers/firmware/meson/meson_sm.c:315:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/firmware/meson/meson_sm.c:316:22: error: 'i' undeclared (first use in this function)
     316 |                 for (i = 0; i < 12; i++)
         |                      ^


vim +/ch +315 drivers/firmware/meson/meson_sm.c

   277	
   278	static ssize_t chipid_show(struct device *dev, struct device_attribute *attr,
   279				 char *buf)
   280	{
   281		struct platform_device *pdev = to_platform_device(dev);
   282		struct meson_sm_firmware *fw;
   283		uint8_t *id_buf;
   284		int ret;
   285	
   286		fw = platform_get_drvdata(pdev);
   287	
   288		id_buf = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
   289		if (!id_buf)
   290			return -ENOMEM;
   291	
   292		ret = meson_sm_call_read(fw, id_buf, SM_CHIP_ID_LENGTH, SM_GET_CHIP_ID,
   293					 2, 0, 0, 0, 0);
   294		if (ret < 0) {
   295			kfree(id_buf);
   296			return ret;
   297		}
   298	
   299		int version = *((unsigned int *)id_buf);
   300	
   301		if (version == 2)
   302			ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
   303		else {
   304			/**
   305			 * Legacy 12-byte chip ID read out, transform data
   306			 * to expected order format.
   307			 */
   308			uint8_t *buff;
   309	
   310			buff = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
   311			if (!buff)
   312				return -ENOMEM;
   313			((uint32_t *)buff)[0] = 0; // CPU_ID is empty
   314			/* Transform into expected order for display */
 > 315			ch = (uint8_t *)(id_buf + 4);
 > 316			for (i = 0; i < 12; i++)
   317				buff[i + 4] = ch[11 - i];
   318			ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &buff);
   319			kfree(buff);
   320		}
   321	
   322		kfree(id_buf);
   323		return ret;
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
