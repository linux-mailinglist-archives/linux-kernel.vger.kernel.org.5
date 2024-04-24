Return-Path: <linux-kernel+bounces-157671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF88B1462
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9161B2BFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032C13D25E;
	Wed, 24 Apr 2024 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrqdHiPR"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E26143895
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989672; cv=none; b=YGZ5XcjHzkknExlAp7/xTZmK3DMiuaY7q4CSkIRi0FmrRTIMNoLYyv+z82dLo5UwNwHYB8QKe7yJ4qYgNYOy1QOEgf53O6ZqCQJTKEM8dl4VbbGgNdXSnjUumBq9e5gnddwtrh7oW3UPnoYCX3NdC89ZLxO+1xb5gcT7KLfCmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989672; c=relaxed/simple;
	bh=5juKDdGEYxNl2ENPjsF/4a/Y2iZb9ON1oaGj0sw8O/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtYxGvCpSpqdSn8sAQ3OKnDP2cLY6fEsyIE2UQ98CjNQLXyfPWsoSjJeLKkvsV+eOs8uGtQJ04Dwx+8PdabiM+eaK1bWWGtDRcxFJiLRgziElLl0dGhZ5v7MX7dAKBkTkZZVv8J3mA2e19D6Q9hBU9qHUq/kTdEXfV144pMY+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RrqdHiPR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518931f8d23so252376e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713989669; x=1714594469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=RrqdHiPRlzFgB/YHAMjNRtEi7bA1Korr7bo5TaSAuiPLAgpN6Gg3Qprhmnfoij7Rmn
         ddbEX2E9guF73Gl/qxCubSjrKEgeOaLY7ph20jVyt1pvkm8s+yFa4ikJwy8vLJlFdzcL
         SejCQ3VfanAHPgQu9t4A2kxM1wq6Igs/BJqyd0ja+/aH3It3Clm/2LHdogFICDVdpAVW
         ukYfXsKeQNklSqDgciqkSIIz2t0FoG5gJYKW3VCvhybAqp0ddcvRvCg/bEtCXLHDDOcT
         WKf5ucguoxopL7hJuVLRKs4P2aSuJHDivsRDBV1bq/ihs2z4ytXPGRQOXyYWhBZSipy+
         ENfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989669; x=1714594469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=XtOF5UVsNiaa2jm6loFTUssQjqmD3oleTW38CEAzPbrT1SuyS3yCfGl+fE6h/A0CpM
         O1b8tojF1uQKRkPx4j+1ZL32rS8dKeTHmYnLFG3y6JUIOLwJemfyAWYIGl08SmlXwxuB
         Xgtwz+UQOsICj+pbDtvX+YzDe4TG0eLO1Rp6NewAko9EgmeptW1J8KuN9K+YBRFqRLZ4
         aeJkexTAbPYDvam49DSC06hPXG5ihpwdg+tniESV7uP/cd9WgoUzR8T2vZJ5ZNOABBEW
         uWfhj4EzM91NfhtRggkcHwHoNUy6z1wF7qVbfv868ZJA/MKgYrgbNl10RoORXPn+Vcm8
         UUeg==
X-Forwarded-Encrypted: i=1; AJvYcCXiWBtax7K+C9LNY48zjm3Yo6WpTJg84Suzk744NcLYYtCYwHZIo1veojHCp3ROMI1JINx7hb1HR/yiJRyIEV77dGcAOVjAet1LXaB3
X-Gm-Message-State: AOJu0Yw0DonYXyWecwwzSBLDvKPrP83GPAbwuENrdHICboqhF6KJ8x61
	Qg1nn9/cOP4jNL1NO9nPOlmnAy7lHjnKvtds5xj0qSkUVXkGUP/CBDWo4NbUNzo=
X-Google-Smtp-Source: AGHT+IFIzbbNTj6m6kGkpPa8i8ekvwbmU0oCByomId+50qDRUiDv1Koq7Q2A9H7ah8qGTSTuaqVT6g==
X-Received: by 2002:ac2:4887:0:b0:519:5acc:b114 with SMTP id x7-20020ac24887000000b005195accb114mr2433319lfc.45.1713989669504;
        Wed, 24 Apr 2024 13:14:29 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s6-20020a197706000000b00518d7c38cb9sm2567308lfc.284.2024.04.24.13.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:14:28 -0700 (PDT)
Message-ID: <4d941a6f-ba47-4c1a-94c6-cad24c6f59cf@linaro.org>
Date: Wed, 24 Apr 2024 22:14:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: qcom: msm8939: Use mboxes properties for
 APCS
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
 <20240424-apcs-mboxes-v1-4-6556c47cb501@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-apcs-mboxes-v1-4-6556c47cb501@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 18:23, Luca Weiss wrote:
> Instead of passing the syscon to the various nodes, use the mbox
> interface using the mboxes property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

