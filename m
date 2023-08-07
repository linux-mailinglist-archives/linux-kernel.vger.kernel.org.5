Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF52772857
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHGO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjHGO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E510FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420203; x=1722956203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bv5qmy2opAFHK/vm1WhEMyCMP/qaOlo+EM1ix8neNAY=;
  b=CjW9qMshH+exe5yO5krmOfdtzJJPWAOCpk5ub5hVGcayKZzANCtc0QH2
   Wkx+RDTkfGTI9yT8q7DN5IXhzohOcOTW1SHTF+PmdTGtjky0vySxtNmdu
   sPTDF3hEa6Z6kF8L6Bw9VylY3q/sSEHceoj+RoQxtaj5+BXlsyk9zjZJJ
   39A3JCSzaz1BLC0+8Pai8szwu3RjxD/EeTiCvYLFJr2jHzDGOMy7/3QZ8
   4ukZ3HX+l2np3/KqZ3+Q/tYXfFTvG4Fo+mn9Hw4GPiTQE4zHVOSQclLBn
   mHI0iKgG5FFW4nHLn7I+9hH7h9g+EXk+lxScHlYLlje76oP2jpenNR1Cz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410632"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623888"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623888"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:42 -0700
Message-ID: <4acc7318-69b3-3eb5-1fe8-f7deea8adfad@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:26:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 04:00, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue.
> 
> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
> probe function.

I don't think this patch is aligned with the previous discussions. What
we agreed on is that snd_hdac_i915_init() would be called from and not
from the workqueue.

But this patch also moves all codec initialization out of the workqueue.

I think we need two callbacks for device-specific initilization, one
that is called from the probe function and one from the workqueue,
otherwise we'll have a structure that differs from the snd-hda-intel -
which would be rather silly in terms of support/debug.

I realize there's quite a bit of surgery involved, and most likely the
SOF folks should provide this patch for you to build on.

> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/soc/sof/core.c            | 19 +++++++------------
>  sound/soc/sof/intel/hda-codec.c |  2 +-
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
> index 30db685cc5f4..cd4d06d1800b 100644
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -188,13 +188,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  	struct snd_sof_pdata *plat_data = sdev->pdata;
>  	int ret;
>  
> -	/* probe the DSP hardware */
> -	ret = snd_sof_probe(sdev);
> -	if (ret < 0) {
> -		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
> -		goto probe_err;
> -	}
> -
>  	sof_set_fw_state(sdev, SOF_FW_BOOT_PREPARE);
>  
>  	/* check machine info */
> @@ -325,10 +318,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  dbg_err:
>  	snd_sof_free_debug(sdev);
>  dsp_err:
> -	snd_sof_remove(sdev);
> -probe_err:
> -	sof_ops_free(sdev);
> -
>  	/* all resources freed, update state to match */
>  	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
>  	sdev->first_boot = true;
> @@ -436,6 +425,12 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
>  
>  	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
>  
> +	ret = snd_sof_probe(sdev);
> +	if (ret) {
> +		dev_err_probe(sdev->dev, ret, "failed to probe DSP\n");
> +		return ret;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
>  		INIT_WORK(&sdev->probe_work, sof_probe_work);
>  		schedule_work(&sdev->probe_work);
> @@ -485,9 +480,9 @@ int snd_sof_device_remove(struct device *dev)
>  
>  		snd_sof_ipc_free(sdev);
>  		snd_sof_free_debug(sdev);
> -		snd_sof_remove(sdev);
>  	}
>  
> +	snd_sof_remove(sdev);
>  	sof_ops_free(sdev);
>  
>  	/* release firmware */
> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index f1fd5b44aaac..344b61576c0e 100644
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
