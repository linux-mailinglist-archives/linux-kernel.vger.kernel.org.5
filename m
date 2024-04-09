Return-Path: <linux-kernel+bounces-137145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFB89DD86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78F61F22A63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F153130E2E;
	Tue,  9 Apr 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1aP/tsr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E5131BA1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674855; cv=none; b=HVM8v6b837k6W89J7cRZj5VwiNcxHfYEh1jZEMQ5DXD1o5xdeEVyoK87ynfeI7p9MGbRulvyvZtssdmvuqnbUJyd4aEQ9M1S7ZVRipuyAHRn2uIPmMNzbPNeK2h92gkN/m//k2YRr/tmUvefARyQIjPCNVv3w5bglrewmfp/9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674855; c=relaxed/simple;
	bh=vDiJeOU8oPrybmyV4Svv3/9T3kTe6c6c++lJ8EMYnHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vf7d09SSBy4lR7RCYL3HaE57YIqpTgihQSM0DMzYuKqg7ZZJjf4khkfIgQM9B78dcHGt1pHhoxACJqgNAgh9rle2loYFHgunCBQtiqEmxzGx3pRFoVJyFQ77Wkt3xWnC3a5uLRU+jyBMPkyAlRuLAYC88Dp9vS5fsja6efMMKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1aP/tsr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6898bebso4631709e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712674850; x=1713279650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OrLZIf4Y0ZsYq3tuArNOXJoRjnrpN5lmgiiz9JN9Mw=;
        b=N1aP/tsrQQ8Y909ZZG/BrG8+1IPBoYVa0159BAb34+ZrSLLeWwZpIiVL9dzAt5nWlU
         /aH3g2TMGZxMf9GclzRfC+OaiQyB0jJzXDEikKKA/Zi8OJFH3UtltxSkJvWSXM5xYHyF
         +7JkqD7vrLVlMTTqBgvpAx9TdO+4g8/H6X8OBuVRUvdj034aobovshHXAbaM2kJRPrCX
         v3ZbjLQzJHTiJljmThhy8AW9/y0JZbFbXcL+A7Izi/s9jYUt8oOQmjMpvbeaTEIzx24D
         ooEoSn65TdxGLUCR44MecfFeGC6R/AkDTLJiOi/7rI+wvA1MT+VHhhkab+KXbtjWPhB3
         ny+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674850; x=1713279650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OrLZIf4Y0ZsYq3tuArNOXJoRjnrpN5lmgiiz9JN9Mw=;
        b=Gen7NnDMsyhJfozauzhjw89TS4YVJ8tcBMI7/EoTF1tGctJMROT39sCxlChgYkfWya
         GkyNqKX6Mid400cQHJmicrYG9OuYWZGjWddWZgIr60dgIJNCDEVChgHlCiNEjw2bS8Sp
         rW/ndaHo0A+B1TPCW+ehOkXqDF81vnm5B6rN/N8U0Ep+GpxikUHolFOeepnkb7tY0uSE
         6/KgI6dA2xisQKKXQEHJlqZ2KEUEdi0aQmPsq2Fqx6zGcbXa1krYiGoPgn8w4+T6VsM5
         qfmSNe7yv1HFCplKbbXfTMglIrNFcJQWkR/z1FBzcFJjxpyuyA0u/G5qRXoxbPVzbUe4
         jRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZ/z7T5CILWjSgcBhfPNv9iVduIvyiV7dXRoHCaoyGeY7y9iSQ+8uMMYINTXboB2fH6Bk08r/3b1QfOvvnlZ6KzcXtzl4pc1mRW/V
X-Gm-Message-State: AOJu0Yz+GgKX5ppPeoqBpWR8qS/Ci7Z2wNfyOUAEiL1xYdd8rUQX1USY
	TxeYGLq86fTeoXpzTrbcifQcEBDlgZSV/uS6Z/wj36veNG7oZaOmKzndsj/HCN8=
X-Google-Smtp-Source: AGHT+IGWt8epolvuE8fa7PcVD3HsDmvrOm9/XTIGHL3kwTAbtz3wt+C0aEwcUcEvCI/9lOFp3wVq1Q==
X-Received: by 2002:a05:6512:4884:b0:516:d707:72a7 with SMTP id eq4-20020a056512488400b00516d70772a7mr7820856lfb.10.1712674849698;
        Tue, 09 Apr 2024 08:00:49 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f9-20020a193809000000b00516aff23fc1sm1607617lfa.138.2024.04.09.08.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:00:49 -0700 (PDT)
Message-ID: <91de106e-5758-4f0d-a3fa-e7ae34c395fd@linaro.org>
Date: Tue, 9 Apr 2024 17:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: add
 USB-C orientation GPIOs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
 <20240409-hdk-orientation-gpios-v2-5-658efd993987@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240409-hdk-orientation-gpios-v2-5-658efd993987@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 16:28, Dmitry Baryshkov wrote:
> Define the USB-C orientation GPIOs so that the USB-C ports orientation
> is known without having to resort to the altmode notifications.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

