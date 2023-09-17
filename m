Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097E07A36B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIQRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjIQREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:04:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55D185;
        Sun, 17 Sep 2023 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694970277; x=1726506277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUdRrCzCzrzZX5qO19ypnvIUs5uI+f7tFWK36JaomuM=;
  b=Doyn3C4Fc2L9R1TgoWWWHONQrVVZW53vuVxxSP6k0yO3mQNeFyt/3kw8
   ifShEA6BcUOTrKERV8RoPhnJud/ajhWdCacmYhtME9D9keZXTZEywgQ+W
   gD/3Yi3H1DdMlJQdG0lAO1yS5oqHVfuuW16wgYx1d9woYfseAek+6ZiUW
   q3dFl95tysgacfql8iaZR+SJyBxJRpsOlXiDk+vamwVZ5J56ACJX2G3RP
   2PZlPIACSyIP2ETytWzERva11Y6WoUL862nvXy2qX232yJGxtC75KpTHQ
   SWDVDm6XErcwTDHEpxgWWOJkjhIuVRXzmJQ/HsMLRKOeLoqe/B8vGnaDG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382247954"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="382247954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 10:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="774882915"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="774882915"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2023 10:04:32 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhvCA-0005Lc-0u;
        Sun, 17 Sep 2023 17:04:30 +0000
Date:   Mon, 18 Sep 2023 01:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>, heikki.krogerus@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, abdelalkuor@geotab.com
Subject: Re: [PATCH v5 04/15] USB: typec: Load TPS25750 patch bundle
Message-ID: <202309180034.fV0JkOAu-lkp@intel.com>
References: <20230917152639.21443-5-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-5-alkuor@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abdel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdel-Alkuor/dt-bindings-usb-tps6598x-Add-tps25750/20230917-233037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230917152639.21443-5-alkuor%40gmail.com
patch subject: [PATCH v5 04/15] USB: typec: Load TPS25750 patch bundle
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230918/202309180034.fV0JkOAu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230918/202309180034.fV0JkOAu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309180034.fV0JkOAu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/usb/typec/tipd/core.c:9:
   drivers/usb/typec/tipd/core.c: In function 'tps25750_start_patch_burst_mode':
>> drivers/usb/typec/tipd/core.c:844:35: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     844 |                 dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/usb/typec/tipd/core.c:844:17: note: in expansion of macro 'dev_err'
     844 |                 dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |                 ^~~~~~~
   drivers/usb/typec/tipd/core.c:844:66: note: format string is defined here
     844 |                 dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
         |                                                                ~~^
         |                                                                  |
         |                                                                  long unsigned int
         |                                                                %u


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
