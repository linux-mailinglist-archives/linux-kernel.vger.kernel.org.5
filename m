Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5845A7A36D6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjIQR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjIQRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:25:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB0129;
        Sun, 17 Sep 2023 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694971537; x=1726507537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ENv6ZjlIdXEExHDoykoerWZ3HKSu0pMx/fFt1/9mHTQ=;
  b=XqDrpaDQziB4HsjkV7ShmDnJ41C44Z5/pTiCt1OJHqxmP7719yU2ti0b
   srx2W6Es2R/Gk1bj87D86KyUDcLzI4nh7fWHtj9Lce8Wn6jwnps2dRXNf
   5ekN9TdJMd106MJxoBwEgIIf+Y/WMywBDUebnsIb49tsvIdXD7MHLIRHp
   dazLT6g6ebXcUc/FdmGvBcvzMO93dVHs9tezpdmW0zwfT/AdiBJPiVL6C
   JZ8NcTFXzbpZi1lSNMKPaPbdlpO/yp/P6zUjqR2r0h9HQQ9j7X9Pa7c+D
   57FhnmwSNwFYEdD9i2kIVbrke4WvVFsoGZgF7mJFzGuGNphzscBukNDSo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="376835043"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="376835043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 10:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="774885484"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="774885484"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2023 10:25:33 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhvWU-0005MK-2l;
        Sun, 17 Sep 2023 17:25:30 +0000
Date:   Mon, 18 Sep 2023 01:24:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>, heikki.krogerus@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, abdelalkuor@geotab.com
Subject: Re: [PATCH v5 04/15] USB: typec: Load TPS25750 patch bundle
Message-ID: <202309180124.ZkZ5E7oC-lkp@intel.com>
References: <20230917152639.21443-5-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-5-alkuor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abdel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdel-Alkuor/dt-bindings-usb-tps6598x-Add-tps25750/20230917-233037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230917152639.21443-5-alkuor%40gmail.com
patch subject: [PATCH v5 04/15] USB: typec: Load TPS25750 patch bundle
config: i386-buildonly-randconfig-006-20230917 (https://download.01.org/0day-ci/archive/20230918/202309180124.ZkZ5E7oC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230918/202309180124.ZkZ5E7oC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309180124.ZkZ5E7oC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/usb/typec/tipd/core.c:9:
   drivers/usb/typec/tipd/core.c: In function 'tps25750_start_patch_burst_mode':
>> drivers/usb/typec/tipd/core.c:844:21: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'const unsigned int'} [-Wformat=]
     844 |   dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:144:49: note: in expansion of macro 'dev_fmt'
     144 |  dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                 ^~~~~~~
   drivers/usb/typec/tipd/core.c:844:3: note: in expansion of macro 'dev_err'
     844 |   dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |   ^~~~~~~
   drivers/usb/typec/tipd/core.c:844:52: note: format string is defined here
     844 |   dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |                                                  ~~^
         |                                                    |
         |                                                    long unsigned int
         |                                                  %u


vim +844 drivers/usb/typec/tipd/core.c

   801	
   802	static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
   803	{
   804		int ret;
   805		const struct firmware *fw;
   806		const char *firmware_name;
   807		struct {
   808			u32 fw_size;
   809			u8 addr;
   810			u8 timeout;
   811		} __packed bpms_data;
   812	
   813		ret = device_property_read_string(tps->dev, "firmware-name",
   814						  &firmware_name);
   815		if (ret)
   816			return ret;
   817	
   818		ret = request_firmware(&fw, firmware_name, tps->dev);
   819		if (ret) {
   820			dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
   821			return ret;
   822		}
   823	
   824		if (fw->size == 0) {
   825			ret = -EINVAL;
   826			goto release_fw;
   827		}
   828	
   829		ret = device_property_read_u8(tps->dev, "ti,patch-address", &bpms_data.addr);
   830		if (ret) {
   831			dev_err(tps->dev, "failed to get patch address\n");
   832			return ret;
   833		}
   834	
   835		bpms_data.fw_size = fw->size;
   836		bpms_data.timeout = TPS_BUNDLE_TIMEOUT;
   837	
   838		ret = tps25750_exec_pbms(tps, (u8 *)&bpms_data, sizeof(bpms_data));
   839		if (ret)
   840			goto release_fw;
   841	
   842		ret = tps25750_write_firmware(tps, bpms_data.addr, fw->data, fw->size);
   843		if (ret) {
 > 844			dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
   845				firmware_name, fw->size);
   846			goto release_fw;
   847		}
   848	
   849		/*
   850		 * A delay of 500us is required after the firmware is written
   851		 * based on pg.62 in tps6598x Host Interface Technical
   852		 * Reference Manual
   853		 * https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
   854		 */
   855		udelay(500);
   856	
   857	release_fw:
   858		release_firmware(fw);
   859	
   860		return ret;
   861	}
   862	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
