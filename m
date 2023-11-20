Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B017F0E45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjKTI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:57:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB0AA;
        Mon, 20 Nov 2023 00:57:32 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D798B6603149;
        Mon, 20 Nov 2023 08:57:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700470651;
        bh=d23ZT5zVaG2k3DicMJVOBp0FoX7BK2oj+2zL9rkLlcU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jFG/4oQkTiPCuFeWdj+hKl+IkpmsojIFQH+cPvfEWyMlJLPEfzYgpC5vo3ZDDcbPj
         O/ygRUdSfa+jCME81v7FE0srl3G9yeaK9m1nub4CTXF70ffpom3huQQvk1bFence5W
         4+Gsk+5L/npS23XvSMwPXt6c8++JAVJ9JUnXoWrdeA0Zzd8LmfqtGKoDKapMfTJ2o9
         yN147CWiV5TaVRcAlkzg0NjsLqUEbvMH6M+Qhu5acHZkXc0Xi10CCtqJ9GbZaftzjK
         AxJGSyXO2Dfo9g+0ULn20qDO/J3Ax1Rt3TGn3NBeBltmuJa0u9ekcZXXxu1tOJls+4
         5ZAGzDZSmIvnQ==
Message-ID: <0b95d90d-5dd3-43da-a860-6a84019d097a@collabora.com>
Date:   Mon, 20 Nov 2023 09:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8186: trivial: align code
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-sound@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20231117160914.65341-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231117160914.65341-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/11/23 17:09, Eugen Hristev ha scritto:
> No functionality change, squash some lines and align parameters for
> function prototypes to 80 chars.
> 

Please use scripts/get_maintainer.pl to get the correct recipients list.

> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-afe-control.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-control.c b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> index 55edf6374578..dda648c1e8f8 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> @@ -181,7 +181,8 @@ static unsigned int pcm_rate_transform(struct device *dev, unsigned int rate)
>   	return MTK_AFE_PCM_RATE_48K;
>   }
>   
> -unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev, unsigned int rate)
> +unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev,
> +					       unsigned int rate)

That's not needed, 86 columns is ok.

>   {
>   	switch (rate) {
>   	case 8000:
> @@ -222,7 +223,8 @@ unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev, unsigned int
>   	return MTK_AFE_TDM_RELATCH_RATE_48K;
>   }
>   
> -unsigned int mt8186_rate_transform(struct device *dev, unsigned int rate, int aud_blk)
> +unsigned int mt8186_rate_transform(struct device *dev, unsigned int rate,
> +				   int aud_blk)

Same here, not needed.

>   {
>   	switch (aud_blk) {
>   	case MT8186_DAI_PCM:
> @@ -234,14 +236,13 @@ unsigned int mt8186_rate_transform(struct device *dev, unsigned int rate, int au
>   	}
>   }
>   
> -int mt8186_dai_set_priv(struct mtk_base_afe *afe, int id, int priv_size, const void *priv_data)
> +int mt8186_dai_set_priv(struct mtk_base_afe *afe, int id, int priv_size,
> +			const void *priv_data)

ditto.

>   {
>   	struct mt8186_afe_private *afe_priv = afe->platform_priv;
>   	void *temp_data;
>   
> -	temp_data = devm_kzalloc(afe->dev,
> -				 priv_size,
> -				 GFP_KERNEL);
> +	temp_data = devm_kzalloc(afe->dev, priv_size, GFP_KERNEL);

The only change I agree on is this one... but I don't know if it's even worth
making a commit for just this...

Regards,
Angelo

