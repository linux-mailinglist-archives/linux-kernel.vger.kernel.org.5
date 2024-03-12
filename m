Return-Path: <linux-kernel+bounces-99938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32653878F72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DA71C21882
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55E69D09;
	Tue, 12 Mar 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuodP9dm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652306A031
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230739; cv=none; b=rcHa5g/xrIXoTeqDN3FYnc/ahsuYttminOPn4Wo4vM4b2JkIGoCIqYlnxrNo/3c8pUKKVLdICtVmNB9wk9cLY5ZJY3P6X+nWCdpP7hR3b/odKZk4HtpEES36uCpm+NRPPlO5psb8q+v9wt3I0t6zWEsFR/k63QbNlVdgtYkLeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230739; c=relaxed/simple;
	bh=br278IECTs6mwg8AYiFME7l+eNV3wXD/c6J7sStxOjI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pXIijSyRV3vcNxVuzbgQRm6VbEqK8IGEZBXoqMKJwAn0iIWR0OLUSIhg9hZOofwUMzmuAdPX0326xK+PNaGAhzOjYgoWRe8h2paO9gN7ZlKdnvChJeYz+hRzgCmKxpI9nUdAzD2tBPx77icSxTAbKY4tjULqN71QhfqxoRWG0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuodP9dm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e4f4e463so7139502e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710230734; x=1710835534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNhIiSk+Z5h7g58HyZqwQPvyGLzPtdGbAZ8dMYbx7vI=;
        b=FuodP9dmrZw9YIjG4knejp0NEAy63GqUQ4OT9oqg6+jWFQcIatjCF9r0VCmN2KJ4zS
         YRUn6B7KYhQOtVerJzpe8JBbxj1wS8OtA81CABQBv43TqiDxi0/SwoW1PouJy/v416qG
         omAkJwNZcVOfnXduVnPI/F+fNjeyZnoipdrxUNpYLWk1eu229tD32nQewD6ufeJIQ5az
         E5yMztLvyeCkvCjCCAZekMFNZnwci0dlbwlDKRzC5phqdpwYerU9p+r6/jq1DhWBG0mq
         AdiRxrFOzeFoURLwFPpN+7lK0q1RX1PLxzw3yDmmULZSWUJzdMBeQus4/tIg9ihBPy0J
         0OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710230734; x=1710835534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jNhIiSk+Z5h7g58HyZqwQPvyGLzPtdGbAZ8dMYbx7vI=;
        b=JJ62Ch4gVRaFD7FriLxahG10cFHALJnWigoc9mLNGLPnMGcAnBd51IdUi/DKnUjAxb
         6EcJtvSoaW8daL8S8e0a1jPTRzNmGsLRm62SMdrG7QBaQC9pcuVP+zy5N884JcO6bvrP
         noa28ADrXtKp2vIeS0qERYDXfn6b7PpGecBaIjvFXQopEcJUJZRG37WkHMYQ9ipusMPL
         mZoUKmD+wTLS6WVjIwwdnEnCvcS0me/6OS6JlnkopDxKmcbxiU9xiVTHV16OHeqCHD12
         DtOQwxX8oknqVJbG5Rf6tBQICZ5Fw99StSrj08ayMpCZ8jPbgTx9ww5lKTVP8F3VYCwE
         6faw==
X-Forwarded-Encrypted: i=1; AJvYcCWAgPcrRdb6A7S4FH8MbGdVhPZaU20bDWGwZ1k6CZ+2Bi5Do/agWmiGAgwSr35ljL27I2I1+k/SfR3aIGv8p3j06adrY/AVk/OZiqLq
X-Gm-Message-State: AOJu0YyArKlEknQHGB2VJLLY3lpcqgTMosiUhC+OE0RzcdxKbYHYmfqF
	hwZxB7toLR3QwA1k4sHM3Ex0s3n8hOVmTr3Gk0bPg2444l2iPX2clke4A9tj5bI=
X-Google-Smtp-Source: AGHT+IG4QPJ/TiB3jCYWhKuqaIF6uwCpxH4sxUSkpI/eODFRgTCdlGv3wdSZiCSU8jKcNYNuaJYh1A==
X-Received: by 2002:a05:6512:3b12:b0:513:2329:4308 with SMTP id f18-20020a0565123b1200b0051323294308mr2609363lfv.14.1710230734412;
        Tue, 12 Mar 2024 01:05:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8238:61bd:7273:ad90? ([2a01:e0a:982:cbb0:8238:61bd:7273:ad90])
        by smtp.gmail.com with ESMTPSA id co11-20020a0560000a0b00b0033e94233284sm5231038wrb.78.2024.03.12.01.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:05:33 -0700 (PDT)
Message-ID: <fd983e63-b546-4260-93ec-ebee4d158f21@linaro.org>
Date: Tue, 12 Mar 2024 09:05:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: sm8650: add GPU nodes
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
 <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
 <58d5b209-94f6-43be-89e0-b14f5e30fd8c@linaro.org>
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
In-Reply-To: <58d5b209-94f6-43be-89e0-b14f5e30fd8c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2024 01:20, Konrad Dybcio wrote:
> 
> 
> On 2/16/24 12:03, Neil Armstrong wrote:
>> Add GPU nodes for the SM8650 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 166 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 166 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> index 62e6ae93a9a8..27dcef27b6ad 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -2589,6 +2589,128 @@ tcsr: clock-controller@1fc0000 {
>>               #reset-cells = <1>;
>>           };
>> +        gpu: gpu@3d00000 {
>> +            compatible = "qcom,adreno-43051401", "qcom,adreno";
>> +            reg = <0x0 0x03d00000 0x0 0x40000>,
>> +                  <0x0 0x03d9e000 0x0 0x1000>,
>> +                  <0x0 0x03d61000 0x0 0x800>;
>> +            reg-names = "kgsl_3d0_reg_memory",
>> +                    "cx_mem",
>> +                    "cx_dbgc";
>> +
>> +            interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +            iommus = <&adreno_smmu 0 0x0>,
>> +                 <&adreno_smmu 1 0x0>;
>> +
>> +            operating-points-v2 = <&gpu_opp_table>;
>> +
>> +            qcom,gmu = <&gmu>;
>> +
>> +            status = "disabled";
>> +
>> +            zap-shader {
>> +                memory-region = <&gpu_micro_code_mem>;
>> +            };
>> +
>> +            /* Speedbin needs more work on A740+, keep only lower freqs */
>> +            gpu_opp_table: opp-table {
>> +                compatible = "operating-points-v2";
>> +
>> +                opp-680000000 {
>> +                    opp-hz = /bits/ 64 <680000000>;
>> +                    opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +                };
> 
> I got a memo from krzk that we should be sorting OPPs low-to-high,
> could you please reorder these (and under gmu)?

Ack, I also add 3 more OPPs that works with all speedbins.

Neil

> 
> Otherwise lgtm
> 
> Konrad


