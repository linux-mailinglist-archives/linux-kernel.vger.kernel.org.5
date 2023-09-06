Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1695793D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjIFM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbjIFM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:57:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433A91721
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694005032; x=1725541032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ji2vPvkSoEPWMtRj8ih7XUvtJS058HHiqnFXsSGfi8U=;
  b=TvXUShOwDV1PaK+jEbcjGYkHpZZco3Remwt16pJfynN56Lit/NRNkMWh
   VrPUTw4RJ6+WzpID4GFYTTfLuIVuu5OaBRg0pnKu+v0aXxl/aaxzWNsZR
   VQzI+s90JEq6QrMiwoKlazbGeWWnXYqeLfqF5BhknSaox3R7pUwiQ2LFb
   0O0giU5mJjZ3F1jjrai36Bc27ysA7AOsg/XgVZ9Et7tVWm9jOrQCypf/R
   UMhBflWY5iQYBvG7XiZin9roa12zzSNaEIunkwDQegps8dJZJ5jU27291
   8BekSQduGRDFa4buna6gpTvqtYZ3G4CC5qVKddhBqCuoK9eH/1hHLLnTF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356543038"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="356543038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831650448"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="831650448"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2023 05:57:09 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qds5j-0000EL-1w;
        Wed, 06 Sep 2023 12:57:07 +0000
Date:   Wed, 6 Sep 2023 20:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Support mute notifications for
 CS35L41 HDA
Message-ID: <202309062027.esqlhxcg-lkp@intel.com>
References: <20230825120525.1337417-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825120525.1337417-1-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master next-20230906]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/ALSA-hda-cs35l41-Support-mute-notifications-for-CS35L41-HDA/20230825-200835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230825120525.1337417-1-sbinding%40opensource.cirrus.com
patch subject: [PATCH v1] ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230906/202309062027.esqlhxcg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309062027.esqlhxcg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309062027.esqlhxcg-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/pci/hda/patch_realtek.c: In function 'comp_acpi_device_notify':
>> sound/pci/hda/patch_realtek.c:6717:52: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_fwnode_handle'? [-Werror=implicit-function-declaration]
    6717 |                         spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
         |                                                    ^~~~~~~~~~~~~~~~~~
         |                                                    acpi_fwnode_handle
   sound/pci/hda/patch_realtek.c:6717:52: warning: passing argument 1 of 'spec->comps[i].acpi_notify' makes pointer from integer without a cast [-Wint-conversion]
    6717 |                         spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    int
   sound/pci/hda/patch_realtek.c:6717:52: note: expected 'acpi_handle' {aka 'void *'} but argument is of type 'int'
   sound/pci/hda/patch_realtek.c: In function 'comp_bind':
>> sound/pci/hda/patch_realtek.c:6737:47: error: invalid use of undefined type 'struct acpi_device'
    6737 |         ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
         |                                               ^~
   sound/pci/hda/patch_realtek.c: In function 'comp_unbind':
   sound/pci/hda/patch_realtek.c:6760:46: error: invalid use of undefined type 'struct acpi_device'
    6760 |         ret = acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
         |                                              ^~
   cc1: some warnings being treated as errors


vim +6717 sound/pci/hda/patch_realtek.c

  6706	
  6707	static void comp_acpi_device_notify(acpi_handle handle, u32 event, void *data)
  6708	{
  6709		struct hda_codec *cdc = data;
  6710		struct alc_spec *spec = cdc->spec;
  6711		int i;
  6712	
  6713		codec_info(cdc, "ACPI Notification %d\n", event);
  6714	
  6715		for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
  6716			if (spec->comps[i].dev && spec->comps[i].acpi_notify)
> 6717				spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
  6718							   spec->comps[i].dev);
  6719		}
  6720	}
  6721	
  6722	static int comp_bind(struct device *dev)
  6723	{
  6724		struct hda_codec *cdc = dev_to_hda_codec(dev);
  6725		struct alc_spec *spec = cdc->spec;
  6726		struct acpi_device *adev;
  6727		int ret;
  6728	
  6729		ret = component_bind_all(dev, spec->comps);
  6730		if (ret)
  6731			return ret;
  6732	
  6733		adev = spec->comps[0].adev;
  6734		if (!acpi_device_handle(adev))
  6735			return 0;
  6736	
> 6737		ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
  6738						  comp_acpi_device_notify, cdc);
  6739		if (ret < 0) {
  6740			codec_warn(cdc, "Failed to install notify handler: %d\n", ret);
  6741			return 0;
  6742		}
  6743	
  6744		codec_dbg(cdc, "Notify handler installed\n");
  6745	
  6746		return 0;
  6747	}
  6748	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
