Return-Path: <linux-kernel+bounces-61705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A785158F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9192844BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234D3D978;
	Mon, 12 Feb 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIjK6TOi"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CA3D96C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744973; cv=none; b=BD/zZQqrLFIrE+LDrbzsTgISOQrH0bI7/VyDirf4F6ayeyyWy98UDNrpNd6WWk+NEUn7DKB6gnVjUTqdD9qEVkC1yNW7Py7PEaM88RotVPG4aXphkKzEnxe6Zq71pwm5aFVZ6fMZJVG39Mt4EvkVNzYcP6rRep9RQh1ybjJ2T+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744973; c=relaxed/simple;
	bh=FtXOp79ypwbFscUML393ETpD+v2GjZxqWE9vdktaxqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X3GnaRAqiSYdyqHUynEYhCxNe0AaVpTajhCuZM8j6G5KH9CSYNiKJS/kito/oOjWwkBiNodlB7f0FNvi21bJvl5HpHQun+sb2u4Qy44OwaNI7rRR+O+qVZLPuvQvtg2CnucX22W1LOvT/OCP6D3yBwG/29Y1wcPbzrkyBCVf2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YIjK6TOi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410ec928b83so3394515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744970; x=1708349770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74ExFZRZ6onRvv/q7DNU+xV1ydzYGkcZ6r0iw+QAiOw=;
        b=YIjK6TOiSpR0U9et5h2fA4Y2/arZoN1xdYh5yUNzV3DwPWs4my2sr8tEWt4OXP+thp
         e9GHTTjtrw0yVDTeKWPbm/0XgN4V4GvDKt0lzUkYQz9Gsbdb3HbxBmIQ/aKf545G0ve7
         0Gt/o+2EZ+m0yk0YVfITR/0J7aXSZ/q8M/GEiKdwW9ccCz26CrrF+67Kw6rBEF2cwxRe
         mab+XrPJs4nl6ddKcAVuFlRF1RiWJmTuFL/npa7PXiVp9+a0HR0i3E8eMig6dBmZo2z1
         L0NQjIKFjgLiPb9HA5vWqKFj1qxH0QZrlplkIFumti17CSDgSTSoC1nB/FYnMryaThQ/
         4wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744970; x=1708349770;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74ExFZRZ6onRvv/q7DNU+xV1ydzYGkcZ6r0iw+QAiOw=;
        b=sa0K2hq9Sf3xNiWoEo6kaHkhLzGexOHJHVZsPNxRK2iLLkJAOw86lrY+KBwYg04yIA
         MWwHgEJUcuF9gZuzbzR9k7alLY9c9bZv2rmg4YPFme5331tGy1463oDc0fm5bVGn3mcU
         +lhbHnMElpITDPl+06dWK4h39yw4kVUw5MUtuw+x8GXxx/63liDa+x+flXn58bBEtTBd
         yBV/nq1ZEO1Qw37gS8srmN4hvvx/qxjWJoL/LZWyBJfz8aDA0DRLC9hwfSwuP1b+2KCt
         jy+4p6vyY4DUFNqzQZkYzG2Axdyu3XF7Akc7KJbAZsTxDsGF/xwd8Q0sJAGk1X8XbHt2
         LHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFIgmvL5vVA53O0uM5Nvaw+K6FWZPfHWjyVBwWSuhwA7eWdM4nyTYbXY6hXR8+fD1SgzUurFuLC1uAw0J9hORfp8oGwiJCFog938y
X-Gm-Message-State: AOJu0YxRXshhX+WI7nD99X8/f9icXiu2en4ApgVfmLw5EpA+O+4rESyU
	v0kdEoU/qGAvx2oeuyUNf6xjPXgvMoKurZ6rWDKUj7+w03O/O0Mizc84RImiq20=
X-Google-Smtp-Source: AGHT+IHxiOespFpZaN9WenVMCi5tYoRC71Rge5Y/lysp6dckeGcJpXUwPmAH8chS3wwMFs1t7xyxGw==
X-Received: by 2002:a05:600c:1d07:b0:410:cf4f:68e1 with SMTP id l7-20020a05600c1d0700b00410cf4f68e1mr2395117wms.2.1707744969631;
        Mon, 12 Feb 2024 05:36:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCgnvirB9i9+S1u6JvMGnDSR/MdRPev3xT/whgmQ3kVizbkAlZA6Q0amVId/eUHGe8k/yZRvTSqCMNwDOl0JzBXkyvE8QSjDdkA1qxcheaCT8SpThUMPtSdxo5dn/ahCA4JJmVi0Pl0uanONdqVVO16y2xNLpHg1oMPpxRnNjT82gYNeIXw7esqqfNFyvimfbE9Z+jn/a6Wan6hy6ocxx86SKVOl0JvefGcsL56lxsjK1K8SmA+cZqKG2fiJPH56R2dnM7iUUcKWqm6wa919z2W5filsIGkf33d5Q/vsWIpVXXGXLowBc2VwRgba5WNkwfO9Aea5XLVez+xsSubmQ7Fqmn2/Onqii8wOquLC4QjpDm8YI5LN6sO7k/AD43OnB9kl8jJxByl5AlSww/6EryO0twX0dZAD086dWX7hvHaWoavbmtRYd/RiUpT+UOEZWtxGTIPsOpVpXYNwTH4e5sNnVLb+qlo/0C5Ecr/rAry7HhSmbSEMGMM+yZUbH+eSVewZiu6gCj6nDOWKLEVzXgEBqV2DAX48zO+ROPK0DdWAVN+Lslkz/Y32lqTbgsueS4mL5fFcLnP3rlZwGojJf2AjWEQ982/6BTK1r6068bXcSvVtSAK1rgvAWdhILammp+266OHfTfL3XKy242uF1sg3nCLAtJzuNFFXXnuHrubbuelj27cXprV1z7Wx2SlQskdg1lQpqIvDH8z+sDlWcdPI+Yvkn9DnkSCyEsv0ef3kreyYHbMwI+NTNOBjVxuatQeNx36fCRFmqCtaQ13gbMtHuM5yvj0hKMTz7ca4rPsPf35v+xbfl9DEDh5EFpvJZyNw==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id t20-20020a7bc3d4000000b0040fff3382casm8592379wmj.46.2024.02.12.05.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:36:09 -0800 (PST)
Message-ID: <fff6f6e1-ca2d-4f15-b891-d9b52de8a72f@linaro.org>
Date: Mon, 12 Feb 2024 14:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8650-qrd: enable GPU
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
 <20240212-topic-sm8650-gpu-v1-5-708a40b747b5@linaro.org>
 <CAA8EJpryCXUxs69ockt0TN4LOuBB-4dZkLYHUZyN1Uq0isMjYg@mail.gmail.com>
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
In-Reply-To: <CAA8EJpryCXUxs69ockt0TN4LOuBB-4dZkLYHUZyN1Uq0isMjYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/02/2024 14:32, Dmitry Baryshkov wrote:
> On Mon, 12 Feb 2024 at 12:37, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Add path of the GPU firmware for the SM8650-QRD board
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> index 8515498553bf..7151f3dc67c4 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> @@ -525,6 +525,14 @@ &ipa {
>>          status = "okay";
>>   };
>>
>> +&gpu {
>> +       status = "okay";
>> +
>> +       zap-shader {
>> +               firmware-name = "qcom/sm8650/gen70900_zap.mbn";
> 
> But why? For sm8450 / sm8550 we had "a730_zap.mbn" and "a740_zap.mbn"

No idea why, this is the vendor's fw name, it uses the chipid (2 for sm8550, 9 for sm8650) instead of the commercial name like the seq file (gen70900_sqe.fw).

Neil

> 
>> +       };
>> +};
>> +
>>   &mdss {
>>          status = "okay";
>>   };
>>
>> --
>> 2.34.1
>>
> 
> 


