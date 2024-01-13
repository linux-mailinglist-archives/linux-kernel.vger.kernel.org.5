Return-Path: <linux-kernel+bounces-25274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429EB82CC85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE1A2848AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47F210E6;
	Sat, 13 Jan 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InKI3efF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3020DE3;
	Sat, 13 Jan 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705145570; x=1736681570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Du3qdD4Uv77R7v4lmk2V7UBcI5SCGfYhkI4KA6VQIw0=;
  b=InKI3efFvvcbWfP6i+Agft7QegQWYtaHsUaCeCMpZWpadQXFJDqIV2S8
   nHrDT4czatxtRvQg8ALB+Kb7K52wisdMVthKTNYgCs/ATt+qorvF/PXiv
   YlHiIBRy9tFOKaSYNVJSHYIWjU43Ot7mKrs0PfUiWmac/tua+sjy/Imfk
   +nlaA7YMHwn8MFe/swZb5Pl7ymY38x3c1uc/fm3O7bq/nZXxsS9sznGyr
   NS9DRoTbop3BcKLNQ0O/JEOce1jCBMzPwXR8fz+Kzm0/n57T8H5KKXi+f
   UL3o+Eo2QTYBhp5GOarK0hpJLNsD6GpEJ5V1ndT3CiuKj2ae6eeXeuFhZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12850526"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="12850526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 03:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="783310511"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="783310511"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2024 03:32:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOcFn-000AQA-2j;
	Sat, 13 Jan 2024 11:32:43 +0000
Date: Sat, 13 Jan 2024 19:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Julien Massot <julien.massot@collabora.com>,
	linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v3 4/4] media: i2c: add MAX96714 driver
Message-ID: <202401131916.MpdR8A2O-lkp@intel.com>
References: <20240111130349.2776699-5-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111130349.2776699-5-julien.massot@collabora.com>

Hi Julien,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linuxtv-media-stage/master linus/master next-20240112]
[cannot apply to sailus-media-tree/streams]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julien-Massot/dt-bindings-media-add-Maxim-MAX96717F-GMSL2-Serializer/20240111-210740
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20240111130349.2776699-5-julien.massot%40collabora.com
patch subject: [PATCH v3 4/4] media: i2c: add MAX96714 driver
config: i386-randconfig-r071-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131916.MpdR8A2O-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401131916.MpdR8A2O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131916.MpdR8A2O-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/media/i2c/max96714.o: in function `max96714_parse_dt_txport':
>> drivers/media/i2c/max96714.c:827: undefined reference to `__moddi3'
   ld: drivers/media/i2c/max96714.o: in function `max96714_init_tx_port':
>> drivers/media/i2c/max96714.c:725: undefined reference to `__udivdi3'


vim +827 drivers/media/i2c/max96714.c

   714	
   715	static int max96714_init_tx_port(struct max96714_priv *priv)
   716	{
   717		struct v4l2_mbus_config_mipi_csi2 *mipi;
   718		unsigned long lanes_used = 0;
   719		u8 val, lane;
   720		int ret;
   721	
   722		ret = max96714_disable_tx_port(priv);
   723	
   724		mipi = &priv->vep.bus.mipi_csi2;
 > 725		val = *priv->vep.link_frequencies * 2 / MHZ(100);
   726	
   727		cci_update_bits(priv->regmap, MAX96714_BACKTOP25,
   728				CSI_DPLL_FREQ_MASK, val, &ret);
   729	
   730		val = FIELD_PREP(MAX96714_CSI2_LANE_CNT_MASK, mipi->num_data_lanes - 1);
   731		cci_update_bits(priv->regmap, MAX96714_MIPI_LANE_CNT,
   732				MAX96714_CSI2_LANE_CNT_MASK, val, &ret);
   733	
   734		/* lanes polarity */
   735		val = 0;
   736		for (lane = 0; lane < mipi->num_data_lanes + 1; lane++) {
   737			if (!mipi->lane_polarities[lane])
   738				continue;
   739			if (lane == 0)
   740				/* clock lane */
   741				val |= BIT(5);
   742			else if (lane < 3)
   743				/* Lane D0 and D1 */
   744				val |= BIT(lane - 1);
   745			else
   746				/* D2 and D3 */
   747				val |= BIT(lane);
   748		}
   749	
   750		cci_update_bits(priv->regmap, MAX96714_MIPI_POLARITY,
   751				MAX96714_MIPI_POLARITY_MASK, val, &ret);
   752	
   753		/* lanes mapping */
   754		val = 0;
   755		for (lane = 0; lane < mipi->num_data_lanes; lane++) {
   756			val |= (mipi->data_lanes[lane] - 1) << (lane * 2);
   757			lanes_used |= BIT(mipi->data_lanes[lane] - 1);
   758		}
   759	
   760		/* Unused lanes need to be mapped as well to not have
   761		 * the same lanes mapped twice.
   762		 */
   763		for (; lane < 4; lane++) {
   764			unsigned int idx = find_first_zero_bit(&lanes_used, 4);
   765	
   766			val |= idx << (lane * 2);
   767			lanes_used |= BIT(idx);
   768		}
   769	
   770		return cci_write(priv->regmap, MAX96714_MIPI_LANE_MAP, val, &ret);
   771	}
   772	
   773	static int max96714_rxport_enable_poc(struct max96714_priv *priv)
   774	{
   775		struct max96714_rxport *rxport = &priv->rxport;
   776	
   777		if (!rxport->poc)
   778			return 0;
   779	
   780		return regulator_enable(rxport->poc);
   781	}
   782	
   783	static int max96714_rxport_disable_poc(struct max96714_priv *priv)
   784	{
   785		struct max96714_rxport *rxport = &priv->rxport;
   786	
   787		if (!rxport->poc)
   788			return 0;
   789	
   790		return regulator_disable(rxport->poc);
   791	}
   792	
   793	static int max96714_parse_dt_txport(struct max96714_priv *priv)
   794	{
   795		struct device *dev = &priv->client->dev;
   796		struct fwnode_handle *ep_fwnode;
   797		u32 num_data_lanes;
   798		s64 dpll_freq;
   799		int ret;
   800	
   801		ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
   802							    MAX96714_PAD_SOURCE, 0, 0);
   803		if (!ep_fwnode)
   804			return -EINVAL;
   805	
   806		priv->vep.bus_type = V4L2_MBUS_UNKNOWN;
   807	
   808		ret = v4l2_fwnode_endpoint_alloc_parse(ep_fwnode, &priv->vep);
   809		fwnode_handle_put(ep_fwnode);
   810		if (ret) {
   811			dev_err(dev, "tx: failed to parse endpoint data\n");
   812			return -EINVAL;
   813		}
   814	
   815		if (priv->vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
   816			dev_err(&priv->client->dev, "Unsupported bus-type %u\n",
   817				priv->vep.bus_type);
   818			return -EINVAL;
   819		}
   820	
   821		if (priv->vep.nr_of_link_frequencies != 1) {
   822			ret = -EINVAL;
   823			goto err_free_vep;
   824		}
   825	
   826		/* DPLL freq is twice the link frequency */
 > 827		dpll_freq = priv->vep.link_frequencies[0] * 2;
   828	
   829		/* 100Mbps step, Min 100Mbps, Max 2500Mbps */
   830		if (dpll_freq % MHZ(100) || dpll_freq < MHZ(100) ||
   831		    dpll_freq > MHZ(2500)) {
   832			dev_err(dev, "tx: invalid link frequency\n");
   833			ret = -EINVAL;
   834			goto err_free_vep;
   835		}
   836	
   837		num_data_lanes = priv->vep.bus.mipi_csi2.num_data_lanes;
   838		if (num_data_lanes < 1 || num_data_lanes > 4) {
   839			dev_err(dev,
   840				"tx: invalid number of data lanes should be 1 to 4\n");
   841			ret = -EINVAL;
   842			goto err_free_vep;
   843		}
   844	
   845		return 0;
   846	
   847	err_free_vep:
   848		v4l2_fwnode_endpoint_free(&priv->vep);
   849	
   850		return ret;
   851	};
   852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

