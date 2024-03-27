Return-Path: <linux-kernel+bounces-120155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C578F88D35E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A21F1F3A3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7CF9F7;
	Wed, 27 Mar 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boooKJOi"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09926E541
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499085; cv=none; b=nL9rZIhJSOtjbUqCGIpcaE+khEtlLObamAStwjphwOonRso+Swt2PgEBIu3+96OuIWk+5JojFa2NMbrko7aC5Fo+L1tsXieVnpdELsoFgKYDRt10V2lzgrdZWtSGoe3qisalDHslFpqYcn8vQ+ryuH2PdnIXpdXF1o5fPr1GBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499085; c=relaxed/simple;
	bh=AKB0SgDyiA+k8yW1npLEEnbRai1MmPLE+B5tTxhZUIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYBD55GjFcEjttCy2AjXpfseqwf7I7ynHQAdeE6KHl7HCJHFcqJoTJrLdf+aUxSmiUQNnep/Drv0Ob1tsobdvZtZaqkRi9Coc3KA0XzgCcxrnzOTgbUqXjAVRN8zdoCwc/UOOH7pLk/Z/lRZayazACM6nw7ZFvbdwBM7BsGqUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=boooKJOi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46d0a8399aso56131566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711499080; x=1712103880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G/HCmN9lPCdp2MoNj/SPyQLmSaUATz4v1T2S+06LwPM=;
        b=boooKJOiHwou0kJRltsgriTKLAibuEl5VwtmLK8pdZBlBEwNMIHS8zG/g5AU2RjD46
         tfHl2nqumCUdaMnuoX35++T08lCjNBRb1r1XC8hvINhxv1RojCF+CDb5FcrCK9Iu2JGp
         HsbqEb1ZFbQFX0lWxDfIgKgwU7HvvcrODn8cQk7Sk/61xZ3QxoHGvUeHIuFORxVpePAl
         bRaQkdTEC2XoriMO2sqVohaiVnhU+TQFilRQqjHhVU7oC1uW00P4pFIpNQXh2Q6OOG8h
         1oL84vf+Z8vyOm+ccqYF+lgzaCNjEUR2OZcZZ5tvdQWvzMIgsIxt1x9mvElVic2vK8zK
         dlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711499080; x=1712103880;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/HCmN9lPCdp2MoNj/SPyQLmSaUATz4v1T2S+06LwPM=;
        b=s7BYdghxs+BNMuWc7D2KgCa/GB3ZfyJh0kZ/VUC5A7NcRrpJ8yKrPRPURyKa+FCg64
         3KTKXwP+7+YPXptcBIZJA2hsDIzie9b0mQrUkORZuuIN7uA+kZi5iqHXVWKrKZlE6QDz
         SR5duSGl+qAJZpRmzJDht58MTnWcuTeDA8U/gqbY96zvQG44nmgBzH7BdE/0x7rKmC3w
         b+8IiSw90SMQdYoYddZwGA1lS3GvSj/9vklVHhJ7U4tZN93/k70wCaawsSLQwpSyJWc+
         Htvsxmu2ftXLDDs3NVfnGL+Of7xWhpjc5a4ku1XZ4lhBFn0n2EcuyzmEOMXiLF1mjtYI
         eo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWHnZSBVVU5iKa//elClX2EPl5PrsetPaszWy+4wfkXS7Uwd+vrhgYspFSAZwokucCEPM0yaCYxW55bO0S1uJnZD80AtQT3FZ3dFB7V
X-Gm-Message-State: AOJu0Yza/8yuGgzkOtTB/PcZY6MLJ4cpKbE2NqGg/6Cgg2rOIG5kkpyB
	smCgEOwJF6U2scUR8tslkczyvqud6PkCC48/FzVVFvLvw5qpapGoxUkr5ra7LlQ=
X-Google-Smtp-Source: AGHT+IEP4P3WPB+IB5nDNolthKuBoUUTjLE7geGyhhkXnccZnqDTNIjrCFi5GcTg17FqGSzz69pZGg==
X-Received: by 2002:a17:906:3e0c:b0:a44:e5ed:3d5d with SMTP id k12-20020a1709063e0c00b00a44e5ed3d5dmr2398843eji.9.1711499080417;
        Tue, 26 Mar 2024 17:24:40 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709060a4f00b00a455519bcb3sm4781222ejf.55.2024.03.26.17.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 17:24:39 -0700 (PDT)
Message-ID: <3e15fd38-13d1-4b99-aaf0-f422b2dbab59@linaro.org>
Date: Wed, 27 Mar 2024 01:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sm8650: add GPU nodes
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org>
 <20240318-topic-sm8650-gpu-v4-1-206eb0d31694@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240318-topic-sm8650-gpu-v4-1-206eb0d31694@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.03.2024 11:09 AM, Neil Armstrong wrote:
> Add GPU nodes for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

