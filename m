Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C147F2DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjKUMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjKUMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:54:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB00D4D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:54:11 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A2106607314;
        Tue, 21 Nov 2023 12:54:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571250;
        bh=/LVVlw8gLQB6ZTo1Kr0Z/aF5RSngTPxFRD7QwxrFOpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KRoS6ryt/WYniBln8ggcPoFRpSf2hELuGwRk5vEKV57FaSF/OhaMn7pw6HATLUid0
         t3YnB5WzEoW5hv9xLGA1oov5MuXgkxJCboyVzaIFdZmNXlUDPopGWhi2clWveC5soS
         sw6x0W7q/qLT74sl0FnT8YQDYzuw5nhJ24a7mAR6oZfz192w6Qg1vw+9LxdxDV80ay
         SMxxGNOnZWeWM+X9TUqpxfNfR/sp5Hkz9JQqCK4Iy+YOmYdFZKo3HEUo5nQqO4PWMv
         exCr0IhXGrikqYZMHHAPMrV8gKlCqSQTg+JQZxtm9CVYK3/sJ5iuShaB+5REt/ovtb
         9xAnW2PErb8Vg==
Message-ID: <c35ef2d8-ab40-484b-9a4c-38f2f3e7d99c@collabora.com>
Date:   Tue, 21 Nov 2023 13:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 3/3] drm/bridge: it6505: Add audio support
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        kuninori.morimoto.gx@renesas.com, nfraprado@collabora.com
Cc:     chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        allen-kh.cheng@mediatek.com, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
 <20230730180803.22570-4-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230730180803.22570-4-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 30/07/23 20:08, Jiaxin Yu ha scritto:
> Add audio support for it6505
> 
> 1. Bridge to hdmi-codec to support audio feature. At the same time,
>     the function of automatically detecting audio is removed.
> 2. It is observed that some DP-to-HDMI dongles will get into bad
>     states if sending InfoFrame without audio data. Defer to enable
>     it6505's audio feature when PCM triggers START or RESUME.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Hello Jiaxin,
this patch doesn't apply anymore (and it won't build anymore) upstream.

> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 81 ++++++++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 504d51c42f79..1cfcb0731288 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2162,7 +2162,6 @@ static void it6505_stop_link_train(struct it6505 *it6505)
>   
>   static void it6505_link_train_ok(struct it6505 *it6505)
>   {
> -	struct device *dev = &it6505->client->dev;

This is because this changed to `struct device *dev = it6505->dev;`

>   
>   	it6505->link_state = LINK_OK;
>   	/* disalbe mute enable avi info frame */
> @@ -2170,11 +2169,6 @@ static void it6505_link_train_ok(struct it6505 *it6505)
>   	it6505_set_bits(it6505, REG_INFOFRAME_CTRL,
>   			EN_VID_CTRL_PKT, EN_VID_CTRL_PKT);
>   
> -	if (it6505_audio_input(it6505)) {
> -		DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
> -		it6505_enable_audio(it6505);
> -	}
> -
>   	if (it6505->hdcp_desired)
>   		it6505_start_hdcp(it6505);
>   }
> @@ -2846,6 +2840,45 @@ static void __maybe_unused it6505_audio_shutdown(struct device *dev, void *data)
>   		it6505_disable_audio(it6505);
>   }
>   
> +static int it6505_audio_hw_params(struct device *dev, void *data,
> +				  struct hdmi_codec_daifmt *daifmt,
> +				  struct hdmi_codec_params *params)
> +{
> +	struct it6505 *it6505 = dev_get_drvdata(dev);
> +
> +	return it6505_audio_setup_hw_params(it6505, params);
> +}
> +
> +static int it6505_audio_setup_trigger(struct it6505 *it6505, int cmd)
> +{
> +	struct device *dev = &it6505->client->dev;

...and because you'll have to change this one, and other occurrences of that
as well.

Can you please respin this series?

Thanks,
Angelo


