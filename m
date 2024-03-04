Return-Path: <linux-kernel+bounces-90505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019A870059
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F73F284D87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87C383AF;
	Mon,  4 Mar 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLdUgPPM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FC37167
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551406; cv=none; b=T0BvgDvGxV4pjT63JJ38tpUfSMW6Z+ZcLVsUKjegIYf47tngFb3H6C+1XZaPXFfeIwiK6U95OMjpRfeV5HPfGb5CDDfIpvIdooNmEcf9nwCZDGLWumhRGg3plQP/hKDnHP8+yxgMRL7Z6P/ineQEF4ENWsRtecntqciWFVi1ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551406; c=relaxed/simple;
	bh=ihH8SoZ8MjtM3KsXbVE7KoIbfzOQ2yEi00frq5uj9lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg+dtsGl4sHy0PueG9TbRYA2910ao8OqdCdxXenHyzZLsKoqo7/FO5Z1L1BlI9ly7rxlErMVzkAZF0hcZAwfGyjyw2Ffjk+WKH82NpxT5rnG1ejXsIkAoN/wTgpXdAVMBAzxJfVGmvbLlRB5nhkXtslSaa3ed63dCQc8NYu7zmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dLdUgPPM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412e652c8c8so3363005e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709551403; x=1710156203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lDFXXm2kG1YzDHfr5otPz5t/XELMFvzdm+oyTl+vLC4=;
        b=dLdUgPPM55kn9mYzXaPYa6XGEtlnm+n2EKfjHjCSONhLtAUcduRGocz+Yc4QElLEWA
         tSdLn85MjuWW/qaLMBKgHyh4Kx84Fkx+K5pe0ETBphU96EzOZVRyDgV1/q8LnpdawNEa
         QSmrBUPfp/gKfaWm2cECgvp17yt9oQcX90fUY1FP9xYjDMNxvnC2M5Rt4cU56n2yC4vU
         LyHlqlpe3FtOHyny3nrE5E8WfJMr7vWYJH9mxjHtj0foOEIeAbLYNTCh3bTEZd1mNrIa
         YzTz/g9MvqpB828/Vd0Dtp6q9fhqPzaZzAjbfAgav9XB2hUyn6hjkrYgUYVjnmKbk2mW
         OZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551403; x=1710156203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDFXXm2kG1YzDHfr5otPz5t/XELMFvzdm+oyTl+vLC4=;
        b=ELac0T0OwWiaupPXu3ti76LBMrfakH+780rH1fUSa73nikDBM47boiOEfCvo5Y4VWT
         JXYzgUsZTB+dGPw78F3zTC3bHH9PwtChx8WRjP5C0oy2+hCPpduBm8DhUdbb57YYq4JG
         lpxsKcY6Jl/Zb/p0+6AvtEnyS/LiX1MTCxvbzE/sDFy1IzxPJrgmSVsQcMb4cdCbQ4M4
         Zy7UQA1nXVJrpqhTxeo78/Cdyx9wIIz2vsHc1qrPKYUHL1HH0N5Wm4UxYA92O4sSjb9s
         7s97C32kxgZLfNBZKVUZ2OS/CVVqQB95xdDLeecz2zepm9Uwnrv3af3n1zyPw7NKtk3l
         ILpA==
X-Forwarded-Encrypted: i=1; AJvYcCUIapz2Q2Bt7TqKCPJHdRyZJOAhJkc+W0KIO7Wq/jDtBx9PPvRopZ1EUnClwELXly7/c+YIKLTJhAlMRW0CtNghXx6A7judgSiUNsrp
X-Gm-Message-State: AOJu0YyFlqL3xWzK55awHa0wmUC0R6Ah40QLuMATHV3+NHfiQwuF5dTV
	wu2zyiROmG5aVIuEd2+f0tbKkQtb0fFAzEUb0tMR/7OmnQ9W6WNn+C/eb/CM5OM=
X-Google-Smtp-Source: AGHT+IH1dThM6zognY/FvYTchU1LxcUQcmr7sCx5PceJQrLDmXb80E81mQvdlz+leohQbnt8Kb82+Q==
X-Received: by 2002:a05:600c:1d1d:b0:412:e0f7:ef48 with SMTP id l29-20020a05600c1d1d00b00412e0f7ef48mr2011071wms.32.1709551403045;
        Mon, 04 Mar 2024 03:23:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c198b00b00412c8117a34sm10650735wmq.47.2024.03.04.03.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 03:23:22 -0800 (PST)
Message-ID: <d2426e1f-a09c-466f-a490-40fb7daf406c@linaro.org>
Date: Mon, 4 Mar 2024 12:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
To: =?UTF-8?B?S2VsbHkgSHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>,
 Kelly Hung <ppighouse@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QWxsZW5ZWSBIc3Uo6Kix5bm85bKzKQ==?= <AllenYY_Hsu@asus.com>
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
 <20240130085652.198010-2-Kelly_Hung@asus.com>
 <3edf1a47-9f73-4e99-98ea-182248102346@linaro.org>
 <TYZPR04MB659655F98C755C9DE55FD4AB9D232@TYZPR04MB6596.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYZPR04MB659655F98C755C9DE55FD4AB9D232@TYZPR04MB6596.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 11:45, Kelly Hung(洪嘉莉) wrote:
> Hi, Krzysztof,
> 
> Thanks for review, I notice there were a lot of errors. I've corrected them and done a schema and patch check, then resend the patch on 2/22.

And what happened with my other messages? Why you were not replying to
them? Why only some parts were implemented?

Best regards,
Krzysztof


