Return-Path: <linux-kernel+bounces-102367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4287B13C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D671F27700
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949C75810;
	Wed, 13 Mar 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4nVMhfz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838757580E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354747; cv=none; b=IrcOJMngGaKPQ7rPzLAtTyREeOOLbiWuEbkUUcE3lTLGQgEu/BMYu51UW7QWvWUSXI7HWPYBzodEtLVB0c/aRR3laSmklaJP8NjbSEpBwbpYN7qR8hTC9MQHziHCsAAkzVZ4oIL5JZxU6qmB38yMhlCR+3wkcLSrK3O2OaTjJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354747; c=relaxed/simple;
	bh=DmirhLhHmvPnVjPsWgHzgkUR3c2uacOPJ52RQk/Sgu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXfrw9HNyq+fB42XdKPrkYmqoJPKr7bPvtQo74hztHH/wwHVr6+7oCvO4mTtybpX5oIgwC1iKYJD3gYo3QK6i6ZAlcuLneuN7kvF4QZ0qjw4imSLwi3MnqypS+NFwffVQJWnKCRBZOi5SSHbXjTIzOXjqVoyXx5KTp5KVnMf9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4nVMhfz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso204660e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710354744; x=1710959544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c46CXhHIkfJWzpxGuQS1ConTUqzy9VFRi62kx/9tVb0=;
        b=z4nVMhfzBPR1AXSL9XQenL1ciy1Vz9Un+UqPwvmviYoRe9fTtYcyYgDSIDx01NWG1T
         IHmjlgnFN/hbnPKuNc+g7M3T9S0rdok/wW02JXi7rae3KJ5WYrcbUS5OHx39J/+AhoKo
         NjoJgFiXK7UpdQmIi3hKl2le3wqzgfQrc2WEQqe7y3w5ncVtcXb2rlc/A8mfCRWI9FO5
         qHXWmFg033csT/MOaEpt4ZGUg8A+oXOnfydMYhDB8gSUY9uIGzwJ3HxhfQfzwFwLSbET
         E/+03zjrIRWS1D523TyMYhba+3GbmLs8maVAxYaTlPZQfelTs7j/9NNXNjjXl5YOY5+O
         44CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354744; x=1710959544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c46CXhHIkfJWzpxGuQS1ConTUqzy9VFRi62kx/9tVb0=;
        b=dswMI1HdEaa0iYgbt8EDraDlPXYAt2gn830wcouta0vYbDaCmJf5sarFF8AbBPsdX4
         dCSObgxvc8WNNLzVAyrJGmgQ+/YDbvyqRJOlDgVOfhY9E8qMe5pY3hNXLEGPHovL8DgR
         nSCMGXRt7K100kTYwAXSO18pCx8Htm1kgZ/PCZ6a0lr3BpdkAejYorPvSRUNfzCV2My1
         SJOh6D3rpu5CEG7kqV4xLnaIsYrrEfNMEOYy0CX5vvCM6BrVi6lXSzjRfauy1yj2cPQm
         2fdCcDcGQzzXZpP30QKApXKrRpnl2bIObneQrYvmcPz31UogEfsI1EDbY5NEegRGRkGY
         e4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOwlVYmI80X9MMQJ+ziAvAeuTXmRHG+13TvTWJJS58BbwxQCC35VMQnjYUWfZRg8hdzwvtpEDnFmJ84RUYVOGIodKG9/zhd0xnIAuK
X-Gm-Message-State: AOJu0YxGCq/gQ/kDnjDdbySPljo+PJnUPtANPJtx/SwFj7VlEjFPb7ny
	lvIs+d6Oyk5Ln2usq5VSayMi9MFu7/4OdiRZ+cSe6WFmx3z4bmct0+3Lz4u8d7JqHtdQcyQbnTN
	pbwA=
X-Google-Smtp-Source: AGHT+IHf78ai9oWGrDz80Yon9mpdoWYbkk2sC2HWOSooJ207ZNh1Pw6Fq+km1zFujDhy0w0y5k/d+w==
X-Received: by 2002:a05:6512:368a:b0:513:c146:fc02 with SMTP id d10-20020a056512368a00b00513c146fc02mr2429517lfs.6.1710354743640;
        Wed, 13 Mar 2024 11:32:23 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a8-20020a056512374800b00513b324cc32sm1113882lfs.268.2024.03.13.11.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 11:32:23 -0700 (PDT)
Message-ID: <eda651eb-6b8c-4cb0-ac08-c38666599338@linaro.org>
Date: Wed, 13 Mar 2024 19:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: Add initial support for rb5gen2
 SOM
Content-Language: en-US
To: Wasim Nazir <quic_wasimn@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240313071238.3290-1-quic_wasimn@quicinc.com>
 <20240313071238.3290-3-quic_wasimn@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240313071238.3290-3-quic_wasimn@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/24 08:12, Wasim Nazir wrote:
> Rb5gen2 SOM is based on QCS8550 SoC, used for Rb5gen2 board.
> This initial version describes regulators & ufs storage.

[...]

> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1g_1p2>;
> +	vccq-max-microamp = <1200000>;

You want regulator-allow-set-mode and regulator-allowed-modes,
unless for some reason you want them to be in HPM permanently,
in which case you should definitely comment why

Konrad

