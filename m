Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47E7D2CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJWImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJWImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:42:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE48D79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:42:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d9552d765so2229481f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698050551; x=1698655351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikJXXD4nCot/7ZdxIzEXxNGZwix+QfZwpIvhbz0HTEg=;
        b=HttbhHvsFpyMq4ZZSZddq//iIzKvN51ebsG+X6NNgTEa/MGt3liXELuPLtQDWnzHGb
         kuYUGEDLdFgXazA8e+kJE6AQ0xzW+YOx0z1EqLXqBao1ohAAHwhL1Wj4dgxxoZDj0LPT
         qkAhyVzeWRBiQo+RXaIevwqaZHSnfltniNhaN8s+rTh4DJNvuOztedm+BVfg9DonYGCP
         J3MgrB//p49JVdk6QsgfWB2aQ+xvr5f+nczdG8n/XT+FUY8D9gy40hRQIavRIVgUVhnP
         MzHMBFZ1jZSwSB/gCNagbjLv/lKJ8A5TwHc9LF+n7Gi/pCpFDYZRf6S3cEpCYPuzoG2b
         rFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050551; x=1698655351;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikJXXD4nCot/7ZdxIzEXxNGZwix+QfZwpIvhbz0HTEg=;
        b=Tbr+GegocM34B5/+H8bySdHtCMaAa9fagQWgFvBLRPbqQx6Ia5kWERDuROVw6alhrP
         269tOkfmPgc2+HmxT4qxjIrPT37Rg2Ng/hmSQNubImn505Hit353bic4UqYRLiCgdpaw
         hamJLVNi+s/zCtw1V0oBsqOD9c4yWsknNJVLEPEbFxgMAwvYmXp2DhnLuNzOoKro1hNR
         v2GN2Hjf8fXl8+r+XxCzW8D/Mqo7ApvJRMsWPrst9I0VRMkemOk0xNaEDR/0Ghop51D+
         jskJcsT85Y452zW9Kh8MhzmDCqeKdUK9P+TC4qxMx4+hoPJPMBQ+2jR/0/nyffqOgTQP
         XT+g==
X-Gm-Message-State: AOJu0Yz6LjwX7CMYNSW2WJQzRpfs+IPo/jZHqehCxAhXrum4j3ia1vZt
        vI8bic2tHvQn7zbKEdQBDjWogA==
X-Google-Smtp-Source: AGHT+IGbjC803OKFjmD9fXv2m4GNealji5lyvQv0lU9QHvhBHK1BefFG3amc4POEJpiMP3omf+9KeA==
X-Received: by 2002:a5d:6392:0:b0:32d:827e:7bd8 with SMTP id p18-20020a5d6392000000b0032d827e7bd8mr7171371wru.70.1698050551160;
        Mon, 23 Oct 2023 01:42:31 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d17-20020a5d6451000000b0032da022855fsm7244090wrw.111.2023.10.23.01.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 01:42:30 -0700 (PDT)
Message-ID: <f882b666-8a68-4341-a143-cb226ab7d22b@linaro.org>
Date:   Mon, 23 Oct 2023 09:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: audioreach: Add 4 channel support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20231020084919.18628-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231020084919.18628-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,

On 20/10/2023 09:49, Krzysztof Kozlowski wrote:
> Add support four channel streams.  Map channel 3 and 4 to left/right
> surround ("quad(side)" from ffmpeg standard channel list) to match what
> is in qdsp6/q6dsp-common.c driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

> ---
> 
> quad(side):
> https://trac.ffmpeg.org/wiki/AudioChannelManipulation#Listchannelnamesandstandardchannellayouts
> ---
>   sound/soc/qcom/qdsp6/audioreach.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 5974c7929dd3..4dd2a2e261c9 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -833,6 +833,11 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
>   	} else if (num_channels == 2) {
>   		media_format->channel_mapping[0] = PCM_CHANNEL_L;
>   		media_format->channel_mapping[1] = PCM_CHANNEL_R;
> +	} else if (num_channels == 4) {
> +		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
> +		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
> +		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
> +		media_format->channel_mapping[3] = PCM_CHANNEL_RS;


These are fine, but duplicated from q6dsp_map_channels(), Please 
consider using q6dsp_map_channels().

Also when you do that pl get rid of PCM_CHANNEL_L and PCM_CHANNEL_R 
defines in audioreach.h


thanks,
--srini

>   	}
>   
>   	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
> @@ -869,6 +874,11 @@ static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
>   		} else if (mcfg->num_channels == 2) {
>   			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
>   			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_R;
> +		} else if (mcfg->num_channels == 4) {
> +			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_FL;
> +			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_FR;
> +			mp3_cfg->channel_mapping[2] =  PCM_CHANNEL_LS;
> +			mp3_cfg->channel_mapping[3] =  PCM_CHANNEL_RS;
>   		}
>   		break;
>   	case SND_AUDIOCODEC_AAC:
> @@ -1057,7 +1067,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
>   	int rc, payload_size;
>   	struct gpr_pkt *pkt;
>   
> -	if (num_channels > 2) {
> +	if (num_channels > 4) {
>   		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
>   		return -EINVAL;
>   	}
> @@ -1094,7 +1104,11 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
>   	} else if (num_channels == 2) {
>   		media_cfg->channel_mapping[0] = PCM_CHANNEL_L;
>   		media_cfg->channel_mapping[1] = PCM_CHANNEL_R;
> -
> +	} else if (num_channels == 4) {
> +		media_cfg->channel_mapping[0] = PCM_CHANNEL_FL;
> +		media_cfg->channel_mapping[1] = PCM_CHANNEL_FR;
> +		media_cfg->channel_mapping[2] = PCM_CHANNEL_LS;
> +		media_cfg->channel_mapping[3] = PCM_CHANNEL_RS;
>   	}
>   
>   	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
> @@ -1116,7 +1130,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
>   	struct gpr_pkt *pkt;
>   	void *p;
>   
> -	if (num_channels > 2) {
> +	if (num_channels > 4) {
>   		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
>   		return -EINVAL;
>   	}
> @@ -1158,6 +1172,11 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
>   		else if (num_channels == 2) {
>   			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
>   			cfg->channel_mapping[1] =  PCM_CHANNEL_R;
> +		} else if (num_channels == 4) {
> +			cfg->channel_mapping[0] =  PCM_CHANNEL_FL;
> +			cfg->channel_mapping[1] =  PCM_CHANNEL_FR;
> +			cfg->channel_mapping[2] =  PCM_CHANNEL_LS;
> +			cfg->channel_mapping[3] =  PCM_CHANNEL_RS;
>   		}
>   	} else {
>   		rc = audioreach_set_compr_media_format(header, p, mcfg);
