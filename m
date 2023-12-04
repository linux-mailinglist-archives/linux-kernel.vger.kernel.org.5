Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6528038FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjLDPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjLDPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:38:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B806C1;
        Mon,  4 Dec 2023 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701704324; x=1733240324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bkf6JVVfUCqBbGhiGrUHi1gysUmPoAAmxSWpmZdALtQ=;
  b=TFS18IyIrLoICSOmT0d06HD11PA3gV9tsYRM9Q+uKG5giorjbF8/4L03
   CnOY1sBNmPGCgXUU3baOYAXEsmyMgYCzNuMoew+Autwj7s5DIFCe6rc/g
   ohjktmnJ4Nl1KAvJHPPkTg4A/QstMehV4kVOuXqEpWYO+nUMZNswHLtFn
   SVO4i1Wggd38yfKnDVQl8KVuIZ0xrJuGjpJE1IM2pTjSm+q1Tt5W3kiU0
   ibfE4DBoUq39n24GFeZDezkLfhdruWL6Fr5U8IpVuL6ZY0WkFX3UuIEM9
   mKtEQLop7eTOvw4FDWf97VdaEnvLqvt/QTyMquK+gL/DYj0mioqHMKaB0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="794501"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="794501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914473994"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="914473994"
Received: from sdneilso-mobl1.amr.corp.intel.com (HELO [10.212.147.197]) ([10.212.147.197])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:38:42 -0800
Message-ID: <8510b464-9352-480d-88cf-857597e16cbc@linux.intel.com>
Date:   Mon, 4 Dec 2023 08:55:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and
 cs35l56 support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com
Cc:     kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20231204135614.2169624-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231204135614.2169624-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 07:56, Richard Fitzgerald wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> This is a test configuration for UpExtreme with Cirrus Logic
> CS35L56-EIGHT-C board.
> 
> The codec layout is configured as:
>     - Link3: CS42L43 Jack
>     - Link0: 2x CS35L56 Speaker (amps 1 and 2)
>     - Link1: 2x CS35L56 Speaker (amps 7 and 8)
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V1:
> - Changed ALSA prefixes for CS35L56 to 'AMPn'
> - Renumbered the CS35L56 prefixes to match the numbering of the
>   OUTn speaker sockets on the EIGHT-C board
> ---
>  .../intel/common/soc-acpi-intel-tgl-match.c   | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> index 5804926c8b56..e5f721ba5ed4 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c

> +static const struct snd_soc_acpi_adr_device cs35l56_0_adr[] = {
> +	{
> +		.adr = 0x00003301FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +		.name_prefix = "AMP1"
> +	},
> +	{
> +		.adr = 0x00003201FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_3_endpoint,
> +		.name_prefix = "AMP2"
> +	}
> +};
> +
> +static const struct snd_soc_acpi_adr_device cs35l56_1_adr[] = {
> +	{
> +		.adr = 0x00013701FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_l_endpoint,
> +		.name_prefix = "AMP8"
> +	},
> +	{
> +		.adr = 0x00013601FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_2_endpoint,
> +		.name_prefix = "AMP7"
> +	}
> +};

Don't we need the same change of name_prefix for
soc-acpi-intel-mtl-match.c? I see this in the existing code:

static const struct snd_soc_acpi_adr_device cs35l56_1_adr[] = {
	{
		.adr = 0x00013701FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_r_endpoint,
		.name_prefix = "cs35l56-8"
	},
	{
		.adr = 0x00013601FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_3_endpoint,
		.name_prefix = "cs35l56-7"
	}
};

static const struct snd_soc_acpi_adr_device cs35l56_2_adr[] = {
	{
		.adr = 0x00023301FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_l_endpoint,
		.name_prefix = "cs35l56-1"
	},
	{
		.adr = 0x00023201FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_2_endpoint,
		.name_prefix = "cs35l56-2"
	}
};

