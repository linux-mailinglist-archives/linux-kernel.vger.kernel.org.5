Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10D7ECBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjKOTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjKOTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:25:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D72A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700076327; x=1731612327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q0JGB/3g6HqTpXnULGfv3tEtLwL+H//ZnL7YDLb5P7A=;
  b=m08YCmZfx+ku4mTpApD9a9wJywtJILZY8xP/Z1sJ/8jt4N0k5DHjsG5H
   6tmFsopLf9K8Qn2SVjnJMaAejfr7DkAE8RfkRFZjHNplq4vMFAZ9rC7cD
   IX6Q+tfWn/QWw7Jo8ROXxYSrTw9SrvnyXPa1QJASN2oDAWWRz2b0Ff0MT
   YjWM1eDy8HyPKOYm1PN6XQPuIW4O1uhQ4O7qfcteuccAalEQ1m5t97vpz
   s3pw75Mw3sUby1kr1jcudEbn22XVLatCqto4M6WdJ/O/nlaGAqFm/UDdH
   UEDIqcAyQpTB6LU9anlXlQwpSxZDqSs+HOSjNxJ5UayWaH/2NzeWhAzV4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457434767"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="457434767"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831028201"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831028201"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2023 11:24:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3LVK-0000ki-2Y;
        Wed, 15 Nov 2023 19:24:50 +0000
Date:   Thu, 16 Nov 2023 03:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/qcom/qdsp6/q6apm-dai.c:251:38: warning: cast from 'void
 (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int,
 unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void
 (*)(unsigned int, unsigned int, void *, void *)') ...
Message-ID: <202311160326.ADEJ1JLw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 9b4fe0f1cd791d540100d98a3baf94c1f9994647 ASoC: qdsp6: audioreach: add q6apm-dai support
date:   2 years, 1 month ago
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231116/202311160326.ADEJ1JLw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160326.ADEJ1JLw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160326.ADEJ1JLw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/qdsp6/q6apm-dai.c:251:38: warning: cast from 'void (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int, unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void (*)(unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Wcast-function-type-strict]
     251 |         prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +251 sound/soc/qcom/qdsp6/q6apm-dai.c

   226	
   227	static int q6apm_dai_open(struct snd_soc_component *component,
   228				  struct snd_pcm_substream *substream)
   229	{
   230		struct snd_pcm_runtime *runtime = substream->runtime;
   231		struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
   232		struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_prtd, 0);
   233		struct device *dev = component->dev;
   234		struct q6apm_dai_data *pdata;
   235		struct q6apm_dai_rtd *prtd;
   236		int graph_id, ret;
   237	
   238		graph_id = cpu_dai->driver->id;
   239	
   240		pdata = snd_soc_component_get_drvdata(component);
   241		if (!pdata) {
   242			dev_err(dev, "Drv data not found ..\n");
   243			return -EINVAL;
   244		}
   245	
   246		prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
   247		if (prtd == NULL)
   248			return -ENOMEM;
   249	
   250		prtd->substream = substream;
 > 251		prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
   252		if (IS_ERR(prtd->graph)) {
   253			dev_err(dev, "%s: Could not allocate memory\n", __func__);
   254			ret = PTR_ERR(prtd->graph);
   255			goto err;
   256		}
   257	
   258		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
   259			runtime->hw = q6apm_dai_hardware_playback;
   260		else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
   261			runtime->hw = q6apm_dai_hardware_capture;
   262	
   263		/* Ensure that buffer size is a multiple of period size */
   264		ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
   265		if (ret < 0) {
   266			dev_err(dev, "snd_pcm_hw_constraint_integer failed\n");
   267			goto err;
   268		}
   269	
   270		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
   271			ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
   272							   BUFFER_BYTES_MIN, BUFFER_BYTES_MAX);
   273			if (ret < 0) {
   274				dev_err(dev, "constraint for buffer bytes min max ret = %d\n", ret);
   275				goto err;
   276			}
   277		}
   278	
   279		ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
   280		if (ret < 0) {
   281			dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
   282			goto err;
   283		}
   284	
   285		ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
   286		if (ret < 0) {
   287			dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
   288			goto err;
   289		}
   290	
   291		runtime->private_data = prtd;
   292		runtime->dma_bytes = BUFFER_BYTES_MAX;
   293		if (pdata->sid < 0)
   294			prtd->phys = substream->dma_buffer.addr;
   295		else
   296			prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
   297	
   298		return 0;
   299	err:
   300		kfree(prtd);
   301	
   302		return ret;
   303	}
   304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
