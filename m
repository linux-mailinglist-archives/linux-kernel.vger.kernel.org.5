Return-Path: <linux-kernel+bounces-48877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB684629D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B0028B068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED873D0A6;
	Thu,  1 Feb 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPZORThD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56183FB01
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823027; cv=none; b=gDWs4LlrRg3S4LY96Rs9v1G26mGB0eODvXKlfk7UoO2nKAA8lHTWdTWT208RuACaP4oBbsWyY74ykHzWnbig60c6JoKPPVX/ZjhxWZS8FAxagunHn+/Jy2cFOEZDZ8Clk8cmLcwmVG57Sxf9k88oOYxTOMzcj8bH/Ewbl+g4ubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823027; c=relaxed/simple;
	bh=PbdIUqPhYiA6AB3X+rs8Be25vy0jyf89naAwB2nQj1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgToYyEgipJ5siWB21jmaRzkZ2wId1OGftOYpDCl+f8g8P3jVJGa/jeUbBisepk1xsHMRr0keYmX9+wod/pluvMnPPhRcxIQF+ECUH0qB7KDu0uo/lva7RvrdIi+B20n4/k4ckTJU/h1ronXOybNdlOkJFMod4guqbCQa0gbCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPZORThD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a358ec50b7cso30026366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706823023; x=1707427823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/QeHBpQyFPB5QhxpYTGrBvtFQrY95kd1lO0Bi8UaxU=;
        b=DPZORThDPoXzLgCzVtxaLPNByk9k6XXDS0lMiSItp5Rtsn4eQYBzk8HhQ4wES9XD3E
         hARqmxOHvcX8oOtZiOI1zd8BbHJu9fmWcObInQIZ5NCJP12K9s3NF58EmIa/sZhZOSsE
         Ga0rYpWo9GEzfwFkMRzozNBZ4cK8zt42RyK+1eYcOfUQUxFzn6kzBUnEw8A6WDsfLPoI
         sGBELbxzblryR8AsZh6XRZRzF1fy2oNbVi+0zv4tGi5IdWiU2NGJO3Miym2DAYROkv0K
         hnVTI5pp94Ckeugm4NAEPZcWpahkhx6rHKmovt9ja5GuLdfHOGmKEvat8ODqY97l74Iy
         W+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823023; x=1707427823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/QeHBpQyFPB5QhxpYTGrBvtFQrY95kd1lO0Bi8UaxU=;
        b=YTXBLr99FmhNX4E+dTQjwYm7GjAPwdsMyhZQY1upb6MihfLpnmNMWa4Ij5BW2vf/2e
         NyKkr4kUO1/Lg2k4GCvSwsg1jPJIP7Nx1J8PVJCnw2ecjlYeClGfVBeE2UCObwFRspqc
         rg/XQiUsKRG2TZ193+FOxqQGXdbH1bDR2eo6gGEsvCyj9k3qtu1c71FGyLig0IkPHr1z
         3TM0CCYE2/jFg1I8xBMY4N17JRLefzOZJdGfwLG3IfjCk27d6Y5sU7S0cUqz+k+A2rRl
         BVVa/AkUOEXcCi3D/fG+Qf1H8PKk2Cv7QQSghNpsniteZPFcpaW/iYC/DJIexJvgjiK2
         My7A==
X-Gm-Message-State: AOJu0YwG5acZfrHuaVz0EoYCzfQIKYGOOVB+7hUlwnXsE7XikZ9EApZE
	0vHEKY9jKfj24ZN3RIybD6DIttaM6OSOS43RO51Xo6S8MW5/wYbIIYLUqFHxspbtIWi+oA8KgmX
	x
X-Google-Smtp-Source: AGHT+IHtJvQqsTQUguHfqfY/hfR6i77WkkUasxCHl7HQl8VYXpNsvAtsieZkmkFJ+Vqc4qtxS7NwgQ==
X-Received: by 2002:a17:907:7782:b0:a35:3c1f:b29f with SMTP id ky2-20020a170907778200b00a353c1fb29fmr169075ejc.5.1706823022667;
        Thu, 01 Feb 2024 13:30:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMRc3D9T5IxagDk3x3d6wMkDlSrnKJgtV+EG1BYuZtNjs6K1RNC0CXhuhRxcI8pGVl59dyItFYSZaZZkyQ2CLlXSDzUJsyKHKE52kCsNmfFBFmBbU9Om/FRsTmm+pTvhaM5CLPQbAvl9OX0JTIVOOptsz6gLrbJRKh2PmbKTjL/o3Yp87T/nYvgXgs3/Pqjsf2/VCzGw==
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id hd34-20020a17090796a200b00a36f314daa6sm182740ejc.46.2024.02.01.13.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:30:22 -0800 (PST)
Message-ID: <67c87d4e-bfab-4248-8f4c-60a80ca3969f@linaro.org>
Date: Thu, 1 Feb 2024 22:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnect providers
Content-Language: en-US
To: quic_bjorande@quicinc.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240201-enable-icc-8250-2290-v1-1-8ded02750521@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240201-enable-icc-8250-2290-v1-1-8ded02750521@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.02.2024 22:31, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> With interconnect providers built as modules Qualcomm SM8250 and QCM2290
> platforms launches init without /dev/console being backed by the debug
> UART.
> 
> Build there drivers into the kernel, to make sure the dependencies for
> the UART driver are available and thereby give userspace access to the
> UART without having to re-open the console, once the deferred UART
> driver has probed.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

