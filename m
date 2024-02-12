Return-Path: <linux-kernel+bounces-61375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C4851184
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980F02870E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FA3A262;
	Mon, 12 Feb 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjAK9lid"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741138FAA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735020; cv=none; b=Nk4GMZXBu77FERnppJFeIgo3/Y+oZwENRIumZ7zyGDGnPCxBN/a0x3oR5GJ2zKQcTrTEyaTGXE/aBLyq4rrJaJNNDagLgHCVmjyiJaAf/gO6Ji/sTOAXD1ALzP82qwyfHlbTNRkNGVCbR+LaNfd7e6FBtVbCKVs4DLkJfedlpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735020; c=relaxed/simple;
	bh=4Tj5FveOP8pQNFj0S/FjXvnD6Jf5xD29Uh8PHdgkGaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNt7UmxXBEJ5nWHVFf3O/dtuAIVAuDia7h4z81tjpvMZqQ4tytk7IyvNh2AW3ElYcC2hzfoFZrHwRXPWYI3r+4pVjSn/ShfRWRz/5YThD9p3oN4AVZqi9Z7ehRXfDZifrv4kpl+p2pJljzI/5jdqpU6RHCCUwzjYU2B7TkeQFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjAK9lid; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so38303541fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707735017; x=1708339817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsiONBa9OHg8815U9gD4Jj6CHBQCQ+gkIU50mMZU6DU=;
        b=TjAK9lidqUJumLZrgvvEBwerkBoKMifBYBfTJpeo5qTsjiO/tfWDy+LQutBvOpVCIg
         MCRcHnkz6xv/j3u429roP7f/CNIiQXeDLXH+P+qUhgeyTXB4PZL9b0aBRP1JwarwSBSi
         7YzLnWQKHNZ7v1PAGkpc8WRGVe5am1vGWaU2ktm1EA3NGI4vca7oMxqSf7M7bF0koVEC
         JgQbums7pKKgY6K8iM2akKVOHAoCGLxXaewk7pjG1ns98/kOZHFu7tsoVzcXaZDks4TX
         a4a0OFDVJiSj9DONlmbZ7BKi7c+aNfnsLY0E1uNtVjY2yJg9U3G+xHe6JvS5/obCgwDL
         cIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735017; x=1708339817;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsiONBa9OHg8815U9gD4Jj6CHBQCQ+gkIU50mMZU6DU=;
        b=TW0WxeaFraSzy9dTu/P957N9G4NyWD8sg2JjFFABDAA/6LyCzQgjJMMfUyXXWDTdZw
         xIGgb++1XmXIEcXp1r1rr8I+k8FoIcKjCxPRiRYN6WDLx5FkwxI+h8kK6iN0H6khZbiC
         ZjUq1vytM/zjFakgzwR2+zTOignQv7pzLxIKwaM4DjiCLTDTqLP6wCIyu0tA4YNXaN92
         bmddsZ/0HrN7vP87wWtRqGQQRUqc7M88lC/saXg9e7iWExmEtL/fXS2ts79wWGCcL1/4
         pIGM3u34xBqOBMAnQdiV218qNO1B7bXvb7iqh1ECnWbN8pKJkUfcedVQkiB+eD8Fxfl3
         u6HA==
X-Gm-Message-State: AOJu0YyTDaowQAZLhp0JBTPfwvm0NhRhXkZYFxrl9W0TGMphIj+8LIoJ
	QICUFLOQNUagDrxAfru850bmqWFMNv5a48IhszVWScl1NCyR5B52+nfzaHGvwUw=
X-Google-Smtp-Source: AGHT+IEkrQwwLL5wWEukaiwbioQi4yPz0By7s62pvcF00HgGyRboEPg8+q3tloDCWZm05GD9w7JWDQ==
X-Received: by 2002:a2e:2244:0:b0:2d0:e0ad:df4 with SMTP id i65-20020a2e2244000000b002d0e0ad0df4mr4622172lji.8.1707735017374;
        Mon, 12 Feb 2024 02:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU55zE4MLG6Kky4doZASDNqHgttMqHsVqbyqGAgdoGC/N90zMSAWMNs5qFesk+XquXpp5RkQZWzA/T7DUyvt7vr+o8yvTVJKERLfyA524AeUNyP4MvfGmaF9Z/mlNz8LfYYijLIDs9QDpMwODGa4/dYhaefot9yD3UGrlgG7ck/SwQ4KwonJG+5YG1sgkLOWzhh+DgfTRALM+YhM6354OFU1A/vbaq+F616aP2UG/l1A9UxMuSpfcXZm0kj8jAmWp0bS+PTijNf86i8g8yvBGjzwWIRS3NF1+XH+xPN9ZZXQ98zubNm/WHFnrbVQxg4351AYw28CuPyG9GUXV5/yMHK7IFp6nhUmE/CP9348v4Cuc7pSY3sOfdigjVO2aEuP0zUrIioA2FuSYGNsrlSHL/KBG5AFbGb9Z/IuPUbpt7TqkKszjbxHuSv7Tk+kzfd1hc46RdrhQv5EbxZ1n5hraNzLIAE/0ledFXPedV12NwKbdj/eT7EwqdKjCS2qT2shzy+cy+4lrnem9hNfrxkv5FwFo/gVqlJFNXvM12xHpZnT6n5fh2PD37Ge4+N6V71NoyfBgRc8F4LnEql3xqj2xYmJsd4s9WfR6+e0mizblfEcWQ3vIn8EOgilbq7LwMKXRl995gWoG1efH8mR9UhTCVj1wOoNB4qu2awaocfAXgDwamMep744GhZoy+CAt+w0mfuWJ18oN9U8/A4HvfZBZW9RObcXOxIJDzZz/+R/lKD3KZgJ9bm7qVNwXnuYO+PlaOTLTivFpzt9d9jfXyD4LVfQpFYtn1dUTfIOmj7QKhLrK91U9nsUHyYCY+0
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id ev13-20020a056402540d00b00560e72d22b8sm2660498edb.2.2024.02.12.02.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:50:17 -0800 (PST)
Message-ID: <70caf0d0-28f5-48b9-b10e-5541488dd982@linaro.org>
Date: Mon, 12 Feb 2024 11:50:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm8650: add GPU nodes
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
 iommu@lists.linux.dev
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
 <20240212-topic-sm8650-gpu-v1-4-708a40b747b5@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240212-topic-sm8650-gpu-v1-4-708a40b747b5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.02.2024 11:37, Neil Armstrong wrote:
> Add GPU nodes for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 169 +++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index c455ca4e6475..f6f9e603fb2f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2582,6 +2582,131 @@ tcsr: clock-controller@1fc0000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-43051401", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x1000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus = <&adreno_smmu 0 0x0>,
> +				 <&adreno_smmu 1 0x0>;
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "gfx-mem";

ICC should be unnecessary

Konrad

