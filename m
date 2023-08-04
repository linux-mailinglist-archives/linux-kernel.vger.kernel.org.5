Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF276FDE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHDJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHDJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:58:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86446AA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:57:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so18673775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691143077; x=1691747877;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cq4OOSVx9g8PX/S/ulKo9hrKSebxij0hOukOrrlHEhg=;
        b=3McuJHfNMgp1qY5FoOL/M3plIGcZeWXk9vFhv9b11ce4F5H4m8qd3wSDi3JN7Njd1z
         /8hqxh7P3pBpH/CBFH6CS5xijssJmGx8evhhpyLHg3znOAMUK9aso9InBz6zKUz0ZCw9
         iBqcNeWdvAc+YgkuU+IJOt44zgkpxWlXegAYCp5DKliAhtK8gE4jyQHG4Hgqnu/xy46C
         JDfBLqYPcFk2dXd2+d+J4tQ3okYNcgIJCd8LqjF9WQa5L2c65KMMYTNnPPAJCgQDMT+s
         yqpzgPF4rtK3sJRxePJaGLE15gmpRWZ+47LWKZqT8+yU3jB/2JGn2OU1O7suqrwY9iAH
         xoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143077; x=1691747877;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq4OOSVx9g8PX/S/ulKo9hrKSebxij0hOukOrrlHEhg=;
        b=arN2P7XzYIQdeXtJ6umsvx5bx6mT2s69rBh/naLKar0BcR6P9XIkV0wCaSEaCr6/R9
         m8bn8zOzHEAZBbkH6Gc/XkrE9y3LOBeU0H9eAnKnSc+Ou/WFjBiBRgnoxBmYWgpwzd0/
         dMEF0965OHja3vSrt1zul7Hi0SVs22hnwmim5Mp3Btmgl8mTgQwQBi60I+OPHnUYfkhq
         E+x/IM4yYy7IBYO+QLhGPqwGP9+10u9Vh0eZk8lG54kjdq7G4GYsA3xQoep1UOSM4Ww/
         wH1AvwgeTXcdNaio2A/G2Q8Bw5672CI6SdSbR9HkOaLGh7vHmLzpKJTNC93QzlB9awIs
         gZMQ==
X-Gm-Message-State: AOJu0YzfIzVPR97lhATE67hJzefOqxt+p40PtXlIg/9mQMxql94As/Xx
        qRKJEeX0/36/DuLX6tXr9b4mpg==
X-Google-Smtp-Source: AGHT+IFbMXhZU8krQv+KCEswAMi3LzF+bcYenIqf+TpHloBtGWTCayeUN0VwW75SutGBmgaIFJhUeA==
X-Received: by 2002:a05:600c:450:b0:3fe:407c:a053 with SMTP id s16-20020a05600c045000b003fe407ca053mr1099612wmb.16.1691143077174;
        Fri, 04 Aug 2023 02:57:57 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d6e06000000b0031435731dfasm2094028wrz.35.2023.08.04.02.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:57:56 -0700 (PDT)
Message-ID: <988db1b4-784c-bc59-297b-783feb99a9b4@baylibre.com>
Date:   Fri, 4 Aug 2023 11:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/6] ASoC: mediatek: mt7986: support etdm in platform
 driver
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-3-maso.huang@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230728090819.18038-3-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maso,

On 28/07/2023 11:08, Maso Huang wrote:
> Add mt7986 etdm dai driver support.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   sound/soc/mediatek/mt7986/mt7986-dai-etdm.c | 420 ++++++++++++++++++++
>   1 file changed, 420 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> 
> diff --git a/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> new file mode 100644
> index 000000000000..dc094e25ddb4
> --- /dev/null
> +++ b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC Audio DAI eTDM Control
> + *
> + * Copyright (c) 2021 MediaTek Inc.

2023

> + * Author: Vic Wu <vic.wu@mediatek.com>

Authors

> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <sound/pcm_params.h>
> +#include "mt7986-afe-common.h"
> +#include "mt7986-reg.h"
> +
> +enum {
> +	HOPPING_CLK = 0,
> +	APLL_CLK = 1,
> +};

Is there a reason to use enum instead of define ?

> +
> +enum {
> +	MTK_DAI_ETDM_FORMAT_I2S = 0,
> +	MTK_DAI_ETDM_FORMAT_DSPA = 4,
> +	MTK_DAI_ETDM_FORMAT_DSPB = 5,
> +};

Same question here.

> +
> +enum {
> +	ETDM_IN5 = 2,
> +	ETDM_OUT5 = 10,
> +};

I don't find where these enum are used.
If there aren't used, please remove them.

> +
> +enum {
> +	MTK_ETDM_RATE_8K = 0,
> +	MTK_ETDM_RATE_12K = 1,
> +	MTK_ETDM_RATE_16K = 2,
> +	MTK_ETDM_RATE_24K = 3,
> +	MTK_ETDM_RATE_32K = 4,
> +	MTK_ETDM_RATE_48K = 5,
> +	MTK_ETDM_RATE_96K = 7,
> +	MTK_ETDM_RATE_192K = 9,
> +	MTK_ETDM_RATE_11K = 16,
> +	MTK_ETDM_RATE_22K = 17,
> +	MTK_ETDM_RATE_44K = 18,
> +	MTK_ETDM_RATE_88K = 19,
> +	MTK_ETDM_RATE_176K = 20,
> +};
> +
> +struct mtk_dai_etdm_priv {
> +	bool bck_inv;
> +	bool lrck_inv;
> +	bool slave_mode;
> +	unsigned int format;
> +};
> +
> +static unsigned int mt7986_etdm_rate_transform(struct device *dev, unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_ETDM_RATE_8K;
> +	case 11025:
> +		return MTK_ETDM_RATE_11K;
> +	case 12000:
> +		return MTK_ETDM_RATE_12K;
> +	case 16000:
> +		return MTK_ETDM_RATE_16K;
> +	case 22050:
> +		return MTK_ETDM_RATE_22K;
> +	case 24000:
> +		return MTK_ETDM_RATE_24K;
> +	case 32000:
> +		return MTK_ETDM_RATE_32K;
> +	case 44100:
> +		return MTK_ETDM_RATE_44K;
> +	case 48000:
> +		return MTK_ETDM_RATE_48K;
> +	case 88200:
> +		return MTK_ETDM_RATE_88K;
> +	case 96000:
> +		return MTK_ETDM_RATE_96K;
> +	case 176400:
> +		return MTK_ETDM_RATE_176K;
> +	case 192000:
> +		return MTK_ETDM_RATE_192K;
> +	default:
> +		dev_warn(dev, "%s(), rate %u invalid, using %d!!!\n",
> +			 __func__, rate, MTK_ETDM_RATE_48K);
> +		return MTK_ETDM_RATE_48K;
> +	}
> +}
> +
> +static int get_etdm_wlen(unsigned int bitwidth)
> +{
> +	return bitwidth <= 16 ? 16 : 32;
> +}
> +
> +/* dai component */
> +/* interconnection */
> +
> +static const struct snd_kcontrol_new o124_mix[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("I032_Switch", AFE_CONN124_1, 0, 1, 0),
> +};
> +
> +static const struct snd_kcontrol_new o125_mix[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("I033_Switch", AFE_CONN125_1, 1, 1, 0),
> +};
> +
> +static const struct snd_soc_dapm_widget mtk_dai_etdm_widgets[] = {
> +
> +	/* DL */
> +	SND_SOC_DAPM_MIXER("I150", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("I151", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	/* UL */
> +	SND_SOC_DAPM_MIXER("O124", SND_SOC_NOPM, 0, 0, o124_mix, ARRAY_SIZE(o124_mix)),
> +	SND_SOC_DAPM_MIXER("O125", SND_SOC_NOPM, 0, 0, o125_mix, ARRAY_SIZE(o125_mix)),
> +};
> +
> +static const struct snd_soc_dapm_route mtk_dai_etdm_routes[] = {
> +	{"I150", NULL, "ETDM Capture"},
> +	{"I151", NULL, "ETDM Capture"},
> +	{"ETDM Playback", NULL, "O124"},
> +	{"ETDM Playback", NULL, "O125"},
> +	{"O124", "I032_Switch", "I032"},
> +	{"O125", "I033_Switch", "I033"},
> +};
> +
> +/* dai ops */
> +static int mtk_dai_etdm_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(afe_priv->num_clks, afe_priv->clks);
> +	if (ret)
> +		return dev_err_probe(afe->dev, ret, "Failed to enable clocks\n");
> +
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_OUT5_PDN_MASK, 0);
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_IN5_PDN_MASK, 0);
> +
> +	return 0;
> +}
> +
> +static void mtk_dai_etdm_shutdown(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_OUT5_PDN_MASK,
> +			   CLK_OUT5_PDN);
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_IN5_PDN_MASK,
> +			   CLK_IN5_PDN);
> +
> +	clk_bulk_disable_unprepare(afe_priv->num_clks, afe_priv->clks);
> +}
> +
> +static unsigned int get_etdm_ch_fixup(unsigned int channels)
> +{
> +	if (channels > 16)
> +		return 24;
> +	else if (channels > 8)
> +		return 16;
> +	else if (channels > 4)
> +		return 8;
> +	else if (channels > 2)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
> +static int mtk_dai_etdm_config(struct mtk_base_afe *afe,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai,
> +			       int stream)
> +{
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
> +	unsigned int rate = params_rate(params);
> +	unsigned int etdm_rate = mt7986_etdm_rate_transform(afe->dev, rate);
> +	unsigned int afe_rate = mt7986_afe_rate_transform(afe->dev, rate);
> +	unsigned int channels = params_channels(params);
> +	unsigned int bit_width = params_width(params);
> +	unsigned int wlen = get_etdm_wlen(bit_width);
> +	unsigned int val = 0;
> +	unsigned int mask = 0;
> +
> +	dev_dbg(afe->dev, "%s(), stream %d, rate %u, bitwidth %u\n",
> +		 __func__, stream, rate, bit_width);
> +
> +	/* CON0 */
> +	mask |= ETDM_BIT_LEN_MASK;
> +	val |= ETDM_BIT_LEN(bit_width);
> +	mask |= ETDM_WRD_LEN_MASK;
> +	val |= ETDM_WRD_LEN(wlen);
> +	mask |= ETDM_FMT_MASK;
> +	val |= ETDM_FMT(etdm_data->format);
> +	mask |= ETDM_CH_NUM_MASK;
> +	val |= ETDM_CH_NUM(get_etdm_ch_fixup(channels));
> +	mask |= RELATCH_SRC_MASK;
> +	val |= RELATCH_SRC(APLL_CLK);

Why don't use bitfield helper to increase readability and reduce the 
number of define from mt7986-reg.h ?
val |= FIELD_PREP(ETDM_BIT_LEN_MASK, bit_width-1)	;

Then you can remove all ETDM_*****(x) and ETDM_*****_SFT these from your 
header file for all field:
#define ETDM_BIT_LEN(x)                 (((x) - 1) << 11)
#define ETDM_BIT_LEN_SFT                11

Please, do it for all bit operations in all your commits.

> +
> +	switch (stream) {
> +	case SNDRV_PCM_STREAM_PLAYBACK:
> +		/* set ETDM_OUT5_CON0 */
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, mask, val);
> +
> +		/* set ETDM_OUT5_CON4 */
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
> +				   OUT_RELATCH_MASK, OUT_RELATCH(afe_rate));
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
> +				   OUT_CLK_SRC_MASK, OUT_CLK_SRC(APLL_CLK));
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON4,
> +				   OUT_SEL_FS_MASK, OUT_SEL_FS(etdm_rate));
> +
> +		/* set ETDM_OUT5_CON5 */
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON5,
> +				   ETDM_CLK_DIV_MASK, ETDM_CLK_DIV);
> +		break;
> +	case SNDRV_PCM_STREAM_CAPTURE:
> +		/* set ETDM_IN5_CON0 */
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, mask, val);
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON0,
> +				   ETDM_SYNC_MASK, ETDM_SYNC);
> +
> +		/* set ETDM_IN5_CON2 */
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON2,
> +				   IN_CLK_SRC_MASK, IN_CLK_SRC(APLL_CLK));
> +
> +		/* set ETDM_IN5_CON3 */
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON3,
> +				   IN_SEL_FS_MASK, IN_SEL_FS(etdm_rate));
> +
> +		/* set ETDM_IN5_CON4 */
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON4,
> +				   IN_RELATCH_MASK, IN_RELATCH(afe_rate));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +
> +	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_PLAYBACK);
> +	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_CAPTURE);
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
> +				struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +
> +	dev_dbg(afe->dev, "%s(), cmd %d, dai id %d\n", __func__, cmd, dai->id);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, ETDM_EN_MASK,
> +				   ETDM_EN);
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, ETDM_EN_MASK,
> +				   ETDM_EN);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +		regmap_update_bits(afe->regmap, ETDM_IN5_CON0, ETDM_EN_MASK,
> +				   0);
> +		regmap_update_bits(afe->regmap, ETDM_OUT5_CON0, ETDM_EN_MASK,
> +				   0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_etdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt7986_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *etdm_data;
> +	void *priv_data;
> +
> +	switch (dai->id) {
> +	case MT7986_DAI_ETDM:
> +		break;
> +	default:
> +		dev_warn(afe->dev, "%s(), id %d not support\n",
> +			 __func__, dai->id);
> +		return -EINVAL;
> +	}
> +
> +	priv_data = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_etdm_priv),
> +				 GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	afe_priv->dai_priv[dai->id] = priv_data;
> +	etdm_data = afe_priv->dai_priv[dai->id];
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		etdm_data->format = MTK_DAI_ETDM_FORMAT_I2S;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPA;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPB;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		etdm_data->bck_inv = false;
> +		etdm_data->lrck_inv = false;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		etdm_data->bck_inv = false;
> +		etdm_data->lrck_inv = true;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		etdm_data->bck_inv = true;
> +		etdm_data->lrck_inv = false;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		etdm_data->bck_inv = true;
> +		etdm_data->lrck_inv = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		etdm_data->slave_mode = true;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		etdm_data->slave_mode = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops mtk_dai_etdm_ops = {
> +	.startup = mtk_dai_etdm_startup,
> +	.shutdown = mtk_dai_etdm_shutdown,
> +	.hw_params = mtk_dai_etdm_hw_params,
> +	.trigger = mtk_dai_etdm_trigger,
> +	.set_fmt = mtk_dai_etdm_set_fmt,
> +};
> +
> +/* dai driver */
> +#define MTK_ETDM_RATES (SNDRV_PCM_RATE_8000_48000 |\
> +			SNDRV_PCM_RATE_88200 |\
> +			SNDRV_PCM_RATE_96000 |\
> +			SNDRV_PCM_RATE_176400 |\
> +			SNDRV_PCM_RATE_192000)
> +
> +#define MTK_ETDM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			  SNDRV_PCM_FMTBIT_S24_LE |\
> +			  SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static struct snd_soc_dai_driver mtk_dai_etdm_driver[] = {
> +	{
> +		.name = "ETDM",
> +		.id = MT7986_DAI_ETDM,
> +		.capture = {
> +			.stream_name = "ETDM Capture",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = MTK_ETDM_RATES,
> +			.formats = MTK_ETDM_FORMATS,
> +		},
> +		.playback = {
> +			.stream_name = "ETDM Playback",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = MTK_ETDM_RATES,
> +			.formats = MTK_ETDM_FORMATS,
> +		},
> +		.ops = &mtk_dai_etdm_ops,
> +		.symmetric_rate = 1,
> +		.symmetric_sample_bits = 1,
> +	},
> +};
> +
> +int mt7986_dai_etdm_register(struct mtk_base_afe *afe)
> +{
> +	struct mtk_base_afe_dai *dai;
> +
> +	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
> +	if (!dai)
> +		return -ENOMEM;
> +
> +	list_add(&dai->list, &afe->sub_dais);
> +
> +	dai->dai_drivers = mtk_dai_etdm_driver;
> +	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_etdm_driver);
> +
> +	dai->dapm_widgets = mtk_dai_etdm_widgets;
> +	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_etdm_widgets);
> +	dai->dapm_routes = mtk_dai_etdm_routes;
> +	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_etdm_routes);
> +
> +	return 0;
> +}

-- 
Regards,
Alexandre
