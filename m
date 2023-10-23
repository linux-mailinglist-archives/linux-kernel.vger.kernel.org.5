Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB987D2BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJWHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJWHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:51:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27AD66
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698047472; x=1729583472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W64Rt+rnod+gmqnyOQdn0ij+theDjkJ3D8rzwNAejhg=;
  b=AQcPU5HqesqXBrTGjLmKt0u1QqEricXhg4OvM8BJqf9bFsNH6H9mgd/g
   JznoN0IcdVc3gxxahsxQuu53ur23sGd1g+J3Idx2LJsRqg18qxVps0swp
   Fd1VQnD5rt3P8fwzYEdWsk0Bcx96Ga7lrSzi9Bs1D77erqL1CZGtdRHdV
   79CdVB2YVH/Gw/DuoNy7XQpNn8JY98wmlpBhQ/T7TZdWOlqcEDt/ND3qj
   Yab5KD65mtbBfADZkymTbbE3vs4WDRz86xECNanIr5pYBp++MtzFBrwqf
   9G9u4Gq2Xq9g3e8R0tL/0AfW5ezHOc5qoij/+0TTChFBK2XSglHvziO75
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="385670375"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="385670375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 00:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734588327"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734588327"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 00:50:44 -0700
Message-ID: <d5fba90c-24ab-4aff-8d6f-6d1443f4c10a@linux.intel.com>
Date:   Mon, 23 Oct 2023 09:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ASoC: amd: acp: Add pci legacy driver support for
 acp7.0 platform
Content-Language: en-US
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-12-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20231021145110.478744-12-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 4:50 PM, Syed Saba Kareem wrote:
> Add pci legacy driver support and create platform driver for
> acp7.0 platform.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---

...

> +
> +static struct snd_soc_dai_driver acp70_dai[] = {
> +{
> +	.name = "acp-i2s-sp",
> +	.id = I2S_SP_INSTANCE,
> +	.playback = {
> +		.stream_name = "I2S SP Playback",
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
> +			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,

Any reason to not go from lowest bit width to higher? Similarly in 
further definitions.

> +		.channels_min = 2,
> +		.channels_max = 8,
> +		.rate_min = 8000,
> +		.rate_max = 96000,
> +	},

...

> +
> +static int __maybe_unused acp70_pcm_resume(struct device *dev)
> +{
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	struct acp_stream *stream;
> +	struct snd_pcm_substream *substream;
> +	snd_pcm_uframes_t buf_in_frames;
> +	u64 buf_size;
> +
> +	spin_lock(&adata->acp_lock);
> +	list_for_each_entry(stream, &adata->stream_list, list) {
> +		if (stream) {
> +			substream = stream->substream;
> +			if (substream && substream->runtime) {
> +				buf_in_frames = (substream->runtime->buffer_size);
> +				buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
> +				config_pte_for_stream(adata, stream);
> +				config_acp_dma(adata, stream, buf_size);
> +				if (stream->dai_id)
> +					restore_acp_i2s_params(substream, adata, stream);
> +				else
> +					restore_acp_pdm_params(substream, adata);
> +			}
> +		}
> +	}
> +		spin_unlock(&adata->acp_lock);
> +		return 0;

Indentation is wrong in above two lines.

> +}
> +
> +static const struct dev_pm_ops acp70_dma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp70_pcm_resume)
> +};
> +


