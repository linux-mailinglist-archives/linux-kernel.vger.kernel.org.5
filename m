Return-Path: <linux-kernel+bounces-155613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651258AF4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C931C22B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1413DDB2;
	Tue, 23 Apr 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3n6swNb"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6713D8BF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891719; cv=none; b=tWcUeHpedtNo7yHTLaw0UAdBBL/ApgdrnVmQDOkDwgH3ksmzLh3hMWw/f4Kf6MCMYKprijQL67HYgdQMg+OhfhUC0K//3kU9UbJjcBboFeM7EnKLmVYhg1xzexOeaMvMZrhQyqbgTstPP3dArD0iqHLfrrKLcGG9DozUGsbijIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891719; c=relaxed/simple;
	bh=cC+dErYbmnokudp3GhDMHIAy+gc8yV+HfdxgXByLeSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhOXEjLczjIUpG/kQraW1Yykvjdpn4P6EeVRwUTC+1PhkuM10f3/xz1AFYh3Cj9xNwGpZTBqqN0GRpk0RZJDkzekUbNO4WS72ym+hsGfM1/lpvx/aJInRChoS2/nxV8FuidVWRgWCg9ct7wwhnkhaBk4Xje53KKnvFwdOoVOj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3n6swNb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ae315bb20so4563899e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891716; x=1714496516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9xHbZYIG5Mw8Eh9K4eptlqfJVILD/D23wlU1wrlp58=;
        b=r3n6swNbxTyErIdOJHqK7cJ7IVAu/yw2jzhLaKK6mIt8PBSgA2KJ2ahI4olOgv8oTd
         DzVbBeAOfMvs6OXytFCyTdOsRfZg/WFhhtr+3R3RhhhUOh8bc5/0M5FiuZ0jw/VUc2+1
         wKBk+LPTrfrRbq3KYBdwAqhHvNzlRYw2TJsflB191P6h4Z7fEyUmNn+GZRegXhNpXXs8
         aNpFKKYPkVgfmj1hBHdH19fQKVo4bqcB33CRD1jPcBBCxuCL6t7fIllO0/tH1/qQByba
         c5N9sBC5o3lhfUIlaALjFqbzW8c02QTWZRVa8aW5/Q8kT+Z4XIYet5lw6ptd6UdWNjTy
         QZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891716; x=1714496516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9xHbZYIG5Mw8Eh9K4eptlqfJVILD/D23wlU1wrlp58=;
        b=ftYRYXNfLkMm5pvDw3lC7LOnPhVgx/fmpKPBauFPyuaWqvJD9VIOpfq1sgqsBmFgen
         0fffrj4lqcNzN5BY91pThhUf2zIDioabnjIxDADrDWNI0kxl2L2xiO5TjL4mvEbsfIes
         f+TCZjYkrXWwpRtbvBZBty4Z+80q9hHySm2Cfcl4q2lzd+CvGaDAVHu8bU1LPRQ8ViLW
         OBMXMnmHeSuo2ywYlF7Jtgsd3TmV4DXERocHdxPg7R/XdZW/oyX5hjgW+KRevlDzwYhW
         V/Hd5XrsUXo4U18rVdI7bDv4UYx7BoiMXv55lalJcBaNQvGwNPPhkKQn9iT2X9J91/2a
         rC/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNROP+kCqsr4thX+rfcgJHDd6QM+QsJdeG+i/Q7uFXXaA5YUAIoGAhwKmuZyFZLLS5gpdcKwHtZQioRMertWEV8FTHSC0KzZqRHwuv
X-Gm-Message-State: AOJu0YyExBQfYKSGqw2ljB9Ljj/4R4Z2McSz67FlJNkE7hRuW2cbdKYq
	WJlZDY9NDoBiLB9cUW3S4LjGwXHRAYl0Thoaqu9Ih88ffen29SWmF6kLf+cb2vI=
X-Google-Smtp-Source: AGHT+IFFgAqRTu0OiAHoCmMWpJsWpTFKQENMZbvbVW68Tnv0kqgDei+xKSGXPHh9KPd5kq4AudXVJA==
X-Received: by 2002:ac2:58cf:0:b0:516:7738:bd5c with SMTP id u15-20020ac258cf000000b005167738bd5cmr102879lfo.4.1713891715686;
        Tue, 23 Apr 2024 10:01:55 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id e17-20020ac24e11000000b0051bbb1031dfsm150689lfr.182.2024.04.23.10.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:01:55 -0700 (PDT)
Message-ID: <a6936f38-78d8-458b-8864-543a923ad1a1@linaro.org>
Date: Tue, 23 Apr 2024 19:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: msm8976: Add WCNSS node
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240413170317.34553-1-a39.skl@gmail.com>
 <20240413170317.34553-5-a39.skl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240413170317.34553-5-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/24 19:03, Adam Skladowski wrote:
> Add node describing wireless connectivity subsystem.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

[...]

> +					wcnss_wifi: wifi {
> +						compatible = "qcom,wcnss-wlan";
> +
> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +						interrupt-names = "tx", "rx";
> +
> +						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
> +						qcom,smem-state-names = "tx-enable",
> +									"tx-rings-empty";

Since you're already going to resend, please keep one entry per line,
this fragment is very inconsistent

looks good otherwise

Konrad

