Return-Path: <linux-kernel+bounces-74419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD485D3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739A028403B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FF3D3A8;
	Wed, 21 Feb 2024 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="27eEx0m2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEA3D0AF;
	Wed, 21 Feb 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508128; cv=none; b=UYe0EeDWzWo4DIB33Xx4j6WX/iXDmOp42wssl6llEw/WuhOc5jn052+Dq0YMgnKksCaYIMJr2MopbNV6QdXqLPL3HqoD5wsn9pxuE8UOzG+BrvhfyBCoIDtOKyMcjlc116x6BckQlSYe7BqFJK3LerzrtqcLB96mjCAx/IHuk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508128; c=relaxed/simple;
	bh=ZWJny5hDmVoDsoifGsfG1NwH9fjOr39mDzWHBIT6QrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiC9tA9qBao/UPeOTdRclZN4SBYOqsb6gP8Gn8iiAzWDXJOzK3mc20A0EjWHVfFYUCRkvQfmxPKXnX6D9wgUkBpe0/v48p9U0ZzYBkKtWQKyT6SAGtx4CyRxkxbxHcbVBFDCxXu42Q3pn93J8Pf8UOakBTFivSA60ZICTJ2Lz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=27eEx0m2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708508124;
	bh=ZWJny5hDmVoDsoifGsfG1NwH9fjOr39mDzWHBIT6QrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=27eEx0m2Y57RGki5Tg/d8bO98TkHsTUmDx546m5WO9M4Sc1M7jjlxlQZsGWTV8hXq
	 zECaDhHjP6Mo70MTiOZP0S0wWvNA3TdTEVlx6iLRp0k9wlmBDYYybRGAq5hnWPUWCT
	 a+T7MX8+S2X6x1gesDLei+jKwSzDasoXgQm5Qf84TP33ks1AIcuATkn3Bzggf8WrPq
	 XLtHh1GhcCN1/2yDYkvLwkT7wiGR6F9Ot5XsanpZ+xQhF/vvCAbjgb9Mo/3iaWYeeb
	 giylLJfAv5d/l+zZWOM2YJPk9rnHexCszNYagTw9S1Acd8BBPtc4Je0UdDS5LjKeu8
	 f9Ud1qPm8XwSA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 03EE8378148F;
	Wed, 21 Feb 2024 09:35:22 +0000 (UTC)
Message-ID: <54c35628-9897-4415-86c0-cf81c897840e@collabora.com>
Date: Wed, 21 Feb 2024 10:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: SOF: amd: Move signed_fw_image to struct
 acp_quirk_entry
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
 <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/02/24 21:16, Cristian Ciocaltea ha scritto:
> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
> signed firmware support in the driver via the acp_sof_quirk_table.
> 
> In preparation to support additional use cases of the quirk table (i.e.
> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
> and update all references to it accordingly.
> 
> No functional changes intended.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/amd/acp-loader.c |  2 +-
>   sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
>   sound/soc/sof/amd/acp.h        |  6 ++++-
>   sound/soc/sof/amd/vangogh.c    |  9 +++++--
>   4 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
> index d2d21478399e..aad904839b81 100644
> --- a/sound/soc/sof/amd/acp-loader.c
> +++ b/sound/soc/sof/amd/acp-loader.c
> @@ -173,7 +173,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
>   
>   	adata = sdev->pdata->hw_pdata;
>   
> -	if (adata->signed_fw_image)
> +	if (adata->quirks && adata->quirks->signed_fw_image)
>   		size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
>   	else
>   		size_fw = adata->fw_bin_size;
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index 9b3c26210db3..9d9197fa83ed 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -20,12 +20,14 @@
>   #include "acp.h"
>   #include "acp-dsp-offset.h"
>   
> -#define SECURED_FIRMWARE 1
> -
>   static bool enable_fw_debug;
>   module_param(enable_fw_debug, bool, 0444);
>   MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
>   
> +static struct acp_quirk_entry quirk_valve_galileo = {
> +	.signed_fw_image = true,

Hello Cristian,

are you sure that a structure holding "quirks" is the right choice here?

That probably comes as a personal preference, but I would simply pass a `u32 flags`
and structure the quirks as bits.

#define ACP_SIGNED_FW_IMAGE	BIT(0)
#define ACP_SOMETHING_ELSE	BIT(1)

flags = BIT(SIGNED_FW_IMAGE) | BIT(SOMETHING_ELSE);

if (flags & BIT(SIGNED_FW_IMAGE))
    do_something()

What do you think?

Cheers,
Angelo

> +};
> +
>   const struct dmi_system_id acp_sof_quirk_table[] = {
>   	{
>   		/* Steam Deck OLED device */
> @@ -33,7 +35,7 @@ const struct dmi_system_id acp_sof_quirk_table[] = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>   		},
> -		.driver_data = (void *)SECURED_FIRMWARE,
> +		.driver_data = &quirk_valve_galileo,
>   	},
>   	{}
>   };
> @@ -254,7 +256,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
>   		}
>   	}
>   
> -	if (adata->signed_fw_image)
> +	if (adata->quirks && adata->quirks->signed_fw_image)
>   		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
>   
>   	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
> @@ -738,26 +740,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>   	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
>   	sdev->debug_box.size = BOX_SIZE_1024;
>   
> -	adata->signed_fw_image = false;
>   	dmi_id = dmi_first_match(acp_sof_quirk_table);
> -	if (dmi_id && dmi_id->driver_data) {
> -		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "sof-%s-code.bin",
> -						    chip->name);
> -		if (!adata->fw_code_bin) {
> -			ret = -ENOMEM;
> -			goto free_ipc_irq;
> +	if (dmi_id) {
> +		adata->quirks = dmi_id->driver_data;
> +
> +		if (adata->quirks->signed_fw_image) {
> +			adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> +							    "sof-%s-code.bin",
> +							    chip->name);
> +			if (!adata->fw_code_bin) {
> +				ret = -ENOMEM;
> +				goto free_ipc_irq;
> +			}
> +
> +			adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> +							    "sof-%s-data.bin",
> +							    chip->name);
> +			if (!adata->fw_data_bin) {
> +				ret = -ENOMEM;
> +				goto free_ipc_irq;
> +			}
>   		}
> -
> -		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "sof-%s-data.bin",
> -						    chip->name);
> -		if (!adata->fw_data_bin) {
> -			ret = -ENOMEM;
> -			goto free_ipc_irq;
> -		}
> -
> -		adata->signed_fw_image = dmi_id->driver_data;
>   	}
>   
>   	adata->enable_fw_debug = enable_fw_debug;
> diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
> index 947068da39b5..b648ed194b9f 100644
> --- a/sound/soc/sof/amd/acp.h
> +++ b/sound/soc/sof/amd/acp.h
> @@ -207,6 +207,10 @@ struct sof_amd_acp_desc {
>   	u64 sdw_acpi_dev_addr;
>   };
>   
> +struct acp_quirk_entry {
> +	bool signed_fw_image;
> +};
> +
>   /* Common device data struct for ACP devices */
>   struct acp_dev_data {
>   	struct snd_sof_dev  *dev;
> @@ -236,7 +240,7 @@ struct acp_dev_data {
>   	u8 *data_buf;
>   	dma_addr_t sram_dma_addr;
>   	u8 *sram_data_buf;
> -	bool signed_fw_image;
> +	struct acp_quirk_entry *quirks;
>   	struct dma_descriptor dscr_info[ACP_MAX_DESC];
>   	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
>   	struct acp_dsp_stream *dtrace_stream;
> diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
> index de15d21aa6d9..bc6ffdb5471a 100644
> --- a/sound/soc/sof/amd/vangogh.c
> +++ b/sound/soc/sof/amd/vangogh.c
> @@ -143,6 +143,7 @@ EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
>   int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
>   {
>   	const struct dmi_system_id *dmi_id;
> +	struct acp_quirk_entry *quirks;
>   
>   	/* common defaults */
>   	memcpy(&sof_vangogh_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
> @@ -151,8 +152,12 @@ int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
>   	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
>   
>   	dmi_id = dmi_first_match(acp_sof_quirk_table);
> -	if (dmi_id && dmi_id->driver_data)
> -		sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
> +	if (dmi_id) {
> +		quirks = dmi_id->driver_data;
> +
> +		if (quirks->signed_fw_image)
> +			sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
> +	}
>   
>   	return 0;
>   }




