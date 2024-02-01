Return-Path: <linux-kernel+bounces-48519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98574845D33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F6D296AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683F5E212;
	Thu,  1 Feb 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clM4iyz6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2F5A4E7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804718; cv=none; b=bW7LGS/BiwIYJYhwQpE55x/OEDZvdgOPgdsGJ8VpNq3r97NdlPD/0uhSOgLU28197jKHHoA+XfXx2uQ15LgUYKIkAhKgBvM9ZHL/S1/yQ0cgdilIRmR+YBbFGd3vh/wIxYJYZ6FxS1HLP+hLIXJyVWWL0li4andxPXI2P88MGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804718; c=relaxed/simple;
	bh=U+E/xQ4vC61LZVwp9IMPUz+1ekbJE2KKJxmpXRoWhfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBpr6fQbp+Lpumg+xPiPbZ6R+Gh9WvSRDx3lNRgKl7fZFO53c1PR8X+jnNadJwXGTHrYrjQJXQcMcDALColDi2i5s8IPe7Qs9V9Wbc7WjzBOBtGY8/el1zJdeWrtBidsLUatzDP/8d54zQvrzdbCObrd6lutSP23tHELo3U9XV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=clM4iyz6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso150469566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706804714; x=1707409514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zSfRUTFrq7vm4ZOzcXmaAJYP5yS5MiLP8FPnlEZbwI=;
        b=clM4iyz6M2MDzoaXMRCW71ixUGXskNm1L8iRgKLU2PG40UAmff9RiQpVVs4jTlimSx
         brnGA1/4iIA02zg8ArAgFWlf+IfXSfGG8zBL0S+B+fYEUEi6n4f1crDgT0qjaidS8dhI
         Y8t1aAFXIZ+LEvJ1vkIdL9BfvWcm7aCJU0kpkkt81A4oEk7xfLWAuKUoPZffdPZhg7Gf
         auynz7Lv7imvKEdEuK01uhZ16AGGdfCX2VmEVsu37kGEkwisOsOw2YRDAcn80UsPi8sN
         L/bSM5Z33Ot0yIh3NC5VpYo6mN89L70wtTEP9D1NgM6p+z5RCjIzFpGb/wpIW3tmwKic
         k/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804714; x=1707409514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zSfRUTFrq7vm4ZOzcXmaAJYP5yS5MiLP8FPnlEZbwI=;
        b=qBbhHOXA8fCiixqBs6byjUrNbMyI5J8e80h9EXjSpC+iYaqeuSWxP9mAEz+nqp1aar
         W123qQ4CRM1Mtcw6pI+G34/3qVCMFuZ3nknPa8+7fMBAaotv2kP7/QXI6wi1r0ATb4S7
         IccvO1XJzYW6RUeo7rWBpXeJET4g4qLUb6rgdk2VruWLTagfsBofArnEVR44qpcYsC0b
         6qlrHnd8zFWCPFBeXdePKYrA4Bt0MUA73zgFt1wJ50OWRQpgo0rU0jz2jHqADNyd3FdS
         p1LmZ2wzrk7z2zARZaD0ur6rEn8N+lSN6U8lE6V9mucrbyEPw/1xAhz/SXMFzqeS4p7x
         hUbg==
X-Gm-Message-State: AOJu0Yza+LPrsLeYrEPPoJaHmAnVcMZtH2ecGrLtd5jt53N4bMWKDV9R
	2uLpvLVgU2LL+ntPxeKif+agQHWsHQJGB53qktLUZNZ646UXHH5fK6zgpk4B39A=
X-Google-Smtp-Source: AGHT+IHew+Vx5htu1yyTaHiiBpXUkVcT/pWsI/Dw7dqmx2MHvRWV3p8XzntCJ9X+ndSCUsO7sZ8VWg==
X-Received: by 2002:a17:906:bcf7:b0:a2f:46c7:4658 with SMTP id op23-20020a170906bcf700b00a2f46c74658mr3634605ejb.28.1706804714521;
        Thu, 01 Feb 2024 08:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLe7T8/4DSvjEnhO65Rj6fIIZN/uZP0uvKL8EisM9wWy94vhRbxx37SxVfb06mavVzTWZ0mknhgriomTZNIRflQ+2PUSIxi+U+yXSu+JKZtMsOyqxNkH8v+AelOOw2Vbln6tTHeQyv9dNr3IXrzHthAwDOo5ot0NY2yka1EVn6wF6JmZygY3ySkzskpl5QaYOPkS5nXXjt2R4NQ/1pja0=
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a3543718f5bsm6191330ejc.221.2024.02.01.08.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 08:25:13 -0800 (PST)
Message-ID: <733a340c-c1b0-419b-b641-0f30faca7191@linaro.org>
Date: Thu, 1 Feb 2024 17:25:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in
 qcom_mpm_init()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.02.2024 13:17, Dan Carpenter wrote:
> The devm_ioremap() function doesn't return error pointers, it returns
> NULL on error.  Update the check accordingly.
> 
> Fixes: 221b110d87c2 ("irqchip/qcom-mpm: Support passing a slice of SRAM as reg space")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

