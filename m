Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25166786A15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbjHXIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjHXIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:30:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1211724
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:30:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso9855726e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865845; x=1693470645;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRy8xMJqy84kf7uXRw/eHLuxoHjrotPEc4vQZu2qMs4=;
        b=O+aNJRCG5gSYhyCsijqXDezqocG5OuOi1DJYrGcYP/yGSkjcS3wTo8FUauXratDacf
         yzS1h/RZgK4NX0W6EJhgpcBu1dpDlZz7VNE5X07g1AXneVdSiKskDiV7P0Rm7SvWJYfO
         +1GGIKpZlDGRdvQhKdUgXbTSc+H7zgKaLGZ1ErvyNaWMjnD7xLKjek9IZFvdaNM7d4Xm
         VVu//QwTi4ttT4T3lRf7WNIXKbkfBrRqb2S3luY9GRg2VtW7HbNsjm6H9AtZkAE+cPVD
         oJ4YoGcv8P1ijHZfxLbJowAGoGhIECV1Xu2RaIAapCbHhZw60tlhAMYob2TmNqBKEl8i
         2TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865845; x=1693470645;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sRy8xMJqy84kf7uXRw/eHLuxoHjrotPEc4vQZu2qMs4=;
        b=htjFLBgeuDYaQhcrzqTHgsgRAhnwvpJdI8/r0A5/p3ifPBRNHX9I1OxVQNrXWFMWkA
         MU2CmXfj/wcLnKFJcqw9Lp1zrVStx2STlLc0l1OT/T3k8/ZJACQf1s52yZSoJ8BDTzkY
         mXkGD6NUIkwuHwf5rTelamzAsODWjVPcRsbBKa/4rGEJka1cODQaXo6KKm8pdMatRtRf
         HEoYbYHpj/52tRknhevMPvGuyryAVuIxFHC3TLHWv4hUQ9KhgBZxdbFDqjRI6rJS9oVd
         0eAxS5/jNaWM30eSvXOVw9L0PT/lKycZNmLs9WKvl56vD1xqP9XIv7FYIZLT7+gaquD/
         blsQ==
X-Gm-Message-State: AOJu0YzXFUNFr7v93IpcU3H5p+E9/p2x5IGxSvtSkrm/IjI12A9G/qtk
        3zimxAIfEePAS+6U3LbXztssqQ==
X-Google-Smtp-Source: AGHT+IFHhm+TWFYflreH1RasNxMKNwnJDeyyAJPqK+5h1u92DvQuyhfswDqodp7D0C9bN6etC1PVug==
X-Received: by 2002:a05:6512:36cd:b0:500:9d6c:913e with SMTP id e13-20020a05651236cd00b005009d6c913emr1172825lfs.52.1692865845170;
        Thu, 24 Aug 2023 01:30:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fbd9e390e1sm1907393wmg.47.2023.08.24.01.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:30:44 -0700 (PDT)
Message-ID: <97c05c1f-1d59-4dc8-9a1b-ae2fea61e094@linaro.org>
Date:   Thu, 24 Aug 2023 10:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 5/6] soc: amlogic: Add support for T7 power domains
 controller
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-6-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230824055930.2576849-6-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 07:59, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
> 
> Add support for T7 power controller. T7 power control
> registers are in secure domain, and should be accessed by SMC.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: Modify T7_NIC flag  "ALWAYS_ON"
> ---
>   drivers/genpd/amlogic/meson-secure-pwrc.c | 73 +++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> index 3e7e3bd25d1f..2233f6cb7e71 100644
> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/power/meson-a1-power.h>
>   #include <dt-bindings/power/amlogic,c3-pwrc.h>
>   #include <dt-bindings/power/meson-s4-power.h>
> +#include <dt-bindings/power/amlogic,t7-pwrc.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/firmware/meson/meson_sm.h>
>   #include <linux/module.h>
> @@ -164,6 +165,69 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>   	SEC_PD(S4_AUDIO,	0),
>   };
>   
> +static struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
> +	SEC_PD(T7_DSPA,		0),
> +	SEC_PD(T7_DSPB,		0),
> +	TOP_PD(T7_DOS_HCODEC,	0, PWRC_T7_NIC3_ID),
> +	TOP_PD(T7_DOS_HEVC,	0, PWRC_T7_NIC3_ID),
> +	TOP_PD(T7_DOS_VDEC,	0, PWRC_T7_NIC3_ID),
> +	TOP_PD(T7_DOS_WAVE,	0, PWRC_T7_NIC3_ID),
> +	SEC_PD(T7_VPU_HDMI,	0),
> +	SEC_PD(T7_USB_COMB,	0),
> +	SEC_PD(T7_PCIE,		0),
> +	TOP_PD(T7_GE2D,		0, PWRC_T7_NIC3_ID),
> +	/* SRAMA is used as ATF runtime memory, and should be always on */
> +	SEC_PD(T7_SRAMA,	GENPD_FLAG_ALWAYS_ON),
> +	/* SRAMB is used as ATF runtime memory, and should be always on */
> +	SEC_PD(T7_SRAMB,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(T7_HDMIRX,	0),
> +	SEC_PD(T7_VI_CLK1,	0),
> +	SEC_PD(T7_VI_CLK2,	0),
> +	/* ETH is for ethernet online wakeup, and should be always on */
> +	SEC_PD(T7_ETH,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(T7_ISP,		0),
> +	SEC_PD(T7_MIPI_ISP,	0),
> +	TOP_PD(T7_GDC,		0, PWRC_T7_NIC3_ID),
> +	TOP_PD(T7_DEWARP,	0, PWRC_T7_NIC3_ID),
> +	SEC_PD(T7_SDIO_A,	0),
> +	SEC_PD(T7_SDIO_B,	0),
> +	SEC_PD(T7_EMMC,		0),
> +	TOP_PD(T7_MALI_SC0,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_MALI_SC1,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_MALI_SC2,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_MALI_SC3,	0, PWRC_T7_NNA_TOP_ID),
> +	SEC_PD(T7_MALI_TOP,	0),
> +	TOP_PD(T7_NNA_CORE0,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_NNA_CORE1,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_NNA_CORE2,	0, PWRC_T7_NNA_TOP_ID),
> +	TOP_PD(T7_NNA_CORE3,	0, PWRC_T7_NNA_TOP_ID),
> +	SEC_PD(T7_NNA_TOP,	0),
> +	SEC_PD(T7_DDR0,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(T7_DDR1,		GENPD_FLAG_ALWAYS_ON),
> +	/* DMC0 is for DDR PHY ana/dig and DMC, and should be always on */
> +	SEC_PD(T7_DMC0,		GENPD_FLAG_ALWAYS_ON),
> +	/* DMC1 is for DDR PHY ana/dig and DMC, and should be always on */
> +	SEC_PD(T7_DMC1,		GENPD_FLAG_ALWAYS_ON),
> +	/* NOC is related to clk bus, and should be always on */
> +	SEC_PD(T7_NOC,		GENPD_FLAG_ALWAYS_ON),
> +	/* NIC is for the Arm NIC-400 interconnect, and should be always on */
> +	SEC_PD(T7_NIC2,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(T7_NIC3,		0),
> +	/* CPU accesses the interleave data to the ddr need cci, and should be always on */
> +	SEC_PD(T7_CCI,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(T7_MIPI_DSI0,	0),
> +	SEC_PD(T7_SPICC0,	0),
> +	SEC_PD(T7_SPICC1,	0),
> +	SEC_PD(T7_SPICC2,	0),
> +	SEC_PD(T7_SPICC3,	0),
> +	SEC_PD(T7_SPICC4,	0),
> +	SEC_PD(T7_SPICC5,	0),
> +	SEC_PD(T7_EDP0,		0),
> +	SEC_PD(T7_EDP1,		0),
> +	SEC_PD(T7_MIPI_DSI1,	0),
> +	SEC_PD(T7_AUDIO,	0),
> +};
> +
>   static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   {
>   	int i;
> @@ -257,6 +321,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
>   	.count = ARRAY_SIZE(s4_pwrc_domains),
>   };
>   
> +static struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
> +	.domains = t7_pwrc_domains,
> +	.count = ARRAY_SIZE(t7_pwrc_domains),
> +};
> +
>   static const struct of_device_id meson_secure_pwrc_match_table[] = {
>   	{
>   		.compatible = "amlogic,meson-a1-pwrc",
> @@ -270,6 +339,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
>   		.compatible = "amlogic,meson-s4-pwrc",
>   		.data = &meson_secure_s4_pwrc_data,
>   	},
> +	{
> +		.compatible = "amlogic,t7-pwrc",
> +		.data = &amlogic_secure_t7_pwrc_data,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);

With updated subject:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
