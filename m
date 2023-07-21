Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456CB75C6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGUMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGUMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:16:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3381722
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941802; x=1721477802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WzLVA2z3z4Ky0rEoHYajFlgKmQlaun6+TT25viWnE/c=;
  b=Stx2Klze4IXbu1QpOjZQD7x5JY65wxW3HQRurfodq5VJldcBNGBh+jug
   omVVYaapKEMKrlCSTcLYmcSTYBOYsC5fWP3egCpMt2OIISwuADZQLoD1y
   nQCdLEf6AOzi+oagypJPuq5g2BGjezNmXy6EJIqZMQrGPfl0Mx9yMfXot
   6wph5XxCzr9Wt6xItFLf8X7LFrjOxA1eDc0zBqqwlxhCuIM21xgkZ2MNw
   sydjp1YIgC221UruLJzsKL3icnD9oGZU0B4oeIkat7+JVwyFNEVk92YXw
   aSmDtyVxxjybsGyZydujceRZZ2EswuuueGp/yQDtZ/txtxzFOWTIQJAmx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364473041"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364473041"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:16:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759940914"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759940914"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:16:37 -0700
Message-ID: <3fabdfd4-f6c5-c8e5-391f-baf8ff74210c@linux.intel.com>
Date:   Fri, 21 Jul 2023 15:17:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/9] ASoC: SOF: Intel: Remove deferred probe for SOF
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-9-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-9-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2023 19:41, Maarten Lankhorst wrote:
> This was only used to allow modprobing i915, by converting to the
> -EPROBE_DEFER mechanism, it can be completely removed, and is in
> fact counterproductive since -EPROBE_DEFER otherwise won't be
> handled correctly.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Acked-by: Matthew Auld <matthew.auld@intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/sof/Kconfig           | 19 -----------------
>  sound/soc/sof/core.c            | 38 ++-------------------------------
>  sound/soc/sof/intel/Kconfig     |  1 -
>  sound/soc/sof/intel/hda-codec.c |  2 +-
>  sound/soc/sof/intel/hda.c       | 32 ++++++++++++++++-----------
>  sound/soc/sof/sof-pci-dev.c     |  3 +--
>  sound/soc/sof/sof-priv.h        |  5 -----
>  7 files changed, 23 insertions(+), 77 deletions(-)
> 
> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 80361139a49ad..8ee39e5558062 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -82,17 +82,6 @@ config SND_SOC_SOF_DEVELOPER_SUPPORT
>  
>  if SND_SOC_SOF_DEVELOPER_SUPPORT
>  
> -config SND_SOC_SOF_FORCE_PROBE_WORKQUEUE
> -	bool "SOF force probe workqueue"
> -	select SND_SOC_SOF_PROBE_WORK_QUEUE
> -	help
> -	  This option forces the use of a probe workqueue, which is only used
> -	  when HDaudio is enabled due to module dependencies. Forcing this
> -	  option is intended for debug only, but this should not add any
> -	  functional issues in nominal cases.
> -	  Say Y if you are involved in SOF development and need this option.
> -	  If not, select N.
> -
>  config SND_SOC_SOF_NOCODEC
>  	tristate
>  
> @@ -271,14 +260,6 @@ config SND_SOC_SOF
>  	  module dependencies but since the module or built-in type is decided
>  	  at the top level it doesn't matter.
>  
> -config SND_SOC_SOF_PROBE_WORK_QUEUE
> -	bool
> -	help
> -	  This option is not user-selectable but automagically handled by
> -	  'select' statements at a higher level.
> -	  When selected, the probe is handled in two steps, for example to
> -	  avoid lockdeps if request_module is used in the probe.
> -
>  # Supported IPC versions
>  config SND_SOC_SOF_IPC3
>  	bool
> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
> index 30db685cc5f4b..cdf86dc4a8a87 100644
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -191,7 +191,8 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  	/* probe the DSP hardware */
>  	ret = snd_sof_probe(sdev);
>  	if (ret < 0) {
> -		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);

While at it, can you drop thee "error:" prefix from the print?

>  		goto probe_err;
>  	}
>  
> @@ -309,8 +310,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  	if (plat_data->sof_probe_complete)
>  		plat_data->sof_probe_complete(sdev->dev);
>  
> -	sdev->probe_completed = true;
> -
>  	return 0;
>  
>  sof_machine_err:
> @@ -336,19 +335,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  	return ret;
>  }
>  
> -static void sof_probe_work(struct work_struct *work)
> -{
> -	struct snd_sof_dev *sdev =
> -		container_of(work, struct snd_sof_dev, probe_work);
> -	int ret;
> -
> -	ret = sof_probe_continue(sdev);
> -	if (ret < 0) {
> -		/* errors cannot be propagated, log */
> -		dev_err(sdev->dev, "error: %s failed err: %d\n", __func__, ret);
> -	}
> -}
> -
>  int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
>  {
>  	struct snd_sof_dev *sdev;
> @@ -436,33 +422,16 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
>  
>  	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
>  
> -	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
> -		INIT_WORK(&sdev->probe_work, sof_probe_work);
> -		schedule_work(&sdev->probe_work);
> -		return 0;
> -	}
> -
>  	return sof_probe_continue(sdev);
>  }
>  EXPORT_SYMBOL(snd_sof_device_probe);
>  
> -bool snd_sof_device_probe_completed(struct device *dev)
> -{
> -	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
> -
> -	return sdev->probe_completed;
> -}
> -EXPORT_SYMBOL(snd_sof_device_probe_completed);
> -
>  int snd_sof_device_remove(struct device *dev)
>  {
>  	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
>  	struct snd_sof_pdata *pdata = sdev->pdata;
>  	int ret;
>  
> -	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
> -		cancel_work_sync(&sdev->probe_work);
> -
>  	/*
>  	 * Unregister any registered client device first before IPC and debugfs
>  	 * to allow client drivers to be removed cleanly
> @@ -501,9 +470,6 @@ int snd_sof_device_shutdown(struct device *dev)
>  {
>  	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
>  
> -	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
> -		cancel_work_sync(&sdev->probe_work);
> -
>  	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE) {
>  		sof_fw_trace_free(sdev);
>  		return snd_sof_shutdown(sdev);
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 69c1a370d3b61..d9e87a91670a3 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -293,7 +293,6 @@ config SND_SOC_SOF_HDA_LINK
>  config SND_SOC_SOF_HDA_AUDIO_CODEC
>  	bool "SOF support for HDAudio codecs"
>  	depends on SND_SOC_SOF_HDA_LINK
> -	select SND_SOC_SOF_PROBE_WORK_QUEUE
>  	help
>  	  This adds support for HDAudio codecs with Sound Open Firmware
>  	  for Intel(R) platforms.
> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index f1fd5b44aaac9..344b61576c0e3 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
>  		return 0;
>  
>  	/* i915 exposes a HDA codec for HDMI audio */
> -	ret = snd_hdac_i915_init(bus, true);
> +	ret = snd_hdac_i915_init(bus, false);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 64bebe1a72bbc..a8b7a68142c05 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -801,8 +801,11 @@ static int hda_init(struct snd_sof_dev *sdev)
>  
>  	/* init i915 and HDMI codecs */
>  	ret = hda_codec_i915_init(sdev);
> -	if (ret < 0)
> -		dev_warn(sdev->dev, "init of i915 and HDMI codec failed\n");
> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_warn(sdev->dev, "init of i915 and HDMI codec failed: %i\n", ret);
> +		return ret;
> +	}
>  
>  	/* get controller capabilities */
>  	ret = hda_dsp_ctrl_get_caps(sdev);
> @@ -1115,14 +1118,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>  	sdev->pdata->hw_pdata = hdev;
>  	hdev->desc = chip;
>  
> -	hdev->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
> -						       PLATFORM_DEVID_NONE,
> -						       NULL, 0);
> -	if (IS_ERR(hdev->dmic_dev)) {
> -		dev_err(sdev->dev, "error: failed to create DMIC device\n");
> -		return PTR_ERR(hdev->dmic_dev);
> -	}
> -
>  	/*
>  	 * use position update IPC if either it is forced
>  	 * or we don't have other choice
> @@ -1142,6 +1137,15 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>  	if (ret < 0)
>  		goto hdac_bus_unmap;
>  
> +	hdev->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
> +						       PLATFORM_DEVID_NONE,
> +						       NULL, 0);
> +	if (IS_ERR(hdev->dmic_dev)) {
> +		dev_err(sdev->dev, "error: failed to create DMIC device\n");

From here also, let's not add them back.

> +		ret = PTR_ERR(hdev->dmic_dev);
> +		goto hdac_exit;
> +	}
> +
>  	if (sdev->dspless_mode_selected)
>  		goto skip_dsp_setup;
>  
> @@ -1150,7 +1154,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>  	if (!sdev->bar[HDA_DSP_BAR]) {
>  		dev_err(sdev->dev, "error: ioremap error\n");
>  		ret = -ENXIO;
> -		goto hdac_bus_unmap;
> +		goto platform_unreg;
>  	}
>  
>  	sdev->mmio_bar = HDA_DSP_BAR;
> @@ -1248,10 +1252,12 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>  /* dsp_unmap: not currently used */
>  	if (!sdev->dspless_mode_selected)
>  		iounmap(sdev->bar[HDA_DSP_BAR]);
> -hdac_bus_unmap:
> +platform_unreg:
>  	platform_device_unregister(hdev->dmic_dev);
> -	iounmap(bus->remap_addr);
> +hdac_exit:
>  	hda_codec_i915_exit(sdev);
> +hdac_bus_unmap:
> +	iounmap(bus->remap_addr);
>  err:
>  	return ret;
>  }
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index f5ece43d0ec24..0fa424613082e 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -339,8 +339,7 @@ void sof_pci_remove(struct pci_dev *pci)
>  	snd_sof_device_remove(&pci->dev);
>  
>  	/* follow recommendation in pci-driver.c to increment usage counter */
> -	if (snd_sof_device_probe_completed(&pci->dev) &&
> -	    !(sof_pci_debug & SOF_PCI_DISABLE_PM_RUNTIME))
> +	if (!(sof_pci_debug & SOF_PCI_DISABLE_PM_RUNTIME))
>  		pm_runtime_get_noresume(&pci->dev);
>  
>  	/* release pci regions and disable device */
> diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
> index d4f6702e93dcb..71db636cfdccc 100644
> --- a/sound/soc/sof/sof-priv.h
> +++ b/sound/soc/sof/sof-priv.h
> @@ -564,10 +564,6 @@ struct snd_sof_dev {
>  	enum sof_fw_state fw_state;
>  	bool first_boot;
>  
> -	/* work queue in case the probe is implemented in two steps */
> -	struct work_struct probe_work;
> -	bool probe_completed;
> -
>  	/* DSP HW differentiation */
>  	struct snd_sof_pdata *pdata;
>  
> @@ -675,7 +671,6 @@ struct snd_sof_dev {
>  int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data);
>  int snd_sof_device_remove(struct device *dev);
>  int snd_sof_device_shutdown(struct device *dev);
> -bool snd_sof_device_probe_completed(struct device *dev);
>  
>  int snd_sof_runtime_suspend(struct device *dev);
>  int snd_sof_runtime_resume(struct device *dev);

-- 
Péter
