Return-Path: <linux-kernel+bounces-76584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D731D85F98E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F86E1F212EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B2F137C4A;
	Thu, 22 Feb 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgpXxHjt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B1482D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608097; cv=none; b=Wiek1GacrsO6ATNt38OpkpKJM4f5lo0FUS6o6vaqPHvvSMVYUTSgyelk/jsJhrXLjJhhoeq0vViFMB1mQlnow/jJdqQ+ZjfiZ8XfZsLz5A4DlUQmr10G1kswyUBpsTFAi2FFOZGNVgNULsXqp29Z5lJYXxOZnkPhVjG9r2iMuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608097; c=relaxed/simple;
	bh=bhujJwo0n2i82rSZ2CCyo+HTa0yJTbld2cvmeZujWFg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kYi8me/HDvWd3t1ZPfwRT+Sqn3BE2iaYIrUPs1G6F0gjOW/hvQ6YwqD3ZGTgxnfamsRkDK5Oy/vmmecxhfnyy+fkFtyjkuToPXPUFuYgDkASKhNsEbVviuX04mlDh1io8puRfYhDnqdL/CCe/yLuZpn9j4X0TgLr7NozyMbh6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgpXxHjt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so1723669f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708608093; x=1709212893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJe8AJQ4avlhs+TrkE3V41RN60ULi4C44lxA2alOfPw=;
        b=rgpXxHjtXOjJKc3miMT3mnfJ6H4wBUa9r3bbRWU/J1KpQR+yJJeXf9LmaEoThJaBGA
         1isD7O3bUB9piirj5EIGlnLpECuNPaZZGapC1SFusZbApSGK3gqT0nCebOyYuc72PCpg
         7aRJD9oFYNLsxNqvnjP83OvGpPU4LUAlKG4+A+/Weoff+kHejWH+lvpQ/b+aqzaLJIym
         Jww1BZSzzbSXcyMp5DfnYM8VJ98yoJRvl0FX1uhNhfN706fqQO+0eR4HVhNIy4jgfBvd
         KGlR24GyGkzx7OsZ88Oi9zOJNT3wKylieEquDERnBIPctD2VwUQd0qTNMyh4F80FMB0h
         S1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608093; x=1709212893;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJe8AJQ4avlhs+TrkE3V41RN60ULi4C44lxA2alOfPw=;
        b=PLNM1oPNFrS6iWsGAzr/p5/qt9yVp9qaLMGKlzmIqH9TatgX2B9X0WcgIyLwuO7TfE
         yOB7TlkVjya/gV6VUXN1z2AZmT84tnwIaRWjnkvpQydlqr9BwgD6PXfypfbqV1+VgJ5K
         xBrhlMsi33rvk3va1Gftv7vfMPchvRUXZsCYvCqaS/MgGNDa9pGlApaGwtjDcEOGeDW2
         kWMqLGpKBx9wS/PyAXTqPSxzemO3hE28T13FPAxxAdko7zi+FE4xS+TQeRwsJEHivHj8
         O9iiw6J1wRUGHOI8RpGoVbqY9fL+7mET9HnVdtKYM7vG1Po5poN9dfNMtBLclJMZqMpC
         6OyA==
X-Forwarded-Encrypted: i=1; AJvYcCXgJR1OUiY/xgihIdqJZIiWnX0aknI4ysZJT5zXUv57A6oHI65zXgla+vXx9W0ajA7THnZ7frmCEV/2KEoPBGTioUJ5i6dgCzP6EDgy
X-Gm-Message-State: AOJu0YxRPspjvy86Y+d/i254RT1FkTiBCJtbCxFUPGvZ68tRGkTC4aaB
	3CHTSQgs8rU4Dd9ZmJYGP25qblS++AfKVKx2v3E6iEZ5Oi5bjLxsj55GxTww8tw=
X-Google-Smtp-Source: AGHT+IFe5RxqLhSi7hpw2Xp1Ta1zsSUeiZfO4vru4wGScJd+HsEOHeDUU7HSxRMxcC5/c9uf6FaJpw==
X-Received: by 2002:adf:e84c:0:b0:33d:82a1:626d with SMTP id d12-20020adfe84c000000b0033d82a1626dmr3017418wrn.38.1708608093324;
        Thu, 22 Feb 2024 05:21:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c3d:c732:acf9:f53b? ([2a01:e0a:982:cbb0:c3d:c732:acf9:f53b])
        by smtp.gmail.com with ESMTPSA id r10-20020adfda4a000000b0033d3b8820f8sm15199268wrl.109.2024.02.22.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:21:32 -0800 (PST)
Message-ID: <665f37e9-eda4-4d82-8d94-a1238514dbff@linaro.org>
Date: Thu, 22 Feb 2024 14:21:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 4/6] arm64: dts: qcom: sm8650p: introduce sm8650p dtsi
Content-Language: en-US, fr
To: Jingyi Wang <quic_jingyw@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@quicinc.com
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-5-quic_jingyw@quicinc.com>
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
In-Reply-To: <20240205115721.1195336-5-quic_jingyw@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:57, Jingyi Wang wrote:
> Introduce sm8650p dtsi, sm8650p has same base functions
> as sm8650 with different memory regions.
> 
> There are 3 types of reserved memory regions here:
> 1. Firmware related regions.
>      This will be described as: reserved-region@address. Current
> reserved-region may have reserved area which was not yet used, release
> note of the firmware can have such kind of information.
> 2. Firmware related which shared with kernel access.
>      Each region will have a specific node with specific label name for
> later phandle reference from other driver dt node. May overlapping with
> above type regions.
> 3. PIL regions.
>      PIL regions are allocated by kernel and assigned to subsystem
> firmware later.
> Here is a map for this platform:
> 0x100000000 +------------------+
>              |                  |
>              | Firmware Related |
>              |                  |
>   0xd8000000 +------------------+
>              |                  |
>              | Kernel Available |
>              |                  |
>   0xA7000000 +------------------+
>              |                  |
>              |    PIL Region    |
>              |                  |
>   0x8BC00000 +------------------+
>              |                  |
>              | Firmware Related |
>              |                  |
>   0x80000000 +------------------+
> Note that:
> 1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not suggest
> for other usage.
> 2. Kernel start address was start at 0xA8000000.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650p.dtsi | 180 ++++++++++++++++++++++++++
>   1 file changed, 180 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8650p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650p.dtsi b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
> new file mode 100644
> index 000000000000..26dfe315b49d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "sm8650.dtsi"
> +
> +/delete-node/ &reserved_memory;
> +
> +/ {
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/*
> +		 * There are 3 types of reserved memory regions here:
> +		 * 1. Firmware related regions.
> +		 *     This will be described as: reserved-region@address. Current
> +		 * reserved-region may have reserved area which was not yet used,
> +		 * release note of the firmware can have such kind of information.
> +		 * 2. Firmware related which shared with kernel access.
> +		 *     Each region will have a specific node with specific label
> +		 * name for later phandle reference from other driver dt node. May
> +		 * overlapping with above type regions.
> +		 * 3. PIL regions.
> +		 *     PIL regions are allocated by kernel and assigned to subsystem
> +		 * firmware later.
> +		 * Here is a map for this platform:
> +		 * 0x100000000 +------------------+
> +		 *             |                  |
> +		 *             | Firmware Related |
> +		 *             |                  |
> +		 *  0xd8000000 +------------------+
> +		 *             |                  |
> +		 *             | Kernel Available |
> +		 *             |                  |
> +		 *  0xA7000000 +------------------+
> +		 *             |                  |
> +		 *             |    PIL Region    |
> +		 *             |                  |
> +		 *  0x8BC00000 +------------------+
> +		 *             |                  |
> +		 *             | Firmware Related |
> +		 *             |                  |
> +		 *  0x80000000 +------------------+
> +		 * Note that:
> +		 * 1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not
> +		 * suggest for other usage.
> +		 * 2. Kernel start address was start at 0xA8000000.
> +		 */
> +
> +		/* Firmware related regions */
> +		reserved-region@80000000 {
> +			reg = <0x0 0x80000000 0x0 0xbc00000>;
> +			no-map;
> +		};

Ok this region goes up to 0x8BC00000 and so overlaps with the next regions:

> +
> +		aop_image_mem: aop-image-region@81c00000 {
> +			reg = <0x0 0x81c00000 0x0 0x60000>;
> +			no-map;
> +		};
> +
> +		aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x81c60000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		aop_config_mem: aop-config-region@81c80000 {
> +			no-map;
> +			reg = <0x0 0x81c80000 0x0 0x20000>;
> +		};
> +
> +		smem_mem: smem-region@81d00000 {
> +			compatible = "qcom,smem";
> +			reg = <0x0 0x81d00000 0x0 0x200000>;
> +			hwlocks = <&tcsr_mutex 3>;
> +			no-map;
> +		};
> +
> +		adsp_mhi_mem: adsp-mhi-region@81f00000 {
> +			reg = <0x0 0x81f00000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		global_sync_mem: global-sync@82600000 {
> +			reg = <0 0x82600000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		mpss_dsm_mem: mpss-dsm@86b00000 {
> +			reg = <0 0x86b00000 0 0x4900000>;
> +			no-map;
> +		};
> +
> +		mpss_dsm_mem_2: mpss-dsm-2@8b400000 {
> +			reg = <0 0x8b400000 0 0x800000>;
> +			no-map;
> +		};

up to here

Please fix this,

I just checked against plain sm8650.dtsi and actually the memory adresses are the same.

So what's the _real_ difference here ? Just drop the superfluous memory zones and redefine them if needed.

Thanks,
Neil

> +
> +		/* PIL region */
> +		mpss_mem: mpss-region@8bc00000 {
> +			reg = <0x0 0x8bc00000 0x0 0xf400000>;
> +			no-map;
> +		};
> +
> +		q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
> +			reg = <0x0 0x9b000000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: ipa-fw-region@9b080000 {
> +			reg = <0x0 0x9b080000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: ipa-gsi-region@9b090000 {
> +			reg = <0x0 0x9b090000 0x0 0xa000>;
> +			no-map;
> +		};
> +
> +		gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
> +			reg = <0x0 0x9b09a000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		spss_region_mem: spss-region@9b0a0000 {
> +			reg = <0x0 0x9b0a0000 0x0 0x1e0000>;
> +			no-map;
> +		};
> +
> +		spu_secure_shared_memory_mem: spu-secure-shared-memory-region@9b280000 {
> +			reg = <0x0 0x9b280000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		camera_mem: camera-region@9b300000 {
> +			reg = <0x0 0x9b300000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		video_mem: video-region@9bb00000 {
> +			reg = <0x0 0x9bb00000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		cvp_mem: cvp-region@9c300000 {
> +			reg = <0x0 0x9c300000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: cdsp-region@9ca00000 {
> +			reg = <0x0 0x9ca00000 0x0 0x1400000>;
> +			no-map;
> +		};
> +
> +		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9de00000 {
> +			reg = <0x0 0x9de00000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		q6_adsp_dtb_mem: q6-adsp-dtb-region@9de80000 {
> +			reg = <0x0 0x9de80000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		adspslpi_mem: adspslpi-region@9df00000 {
> +			reg = <0x0 0x9df00000 0x0 0x4080000>;
> +			no-map;
> +		};
> +
> +		/* Firmware related regions */
> +		reserved-region@d8000000 {
> +			reg = <0x0 0xd8000000 0x0 0x28000000>;
> +			no-map;
> +		};
> +
> +	};
> +};


