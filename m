Return-Path: <linux-kernel+bounces-48753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC98460CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF201F291B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D968527E;
	Thu,  1 Feb 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy0iRIM5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944112FB11
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815093; cv=none; b=QjXtpaMDvnWtGTzu7Ob2E3IE4Az8IPuk8ynqJcX+2Mi9329cnW4Kf1RB1Hp3jq9L/+o07gQ1J9Hp0s66L9QN9VoH5Z4n9Vn4kDUaqFgL3lyDVG6lyHKzCGzQoVyhg+rnHpta1fntc6kfVtnrCkv2WnqGzgxhE21xLnc+3zV82C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815093; c=relaxed/simple;
	bh=R5J7e6yDm5DpogUt4Oh98/ofAd/CufNXIEJN3Y3bkH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjASOEuhcPlaPIm2+YoH/LkJT+QuETpVaP/3wKgGbWqTYbApsEuEBmF7JcdYGJ4uFvUroDgq4EziiPDkvjhnERcIu8BNcUvvl1mDO8m5tw048jo6xFlxVTUR0rezcJysJY0NkC9SVCxeFsht/9A1mwkkZF/dvnIZc6fvIOFSUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jy0iRIM5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so1728686a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815090; x=1707419890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOUWdZfMX4nTY0ghBz+cidESqyTeNODDjrA7R3aKU3U=;
        b=Jy0iRIM5eM6Tvg2d8ZYdqbFcR8VsOeJzrk4xho6UEa+kcpu9wP56Kd2lyRFdoEASUr
         qeO8FxoVlot9eGbkeT/OsGP1h+TyCdkVA4ovEMPmCMrohY+fZ/3813BVwPhv40KbkUPd
         y90PtXoY6zTwIVVfHZZzM4GSRthC4IoJ8xCpZoxq2zVA+idGFqfJfLysS9GAsywa513X
         QZ+xfiVFnOWzGaSRHHcMZJuCrI4TsM7s3j8BB6ZTSBAqqz2Vx8TlUvaugoEwSiOyZF3O
         O035giPfNOAKMMHWLXpgg7aICTHmoPvtCAnutZpke853nTJv/V8GFE0dYuVa36hJq5eS
         irWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815090; x=1707419890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOUWdZfMX4nTY0ghBz+cidESqyTeNODDjrA7R3aKU3U=;
        b=ACRYh69YeN9CP2mLQ9lqeUHLJLfbmcm7yfffSgorJpkt0Sg+qSS/PSlGV7mrdfy/MP
         IvgKvDkXD1Lq4XYNG0XAlh9vkmFJ8Vq1PhyTvZPjBs+tW+mPsBcGx6MtduJCyjVNHv/t
         g3+YeOjSiCT0IuAzAD3gCkqi4qjrPx5w4SBmEKEmFBFvpzOUkvNEGce5tjbbGedopGAk
         ugtXz06d2+MWa9nLdIp62ogTYIpnR9pvIgyFjcip0mBTQecjMr9Kl3M9DQ/S62/Z1BUu
         9/dH9xsppcOkbyt/WVAFiAi62m9GvLBHnU7b7T91peB2MQhfJE4Z9okLKBRBzUBvaWxa
         BZdQ==
X-Gm-Message-State: AOJu0YyC0nm4pwDP5rOB2eYoHrptGFn4vTjfzhEWoq7bcbb9LOTl22kN
	gRihdETjiSnHzdoU5wyP4MHvKqFKgW3YicCv+JZh/+Nb8tdB/e1ZeliB4RKVPTQ=
X-Google-Smtp-Source: AGHT+IEdJxjGxrGzqvvt0C8i6hMcGylTJUdvufXcyZVqcHTWcT90Ums4gbfmlnKjb8sUV1Dj91Qyng==
X-Received: by 2002:a17:907:7f12:b0:a36:8b31:5c99 with SMTP id qf18-20020a1709077f1200b00a368b315c99mr44891ejc.49.1706815090057;
        Thu, 01 Feb 2024 11:18:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/u+xVKfSFq7h2SiLP7CC5EZuvg29FcXujRmt/vijgC/FXTn6S55m82uoFfWxhWjFCXpT5kQuHGsZmeLTaOGv3LlClrRGmy7VNbXSQ68BhOf5A4rFGNCI/n+6KafAZpilmfL/VrnF4GG2f1Q18xL1wPz2NcSJWK6wY4UF2thjiyTkpUrHVT5kX6cqqu8P9M6PxNqv4w1gnpb+TLyFxziuofG/vqyMLuxebSmto6fqRxxh/9ys9brBW4BclqCogK6OXtcN/D3KesKLF4TM81SHX/BFVpglfeLYSI7aXgZVy3aOeK+dwIHhXowVhc11ppcpbpkiOXxFXrlxS+ll1QUyQwGjUPsC8NqOZz0hIBSop
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a36f8fdeb98sm23088ejc.59.2024.02.01.11.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:18:09 -0800 (PST)
Message-ID: <2c2eb7e0-bf1f-473f-a356-b70df6d11ed6@linaro.org>
Date: Thu, 1 Feb 2024 20:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] arm64: dts: qcom: x1e80100: Add TCSR node
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
 <20240126-x1e80100-dts-missing-nodes-v5-5-3bb716fb2af9@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-5-3bb716fb2af9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.01.2024 11:00, Abel Vesa wrote:
> Add the TCSR clock controller and register space node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

