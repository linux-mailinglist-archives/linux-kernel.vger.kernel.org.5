Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F57BDB79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjJIMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbjJIMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:20:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AC8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:20:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E698D660576C;
        Mon,  9 Oct 2023 13:20:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696854046;
        bh=ltBHVfNpOMGPjjWoCkqTtFcFuhUvovse3VSY6GPftr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DWF+bb2tcd3rtuLuii3pdK99bZopv8lB8c6HfzQOq1TrcL5yAutOz274686oyxOVV
         ZW3BjdO4kgR8Ym4bnF/cjY2unKDQFCWCy33gyuzuGmavlvPXwEp7//oJPk3qriYA7S
         x6ox4ErhcAeF3BloZaym3gjJdAy6hHWZWYKhCTHgMuU1m69J8xg32t1vkAvS6ItO5C
         4GHZk9aXIVAdVmqpjs5ctx+Vu5zAEXUUyf9vEXFE/yts1uu80PMIyuKYSHtw4DDGXG
         zAByRegOR8DOGtbl1UAwCkkn2vHgxSNOohCwZNZ9Thk0jmuWFq7jMaRdzgp4+zigHZ
         MjzmO730nIeqw==
Message-ID: <9c28b84e-2d4e-7bc2-88f3-ad5b30d2c727@collabora.com>
Date:   Mon, 9 Oct 2023 14:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [v4 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Content-Language: en-US
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, maso.huang@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231008014629.4971-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20231008014629.4971-3-xiazhengqiao@huaqin.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231008014629.4971-3-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/10/23 03:46, xiazhengqiao ha scritto:
> To use RT5682S as the codec and MAX98390 as the amp, add a new
> sound card named mt8188_rt5682s.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> Reviewed-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                |   1 +
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 141 +++++++++++++++++++++-
>   2 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 8d1bc8814486..43c8fea00439 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -250,6 +250,7 @@ config SND_SOC_MT8188_MT6359
>   	select SND_SOC_MAX98390
>   	select SND_SOC_NAU8315
>   	select SND_SOC_NAU8825
> +	select SND_SOC_RT5682S
>   	help
>   	  This adds support for ASoC machine driver for MediaTek MT8188
>   	  boards with the MT6359 and other I2S audio codecs.
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index e2416b981e1f..66f246126728 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -17,6 +17,7 @@
>   #include "mt8188-afe-common.h"
>   #include "../../codecs/nau8825.h"
>   #include "../../codecs/mt6359.h"
> +#include "../../codecs/rt5682.h"
>   #include "../common/mtk-afe-platform-driver.h"
>   #include "../common/mtk-soundcard-driver.h"
>   #include "../common/mtk-dsp-sof-common.h"
> @@ -32,7 +33,7 @@
>    #define TEST_MISO_DONE_2	BIT(29)
>   
>   #define NAU8825_HS_PRESENT	BIT(0)
> -
> +#define RT5682S_HS_PRESENT	BIT(1)
>   /*
>    * Maxim MAX98390
>    */
> @@ -52,6 +53,8 @@
>   #define SOF_DMA_UL4 "SOF_DMA_UL4"
>   #define SOF_DMA_UL5 "SOF_DMA_UL5"
>   
> +#define RT5682S_CODEC_DAI     "rt5682s-aif1"
> +
>   /* FE */
>   SND_SOC_DAILINK_DEFS(playback2,
>   		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
> @@ -258,6 +261,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
>   	},
>   };
>   
> +static struct snd_soc_jack_pin rt5682s_jack_pins[] = {

nau8825_jack_pins is exactly the same as this one, can we please commonize
and avoid duplicate declarations?

> +	{
> +		.pin    = "Headphone Jack",
> +		.mask   = SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin    = "Headset Mic",
> +		.mask   = SND_JACK_MICROPHONE,
> +	},
> +};
> +
>   struct mt8188_card_data {
>   	const char *name;
>   	unsigned long quirk;
> @@ -316,10 +330,18 @@ static const struct snd_soc_dapm_widget mt8188_nau8825_widgets[] = {
>   	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>   };
>   
> +static const struct snd_soc_dapm_widget mt8188_rt5682s_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +};

Same here...

> +
>   static const struct snd_kcontrol_new mt8188_nau8825_controls[] = {
>   	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>   };
>   
> +static const struct snd_kcontrol_new mt8188_rt5682s_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
> +};

...and here.

Regards,
Angelo

