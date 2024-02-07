Return-Path: <linux-kernel+bounces-56721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3684CE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E047D1C233F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C77F7FF;
	Wed,  7 Feb 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmS6bQ0o"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D887F7FD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319818; cv=none; b=DCd39xJzCUm1o4wN/sz3XYIJ73ngqF46VpaA+WOpUwB/5KzFa5xuqx0tWhp/valr0pz7j/lCvej7gqwJVAvtCQeaVFmIHL4VxPYlaUkwtY8sUQ8ooeo+AuedNqb7AwxnyiEZFT25TWyDkhwcxGFOpLws8RllO7+M1yOb8uJ2aJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319818; c=relaxed/simple;
	bh=9Gs36drIPM9UUKn8G6E3uMLP6Kraj6q95m+7RitPm9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tofI/RramrNIg7sjW6RXAHQyrfAcv5I5Zikcb4R2Ngm0crmqPj92IUvdeEITeefBPSQkltuBK5Q2HvIAj5/zMB8iWxLlrctvAh+C6qN+IEbzO1z0PsPW2ySS8yjMAACGDuWoJaiTNTifhq//gqv2vHK+40INjO9nXRWVVUhZRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmS6bQ0o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ff28388a6so6811995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707319815; x=1707924615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW6ZBt89YTx/wzUfUDXHhU8+peF89W8hdZzNN91NiGg=;
        b=XmS6bQ0o93rZdXwuVSCn2HpYpP6IQz0iRaCg7nnQ2wukt4Ru3I9sIh3MECNWDgGWtA
         2bZ+pcFWU1DBbPBd7bqHyqEkoA97HE8QVyVUu3vcGeixaMgFgGb0aLtETk3L5tg+8f8K
         IOuOdrl4dW2CulkL97sC06Tm3gVrcR+M7Fpra/oo08pw9o+w22FmwB3SKzFbdWmZhWy+
         A1CXSQY8yCJGECewdA3tgIcZX6HVwcHXk4GE3q4qKY5BphEiIXXUGnkNkSz6cfhEQa+J
         2UjQMWxuRPmnGBsaIHqCYD8mX2RQHIZOgtwklh5koNonSadCN9PhSeG52gxe2os5tzoe
         9u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319815; x=1707924615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW6ZBt89YTx/wzUfUDXHhU8+peF89W8hdZzNN91NiGg=;
        b=cy0nNSBkptQrblIHxqDQWnxZY3wLxc0oQZqUI2fdxLKlDyDaQ1ezSY/fZSIvOIh6/v
         6a3pVdcSeIckO1IABWb2wbNjyn6L2YdweS8PaAgtrv94OF/QC8IbFVkh+nySYTz9Bv15
         G9yd1VhuKKrK5mwpHBb4mX7Wbvrv0Z8IcM8YhAxY8ota/sH+f7H5oH3kVxjgAvzHEqXD
         qobHiXDQAp2HIkkeSu8iiP+8mRoFgQmG9hbAJEhjyZV3V++/3HDi61yYyDJLtvnxYLvK
         gWS7I1bukXEEe6zycpPEqluJ59vtmpiYpYm1bbYdoI2kYcIqu3xzINfgS+a/9tBQuDwz
         cQkA==
X-Gm-Message-State: AOJu0YzckE6I4EBh/y8F8RVOFLQOPMXrTPDSg5vZ5wWetf5niw7fNWHS
	+ag/QY35NNMNtCODWZ0eehk7OCflm3YDB1v4SXiy2/Mfx6nnUODWH6FNvznaJGg=
X-Google-Smtp-Source: AGHT+IHUZ+ze8SoTaGJENjxRM+je5SRBAEpXnDJN4W2y0rjY4fZafM0YcBW+k8lTLS4B9ov6XtIB3A==
X-Received: by 2002:a05:600c:4fce:b0:40f:d3b2:8ed5 with SMTP id o14-20020a05600c4fce00b0040fd3b28ed5mr5002850wmq.3.1707319814710;
        Wed, 07 Feb 2024 07:30:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9EPxqKW/o4Gdmn7ILkZETK+5uTO6fAEq0Fh9t+EBxgaUNNHOkTE3qvanRnA9+P87x5BO3LGlnQ/RDjz89Kn1s8OQcU9MQetKcqUs0DsjZg60CBxGIEQpiqKyojuTVp+gablRsZYS4e8YSbbVQ2BqDj/mwYfC8BsUVN2+RpwO+ZHMpyCBL/CqsK4Gvzt+/tevw5B8ZqEJEEyhwosceMN/Wah8S1Qryz39LBpxx/Y9r2SQwqMSu2ShQDngA9gZougvLf8AKBB5HEtsYEHQ3nTMuWV0HIwXhZ/OGk1dzFsl4uiCVgTr+yY0OITD8OmZyPpys/pVj/MfzuqKiunL429EmGfxj+ETUOZI3l8Bu+wK63ZDgY9JjIK3PipaO7YgFJjUsEvQYdkPui3KVb+YyUMGDWcyF2QfqqGrzenEG0GegoU54rkkKi/hAjH12PbSM4NMM1sIVn78C+QMvFnToKbpo5QwPooj6/gNJO+ezYKd8IWOXljBpIikQ86VUZA0qOjaNXHZI0GuYfwIuPbzveGVoi+kCh9kjJpA0buLZXrshikZdguRt/Enu04xPBEnmo+4L/ZP3dQhSYsrM3Fk5HU2B6QrtWRhe03b8y7Q0Q/jWVdICg21LLig5N8qvYf9GXKF4ZY/G9Q7uVpX5V8j3nAqybICAsmm3pLYzeNjyvEyruqWW8+/bcGX2um2sYhWIyWQCfE5j7Oc5
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b0041007731a52sm2464323wmq.11.2024.02.07.07.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:30:14 -0800 (PST)
Message-ID: <23963f63-7410-46be-8bac-c6862fedfbef@linaro.org>
Date: Wed, 7 Feb 2024 16:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: google,gs101-clock: add PERIC1
 clock management unit
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20240201161258.1013664-1-andre.draszik@linaro.org>
 <20240201161258.1013664-3-andre.draszik@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201161258.1013664-3-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 17:11, André Draszik wrote:
> Add dt-schema documentation and clock IDs for the Connectivity
> Peripheral 1 (PERIC1) clock management unit.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

I was waiting a bit to be sure these are the last bindings you send for
this cycle. I assume that's the case, so I will go ahead with this one.

Best regards,
Krzysztof


