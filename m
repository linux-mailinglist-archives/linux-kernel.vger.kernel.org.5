Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAA7B865B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjJDRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbjJDRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:05:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3BAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696439115; x=1727975115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BPrbOdjfDQnlu7PBBE6jMSOGqJlteSEMb7Ixz8XIRgc=;
  b=FNXt+Yt0epE2UKq9LF2EgNLw+/iTBNTGj7cuGBogulwDRkRZIRugyVzE
   Ufh2WK6CGyDLpOEDw2sGGcdGgAMDQfHrtNF9aTfDB/AHy6MKxDMvAPLVD
   bUGi8k7MI6H7M4cOHZlOz1lyumf95FxF72n774a0RJK2cp3DYLtJLKhKm
   x3aa7C3C57dGaJaSjHXZ6sM2WXhgQHU+PPxoWY7/f5ZztIMXlUalAa+v6
   8Mco/x1BCO6qqiEqZjB3j+GHFmpCgwVuGBaNvwgRNDP5zIEJWj2s7fOMt
   KQ8j9raMgFM7rZfYM26EcNxDKpO09Tcd0bfJH5Ii95aWRTMbTLGJBFVOY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383138204"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="383138204"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 10:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="755023978"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="755023978"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 10:03:55 -0700
Date:   Wed, 4 Oct 2023 19:59:42 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v6 11/12] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
In-Reply-To: <20231004145540.32321-12-maarten.lankhorst@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2310041953090.3390143@eliteleevi.tm.intel.com>
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com> <20231004145540.32321-12-maarten.lankhorst@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm good with rest of the series, but one patch requires work.

On Wed, 4 Oct 2023, Maarten Lankhorst wrote:

> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue.
> 
> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
> probe function.
> 
> The previously added probe_early can be used for this,
> and we also use the newly added remove_late for unbinding afterwards.
[...]
> --- a/sound/soc/sof/intel/hda-common-ops.c
> +++ b/sound/soc/sof/intel/hda-common-ops.c
> @@ -19,6 +19,7 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
>  	.probe_early	= hda_dsp_probe_early,
>  	.probe		= hda_dsp_probe,
>  	.remove		= hda_dsp_remove,
> +	.remove_late	= hda_dsp_remove_late,
>  
>  	/* Register IO uses direct mmio */
>  
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 86a2571488bc..4eb7f04b8ae1 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -1160,6 +1160,7 @@ int hda_dsp_probe_early(struct snd_sof_dev *sdev)
>  		return -ENOMEM;
>  	sdev->pdata->hw_pdata = hdev;
>  	hdev->desc = chip;
> +	ret = hda_init(sdev);
>  
>  err:
>  	return ret;

I don't think this works. The hda_codec_i915_init() errors are ignored in 
hda_init() so this never returns -EPROBE_DEFER.

So something like this is needed on top (tested quickly on one SOF 
machine and this blocks SOF load until i915 or xe driver is loaded):

--cut--
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 9025bfaf6a7e..8b17c82dcc89 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -863,13 +863,20 @@ static int hda_init(struct snd_sof_dev *sdev)
        /* init i915 and HDMI codecs */
        ret = hda_codec_i915_init(sdev);
        if (ret < 0)
-               dev_warn(sdev->dev, "init of i915 and HDMI codec 
failed\n");
+               dev_warn(sdev->dev, "init of i915 and HDMI codec failed 
(%d)\n", ret);
+
+       if (ret < 0 && ret != -ENODEV)
+               goto out;
 
        /* get controller capabilities */
        ret = hda_dsp_ctrl_get_caps(sdev);
        if (ret < 0)
                dev_err(sdev->dev, "error: get caps error\n");
 
+out:
+       if (ret < 0)
+               iounmap(sof_to_bus(sdev)->remap_addr);
+
        return ret;
 }
--cut--

Br, Kai
