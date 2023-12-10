Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE380B85F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 03:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjLJCDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 21:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 21:03:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9910C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 18:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702173800; x=1733709800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPSa+EqqbwYkScTEXGKik/E61oTp1OD7T/v2f6DAEvI=;
  b=iU/K6QN1LiXxgAEWyAMX73eoRqRYr9i0zgtbt2/v8MNXvNnPquFn0j8q
   G520KKbUp20k0MdjLxjFxoESwH4g62WUHI3ZETegtzg5K7Ate2ZGIC3Tl
   y7byIoZZwclSnFS7/rmXKL6OwMIT3bJHltlq0ntcpnLwY24StUuiH/LXF
   mBkaZTdkKZR97TGuqQ7O5jk1AeRl70hh1GNQa1lKoNHwSxXAg+4J63JLQ
   1wsH9qLb1Ay8ZGxMUoU8kHQLiWWXVb4q4Gmna7XVDu851zQNbBqyB43xD
   rbtUFeU2jou28aHxPzAxndRorC6nNHhlkNfhiydbNM6PaRQVuBUmoWjgH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="7892381"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="7892381"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 18:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748776727"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="748776727"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2023 18:03:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC9A1-000GGl-0n;
        Sun, 10 Dec 2023 02:03:13 +0000
Date:   Sun, 10 Dec 2023 10:02:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Message-ID: <202312100942.CvTnDpkg-lkp@intel.com>
References: <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gergo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ffc253263a1375a65fa6c9f62a893e9767fbebfa]

url:    https://github.com/intel-lab-lkp/linux/commits/Gergo-Koteles/ASoc-tas2563-DSP-Firmware-loading-support/20231205-074901
base:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
patch link:    https://lore.kernel.org/r/4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer%40irl.hu
patch subject: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
config: x86_64-randconfig-r121-20231210 (https://download.01.org/0day-ci/archive/20231210/202312100942.CvTnDpkg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100942.CvTnDpkg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100942.CvTnDpkg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long __ms @@     got restricted __be16 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:21:9: sparse:     expected unsigned long __ms
   sound/soc/codecs/tas25xx-dsp.c:21:9: sparse:     got restricted __be16 [usertype]
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:21:9: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:28:26: sparse: sparse: incorrect type in initializer (different base types) @@     expected int num_writes @@     got restricted __be16 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:28:26: sparse:     expected int num_writes
   sound/soc/codecs/tas25xx-dsp.c:28:26: sparse:     got restricted __be16 [usertype]
>> sound/soc/codecs/tas25xx-dsp.c:65:33: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long [usertype] val_count @@     got restricted __be16 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:65:33: sparse:     expected unsigned long [usertype] val_count
   sound/soc/codecs/tas25xx-dsp.c:65:33: sparse:     got restricted __be16 [usertype]
   sound/soc/codecs/tas25xx-dsp.c:84:30: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:87:30: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:82:17: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:82:17: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:82:17: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:103:17: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:103:17: sparse: sparse: restricted __be16 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:103:17: sparse: sparse: restricted __be16 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:141:24: sparse: sparse: restricted __be32 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:145:24: sparse: sparse: invalid assignment: +=
>> sound/soc/codecs/tas25xx-dsp.c:145:24: sparse:    left side has type int
>> sound/soc/codecs/tas25xx-dsp.c:145:24: sparse:    right side has type restricted __be32
   sound/soc/codecs/tas25xx-dsp.c:150:35: sparse: sparse: restricted __be32 degrades to integer
>> sound/soc/codecs/tas25xx-dsp.c:151:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected int num_subblocks @@     got restricted __be32 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:151:29: sparse:     expected int num_subblocks
   sound/soc/codecs/tas25xx-dsp.c:151:29: sparse:     got restricted __be32 [usertype]
   sound/soc/codecs/tas25xx-dsp.c:182:26: sparse: sparse: restricted __be32 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:186:24: sparse: sparse: invalid assignment: +=
   sound/soc/codecs/tas25xx-dsp.c:186:24: sparse:    left side has type int
   sound/soc/codecs/tas25xx-dsp.c:186:24: sparse:    right side has type restricted __be32
   sound/soc/codecs/tas25xx-dsp.c:191:35: sparse: sparse: restricted __be32 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:192:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected int num_subblocks @@     got restricted __be32 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:192:29: sparse:     expected int num_subblocks
   sound/soc/codecs/tas25xx-dsp.c:192:29: sparse:     got restricted __be32 [usertype]
   sound/soc/codecs/tas25xx-dsp.c:238:29: sparse: sparse: restricted __be32 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:239:31: sparse: sparse: invalid assignment: +=
>> sound/soc/codecs/tas25xx-dsp.c:239:31: sparse:    left side has type unsigned int
   sound/soc/codecs/tas25xx-dsp.c:239:31: sparse:    right side has type restricted __be32
   sound/soc/codecs/tas25xx-dsp.c:241:29: sparse: sparse: restricted __be32 degrades to integer
   sound/soc/codecs/tas25xx-dsp.c:242:33: sparse: sparse: invalid assignment: +=
   sound/soc/codecs/tas25xx-dsp.c:242:33: sparse:    left side has type unsigned int
   sound/soc/codecs/tas25xx-dsp.c:242:33: sparse:    right side has type restricted __be32
>> sound/soc/codecs/tas25xx-dsp.c:260:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] prog_num @@     got restricted __be32 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:260:18: sparse:     expected unsigned int [usertype] prog_num
   sound/soc/codecs/tas25xx-dsp.c:260:18: sparse:     got restricted __be32 [usertype]
>> sound/soc/codecs/tas25xx-dsp.c:261:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] config_num @@     got restricted __be32 [usertype] @@
   sound/soc/codecs/tas25xx-dsp.c:261:20: sparse:     expected unsigned int [usertype] config_num
   sound/soc/codecs/tas25xx-dsp.c:261:20: sparse:     got restricted __be32 [usertype]
--
>> sound/pci/hda/tas2563_hda_i2c.c:325:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   sound/pci/hda/tas2563_hda_i2c.c:325:37: sparse:     expected unsigned int
   sound/pci/hda/tas2563_hda_i2c.c:325:37: sparse:     got restricted __be32 [usertype]

vim +325 sound/pci/hda/tas2563_hda_i2c.c

   306	
   307	/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
   308	 * Calibrate data is done by manufacturer in the factory. These data are used
   309	 * by Algo for calucating the speaker temperature, speaker membrance excursion
   310	 * and f0 in real time during playback.
   311	 */
   312	static int tas2563_tasdev_read_efi(struct tas2563_data *tas2563,
   313		struct tas2563_dev *tasdev)
   314	{
   315		efi_status_t status;
   316		unsigned int attr;
   317		unsigned long max_size = TAS2563_CAL_DATA_SIZE;
   318	
   319		for (int i = 0; i < TAS2563_CAL_N; ++i) {
   320			status = efi.get_variable(efi_var_names[tasdev->dev_id][i],
   321				&efi_guid, &attr, &max_size,
   322				&tasdev->cal_data[i]);
   323			if (status != EFI_SUCCESS)
   324				return -EINVAL;
 > 325			tasdev->cal_data[i] = cpu_to_be32(tasdev->cal_data[i]);
   326		}
   327	
   328		dev_info(tas2563->dev,
   329			"Calibration data %d: power:%08x r0:%08x inv_r0:%08x r0_low:%08x tlim:%08x\n",
   330			tasdev->dev_id, tasdev->cal_data[0], tasdev->cal_data[1],
   331			tasdev->cal_data[2], tasdev->cal_data[3], tasdev->cal_data[4]);
   332	
   333		return 0;
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
