Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1547F8A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjKYMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjKYMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:07:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658D19B2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:07:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a0b7f793b8aso50929866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700914026; x=1701518826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ua8H1ptm7Jh60hu9vOx5MGnEW8+EOEb5ojvwQq1JOM=;
        b=QWrXK1ymUaWXa9UWZQUbz7n4Pr40GhFVfGAIJsJz84IQXVlWDHpnY6ob9E1VnGDP7k
         86IQfoDJmL/aHKh8ZGHL5JGh/Zjh1WadbHm9jmAbjAX+XEjciGAC1dG/I9CnEIALAw2R
         qSuwfo7gyigeMIqcBpiVHbzf1v7pvbqTvJ5zI+w781kvbZ5w2tyTyTrvtQX7KI8HThxQ
         6Kyw9oUcjH6QwXBMdkCXBGg8riVG+JtLl/okhDCCguaaaqeSkeSk2ljz9NnMsFaLA0iH
         MYLKtq/rLok3oB5SsNP4twQmzozYoyZO0lx+Rcu5hxDM1H4gRrd0WKJZps9c6at+YJPp
         gFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700914026; x=1701518826;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ua8H1ptm7Jh60hu9vOx5MGnEW8+EOEb5ojvwQq1JOM=;
        b=lkMxUQl0zsmmqL519JEUwIFqiUr7Ite1W1lvprgJmO61DxHRkB/Wpkdc3fn+Mj4DcU
         VgJ3X6RVfUa/8QwvcBjT0jZasMxmuFJmK+T0OfQ+BX0+KkRzKuXUrm+fM8WaufbswfQH
         y/rj6HCiIEJdjR08OgydPtF4fZbzjNf34w3AqglzfFUtpxB5/ksM76zBjOsE6azLHB+A
         glZHSEJ2bpQcuKIxV8DrYaqAIq4rsZj7LCIyONmD3/4gPCPsniICJqBcqQRzqwuh6dwK
         w3GP+afzOd/aZa7ffFrn6QXL7JTdzkKjK26QEn71cvLCfc43u44GYZQTn1qvbomVi3sx
         5v8A==
X-Gm-Message-State: AOJu0YzWe0M9Xm1TLX6PSxjVdyFEulsTx0px9WK0hpAsX4KyyQzvQhtU
        n0AvjydlHwze52+Bhk9wG+gQbQ==
X-Google-Smtp-Source: AGHT+IH0M6xQj7KsrKP6PqIuiNzN/gULlTS56kTOHqbcJQfDasUyiWHLshIlSs+TQToG9S6jPgoAxQ==
X-Received: by 2002:a17:906:7691:b0:a04:837e:87af with SMTP id o17-20020a170906769100b00a04837e87afmr4562560ejm.33.1700914026516;
        Sat, 25 Nov 2023 04:07:06 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709063e9400b00a0369e232bfsm3361413ejj.75.2023.11.25.04.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 04:07:06 -0800 (PST)
Message-ID: <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
Date:   Sat, 25 Nov 2023 13:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.2023 15:49, Neil Armstrong wrote:
> Add the main WCD9390/WCD9395 Audio Codec driver to support:
> - 4 ADC inputs for up to 5 Analog Microphones
> - 4 DMIC inputs for up to 8 Digital Microphones
> - 4 Microphone BIAS
> - Stereo Headphone output
> - Mono EAR output
> - MBHC engine for Headset Detection
> 
> It makes usage of the generic MBHC and CLSH generic code and
> the USB Type-C mux and switch helpers to gather USB-C Events
> in order to properly setup Headset Detection mechanism
> when connected behind the separate USB-C Mux subsystem.
> 
> WCD9390/WCD9395 supports a PCM path for Playback instead
> of the actually implemented PDM playback, it will be
> implemented later.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  sound/soc/codecs/Kconfig       |    8 +
>  sound/soc/codecs/Makefile      |    6 +
>  sound/soc/codecs/wcd-clsh-v2.h |    1 +
>  sound/soc/codecs/wcd939x.c     | 3635 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 3650 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 1a29b38d4cb9..31f26eb2f833 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2056,8 +2056,16 @@ config SND_SOC_WCD938X_SDW
>  	  The WCD9380/9385 is a audio codec IC Integrated in
>  	  Qualcomm SoCs like SM8250.
>  
> +config SND_SOC_WCD939X
> +	depends on SND_SOC_WCD939X_SDW
> +	tristate
> +	depends on SOUNDWIRE || !SOUNDWIRE
> +	select SND_SOC_WCD_CLASSH
> +
>  config SND_SOC_WCD939X_SDW
>  	tristate "WCD9390/WCD9395 Codec - SDW"
> +	select SND_SOC_WCD939X
> +	select SND_SOC_WCD_MBHC
>  	select REGMAP_IRQ
>  	depends on SOUNDWIRE
>  	select REGMAP_SOUNDWIRE
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index c63e4c274ed4..4fba9fbb6516 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -312,6 +312,7 @@ snd-soc-wcd9335-objs := wcd9335.o
>  snd-soc-wcd934x-objs := wcd934x.o
>  snd-soc-wcd938x-objs := wcd938x.o
>  snd-soc-wcd938x-sdw-objs := wcd938x-sdw.o
> +snd-soc-wcd939x-objs := wcd939x.o
>  snd-soc-wcd939x-sdw-objs := wcd939x-sdw.o
>  snd-soc-wl1273-objs := wl1273.o
>  snd-soc-wm-adsp-objs := wm_adsp.o
> @@ -702,6 +703,11 @@ ifdef CONFIG_SND_SOC_WCD938X_SDW
>  # avoid link failure by forcing sdw code built-in when needed
>  obj-$(CONFIG_SND_SOC_WCD938X) += snd-soc-wcd938x-sdw.o
>  endif
> +obj-$(CONFIG_SND_SOC_WCD939X)	+= snd-soc-wcd939x.o
> +ifdef CONFIG_SND_SOC_WCD939X_SDW
> +# avoid link failure by forcing sdw code built-in when needed
> +obj-$(CONFIG_SND_SOC_WCD939X) += snd-soc-wcd939x-sdw.o
> +endif
>  obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
>  obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
>  obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
> diff --git a/sound/soc/codecs/wcd-clsh-v2.h b/sound/soc/codecs/wcd-clsh-v2.h
> index 4e3653058275..eeb9bc5b01e2 100644
> --- a/sound/soc/codecs/wcd-clsh-v2.h
> +++ b/sound/soc/codecs/wcd-clsh-v2.h
> @@ -47,6 +47,7 @@ enum wcd_codec_version {
>  	/* New CLSH after this */
>  	WCD937X  = 2,
>  	WCD938X  = 3,
> +	WCD939X  = 4,
>  };
>  struct wcd_clsh_ctrl;
>  
> diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
> new file mode 100644
> index 000000000000..47af08e6c0c8
> --- /dev/null
> +++ b/sound/soc/codecs/wcd939x.c
> @@ -0,0 +1,3635 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/component.h>
> +#include <sound/tlv.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_graph.h>
> +#include <linux/of.h>
> +#include <sound/jack.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <linux/regmap.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_altmode.h>
> +
> +#include "wcd-clsh-v2.h"
> +#include "wcd-mbhc-v2.h"
> +#include "wcd939x.h"
> +
> +#define WCD939X_MAX_MICBIAS		(4)
> +#define WCD939X_MAX_SUPPLY		(4)
> +#define WCD939X_MBHC_MAX_BUTTONS	(8)
> +#define TX_ADC_MAX			(4)
> +#define WCD_MBHC_HS_V_MAX		1600
> +
> +enum {
> +	WCD939X_VERSION_1_0 = 0,
> +	WCD939X_VERSION_1_1,
> +	WCD939X_VERSION_2_0,
> +};
> +
> +#define WCD939X_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
> +			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
> +			    SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000 |\
> +			    SNDRV_PCM_RATE_384000)
> +/* Fractional Rates */
> +#define WCD939X_FRAC_RATES_MASK (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_88200 |\
> +				 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800)
> +#define WCD939X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE |\
> +			 SNDRV_PCM_FMTBIT_S24_3LE |\
> +			 SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/* Convert from vout ctl to micbias voltage in mV */
> +#define WCD_VOUT_CTL_TO_MICB(v)		(1000 + (v) * 50)
> +#define SWR_CLK_RATE_0P6MHZ		(600000)
> +#define SWR_CLK_RATE_1P2MHZ		(1200000)
> +#define SWR_CLK_RATE_2P4MHZ		(2400000)
> +#define SWR_CLK_RATE_4P8MHZ		(4800000)
> +#define SWR_CLK_RATE_9P6MHZ		(9600000)
> +#define SWR_CLK_RATE_11P2896MHZ		(1128960)
> +
> +#define ADC_MODE_VAL_HIFI		0x01
> +#define ADC_MODE_VAL_LO_HIF		0x02
> +#define ADC_MODE_VAL_NORMAL		0x03
> +#define ADC_MODE_VAL_LP			0x05
> +#define ADC_MODE_VAL_ULP1		0x09
> +#define ADC_MODE_VAL_ULP2		0x0B
> +
> +/* Z value defined in milliohm */
> +#define WCD939X_ZDET_VAL_32		(32000)
> +#define WCD939X_ZDET_VAL_400		(400000)
> +#define WCD939X_ZDET_VAL_1200		(1200000)
> +#define WCD939X_ZDET_VAL_100K		(100000000)
> +
> +/* Z floating defined in ohms */
> +#define WCD939X_ZDET_FLOATING_IMPEDANCE	(0x0FFFFFFE)
> +#define WCD939X_ZDET_NUM_MEASUREMENTS	(900)
> +#define WCD939X_MBHC_GET_C1(c)		(((c) & 0xC000) >> 14)
> +#define WCD939X_MBHC_GET_X1(x)		((x) & 0x3FFF)
> +
> +/* Z value compared in milliOhm */
> +#define WCD939X_MBHC_IS_SECOND_RAMP_REQUIRED(z) false
> +#define WCD939X_ANA_MBHC_ZDET_CONST	(1018 * 1024)
> +
> +enum {
> +	WCD9390 = 0,
> +	WCD9395 = 5,
> +};
> +
> +enum {
> +	/* INTR_CTRL_INT_MASK_0 */
> +	WCD939X_IRQ_MBHC_BUTTON_PRESS_DET = 0,
> +	WCD939X_IRQ_MBHC_BUTTON_RELEASE_DET,
> +	WCD939X_IRQ_MBHC_ELECT_INS_REM_DET,
> +	WCD939X_IRQ_MBHC_ELECT_INS_REM_LEG_DET,
> +	WCD939X_IRQ_MBHC_SW_DET,
> +	WCD939X_IRQ_HPHR_OCP_INT,
> +	WCD939X_IRQ_HPHR_CNP_INT,
> +	WCD939X_IRQ_HPHL_OCP_INT,
> +
> +	/* INTR_CTRL_INT_MASK_1 */
> +	WCD939X_IRQ_HPHL_CNP_INT,
> +	WCD939X_IRQ_EAR_CNP_INT,
> +	WCD939X_IRQ_EAR_SCD_INT,
> +	WCD939X_IRQ_HPHL_PDM_WD_INT,
> +	WCD939X_IRQ_HPHR_PDM_WD_INT,
> +	WCD939X_IRQ_EAR_PDM_WD_INT,
> +
> +	/* INTR_CTRL_INT_MASK_2 */
> +	WCD939X_IRQ_MBHC_MOISTURE_INT,
> +	WCD939X_IRQ_HPHL_SURGE_DET_INT,
> +	WCD939X_IRQ_HPHR_SURGE_DET_INT,
> +	WCD939X_NUM_IRQS,
> +};
> +
> +enum {
> +	WCD_ADC1 = 0,
> +	WCD_ADC2,
> +	WCD_ADC3,
> +	WCD_ADC4,
> +	HPH_PA_DELAY,
> +};
> +
> +enum {
> +	ADC_MODE_INVALID = 0,
> +	ADC_MODE_HIFI,
> +	ADC_MODE_LO_HIF,
> +	ADC_MODE_NORMAL,
> +	ADC_MODE_LP,
> +	ADC_MODE_ULP1,
> +	ADC_MODE_ULP2,
> +};
> +
> +enum {
> +	AIF1_PB = 0,
> +	AIF1_CAP,
> +	NUM_CODEC_DAIS,
> +};
> +
> +static u8 tx_mode_bit[] = {
> +	[ADC_MODE_INVALID] = 0x00,
> +	[ADC_MODE_HIFI] = 0x01,
> +	[ADC_MODE_LO_HIF] = 0x02,
> +	[ADC_MODE_NORMAL] = 0x04,
> +	[ADC_MODE_LP] = 0x08,
> +	[ADC_MODE_ULP1] = 0x10,
> +	[ADC_MODE_ULP2] = 0x20,
> +};
> +
> +struct wcd939x_priv {
> +	struct sdw_slave *tx_sdw_dev;
> +	struct wcd939x_sdw_priv *sdw_priv[NUM_CODEC_DAIS];
> +	struct device *txdev;
> +	struct device *rxdev;
> +	struct device_node *rxnode, *txnode;
> +	struct regmap *regmap;
> +	struct snd_soc_component *component;
> +	/* micb setup lock */
> +	struct mutex micb_lock;
> +	/* typec handling */
> +	bool typec_analog_mux;
> +	struct typec_mux_dev *typec_mux;
> +	struct typec_switch_dev *typec_sw;
> +	enum typec_orientation typec_orientation;
> +	unsigned long typec_mode;
> +	struct typec_switch *typec_switch;
> +	/* mbhc module */
> +	struct wcd_mbhc *wcd_mbhc;
> +	struct wcd_mbhc_config mbhc_cfg;
> +	struct wcd_mbhc_intr intr_ids;
> +	struct wcd_clsh_ctrl *clsh_info;
> +	struct irq_domain *virq;
> +	struct regmap_irq_chip *wcd_regmap_irq_chip;
> +	struct regmap_irq_chip_data *irq_chip;
> +	struct regulator_bulk_data supplies[WCD939X_MAX_SUPPLY];
> +	struct snd_soc_jack *jack;
> +	unsigned long status_mask;
> +	s32 micb_ref[WCD939X_MAX_MICBIAS];
> +	s32 pullup_ref[WCD939X_MAX_MICBIAS];
> +	u32 hph_mode;
> +	u32 tx_mode[TX_ADC_MAX];
> +	int variant;
> +	int reset_gpio;
> +	u32 micb1_mv;
> +	u32 micb2_mv;
> +	u32 micb3_mv;
> +	u32 micb4_mv;
> +	int hphr_pdm_wd_int;
> +	int hphl_pdm_wd_int;
> +	int ear_pdm_wd_int;
> +	bool comp1_enable;
> +	bool comp2_enable;
> +	bool ldoh;
> +};
> +
> +static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
> +static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
> +
> +struct wcd939x_mbhc_zdet_param {
> +	u16 ldo_ctl;
> +	u16 noff;
> +	u16 nshift;
> +	u16 btn5;
> +	u16 btn6;
> +	u16 btn7;
> +};
> +
> +static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
> +	WCD_MBHC_FIELD(WCD_MBHC_L_DET_EN, WCD939X_ANA_MBHC_MECH, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_GND_DET_EN, WCD939X_ANA_MBHC_MECH, 0x40),
> +	WCD_MBHC_FIELD(WCD_MBHC_MECH_DETECTION_TYPE, WCD939X_ANA_MBHC_MECH, 0x20),
> +	WCD_MBHC_FIELD(WCD_MBHC_MIC_CLAMP_CTL, WCD939X_MBHC_NEW_PLUG_DETECT_CTL, 0x30),
> +	WCD_MBHC_FIELD(WCD_MBHC_ELECT_DETECTION_TYPE, WCD939X_ANA_MBHC_ELECT, 0x08),
> +	WCD_MBHC_FIELD(WCD_MBHC_HS_L_DET_PULL_UP_CTRL, WCD939X_MBHC_NEW_INT_MECH_DET_CURRENT, 0x1F),
> +	WCD_MBHC_FIELD(WCD_MBHC_HS_L_DET_PULL_UP_COMP_CTRL, WCD939X_ANA_MBHC_MECH, 0x04),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_PLUG_TYPE, WCD939X_ANA_MBHC_MECH, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_GND_PLUG_TYPE, WCD939X_ANA_MBHC_MECH, 0x08),
> +	WCD_MBHC_FIELD(WCD_MBHC_SW_HPH_LP_100K_TO_GND, WCD939X_ANA_MBHC_MECH, 0x01),
> +	WCD_MBHC_FIELD(WCD_MBHC_ELECT_SCHMT_ISRC, WCD939X_ANA_MBHC_ELECT, 0x06),
> +	WCD_MBHC_FIELD(WCD_MBHC_FSM_EN, WCD939X_ANA_MBHC_ELECT, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_INSREM_DBNC, WCD939X_MBHC_NEW_PLUG_DETECT_CTL, 0x0F),
> +	WCD_MBHC_FIELD(WCD_MBHC_BTN_DBNC, WCD939X_MBHC_NEW_CTL_1, 0x03),
> +	WCD_MBHC_FIELD(WCD_MBHC_HS_VREF, WCD939X_MBHC_NEW_CTL_2, 0x03),
> +	WCD_MBHC_FIELD(WCD_MBHC_HS_COMP_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0x08),
> +	WCD_MBHC_FIELD(WCD_MBHC_IN2P_CLAMP_STATE, WCD939X_ANA_MBHC_RESULT_3, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_MIC_SCHMT_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0x20),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_SCHMT_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHR_SCHMT_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0x40),
> +	WCD_MBHC_FIELD(WCD_MBHC_OCP_FSM_EN, WCD939X_HPH_OCP_CTL, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_BTN_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0x07),
> +	WCD_MBHC_FIELD(WCD_MBHC_BTN_ISRC_CTL, WCD939X_ANA_MBHC_ELECT, 0x70),
> +	WCD_MBHC_FIELD(WCD_MBHC_ELECT_RESULT, WCD939X_ANA_MBHC_RESULT_3, 0xFF),
> +	WCD_MBHC_FIELD(WCD_MBHC_MICB_CTRL, WCD939X_ANA_MICB2, 0xC0),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPH_CNP_WG_TIME, WCD939X_HPH_CNP_WG_TIME, 0xFF),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHR_PA_EN, WCD939X_ANA_HPH, 0x40),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_PA_EN, WCD939X_ANA_HPH, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPH_PA_EN, WCD939X_ANA_HPH, 0xC0),
> +	WCD_MBHC_FIELD(WCD_MBHC_SWCH_LEVEL_REMOVE, WCD939X_ANA_MBHC_RESULT_3, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_ANC_DET_EN, WCD939X_MBHC_CTL_BCS, 0x02),
> +	WCD_MBHC_FIELD(WCD_MBHC_FSM_STATUS, WCD939X_MBHC_NEW_FSM_STATUS, 0x01),
> +	WCD_MBHC_FIELD(WCD_MBHC_MUX_CTL, WCD939X_MBHC_NEW_CTL_2, 0x70),
> +	WCD_MBHC_FIELD(WCD_MBHC_MOISTURE_STATUS, WCD939X_MBHC_NEW_FSM_STATUS, 0x20),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHR_GND, WCD939X_HPH_PA_CTL2, 0x40),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_GND, WCD939X_HPH_PA_CTL2, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_OCP_DET_EN, WCD939X_HPH_L_TEST, 0x01),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHR_OCP_DET_EN, WCD939X_HPH_R_TEST, 0x01),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHL_OCP_STATUS, WCD939X_DIGITAL_INTR_STATUS_0, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_HPHR_OCP_STATUS, WCD939X_DIGITAL_INTR_STATUS_0, 0x20),
> +	WCD_MBHC_FIELD(WCD_MBHC_ADC_EN, WCD939X_MBHC_NEW_CTL_1, 0x08),
> +	WCD_MBHC_FIELD(WCD_MBHC_ADC_COMPLETE, WCD939X_MBHC_NEW_FSM_STATUS, 0x40),
> +	WCD_MBHC_FIELD(WCD_MBHC_ADC_TIMEOUT, WCD939X_MBHC_NEW_FSM_STATUS, 0x80),
> +	WCD_MBHC_FIELD(WCD_MBHC_ADC_RESULT, WCD939X_MBHC_NEW_ADC_RESULT, 0xFF),
> +	WCD_MBHC_FIELD(WCD_MBHC_MICB2_VOUT, WCD939X_ANA_MICB2, 0x3F),
> +	WCD_MBHC_FIELD(WCD_MBHC_ADC_MODE, WCD939X_MBHC_NEW_CTL_1, 0x10),
> +	WCD_MBHC_FIELD(WCD_MBHC_DETECTION_DONE, WCD939X_MBHC_NEW_CTL_1, 0x04),
> +	WCD_MBHC_FIELD(WCD_MBHC_ELECT_ISRC_EN, WCD939X_ANA_MBHC_ZDET, 0x02),
> +};
> +
> +static const struct regmap_irq wcd939x_irqs[WCD939X_NUM_IRQS] = {
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_BUTTON_PRESS_DET, 0, 0x01),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_BUTTON_RELEASE_DET, 0, 0x02),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_ELECT_INS_REM_DET, 0, 0x04),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_ELECT_INS_REM_LEG_DET, 0, 0x08),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_SW_DET, 0, 0x10),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHR_OCP_INT, 0, 0x20),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHR_CNP_INT, 0, 0x40),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHL_OCP_INT, 0, 0x80),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHL_CNP_INT, 1, 0x01),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_EAR_CNP_INT, 1, 0x02),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_EAR_SCD_INT, 1, 0x04),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHL_PDM_WD_INT, 1, 0x20),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHR_PDM_WD_INT, 1, 0x40),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_EAR_PDM_WD_INT, 1, 0x80),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_MBHC_MOISTURE_INT, 2, 0x02),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHL_SURGE_DET_INT, 2, 0x04),
> +	REGMAP_IRQ_REG(WCD939X_IRQ_HPHR_SURGE_DET_INT, 2, 0x08),
> +};
> +
> +static struct regmap_irq_chip wcd939x_regmap_irq_chip = {
> +	.name = "wcd939x",
> +	.irqs = wcd939x_irqs,
> +	.num_irqs = ARRAY_SIZE(wcd939x_irqs),
> +	.num_regs = 3,
> +	.status_base = WCD939X_DIGITAL_INTR_STATUS_0,
> +	.mask_base = WCD939X_DIGITAL_INTR_MASK_0,
> +	.ack_base = WCD939X_DIGITAL_INTR_CLEAR_0,
> +	.use_ack = 1,
> +	.runtime_pm = true,
> +	.irq_drv_data = NULL,
> +};
> +
> +static int wcd939x_get_clk_rate(int mode)
> +{
> +	int rate;
> +
> +	switch (mode) {
> +	case ADC_MODE_ULP2:
> +		rate = SWR_CLK_RATE_0P6MHZ;
> +		break;
> +	case ADC_MODE_ULP1:
> +		rate = SWR_CLK_RATE_1P2MHZ;
> +		break;
> +	case ADC_MODE_LP:
> +		rate = SWR_CLK_RATE_4P8MHZ;
> +		break;
> +	case ADC_MODE_NORMAL:
> +	case ADC_MODE_LO_HIF:
> +	case ADC_MODE_HIFI:
> +	case ADC_MODE_INVALID:
> +	default:
> +		rate = SWR_CLK_RATE_9P6MHZ;
> +		break;
> +	}
> +
> +	return rate;
> +}
> +
> +static int wcd939x_set_swr_clk_rate(struct snd_soc_component *component, int rate, int bank)
> +{
> +	u8 mask = (bank ? 0xF0 : 0x0F);
> +	u8 val = 0;
> +
> +	switch (rate) {
> +	case SWR_CLK_RATE_0P6MHZ:
> +		val = 6;
> +		break;
> +	case SWR_CLK_RATE_1P2MHZ:
> +		val = 5;
> +		break;
> +	case SWR_CLK_RATE_2P4MHZ:
> +		val = 3;
> +		break;
> +	case SWR_CLK_RATE_4P8MHZ:
> +		val = 1;
> +		break;
> +	case SWR_CLK_RATE_9P6MHZ:
> +	default:
> +		val = 0;
> +		break;
> +	}
> +
> +	snd_soc_component_write_field(component, WCD939X_DIGITAL_SWR_TX_CLK_RATE, mask, val);
> +
> +	return 0;
> +}
> +
> +static int wcd939x_io_init(struct snd_soc_component *component)
> +{
> +	snd_soc_component_write_field(component, WCD939X_ANA_BIAS,
> +				      WCD939X_BIAS_ANALOG_BIAS_EN, 1);
All of these values are BIT()s or 2-4 ORed BIT()s, can you check what they
mean?

Same for almost all other snd_soc_component_ write/modify functions

[...]

> +static int wcd939x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
> +			       struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
> +	int bank;
> +	int rate;
> +
> +	bank = (wcd939x_swr_get_current_bank(wcd939x->sdw_priv[AIF1_CAP]->sdev)) ? 0 : 1;
> +	bank = bank ? 0 : 1;
this is just the return value of wcd939x_swr_get_current_bank NOTed twice

> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (strnstr(w->name, "ADC", sizeof("ADC"))) {
> +			int i = 0, mode = 0;
> +
> +			if (test_bit(WCD_ADC1, &wcd939x->status_mask))
> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC1]];
> +			if (test_bit(WCD_ADC2, &wcd939x->status_mask))
> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC2]];
> +			if (test_bit(WCD_ADC3, &wcd939x->status_mask))
> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC3]];
> +			if (test_bit(WCD_ADC4, &wcd939x->status_mask))
> +				mode |= tx_mode_bit[wcd939x->tx_mode[WCD_ADC4]];
> +
> +			if (mode != 0) {
> +				for (i = 0; i < ADC_MODE_ULP2; i++) {
> +					if (mode & (1 << i)) {
BIT(i)

> +						i++;
> +						break;
> +					}
the immediate break makes it look like you're just looking for the first set
bit, 1-indexed, and there's functions for that

> +				}
> +			}
> +			rate = wcd939x_get_clk_rate(i);
> +			wcd939x_set_swr_clk_rate(component, rate, bank);
> +			/* Copy clk settings to active bank */
> +			wcd939x_set_swr_clk_rate(component, rate, !bank);
This comment is very confusing

[...]

> +static void wcd939x_mbhc_get_result_params(struct snd_soc_component *component,
> +					   s16 *d1_a, u16 noff,
> +						int32_t *zdet)
very weird alignment

> +{
> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
> +	int i;
> +	int val, val1;
> +	s16 c1;
> +	s32 x1, d1;
> +	s32 denom;
> +	static const int mincode_param[] = {
static inside a function means something else than static global

> +		3277, 1639, 820, 410, 205, 103, 52, 26
> +	};
reverse-Christmas-tree

> +
> +	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MBHC_ZDET, 0x20, 0x20);
> +	for (i = 0; i < WCD939X_ZDET_NUM_MEASUREMENTS; i++) {
> +		regmap_read(wcd939x->regmap, WCD939X_ANA_MBHC_RESULT_2, &val);
> +		if (val & 0x80)
BIT(7), please name it

> +			break;
> +	}
> +	val = val << 0x8;
<< 8 makes more sense

> +	regmap_read(wcd939x->regmap, WCD939X_ANA_MBHC_RESULT_1, &val1);
> +	val |= val1;
> +	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MBHC_ZDET, 0x20, 0x00);
BIT()s

> +	x1 = WCD939X_MBHC_GET_X1(val);
> +	c1 = WCD939X_MBHC_GET_C1(val);
> +	/* If ramp is not complete, give additional 5ms */
> +	if (c1 < 2 && x1)
> +		usleep_range(5000, 5050);
udelay, see timers-howto.txt

[...]

> +static void wcd939x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
> +				       s32 *z_val, int flag_l_r)
> +{
> +	s16 q1;
> +	int q1_cal;
> +
> +	q1 = snd_soc_component_read(component, WCD939X_DIGITAL_EFUSE_REG_21 + flag_l_r);
> +	if (q1 & 0x80)
BIT
> +		q1_cal = (10000 - ((q1 & 0x7F) * 10));
GENMASK

> +	else
> +		q1_cal = (10000 + (q1 * 10));
> +	if (q1_cal > 0)
> +		*z_val = ((*z_val) * 10000) / q1_cal;
> +}
> +
> +static void wcd939x_wcd_mbhc_calc_impedance(struct snd_soc_component *component,
> +					    u32 *zl, uint32_t *zr)
> +{
> +	struct wcd939x_priv *wcd939x = dev_get_drvdata(component->dev);
> +	s16 reg0, reg1, reg2, reg3, reg4;
> +	s32 z1l, z1r, z1ls;
> +	int z_mono, z_diff1, z_diff2;
> +	bool is_fsm_disable = false;
> +	struct wcd939x_mbhc_zdet_param zdet_param[] = {
const

> +		{4, 0, 4, 0x08, 0x14, 0x18}, /* < 32ohm */
> +		{4, 0, 6, 0x18, 0x60, 0x78}, /* 32ohm < Z < 400ohm */
> +		{1, 4, 5, 0x18, 0x7C, 0x90}, /* 400ohm < Z < 1200ohm */
> +		{1, 6, 7, 0x18, 0x7C, 0x90}, /* >1200ohm */
> +	};
> +	struct wcd939x_mbhc_zdet_param *zdet_param_ptr = NULL;
> +	s16 d1_a[][4] = {
const

> +		{0, 30, 90, 30},
> +		{0, 30, 30, 6},
> +		{0, 30, 30, 5},
> +		{0, 30, 30, 5},
> +	};
> +	s16 *d1 = NULL;
????

[...]

> +
> +	rc = of_property_read_u32(np, "qcom,micbias1-microvolt",  &prop_val);
similarly to the swr port map, this should be commonized for WCDxxxx


Konrad
