Return-Path: <linux-kernel+bounces-24407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F423482BC26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B02848CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF25D740;
	Fri, 12 Jan 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fx4zCRAW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77B5D73B;
	Fri, 12 Jan 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705046696; x=1736582696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uv6Ype/eC4lHKRzgMxquVIgBBZeHuFiDJm+CmozdVpA=;
  b=Fx4zCRAWGBEaxP9k9rK4QcpfpEvI1LJSP0bMuFJfEik4dcCneyvmQNLI
   RFOlLnb2PcQQDnbu4W9S8Yy78TIPUwany0G3x0Sx9T6Q5moMfi+vpapwe
   KtC3PIfnZ1KzOYd0mTmWL6vxg6W0nVpAh5wxIe8D9JAKlWAZD6z8ZqHVU
   gu4b+srIDuxLfF3/5D8ENoFmUK4gUzTz3ZY602HSQr9NLeNSkIKUkNcUY
   fvYG12XXVKQFpmhXTjY2un16O8vrmKcPcUWXmK5VudNBQXs7SZkpmhzd/
   ikIqCXnh03AX4ldl+wZifTmoxtmxDSRAN2C1wetxIJz1NhedQB3g9Md+l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20577906"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="20577906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 00:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="926312678"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="926312678"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2024 00:02:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOCUR-0009DU-2u;
	Fri, 12 Jan 2024 08:02:20 +0000
Date: Fri, 12 Jan 2024 16:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	lgirdwood@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ribalda@chromium.org,
	nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
	kuninori.morimoto.gx@renesas.com, nfraprado@collabora.com,
	alsa-devel@alsa-project.org, trevor.wu@mediatek.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/7] ASoC: mediatek: mt8192-afe-pcm: Simplify with
 dev_err_probe()
Message-ID: <202401121548.rwSkkCvR-lkp@intel.com>
References: <20240111105247.117766-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111105247.117766-7-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on broonie-spi/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/ASoC-mediatek-mt8173-afe-pcm-Convert-to-devm_pm_runtime_enable/20240111-185734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240111105247.117766-7-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH 6/7] ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240112/202401121548.rwSkkCvR-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121548.rwSkkCvR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121548.rwSkkCvR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/mediatek/mt8192/mt8192-afe-pcm.c:2284:46: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
    2284 |                         return dev_err_probe(afe->dev, ret, "dai %d register fail");
         |                                                                  ~^
   1 warning generated.


vim +2284 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c

  2172	
  2173	static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
  2174	{
  2175		struct mtk_base_afe *afe;
  2176		struct mt8192_afe_private *afe_priv;
  2177		struct device *dev;
  2178		struct reset_control *rstc;
  2179		int i, ret, irq_id;
  2180	
  2181		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
  2182		if (ret)
  2183			return ret;
  2184	
  2185		afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
  2186		if (!afe)
  2187			return -ENOMEM;
  2188		platform_set_drvdata(pdev, afe);
  2189	
  2190		afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
  2191						  GFP_KERNEL);
  2192		if (!afe->platform_priv)
  2193			return -ENOMEM;
  2194		afe_priv = afe->platform_priv;
  2195	
  2196		afe->dev = &pdev->dev;
  2197		dev = afe->dev;
  2198	
  2199		/* init audio related clock */
  2200		ret = mt8192_init_clock(afe);
  2201		if (ret) {
  2202			dev_err(dev, "init clock error\n");
  2203			return ret;
  2204		}
  2205	
  2206		/* reset controller to reset audio regs before regmap cache */
  2207		rstc = devm_reset_control_get_exclusive(dev, "audiosys");
  2208		if (IS_ERR(rstc))
  2209			return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
  2210	
  2211		ret = reset_control_reset(rstc);
  2212		if (ret)
  2213			return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
  2214	
  2215		ret = devm_pm_runtime_enable(&pdev->dev);
  2216		if (ret)
  2217			return ret;
  2218	
  2219		/* regmap init */
  2220		afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
  2221		if (IS_ERR(afe->regmap))
  2222			return dev_err_probe(dev, PTR_ERR(afe->regmap),
  2223					     "could not get regmap from parent");
  2224	
  2225		ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
  2226		if (ret)
  2227			return dev_err_probe(dev, ret, "regmap_attach_dev fail\n");
  2228	
  2229		/* enable clock for regcache get default value from hw */
  2230		afe_priv->pm_runtime_bypass_reg_ctl = true;
  2231		pm_runtime_get_sync(&pdev->dev);
  2232	
  2233		ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
  2234		if (ret)
  2235			return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
  2236	
  2237		pm_runtime_put_sync(&pdev->dev);
  2238		afe_priv->pm_runtime_bypass_reg_ctl = false;
  2239	
  2240		regcache_cache_only(afe->regmap, true);
  2241		regcache_mark_dirty(afe->regmap);
  2242	
  2243		/* init memif */
  2244		afe->memif_size = MT8192_MEMIF_NUM;
  2245		afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
  2246					  GFP_KERNEL);
  2247		if (!afe->memif)
  2248			return -ENOMEM;
  2249	
  2250		for (i = 0; i < afe->memif_size; i++) {
  2251			afe->memif[i].data = &memif_data[i];
  2252			afe->memif[i].irq_usage = memif_irq_usage[i];
  2253			afe->memif[i].const_irq = 1;
  2254		}
  2255	
  2256		mutex_init(&afe->irq_alloc_lock);	/* needed when dynamic irq */
  2257	
  2258		/* init irq */
  2259		afe->irqs_size = MT8192_IRQ_NUM;
  2260		afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
  2261					 GFP_KERNEL);
  2262		if (!afe->irqs)
  2263			return -ENOMEM;
  2264	
  2265		for (i = 0; i < afe->irqs_size; i++)
  2266			afe->irqs[i].irq_data = &irq_data[i];
  2267	
  2268		/* request irq */
  2269		irq_id = platform_get_irq(pdev, 0);
  2270		if (irq_id < 0)
  2271			return irq_id;
  2272	
  2273		ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
  2274				       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
  2275		if (ret)
  2276			return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
  2277	
  2278		/* init sub_dais */
  2279		INIT_LIST_HEAD(&afe->sub_dais);
  2280	
  2281		for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
  2282			ret = dai_register_cbs[i](afe);
  2283			if (ret)
> 2284				return dev_err_probe(afe->dev, ret, "dai %d register fail");
  2285		}
  2286	
  2287		/* init dai_driver and component_driver */
  2288		ret = mtk_afe_combine_sub_dai(afe);
  2289		if (ret)
  2290			return dev_err_probe(afe->dev, ret, "mtk_afe_combine_sub_dai fail\n");
  2291	
  2292		/* others */
  2293		afe->mtk_afe_hardware = &mt8192_afe_hardware;
  2294		afe->memif_fs = mt8192_memif_fs;
  2295		afe->irq_fs = mt8192_irq_fs;
  2296		afe->get_dai_fs = mt8192_get_dai_fs;
  2297		afe->get_memif_pbuf_size = mt8192_get_memif_pbuf_size;
  2298		afe->memif_32bit_supported = 1;
  2299	
  2300		afe->runtime_resume = mt8192_afe_runtime_resume;
  2301		afe->runtime_suspend = mt8192_afe_runtime_suspend;
  2302	
  2303		/* register platform */
  2304		ret = devm_snd_soc_register_component(&pdev->dev,
  2305						      &mt8192_afe_component, NULL, 0);
  2306		if (ret)
  2307			return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
  2308	
  2309		ret = devm_snd_soc_register_component(&pdev->dev,
  2310						      &mt8192_afe_pcm_component,
  2311						      afe->dai_drivers,
  2312						      afe->num_dai_drivers);
  2313		if (ret)
  2314			return dev_err_probe(dev, ret, "Couldn't register AFE-PCM component\n");
  2315	
  2316		return 0;
  2317	}
  2318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

