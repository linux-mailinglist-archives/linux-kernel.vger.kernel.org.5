Return-Path: <linux-kernel+bounces-89240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22086ED24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE23FB202F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801485F46A;
	Fri,  1 Mar 2024 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCTbI/4t"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A95EE9D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337563; cv=none; b=AINmV4DFtCsiQw2KcKWMxdbJP9PKbAPYXCzSHcWQj3AVMgDnl9SYhaBQ2lWOE7EDCnEcqfu3R7jpZu3YXFMnBr+sHaIv0PgxKnkstD+GqeMxEzp4UOT8A9guHg8/q3Ev6R35PDQBmC7zXeXrMyXVRUZdBjViRdt3TYk+oHEGWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337563; c=relaxed/simple;
	bh=+pVQKpKPrqAv1GP6rBXK5MuOCZSMFVYXcDPhbON6UHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACSVScEDfPPGyAAREv1Pabcff5xhh5EPPH1+2IHmsQ33nLJoesmGOV2/EpLRqlkfmdfC8J8JmGRqyCfzzyVVtw0vlh06jXP7mXwC0pdFkvSU4vw+SNGnIC3YqcdlZr2EBxSRkLctcqO36iKl5UyJTKR5LZe0WSQ6Jhm5dcGp8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCTbI/4t; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so428325266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709337561; x=1709942361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnkM+qWloaT6h+HbNrSbJxQgGHFp+PPEbJG0sz3nNTE=;
        b=yCTbI/4tr+NBlDukNmiytOgt+JrBUbRHdyDlc5DvuUiW09FAlESp+HvX+uL/J96a7O
         Qn02bqca4XrBOoJX+Gw0bABwGBGvaTe9FX773tY2qd2gzP/8NJKKntGHVihHuVKhFvn6
         YzHPtUkrAOlW2LIlmnSvkBL57sizyDgLsm07+MVBIFr2V8VnvfDEKgQsOzsjxlP7hzY7
         dVgXc6o+c6ZoclqCVCxnsRH++8vloo4gKEjXHedaEMLFqsRHHo7BwEpx8xS4p1HvtB4g
         TWOwt7hICZM/e8KiQbA6Yc9yB3MH6FCQLVFSBPcM/pDMT9gJ6e39bZXWdNXxo4jrqIRh
         xPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709337561; x=1709942361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnkM+qWloaT6h+HbNrSbJxQgGHFp+PPEbJG0sz3nNTE=;
        b=XBMMZ7J4tCuVzrXzbtiqYKeZmC8Nw1h9LKEzU+v0Sz2YOMbPpEwks8lpSJ9dL2OFRm
         x9BnWKtGHkbY98FFAx66YHY7biWXGuaR74IrtQRv8sZP3wbUdYe6vTJO2gqEfEBmDCS+
         yyGM2W2TdkEUQHh6v/WB5jwGSuoD8uMFCqDYhcJJR1KJ9Ky5XzjJl7AqP9OL64IOrgTR
         QYubgkTktNpLdW2EUuEfo/JUVCbZKdCIyq4awC9kGk7hc9HhkCKUg4r77ychqKUVVVKf
         jKWXCrAMXx8W5EnimbG8WLsOZ6KX/GH1vMvSonLAZCHfY+RIq1pjG+ipYSSQ++msda46
         nZgw==
X-Forwarded-Encrypted: i=1; AJvYcCXXIalXgKnp9/cLZx0gwTM6Ufk8PUwMgwgR0vorctzjCJyPbhMpQSdOey0oPT43yBnDSR0T0x5wt0OF8YpzQ0Py2hfZCumYESSa2sku
X-Gm-Message-State: AOJu0YyhhNYhirJopPQWyLIg0ahmPfanVi0xhFklbrnFP0tXt5DrIbCd
	po8mjCFy492eIfYqbwZHZraSeDuKnGPpc14fePpAmG/Ma/+jFNR+FkOeb2WHFeQ=
X-Google-Smtp-Source: AGHT+IF2D8iZOfj7+XRauSE4C10V4NeJF+9wAK/LHVS9yazjecLdeBBToJJlc6+QGbf3QkVtRE4VQg==
X-Received: by 2002:a17:906:791:b0:a44:93de:f4bb with SMTP id l17-20020a170906079100b00a4493def4bbmr2344139ejc.28.1709337560753;
        Fri, 01 Mar 2024 15:59:20 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906131700b00a432f3bc3a5sm2157029ejb.76.2024.03.01.15.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 15:59:20 -0800 (PST)
Message-ID: <ab208a2c-ebc3-46f4-94f7-a0bc736e0b89@linaro.org>
Date: Sat, 2 Mar 2024 00:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set rotation
Content-Language: en-US
To: Jianhua Lu <lujianhua000@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227121744.10918-1-lujianhua000@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240227121744.10918-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.2024 13:17, Jianhua Lu wrote:
> Xiaomi Pad 5 Pro has a 2560x1600 portrait screen, set RIGHT_UP rotation
> to make it look like a landscape screen.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

