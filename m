Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CC7ABC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjIWAGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIWAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:06:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F991A8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695427604; x=1726963604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9pZkepKP2RW6FPHyL255GvZV7UBZds/BAyBAw4eBSUE=;
  b=B22J7KABaj7ImSYIkFGMum3GmYmHsGgLafIbD1H7hzjljIeCdsvgcIgW
   sMQXn0Cl4bAVNRkdgnwc3MCpgc3exTF4FxMW3vbibGwSzStspVsQZIXI+
   yUPu3UO2VsRqnO3bcOQIUsrLtC+5v9bbkkDIcUk1wDeTRRrzsWwsFjeSh
   wKatvavt15n5iIo4IbC9BsRjj2wnAzM+LvOxua68ie+ksrRpBTEtf/nI+
   GrM8IMyT/T4lJ3Jvt9rkGfljlBBkNIXnm/BbF2XIk1ialkIMBgidOr54w
   w1IZ8n0JqaPuVTmXDxESJdbXJZLYhAVAGfEuRNsOISOP1GO1klDZxGPY6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383728557"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="383728557"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 17:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="921355837"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="921355837"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2023 17:06:42 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjqAS-0001VJ-1K;
        Sat, 23 Sep 2023 00:06:40 +0000
Date:   Sat, 23 Sep 2023 08:06:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/soc/codecs/ak4642.c:646:24: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202309230808.muWc0Phh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8018e02a87031a5e8afcbd9d35133edd520076bb
commit: 3cd8cc98d63492f6f69edd4486c9bd1fe29f91c3 platform/x86: Drop the PMC_ATOM Kconfig option
date:   1 year, 3 months ago
config: i386-randconfig-061-20230923 (https://download.01.org/0day-ci/archive/20230923/202309230808.muWc0Phh-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230808.muWc0Phh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230808.muWc0Phh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/ak4642.c:646:24: sparse: sparse: Using plain integer as NULL pointer

vim +646 sound/soc/codecs/ak4642.c

171a0138ab75fc Kuninori Morimoto 2015-09-10  631  
27204ca8b98116 Kiran Padwal      2014-07-28  632  static const struct of_device_id ak4642_of_match[];
e654a1331f6855 Stephen Kitt      2022-04-15  633  static const struct i2c_device_id ak4642_i2c_id[];
e654a1331f6855 Stephen Kitt      2022-04-15  634  static int ak4642_i2c_probe(struct i2c_client *i2c)
a3a83d9a7cb0ce Kuninori Morimoto 2009-08-21  635  {
2719a752b6e96b Kuninori Morimoto 2015-09-10  636  	struct device *dev = &i2c->dev;
2719a752b6e96b Kuninori Morimoto 2015-09-10  637  	struct device_node *np = dev->of_node;
d815c703cedbc7 Sascha Hauer      2014-05-14  638  	const struct ak4642_drvdata *drvdata = NULL;
4574cd94a717ef Mark Brown        2013-11-28  639  	struct regmap *regmap;
d815c703cedbc7 Sascha Hauer      2014-05-14  640  	struct ak4642_priv *priv;
171a0138ab75fc Kuninori Morimoto 2015-09-10  641  	struct clk *mcko = NULL;
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  642  
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  643  	if (np) {
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  644  		const struct of_device_id *of_id;
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  645  
171a0138ab75fc Kuninori Morimoto 2015-09-10 @646  		mcko = ak4642_of_parse_mcko(dev);
171a0138ab75fc Kuninori Morimoto 2015-09-10  647  		if (IS_ERR(mcko))
171a0138ab75fc Kuninori Morimoto 2015-09-10  648  			mcko = NULL;
171a0138ab75fc Kuninori Morimoto 2015-09-10  649  
2719a752b6e96b Kuninori Morimoto 2015-09-10  650  		of_id = of_match_device(ak4642_of_match, dev);
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  651  		if (of_id)
d815c703cedbc7 Sascha Hauer      2014-05-14  652  			drvdata = of_id->data;
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  653  	} else {
e654a1331f6855 Stephen Kitt      2022-04-15  654  		const struct i2c_device_id *id =
e654a1331f6855 Stephen Kitt      2022-04-15  655  			i2c_match_id(ak4642_i2c_id, i2c);
d815c703cedbc7 Sascha Hauer      2014-05-14  656  		drvdata = (const struct ak4642_drvdata *)id->driver_data;
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  657  	}
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  658  
d815c703cedbc7 Sascha Hauer      2014-05-14  659  	if (!drvdata) {
2719a752b6e96b Kuninori Morimoto 2015-09-10  660  		dev_err(dev, "Unknown device type\n");
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  661  		return -EINVAL;
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  662  	}
bbf1453e28e4e3 Kuninori Morimoto 2013-01-10  663  
2719a752b6e96b Kuninori Morimoto 2015-09-10  664  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
d815c703cedbc7 Sascha Hauer      2014-05-14  665  	if (!priv)
d815c703cedbc7 Sascha Hauer      2014-05-14  666  		return -ENOMEM;
d815c703cedbc7 Sascha Hauer      2014-05-14  667  
d815c703cedbc7 Sascha Hauer      2014-05-14  668  	priv->drvdata = drvdata;
171a0138ab75fc Kuninori Morimoto 2015-09-10  669  	priv->mcko = mcko;
d815c703cedbc7 Sascha Hauer      2014-05-14  670  
d815c703cedbc7 Sascha Hauer      2014-05-14  671  	i2c_set_clientdata(i2c, priv);
d815c703cedbc7 Sascha Hauer      2014-05-14  672  
d815c703cedbc7 Sascha Hauer      2014-05-14  673  	regmap = devm_regmap_init_i2c(i2c, drvdata->regmap_config);
4574cd94a717ef Mark Brown        2013-11-28  674  	if (IS_ERR(regmap))
4574cd94a717ef Mark Brown        2013-11-28  675  		return PTR_ERR(regmap);
4574cd94a717ef Mark Brown        2013-11-28  676  
43c5d0f05ec55a Kuninori Morimoto 2018-01-29  677  	return devm_snd_soc_register_component(dev,
43c5d0f05ec55a Kuninori Morimoto 2018-01-29  678  				&soc_component_dev_ak4642, &ak4642_dai, 1);
a3a83d9a7cb0ce Kuninori Morimoto 2009-08-21  679  }
a3a83d9a7cb0ce Kuninori Morimoto 2009-08-21  680  

:::::: The code at line 646 was first introduced by commit
:::::: 171a0138ab75fcbe1228c4af0442221efccfb197 ASoC: ak4642: enable to use MCKO as fixed rate output pin on DT

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
