Return-Path: <linux-kernel+bounces-61452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D6851299
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664141F23745
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBEC39AD0;
	Mon, 12 Feb 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OekmQbST"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06539867
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738520; cv=none; b=oxXcb5lE3AEnakdKI2+OWY3o+AqSlFZIbrzMwd3JvtHdjLoWDhaEQDPenjv5PrWW55385/Q+ufZkyKQ6i1B9UjzskNBgyokXzvmXHtSqU19Ub/UjRIu/D8p04ywIw3EXw/rv9HV2XX0K7WmMe6amiwTJamBI2VAqTCISiU1Hez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738520; c=relaxed/simple;
	bh=XY8pKtMOGlU8E7fmXXTFQQ5wVyVh12EH/rjSh7TceOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F92KSxSXhwmoKRynzFWvrwYk4mcd+cjupIS1CnyzTUKogBnT1M+jcF2hVV+Reej21Qj1zDhePoJLxMwsNwtIgMoaRj4SKAvm8JBpkywX63GG75YgBAneFUzrUu/Usy150wc3zMN7cfwH4nwvb+ujHpaFPAw5HxbYPST5vUC4glI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OekmQbST; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411a5a86078so206035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707738517; x=1708343317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY8pKtMOGlU8E7fmXXTFQQ5wVyVh12EH/rjSh7TceOU=;
        b=OekmQbSTu2WdDQbk0zuQmLPMqBltcxOxPuMuenfDspiFKifJ0To6npllULofDgg5F1
         lI85zsOhTBQx3Y2qZ/CpZKjN/vGG3yIBkEDszAadYb3ieapuw2eOsXXsJoFWhQpPNkcx
         RoBV4Myy3893CIiXnwmrE3/Krj2zMDd7Gl57aTpkh/8jDTwhP0qsAEFHx4iiIzTErYfC
         z7quI+P13bV8LDm69k3fJspSYsVgZXNwcz5VF++7BsdjQWY/tJA3Sy4p3gzpxyvIK3Gs
         lsDbLfmtu2JxXoCj8m5mYQll1JcS/73i8z5qWG3h0TIy4tVTJySggXB9EUDMarE/r23I
         X91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738517; x=1708343317;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XY8pKtMOGlU8E7fmXXTFQQ5wVyVh12EH/rjSh7TceOU=;
        b=sGmTdL25igYWhDMSgVCt0s5GFbMbvotFv7xMNTrKlMNBwr1FD4IH7mc0INKQli41Zk
         KFo/CjIh4wbdEKdUzirHA324oI+ceBK4OL4EWrEbFJrzeylCKampvRcvfjsFdMkdcqxn
         ipU8Sh95kep6Qkzsp33STn/iDbXzUHk68QVX9Bdo2IEAruOAeCP3g5cz7cHaz6+WCs2g
         C6sLZSQ9wRNeB2RGWrJ+VoRkGMnaoAc/M4NZC2g4cyKubyZdc3kYy3PrmL2f5paoHMC/
         L016kXrhX9FqKXAuUa3/0OJaB0WQKyUZNy1Kxl2jEsSf6vbAS+HqqOhMUgXZBkggrv1k
         LkWg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EWsBmsKZTsy2oL5ipjhmQQBa0z2kq+1CAGly+/zRU4XIZCP1Onj/uk9Rd38+qWmEDFKfIrR8ONlNsOKxZAPJdMU0MakUxlDBQEVi
X-Gm-Message-State: AOJu0Yxfbe9iTbpded/Uj4szRyAo3guQAOQOswNuL54McynHuHIcMQ68
	lnW3OG/N5dcsuTyZsCDz7ODcyt2KIvkr2mUYCBuzaejIrLEr2cnfwCjG4Ww/XlM=
X-Google-Smtp-Source: AGHT+IEj/Q4zQlqs72828T06S++ozVybJYIXY6j9E9iaa2Mnn8VzBE59Jj+r+vXY1CShCioQgfHvPw==
X-Received: by 2002:a05:600c:35cb:b0:410:7635:4087 with SMTP id r11-20020a05600c35cb00b0041076354087mr5827825wmq.6.1707738516774;
        Mon, 12 Feb 2024 03:48:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUo0qHvCZ9OtMAIWgbHvTSRPHG/XfC22CJDRaGbafxNCKCLhhTNC7VaWxLS19l1DQjKQmXoFgR9BvtCehN8Vi8OnTc+sTVGAseNHUUFEnYz/brSlV7Ic16bADpxdRShfcQsMSgj/DmRSUhROXdD3YXgxM0RjvbZ5QA73A4UmtayR2CstYjuNvZIHMc1oFQ9Ld9oQr9nRRMcCp8blNLT0rlbK3B5M+qS/+SQOt/ff83+t3Miz8RCSN9mV3Vm+0dKunCx7UP7Ux0dD1wEV2rzMBaDhFSwbnz1Ei8+2fWmRlwGwDl6EL7iq4+Nd3eODT3ar4xjnU548q95RH62lvxK5cu5v2kIce3z7h0x+uTgdcryyGwsO6o4cYXymSZ+6IjSdsZ99FS5rx28LeFcwYXYWcXBUk7ha2/Z9cVAE7eHO7IeG9y5BxfDuI65H9C4DuSwFnr1Gx0STRxUktoPzwVzLwX7tOcmAGmP
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b0033b4acb999dsm6536583wrx.98.2024.02.12.03.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:48:36 -0800 (PST)
Message-ID: <e1e2f1b5-efc6-4f87-9549-f395a1005c22@linaro.org>
Date: Mon, 12 Feb 2024 12:48:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
Content-Language: en-US
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-3-quic_lxu5@quicinc.com>
 <069b82ac-b59c-4665-8a77-6c11a2463faa@linaro.org>
 <690e64d6-8888-4f99-9ee0-c731aeea7762@linaro.org>
 <7edfed88-d84f-41e1-8c10-4af6efe53c4c@quicinc.com>
 <ed9bf914-8b3e-401e-93c0-77eae97e2ab8@linaro.org>
 <73cdc81b-f58f-4eb5-b6ad-3011768781bd@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <73cdc81b-f58f-4eb5-b6ad-3011768781bd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 12:45, Ling Xu wrote:
>>>> https://lore.kernel.org/linux-devicetree/254c1d14-25e3-4f4c-9e79-4ef7cec4d22f@linaro.org/T/#t
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Hi Krzysztof,
>>> Add dma-coherent: true in this file: Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml at line number 89 can pass the DTcheck.
>>
>> I don't understand your comment. Did you read the link above?
>>
>> Anyway, I was asking: are you testing the patches before sending?
>>
>> Best regards,
>> Krzysztof
>>
> Yes, I tested before sending.

Then I am confused why there is a warning. If this was tested and sent,
it means you sent code with a known warning.

Best regards,
Krzysztof


