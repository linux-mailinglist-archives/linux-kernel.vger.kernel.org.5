Return-Path: <linux-kernel+bounces-74824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95085DC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD21F2103E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CB79DD7;
	Wed, 21 Feb 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUF0MQo5"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5B7A715
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523346; cv=none; b=hC4dXDxPkv/NAvv7AnhSqUN2uX/hqZblY+EAh55AufbHZjO9HnjQLvYyuiGyExxLNongTLkh/phWMw/ECrui692t77uMhSP1aW6NxZSwVFiXaR+U/HAKA9EHOTOoJ1LNOEukYzjaf5Dba77XqHrVFEP/x63H4/YDnBN8dtiBlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523346; c=relaxed/simple;
	bh=dbqzli4cR3WCeUsaiipTFck3hHY4sMi8a7ZU5v4Fnq4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Co4hS7M8aLS2mcmQ4EyuwFz5c2RMOMeh1DzEX35nrl33GQxEe/7OUG3m3KPncwbDZF1ZzQeQWysDKXSX0bK5jCazKu4ZfkBtnBdabFHze+NlZ7RNWsVLwzrPZWxgArr3m3QE2TzN8HFOlh4MaMJi+vrMqePE8+DvfUoRqgFMry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUF0MQo5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso11153165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708523343; x=1709128143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtFDOKN5+hR4HH1P/38GAxhyej34QU8WFZl+t+s3aWo=;
        b=UUF0MQo5HFiUJeiILuBf2tD44upvRRwWsy4GL9ngc0hX7mWlp1gsTrcFn4G8Vl8m/d
         gso/obKmxy5atXiqpr0Jzxjwwk4IjCHA9Dw3jwfR4XCIqZ7aIPn9NIH4uLfQcg5V8zMk
         fuIs2UeAYl84z7UpEjYgF7aDgD6YIAHHN24wKjdBhWZ3cpDS38dIZkVdxP3w8iVRKKb5
         4Yb6imUvOkRNUWfJG7Rm3AOG4UffjNDahQsMxAjT6E52+ii13nyJcNtM96Raka2M2gvH
         czJTt4QtpptDTLP09+KCSfHiuggBexQ7dFDO3/Zn5bmBOd+Bh+8yVwKkEMtbKp3fUKgy
         G2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523343; x=1709128143;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtFDOKN5+hR4HH1P/38GAxhyej34QU8WFZl+t+s3aWo=;
        b=CqukBz4u18i7SIzS7g4cZopHu6OHqCn8qoeXgUYMZo0dpDCHc9AZ9GDbIQv+bTOsYf
         hcnJxZpvWUN6lURcq34iJLRpF9b6CvSAOq40BtW5Kyv+aPZPqNlrzhUxs4+LE2f0muR6
         2+DmJ+2mnIjj676txyorFqI0ooMzQrMI3nTOHsqBa+/geLDI3u4deV3fOOsb7WNFAE9E
         JIzExWVXC7tGi5BAwYo5qegWaxdmiznyvrdfVUGbIgdBKviSs0+XcLLUJv/GA3X+wHh3
         DcWS8c0FXTN3+Dp5Xr4DSQCsqvy07XEan6SQh2w/a014vXIs7bNB/t3UnF+scCG+ejry
         M6OA==
X-Forwarded-Encrypted: i=1; AJvYcCUURDEguBe9CzpfvM2hVu1a9MUgfRD3t9IVI1j2giDMv+IVIvmwb6o//PB+If2nlSaGhkhC5/sqfNP3+CbTv3AT0hTHdRdWW/7UNIhn
X-Gm-Message-State: AOJu0Yw5XpTj1az5UbmW3rQQdwcjAXB1DitoGq7fCT4Uhg9rQuLthhWc
	3Djf3QjXYqHMr8A2/yAShRPZ/fVoUoPT8w9a/kfx62mVcnsAtZue4lwrnXWkC+c=
X-Google-Smtp-Source: AGHT+IFESSv2epAh2jQikPzor1NGRNpRGVyZZwKtgnNFvsQler9c/74e1224I59lL6qrirgD1bFHNA==
X-Received: by 2002:a05:600c:4f55:b0:412:392e:6f06 with SMTP id m21-20020a05600c4f5500b00412392e6f06mr11955635wmq.7.1708523342806;
        Wed, 21 Feb 2024 05:49:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:83fc:439c:6f36:ce5c? ([2a01:e0a:982:cbb0:83fc:439c:6f36:ce5c])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b004124907f43fsm17647391wmo.12.2024.02.21.05.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 05:49:01 -0800 (PST)
Message-ID: <f2b9443e-b214-4f72-a870-2f16d37a04a6@linaro.org>
Date: Wed, 21 Feb 2024 14:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8650: Fix SPMI channels size
Content-Language: en-US, fr
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-0-72b5efd9dc4f@linaro.org>
 <20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-2-72b5efd9dc4f@linaro.org>
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
In-Reply-To: <20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-2-72b5efd9dc4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2024 14:04, Abel Vesa wrote:
> The actual size of the channels registers region is 4MB, according to the
> documentation. This issue was not caught until now because the driver was
> supposed to allow same regions being mapped multiple times for supporting
> multiple buses. Thie driver is using platform_get_resource_byname() and
> devm_ioremap() towards that purpose, which intentionally avoids
> devm_request_mem_region() altogether.
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index d488b3b3265e..260eda81b743 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -3747,7 +3747,7 @@ sram@c3f0000 {
>   		spmi_bus: spmi@c400000 {
>   			compatible = "qcom,spmi-pmic-arb";
>   			reg = <0 0x0c400000 0 0x3000>,
> -			      <0 0x0c500000 0 0x4000000>,
> +			      <0 0x0c500000 0 0x400000>,
>   			      <0 0x0c440000 0 0x80000>,
>   			      <0 0x0c4c0000 0 0x20000>,
>   			      <0 0x0c42d000 0 0x4000>;
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

