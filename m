Return-Path: <linux-kernel+bounces-74924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097785E025
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B64DB28A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849369D05;
	Wed, 21 Feb 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQaK/ORa"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33387FBCD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526506; cv=none; b=jOqClI/FsEfX0bWo6KtzSPho6XOJ5M+KYHZuGVgNZI/wYDpGE28XNQ8SE2mfqiAXcTzKTuCsdMsfFqXQyXaFPgJYV+EX2KkwkWJnSAexsbmDhnhUujsUA407Su3e04Q6XJMkKtwsfsiIHAoC43ysL2hr85BcfZMWTwKn78CIITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526506; c=relaxed/simple;
	bh=EP8HqW4umDRvOBsPISEVcT8aR7cY+L8gNkA+jwmzrB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3URRELWGJ70hXhmmx+cz8kWmhfUX0/4GQYPpw9hGZJ4yCcJJZX7kmrwKFStIVn6cAsmIPkrzAyBSw4OcnZitvpZa0FmWjKpbcfeVGRsu1HcnZkJNjHQz4n5fa5WqCS/aCuJYkLTXgtLDG/GtOZzhEb07hanCOtJe6edxqUDETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQaK/ORa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e4765c86eso512678766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526503; x=1709131303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNVvKppdpjUMIpAElpMhT4YLDf9pEcmZRZrhoHTqnx4=;
        b=UQaK/ORaW4OCzrfUYz2nRqkaVVwg9zZxMg6t4v6GZBxtOdbUQvxttjt/LwS5Bb9ctT
         fqvbNYo7MUeLk7nq2GNKteATjl/IRhYhobK2wZpKpHrt2ZambdyuD2YNpfoP6E8BV3Dh
         QUfOgJhabwydV+cbCwXyeshdGO9ZiFHTTBBUByTa4x7HvZF65EET54LbBZsUdFNh+Sq0
         yZ22+mcn9yACqTu1Arx2ol6nZtjekVxP1urTdM3JO0DBqsfPKP408e9j53KPE016o9ZN
         zUmiYICbW/18+owHx2wN00Ld4eyNeqtkMcYlhjshyjZjZH1xFGdayQaw+3ZL7IKZx0Rh
         P6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526503; x=1709131303;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNVvKppdpjUMIpAElpMhT4YLDf9pEcmZRZrhoHTqnx4=;
        b=R6BHRcL8cy2stKLTXw3d6hgJcd96HAv/fbKXu43xxZXNog49D4hIjU/JzYnAHUtYGM
         0jeEXO5Jhk7lp0CZLa2HIGeJ3QvhqaaidV3AXYGrHHOFy1d72+j0AK+y2L79kDMtpiO/
         lEiUcrKLb6kmOrltqCA77n/+N0v2knZeSwKYuPswmCjR6r6qsQuH4DTTHqkexeSVoCPW
         PIMLc+FsHV5zOoE2s7nnesnUf8xwwjXRGAOpL1fpSQVq+zdEeDSQahqi/7MLHF2gNFaD
         +z3rD+DltHJ8i80Mf6vJRG0EV16Ez6GQfF5JjPGYitFYtdetHQyJGWx6ho5eppA/2pEi
         EZfg==
X-Forwarded-Encrypted: i=1; AJvYcCXMB13NVPE/HwMRat1462Mp0h0wdPjyuGdcqE60gW2N1N7ZPz30nrb7JY9RttdtWkBKBmSkEDwcpGtqaIKLsi9JIoxmU+JOcrrY0qnt
X-Gm-Message-State: AOJu0YwaJimmZLxv76yjcf25NvqLqJgEbke5M6l1cTZfP8Qo3yElHho5
	StjeKhsbgp9vNfjcErV1gogwenjEaf62iQXHDg4nyAGYxMylkcwsC/8Qu86SiaU=
X-Google-Smtp-Source: AGHT+IF9diBdOtITqCSbX0c0UKmh85wxVnxu8kqBryLrIT4N2/35H4N/z4/gqahG8we9+jSbEliCWA==
X-Received: by 2002:a17:906:494d:b0:a3f:4842:2f60 with SMTP id f13-20020a170906494d00b00a3f48422f60mr1058962ejt.70.1708526503366;
        Wed, 21 Feb 2024 06:41:43 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4983128ejc.69.2024.02.21.06.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:41:43 -0800 (PST)
Message-ID: <bc45229c-6412-4fd5-ba8e-28b293d7864b@linaro.org>
Date: Wed, 21 Feb 2024 15:41:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: Add SMB2360 pmic dtsi
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
 <20240221-x1e80100-dts-smb2360-v2-2-037d183cc021@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240221-x1e80100-dts-smb2360-v2-2-037d183cc021@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2024 15:38, Abel Vesa wrote:
> Add nodes for SMB2360 with the eUSB2 repeater nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/smb2360.dtsi | 51 +++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/smb2360.dtsi b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> new file mode 100644
> index 000000000000..8d7bdb56e6fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +};
> +
> +&spmi_bus1 {
> +	smb2360h: pmic@7 {

Hm, I'm not 100% sure about bringing in this letter-suffix notation..

But then, is there anything better? What are they called in schematics?
SMB2360_n, perhaps?

konrad

