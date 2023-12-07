Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764A807DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443057AbjLGB0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443286AbjLGB0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:26:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B830E7;
        Wed,  6 Dec 2023 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701912232; x=1733448232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=haxRevXN/RxJvUHVAi69/QMEeMdiAMug75ZxQ4vmF6o=;
  b=eWeLSCjkUGVuw9SoJlRq97E9b/YuFiak38nPQ+hzwmwdBKQFhfX7JFYi
   K8McFimtd3Y2I5Ab+vkDOEt64ScvDF1COzMSnhicCI0daPv8HhaT1TS+J
   XtuPbjYGVOmep+MW8Q8UV2+pvuND4yCpg7egh8Hmo2PGtP9Glj2v0+qT+
   UPiJm2MRApRq+DjWBSf0R3qGlNamvaHzZGOQhe8A3oYriMRsgvQ/87pTH
   tNZyxEufA0rKPL9S0ZCP9vzI98I2+pE7jfx3Iqq1s4l1kPGAb5wf0Lpao
   sHhWHjeWXo3J95zc7onWAQBcOEEBJTgHeharo0s6fOyd+W6F/XVQhk7/H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391326002"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391326002"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:22:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="894943613"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="894943613"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2023 17:22:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rB35s-000BfC-14;
        Thu, 07 Dec 2023 01:22:25 +0000
Date:   Thu, 7 Dec 2023 09:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <202312070921.XWcr7wUd-lkp@intel.com>
References: <20231205134223.17335-2-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205134223.17335-2-mitrutzceclan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dumitru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dumitru-Ceclan/iio-adc-ad7173-add-AD7173-driver/20231205-214833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231205134223.17335-2-mitrutzceclan%40gmail.com
patch subject: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
config: m68k-randconfig-r071-20231207 (https://download.01.org/0day-ci/archive/20231207/202312070921.XWcr7wUd-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312070921.XWcr7wUd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070921.XWcr7wUd-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad7173.c:833 ad7173_fw_parse_channel_config() warn: unsigned 'ref_sel' is never less than zero.

vim +/ref_sel +833 drivers/iio/adc/ad7173.c

   735	
   736	static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
   737	{
   738		struct ad7173_channel *channels_st_priv_arr, *chan_st_priv;
   739		struct ad7173_state *st = iio_priv(indio_dev);
   740		struct device *dev = indio_dev->dev.parent;
   741		struct iio_chan_spec *chan_arr, *chan;
   742		struct fwnode_handle *child;
   743		unsigned int ain[2], chan_index = 0;
   744		unsigned int num_channels;
   745		const char *ref_label;
   746		u32 ref_sel;
   747		int ret;
   748	
   749		st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
   750		st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
   751		st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
   752	
   753		/* If a regulator is not available, it will be set to a dummy regulator.
   754		 * Each channel reference is checked with regulator_get_voltage() before
   755		 *  setting attributes so if any channel uses a dummy supply the driver
   756		 *  probe will fail.
   757		 */
   758		ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
   759					      st->regulators);
   760		if (ret)
   761			return dev_err_probe(dev, ret, "Failed to get regulators\n");
   762	
   763		ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
   764		if (ret)
   765			return dev_err_probe(dev, ret, "Failed to enable regulators\n");
   766	
   767		ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
   768		if (ret)
   769			return dev_err_probe(dev, ret,
   770					     "Failed to add regulators disable action\n");
   771	
   772		num_channels = device_get_child_node_count(dev);
   773	
   774		if (st->info->has_temp)
   775			num_channels++;
   776	
   777		if (num_channels == 0)
   778			return dev_err_probe(dev, -EINVAL, "No channels specified\n");
   779		st->num_channels = num_channels;
   780	
   781		chan_arr = devm_kcalloc(dev, sizeof(*chan_arr), num_channels, GFP_KERNEL);
   782		if (!chan_arr)
   783			return -ENOMEM;
   784	
   785		channels_st_priv_arr = devm_kcalloc(dev, num_channels,
   786						    sizeof(*channels_st_priv_arr),
   787						    GFP_KERNEL);
   788		if (!channels_st_priv_arr)
   789			return -ENOMEM;
   790	
   791		indio_dev->channels = chan_arr;
   792		indio_dev->num_channels = num_channels;
   793		st->channels = channels_st_priv_arr;
   794	
   795		if (st->info->has_temp) {
   796			chan_arr[chan_index] = ad7173_temp_iio_channel_template;
   797			chan_st_priv = &channels_st_priv_arr[chan_index];
   798			chan_st_priv->ain =
   799				AD7173_CH_ADDRESS(chan_arr[chan_index].channel, chan_arr[chan_index].channel2);
   800			chan_st_priv->cfg.bipolar = false;
   801			chan_st_priv->cfg.input_buf = true;
   802			chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
   803			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
   804	
   805			chan_index++;
   806		}
   807	
   808		device_for_each_child_node(dev, child) {
   809			chan = &chan_arr[chan_index];
   810			chan_st_priv = &channels_st_priv_arr[chan_index];
   811			ret = fwnode_property_read_u32_array(child, "diff-channels",
   812							     ain, ARRAY_SIZE(ain));
   813			if (ret) {
   814				fwnode_handle_put(child);
   815				return ret;
   816			}
   817	
   818			if (ain[0] >= st->info->num_inputs ||
   819			    ain[1] >= st->info->num_inputs) {
   820				fwnode_handle_put(child);
   821				return dev_err_probe(dev, -EINVAL,
   822						     "Input pin number out of range for pair (%d %d).\n",
   823						     ain[0], ain[1]);
   824			}
   825	
   826			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
   827			ref_label = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
   828	
   829			fwnode_property_read_string(child, "adi,reference-select",
   830						    &ref_label);
   831			ref_sel = match_string(ad7173_ref_sel_str,
   832					       ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
 > 833			if (ref_sel < 0) {
   834				fwnode_handle_put(child);
   835				return dev_err_probe(dev, -EINVAL,
   836						     "Invalid channel reference name %s\n",
   837						     ref_label);
   838			}
   839	
   840			if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
   841			    st->info->id != AD7173_ID) {
   842				fwnode_handle_put(child);
   843				return dev_err_probe(dev, -EINVAL, "External reference 2 is only available on ad7173-8\n");
   844			}
   845	
   846			ret = ad7173_get_ref_voltage_milli(st, ref_sel);
   847			if (ret < 0) {
   848				fwnode_handle_put(child);
   849				return dev_err_probe(dev, ret,
   850						     "Cannot use reference %u\n", ref_sel);
   851			}
   852			if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
   853				st->adc_mode |= AD7173_ADC_MODE_REF_EN;
   854			chan_st_priv->cfg.ref_sel = ref_sel;
   855	
   856			*chan = ad7173_channel_template;
   857			chan->address = chan_index;
   858			chan->scan_index = chan_index;
   859			chan->channel = ain[0];
   860			chan->channel2 = ain[1];
   861			chan->differential = true;
   862	
   863			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
   864			chan_st_priv->chan_reg = chan_index;
   865			chan_st_priv->cfg.input_buf = true;
   866			chan_st_priv->cfg.odr = 0;
   867	
   868			chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
   869			if (chan_st_priv->cfg.bipolar)
   870				chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
   871	
   872			chan_index++;
   873		}
   874	
   875		return 0;
   876	}
   877	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
