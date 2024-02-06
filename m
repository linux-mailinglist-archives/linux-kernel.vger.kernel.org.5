Return-Path: <linux-kernel+bounces-54501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73084B00A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670A81C244A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB812BE98;
	Tue,  6 Feb 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLwm3ODE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489912B17D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208539; cv=none; b=U8gpgazCO4apjaHuFZazcc0x1JInZ5h4FudQOFNv99VdMEbd12NhO/R3hG1tFdKz7D3eEvaaRFT3YBPiMoEZsW47xKTj5U2hIEF4166xJl4WCOAovnrfFQGmZtgezTVyNvWTbc3ihzDgqFVx96LWgCaSF/LsRv6yWWXTPJl38x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208539; c=relaxed/simple;
	bh=s+BUvunDeaR3/Eke62fggxZvcYcBIZXY46XKoSWdgSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdMpCzAffaHFWJwaQgjXcLzSdYpE5e0V/eAU4TufkD06l74iifYr0dTU5LPrTNxDwO/oeiraqtg6+ZCeYil+l5qBmAmdu3n6shChOrwi69uzMnWcDhYJD+/7jY81LWSTFf4xANbV0vd/TPRs2rN+BgRKIrDI1+SFjWsDRWQrTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLwm3ODE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so47841145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707208536; x=1707813336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+BUvunDeaR3/Eke62fggxZvcYcBIZXY46XKoSWdgSk=;
        b=bLwm3ODEfM0i7ez3adsdrKzEOl9z2GAvfN/h/oswRtlyNEUBZ520epwfwmC45Hr2wc
         MFsycehLTO1VqrvLIVYFQe1HEIWDyxv+LcY7ZEvo4vNGS3rExb+fLXMx1nLWleBPsx/4
         qijpRBPg2aXwEFnCJ6moNDGVQw+uGLGRpUZsOWyBOQbEm8qLXHIjPIJZphzp54R0i8Rt
         I5cchVBL6yya57HzChMXUiTRtCib9/doIdKA45eQynqeEHT/eZ+0asnH4Y+SZW5MrOtX
         iJiXrDQeumor7nWPIENPD1FIYbBHv0cUQIOeoD50xwilgRq9C00dNv6vZIXzUrd33Wvq
         dtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208536; x=1707813336;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+BUvunDeaR3/Eke62fggxZvcYcBIZXY46XKoSWdgSk=;
        b=lHvId74+3Wk1blKAUClfuu/Flt9knyNhre/+DXIvMNGMWAvqglHi4ryRzn+34Ekdwo
         HMvvapJpokS4WLmrKheF051bFdT0fG8HENEGBCQt5WSXbdKqPHnVprTCwUK/+gjYjyE9
         r6mu08aW4Ft3einbqfGrqHZl82/z0rcM/yPkmFddaYbk2eIabi5Fcp9DSGb3LX0vXh+D
         a4UvnznUJQ3rF6VS2bqaNXbilcET2Ctst6y20RrAqWSx/6/we78ht6n8T41Xw6zokAnv
         wqFfWLD7WqLxOVxqSy3ftHG9DoULX2HzxxLs5FppCjYsQNwMpGtOxuglG5r2FkUG1l3O
         TsYA==
X-Gm-Message-State: AOJu0YymV572vGwbtnzK6vxH/WQTg7SOAkA1v/sCPpC7LHvtKvLuupXI
	uvKOz746HX4TBm3zqd32VomSCTNLTzRFzNjQS+OqsF1201nLhLHgJmAAHq00Agc=
X-Google-Smtp-Source: AGHT+IEuY8e3Afw4ye2X/1S7e6dHJY/WVx+NeCND/Qxi5HO7UmQ0mM9QBmx7aRrVh0b2r5r5R7S9Xg==
X-Received: by 2002:adf:f550:0:b0:33b:17a2:fff9 with SMTP id j16-20020adff550000000b0033b17a2fff9mr655953wrp.59.1707208536153;
        Tue, 06 Feb 2024 00:35:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbbxdKQXJB0lQlxP/FF3XuCd2kZjifSp5FzZGH7MA/OFIkNHHQpnzjkjBz+UavuDzFxK4ugYba/wQzpCMWn2+SxHUuZ0TOB4aHH8e+vNXpEVVCwjPeimEEGhTE8C6zjB3q5xt8nD9SsHHxv6ZF360+TjnaPVV5QgljOAONUIu9EC4dFFkcT0En5gc1ku/nqcUDFi2bi6YLtQgoeF0s4pYCpu9Wq1r+lREBEzHanhk9N2Alpouq3hj8DgK+yikqOuoMIGl8fFXuBXw3VOn2Q+oXgPMU7rqIlWPO+93zvnke+M9LxSPVnirpC833lUpT3htE34UCbRd9ag==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d514f000000b0033afe6968bfsm1487670wrt.64.2024.02.06.00.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:35:35 -0800 (PST)
Message-ID: <1e26c5b3-716b-4f16-bae4-2682667550a5@linaro.org>
Date: Tue, 6 Feb 2024 09:35:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: qcom: sm8450: Add mapping to llcc
 Broadcast_AND region
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <cf138f258ecbfbcc94717e4914de2f60153e5abb.1707202761.git.quic_uchalich@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cf138f258ecbfbcc94717e4914de2f60153e5abb.1707202761.git.quic_uchalich@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
> Mapping Broadcast_AND region for LLCC in SM8450.

Why?

And why your DTS is in the middle of driver changes? Driver cannot
depend on DTS - you are now breaking all existing boards and users.


Best regards,
Krzysztof


