Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D2804BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjLEIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjLEIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:10:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6B1B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:10:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so3280074f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701763828; x=1702368628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To/Mq2O0SV6zWZcXoTJ9H+fWGk7Vh7ECSWv1vGXoxV8=;
        b=VubNunKJ7u9puIOfkvWwjg3oZY/lgpP60nL6U25XzJeLuhFf6RPxYeeAy2t8Mfa/J3
         8Nz4iyTVdZXvlJpvnQwa/jFzL6e1Zy8G4RumKm9HFmC9hy+Yw2cNBesAHzedwmO2Y+gn
         13j6PQiVHPv3IAe9VxmSOKSqMm2QASMCErN3MlKc27WZ62uvZUNjFLoFjXgXtKs/anXl
         ROBio7UHz/wF5P6tEJoBHkRizAiWYHCLCRZq28zEyRUgpV4eUjw7zqYfBHJExkGzdDbf
         zEd/1FojtZq5Js31wdsHMWwt+aANLIH7PHia3Lxf29kxGypGbDZpx9w+bfcLJTxyQaUk
         uZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763828; x=1702368628;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=To/Mq2O0SV6zWZcXoTJ9H+fWGk7Vh7ECSWv1vGXoxV8=;
        b=GpY8cKJdBHHeYJGS2SB1Cae4Wecv8hgELwky7+X/SXUGisTXb0FHuOncQn8LUdjKCT
         Wok/Krz2G/W5JOZcVwyf5GSCSulqoa4I3/H3EEBJNA7/3h1Pguo2izuumSomAMpY7+fG
         VaG3Z0L3daP9rBmCBCGlre9z12tDIvI2Bv3O36mDL0p9fuklNXjr7kMrz97HXlVieFYx
         BE772pEYvMzP7ukO3mjChbb11OumauTBrbWkbv3O8ynHho3vLmbfXnfUjmvpqbuvtTNf
         6R1BrmsyScpt/+SHn5XLvTkEGKo3FGt/qo2chM1CRER/xFZm0DzpVP/8UCFIc5pQ0Wlx
         BkKA==
X-Gm-Message-State: AOJu0YzXdtAPxqdYz7Qel/eJziK+fYcVzeIWfmghjh39kYmTLFfLin/x
        e2WHP56orh6FGtqONmvgE/DwcWxN66BrQxOL2iZcG4ak
X-Google-Smtp-Source: AGHT+IGhDFqeShgQA4Pk8/vOpc1HDnxCnHlNuoz9DLOG7dl0MVGgDo/Cij1RIQmi4hoykuvg9IINuQ==
X-Received: by 2002:a5d:6851:0:b0:333:214e:e447 with SMTP id o17-20020a5d6851000000b00333214ee447mr442779wrw.34.1701763827983;
        Tue, 05 Dec 2023 00:10:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb? ([2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb])
        by smtp.gmail.com with ESMTPSA id b7-20020a056000054700b003334460e256sm5976126wrf.92.2023.12.05.00.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:10:27 -0800 (PST)
Message-ID: <46d949fc-e30d-4c90-9d98-62501be5fc03@linaro.org>
Date:   Tue, 5 Dec 2023 09:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 09/10] drm/panel: ilitek-ili9805: add support for
 Tianma TM041XDHG01 panel
Content-Language: en-US, fr
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
 <20231130141705.1796672-10-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20231130141705.1796672-10-dario.binacchi@amarulasolutions.com>
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

On 30/11/2023 15:16, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Tianma TM041XDHG01 utilizes the Ilitek ILI9805 controller.
> 
> Add this panel's initialzation sequence and timing to ILI9805 driver.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 53 ++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> index 749959e10d92..cd187b0b1998 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -89,6 +89,36 @@ static const struct ili9805_instr gpm1780a0_init[] = {
>   	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
>   };
>   
> +static const struct ili9805_instr tm041xdhg01_init[] = {
> +	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> +		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
> +	ILI9805_INSTR(100, 0xFD, 0x0F, 0x13, 0x44, 0x00),
> +	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
> +		      0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01),
> +	ILI9805_INSTR(0, 0xB8, 0x74),
> +	ILI9805_INSTR(0, 0xF1, 0x00),
> +	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
> +	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
> +	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
> +	ILI9805_INSTR(0, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> +		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
> +	ILI9805_INSTR(0, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> +		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
> +	ILI9805_INSTR(10, 0xc1, 0x15, 0x03, 0x03, 0x31),
> +	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
> +	ILI9805_INSTR(10, 0xB4, 0x02),
> +	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
> +	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x0a),
> +	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
> +	ILI9805_INSTR(0, 0x20),
> +	ILI9805_INSTR(0, 0xB0, 0x00),
> +	ILI9805_INSTR(0, 0xB6, 0x01),
> +	ILI9805_INSTR(0, 0xc2, 0x11),
> +	ILI9805_INSTR(0, 0x51, 0xFF),
> +	ILI9805_INSTR(0, 0x53, 0x24),
> +	ILI9805_INSTR(0, 0x55, 0x00),
> +};
> +
>   static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct ili9805, panel);
> @@ -239,6 +269,20 @@ static const struct drm_display_mode gpm1780a0_timing = {
>   	.vtotal = 480 + 2 + 4 + 10,
>   };
>   
> +static const struct drm_display_mode tm041xdhg01_timing = {
> +	.clock = 26227,
> +
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 10,
> +	.hsync_end = 480 + 10 + 2,
> +	.htotal = 480 + 10 + 2 + 36,
> +
> +	.vdisplay = 768,
> +	.vsync_start = 768 + 2,
> +	.vsync_end = 768 + 10 + 4,
> +	.vtotal = 768 + 2 + 4 + 10,
> +};
> +
>   static int ili9805_get_modes(struct drm_panel *panel,
>   			      struct drm_connector *connector)
>   {
> @@ -343,8 +387,17 @@ static const struct ili9805_desc gpm1780a0_desc = {
>   	.height_mm = 65,
>   };
>   
> +static const struct ili9805_desc tm041xdhg01_desc = {
> +	.init = tm041xdhg01_init,
> +	.init_length = ARRAY_SIZE(tm041xdhg01_init),
> +	.mode = &tm041xdhg01_timing,
> +	.width_mm = 42,
> +	.height_mm = 96,
> +};
> +
>   static const struct of_device_id ili9805_of_match[] = {
>   	{ .compatible = "giantplus,gpm1790a0", .data = &gpm1780a0_desc },
> +	{ .compatible = "tianma,tm041xdhg01", .data = &tm041xdhg01_desc },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ili9805_of_match);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
