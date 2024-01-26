Return-Path: <linux-kernel+bounces-40127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40083DAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A965E284540
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23B1B803;
	Fri, 26 Jan 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVkgNOv4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDE1BDDD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275310; cv=none; b=giwlBztFjyYiLv8lImPdU6a33N63LIs68lS4+4+LskJNjHiabgPJ3pLrDCUDTJExouJ6L4mRVYSz8lMH15qA3oQHZgFfxIm75xmorEgLjX1aAcDZWnlWFXSRdruYX2gx17OKS5lDu0L1QAlCwLaELX4CQEw0jJMBuSdDBbZdRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275310; c=relaxed/simple;
	bh=1R9J06P8/ttwwRvg8nQKlDyvCSA8pRs99L0R7r43U3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WyMORTZJBl3zN0nz2GQRH86RIn+gCO2Cd93mwjj+hNKdbL5syFQyEVbxikSeV6UufF7cX6f707JY/y7A6IXdgyKPq3N9i+iubkVR/Hw48NHcLYIf5VMusYkB+zu8h3vPIUq4Z8aYbcAQ7KUYAl4XYOFWq3uROWAWEuZqNw8x6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVkgNOv4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51025cafb51so593468e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706275306; x=1706880106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LO4L/uqo4fUbqmSqa9g43rknnKsS+IuadX7TcgniBs=;
        b=tVkgNOv4Fxvo6ah4sEw+tVds0xgdZZJpijzbLF3AKd4SkOC6iSVEyw9upki654ODbZ
         hMX2SSzBMr+EEkcYdesK012Zohz8YnG/Wo/Ng9NlxDSlut9eUKMdBm2YSRfmusy3aFD4
         N84R7dT29dw8gTeRf3ccm3d+mVYktSsu8azR5I+11jEgDxNQpVcZipLjfCToEo1M7mcU
         aAWIdIFvvq2V1a21W0YOWDaK2aub0cUjBDFduEVJmb2B6EIdMqCz+FgOCXwaATpztWHk
         nPjDn1QwHphguTk4FKkOxLBgJYd5FkfPLKjpMn7nL+gKWKIJp99bGX8c79VbnQBnGDhK
         CozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706275306; x=1706880106;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LO4L/uqo4fUbqmSqa9g43rknnKsS+IuadX7TcgniBs=;
        b=jIZPR6upjsZQbHptvKj3LpMqnsY855p2kvjeMFDSxc8RwZtf9Ky3+VPmPD21W3vyKJ
         VncCfuEAHhmsU7CyQirK5sXzEgEkw9v2nTsnMccFlSDLU5n6F/tn09iIUH/03J9afA3J
         fzLHclKWGD7soxondVWyY30H1ozu4BFY0JVFqszmiQ46EIkKtjMskyoGIijWWJjry9xY
         WhVeCVCKkyPBzO5x+yhpRJ/Ppr4N8c3b0b6GETKKPetPxBr+AfP29/0TRXSJRQZpVjhq
         W1JCFZGYvcR30KAzvw2VNmUiFjDmVzHzCiMcRO4yVa7d+XOY8ES5K6x1DL6e8WWYs1WQ
         65hw==
X-Gm-Message-State: AOJu0YzBqkis/oN9YlkS51NKJJk2C8nEiLaZ2rGT452CyGS/obco8tZt
	9/VhrfSTPZ5fqmXNqjrvd9XYivf3SM22taRrn5Iglt/w1HzBs2t3VFCjtnaVWiw=
X-Google-Smtp-Source: AGHT+IFectoDvTKDWCPxyJpIrX26HU7+8ZDwO0GAD5uqodN7Yfl756aMvZYORY1aJ3oXoJrNbb17Wg==
X-Received: by 2002:a2e:9448:0:b0:2cf:34b4:63e0 with SMTP id o8-20020a2e9448000000b002cf34b463e0mr736158ljh.80.1706275306490;
        Fri, 26 Jan 2024 05:21:46 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l30-20020a50d6de000000b0055c875c2095sm612168edj.96.2024.01.26.05.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 05:21:46 -0800 (PST)
Message-ID: <4d377c8e-8cef-4da3-9b25-fc91a7dc3d49@linaro.org>
Date: Fri, 26 Jan 2024 13:21:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/01/2024 15:31, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changelog in individual patches.
> 
> v1:
> https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/
> 

Unfortunately this is breaking mic on X13s.

--srini

> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (2):
>    ASoC: codecs: tx-macro: split widgets per different LPASS versions
>    ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
> 
>   sound/soc/codecs/lpass-macro-common.h |   7 +
>   sound/soc/codecs/lpass-tx-macro.c     | 666 +++++++++++++++++++-------
>   2 files changed, 501 insertions(+), 172 deletions(-)
> 

