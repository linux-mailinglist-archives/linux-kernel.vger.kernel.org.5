Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A727E915D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjKLPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:14:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA752D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699802090; x=1731338090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q0SrsMtwKHarQmZ6jGZ7yh5YwH1syJtrkFTylQhmUkw=;
  b=bPC3+Pda/9ugEpqC8zdJXzdAHkWqlOvQey9MjMaCVJYE8/wi+V0SbME+
   3Sf3+JKJWf+0Kz6YqWpghY/CHrKNe/mqCr1FIm+tiknnibHOZwyroj5ve
   a3cJkV+DaBMx0EhfDMMlU7sDpvcqp2/yakO8c6/kLIo17Iq/tXjVBpL2o
   qTt81+UKYTJG9Now88nX6Nd91Dv2wvZo9Jdhn420LBPI2rghkpRVOTc3P
   zqSeDrhjJTHaAJ+TQiRgvOYjvsp5c2kO4P+V5MVTUQ7WuOCqlMqfA4W7m
   6uUA+0e8uP4Evh/h6Y579QVIJ/66l/CQYSSH45oAry9jKXOEexMM0867g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="454636590"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="454636590"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 07:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="830045599"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="830045599"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2023 07:14:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2CAf-000BEI-0k;
        Sun, 12 Nov 2023 15:14:45 +0000
Date:   Sun, 12 Nov 2023 23:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lin <CTLIN0@nuvoton.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/nau8822.c:199:25: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202311122320.T1opZVkP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b907d0507354b74a4f2c286380cd6059af79248
commit: 1e3cb6c321be2e5295dcaa94c2bf42a43a47a067 ASoC: nau8822: new codec driver
date:   5 years ago
config: x86_64-randconfig-x014-20230805 (https://download.01.org/0day-ci/archive/20231112/202311122320.T1opZVkP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311122320.T1opZVkP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311122320.T1opZVkP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/nau8822.c:199:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] reg_val @@     got restricted __be16 [usertype] @@
   sound/soc/codecs/nau8822.c:199:25: sparse:     expected unsigned short [assigned] [usertype] reg_val
   sound/soc/codecs/nau8822.c:199:25: sparse:     got restricted __be16 [usertype]
>> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
>> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
>> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
>> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16

vim +199 sound/soc/codecs/nau8822.c

   176	
   177	/* The EQ parameters get function is to get the 5 band equalizer control.
   178	 * The regmap raw read can't work here because regmap doesn't provide
   179	 * value format for value width of 9 bits. Therefore, the driver reads data
   180	 * from cache and makes value format according to the endianness of
   181	 * bytes type control element.
   182	 */
   183	static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
   184		struct snd_ctl_elem_value *ucontrol)
   185	{
   186		struct snd_soc_component *component =
   187				snd_soc_kcontrol_component(kcontrol);
   188		struct soc_bytes_ext *params = (void *)kcontrol->private_value;
   189		int i, reg;
   190		u16 reg_val, *val;
   191	
   192		val = (u16 *)ucontrol->value.bytes.data;
   193		reg = NAU8822_REG_EQ1;
   194		for (i = 0; i < params->max / sizeof(u16); i++) {
   195			reg_val = snd_soc_component_read32(component, reg + i);
   196			/* conversion of 16-bit integers between native CPU format
   197			 * and big endian format
   198			 */
 > 199			reg_val = cpu_to_be16(reg_val);
   200			memcpy(val + i, &reg_val, sizeof(reg_val));
   201		}
   202	
   203		return 0;
   204	}
   205	
   206	/* The EQ parameters put function is to make configuration of 5 band equalizer
   207	 * control. These configuration includes central frequency, equalizer gain,
   208	 * cut-off frequency, bandwidth control, and equalizer path.
   209	 * The regmap raw write can't work here because regmap doesn't provide
   210	 * register and value format for register with address 7 bits and value 9 bits.
   211	 * Therefore, the driver makes value format according to the endianness of
   212	 * bytes type control element and writes data to codec.
   213	 */
   214	static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
   215		struct snd_ctl_elem_value *ucontrol)
   216	{
   217		struct snd_soc_component *component =
   218				snd_soc_kcontrol_component(kcontrol);
   219		struct soc_bytes_ext *params = (void *)kcontrol->private_value;
   220		void *data;
   221		u16 *val, value;
   222		int i, reg, ret;
   223	
   224		data = kmemdup(ucontrol->value.bytes.data,
   225			params->max, GFP_KERNEL | GFP_DMA);
   226		if (!data)
   227			return -ENOMEM;
   228	
   229		val = (u16 *)data;
   230		reg = NAU8822_REG_EQ1;
   231		for (i = 0; i < params->max / sizeof(u16); i++) {
   232			/* conversion of 16-bit integers between native CPU format
   233			 * and big endian format
   234			 */
 > 235			value = be16_to_cpu(*(val + i));
   236			ret = snd_soc_component_write(component, reg + i, value);
   237			if (ret) {
   238				dev_err(component->dev,
   239				    "EQ configuration fail, register: %x ret: %d\n",
   240				    reg + i, ret);
   241				kfree(data);
   242				return ret;
   243			}
   244		}
   245		kfree(data);
   246	
   247		return 0;
   248	}
   249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
