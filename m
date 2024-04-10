Return-Path: <linux-kernel+bounces-138471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C298C89F1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1141F23A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5215B0EC;
	Wed, 10 Apr 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPiVYF9a"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4F15B0F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750924; cv=none; b=cwHdilyA6vj/C5KDLsFzc6KjGXm8m4l5Vf+cDkjaglTUadpNF1AocUnl+v4FJUoU3L/iHkCP4T9g1lx77igyMQvTm5s3B4xOOW71Qau7M/kfFCmSlnnpGFiGaeH+h+NVUv+rQ+XIVyuei72Og0pWaVQbFMgyK7eZzjKC1pfWM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750924; c=relaxed/simple;
	bh=jenHaOnHcbxtWDU/sjx/JJIEbosXdTyAf0Nq51UQ+ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipeORMvchsi+igk5uwA4mBfNMj0NqRsYEhlmaxped+cKE9GMkfo/TxnVr6AD16dfyNgo5TmS3rFBP+iYoa4wLuHV2Y2NAxjKhMGOwiAOvnAS6QfFj3aO+CMXhyPCl3Ak6LbCXbSuali48xFVoB8YVqrhG1GeZCtgdbqH2RFNwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPiVYF9a; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d756eb74so5958037e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712750920; x=1713355720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/eIBodkkKg9gHiISFmQzqjV9vYTJz8x5fg7OEsG2PY=;
        b=DPiVYF9aQ0Rp0shN0jc7a7gZB3ChAgjpGMGFblqHQiPmmI7UFWvkDaWILtEcSMc+v3
         w3u03LfixU0LamxAPxJKwJaQFQvBJGAQdfWt1duCKk/cEUugt5EkgeknC/lsuOtBWeUD
         bBL5odqyAy+gzNYeQQLEAN/3qlPt+H1t5UGOWVrjofs5eaZoVd9XdAiTXa5ZZExXDwXh
         ba4mTRiCF48BrUkfAUncEPs3xhyqiLuAEL/6bITYwsRBOUHEEOsFtbiN3CIPlblmk+Lv
         HXwxYo1rW9c0fEmkfqiWFeuH4IL23Di6taXJ4h2kIRzHMDoNFUGBMEVrLrqqjIQjm7lF
         +U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712750920; x=1713355720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/eIBodkkKg9gHiISFmQzqjV9vYTJz8x5fg7OEsG2PY=;
        b=LV6ZC4WNQqE3onSK7aeAKa9856nPfPLIXDOiV3tKVCfeKHRAcKcafsRrA1UW8jFrOQ
         SsWeT06Ghm+1a2j1+3qFt3CIFUCng07NskombQrKR7ig4+I+Hw0BOXPfG83hC0bkDbF1
         q2UfZxWmEuEbA4oWaFE91oOOKqbsTaHAqAlEq6c3Nkd0VUjZUSd75swwVv0zaycVNJCo
         ahjrbQqWC/95VAjNAbGjmx+OI6vc0KasX9gKdaJAbs1uDPhj4iO8Y+TbpaqWPimrBvbz
         Y8ACKNSZXLU3GGDjSIe0Rsd2r/v058LmX0JNF0iSLF4yaZs9HDnnm7FFCky5DXsR2UVi
         GD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiKfxx32l8UD/a8RvLCJmxFsIk1ubLjgQGd+0RQI249NfSwxrDwbx0g7UfEa8z1WJfW5uyR501G58/olNFyxJG5r3wCO/qhihsk8QU
X-Gm-Message-State: AOJu0YwutRrjtVgvVLQ8tWi8oe6A/tb8IiEkxbw4KCCuBAS2l9PpOeph
	Ujtdkk2EAlKep98RKCOXv+zQSV56J8H8vH67AaHvo2yt3gKrSGIJckmNeqFGkD4=
X-Google-Smtp-Source: AGHT+IHWhWVUT+mJBbmOEO2cd0a3sYytqZtHgO7IW9217h6HPe6S+6voseWdDbeYpLJ8PbQDvZI58w==
X-Received: by 2002:a2e:81d2:0:b0:2d8:5fb1:4b80 with SMTP id s18-20020a2e81d2000000b002d85fb14b80mr2016525ljg.24.1712750919723;
        Wed, 10 Apr 2024 05:08:39 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r10-20020a2eb60a000000b002d2dfe8a36csm1795293ljn.96.2024.04.10.05.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:08:39 -0700 (PDT)
Message-ID: <d21b1b9b-6f1d-4ffe-b5e3-41d0a43fb17d@linaro.org>
Date: Wed, 10 Apr 2024 14:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the
 TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, djakov@kernel.org
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
 <20240329210638.3647523-6-quic_c_gdjako@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240329210638.3647523-6-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 22:06, Georgi Djakov wrote:
> Add the device-tree nodes for the TBUs (translation buffer units) that
> are present on the sdm845 platforms. The TBUs can be used debug the
> kernel and provide additional information when a context faults occur.
> 
> Describe the all registers, clocks, interconnects and power-domain
> resources that are needed for each of the TBUs.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---

[...]

> +		mnoc_hf_0_tbu: tbu@150cd000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150cd000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
> +		};
> +
> +		mnoc_hf_1_tbu: tbu@150d1000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150d1000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
> +		};
> +
> +		mnoc_sf_0_tbu: tbu@150d5000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150d5000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
> +		};

These three are missing their GDSCs, the rest looks in line with msm-4.4

Konrad

