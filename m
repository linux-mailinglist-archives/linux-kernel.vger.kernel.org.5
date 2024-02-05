Return-Path: <linux-kernel+bounces-52465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF05849888
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAE81F2163C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4B18AEE;
	Mon,  5 Feb 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC+Db8CL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CF182DB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131492; cv=none; b=huZMsWhNGkSJImsNm3r4KApFox0oCdosQQjf7Osc+c+t5ifCG+SwmSElTNU4VKsazn4EM0J99GQdPIyS3+6rsDJqZVZKD2IHa+aUOt+CdXoSr7p7ERU9CoC2MtA2+bIc/53LBAPzvCFeKPLoEYDMPgLD11agFjIwrLEoPaQ1oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131492; c=relaxed/simple;
	bh=gQAq4MweqwA6aUXk7QZgO7xIzbNXacDqV8af2G+cUT8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=IImzHzq+zBcU5tAmYv9qW7yDw96kasADbarPsdAYNiDP8zl8DG1SLNM47TTbiKyEbIg+/Hu78Qmi1NY2MOJgu+4j9MQghIa25KihOKU+K6KTvpC6FLtAP8jrXGiQc3zgM/4YfAqg3zgYO7kxEeQZOicogJpec071aJNkFuoQXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cC+Db8CL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb94d42e4so34245465e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707131488; x=1707736288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QVsuijCPHavEWHOWRMszbUszZyTVOD/XUq0yupfoag=;
        b=cC+Db8CLIU5tsUebgiGf0unvwI1SKmwO8zXMlp0V3EA0jRYnQFulVj4eniO8ICtBbH
         Adjs9lMWR16zzu94nAue2QPFSznCMozCX1bAELhxoiyV5Z7HbxLD1JuvohOvalHCkEDY
         pIL3sZraNQ44LKSFZh5oMR3uBVdqMQ+hTmKbv9C0OAx2s7EtqEMprwYN++2NmoTgNlPg
         sVZA/gjQJq83IGb613I7hj3uX3/SI5Zfxo4Jv/eMCF8J/fE2CzPE608Rhpmb7fEjo+yu
         4OsMidOwj3wxclgX3jTXlKBnrMgQlFmKAW9EvxM2rLmvL4mCXld6Afq0wV9mJ/UjpAU/
         wuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131488; x=1707736288;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QVsuijCPHavEWHOWRMszbUszZyTVOD/XUq0yupfoag=;
        b=ZCx3boLXGb/JZGDDD7DK79tuLNKDbK0s55plbDNgxjhu65y+k9Sqb/YVy1P59uAb5t
         0tKcUI29FyaDUQAufwFqyF7cRjiyAkrtiTuL5De0Et1Mx6hACDS4TB+xPnPVxXn7UFor
         rZ+safZLHm7DU0C0VrlQN9h/Rj7WYzNuKeXbtyBuNZDpfLRI7rBwRCqk2GNgY9AWYheA
         GghJCWH9hU3iT1N6aRnBlpYPcARHjTpGmeFDWmIx5LPDL4zIEZj7MUb9wgqQX9/ngXBc
         j/IBvaTSPOfmVxGpXQ7mT0gozjpDTrSorgaGtagUytmmnlNmWnzgXpo9a/QunJD5LhkO
         yIwA==
X-Gm-Message-State: AOJu0YyP4a0nKJq7H4rr5C/DYxBHrFqIhnDMg7Nw7WBsDfwJ0Fsuj7+7
	02wMDnG//74Cdsm8NSMM9FIjZwkDd7gNZaV55n+m53kz02OVcjmjhEudkWyy8uM=
X-Google-Smtp-Source: AGHT+IHeNi8zOfHZpHG+NK3C6r+3T2tlwokp9RHj8nQZrYHIZBpSSe9OCT8a/oJWZ5iu8mlykl//qA==
X-Received: by 2002:a5d:4049:0:b0:33a:f51a:f7ba with SMTP id w9-20020a5d4049000000b0033af51af7bamr9126863wrp.49.1707131487986;
        Mon, 05 Feb 2024 03:11:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvigXlFQQMYWA2AQh0+z0n7vfZG/ztnOFu0Zbs+LGR6Co+U8dVpdx0SVlZ89TC7JQG25mr5l27Ul9t8fVsvMxKsyEiuD2vdfdRS/5AQ2zl8kdzj2ZTDpgmEiWNZZw/+vTO1GyzPY5G9SXhEcYyaO4Ey4bL+laVtph0QGR61c0/KN8aE4t13AzqE2nUU842m5FRBW3RfuZCBorDYSNQcSJCF1bX4CNhF2shtj27LWRlSm/J05B/tQH227jLGjZHt0SWRmQoHK3SUREXXVTGtahz1sJYSHGDiQ+SYM3A8tjappCzy7gbFMXRh59/VLwh0NrJ4auEOyw+ntCWNcRyIQPqdmkuLYZMmtSKfARgg59Ed3pxJzCuR62csiWr0DJV7sIWT7+jOw+YTwAfl353pSeIKZPI/9Q87EENdjEm0o/r/cVCMEJOkjhqRkUOcN5TSyOWfl17oGcFHqRk+vR/JlJMxJGBH+V+q5aWknURFOaeK/Rvwr3WrdYmZ354dlFbVAYoVqzjHbo6o8ZH7hsdkNvXMhIWUbubrQk0Acc1vUeuos1phY7xJvt95A4aD0iJuo6LSh6mGJwy4Tib98Ij3ZadR6N2mjVuUhTLj4nbR5T5DB1dzsS4/U7VXH57T5ZUIQMrMnKsCi2DF28NCrbky7GSlod9VX+/b65UNuICyfFqkMQdBwPiT9UccXFPXme99vlCxz85F4nHf66d1zSSqrDLg/kwTpD94AiKvqNpv37+D6uu4f2zeGB3L6mYYm1eqFOM6lONTrdi7XquNSgN4rpE920BonIFZuSiTQJovgttIhn5F5iTOuZZ6C+CZf/kVnIxUr+W3rZOxSaqeFIXYMxUe27sJcyAfDtM/hQJQwyBwaBAWR0sfixVEhMhfDxM/KzY+9tUG0/OU3jKFRB4C9uF0hiiAkHEOqA1iaju5NXIb8Efr29cTYS6RJV4JRiUUuDuk9
 bcWXqD0qat
Received: from ?IPV6:2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662? ([2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d45c1000000b0033b28a784dcsm5799075wrs.114.2024.02.05.03.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 03:11:27 -0800 (PST)
Message-ID: <5109d6c0-07b0-4915-9b80-5b562431fd48@linaro.org>
Date: Mon, 5 Feb 2024 12:11:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [linux][PATCH v2 2/4] drm/bridge: add lvds controller support for
 sam9x7
Content-Language: en-US, fr
To: Dharma Balasubiramani <dharma.b@microchip.com>, andrzej.hajda@intel.com,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, geert+renesas@glider.be, arnd@arndb.de,
 hari.prasathge@microchip.com, Jason@zx2c4.com, rientjes@google.com,
 rdunlap@infradead.org, vbabka@suse.cz, manikandan.m@microchip.com
References: <20240205110609.217022-1-dharma.b@microchip.com>
 <20240205110609.217022-3-dharma.b@microchip.com>
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
In-Reply-To: <20240205110609.217022-3-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 05/02/2024 12:06, Dharma Balasubiramani wrote:
> Add a new LVDS controller driver for sam9x7 which does the following:
> - Prepares and enables the LVDS Peripheral clock
> - Defines its connector type as DRM_MODE_CONNECTOR_LVDS and adds itself
> to the global bridge list.
> - Identifies its output endpoint as panel and adds it to the encoder
> display pipeline
> - Enables the LVDS serializer
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changelog
> v1 -> v2
> - Drop 'res' variable and combine two lines into one.
> - Handle deferred probe properly, use dev_err_probe().
> - Don't print anything on deferred probe. Dropped print.
> - Remove the MODULE_ALIAS and add MODULE_DEVICE_TABLE().
> - symbol 'mchp_lvds_driver' was not declared. It should be static.
> ---
>   drivers/gpu/drm/bridge/Kconfig          |   7 +
>   drivers/gpu/drm/bridge/Makefile         |   1 +
>   drivers/gpu/drm/bridge/microchip-lvds.c | 246 ++++++++++++++++++++++++
>   3 files changed, 254 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3e6a4e2044c0..200afb36e421 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -173,6 +173,13 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
>   	  to DP++. This is used with the i.MX6 imx-ldb
>   	  driver. You are likely to say N here.
>   
> +config DRM_MICROCHIP_LVDS_SERIALIZER
> +	tristate "Microchip LVDS serailzer support"
---------------------------------/\

Should be serializer

> +	depends on OF
> +	depends on DRM_ATMEL_HLCDC
> +	help
> +	  Support for Microchip's LVDS serializer.
> +
>   config DRM_NWL_MIPI_DSI
>   	tristate "Northwest Logic MIPI DSI Host controller"
>   	depends on DRM
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 2b892b7ed59e..e3804e93d324 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
>   obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
>   obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
>   obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
> +obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
>   obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>   obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>   obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
> new file mode 100644
> index 000000000000..508321ad0f66
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
> + * Author: Dharma Balasubiramani <dharma.b@microchip.com>
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_graph.h>
> +#include <linux/pinctrl/devinfo.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +
> +#define LVDS_POLL_TIMEOUT_MS 1000
> +
> +/* LVDSC register offsets */
> +#define LVDSC_CR	0x00
> +#define LVDSC_CFGR	0x04
> +#define LVDSC_SR	0x0C
> +#define LVDSC_WPMR	0xE4
> +
> +/* Bitfields in LVDSC_CR (Control Register) */
> +#define LVDSC_CR_SER_EN	BIT(0)
> +
> +/* Bitfields in LVDSC_CFGR (Configuration Register) */
> +#define LVDSC_CFGR_PIXSIZE_24BITS	0
> +#define LVDSC_CFGR_DEN_POL_HIGH		0
> +#define LVDSC_CFGR_DC_UNBALANCED	0
> +#define LVDSC_CFGR_MAPPING_JEIDA	BIT(6)
> +
> +/*Bitfields in LVDSC_SR */
> +#define LVDSC_SR_CS	BIT(0)
> +
> +/* Bitfields in LVDSC_WPMR (Write Protection Mode Register) */
> +#define LVDSC_WPMR_WPKEY_MASK	GENMASK(31, 8)
> +#define LVDSC_WPMR_WPKEY_PSSWD	0x4C5644
> +
> +struct mchp_lvds {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *pclk;
> +	int format; /* vesa or jeida format */
> +	struct drm_panel *panel;
> +	struct drm_bridge bridge;
> +	struct drm_bridge *panel_bridge;
> +};
> +
> +static inline struct mchp_lvds *bridge_to_lvds(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct mchp_lvds, bridge);
> +}
> +
> +static inline u32 lvds_readl(struct mchp_lvds *lvds, u32 offset)
> +{
> +	return readl_relaxed(lvds->regs + offset);
> +}
> +
> +static inline void lvds_writel(struct mchp_lvds *lvds, u32 offset, u32 val)
> +{
> +	writel_relaxed(val, lvds->regs + offset);
> +}
> +
> +static void lvds_serialiser_on(struct mchp_lvds *lvds)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(LVDS_POLL_TIMEOUT_MS);
> +
> +	/* The LVDSC registers can only be written if WPEN is cleared */
> +	lvds_writel(lvds, LVDSC_WPMR, (LVDSC_WPMR_WPKEY_PSSWD &
> +				LVDSC_WPMR_WPKEY_MASK));
> +
> +	/* Wait for the status of configuration registers to be changed */
> +	while (lvds_readl(lvds, LVDSC_SR) & LVDSC_SR_CS) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(lvds->dev, "%s: timeout error\n", __func__);
> +			return;
> +		}
> +		usleep_range(1000, 2000);
> +	}
> +
> +	/* Configure the LVDSC */
> +	lvds_writel(lvds, LVDSC_CFGR, (LVDSC_CFGR_MAPPING_JEIDA |
> +				LVDSC_CFGR_DC_UNBALANCED |
> +				LVDSC_CFGR_DEN_POL_HIGH |
> +				LVDSC_CFGR_PIXSIZE_24BITS));
> +
> +	/* Enable the LVDS serializer */
> +	lvds_writel(lvds, LVDSC_CR, LVDSC_CR_SER_EN);
> +}
> +
> +static int mchp_lvds_attach(struct drm_bridge *bridge,
> +			    enum drm_bridge_attach_flags flags)
> +{
> +	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
> +
> +	bridge->encoder->encoder_type = DRM_MODE_ENCODER_LVDS;
> +
> +	return drm_bridge_attach(bridge->encoder, lvds->panel_bridge,
> +				 bridge, flags);
> +}
> +
> +static void mchp_lvds_enable(struct drm_bridge *bridge)
> +{
> +	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
> +	int ret;
> +
> +	ret = clk_enable(lvds->pclk);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
> +		return;
> +	}
> +
> +	ret = pm_runtime_get_sync(lvds->dev);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
> +		clk_disable(lvds->pclk);
> +		return;
> +	}
> +
> +	lvds_serialiser_on(lvds);
> +}
> +
> +static void mchp_lvds_disable(struct drm_bridge *bridge)
> +{
> +	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
> +
> +	pm_runtime_put(lvds->dev);
> +	clk_disable(lvds->pclk);
> +}
> +
> +static const struct drm_bridge_funcs mchp_lvds_bridge_funcs = {
> +	.attach = mchp_lvds_attach,
> +	.enable = mchp_lvds_enable,
> +	.disable = mchp_lvds_disable,
> +};
> +
> +static int mchp_lvds_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mchp_lvds *lvds;
> +	struct device_node *port;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
> +	if (!lvds)
> +		return -ENOMEM;
> +
> +	lvds->dev = dev;
> +
> +	lvds->regs = devm_ioremap_resource(lvds->dev,
> +			platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	if (IS_ERR(lvds->regs))
> +		return PTR_ERR(lvds->regs);
> +
> +	lvds->pclk = devm_clk_get(lvds->dev, "pclk");
> +	if (IS_ERR(lvds->pclk))
> +		return dev_err_probe(lvds->dev, PTR_ERR(lvds->pclk),
> +				"could not get pclk_lvds\n");
> +
> +	ret = clk_prepare(lvds->pclk);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
> +		return ret;
> +	}

I think you can switch to devm_clk_get_prepared() here

> +
> +	port = of_graph_get_remote_node(dev->of_node, 1, 0);
> +	if (!port) {
> +		DRM_DEV_ERROR(dev,
> +			      "can't find port point, please init lvds panel port!\n");
> +		return -EINVAL;
> +	}
> +
> +	lvds->panel = of_drm_find_panel(port);
> +	of_node_put(port);
> +
> +	if (IS_ERR(lvds->panel))
> +		return -EPROBE_DEFER;
> +
> +	lvds->panel_bridge = devm_drm_panel_bridge_add(dev, lvds->panel);
> +
> +	if (IS_ERR(lvds->panel_bridge))
> +		return PTR_ERR(lvds->panel_bridge);
> +
> +	lvds->bridge.of_node = dev->of_node;
> +	lvds->bridge.type = DRM_MODE_CONNECTOR_LVDS;
> +	lvds->bridge.funcs = &mchp_lvds_bridge_funcs;
> +
> +	dev_set_drvdata(dev, lvds);
> +	pm_runtime_enable(dev);

If you also use devm_pm_runtime_enable() you can drop mchp_lvds_remove()

> +
> +	drm_bridge_add(&lvds->bridge);
> +
> +	return 0;
> +}
> +
> +static int mchp_lvds_remove(struct platform_device *pdev)
> +{
> +	struct mchp_lvds *lvds = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	clk_unprepare(lvds->pclk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mchp_lvds_dt_ids[] = {
> +	{
> +		.compatible = "microchip,sam9x75-lvds",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mchp_lvds_dt_ids);
> +
> +static struct platform_driver mchp_lvds_driver = {
> +	.probe = mchp_lvds_probe,
> +	.remove = mchp_lvds_remove,
> +	.driver = {
> +		   .name = "microchip-lvds",
> +		   .of_match_table = mchp_lvds_dt_ids,
> +	},
> +};
> +module_platform_driver(mchp_lvds_driver);
> +
> +MODULE_AUTHOR("Manikandan Muralidharan <manikandan.m@microchip.com>");
> +MODULE_AUTHOR("Dharma Balasubiramani <dharma.b@microchip.com>");
> +MODULE_DESCRIPTION("Low Voltage Differential Signaling Controller Driver");
> +MODULE_LICENSE("GPL");

Thanks,
Neil

