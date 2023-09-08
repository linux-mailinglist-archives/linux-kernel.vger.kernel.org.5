Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4731B7991A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjIHVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjIHVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:49:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B0E45
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694209774; x=1725745774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ugbmmZHWI8UpAx4ybKJuqBElMoFDfDGro8HHktoWgQY=;
  b=l4I4zvx/EzhNmsNj155KeeuTCGWNycGgALo+ph5CGKIV8ctCrF/FeQBH
   q1nAUPhvz9ApBJIoOH+bJYw1BjLdlhZrdxhFNNKTlrfg/4VODfLcqigEy
   b3SGmoYs8SDkJYlsBus43iLm4A+rz06D7DnV10kSThZTXQhogUvGimer8
   dirNPpFW+zeXdh4xazxZ59zE9/MDDLSQ7NbPL180K7AM9ZItm2sE1Ttqa
   HTB7Z+yYu0Wotxf49pNh7mhoEcvd0QBhXS8JCkM8ANPw9Ty0UMWtcKb4o
   bfhf1XnMc9jnHyubn91b9asaZ6mEVmLhyi1z/FvjZrR/V/GoQWXtVp/27
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357219723"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="357219723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="885811725"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="885811725"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2023 14:49:14 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qejM1-0002di-1F;
        Fri, 08 Sep 2023 21:49:29 +0000
Date:   Sat, 9 Sep 2023 05:48:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ALSA: hda: cs35l41: Support mute notifications
 for CS35L41 HDA
Message-ID: <202309090555.tnWpQ7Gh-lkp@intel.com>
References: <20230908133421.2483508-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908133421.2483508-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master next-20230908]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/ALSA-hda-cs35l41-Support-mute-notifications-for-CS35L41-HDA/20230908-213735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230908133421.2483508-2-sbinding%40opensource.cirrus.com
patch subject: [PATCH v2 1/2] ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA
config: riscv-randconfig-001-20230909 (https://download.01.org/0day-ci/archive/20230909/202309090555.tnWpQ7Gh-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090555.tnWpQ7Gh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090555.tnWpQ7Gh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/pci/hda/patch_realtek.c:6718:31: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
                                                      ^
   sound/pci/hda/patch_realtek.c:6718:31: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'acpi_handle' (aka 'void *') [-Wint-conversion]
                           spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/patch_realtek.c:6737:7: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (!acpi_device_handle(adev))
                ^
   sound/pci/hda/patch_realtek.c:6745:41: error: incomplete definition of type 'struct acpi_device'
                   ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
                                                     ~~~~^
   include/linux/acpi.h:790:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   sound/pci/hda/patch_realtek.c:6766:7: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (!acpi_device_handle(adev))
                ^
   sound/pci/hda/patch_realtek.c:6769:39: error: incomplete definition of type 'struct acpi_device'
           ret = acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
                                            ~~~~^
   include/linux/acpi.h:790:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   6 errors generated.


vim +/acpi_device_handle +6718 sound/pci/hda/patch_realtek.c

  6707	
  6708	static void comp_acpi_device_notify(acpi_handle handle, u32 event, void *data)
  6709	{
  6710		struct hda_codec *cdc = data;
  6711		struct alc_spec *spec = cdc->spec;
  6712		int i;
  6713	
  6714		codec_info(cdc, "ACPI Notification %d\n", event);
  6715	
  6716		for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
  6717			if (spec->comps[i].dev && spec->comps[i].acpi_notify)
> 6718				spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
  6719							   spec->comps[i].dev);
  6720		}
  6721	}
  6722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
