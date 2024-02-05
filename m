Return-Path: <linux-kernel+bounces-52879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA69849DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896E0B27231
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E132C688;
	Mon,  5 Feb 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFOKGX/A"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BC2C69D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145935; cv=none; b=SvoK/9dIsaDpttgOAF+0MI+GRNh0MoUgZ9fiukkKMHZYPBdVzsqnWrAq59f+pmzC7nBoZYTlQ52PzrW2RYR4DmyRt9jiQ7TlEgPf0OhzI8bYZ+wJTSLnscV8rE7JBuOCri7hcOAdmCBZgGJoCIRhWbNXg8gkoa0LMU91k/2PFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145935; c=relaxed/simple;
	bh=8KHJiJdvkaYJEmL8dJDvp2dK3TgjbQJhM/nTucwFCSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmPMCFaOgYG/QONf17G3Er1ufyIkGhebwJyi+tjKe7G2cy86suCcju50H7Q7/KvKelTrVaBPkgaQGGdxriysKmp8TWkK0en3yw71SvkbeEZScg3MKjHz8aRN+nOxEUHyibsXcOl2wGjW6tBCFNf7P87rB3bZHmp4S8/ukHFKSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFOKGX/A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fdc500db5so6511035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707145931; x=1707750731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XukEwwNROST4MAhIsD9QHQj3cxSau4ptDbEDrBWVEZo=;
        b=iFOKGX/AG2h6xMk5htrLWJhp76U8d8NJM+5owuswu+XY9JMlsDdS+wnxSpj9Q11YFe
         EnjideBOOMsR6xd61LrqXpBH/4iTKHPBVj/pS4p7P9WrIT2QoHDNFE2eYefxxSdWNmZu
         F1EJuBaKqT9ufKES0QnRKOC5JVvEBQHOPOvGYL4a9sZq2tI7xYBcE6vsoHC1awEXLqNN
         8oASx9agqeL7dRq5FDcPeSi31rLtz1NDIsSej+7lQtV1QazmITNIqtfuUMVilCepf+aE
         d7ac6DPIAcDAPB4ukVSJ2dXtZ1+156sPObp0EOSU9ohsOmH5sGiA2fkdkI5pdwl9jCAm
         TmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145931; x=1707750731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XukEwwNROST4MAhIsD9QHQj3cxSau4ptDbEDrBWVEZo=;
        b=KgM4SwqCEDxPq48fBx76oMKLcSbHrJNU135SYitdJP60KU6c7z3m6m4jK6hZRD03Ux
         FZj9ycIB+3Ofnr4HCpqk/jEs9a+mN5J+dNs5g/RXbUskmkGFUaG9GfVZbwfbkMRmP8J+
         NvZ+IYrZgM2vDQAZdHkutJ2Hxr3H38RBcV9ej1d0tmqWBgHwhHyvw34FjNhJNliqewBL
         hDhcCGAMgtyLaoTvTPqEdHp0P3aIVlVyXuqds8QcJv2bfGS8E9qywXZFKtHysaB/aYqm
         4HchZRB/0exqsk3QPlhCWHFBftKNMoQVEPSsonX5nFtbqJf5Y3110xXNWF9VgpPnAVR5
         Jt5g==
X-Gm-Message-State: AOJu0YzSoo5iOGHCt4zr/Cl64USmzQH2w8Q293cQisnnCKEAIDbB7et4
	2ekh57kwFgWzsafIh45ApZB+Og+dXirccME/NuGN44bCkpJWRdU4enRk7E/YPrA=
X-Google-Smtp-Source: AGHT+IHHICDtw/8losgVG/NS3r+mfbnvGOyxdEXUtpPF9IWSh0adWS7114402LJLDqzLQ4SmAQMBJQ==
X-Received: by 2002:a05:600c:5490:b0:40f:ba0b:16b3 with SMTP id iv16-20020a05600c549000b0040fba0b16b3mr70606wmb.2.1707145931619;
        Mon, 05 Feb 2024 07:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLV6ifnAjcXxTu16J3k3pzYbjQG7rjYgS8CXd3se8D21ocXYs7zcHex+U2Z/NO5wZMl5ZZMPSutu6FVoRVm5SKmUs4S/YZsQKr9yLKUv0IZEfpWmnBgC8PWIOqqCnttdfYenO/CAEBbPjQHLR8Cza8sm8VlcQlCfMDzyA+CoDiUtVXQRDdy1JMPuuZLc2sGHAVcHOSEmv3mRYTaCktRBPs6HIeP77myHcg+jK8DKP9MwpYi4SDnZKjh85e5D6OXHEspMSzNmcV0Agfj5uw7qz0dbBY3K3TGOP77dwOwrpugp4B4vrnM5HKz3wRCeCHDh1okNKvzkBLqDdQGMXN8MdQn/Ny3Diy6tk+uzWl1pYBi+D2QeYDILImdZe8dBTky/FY+TesHloQ
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0040fb0193565sm8777767wmq.29.2024.02.05.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 07:12:11 -0800 (PST)
Message-ID: <ecdf3c46-77ba-443f-9d64-caf4dc67fc3a@linaro.org>
Date: Mon, 5 Feb 2024 16:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>, djakov@kernel.org
Cc: rafael@kernel.org, corbet@lwn.net, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_viveka@quicinc.com, peterz@infradead.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
 <20240205145606.16936-3-quic_okukatla@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205145606.16936-3-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 15:56, Odelu Kukatla wrote:
> Enable QoS configuration for the master ports with predefined values
> for priority and urgency.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/sc7280.c | 332 +++++++++++++++++++++++++++++
>  1 file changed, 332 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
> index 7d33694368e8..438f927935e5 100644
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   *
>   */
>  
> @@ -16,29 +17,53 @@
>  #include "icc-rpmh.h"
>  #include "sc7280.h"
>  
> +static struct qcom_icc_qosbox qhm_qspi_qos = {

Why this cannot be const?

> +	.num_ports = 1,
> +	.port_offsets = { 0x7000 },
> +	.prio = 2,
> +	.urg_fwd = 0,


Best regards,
Krzysztof


