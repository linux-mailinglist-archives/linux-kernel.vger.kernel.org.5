Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEF7995DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbjIIB4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjIIB4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:56:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997751FE7;
        Fri,  8 Sep 2023 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694224603; x=1725760603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hQkwUDsF7jjoxtNktbAorkEzi1GLgiNhqU+nuZFU8JQ=;
  b=j6Pz0Sek0yKbscpusV0iycADwVT9MFivdLW2XSGNZMGARD0Q13Z+8nh/
   qwJ3++DML2JK4052VTI5A2swHdH2LXdeGCJpr71AXI1zJs8t/BHtzS3TB
   zxaoHSAruTUI3T6Uz2JBAmThKxyY2crTCufFiYPUPi3cf/YFOXskmncdW
   iHeFRb4/OP5lWgeR5/BN9TRQgS4cOXFaiYjncFQcqGDpUM0yBEi/kUxxu
   BrcQT8eLShJiA+JHZUE1S7nkyzmgLisJuw8KYYZRDLB3wgqOZJai+acJS
   kg8phWByBk3RL85egBePLC/in7Snz/+yuxEgjNAAcuA0/qteMb4DoyzxD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464152849"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="464152849"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 18:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745800619"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="745800619"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Sep 2023 18:56:40 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qenDB-0002pP-2O;
        Sat, 09 Sep 2023 01:56:37 +0000
Date:   Sat, 9 Sep 2023 09:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 4/6] pinctrl: sprd: Add pinctrl support for UMS512
Message-ID: <202309090904.PsOH9TGp-lkp@intel.com>
References: <20230908055146.18347-5-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-5-Linhua.xu@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linhua,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linhua-Xu/pinctrl-sprd-Modify-the-probe-function-parameters/20230908-135519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230908055146.18347-5-Linhua.xu%40unisoc.com
patch subject: [PATCH V2 4/6] pinctrl: sprd: Add pinctrl support for UMS512
config: alpha-randconfig-r011-20230909 (https://download.01.org/0day-ci/archive/20230909/202309090904.PsOH9TGp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090904.PsOH9TGp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090904.PsOH9TGp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/sprd/pinctrl-sprd.c: In function 'sprd_dt_node_to_map':
>> drivers/pinctrl/sprd/pinctrl-sprd.c:287:15: error: implicit declaration of function 'pinconf_generic_parse_dt_config'; did you mean 'pinconf_generic_dump_config'? [-Werror=implicit-function-declaration]
     287 |         ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               pinconf_generic_dump_config
   cc1: some warnings being treated as errors


vim +287 drivers/pinctrl/sprd/pinctrl-sprd.c

41d32cfce1ae616 Baolin Wang 2017-08-17  246  
41d32cfce1ae616 Baolin Wang 2017-08-17  247  static int sprd_dt_node_to_map(struct pinctrl_dev *pctldev,
41d32cfce1ae616 Baolin Wang 2017-08-17  248  			       struct device_node *np,
41d32cfce1ae616 Baolin Wang 2017-08-17  249  			       struct pinctrl_map **map,
41d32cfce1ae616 Baolin Wang 2017-08-17  250  			       unsigned int *num_maps)
41d32cfce1ae616 Baolin Wang 2017-08-17  251  {
41d32cfce1ae616 Baolin Wang 2017-08-17  252  	struct sprd_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
41d32cfce1ae616 Baolin Wang 2017-08-17  253  	const struct sprd_pin_group *grp;
41d32cfce1ae616 Baolin Wang 2017-08-17  254  	unsigned long *configs = NULL;
41d32cfce1ae616 Baolin Wang 2017-08-17  255  	unsigned int num_configs = 0;
41d32cfce1ae616 Baolin Wang 2017-08-17  256  	unsigned int reserved_maps = 0;
41d32cfce1ae616 Baolin Wang 2017-08-17  257  	unsigned int reserve = 0;
41d32cfce1ae616 Baolin Wang 2017-08-17  258  	const char *function;
41d32cfce1ae616 Baolin Wang 2017-08-17  259  	enum pinctrl_map_type type;
41d32cfce1ae616 Baolin Wang 2017-08-17  260  	int ret;
41d32cfce1ae616 Baolin Wang 2017-08-17  261  
41d32cfce1ae616 Baolin Wang 2017-08-17  262  	grp = sprd_pinctrl_find_group_by_name(pctl, np->name);
41d32cfce1ae616 Baolin Wang 2017-08-17  263  	if (!grp) {
41d32cfce1ae616 Baolin Wang 2017-08-17  264  		dev_err(pctl->dev, "unable to find group for node %s\n",
41d32cfce1ae616 Baolin Wang 2017-08-17  265  			of_node_full_name(np));
41d32cfce1ae616 Baolin Wang 2017-08-17  266  		return -EINVAL;
41d32cfce1ae616 Baolin Wang 2017-08-17  267  	}
41d32cfce1ae616 Baolin Wang 2017-08-17  268  
41d32cfce1ae616 Baolin Wang 2017-08-17  269  	ret = of_property_count_strings(np, "pins");
41d32cfce1ae616 Baolin Wang 2017-08-17  270  	if (ret < 0)
41d32cfce1ae616 Baolin Wang 2017-08-17  271  		return ret;
41d32cfce1ae616 Baolin Wang 2017-08-17  272  
41d32cfce1ae616 Baolin Wang 2017-08-17  273  	if (ret == 1)
41d32cfce1ae616 Baolin Wang 2017-08-17  274  		type = PIN_MAP_TYPE_CONFIGS_PIN;
41d32cfce1ae616 Baolin Wang 2017-08-17  275  	else
41d32cfce1ae616 Baolin Wang 2017-08-17  276  		type = PIN_MAP_TYPE_CONFIGS_GROUP;
41d32cfce1ae616 Baolin Wang 2017-08-17  277  
41d32cfce1ae616 Baolin Wang 2017-08-17  278  	ret = of_property_read_string(np, "function", &function);
41d32cfce1ae616 Baolin Wang 2017-08-17  279  	if (ret < 0) {
41d32cfce1ae616 Baolin Wang 2017-08-17  280  		if (ret != -EINVAL)
41d32cfce1ae616 Baolin Wang 2017-08-17  281  			dev_err(pctl->dev,
41d32cfce1ae616 Baolin Wang 2017-08-17  282  				"%s: could not parse property function\n",
41d32cfce1ae616 Baolin Wang 2017-08-17  283  				of_node_full_name(np));
41d32cfce1ae616 Baolin Wang 2017-08-17  284  		function = NULL;
41d32cfce1ae616 Baolin Wang 2017-08-17  285  	}
41d32cfce1ae616 Baolin Wang 2017-08-17  286  
41d32cfce1ae616 Baolin Wang 2017-08-17 @287  	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
41d32cfce1ae616 Baolin Wang 2017-08-17  288  					      &num_configs);
41d32cfce1ae616 Baolin Wang 2017-08-17  289  	if (ret < 0) {
41d32cfce1ae616 Baolin Wang 2017-08-17  290  		dev_err(pctl->dev, "%s: could not parse node property\n",
41d32cfce1ae616 Baolin Wang 2017-08-17  291  			of_node_full_name(np));
41d32cfce1ae616 Baolin Wang 2017-08-17  292  		return ret;
41d32cfce1ae616 Baolin Wang 2017-08-17  293  	}
41d32cfce1ae616 Baolin Wang 2017-08-17  294  
41d32cfce1ae616 Baolin Wang 2017-08-17  295  	*map = NULL;
41d32cfce1ae616 Baolin Wang 2017-08-17  296  	*num_maps = 0;
41d32cfce1ae616 Baolin Wang 2017-08-17  297  
41d32cfce1ae616 Baolin Wang 2017-08-17  298  	if (function != NULL)
41d32cfce1ae616 Baolin Wang 2017-08-17  299  		reserve++;
41d32cfce1ae616 Baolin Wang 2017-08-17  300  	if (num_configs)
41d32cfce1ae616 Baolin Wang 2017-08-17  301  		reserve++;
41d32cfce1ae616 Baolin Wang 2017-08-17  302  
41d32cfce1ae616 Baolin Wang 2017-08-17  303  	ret = pinctrl_utils_reserve_map(pctldev, map, &reserved_maps,
41d32cfce1ae616 Baolin Wang 2017-08-17  304  					num_maps, reserve);
41d32cfce1ae616 Baolin Wang 2017-08-17  305  	if (ret < 0)
41d32cfce1ae616 Baolin Wang 2017-08-17  306  		goto out;
41d32cfce1ae616 Baolin Wang 2017-08-17  307  
41d32cfce1ae616 Baolin Wang 2017-08-17  308  	if (function) {
41d32cfce1ae616 Baolin Wang 2017-08-17  309  		ret = pinctrl_utils_add_map_mux(pctldev, map,
41d32cfce1ae616 Baolin Wang 2017-08-17  310  						&reserved_maps, num_maps,
41d32cfce1ae616 Baolin Wang 2017-08-17  311  						grp->name, function);
41d32cfce1ae616 Baolin Wang 2017-08-17  312  		if (ret < 0)
41d32cfce1ae616 Baolin Wang 2017-08-17  313  			goto out;
41d32cfce1ae616 Baolin Wang 2017-08-17  314  	}
41d32cfce1ae616 Baolin Wang 2017-08-17  315  
41d32cfce1ae616 Baolin Wang 2017-08-17  316  	if (num_configs) {
41d32cfce1ae616 Baolin Wang 2017-08-17  317  		const char *group_or_pin;
41d32cfce1ae616 Baolin Wang 2017-08-17  318  		unsigned int pin_id;
41d32cfce1ae616 Baolin Wang 2017-08-17  319  
41d32cfce1ae616 Baolin Wang 2017-08-17  320  		if (type == PIN_MAP_TYPE_CONFIGS_PIN) {
41d32cfce1ae616 Baolin Wang 2017-08-17  321  			pin_id = grp->pins[0];
41d32cfce1ae616 Baolin Wang 2017-08-17  322  			group_or_pin = pin_get_name(pctldev, pin_id);
41d32cfce1ae616 Baolin Wang 2017-08-17  323  		} else {
41d32cfce1ae616 Baolin Wang 2017-08-17  324  			group_or_pin = grp->name;
41d32cfce1ae616 Baolin Wang 2017-08-17  325  		}
41d32cfce1ae616 Baolin Wang 2017-08-17  326  
41d32cfce1ae616 Baolin Wang 2017-08-17  327  		ret = pinctrl_utils_add_map_configs(pctldev, map,
41d32cfce1ae616 Baolin Wang 2017-08-17  328  						    &reserved_maps, num_maps,
41d32cfce1ae616 Baolin Wang 2017-08-17  329  						    group_or_pin, configs,
41d32cfce1ae616 Baolin Wang 2017-08-17  330  						    num_configs, type);
41d32cfce1ae616 Baolin Wang 2017-08-17  331  	}
41d32cfce1ae616 Baolin Wang 2017-08-17  332  
41d32cfce1ae616 Baolin Wang 2017-08-17  333  out:
41d32cfce1ae616 Baolin Wang 2017-08-17  334  	kfree(configs);
41d32cfce1ae616 Baolin Wang 2017-08-17  335  	return ret;
41d32cfce1ae616 Baolin Wang 2017-08-17  336  }
41d32cfce1ae616 Baolin Wang 2017-08-17  337  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
