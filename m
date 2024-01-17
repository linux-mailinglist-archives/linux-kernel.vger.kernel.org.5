Return-Path: <linux-kernel+bounces-28596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1083007E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D321F2486D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E57BA27;
	Wed, 17 Jan 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3kP9V/+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C98BF3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476255; cv=none; b=P+QeA62ej4OdeVyHUmoNY4yNEV6+pd3N/vTuCQvdBqVTUPJlfLV58d0S3aS7HJ2bnDbPbwcNfeeWGQ0gV/5muezWkfLqrZN2wx+7skfP7nd/E4ZbQtddTrod5UbsyjZxQh2SpAaEmxix9Gwqijd7QwQBrqnW1QjIfLUKrs6jeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476255; c=relaxed/simple;
	bh=Id3wi3olBIfysDhLSl9qyngd9s+jR6CUqvJn2Xr67tw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Ch8zmfwQfifp7vHzfTSR3MecldQE/clmDXj6n8YROdgE08RGwdmpRfbmMb/IQGy8rNeIiomgKxam/V+1QRRxpQhGiS6EOAt+fZk6/iWNjjlmmf2D/Nu8xcylVP5Taz/QoTCGgxDvj9WsJcA2n+5djWI4cFXgThqykHuiRmFY7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3kP9V/+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so891281a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705476252; x=1706081052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOeeLr5Q/SJJfobMWQJMrFz6HgRJncfEoFMxDRaNXQU=;
        b=m3kP9V/+8n7ZK9jVepPFRJTXpBcR02u4wEHP7wPmBykvIsmGm5Q/gmu9rDV4NAP5YI
         JBiDdkB7iQBP2w4MBin6ENiCeeoOoP2WB6Jhz6QArtTc0N14boNAyHn3BkTQeYMJFyCH
         TdLKvKE0Vg8CrYIygdgRwyjrWVZaFOF1kY7yuw+7xfc66kKFE3Nv9fXgvBKFqZl/3Nbf
         jCSNYsH+Vma20gDxrYLjzVYBXK0BLoAdhdgErwOu+nloUxL0Ml2nmFoxFfSUuHNZqtRw
         83icy5X8GgDv7CJTDoXf3L6TfJ3/4ITUdIVs6SK7RrRk1Gc71s1qQAmqfyYAs/aKOLx4
         ow/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705476252; x=1706081052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOeeLr5Q/SJJfobMWQJMrFz6HgRJncfEoFMxDRaNXQU=;
        b=jPxwSzLWyIwcHeNER1DrMyTXzfb1MVyjiAFXGlBliFn2DgHGMogvzT2WlGRaMLlcHo
         hvigSevo+zutt9hltqZmJaP+fhDqhATK8se+M8rB/Imwr0O2K4kdmHlNtmsT4vpy1jsq
         9zoWceVlYPxlwjOCd6fz/cN7PPDd/4dIAQtCwGh0+pUO0MeurMtbsJBi5PQUAs7ZzS+e
         tpw/bMOiXxjwIiHTr6DRHUIBEzs0mLCbMZD04jaKUSC1HSIVG3f/R+2XH87mibFt9Afx
         3HXaQeYfnTmTODI/ScUr3wo8pOuIDPOD7WV9rVDrpilZpShbxNt6X+zhTjxxreSb/2K9
         B0lA==
X-Gm-Message-State: AOJu0YwWvA5G+rKkBCFil9LcAsjchZL1BJHMBEKv90iCvVAEVpmI/yy4
	J+bxR/UIJasr3p9y6DlZwROCKhwIgfgI45EEjbkQXBhfATs=
X-Google-Smtp-Source: AGHT+IF/gu11M5AnhrGIj7RSq6/2aoVcOjcNcUTIP7n9SwU0eKQaaIsT1yOqjLFs0v5VPGq6tmd1KQ==
X-Received: by 2002:a05:6402:31e4:b0:558:b5d0:e77a with SMTP id dy4-20020a05640231e400b00558b5d0e77amr442788edb.36.1705476252401;
        Tue, 16 Jan 2024 23:24:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm1332043edb.6.2024.01.16.23.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:24:12 -0800 (PST)
Message-ID: <70d52400-13b8-4f2f-81e3-0753e77e129f@linaro.org>
Date: Wed, 17 Jan 2024 08:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: tps65217: add power regulator & backlight
 drivers support
Content-Language: en-US
To: Xulin Sun <xulin.sun@windriver.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117043323.2008454-1-xulin.sun@windriver.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240117043323.2008454-1-xulin.sun@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 05:33, Xulin Sun wrote:
> Support TPS65217 voltage regulator driver and TPS65217 Backlight driver.
> And enable them by default. This will avoid below booting failed
> information:
> tps65217-pmic: Failed to locate of_node [id: -1]
> tps65217-bl: Failed to locate of_node [id: -1]
> 
> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
> ---
>  arch/arm/boot/dts/tps65217.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
> index 0d463de5650f..f412e7476660 100644
> --- a/arch/arm/boot/dts/tps65217.dtsi
> +++ b/arch/arm/boot/dts/tps65217.dtsi
> @@ -13,6 +13,16 @@ &tps {
>  	interrupt-controller;
>  	#interrupt-cells = <1>;
>  
> +	pmic {
> +		compatible = "ti,tps65217-pmic";
> +		status = "okay";

Why do you need status here?

Best regards,
Krzysztof


