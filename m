Return-Path: <linux-kernel+bounces-48051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83988456AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5581C23AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391715D5C1;
	Thu,  1 Feb 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evldtosh"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7812CDB4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788610; cv=none; b=uaIOFDlpYJPSUqvkhValyVCxMpOgdY6d6AP3wIB7cUMa+rFGGz5uufApPh6kqGvuaXvQK6RvqhUkP0cch7hYQZcvTSYxuy5B5rWGdbRA/RT7w3XfhRh/wIndCuQRqLKJ7FFL9eK4AKnYit1N/IMTZyE0bQc1uE5ExxVcT1pY4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788610; c=relaxed/simple;
	bh=RfmXQyvEyel69xPdhImaszos039ws3Lu/IQlwJQIF3g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r7DgbSUlUt5J7127Bf2AOEz8baJrIrQ9d1rn/tBkshNpYqQVmf7ETV3KSV8M5xAwUj4Ae03NkW9vZtM3yzeMLPl0t75M+R9RcXItzNK4Se/h5CPLjzXofKXMCIbKPPvJ40/Yz8cdnI49zUGxWn5mXfa4rkTjnxak1SpCKnnBJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evldtosh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so7188835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706788606; x=1707393406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UzaWP/6dtk16YfMVdAvaDfLCxRKNmuhmg2gmErctQc8=;
        b=evldtoshW45feD2aPb3OoYeqnFY2GG4gHjyEAeHCZf1bIdHal9vqOr8PcPTGVYEHZo
         WUMsM3kgtKbLZV/H6Gw1CquJoDP4jB5iUkaMLCpczB7TYVInXofmg162yIsTutfi+yV0
         IaGZyUk2pP7YYzBxnDKVVQbRzsfqJ/R3cXY6w3nICiU0KpBcEr+h5pRRU/g1ss7Adk45
         bLDiRIxh4ac0bkKrS5/ZeIcSgThMKzww0HKPSqbgbeueOfERToOc2EUKll0XAHc+OXJG
         YO5nUm5C/ErAaws2IDc6trEDW86HxbMkKFbGrY6PCdEFLuvui87MG5KqpQ2iHQsr9XIY
         iUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788606; x=1707393406;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzaWP/6dtk16YfMVdAvaDfLCxRKNmuhmg2gmErctQc8=;
        b=SYqwGWwPyLhJpo4jYwYls4C4ltjMdgSa3Rh05W5uVAnw15aai8ubFSNkEAnKNV2Fxm
         lsqC03yS52o3OceqOeqq4nLPdhE6NrK31PIG9+0B1TrFKs7iEKesmbrsF/OGzBnk4n2D
         rBx7Mrwv8GwxjwTvPbvz4W7hxHXn+qyKsoia0JX6xYmRRGHeDzWBe6ZKAtHtEzFD/A/k
         20p8uG/bjvYtLgFl2YS3J0+mDHnpgrvge2SGJveB8tetpVM6JoF5YCfq7Po0GedQXEYQ
         TZAb621PFeFzvtTuLBtE50EBpfhey5CwbeMc3nADirVPOSX9d2oPG/6Tfq1JUiyL+5nk
         qEqA==
X-Gm-Message-State: AOJu0Yw2ydSB11Y3MuveUqJKwesmiJcFND1zElnFsx38orrY2GocDah3
	sZpbapfduwkMWiLP3/p9yg9D6r8bBQGhDUYZaAcvrnoDf66wH+NyerMw+OG48NA=
X-Google-Smtp-Source: AGHT+IH3xQv15i/rUEPOTbg1xkEyQ/z+dTi//c+Mo/pC9to5fm/kXZccoS2X8OLxv+GC/rXP2Zn1VA==
X-Received: by 2002:a05:600c:1c06:b0:40e:46b6:bc48 with SMTP id j6-20020a05600c1c0600b0040e46b6bc48mr1586219wms.41.1706788605859;
        Thu, 01 Feb 2024 03:56:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSbCo4GSIJ1EQ1Lh5Gndw9BXaoOrip1LEEj+lfkbP2EfE33NOZRz2cNqppVBEzOouSsaqfrqyuZy3fRFCSATxZdil1v/qESdp3mxpdptGNsjnuyjlpdtH2eyuT3mL7xDifDMQMd+JlYOlA+VJStnVmd8xq1yszvx202pCmd5HqfBG5QOt4oIdsn07ZC3+Cdc98tOzRZVC4Cc5GA4ra3dNADbxtBAyV8e5Ns7RyRSeOlIzKylhmaKfjjh63U5GfF9wBi8xHkE3CO9hdT/olr8y7geZ/tggYHQKRQHVn1gL/uS1ib0sDvrFoNx/iZCMlMCqheIxRFzzZBWFkch1JMS/Xvb+PzydzGxH2ELstLlpOhTPIyuLjQGGZ4iKuU+aVT11rq3RI4aOHxiFdwwh1s2ry/xSvZ9GxsSk2Ubb/u8ZwsKllCjnVDFN2D5gxuJLJ7tTUCBytUTxP8b+eZpbjhLX5bMJcMF1nQV+fi8V4Zd36pg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c448600b0040efb490814sm4141897wmo.27.2024.02.01.03.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:56:45 -0800 (PST)
Message-ID: <4c2c425b-3ddd-4484-98cf-3f7768c94e82@linaro.org>
Date: Thu, 1 Feb 2024 12:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: exynos: Add SPI nodes for
 Exynos850
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240125013858.3986-1-semen.protsenko@linaro.org>
 <20240125013858.3986-4-semen.protsenko@linaro.org>
 <170678377409.179918.13077326172475089482.b4-ty@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <170678377409.179918.13077326172475089482.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 11:36, Krzysztof Kozlowski wrote:
> 
> On Wed, 24 Jan 2024 19:38:58 -0600, Sam Protsenko wrote:
>> Some USI blocks can be configured as SPI controllers. Add corresponding
>> SPI nodes to Exynos850 SoC device tree.
>>
>>
> 
> Applied, thanks!
> 
> [3/3] arm64: dts: exynos: Add SPI nodes for Exynos850
>       https://git.kernel.org/krzk/linux/c/98473b0d78caa5502b7eee05553ee168f0b0b424

And dropped. You did not test it.

For some time, all Samsung SoCs and its variants are expected not to
introduce any new `dtbs_check W=1` warnings. Several platforms, like all
ARM64 Samsung SoCs, have already zero warnings, thus for such platforms
it is extra easy for the submitter to validate DTS before posting a
patch. The patch briefly looks like it is not conforming to this rule.
Please confirm that you tested your patch and it does not introduce any
new warnings (linux-next is decisive here).

Best regards,
Krzysztof


