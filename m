Return-Path: <linux-kernel+bounces-146933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A48A6D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A11C21847
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3712D742;
	Tue, 16 Apr 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZAIFmKg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9212D1EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275965; cv=none; b=BvMmCjfr2Sg+wv/Y+maKoftKgcIhoZnN5CzxFRuXBsnqGYC4oDn9VDY/xG9PBQwk8vndWso1u1YaQoL1jxuFo+oHfRwxb/Kz4htrBviP0ocdgZp/QD/+p/uTpAD7RRHkOWtHzK1Vo/wuccNL69eTUpVMZk67U8QmgN33YzWA+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275965; c=relaxed/simple;
	bh=LHyKeXKzNTWwXkPYS/BAIhA9PRdODG+cNEw1D9IU6jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pbeup34jWz0pZmj4z6ZybYXO4OblujOLpB/D2qA8dWKybpo10Xr8EHH6nfFthBRRfLatglKkFpIWOvzBefqMTBlSLgqou7momBL/ZpWj59bTWmHMtuJ/vDrP0AfutBa+ZPH4wK4CJ/Az8TRefkCws3MfaR8wWCMXHXEKoB2Dt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZAIFmKg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518f8a69f82so2238813e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713275961; x=1713880761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wD9eHBRhW8p2vFdmYSbs5m/0CPQ24aGQTS5i8W86vBg=;
        b=dZAIFmKgWbwxuDtAC33YWFPBMG9SEHY0ijYMMF5sgjt4BSt/LdruMpLSxEK2YPoQF6
         ztoqHnVV7lme3zT1SbofGj4LsGf6gOaRpZGt/vXjkoA04PMTM9l9TAESGnRrklw7z6yV
         QYxC7UbAPjuWqU2xnv6GrnswaHgaWCXKee/5lN1RvsHNux8ceQ+hc5mdaG6KU57BbfU5
         Yf3wB1UOjKrYCccfoaPmPo/eS+sD0Dt9KqtGquXHB5Rq5dSzV2ITodWNjExndlB5wyzO
         p5Wz9kda3w9yzWfkucm3SSVffPkCfd+t5ns3iPD4lGFbtpwc/yzus+3QKLEEXMjDeayf
         WkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275961; x=1713880761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD9eHBRhW8p2vFdmYSbs5m/0CPQ24aGQTS5i8W86vBg=;
        b=Oz8Ze3qvVjMvuMB7gOxoOhPdABK/dvNZMt/5hW5PpII6WuI5zUwp2vTg/jE6SNFVE7
         i9Pt5zK73RWY3k81waB0WsWQCj2YdQYWqe3Kw3TgCemwoldW7HcpC/vpYmFtah0U0uAV
         XSN5afMXkcGkkMY5RcobnuJ8fNHdk9BEi+SYXi+PKn1Y3DvYhgCvgIsG/1f/va9awrpA
         /z3qMXMew3wWN2gVeXYZQ+Czfsk21nxgdByv6SdF6bJROG3IklSHP1ObQjlcHqVU0LhA
         wGOoL5w2O+tqyTl0RyVuTjCui/znhidToH73GloBGCDdE4O2jnvVP4PLY7Ciwr2Hz+Uk
         1u8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE0Eu54NUe0P1rxw38G+PxGkHNZ3DtFZQf8UESryG4avnPNUw/KbgtPFaz0zyESRdBKVIWzZUHlJJWvvXRGr2RGcytNU18/qFLfgO7
X-Gm-Message-State: AOJu0YyOlDC6HSoG0gZuMdWYIIq6b513zs6VdE0/6ZERUCVwfYFip2wO
	roocZT/NNf9VHveXWV1P83+01d0InoqAkj253fLDJANhlGpXey+oXkIMa8TUpCo20T5dpOgZ+CT
	d3qs=
X-Google-Smtp-Source: AGHT+IE37/W/LNxHjwv+kSmZ5GYL1F0f4rusBwAvgLPgoyr0g/XjmubcRmdvnLkQS2BP/CcBUAheZQ==
X-Received: by 2002:a05:6512:1c7:b0:516:d3ba:5602 with SMTP id f7-20020a05651201c700b00516d3ba5602mr8868189lfp.16.1713275961469;
        Tue, 16 Apr 2024 06:59:21 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id eq2-20020a056512488200b00516c40b05b0sm1585497lfb.215.2024.04.16.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:59:21 -0700 (PDT)
Message-ID: <08f3b1d1-c3ab-4201-b943-ca35bd321103@linaro.org>
Date: Tue, 16 Apr 2024 15:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] input: pm8xxx-vibrator: add new SPMI vibrator
 support
To: quic_fenglinw@quicinc.com, kernel@quicinc.com,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
 <20240416-pm8xxx-vibrator-new-design-v11-3-7b1c951e1515@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-3-7b1c951e1515@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:44, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add support for a new SPMI vibrator module which is very similar
> to the vibrator module inside PM8916 but has a finer drive voltage
> step and different output voltage range, its drive level control
> is expanded across 2 registers. The vibrator module can be found
> in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

