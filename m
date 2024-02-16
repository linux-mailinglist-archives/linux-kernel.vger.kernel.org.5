Return-Path: <linux-kernel+bounces-67910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824448572E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F521C21313
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C7CA6F;
	Fri, 16 Feb 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+Acuo87"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816E8F55
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044684; cv=none; b=L9XPT6hLc1zMJqUX2Jpvt5rUGhvreApaR8LH7wO/ehppTsZ4XZTS6zbcoOTHswvY4u8Dfj6S7noH9uEO60Q6/kcrjqYu43EFlI6RSdAuAkSZSeigiQOUh7Z4uzHCtT/wE1QGATtKkg+N5sXeXCaODkC8DA4BmHfQ4yRtmMDDQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044684; c=relaxed/simple;
	bh=Sqz32+QwvQqf41D8qqO+pzhhscdrSur6VKi4qrhxa5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID1a3EscUe1ohMM4aWZ71tigxamLe4oZkXpd9Ici/S7XHS1m44nTZmsFkaRJd8sAwg9KZLtrniveJCB9MzR/qfLzt8o8WSmHJ4XS7aREI/HreL6RLT0L/J3sxOtcyUy6xQR+flZur3tpz3g1VvXETLAw7ASYaxXwXK9bl47Yaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+Acuo87; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso218762966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708044681; x=1708649481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrLVLRDEPbd+8cld2jXGnfOE3rGOboZOPgMJ7b8nYME=;
        b=n+Acuo87PHpNVeaffxLP7MZfHEY38XPhHIMPpVaNcdF482NavfGtnAwucC3AuW0tIh
         hQaO7ZnThtIMw2UevISd2hTTGWPHkCtnmfz2GcpMqWw7IsFIg+hgskhP9kuOhBSiq8WA
         mw9Xr1J5byxgyw3cGXiIK2QIhqQtarLHntbEND3GxxqX9gabTUDNlUviIiNoAi47T8CN
         kh8zsTMCRRP2Q84xs1kTxN2dcL9/CBxKERRi7qMBNf7WI20GLk0AbXB80wJuOhxObNK/
         3skLx5RCu2cEYsom3jSzUCdHdLWfMh807gPlL5ehJ4C9yQrYXKLqLGghn45I7FMdaAli
         vX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044681; x=1708649481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrLVLRDEPbd+8cld2jXGnfOE3rGOboZOPgMJ7b8nYME=;
        b=ffDc+RRxKpJuLWHxHem+G46gCv7w8pbZ6h3MxYksBiLP3Cx8z+157VMMklq+1Irdh4
         7D6ZO2oyzCPovK0dYFmGRJHIAnr0e8oxClZgFtxSksEWORXMiQ+tdxNEUjq0siuiCSWC
         TzOm68lK/6WBAqq0Jtze0arNnbsdpwJ/06kXdMX2CmVNHAb3szQ5Ah4gUF6ntAi2ye9R
         jNg63PrgwzrNf53HigPuh2MnsHDeg16naFo2l047dv19kc0as2aPJUvsiu3bsGfjgTuf
         BZMxgv98ZmUpCRVAVknjk0FCHZRUi4lTNDpPb9Fw8zcDs4rj6aY4TQS6gULQ0n+OYpNW
         ExGg==
X-Forwarded-Encrypted: i=1; AJvYcCUS8uenzMd1Iup0YaEKp2w6rFKXeNNmP0fbaEGxF8dHVVACp6cl/Jxz0jBXoFrR+dFTrsaS0JuojE5b3csgxtRkZSALgxa40kyO58GL
X-Gm-Message-State: AOJu0Yw5GcPO4tzzU3HHzHD68fFAgumMGSsFD0h8oByG8CHGKzWLXRXI
	dZEpAIVqFxBQkxx6Y4dhMoMaljxt9lMq6a/6FQ4yRqRj+6B/anz2ezYmtVyg+bM=
X-Google-Smtp-Source: AGHT+IENTyGsJoowL/bxOkLT7wmnB9W0cQC2zBMwiahmXo3191Ncw3RYDZMp+ExbjNdkHx2vY6TCwQ==
X-Received: by 2002:a17:906:4a1a:b0:a3c:ff93:e12d with SMTP id w26-20020a1709064a1a00b00a3cff93e12dmr2552073eju.74.1708044680964;
        Thu, 15 Feb 2024 16:51:20 -0800 (PST)
Received: from [192.168.192.135] ([78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ho38-20020a1709070ea600b00a3d72aa247dsm1041742ejc.115.2024.02.15.16.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 16:51:20 -0800 (PST)
Message-ID: <c0f3cb6e-b56b-4e34-b22b-16d21e5f2765@linaro.org>
Date: Fri, 16 Feb 2024 01:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: msm8916/39-samsung-a2015: Add
 connector for MUIC
Content-Language: en-US
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jakob Hauser <jahau@rocketmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240215122612.3833-1-raymondhackley@protonmail.com>
 <20240215122612.3833-2-raymondhackley@protonmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240215122612.3833-2-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 13:26, Raymond Hackley wrote:
> Add subnode usb_con: extcon for SM5502 / SM5504 MUIC, which will be used
> for RT5033 charger.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

I think splitting this patchset into "add everything at once for device X"
would be saner and easier to e.g. revert when bisecting or so

Konrad

