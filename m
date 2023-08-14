Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000577BAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjHNOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHNOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:07:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F064E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692022044; x=1723558044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T6NLn5YIRVWjwgZevUuqpYxYLKGf+XO+f3CSLZhvDPE=;
  b=QQ7TRvmjcpPytIk8PXOmtNlNPhxQZbAlLDAUk9AMxEYcm9hS3orzQeeX
   6QJJGK01ocwZTJXaQGq5gFYYwI0k6j8NNGrBVBKf0wmHI/enhJC5y60jt
   gJcP6g3TpDGZLiutoJVJ4nZJShI1GaieYm4NA9AW9jTDnnXBaOweE+X1B
   /Wtd6GByBwTZN7iMxs5Wd7YORAiwRquPuFFQK0lLn+uTKM+re46QyMrBv
   cP/yLjeoRJ7ovu6CBi5Qppko+USXOu7j5XHn/evJrU/dpNUd8s1K1+tFv
   izM7rLGB/5ihF4refBzHrLhIJ+CRYPqsTIZLWmVz+f6cN/WsftfZxBPqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370943656"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370943656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798825217"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798825217"
Received: from ryana2x-mobl.amr.corp.intel.com (HELO [10.212.126.76]) ([10.212.126.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:07:22 -0700
Message-ID: <6c05170c-046f-84af-bed1-7c11801b938a@linux.intel.com>
Date:   Mon, 14 Aug 2023 08:48:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v1] ASoC: Intel: Add rpl_nau8318_8825 driver
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org
References: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/23 03:56, Ajye Huang wrote:
> Boards were using this in older kernels before adl and rpl ids were
> split. Add this back to maintain support.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

Sorry, missed this.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/soc/intel/boards/sof_nau8825.c              | 10 ++++++++++
>  sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
> index 4fc6e1c6aef3..46b7ecf6f9f1 100644
> --- a/sound/soc/intel/boards/sof_nau8825.c
> +++ b/sound/soc/intel/boards/sof_nau8825.c
> @@ -684,6 +684,16 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_BT_OFFLOAD_SSP(2) |
>  					SOF_SSP_BT_OFFLOAD_PRESENT),
>  	},
> +	{
> +		.name = "rpl_nau8318_8825",
> +		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_NAU8318_SPEAKER_AMP_PRESENT |
> +					SOF_NAU8825_SSP_AMP(1) |
> +					SOF_NAU8825_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_SSP(2) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
> index 4eefdb2dd45c..1dd699181765 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
> @@ -351,6 +351,11 @@ static const struct snd_soc_acpi_codecs rpl_rt1019p_amp = {
>  	.codecs = {"RTL1019"}
>  };
>  
> +static const struct snd_soc_acpi_codecs rpl_nau8318_amp = {
> +	.num_codecs = 1,
> +	.codecs = {"NVTN2012"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
>  	{
>  		.comp_ids = &rpl_rt5682_hp,
> @@ -373,6 +378,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
>  		.quirk_data = &rpl_max98373_amp,
>  		.sof_tplg_filename = "sof-rpl-max98373-nau8825.tplg",
>  	},
> +	{
> +		.id = "10508825",
> +		.drv_name = "rpl_nau8318_8825",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rpl_nau8318_amp,
> +		.sof_tplg_filename = "sof-rpl-nau8318-nau8825.tplg",
> +	},
>  	{
>  		.comp_ids = &rpl_rt5682_hp,
>  		.drv_name = "rpl_rt1019_rt5682",
