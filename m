Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5377D2B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjJWHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjJWHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:35:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D55D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:35:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40839807e82so16459895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698046506; x=1698651306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thL10AgtDXcVFAC/XjwiBG2IUEW1O1jkUpxL/3Y8WKI=;
        b=XPiNTMV8rwRsRparj9hiIeehekH6p2ZPKTttusakB/0vvXynoY2kIQQ7OB/t0hgn83
         mmUL/2DmIqcZZuzOhcC0QWYRCf/Evn+rQ1iCqSWN/zVUCsJ9F4Dpky3Pe8W5b7Pk68IK
         y7o8WzAMmV11Io4lozGp0QyIv8m7oXRSIAmwLPDwnLu9MK7fKF/yZDTvmoelg+LsLtmx
         q+FiPD5F47G/hFIaKCsDw3tGwQtDBs8V2tG9re2wNTfGsHJZvS8S+RbT4IfaGrERpxQE
         /2e4q5+h++FIp8WbxhVn0ZJLEKXw6Yw2BVaM49W/teH/RKV6tHbWKR9SJZdEWoFAgnLC
         SvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698046506; x=1698651306;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=thL10AgtDXcVFAC/XjwiBG2IUEW1O1jkUpxL/3Y8WKI=;
        b=ZA9UDaNhstULMH6rnQEnBCF3xgu223Gs4cfyAuIuQaj6SfF0kIG0YCtVmAb7HQV00d
         sk5IHEz/dv/pSYYJCu67gkzG3Fuqy5kTCyF409uhGOrKEMrBaTdyL25w/llNS34GnXAF
         QrEQ40D9KJ1ReX49+1qsGf4hqbpcMhIb26FE3jQIxI6JfMdZHB/UhMwupi1MBI/nAaCw
         wFftktuVIGzQ2XkRrqzC0ZmZF/k+RMuTe6sf5y4GIqRkg0uY+MJ+ttkkvdW4SJh7+jZh
         RGQmTDcCgwALEfvCzhxX3erROvOnp7L0gUgZrUhl6YTSHj1Gk1OGKVRNBilXFF/Wr50x
         1KUg==
X-Gm-Message-State: AOJu0Yy8Wk+RgAqkkytJFsy5aHloeCqendHB6W1r2L4uihG95CVLZ+tz
        Au7Eqy2KrppXmEccClHTvY8xOg==
X-Google-Smtp-Source: AGHT+IE11hzOY1C0U/CiqWSN0+Aml9paQ0JcnCha4kc3llgl6mqXauCCgwyskR0Du4qE9ZQDWzZqTw==
X-Received: by 2002:a05:600c:4fc6:b0:405:19dd:ad82 with SMTP id o6-20020a05600c4fc600b0040519ddad82mr8126066wmq.16.1698046506218;
        Mon, 23 Oct 2023 00:35:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b004063cd8105csm13550614wms.22.2023.10.23.00.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:35:05 -0700 (PDT)
Message-ID: <d941462e-1ac8-4dce-bd09-ddb99d79578a@linaro.org>
Date:   Mon, 23 Oct 2023 09:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 18:53, Dmitry Baryshkov wrote:
> The MIPI DSI links do not fully fall into the DRM callbacks model. The
> drm_bridge_funcs abstraction. Instead of having just two states (off and
> on) the DSI hosts have separate LP-11 state. In this state the host is
> on, but the video stream is not yet enabled.
> 
> Introduce API that allows DSI bridges / panels to control the DSI host
> power up state.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
>   2 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 14201f73aab1..c467162cb7d8 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
>   
> +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops = host->ops;
> +
> +	return ops && ops->power_up;
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_control_available);
> +
> +int mipi_dsi_host_power_up(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops = host->ops;
> +
> +	if (!mipi_dsi_host_power_control_available(host))
> +		return -EOPNOTSUPP;
> +
> +	return ops->power_up ? ops->power_up(host) : 0;
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_up);
> +
> +void mipi_dsi_host_power_down(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops = host->ops;
> +
> +	if (!mipi_dsi_host_power_control_available(host))
> +		return;
> +
> +	if (ops->power_down)
> +		ops->power_down(host);
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_down);
> +
>   static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
>   					struct mipi_dsi_msg *msg)
>   {
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 167742e579e3..e503c3e4d057 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -68,6 +68,8 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
>    * @attach: attach DSI device to DSI host
>    * @detach: detach DSI device from DSI host
>    * @transfer: transmit a DSI packet
> + * @power_up: enable DSI link and bring it to the LP-11 state
> + * @power_down: fully disable DSI link
>    *
>    * DSI packets transmitted by .transfer() are passed in as mipi_dsi_msg
>    * structures. This structure contains information about the type of packet
> @@ -81,10 +83,18 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
>    * function will seldomly return anything other than the number of bytes
>    * contained in the transmit buffer on success.
>    *
> - * Also note that those callbacks can be called no matter the state the
> - * host is in. Drivers that need the underlying device to be powered to
> - * perform these operations will first need to make sure it's been
> - * properly enabled.
> + * Note: currently there are two modes of DSI power control. Legacy drivers
> + * will call those callbacks no matter the state the host is in. DSI host
> + * drivers that need the underlying device to be powered to perform these
> + * operations will first need to make sure it's been properly enabled.
> + *
> + * Newer drivers will set the @MIPI_DSI_MANUAL_POWERUP flag to indicate that
> + * they will call @mipi_dsi_power_up() and @mipi_dsi_power_down() to control
> + * the link state of the DSI host or they will set @MIPI_DSI_AUTO_POWERUP to
> + * indicate that the driver is fine with the link being powered up in DSI
> + * host's (atomic_)pre_enable() callback and then being disabled in the
> + * (atomic_)post_disable() callback. The transfer callback must only be called
> + * if the DSI host has been powered up and was not brought down.
>    *
>    * Note: some hosts (sunxi) can not send LP commands between HS video
>    * packets. Thus all DSI transfers sent in LP mode should be limited to the
> @@ -97,6 +107,8 @@ struct mipi_dsi_host_ops {
>   		      struct mipi_dsi_device *dsi);
>   	ssize_t (*transfer)(struct mipi_dsi_host *host,
>   			    const struct mipi_dsi_msg *msg);
> +	int (*power_up)(struct mipi_dsi_host *host);
> +	void (*power_down)(struct mipi_dsi_host *host);
>   };
>   
>   /**
> @@ -143,6 +155,10 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
>   #define MIPI_DSI_MODE_LPM		BIT(11)
>   /* transmit data ending at the same time for all lanes within one hsync */
>   #define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
> +/* DSI peripheral driver manually controls DSI link powerup */
> +#define MIPI_DSI_MANUAL_POWERUP		BIT(13)
> +/* DSI peripheral driver is fine with automatic DSI link power control */
> +#define MIPI_DSI_AUTO_POWERUP		BIT(14)

What happens if none of the bits are in the flags ?

Can't we implement "opportunistic power-up" on the first DSI command sent?

If a bridge/panel sends a DSI command, and if it happens before the DSI host enable, then
the DSI host will "pre-enable" the host and put the link in LP-11.

This would be simpler and would work whatever the pre_enable order.

But this won't work for the tc358767, except if we add a dummy DSI host command
which powers up the DSI link.

This won't fix the PS8640 either who also needs a disabled DSI link to initialize.

Neil

>   
>   enum mipi_dsi_pixel_format {
>   	MIPI_DSI_FMT_RGB888,
> @@ -235,6 +251,11 @@ void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi);
>   struct mipi_dsi_device *
>   devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *host,
>   				   const struct mipi_dsi_device_info *info);
> +
> +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host);
> +int mipi_dsi_host_power_up(struct mipi_dsi_host *host);
> +void mipi_dsi_host_power_down(struct mipi_dsi_host *host);
> +
>   struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
>   int mipi_dsi_attach(struct mipi_dsi_device *dsi);
>   int mipi_dsi_detach(struct mipi_dsi_device *dsi);

