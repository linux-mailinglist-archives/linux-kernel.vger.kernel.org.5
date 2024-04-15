Return-Path: <linux-kernel+bounces-145769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB58A5A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CC9281777
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F0156257;
	Mon, 15 Apr 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujYGYJYQ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93144154BFB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209512; cv=none; b=O5JQSyoNcpou80UTlIatPSzebwlHDPx/RjEkO1enzUm9+oyIHPJKesceFG218uhV7HwcUsSP+UxhZEDEy+uhs+FrWvwWQHgWNnMxWW87PL+vNKU85KQfPDQPxJC8t2uAlgDO1n+PfutJYOIezlChCNC8kPKh1yvgLryLtC6QAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209512; c=relaxed/simple;
	bh=yCsFlnUbGZWDCDqayNjxY166IYIvnKOr6fHx++JOY88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg1TOwwhmh0uQc3Fb7Xh+rqP5yN2kY1KQVmp2NV0fpnBfFDjSyptzQxXCf5CLwFo4p5gH6fR7EyxfBfXA9PnWSIM+J//mi6OwPax0uASrY4n3K0RAi1VZIdugn3afPg5xp7FdldUQVTUzMA1hLprWz+6OHYt6L9zc0Eatx6qn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ujYGYJYQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso45997831fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713209509; x=1713814309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx47+NS9TsvFbo8I/9W/8DEAWOonZGJHwk+Es5dW8Wg=;
        b=ujYGYJYQT+vXultdAhZU2cljUudDUoMTd/90kjQn0HAt/UFplbc7vCwcPMiUSt5S+n
         uJFXso1G7XxpEzzI/ZAujzJda4YcVeQd7P54Qw4Ux3+yuVog1HVJLfQdQOEyhLF8IpFH
         a8mGp3Xv1Fsk4Sdtx060h886smJFlIyUu21iK2dGgO5ieP77AT/EgCQbK5+YGEs0eISd
         3oBa4ahj0rl6rfspmVgLwVdxsWtV4vWHkKDWC56A1soiHRYSsMG3lXmWYimB90VH0ns+
         jMYRmI88m06/J3uW+XK38E0OQqq2jwp2s+oATfHXr17tpwoyIG1wKK2/D2fTtVHUSoCk
         Op4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209509; x=1713814309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx47+NS9TsvFbo8I/9W/8DEAWOonZGJHwk+Es5dW8Wg=;
        b=fR4ETFBW2NNuoRxgiXrvoMegg8102fdeH72LFgJLbThO5hFY3hs79VdD/TYU8oB1Ze
         +URnaIHKydfw3t5WnTgKAPIHiQTY7FkB9bSIP6rsBA5EMlzS69Jvx6QEqr57QayirGh3
         XzYdE85ZyjnMUaIQLi6zVLFXQPGto2OQ6cBiIfTKtxUUMxsaHgSoqabGLaWuy8302JlF
         YYi5CLJSb0DWr0A4uHCF3otb+VS0HR3nW7fOP8HuRzUoBAQilxVXYRLWFK61VvnI31/m
         pgY7pRqX7Cn0tgEe5JvU0lzAXJ0u1/zJhMZvY9Tm3Mi5aaZdTziBDr0yNklHTUOPthlS
         SDsA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/5Nf48nyKw94qUN89kvv+IbQoxc8FbM0UU5cvu7MlQC+jWMayD0uPsNAUQZVtzM/wx97D5DsPiLw3LcmaAarf4pTv0mi4iT12G2g
X-Gm-Message-State: AOJu0YwJZasH6h066X3vvDc1SyyX37peBZWdgdyWHXlsW54xMD9/UdF7
	FAh8AUMgdUb5eupoZJKQDLJrEd3+ECjpfD7XP8JdRdFO1jKEAcl9aEI1oE8JmLs=
X-Google-Smtp-Source: AGHT+IG8iFhS6jwBZfZytxVfBXzlshGGFS1RA4YXsHKJ+ntB17ZsXiMdIQ/RLrjWUdh4EMYOYWd1HQ==
X-Received: by 2002:a2e:9b1a:0:b0:2d8:b2e:7bf3 with SMTP id u26-20020a2e9b1a000000b002d80b2e7bf3mr6448000lji.0.1713209508653;
        Mon, 15 Apr 2024 12:31:48 -0700 (PDT)
Received: from [172.30.205.18] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9a87000000b002d9e3a525bfsm1291268lji.41.2024.04.15.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:31:48 -0700 (PDT)
Message-ID: <1158f240-ea6b-4ac7-9697-a30d27311c50@linaro.org>
Date: Mon, 15 Apr 2024 21:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: pm8xxx: add support for PM8901
To: Herman van Hazendonk <github.com@herrie.org>, andersson@kernel.org
Cc: benwolsieffer@gmail.com, chris.chapuis@gmail.com,
 Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240415123941.1527938-1-github.com@herrie.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240415123941.1527938-1-github.com@herrie.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 14:39, Herman van Hazendonk wrote:
> Add support for the pm8901 PMIC used by msm8660.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>   drivers/mfd/qcom-pm8xxx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 8b6285f687da..9cca14d54d8d 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -501,6 +501,7 @@ static const struct pm_irq_data pm8821_data = {
>   static const struct of_device_id pm8xxx_id_table[] = {
>   	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
>   	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
> +	{ .compatible = "qcom,pm8901", .data = &pm8xxx_data},
>   	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},

Please refrain from adding this new compatible, instead add a new,
generic one and modify the dt-bindings such that we go like:

compatible = "qcom,pm8901", "qcom,pm8xxx-ssbi-pmic"

(or similar, +CC Krzysztof, please chime in)

Konrad

