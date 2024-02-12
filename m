Return-Path: <linux-kernel+bounces-61701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED125851583
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755061F26529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751C3CF79;
	Mon, 12 Feb 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpEwpYWC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF263CF73
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744810; cv=none; b=r7lG5UwEd2JTwoc94P+tdNBfkBGMMYErLsICL0omwFuYgUf6oT1UHNupdLOtbDb88OqRbe0BkSVzM/GqRC1ke45f0tCvd5vd85wGJotPjY+4rTSJcbrArwT5x1g7YpcUHD6s8aQOwI7XPN1IH5H88aarX/cVGuOnpx5E6+QB9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744810; c=relaxed/simple;
	bh=yqe1MeisjVqaVRo2Qv+sv7kOGkc0J0u1l2qx4nTmQKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pDf2xN1dscQHwPyjiVthxV4H/hFjEIALg/NB1lDC58Y39ioOD9adfD5HNxqmxJ9BzuFhSt9YqOKlODoppatCA/3OR1h6X1Fam1jNoiE3sYyxiJdO1bPaDKAKn2vel80hU80epAsc4RoTI+seqM/kZAbPxXuFeTmvaR6lZ30VDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpEwpYWC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso1137428e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744807; x=1708349607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/kgZxDLzPkX2dj4HID8iXh6TZbRWb3hqOS01jZ2wfU=;
        b=lpEwpYWCyC5OXBxWmzDVkn81d5d0tg/Q1ora1Q4wya740c2lbg2kTs6zg9upvLQK6N
         zye1dgBMjCUit7lwHZLZ10DiQAsL2K/w3LNGnyuCQX+LC5UvjMvL7L8KQG2QrRlVebVi
         5bQwEmXeHE5fkv+0E8RJ8JQHPmwdWKDa6ofVGyoWOT6orE3IA2B5AatI/b8Qun6D0Q7r
         cS+A7MFqPedpc/QgdI8fosl1c8LxLbUGFkCtlvAde1sqEGw1YdfNUaN/0aOL9L1YQK5Y
         NIs3wxxJdkZSlK1zoBTwb0cnYJyCTQlA657bSBbr3jycvl8gmc9NSmX1rouXplszcwuz
         xEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744807; x=1708349607;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/kgZxDLzPkX2dj4HID8iXh6TZbRWb3hqOS01jZ2wfU=;
        b=XnQ3po3mS6G1Swv7xhw1P2PHOBYqB9XHVHrP8ljPyYbFHn5tuwkqkgqwyS8Gamam43
         siSX0kxbcy444JTYYbz952N23N9/pL0UF7ITEHSJI5TcvFV8HvfW8ZPcvOON4HP1b2wT
         SqoUwq2RKH0nbZQqmxXLiPVkRNDJDF0yFEvEtoxzCvcJiu324ndrGBJ7zuk3JQLfxuJq
         5NiE6IWlOLCjTZ4p1YPyRaPThfI+UXjdTCdvgEtxJyQd5fIfPHxOzBqNXL9mq811deF3
         zwem8ud/tSg583b+xhRv7qmK/sVDMgU8boxBwx4ru8ibiCYJYo4MGbn0WdGQ7uy1JdRc
         igNg==
X-Gm-Message-State: AOJu0Yy7+yiiBEnThbFzuz2XhUY2gFDoJjjP4vDim2k0HChMgWO9lutz
	wUSGxsCD+CaJ+YFx/XndSdLZoahYxKYCCD/6VsnKMuaBXZjynoK0wP/t9Qn5U3s=
X-Google-Smtp-Source: AGHT+IHvH2XPj/SKjsWNl6ukO9j8WqLT8nmaHmw9ySTfeVRbApaTcy5hQgOBLWN+LkgF+BRL/7moPA==
X-Received: by 2002:a19:5504:0:b0:511:5b50:4d11 with SMTP id n4-20020a195504000000b005115b504d11mr3845473lfe.32.1707744806973;
        Mon, 12 Feb 2024 05:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCGMzyx+4oXasQf3W7HybFcgfseIwO4/jC4gSzO4p48bQdilaW6B1K3pt/hc2MLQU1nobxdETArybnt4pkerxBlURo1wdjEGI7nPe6Lwhr9dKRjCJ4G18+voDa4dvMfMUi/J+QH/wSPgfED8pYVirq9FKp6To21DoTdY3gddNaktq2E99kfOoI30jgYlQ0WHVVXKxMPimZU2VkEr2qEtXxjGKYaZi2+PyBuyh/72ryPd6/GZGIxrGpN3op/OgGTOb4ekZFglpECLYrzKH2uw3hC4enx8NQ28PwFAti+S32LkjGpDCSVC67kl4W0v4naVD9TlPXDjHSQnepCS8xSJPOz5GSFJLqIsmKNcWTDuYd2KmrkC5MvMsTnWD5xF8Y/8iBCDnO8E09iYbv90zWwYUAJMbwt7DVD5CIts9FDQoNm07n7MXq7UfaQFvCSglEanx2FxEJV3kfwt1FnuP/an0lCpS/DVT1RMEnGTu0M1GYRiGgUjkISNpgyZo6Gf69uIm+hMv8O67R+VcUJpXh5MAZSnEF3rJ75oeqwc0NiCR6T0GNzQ8hw7sA2xV7yo+Mr/H7aMjrMhjfo2FtJffMQixoIfiB168Ysy0m1Ln1rzsgMrKlokNttUES+dGS5W4uwBL/tWcBF10EL/ZbklY+wiSdYeVWifGNv09sEIdP6AF/P7UMEmXwp8MoTof2u0egDfwqVuKYd/OOnODfLGDkJBU5aIa3ah+sTukfEhEvJTr3D8tTILB+Fz2uUhCTN3Wq/Sg0d0JlwaLEq14ttulK0tGb1jKF3+f7RiDcUs8Viq64GdRZZJMHKP6tzw==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm6843987wrq.62.2024.02.12.05.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:33:26 -0800 (PST)
Message-ID: <42d4a413-a4a5-42c3-bcfd-db3485fdbae3@linaro.org>
Date: Mon, 12 Feb 2024 14:33:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as
 dma-coherent
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-4-fda0db38e29b@linaro.org>
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
In-Reply-To: <20240210-topic-1v-v1-4-fda0db38e29b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:10, Konrad Dybcio wrote:
> Like on earlier flagship Qualcomm SoCs, the SMMU is dma-coherent.
> Mark it as such.
> 
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d696ec6c6850..868d48b85555 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3934,6 +3934,7 @@ apps_smmu: iommu@15000000 {
>   				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-coherent;
>   		};
>   
>   		intc: interrupt-controller@17100000 {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

