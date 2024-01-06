Return-Path: <linux-kernel+bounces-18664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCAD8260BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DE1B21612
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334B8C12;
	Sat,  6 Jan 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRtDV5Am"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432FC131
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a997f3dfso37644666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704560013; x=1705164813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LW1sllt9zBRwCDc97u2X0itt1kBazT6XeAMdWffTCRs=;
        b=NRtDV5Amob1N2iaTioiD+Z3dcSIBCBdnaJDOzRwY5rz7ea+mG9HRWbTRhweL6IRDyS
         l9HmnNhGMLeN2I1er38arQgCpuKC09KfiJHm9ZhX5cCHoUDRnc901r6HxWqUxCuer4+Y
         usWdWX+Tfylex8gtrGPBHh4e2kKO+wUpY4UElNLw56o059JkSK1m12FOJx+EQnn3v028
         jhDA5LDiR4V73GhNXF8DSZMJsIJr3YaxYNASprXvwTGN6evEVtrbzilxXSS4GYSz5acU
         59uW0xVn377slDKIV1tQ9mig+Rh1qBuyMIl1O1snEB2SnlTT4F3TZfF6MJvqtSp5hT8h
         ddcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704560013; x=1705164813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW1sllt9zBRwCDc97u2X0itt1kBazT6XeAMdWffTCRs=;
        b=WbKp3ntK9A7COR4fMgBY8rIu1/gzG+o9uIX85j2FuQNEm4LtFxFaY9X37KM/4C/uDE
         m+pYKwmVlO3BZLr8aWtc9O/nf1ghrCh+9FyIwI1dUppUbnkOEMSpGaEi9oZhlflj4NR+
         txte4nBa4D65r0Vf1CmcgtJb+wDsm/z3MSwWAzqCE2Fr3iL7MKfjBJU37++WYx1DGrQp
         q6wKAJJYtPVkBPilb9aX1GQ96COVblfjn7x6JsDPV0NHEtkbTNGfdNcay+uWbwD8BwAC
         c5WAsaaCVxtYzvZQcmJNVxlomL02kInTYA/o9xGbR11a3FBdjWvxq8vdckRiCf27yrSY
         7R3w==
X-Gm-Message-State: AOJu0YyUjpSFPtZIbA/qt+IxyWX/1kfcC9kum9J/ytErUd3EDNsIry6x
	Vlyiws/jZjpTZurBnl++6taMokCC+VOdG5Fqup1fbz0OP9ly/Q==
X-Google-Smtp-Source: AGHT+IE4sIe/vNE84X7XdpyJ3k7v8Kdc7k8r0eQhUrHcPbV2XeLjp+STeRzc8Nzgn/D69RAmOSMmww==
X-Received: by 2002:a17:906:dd1:b0:a23:6c6e:6b4b with SMTP id p17-20020a1709060dd100b00a236c6e6b4bmr521132eji.45.1704560013192;
        Sat, 06 Jan 2024 08:53:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id ez5-20020a1709070bc500b00a2a09be8a2dsm490926ejc.114.2024.01.06.08.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 08:53:32 -0800 (PST)
Message-ID: <b8f417a0-14b1-4d02-92d1-bf9469d38eb1@linaro.org>
Date: Sat, 6 Jan 2024 17:53:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
Content-Language: en-US
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2024 14:35, Bhavin Sharma wrote:
> Adding support for stc3117 fuel gauge driver with
> minimal functionality to read voltage level currently
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  drivers/power/supply/Kconfig              |   7 ++
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 136 ++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
> 

I see now that you got review for your v1. You must implement it fully.
Second, don't send patchsets more often than one per day to allow people
to actually review your code. Especially if you do not test it (neither
v1 nor v2!).

Best regards,
Krzysztof


