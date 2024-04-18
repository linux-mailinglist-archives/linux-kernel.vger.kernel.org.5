Return-Path: <linux-kernel+bounces-150571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D778AA111
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1EB1F22784
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8335174EED;
	Thu, 18 Apr 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjI2MeVd"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABD1EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461312; cv=none; b=CH0dMRKHK6eTe8Jj+PYLSRpIJVJgnU60sPWmaIPL51pwGvg1Bb3HEdCKhoSudMxckylM3Jr2CJ8X8NF9aptpD82TDHdTZZqueA7m3EdABC22WvuQWi6mvaWNQNA/ME4Em0816h8vRx64uCslitThWoDM1xwDKrNXtBrM8gJ5cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461312; c=relaxed/simple;
	bh=om2c0Q3P0gJ1fM7f8JAn8V/umE41rI1zASSBh+OoWw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUI79BxFNDNEw6QI6xR/x7l7bphabP0qQhtc9x52QMevk5/UjxlqByIk+w/85QTk/W24w7f56F2MrukdXLw9QNfVaMq0PIQ9xuMnrWyU7YRdt+NnN4q3OfweSFPnlWuvIgvnb90cu9GGjiGlDfET2ngudRoOUkDvjzo5ehbxr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjI2MeVd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso252213b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713461310; x=1714066110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hL+JOaXU+MUWvyxBhQrwDTWAV3CBHippBakhtwFN0c4=;
        b=mjI2MeVdKa2fzshTL5Ce0zt0kvFwLT+zJBtYsDT/gnRTeZYCz68trZdYa7ONaNb0zp
         lGAWeWQkFxQNTgnokz00U16LaFvSVDS3MKUJiITlV8ruZ0tXPdWOAENR5RSpM750BwnK
         nZF76D5pSBnFMQkCkzaAWVhERDlPnEKN9OqFmMbMSuzQkoM8vDeP+26+CUPMMson3pxB
         2RLPuv8JWCRH5jLuZ8jvuYX9fpwe2JaU6Ttj7SHF4EtiKygIiRbLUamO44JPkLUS3OE1
         /NCw2s8VCXFcsvqpIy7ZAvcszN+jeLUo49AtKfqBTDW4q3lKuFHUlOK9NRK5thkzMshY
         7+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461310; x=1714066110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL+JOaXU+MUWvyxBhQrwDTWAV3CBHippBakhtwFN0c4=;
        b=laMYaL9edlGsWUC7HLb5oFxD90NcAr/vSoays87yxtwJLb1cctO8Vy6m7Vta6qnCEj
         pI7bkGGCyLFoi2AHYYNXc10S9tkH1zqZluURPOnXtEw1qCRSVOoMJkwAGwoTxUz80PER
         L5oTQ6DH3JJYKD5KgHqb5/0+dQv3pXJq7oG3uIxMwRgXPaEE1k0xNmk6LQ2X+8bn721F
         JRcCsiS7tKLvtJLrz68m5EBq6eLu0ko8QSeRmNmcZYahAY0wJT8OJ8FmUoxoBLS28IiN
         3airhRKonDzWeHQPTWsfMWWOgsCIgKENKRRo4OZbckXtjl1PNwc4N4sFn3krTAg3n5rN
         DUng==
X-Forwarded-Encrypted: i=1; AJvYcCXIPe0ftLSv5SrrSKngoyLh/0INTYW4uIelaRU+mTNEy6gNKV7SkESayATyf5xKPEv0gwl1iWxWBX9EXL+DPBAhmVCnGurkI9Jj82wq
X-Gm-Message-State: AOJu0Yz0qTmSG2HXgLecz6euTDQrZpWkFj084LhkW5orWFM5roVkF5vj
	ZK6Gyjl8ykHNCydSoqLPB3N7v61IPTztQth0U0pQgQ+BzoIm/vHCcOUZCY0j+GQ=
X-Google-Smtp-Source: AGHT+IHDuSFKB3hqyRo5MU71tFCeKqpU3qmpVgNP9oyRIdVPD6GADAmz/c8SFPqLzWOlauJ4gbyS/Q==
X-Received: by 2002:a05:6a00:39a9:b0:6ed:4a97:10cc with SMTP id fi41-20020a056a0039a900b006ed4a9710ccmr4620877pfb.3.1713461310454;
        Thu, 18 Apr 2024 10:28:30 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.151])
        by smtp.gmail.com with ESMTPSA id g21-20020a056a000b9500b006e6b2ba1577sm1733617pfj.138.2024.04.18.10.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:28:30 -0700 (PDT)
Message-ID: <675cd641-7322-43d5-a33a-7f0be48c380c@linaro.org>
Date: Thu, 18 Apr 2024 19:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Fabio Aiuto <fabio.aiuto@engicam.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <ea49494429528cf8e60fa984ae1f523ddacd850c.1712920132.git.mazziesaccount@gmail.com>
 <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
 <7541fb24-894a-439e-8f9a-b18f04e06afe@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7541fb24-894a-439e-8f9a-b18f04e06afe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 10:28, Matti Vaittinen wrote:
>>
>> Missing allOf and $ref to watchdog.yaml
> 
> Huh. The watchdog.yaml contains:
> 
> select:
>    properties:
>      $nodename:
>        pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
> 
> properties:
>    $nodename:
>      pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
> 
> 
> This means the watchdog _must_ have own sub-node inside the PMIC node, 

Yes, that's a bit of a trouble. Then instead maybe just add timeout-sec
with maxItems: 2.

Best regards,
Krzysztof


