Return-Path: <linux-kernel+bounces-89243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12786ED2B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996C11C21CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5FBA57;
	Sat,  2 Mar 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Trhf9yhm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E653AC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337733; cv=none; b=XShDbOZzE0xJQXuBSeji/Ab5F+fvDCYKKW1mHe3EdwbHyuCxyj5XmeFvkOdMnQzehFChKx6Cgc9soVDEciY3dQxhsBQxe71O4u/VT0omkKC3nNxZnmJmE16cJplhfCpMXyYfkIbYQX+JF7J3+3CzOLwcsL3Aqt4pc7pI19DK814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337733; c=relaxed/simple;
	bh=p0aTg4Dk43UsooOLlnRb/erthY//r0L6e7MIujI2S88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IZUon7Yu2a4x9YC60lQ7848ZbJ9ZltDh4S4giGGkuisNiXKmtm8zqzeQmPNr5hNf0EDd2N6XbPD6LRTRbrr+uMBmTzyJSHDlA5v90SjNa5qKMMffWm3J9AHqAymB0gKqIyjw3au/NpFxRploX4SEnkkBDhJzykKL0yTE0a9VdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Trhf9yhm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4429c556efso435733966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709337730; x=1709942530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lsVKpZIUbg+frwT+YCemkgWx1etFYNAbDoPF/jLkUg=;
        b=Trhf9yhmOoOzd38KlJ4cSFHNPZWAmFaDO7FtfI0CBXSge73F4wQump/EDj1GPsRTHR
         OLkFeVtF00y6u4Pt5PyITtD5OGxBuFEYNm/3XeXykr8U0zrqxvZP77ZzgOFOHqqtnYQk
         +42s19Mu0k8yhPprkgIuzsnZxf3/6pPIDK4tHVYqdRkL6NrdCvhIxCqPp0A2AgTmuGcH
         5N3s8BOJL6H5vyitWDfUAudsFqeR3h6EpODDnrEp3IDFn9aB61Lrj1ic21JSz177Rnu8
         fXVlDroPQo2rv7nUSGPZdaIn24uiB4o7zkoPE1v78y3XmWwtoFlTbzDovUEvfbJC9+1A
         fErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709337730; x=1709942530;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lsVKpZIUbg+frwT+YCemkgWx1etFYNAbDoPF/jLkUg=;
        b=h24xffrWyAdoPs0+PuPgcza6qtMrcWC9/w4unHmAdQqONGZlWAuwz5Vq+6KnrZ7m8w
         T7TQmrivcFO1RyWn61GhrQKPwhfoMblkL4RgWf3Wbev2ZUdCQ++ikS05Isq0+DmFHIx9
         czmZjgHdZL8qyEyqrhbg7W/ahnyuQEp+hvlKUrocCaOZaQlPPXzbDLalBjiEYbZZGkgc
         WSZgbVzwtXXCelGD5QX9rGRn16ml8fIo3ug9ioPiE+H0hgxirV5ogOIf/b90FyK2AekZ
         hEKcJLL3NnDLGxIyouzZWAVz/8jDdGOilrZdaWEvKM3L+q4KA9WC7CPgcZomKf42yu97
         mMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCFd25Qqlyd3bawNCObeytK4PeA2/HPiW36bzS7X4i/LnxwkyXhRIDMglUbFV7epNbTpLtHPI0e4kw6a73Xl1HnkQRgIY21G1Rdtk
X-Gm-Message-State: AOJu0Ywj3Gf2IS1iAWE3F5xsJSfxC2IT/vRnBT4TXpaTDqvnZFRrjIPM
	HiVfHeDBFVn15TmwbhZz1ghYCEyyd5P4dA2EO/ImXGkXbzi+JeOA15esrFEFCEU=
X-Google-Smtp-Source: AGHT+IF6zq9dPDniFnLIyOkagRML1XNJz5FGHbstGRGs8rXD11h/jejzFqz92hWv8HiSgKBoSNfTCw==
X-Received: by 2002:a17:906:1cd5:b0:a44:512d:fb19 with SMTP id i21-20020a1709061cd500b00a44512dfb19mr2503710ejh.38.1709337729940;
        Fri, 01 Mar 2024 16:02:09 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906131900b00a44bd00ed4csm466451ejb.0.2024.03.01.16.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 16:02:09 -0800 (PST)
Message-ID: <825762ea-8d53-4231-91dc-1c63b955e655@linaro.org>
Date: Sat, 2 Mar 2024 01:02:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: switch WSA8845
 speakers to shared reset-gpio
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
 <20240227142725.625561-2-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240227142725.625561-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.2024 15:27, Krzysztof Kozlowski wrote:
> Each pair of WSA8845 speakers share the powerdown SD_N GPIO, thus this
> GPIO is specified twice in each WSA8845 device node.  Such DTS was added
> hoping non-exclusive GPIO usage would be accepted, but it turned out
> otherwise: it is not supported by the Linux kernel.
> 
> Linux kernel however supports sharing reset GPIOs, when used bia the
> reset controller framework as implemented in commit 26c8a435fce6 ("ASoC:
> dt-bindings: qcom,wsa8840: Add reset-gpios for shared line") and
> commit c721f189e89c ("reset: Instantiate reset GPIO controller for
> shared reset-gpios").
> 
> Convert the property with shutdown GPIO to "reset-gpios" to use
> mentioned Linux kernel feature.  This allows to bring all four speakers
> out of reset.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

