Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4153680EAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjLLLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjLLLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:47:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74018D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:47:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso7928753a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702381658; x=1702986458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeJt1SlvJ2BjVo+T8o9WuujZC5zAwSMZRcDz9J4jRUA=;
        b=t5pLd39D1tYIG6PWp0XUaG3NAnrL3dNKizMtgTSts6mOHbgFeGoax3xr8MCRgJ+Fz1
         /kosS3OAbOeHW4hCdBMn3C/6fL/o9DF8WDX7rFZauR5jgyotXsBGYdhSQHpTPE0b6u2B
         rfgv4t3ZnUSVffmeeYQV0CwTEWREzBA+kouKpwvboF5g2m2AzdhBni3E3gdvAA+Pv1TU
         5WecKjPjKKaUE7RrMcAziZkJ4dRinErJhN1MVV5Ob/u0VTFTpz8rnQsT4TDPh3+9pTAr
         8BMxC5s4+wv964lI4k1j238HzUka9/b6YtOUMvS9c1kGWasaDuJILxBXSHq1DYfidFH3
         DbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381658; x=1702986458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeJt1SlvJ2BjVo+T8o9WuujZC5zAwSMZRcDz9J4jRUA=;
        b=fEVLYyMs8zNAEOP/1huN8pmofN6d9vkNccY3S1qx9vbUNKfN32pT2aNWzREFfNb8ra
         Y95ZJr5eG2b/JsHen7+PJFNRko5eDYeC6xMnreMdwHty2Yz1RWA2jeRjRgPIm1LAStrf
         lUz1n1GgG6bYhaRERCoeXHtaITWp5l/4GYoNGn+P+sZv4/nqgEXSAm0FsYWr2ML3QriR
         CZ8wfDocudwwKesux/SReKXeAi/1ZB6YDqA8wIbDQyFdcduEZdF//WdwE8WQifegZXjO
         B5dGHrphgMy22oX9GTnni/vVxk9sL7MdIuQEi4UJOY2BxSeE9nVSgf5bO0FD8SzAfDJg
         5wlw==
X-Gm-Message-State: AOJu0YwN/mjrQ/TfZpFst9qhjUPOiGMLyYEPSFlfpNwB95oUIApHBPrl
        plFk4FZgrQUL52cMhbTANRYQuLjnJI2xwdHFlk4=
X-Google-Smtp-Source: AGHT+IFjELsRWgldVYuEXuwAZ8zX+ftLOkWb54t7FJjL6MAEhFL8aAHQRMir0ZoV8uzFjZ7aN4mCxw==
X-Received: by 2002:aa7:cc86:0:b0:54c:c464:5b5 with SMTP id p6-20020aa7cc86000000b0054cc46405b5mr3354740edt.46.1702381657928;
        Tue, 12 Dec 2023 03:47:37 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k13-20020a50cb8d000000b0054cc7a4dc4csm4521908edi.13.2023.12.12.03.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 03:47:37 -0800 (PST)
Message-ID: <c43c4303-ed59-49e7-940a-62df6ad1b575@linaro.org>
Date:   Tue, 12 Dec 2023 11:47:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC, PATCH v2 1/2] ASoC: qcom: sdw: Add TDM support
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212095850.26482-1-lujianhua000@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231212095850.26482-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou for the patch,


On 12/12/2023 09:58, Jianhua Lu wrote:
> Add qcom TDM setup function to support TDM ports for qcom platform.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>    1. remove EXPORT_SYMBOL_GPL
>    2. remove static modifier
> 
>   sound/soc/qcom/sdw.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
> index 77dbe0c28b29..948abbd2e0e3 100644
> --- a/sound/soc/qcom/sdw.c
> +++ b/sound/soc/qcom/sdw.c
> @@ -4,6 +4,7 @@
>   
>   #include <dt-bindings/sound/qcom,q6afe.h>
>   #include <linux/module.h>
> +#include <sound/pcm_params.h>
>   #include <sound/soc.h>
>   #include "sdw.h"
>   
> @@ -101,6 +102,65 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
>   }
>   EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
>   
> +int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{

TBH, this should not be part of sdw.c file, its intended for more of 
soundwire specific helpers, pl consider moving this to common.c for now.
Because, Not all old qcom platforms have soundwire controllers.

> +	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +	unsigned int tdm_slot_offset[8] = { 0, 4, 8, 12, 16, 20, 24, 28 };
> +	int channels, slot_width;
> +	int ret;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		slot_width = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		slot_width = 24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		slot_width = 32;
> +		break;
> +	default:
> +		dev_err(rtd->dev, "%s: invalid param format 0x%x\n", __func__,
> +			params_format(params));
> +		return -EINVAL;
> +	}
> +
> +	channels = params_channels(params);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x3, 8, slot_width);

slot mask is always set to 2 channels in this case, should you not check 
the number of channels to determine the correct one?


These magic number 0, 0x3, 8 seems to make the code unreadable, can you 
do something like this:
snd_soc_dai_set_tdm_slot(cpu_dai, tx_mask, rx_mask, 
ARRAY_SIZE(tdm_slot_offset), slot_width);


> +		if (ret < 0) {
> +			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +
> +		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL, channels,
> +						  tdm_slot_offset);
> +		if (ret < 0) {
> +			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0, 8, slot_width);
> +		if (ret < 0) {
> +			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +
> +		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
> +						  tdm_slot_offset, 0, NULL);
> +		if (ret < 0) {
> +			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +	}
Finally  ./sound/soc/qcom/sdm845.c does have exactly same code, can you 
consider removing this and make use of this new helper in that file too.


> +}
> +
>   int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
>   			   struct snd_pcm_hw_params *params,
>   			   struct sdw_stream_runtime **psruntime)
> @@ -125,6 +185,9 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
>   				*psruntime = sruntime;
>   		}
>   		break;
> +	case PRIMARY_TDM_RX_0...QUINARY_TDM_TX_7:
> +		qcom_snd_tdm_hw_params(substream, params);
> +		break;
>   	}
>   
>   	return 0;
