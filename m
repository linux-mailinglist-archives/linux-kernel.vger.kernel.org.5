Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B37C6D82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378870AbjJLL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbjJLL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:57:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE653AA6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:55:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406609df1a6so9410115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697111708; x=1697716508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EEh0DtjuniCuNrVtcwCXYohORKDMpqfS7tvWNnQQLg=;
        b=IOq1oJVqNIBrIpvFvbDqCbAJHsC0Gb0FR37f6xEIWHR+AKclDf2pqNoSWKl5P03VZf
         ehmpoiRl8s9c8Wrt3QVMgKogio+fxO/WgD16zmUNSZaT2SIRIwPPks2lGDU6G1SPkFev
         /ClF7I8ffUZXSmsFEDOQ9NnY0KjLuqQMzhtkzG7Vl3cG2r+4AZAwWgreBuXIyfcSMTT7
         istgB4aFheCFm3waAtCfnn0hHE/ELYAQ8muA+wDkkYVyRfPhHNd4vmeoez5caxi20HGw
         POIwOuMQtCeihBz8L0etKgkHG2bcDnqoXHp50+p3D7NsVFiNSY5C48xiL0bwS5MUiN+T
         StgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111708; x=1697716508;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7EEh0DtjuniCuNrVtcwCXYohORKDMpqfS7tvWNnQQLg=;
        b=ApHZmF4wlCc6ugT1zz1d8GdiAzzw9mhnF+zFwH9usm46idx5u1/RszQHOyhUihjGND
         Pmz9c3yzNkuqHKcX0UBUQf01bcRhCgdBT4o5MffS0U3lozQzFpuuUxdOGvSw09pc6tZS
         d9ydChvzbpvz2ymQnguKBT8sOD3xqWzgRKhlCDbNdGciGyKslWZbiZo0Adq6H44zY12V
         A3PgY4nEO9zd1/fdB9w9VFTU4/bcxRNy/Mkor4j+t8OS3z2fi9mtlf1Yh36pgcX9eQoq
         pPkwnHyREFSHny3Y26M949er6DygvVWth9+4JiC4ziIg4AWGs+VB33Gi4X2Ns0iVNsQz
         eYNw==
X-Gm-Message-State: AOJu0YxEKxxftzjCyuu5u+6sDyBmmX2IZaiGq3a0ptDhiFEuua0Gbk6G
        BfwGOYIIaqVDMRwbPomzqHBXvg==
X-Google-Smtp-Source: AGHT+IF/cZdSXKP3hqC6P1rzTaQWACKheA9PXy21cLGdHXi25qE0+eEDjLjzcczKxWWqYi5oeRhu9g==
X-Received: by 2002:a5d:5a06:0:b0:32d:23b7:49af with SMTP id bq6-20020a5d5a06000000b0032d23b749afmr8409393wrb.36.1697111708198;
        Thu, 12 Oct 2023 04:55:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d423:df8b:7f17:7909? ([2a01:e0a:982:cbb0:d423:df8b:7f17:7909])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b004064e3b94afsm21802128wmc.4.2023.10.12.04.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 04:55:07 -0700 (PDT)
Message-ID: <10a892e7-18fe-4267-aa5d-c77f5da9a3c8@linaro.org>
Date:   Thu, 12 Oct 2023 13:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] perf/amlogic: add missing MODULE_DEVICE_TABLE
Content-Language: en-US, fr
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <CGME20231012103551eucas1p2422c1c7ace26714addeaadde8b645d4b@eucas1p2.samsung.com>
 <20231012103543.3381326-1-m.szyprowski@samsung.com>
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
In-Reply-To: <20231012103543.3381326-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 12:35, Marek Szyprowski wrote:
> Add missing MODULE_DEVICE_TABLE macro to let this driver to be
> automatically loaded as module.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/perf/amlogic/meson_g12_ddr_pmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> index 8b643888d503..15d52ab3276a 100644
> --- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> @@ -377,6 +377,7 @@ static const struct of_device_id meson_ddr_pmu_dt_match[] = {
>   	},
>   	{}
>   };
> +MODULE_DEVICE_TABLE(of, meson_ddr_pmu_dt_match);
>   
>   static struct platform_driver g12_ddr_pmu_driver = {
>   	.probe = g12_ddr_pmu_probe,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
