Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4C7F5639
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjKWB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjKWBza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:55:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BA10EF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704527; x=1732240527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ftBrnZe1VCAG/+lgrZnZM2kyM6tPGdYUKXIO0+taZTE=;
  b=W2UhnVXuNy/jFlrxrcsgMdI9DVSnqbd+deecQrmTsouKiV1Blf2f4sHb
   OdEBxWC8bjSsXXMbKU3Qv8Z9GT2wYCW6j1LzLkhhX8lMz2vl0wy1NE/+Z
   4Vf+12oOJVwDK5rOLr6muDPUs4HDphZ5m3CMlxAOkL/jgoZToqfVUVkpq
   +3z+ZBUm0RUbAXj/MRdpsxEdwcBGhBlXCudCB+p0+9HaeLjq2eNnlxzlT
   RK/FNoZcKLWNRcUc6bzvN65F0R050ABu+D8mHHyh71oAHf3SY+ZZkgx/m
   l2nvs1yF+qBJQQqZbv8tJ01VKAhMJEJYPXP6chgIWlmAJMcpkACDb7okP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13737204"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13737204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801909601"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801909601"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2023 17:55:17 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5yvz-00016Z-1y;
        Thu, 23 Nov 2023 01:55:15 +0000
Date:   Thu, 23 Nov 2023 09:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Funke <lukas.funke-oss@weidmueller.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lukas Funke <Lukas.Funke@weidmueller.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: usbc-tusb320: Set interrupt polarity based on
 device-tree
Message-ID: <202311230606.jY9zcxcB-lkp@intel.com>
References: <20231121124844.872238-1-lukas.funke-oss@weidmueller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121124844.872238-1-lukas.funke-oss@weidmueller.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

kernel test robot noticed the following build errors:

[auto build test ERROR on chanwoo-extcon/extcon-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Funke/extcon-usbc-tusb320-Set-interrupt-polarity-based-on-device-tree/20231121-205141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
patch link:    https://lore.kernel.org/r/20231121124844.872238-1-lukas.funke-oss%40weidmueller.com
patch subject: [PATCH] extcon: usbc-tusb320: Set interrupt polarity based on device-tree
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231123/202311230606.jY9zcxcB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230606.jY9zcxcB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230606.jY9zcxcB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/extcon/extcon-usbc-tusb320.c:573:10: error: call to undeclared function 'irq_get_irq_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           irq_d = irq_get_irq_data(client->irq);
                   ^
   drivers/extcon/extcon-usbc-tusb320.c:573:10: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:482:12: note: 'irq_set_irq_wake' declared here
   extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
              ^
>> drivers/extcon/extcon-usbc-tusb320.c:573:8: error: incompatible integer to pointer conversion assigning to 'struct irq_data *' from 'int' [-Wint-conversion]
           irq_d = irq_get_irq_data(client->irq);
                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/extcon/extcon-usbc-tusb320.c:579:12: error: call to undeclared function 'irqd_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           irq_pol = irqd_get_trigger_type(irq_d);
                     ^
   3 errors generated.


vim +/irq_get_irq_data +573 drivers/extcon/extcon-usbc-tusb320.c

   511	
   512	static int tusb320_probe(struct i2c_client *client)
   513	{
   514		struct tusb320_priv *priv;
   515		const void *match_data;
   516		unsigned int revision;
   517		int ret;
   518		int irq_pol;
   519		struct irq_data *irq_d;
   520	
   521		priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
   522		if (!priv)
   523			return -ENOMEM;
   524	
   525		priv->dev = &client->dev;
   526		i2c_set_clientdata(client, priv);
   527	
   528		priv->regmap = devm_regmap_init_i2c(client, &tusb320_regmap_config);
   529		if (IS_ERR(priv->regmap))
   530			return PTR_ERR(priv->regmap);
   531	
   532		ret = tusb320_check_signature(priv);
   533		if (ret)
   534			return ret;
   535	
   536		match_data = device_get_match_data(&client->dev);
   537		if (!match_data)
   538			return -EINVAL;
   539	
   540		priv->ops = (struct tusb320_ops*)match_data;
   541	
   542		if (priv->ops->get_revision) {
   543			ret = priv->ops->get_revision(priv, &revision);
   544			if (ret)
   545				dev_warn(priv->dev,
   546					"failed to read revision register: %d\n", ret);
   547			else
   548				dev_info(priv->dev, "chip revision %d\n", revision);
   549		}
   550	
   551		ret = tusb320_extcon_probe(priv);
   552		if (ret)
   553			return ret;
   554	
   555		ret = tusb320_typec_probe(client, priv);
   556		if (ret)
   557			return ret;
   558	
   559		/* update initial state */
   560		tusb320_state_update_handler(priv, true);
   561	
   562		/* Reset chip to its default state */
   563		ret = tusb320_reset(priv);
   564		if (ret)
   565			dev_warn(priv->dev, "failed to reset chip: %d\n", ret);
   566		else
   567			/*
   568			 * State and polarity might change after a reset, so update
   569			 * them again and make sure the interrupt status bit is cleared.
   570			 */
   571			tusb320_state_update_handler(priv, true);
   572	
 > 573		irq_d = irq_get_irq_data(client->irq);
   574		if (!irq_d) {
   575			dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
   576			return -ENODEV;
   577		}
   578	
 > 579		irq_pol = irqd_get_trigger_type(irq_d);
   580	
   581		ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
   582						tusb320_irq_handler,
   583						IRQF_ONESHOT | irq_pol,
   584						client->name, priv);
   585		if (ret)
   586			tusb320_typec_remove(priv);
   587	
   588		return ret;
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
