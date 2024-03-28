Return-Path: <linux-kernel+bounces-123032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8B890144
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8236297C42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F480616;
	Thu, 28 Mar 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PedZMalN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAE81AD2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634908; cv=none; b=oNRYcm4I6pIHVppinqlb56zs+Wm0aA0RI4ocE38B+yxIjxSX4gy+rb5EPy9LUf1FTC62n8Xn21XpKLEeVKk2XnEGTIpY2VfiY5ZPVcyfIPvPHGoZ1Zd8/ZhZwDwbY45jYP0UfG8mv4pkVCwowxyYuL7s+4//4YJXsp+whYQ+Ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634908; c=relaxed/simple;
	bh=iIk+LivIXLBnAMRG08/c+OxE8ONUviqrsw9EWVPDFJE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pv0f+q0nIK4jczC1n+hEvuCvBgE9b6n2xK+C/81aceVAvOHO3d17AJsYAtTx4jTin1+HMl0FjeUYpAj0guConFCulk98pFOCbBHCxzlrZOa8q5eHF0TnPoGGcQU0LSy+cjZ3E5c2O68Qy/BxeL3DJFyXrfS9E+jhpwQbTpE8AYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PedZMalN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so14355551fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711634905; x=1712239705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KldVMMTU4wvemf1droJVFNbQxm8DF8GfwQOLOEUBIRI=;
        b=PedZMalNsSOcEFDP3JYaOVBA+tOQqexDVmrI3LFG0z0q1EBXjMUo5dxaZ2zaEaQwUo
         8ij4iLQcZGjkpjgw5Z3VI49ZPzZ+le6rUkh+Vbj+sfdpzv3URfQYdze6L090MS+ldtST
         PQyx1bKUbIPA5MhWNA08KXos45knTZpcLsXd5Vy+m2NBL63PWsH3WtGaPWw4JCyJUio6
         9TL8++5GMOObUNgn8pj3T2yFn0GbyXwqYwjW8H8JsODUy2G61yhngK8eEu0fOsRSEmI4
         ntQacs+/a5RiSvw2ODwnz/4Mo1G0T8NXbeubPeTvYI3ECxpyYUx24ThaUVS2rESUSfX3
         ning==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634905; x=1712239705;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KldVMMTU4wvemf1droJVFNbQxm8DF8GfwQOLOEUBIRI=;
        b=RIcOjqXXKZ9RoYaZ8CtTj/7gXZtw/BZgjiOTwhCeRX/VADtZ2vyptmwr1Aq9SXkIRe
         oahqYhzxovY2CyUmSdWCox4NruvhvB/OK2c4uOYB5JkzJI7/3yjHZoSmKb9ysKGI23p9
         SlJ9ouscx2bPcMFy/taimN/RZ2FeVJUL4z6zy5DqwmrI5oL31bLt+c8LS3LQy032+TLy
         1dd6clKhI+yAuPwXSecaJDDWzmkpTFE8GLrnQyH9SDHyVZDKBQyD8E5iUNsZg2RJk/c2
         hlj5RWd+aK5A3F0UkvoMl0/2Pm9xr3bwiB+7diqzF+mpAdm/LWV2miNPNmElqLh0JYCw
         +gHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnRhE7Hd0yE5uo8PRYNkedXQouE7urwk4j7om7qvla+YHC70GGusdeAHa5ds1m4go2/gjY1nsdutjBE7tK20KnG6o5ztyvH1m0OvJM
X-Gm-Message-State: AOJu0Yz1Q1nG+5+sFxtqtfZNe7aKGzMslYR1Mat7ftHnn2X9EGUGxqzT
	OAIrIKhUvVTgLLBTxO3tRjJFePZunmLAXsOtRqdvLERD/dTdLpAeo3J5P0s58u4=
X-Google-Smtp-Source: AGHT+IFzi5IGT2Or39luIJGiqxag++Cnfv2uvw0ITZd6e/aW+yO5N1QhpGpdl7mOdWQlSPUri5HLMw==
X-Received: by 2002:a05:651c:324:b0:2d3:2ecf:c26a with SMTP id b4-20020a05651c032400b002d32ecfc26amr1523605ljp.13.1711634905209;
        Thu, 28 Mar 2024 07:08:25 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0041488cfd0fesm5549851wmo.28.2024.03.28.07.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:08:24 -0700 (PDT)
Message-ID: <39ae48ba-02a0-4f68-b0a2-e03272fd50a0@linaro.org>
Date: Thu, 28 Mar 2024 15:08:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] thermal: amlogic: support A1 SoC family Thermal
 Sensor controller
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
 mturquette@baylibre.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: kernel@salutedevices.com, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240328133802.15651-1-ddrokosov@salutedevices.com>
 <20240328133802.15651-3-ddrokosov@salutedevices.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240328133802.15651-3-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2024 14:37, Dmitry Rokosov wrote:
> In comparison to other Amlogic chips, there is one key difference.
> The offset for the sec_ao base, also known as u_efuse_off, is special,
> while other aspects remain the same.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   drivers/thermal/amlogic_thermal.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 5877cde25b79..1d23afd32013 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -222,6 +222,12 @@ static const struct amlogic_thermal_data amlogic_thermal_g12a_ddr_param = {
>   	.regmap_config = &amlogic_thermal_regmap_config_g12a,
>   };
>   
> +static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
> +	.u_efuse_off = 0x114,
> +	.calibration_parameters = &amlogic_thermal_g12a,
> +	.regmap_config = &amlogic_thermal_regmap_config_g12a,
> +};
> +
>   static const struct of_device_id of_amlogic_thermal_match[] = {
>   	{
>   		.compatible = "amlogic,g12a-ddr-thermal",
> @@ -231,6 +237,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
>   		.compatible = "amlogic,g12a-cpu-thermal",
>   		.data = &amlogic_thermal_g12a_cpu_param,
>   	},
> +	{
> +		.compatible = "amlogic,a1-cpu-thermal",
> +		.data = &amlogic_thermal_a1_cpu_param,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Keep it even it you change the compatible,

Thanks,
Neil

