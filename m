Return-Path: <linux-kernel+bounces-81764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54483867A31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF43B2BB6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562912D1F9;
	Mon, 26 Feb 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y6m59/iK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F51E49B;
	Mon, 26 Feb 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960245; cv=none; b=eI4rUPbkEMjjH40+XpSobO6TeAqF7wwG443lG45mHai2DxCTGDVTXSVFwmyyHspr+4zprEosYAjimpYy36JD9eKOmdjZm60147xKTZPoNsEd7wMJDTKpYcVSiSboD4VZQlZmrC8gHa3Pj3D+12lo0hyHFcYxhA2pzzkqihVlnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960245; c=relaxed/simple;
	bh=rjsAG19LadGQiXwIsDuk3RWW7tqLr3AaqRurQrCjI74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7S5bWetd94C4fCwN179gHVA5sDZhFqAKqOOWV+8LhAhdDQGcK1D/Vu9cr9cpc4HVaFILSLIQj2Fp09K5M0ym9emetdF0sVKTqqcl19sgL9AXAKmfkbafXJzf/SjJyrPuS0db75kOB2W2ROM4xTMk+jDaRlGU31D/J4OICK7Mjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y6m59/iK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708960240;
	bh=rjsAG19LadGQiXwIsDuk3RWW7tqLr3AaqRurQrCjI74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6m59/iKcLeDX15trf+2b++fknskJ4Y0BjG/DYDeb3AUT62y+f+AbO6SlmwBLIwjo
	 cqmLSnTDIU1bGRMY2gDLoEJAS3Va9jCm++dB5s+FD02iCLPDiPR2Qp5VJTgpjCF4Oa
	 bcVkEIIdPmX58dMIPJEokGY8fZQ6Zt7LSeuGigVTYd/q/JRyJO0bwD8aVESpDw0MHo
	 fyRh/9kAQzd7Y7YBoKCYG9OXTEE+nz1WkeybAse6qCAmwgCI7hR5zax5M+SB+Tp9pC
	 He4lXk9VwlRmTgQDBXV1VgcVpm/Iwy4WZA/yew5hhBmmMNUG8zzPP0RpFitZtyJGdo
	 ofuCNPA4/SjNQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D17523780BFE;
	Mon, 26 Feb 2024 15:10:38 +0000 (UTC)
Message-ID: <007956a2-605d-425e-9b3d-aef90c8e6821@collabora.com>
Date: Mon, 26 Feb 2024 16:10:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] ASoc: mediatek: mt8365: Add a specific soundcard
 for EVK
Content-Language: en-US
To: amergnat@baylibre.com, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-10-4fa1cea1667f@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226-audio-i350-v1-10-4fa1cea1667f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 15:01, amergnat@baylibre.com ha scritto:
> From: Nicolas Belin <nbelin@baylibre.com>
> 
> Add a specific soundcard for mt8365-evk. It supports audio jack
> in/out, dmics, the amic and lineout.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   sound/soc/mediatek/mt8365/mt8365-mt6357.c | 379 ++++++++++++++++++++++++++++++
>   1 file changed, 379 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
> new file mode 100644
> index 000000000000..5192b35458e6
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek MT8365 Sound Card driver
> + *
> + * Copyright (c) 2024 MediaTek Inc.
> + * Authors: Nicolas Belin <nbelin@baylibre.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include "mt8365-afe-common.h"
> +#include <linux/pinctrl/consumer.h>
> +#include "../common/mtk-soundcard-driver.h"
> +
> +enum PINCTRL_PIN_STATE {

Aren't those supposed to be AFE pin states?

Anyway, lower case name for enums please, and no zero initializer for the first
entry.

enum mt8365_pin_state {
	PIN_STATE_DEFAULT,
	....
};

> +	PIN_STATE_DEFAULT = 0,
> +	PIN_STATE_DMIC,
> +	PIN_STATE_MISO_OFF,
> +	PIN_STATE_MISO_ON,
> +	PIN_STATE_MOSI_OFF,
> +	PIN_STATE_MOSI_ON,
> +	PIN_STATE_MAX
> +};
> +
> +static const char * const mt8365_mt6357_pin_str[PIN_STATE_MAX] = {
> +	"aud_default",
> +	"aud_dmic",
> +	"aud_miso_off",
> +	"aud_miso_on",
> +	"aud_mosi_off",
> +	"aud_mosi_on",
> +};
> +
> +struct mt8365_mt6357_priv {
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pin_states[PIN_STATE_MAX];
> +};
> +
> +struct mt8365_dai_link_prop {
> +	char *name;
> +	unsigned int link_id;
> +};

This structure is unused.

> +
> +enum {
> +	/* FE */
> +	DAI_LINK_DL1_PLAYBACK = 0,
> +	DAI_LINK_DL2_PLAYBACK,
> +	DAI_LINK_AWB_CAPTURE,
> +	DAI_LINK_VUL_CAPTURE,
> +	/* BE */
> +	DAI_LINK_2ND_I2S_INTF,
> +	DAI_LINK_DMIC,
> +	DAI_LINK_INT_ADDA,
> +	DAI_LINK_NUM
> +};
> +
> +static const struct snd_soc_dapm_widget mt8365_mt6357_widgets[] = {
> +	SND_SOC_DAPM_OUTPUT("HDMI Out"),
> +};
> +
> +static const struct snd_soc_dapm_route mt8365_mt6357_routes[] = {
> +	{"HDMI Out", NULL, "2ND I2S Playback"},
> +	{"DMIC In", NULL, "MICBIAS0"},
> +};
> +
> +static int mt8365_mt6357_int_adda_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mt8365_mt6357_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	int ret = 0;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		if (IS_ERR(priv->pin_states[PIN_STATE_MOSI_ON]))
> +			return ret;
> +
> +		ret = pinctrl_select_state(priv->pinctrl,
> +					priv->pin_states[PIN_STATE_MOSI_ON]);
> +		if (ret)
> +			dev_err(rtd->card->dev, "%s failed to select state %d\n",
> +				__func__, ret);
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		if (IS_ERR(priv->pin_states[PIN_STATE_MISO_ON]))
> +			return ret;
> +
> +		ret = pinctrl_select_state(priv->pinctrl,
> +					priv->pin_states[PIN_STATE_MISO_ON]);
> +		if (ret)
> +			dev_err(rtd->card->dev, "%s failed to select state %d\n",
> +				__func__, ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mt8365_mt6357_int_adda_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mt8365_mt6357_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	int ret = 0;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		if (IS_ERR(priv->pin_states[PIN_STATE_MOSI_OFF]))
> +			return;
> +
> +		ret = pinctrl_select_state(priv->pinctrl,
> +					priv->pin_states[PIN_STATE_MOSI_OFF]);
> +		if (ret)
> +			dev_err(rtd->card->dev, "%s failed to select state %d\n",
> +				__func__, ret);
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		if (IS_ERR(priv->pin_states[PIN_STATE_MISO_OFF]))
> +			return;
> +
> +		ret = pinctrl_select_state(priv->pinctrl,
> +					priv->pin_states[PIN_STATE_MISO_OFF]);
> +		if (ret)
> +			dev_err(rtd->card->dev, "%s failed to select state %d\n",
> +				__func__, ret);
> +	}
> +
> +}
> +
> +static const struct snd_soc_ops mt8365_mt6357_int_adda_ops = {
> +	.startup = mt8365_mt6357_int_adda_startup,
> +	.shutdown = mt8365_mt6357_int_adda_shutdown,
> +};
> +
> +SND_SOC_DAILINK_DEFS(playback1,
> +	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +SND_SOC_DAILINK_DEFS(playback2,
> +	DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +SND_SOC_DAILINK_DEFS(awb_capture,
> +	DAILINK_COMP_ARRAY(COMP_CPU("AWB")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +SND_SOC_DAILINK_DEFS(vul,
> +	DAILINK_COMP_ARRAY(COMP_CPU("VUL")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(i2s3,
> +	DAILINK_COMP_ARRAY(COMP_CPU("2ND I2S")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +SND_SOC_DAILINK_DEFS(dmic,
> +	DAILINK_COMP_ARRAY(COMP_CPU("DMIC")),
> +	DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +SND_SOC_DAILINK_DEFS(primary_codec,
> +	DAILINK_COMP_ARRAY(COMP_CPU("INT ADDA")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("mt6357-sound", "mt6357-snd-codec-aif1")),
> +	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +/* Digital audio interface glue - connects codec <---> CPU */
> +static struct snd_soc_dai_link mt8365_mt6357_dais[] = {
> +	/* Front End DAI links */
> +	[DAI_LINK_DL1_PLAYBACK] = {
> +		.name = "DL1_FE",
> +		.stream_name = "MultiMedia1_PLayback",
> +		.id = DAI_LINK_DL1_PLAYBACK,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST,
> +			SND_SOC_DPCM_TRIGGER_POST
> +		},
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +		.dpcm_merged_rate = 1,
> +		SND_SOC_DAILINK_REG(playback1),
> +	},
> +	[DAI_LINK_DL2_PLAYBACK] = {
> +		.name = "DL2_FE",
> +		.stream_name = "MultiMedia2_PLayback",
> +		.id = DAI_LINK_DL2_PLAYBACK,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST,
> +			SND_SOC_DPCM_TRIGGER_POST
> +		},
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +		.dpcm_merged_rate = 1,
> +		SND_SOC_DAILINK_REG(playback2),
> +	},
> +	[DAI_LINK_AWB_CAPTURE] = {
> +		.name = "AWB_FE",
> +		.stream_name = "DL1_AWB_Record",
> +		.id = DAI_LINK_AWB_CAPTURE,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST,
> +			SND_SOC_DPCM_TRIGGER_POST
> +		},
> +		.dynamic = 1,
> +		.dpcm_capture = 1,
> +		.dpcm_merged_rate = 1,
> +		SND_SOC_DAILINK_REG(awb_capture),
> +	},
> +	[DAI_LINK_VUL_CAPTURE] = {
> +		.name = "VUL_FE",
> +		.stream_name = "MultiMedia1_Capture",
> +		.id = DAI_LINK_VUL_CAPTURE,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST,
> +			SND_SOC_DPCM_TRIGGER_POST
> +		},
> +		.dynamic = 1,
> +		.dpcm_capture = 1,
> +		.dpcm_merged_rate = 1,
> +		SND_SOC_DAILINK_REG(vul),
> +	},
> +	/* Back End DAI links */
> +	[DAI_LINK_2ND_I2S_INTF] = {
> +		.name = "2ND I2S BE",
> +		.no_pcm = 1,
> +		.id = DAI_LINK_2ND_I2S_INTF,
> +		.dai_fmt = SND_SOC_DAIFMT_I2S |
> +				SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBS_CFS,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		SND_SOC_DAILINK_REG(i2s3),
> +	},
> +	[DAI_LINK_DMIC] = {
> +		.name = "DMIC BE",
> +		.no_pcm = 1,
> +		.id = DAI_LINK_DMIC,
> +		.dpcm_capture = 1,
> +		SND_SOC_DAILINK_REG(dmic),
> +	},
> +	[DAI_LINK_INT_ADDA] = {
> +		.name = "MTK Codec",
> +		.no_pcm = 1,
> +		.id = DAI_LINK_INT_ADDA,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.ops = &mt8365_mt6357_int_adda_ops,
> +		SND_SOC_DAILINK_REG(primary_codec),
> +	},
> +};
> +
> +static int pinctrl_setup(struct snd_soc_card *card,
> +			 struct mt8365_mt6357_priv *priv,
> +			 unsigned int pin_id)
> +{
> +	int ret = 0;
> +	/* if pin exist */
> +	if (!IS_ERR(priv->pin_states[pin_id])) {
> +		ret = pinctrl_select_state(priv->pinctrl,
> +				priv->pin_states[pin_id]);
> +		if (ret)
> +			dev_err(card->dev,
> +				"%s failed to select state %d\n",
> +				__func__, ret);
> +	}
> +	return ret;
> +}
> +
> +static int mt8365_mt6357_gpio_probe(struct snd_soc_card *card)
> +{
> +	struct mt8365_mt6357_priv *priv = snd_soc_card_get_drvdata(card);
> +	int ret = 0;
> +	int i;
> +
> +	priv->pinctrl = devm_pinctrl_get(card->dev);
> +	if (IS_ERR(priv->pinctrl)) {
> +		ret = PTR_ERR(priv->pinctrl);
> +		dev_err(card->dev, "%s devm_pinctrl_get failed %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0 ; i < PIN_STATE_MAX ; i++) {
> +		priv->pin_states[i] = pinctrl_lookup_state(priv->pinctrl,
> +			mt8365_mt6357_pin_str[i]);
> +		if (IS_ERR(priv->pin_states[i])) {
> +			ret = PTR_ERR(priv->pin_states[i]);
> +			dev_err(card->dev, "%s Can't find pin state %s %d\n",
> +				 __func__, mt8365_mt6357_pin_str[i], ret);
> +		}
> +	}
> +
> +	/* Setup pins */

	for (i = PIN_STATE_DEFAULT; i < PIN_STATE_MAX; i++) {
		/* Are you sure about that?!?! */
		if (IS_ERR(priv->pin_states[i]))
			continue;

		ret = pinctrl_select_state(...)
		if (ret) {
			/* Should you go back to default? */
			pinctrl_select_state(card, priv, PIN_STATE_DEFAULT);
			return dev_err_probe(card->dev, ret, "ARGH!\n"); /* :-) */
		}
	};

> +	ret |= pinctrl_setup(card, priv, PIN_STATE_DEFAULT);

...because OR'in return values is a big no.

> +	ret |= pinctrl_setup(card, priv, PIN_STATE_DMIC);
> +	ret |= pinctrl_setup(card, priv, PIN_STATE_MISO_OFF);
> +	ret |= pinctrl_setup(card, priv, PIN_STATE_MOSI_OFF);
> +

	return 0;

> +	return ret;
> +}
> +
> +static struct snd_soc_card mt8365_mt6357_card = {
> +	.name = "mt8365-evk",
> +	.owner = THIS_MODULE,
> +	.dai_link = mt8365_mt6357_dais,
> +	.num_links = ARRAY_SIZE(mt8365_mt6357_dais),
> +	.dapm_widgets = mt8365_mt6357_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(mt8365_mt6357_widgets),
> +	.dapm_routes = mt8365_mt6357_routes,
> +	.num_dapm_routes = ARRAY_SIZE(mt8365_mt6357_routes),
> +};
> +
> +static int mt8365_mt6357_dev_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &mt8365_mt6357_card;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *platform_node;
> +	struct mt8365_mt6357_priv *priv;
> +	int i, ret;
> +
> +	card->dev = dev;
> +	ret = parse_dai_link_info(card);
> +	if (ret)
> +		goto err;
> +
> +	platform_node = of_parse_phandle(dev->of_node, "mediatek,platform", 0);
> +	if (!platform_node) {
> +		dev_err(dev, "Property 'platform' missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < card->num_links; i++) {
> +		if (mt8365_mt6357_dais[i].platforms->name)
> +			continue;
> +		mt8365_mt6357_dais[i].platforms->of_node = platform_node;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(struct mt8365_mt6357_priv),
> +			    GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "%s allocate card private data fail %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	snd_soc_card_set_drvdata(card, priv);
> +
> +	mt8365_mt6357_gpio_probe(card);

P.S.: with my cleanup this function would not need any parse_dai_link_info() call,
nor phandle parsing, nor platform_node assignment, nor any call to
devm_snd_soc_register_card(), nor....

..practically you'd need to only allocate your priv (granted that you are not
moving the gpio_probe() to the AFE driver) and the actual gpio_probe() call.

But I'm not pressing to wait, anyway.

Cheers,
Angelo


