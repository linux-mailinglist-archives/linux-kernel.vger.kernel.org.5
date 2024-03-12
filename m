Return-Path: <linux-kernel+bounces-100770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5B879D02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC001F22183
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0208142916;
	Tue, 12 Mar 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ils7ZC30"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CC1E529
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275875; cv=none; b=EUZZNfHYLOSEdGShFG3HYufjTXC0yiM8WQYgqlw5D26u5aSL5GyCtWDLIBCRuosmsWAwrMDR2OjYO2Lq0dqFRHiiKhfYyj6yY4q9hx/jcpEbTMb0g0nRhRba3mPFYUiy+gOf52Xy3Kyn3g49r2tq3Dzj/rj3AmfITw+sMPJkoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275875; c=relaxed/simple;
	bh=3PoZtqZfv/6PU1uW7l4UoCclsEmR/Cq0T8eKpXLxOAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2b/C8IOSYVO0UdQa46ETjJNZbKFNml8sGHaM7zZMhVN9Rbe6/bArk3KF2oBxxQr1+YXwsfjaMvrZbMyuGvJ89vj9XqkIGr9tbxRZB0m5K0p7NmsXwGFaN8cucwYQmMpvnSqZ3c5PTXUb9y0FVWWyx8NO6D5LfjYbSXplS4SwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ils7ZC30; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131316693cso388003e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710275872; x=1710880672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qkAM+iQxn7GBJaPt3CHhQXDne7eiNHja+zN5jC9ZRg=;
        b=ils7ZC30QZ0HT6qFeVMyhqhW5guOI2ZT1Cve4kRZHl/qAEfl17KscPFSW5yDhs+vYh
         zTEltdk9DkpozprtWgnDse0UNQqVVeEsKcA88cCzCmRUQlFSEz0g04KQpjd0UacolGO7
         R5FXafPek1T1lLDvHshntecc/ifTindJKOrKiEjNwqoaFRV3n2mSkqwZTZTQxImzE2uy
         yeDXcjkM8xxYupNgQVFfxc3let3QPdfGvoltOrO7859mjVgMaIoArzBD+iC9TuIASq3F
         5bnEEQeIbulQ8ckIuJvekaCXWXZqPd2Zw4lEDFmEmscEutEPIjVarvC+TcNRVWPYlWzK
         /Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275872; x=1710880672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qkAM+iQxn7GBJaPt3CHhQXDne7eiNHja+zN5jC9ZRg=;
        b=S6UBXEpuFD4Ve9LTqJhvFDqtv6lUMFFk2dfwvdYEsXOjlRnJUtj6CT8bIJo/hLDBnN
         H/1dDK+mxBWAYauPBVKB5vDJ04LImAHrLegh7OI9bLK8PqlAexSekHF+nRPd0XAMzcWP
         8LitaPT73dYK+jIW6/cLdD5hxNK+sHFhgtCJSjFpcjU1PdUYH81BDV13qBhVCTw9+8rW
         mqy+90uZzs+Yo7pCg6Bo05w66AavKCS26kg8nMW/A5pctIkatGfkgv9ylLdHwmUvisLG
         wwXZOmU8hPQ4loZUXnpi3fyv8HXbMpa8TdmAktDOPnWjMPyfhOR11shaehud/YIkyzKF
         h57Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgXztr603Q2n8l+tFAt/8Yi7Be98/RXIoHW58FHDN58o3PofsSYVGMYiUilYarzms5z3mDfRt9aFMnQSdGFsccqr1W+xrIcYs46aMf
X-Gm-Message-State: AOJu0YzyrC+eFGPARfoSNCLDF07jfp8l5X+Jd7/km3r34ap7JXCGKL5j
	v/2z0LgeVlVaPCBsWRaSrtCfdSeCmnPnXsAt5VvvCnh2Nw9ZZVIOyEK6Yk997I4=
X-Google-Smtp-Source: AGHT+IEwbT5mrbnBCcSEv/VsxGJBXrJlJ2+9LKa0GMPBpgwIJWgGFYSTZs9yyW5Wt+mdSIbJ6kkwSg==
X-Received: by 2002:ac2:4834:0:b0:513:ba0e:a2e9 with SMTP id 20-20020ac24834000000b00513ba0ea2e9mr2443479lft.24.1710275872233;
        Tue, 12 Mar 2024 13:37:52 -0700 (PDT)
Received: from [172.30.204.193] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u14-20020a05651220ce00b00513a238039csm1426317lfr.287.2024.03.12.13.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:37:51 -0700 (PDT)
Message-ID: <6cbc2741-db0f-4acb-a9e1-45b3df1292d5@linaro.org>
Date: Tue, 12 Mar 2024 21:37:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
 <20240226-archer-ax55-v1-v2-2-3776eb61f432@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240226-archer-ax55-v1-v2-2-3776eb61f432@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/24 18:12, Gabor Juhos wrote:
> Add device tree source for the TP-Link Archer AX55 v1 [1]
> which is a dual-band WiFi router based on the IPQ5018 SoC.
> 
> At the moment, only the UART, the GPIO LEDs and buttons
> are usable, but it makes it possible to boot an initramfs
> image on the device.
> 
> The device tree can be extended in the future, once support
> for other periherals will be available for the platform.
> 
> 1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

[...]

> +
> +&uart1_pins {
> +	/*
> +	 * Remove "gpio31" from the default pins in order to be able
> +	 * to use that for the WPS button.
> +	 */
> +	pins = "gpio32", "gpio33", "gpio34";

I believe you can even shorten it down to gpio32/33, 4pin uart
screams flow control, and I'm not sure if it's there only one-way

Konrad

