Return-Path: <linux-kernel+bounces-89230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306D86ECFE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D38284E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63315F46A;
	Fri,  1 Mar 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh1PgTdc"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E25EE91
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336418; cv=none; b=fZI77LeHZrs1b99bcERSHpVAmHLDCDibsEW+WbM39My8RyitqucGX+CcKJaQGgZqnpZoi1CcF+4AZZQ60Q4MXlZhnQCB12+ifb/q9yRr3cuFlv/yULZRpQjmlbs0enWYQBTXo2AYYU6nUptaRmYzH/iV0v59xyCJf7829d9LwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336418; c=relaxed/simple;
	bh=idSvzfAS4ep3/WE+9lUziOUNo3twTGxnZ4JFyu2J8f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejNt453X2yu1pj1MSn8Nh7TM/YPzKb96RlqsIl3+ov1f1wTfgIDCt/kbfBU0v7e/CcOm8ih2mCuFcztCRM/33aijCeDL8bD7DCORLllzOHHEn9kzuHO/gJXhVgKueLtIo1HXoHmNhx4YeGgIpE8v8KnOJfM0qbGA9u1RNzV7Kco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rh1PgTdc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44cf608a39so19805366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709336415; x=1709941215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7ZVdM89+KtkZz6SVTLDCKcLFf8vd3lmFqhwuPTodL0=;
        b=Rh1PgTdcy5urH/YN81ATlMgCAoEJtdIj38TXRCalo1NRouC84TZlJJ4rPNG3hsaDhN
         Nl7VFTMtBy25SeoJgcRd23mtSlJ8KJZ95eEufYqk6G3lZn5WmK0XO/p4PbZquNoJXfU2
         /bbByKmkrIlE7W8AknXWjukW3AQwWml3BR5igiV4w47yqKyRd6mOl3nN+7UzuN1ltLN6
         fdZ3F/OZk2eeJbxzFziNpXRmIrAB74s+nZklyqj9gNMATUHOn48HDkyO6Me/77VSkDuN
         RlvmhyYjzAco6cu5GeYQ6DLjRlXF5ca6UaAx6lgk9cigHQnDuj5mG6OonWO6/S21g+7g
         aA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336415; x=1709941215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7ZVdM89+KtkZz6SVTLDCKcLFf8vd3lmFqhwuPTodL0=;
        b=bosnzZFlRKZM8EeJxK+aTga5D9CXX+mMx33byrfOcdvn3zK1bKx1+BVG3HOkyyO1UE
         Wx5FYU3wWU/8z+K85rya12ItJOxMyxrT6fGJlCYpT26Yp6SlPbIwopYFpcy+X6q+lFjQ
         +DfSJx4unauDfBKqAHVb3szoAQ0pl0n+k53QigS+n9m4sRpVuc3g7ivyn5sjOQ1VTnsU
         y5KRmCxnEXp4+m2fNOg7IbusuF605sK4KCF2oF63WcdRW2t6t77ZNLH57yKIGZ8JpRnH
         Nvd4S70SoCvWUBXnqI9mO2I9/kjkn489Cg9SCvrgjObYsMWcXNcr1rM0jJE77naiABql
         VqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXzF+iY6gCdhUMCMWIABjUA4CgCGV3/m8iNmDMQn6bLZesHSONUheAkjUXazHrejK5tDEmUCwC8BvkKt0jxd2GptpFJThCQk7V8fFux
X-Gm-Message-State: AOJu0YyQWr6HFH15i9KWRaL/oq8xEWuG+mrCk0ooYwmb8N5kFx8E2xfb
	MZL6KIz0Q2sHey2PpzDAl98cEaZ5mjIrRQ8LSwt8AssINZFWxGmNvowNoZNysyI=
X-Google-Smtp-Source: AGHT+IFgo3kAwgbN2l4OD+lpkiPFejUrDFmsu36KW1graCljGsBHhE8Q52BUSYKY20I4WVUJicZAig==
X-Received: by 2002:a17:906:5f9a:b0:a44:5a3d:7877 with SMTP id a26-20020a1709065f9a00b00a445a3d7877mr2253044eju.56.1709336415205;
        Fri, 01 Mar 2024 15:40:15 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709066d4d00b00a44256373afsm2122841ejt.200.2024.03.01.15.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 15:40:14 -0800 (PST)
Message-ID: <b5635fd2-9a06-49f0-9d4f-1088f52d5af5@linaro.org>
Date: Sat, 2 Mar 2024 00:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM7150 driver support
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222174250.80493-1-danila@jiaxyga.com>
 <20240222174250.80493-3-danila@jiaxyga.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240222174250.80493-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.02.2024 18:42, Danila Tikhonov wrote:
> Add a driver that handles the different NoCs found on SM7150, based on the
> downstream dtb.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

