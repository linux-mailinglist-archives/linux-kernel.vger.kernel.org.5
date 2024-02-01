Return-Path: <linux-kernel+bounces-47853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C28453B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239C01C258C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C415B96B;
	Thu,  1 Feb 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8leshd9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EB15CD55
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779279; cv=none; b=WNRhYt7F1wB9PQCHrDbj+uErEEPJQ3K0R3Pv+GRRe5UaDZ9JsvVvcICj6vv9E6sxYe6pllSB46M5Lxj2KUycIHNVqIU7+A4QHD236xkTTknRt8vps2zrUq5XGjN1U/V72jEY1ie5fLIBw7lXIBI44aZ9HuMeY6iXBCK4JLGOjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779279; c=relaxed/simple;
	bh=r5FGGBYzjeKwg1X2IbGxxswfunQAfEEghRXcuuzaY4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9ELXrxTuosn3/a5YQHeptHuEvhjPaxBrjQrycpWzeWEtq7hdXe+DovSXbVEsTQVWPspq6eDUEPTVEha8GwYI1Uj4vX4gbuBYgrXWc4BHJdERaNhWGlMPAVPm9uIXwyoTS5FobLLR0FXzTJyKgk4oomE3hrxtcTiaZ7kP+GngIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C8leshd9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so903656a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706779276; x=1707384076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbxV61vjL5lRZm5vlE8oVNRLNTpll2lgNmnhwSDa2ws=;
        b=C8leshd9xw44pvbBf0omQqp2hJG6qatgGkgzR8KTsXoUo6wXFxIUZMdRN82wM5a+gR
         ZfUSqLn14AAgnHar6X4qCvPurNtOrMtqssrN2Xy9UXO6x+5CPPSsRsexFlkQEW3q3zkb
         wbhLFdJEr4WwX7PsrR3SHEj0E4c+rkA2eGrEZvswrJyxhhmjIEXtQc2pZYRR5KLvY7Eq
         lJNivVfTY/eb3nIl5QbkJlAdEoCVnwi7oTvGMVTlB2yprxe4UEPUYWooX1wPm74NsPEH
         LHQ/PQtOa/chLz9ZX4Qft0LIkq72TMIKtf1pByF41bC8SyZCkDbSbw5Uu9ANGznmB7Ps
         EwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779276; x=1707384076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbxV61vjL5lRZm5vlE8oVNRLNTpll2lgNmnhwSDa2ws=;
        b=HPMxjCxY8//8P5EgXMb6MkdAvWytuWmCrj7bjqb0cjSXgZIEP31WY95vUrWTV/h/hS
         LjaI4kfoh3/OEY25bHoga+9BWIkFe/5OzJJpn0WhZ1Bc8Vh3xbXOoiSSz8Dqb6bd71gM
         OxIxQNiStuV9BV6xnZCZSa4AECMa43J96cpkaaXeyM4Un4EK577sRUGZiScLpg9hW4aK
         /FDGUrlkoEMRx9O8iyOZVKHOKFVYOOXg2DPIyfgw6xwC22F3VFllmIKKKB/emnTLJHvM
         Bm+OH/nKsnax/+IabQ09cHhMbZ7nzMjBBPfqoevikfPfH12Xd9mXG7v58Wkw8kxR2V0h
         a/zg==
X-Gm-Message-State: AOJu0YzyY4lUUIAjsVvZttLAmlD+nINCIyRC96cISX4fK2lLAigk7ihE
	XFTY010wbCRKuogzlnhiDwZUAa+EPPyilUoCCq79gf9aFH4hOXNPttJKtSfzMVM=
X-Google-Smtp-Source: AGHT+IH/r+L5hjqT5x2F0Oirvuvs5Jht0RNej5bDiK2X+zTIdkBR5z/j9mKx2TiPjm14pIrKYtYPWQ==
X-Received: by 2002:aa7:c1c9:0:b0:55e:f6c5:4e44 with SMTP id d9-20020aa7c1c9000000b0055ef6c54e44mr2370702edp.40.1706779276257;
        Thu, 01 Feb 2024 01:21:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEMx84BsRz7klsOitXHC0L/AjjesxEUPAGwnt1eIsfqD90i8jgWsQG3MTkywaDedsUWhiMrdh5ydTIJKp4vkwPLjd3jbjnmUlsOWliCFrpSKhjO6WLnRkJbyNFGN7RxYF2/Y1bH2o89mBocvUmnEVk4AsWt0gWQDoLLY/q9tHK8sq7BNoD4IysOjP40Z4wAgPDx29Tm3mzZrnu8FSF1P3FEOc56Us44k0T4ITEJizQULsRjHzI6duNZITErO21N5jtOqiXNjvLQOxG2Oq/h8xi4RylnwZZcUYVq9RRiLaJgqM=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ch25-20020a0564021bd900b0055ef4a779d9sm4276981edb.34.2024.02.01.01.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:21:15 -0800 (PST)
Message-ID: <2ac5cb07-233a-4fd8-8248-d1dac39150d3@linaro.org>
Date: Thu, 1 Feb 2024 10:21:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and
 port mapping
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201-topic-sm8550-hdk8550-audio-fix-v1-1-aa526c9c91d5@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201-topic-sm8550-hdk8550-audio-fix-v1-1-aa526c9c91d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 10:16, Neil Armstrong wrote:
> Starting from SM8550, the TX ADC input soundwire port is offset by 1,
> and uses the new SWR_INPUTx input ports, so replace the legacy
> SWR_ADCx routes for SWR_INPUT0 & SWR_INPUT1 following the correct
> TX Soundwire port mapping.
> 
> Add some comments on the routing for clarity.
> 
> Fixes: b5e25ded2721 ("arm64: dts: qcom: sm8550: add support for the SM8550-HDK board")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


