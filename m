Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34A97BBF6C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjJFS6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjJFS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:58:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D4095;
        Fri,  6 Oct 2023 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696618711; x=1728154711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ymqImOnv0wl2htFtjpK9gz4sQkzAgOOPROIzfULzwbM=;
  b=LFb+E+PiZpAlxV4XgZ+3YqUyzCy3ffzjOzdKEuxrHkHwW6PS1L12otzj
   Qbelmv4OfBBVz1n7XOS7/7bpCGDfOL1uybhv7vj3iC9jWAjuBUaaD94/4
   we+SyaImcipst+G54931qdkwh2bnT5HPTfp8AvexmUEvGFj8Cq6EYJsWT
   jmZPaDMbtUWoY98JqrTP3Dp0TNb1DPqZ8AGmjiBcx2i29WMWzjb3B+Dso
   R7z6UX1IapmoqUSK7e/brKxNxjcBaw7xU/O+W04uSmQy1MsaV2uHHLJv1
   xjDJAgPfynOMRv8TC30XUw8f4hoCAdDGzy1G8doDm2sxqw0bbtqW2KgmX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="381092073"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="381092073"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787479120"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="787479120"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2023 11:58:27 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoq1p-0003YH-1m;
        Fri, 06 Oct 2023 18:58:25 +0000
Date:   Sat, 7 Oct 2023 02:57:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: xo15-ebook: Replace open coded
 acpi_match_device()
Message-ID: <202310070210.fA8JzLkG-lkp@intel.com>
References: <20231006153152.3502912-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006153152.3502912-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/platform-x86-xo15-ebook-Replace-open-coded-acpi_match_device/20231006-233327
base:   linus/master
patch link:    https://lore.kernel.org/r/20231006153152.3502912-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_device()
config: i386-buildonly-randconfig-003-20231007 (https://download.01.org/0day-ci/archive/20231007/202310070210.fA8JzLkG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070210.fA8JzLkG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070210.fA8JzLkG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/xo15-ebook.c: In function 'ebook_switch_add':
>> drivers/platform/x86/xo15-ebook.c:105:50: error: passing argument 2 of 'acpi_match_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     105 |         id = acpi_match_device(ebook_device_ids, device);
         |                                                  ^~~~~~
         |                                                  |
         |                                                  struct acpi_device *
   In file included from drivers/platform/x86/xo15-ebook.c:17:
   include/linux/acpi.h:712:69: note: expected 'const struct device *' but argument is of type 'struct acpi_device *'
     712 |                                                const struct device *dev);
         |                                                ~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/acpi_match_device +105 drivers/platform/x86/xo15-ebook.c

    81	
    82	static int ebook_switch_add(struct acpi_device *device)
    83	{
    84		const struct acpi_device_id *id;
    85		struct ebook_switch *button;
    86		struct input_dev *input;
    87		char *name, *class;
    88		int error;
    89	
    90		button = kzalloc(sizeof(struct ebook_switch), GFP_KERNEL);
    91		if (!button)
    92			return -ENOMEM;
    93	
    94		device->driver_data = button;
    95	
    96		button->input = input = input_allocate_device();
    97		if (!input) {
    98			error = -ENOMEM;
    99			goto err_free_button;
   100		}
   101	
   102		name = acpi_device_name(device);
   103		class = acpi_device_class(device);
   104	
 > 105		id = acpi_match_device(ebook_device_ids, device);
   106		if (!id) {
   107			dev_err(&device->dev, "Unsupported hid\n");
   108			error = -ENODEV;
   109			goto err_free_input;
   110		}
   111	
   112		strcpy(name, XO15_EBOOK_DEVICE_NAME);
   113		sprintf(class, "%s/%s", XO15_EBOOK_CLASS, XO15_EBOOK_SUBCLASS);
   114	
   115		snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
   116	
   117		input->name = name;
   118		input->phys = button->phys;
   119		input->id.bustype = BUS_HOST;
   120		input->dev.parent = &device->dev;
   121	
   122		input->evbit[0] = BIT_MASK(EV_SW);
   123		set_bit(SW_TABLET_MODE, input->swbit);
   124	
   125		error = input_register_device(input);
   126		if (error)
   127			goto err_free_input;
   128	
   129		ebook_send_state(device);
   130	
   131		if (device->wakeup.flags.valid) {
   132			/* Button's GPE is run-wake GPE */
   133			acpi_enable_gpe(device->wakeup.gpe_device,
   134					device->wakeup.gpe_number);
   135			device_set_wakeup_enable(&device->dev, true);
   136		}
   137	
   138		return 0;
   139	
   140	 err_free_input:
   141		input_free_device(input);
   142	 err_free_button:
   143		kfree(button);
   144		return error;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
