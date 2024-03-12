Return-Path: <linux-kernel+bounces-99697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1165878BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5282F1F22727
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B810946C;
	Tue, 12 Mar 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKWwut4k"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586D8C0A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203089; cv=none; b=ZUpN++Sxri7dZ7/mA3T0Xf4v8RnDouLUOEGadl7eW2uICI8cPPAkod2Zn1jdyQ8pc48uvLy7CU7YB1AwQU2WeTe/yeNmD9jyLr5697Uq3d4W7040/r3UsTFNrxWHgOQ2Kix5yFhD7E55z2irG/R3R3p+RzkGCSzUq86/iWno35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203089; c=relaxed/simple;
	bh=oVopQaOOfzHY3UiFPdcWCjf76IMwbZpTCloyXY+7lDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IY9iVMOixFMIwFaxTkpJTstlj7k9Wwh450z1rtXmJL5YOera5Ol1O6pCMVN+VSFgTCbqDC5rlFejrv5ECOEX8LARPJM/5x0Pi9q82PclR5GKJ6TiMH56RiFypdan1q2afW5wSlsF2nf4u1Lx2Ms7R7KdfkGZz3+SedkEN31msig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKWwut4k; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513b1c69cb8so1198589e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710203086; x=1710807886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWhat7e2j1dWBbmXMTlUYz5GM9qOS0BL4XnLXY/ZEPk=;
        b=OKWwut4kg3tAwLpbwXY1s0ciHFH2UiyDG3GFFY4CfywxXAigzHTL/4yPAIud8gX7HQ
         seZFVZIYKPE1NDXgqReBUSNvPJ2pevi7Xn2hHGJiTqipLqkj+2NmlBcOmovHGC2PKM5r
         lY0JsjoJtmWSOcC71CE86w7ESud8zyfv2/oodyRBdiG4iiPNknaYXJam5KEKnhciAERG
         TYl1obDqFZ2cNKMoH235tSMSUKeEO2NXzgqe+pAe1by4qvfdyj9IdkBR53x12IYUqNbH
         naS/CCgTnKqPcp+gKqfZECiLmgwsPh5SrzZMR3kDFMuwnlJvAMRV3/eaihT8qbZ4ih19
         Rk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203086; x=1710807886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWhat7e2j1dWBbmXMTlUYz5GM9qOS0BL4XnLXY/ZEPk=;
        b=gbrQsZ4nIUWAmnpQh7VtOth4FhmS+41oO2guFTlpbstd9Enn3v6P3JxBNq+k4BM3j5
         AXa9vVJTaRDnt0gm9kw0oKNdGuWPnDrG3okN/Zwt2qN6XoF7iRzqjcWpV6LJfHjnLSdE
         TW5Yt3sWzn8Cou1EUpRn85WDOGLgc1X4iDY5CWngXkiQAohJKcF6zf7uXnKuJIwNOvI4
         Rq6rWpNKsqU2kvcNzMihIbKrJqhMTbGDpX9W+69qJRk1C/abbYofzgDHYWA2Z2MpHEs3
         2EsgjmAzETdpYZtWpj86LUfFcohH1H7aD8WaRIEx7XPG/JCcQsWzhtAd9e24PD02KHhn
         zH0A==
X-Forwarded-Encrypted: i=1; AJvYcCX4aJv169Se4gFHZ3ALLhwRFXS6Uit1c2htQmUlf/gd9KjziOLzPWrbnjeAoWeKb3lcmJpsEA9i9Ab1pxGwMYL095AYk9+LscVA8OVt
X-Gm-Message-State: AOJu0YznU+iCMN/UyfqctYt8AwzHuFMXY/CnitYTrQT7iurqbbmu6+OM
	TydVaNqtUETwtwbTfIQ62KeONMuzXu15wk55UhCsUNMf+UYtBEb/83uWSf9DaCWLxm8r83tSyhE
	Ll0Q=
X-Google-Smtp-Source: AGHT+IHm0GQQWslHHZzfBF39V9xf6bEVsajldQARNOhLXmx/EqaE6zH/wfXQL1fl/FeEaOfWwIn/Bg==
X-Received: by 2002:ac2:46cc:0:b0:512:fce4:327b with SMTP id p12-20020ac246cc000000b00512fce4327bmr5110185lfo.39.1710203085891;
        Mon, 11 Mar 2024 17:24:45 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m3-20020a05651202e300b0051327cb3a77sm1308626lfq.247.2024.03.11.17.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:24:45 -0700 (PDT)
Message-ID: <87709bd5-f985-485e-a2f4-9bdf4de5e40d@linaro.org>
Date: Tue, 12 Mar 2024 01:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 touchscreen
Content-Language: en-US
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Joe Mason <buddyjojo06@outlook.com>
References: <20240219113823.4189-1-raymondhackley@protonmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240219113823.4189-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/24 12:38, Raymond Hackley wrote:
> From: Joe Mason <buddyjojo06@outlook.com>
> 
> Like msm8916-samsung-a3u-eur, the Grand Prime uses a Zinitix BT541
> touchscreen. Add it together with the necessary fixed-regulator to the
> device tree.
> 
> Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
> [Raymond: Move to fortuna-common. Use interrupts-extended]
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

[...]

> +&blsp_i2c5 {
> +	status = "disabled";
> +
> +	/* Touchscreen varies depending on model variant */
> +	/delete-node/ touchscreen@20;

Please delete the node by a &label reference and keep
the bus enabled (if I2C5 is used on all models)

Konrad

