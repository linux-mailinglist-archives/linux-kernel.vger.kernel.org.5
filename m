Return-Path: <linux-kernel+bounces-38859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95983C75F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF531F23C81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCBA74E0F;
	Thu, 25 Jan 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8Sp4HtS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C2745E9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198210; cv=none; b=XTR2S3oK7DaOlMBgxKrSntLLDmEwtTa/D9+/eOdzi2wAs093zBcxirjpQS4v9u9pkyp5ahn5+iFYGhxmNhRa+/RVB5eqgp33UP+eWfNXIQYC/i0ru0YaVmCK7d9k0wweuSUDtI0K8KOqXFdYfxsSKAsJ/c+1fcYYgPuYKZeUlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198210; c=relaxed/simple;
	bh=juRKaRMDv4cbltizqT0zFF5a8XSwtyov/hSi9Hh0SqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9m4adxMpoJ2Ba7wsMBUHSmDIzUs68RQmpFSL6B5Navujjn/qnO8weYHKEcYakoe25h7PYjkr1GUuZHz/uihXkZxTjuktvWAE4JmjdCipM3IWZeHh+HoiS19OfLrrTirTV3z1ggWt+rUEAEAClGQahXz1dagsW+DCtesSmf4Fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8Sp4HtS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392291b21bso5833321f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706198207; x=1706803007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5KW3cGWOologfkUAtnPYUm4hK4xuDwJ4A0oJbDxe8Y=;
        b=a8Sp4HtSuutWs7ootURVVXs7Cw+N3XPK/SBGfMJa5U8DQU0uaEEXc7OyalrZIerVgh
         bzF+6ni2Dzu8AvMjkc25jxemSj1aP+r5MGohTMoy9yOTVm3xzGHHiCWNcZYi6IL7DQ9P
         UOacLXG3B6mwKuK2pv+AehrHwJsWp9BlXD+Rdnw7f3q092xa2xS3I4d+rRfHZn8e2q2P
         /e2Rmv9x0yFe6T3jcnY3jAwrT34NCFsA+TaTRi24bu7vuKGq9ZHNzywz7UeuRf+9s73c
         Nn7VUYJm1ISVjvplvgQhMhbtETfnhICBzvYCyrQL/BEIYTXhRR5MkOMBF52+c80zSJdU
         EYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198207; x=1706803007;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5KW3cGWOologfkUAtnPYUm4hK4xuDwJ4A0oJbDxe8Y=;
        b=plQ6uEDVHRwXjwiEmNKdjUQ0gBcIGP20GCrhG06wKtm/lXV0rZsgwSfTbmbfHHgxus
         uBQh1tku/k8UALe1EC2KNxI0BmzpoBCvujW24/gDijWmAmPkQ576vXJBszKen+Ut6sHU
         co3daC98Y41kmpToGt8Cyq+ySdpDp+m0rxc6ZWXpS4ZzTKfinGSGi4AWghoW8KHkcb0W
         P6W/G0nHxB7hy9R29SNsEqGgLPBqKpnTJUxlkYolQr61bwq4pjANco1P3vWYmdZXouLg
         DNzx7gWasVeNL8UCXP//YZKfolX4wMSeCKJzOaW20aMTiHtspC6N33FcS/6dQbHUwCd3
         HStQ==
X-Gm-Message-State: AOJu0YzU//O8r0G2AovILlS4WNgcFM0lvBcKFQ8Pz6XAeuYvd5oejQTl
	0X4Oo7MvdAVK+O6nKzbee8x1UN1KPDP+8783bmmC4buCIUKQxnxsDjAy2KnbWlQ=
X-Google-Smtp-Source: AGHT+IFPfTqnSRv5OmTbnRNo2YdJXXj+rIyKtLlxPTVuohq08LFuZui3s4qdRTru4THU9byyitLVLg==
X-Received: by 2002:adf:b1d4:0:b0:337:bfd8:e94c with SMTP id r20-20020adfb1d4000000b00337bfd8e94cmr4388wra.55.1706198206858;
        Thu, 25 Jan 2024 07:56:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id g18-20020adff3d2000000b00337f722e5ccsm16485821wrp.65.2024.01.25.07.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:56:46 -0800 (PST)
Message-ID: <a355b700-44e0-440b-91b5-c41af7953bfc@linaro.org>
Date: Thu, 25 Jan 2024 16:56:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ARM: dts: samsung: specify the SPI fifosize
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org
Cc: robh+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, semen.protsenko@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 16:16, Tudor Ambarus wrote:
> Hi,
> 
> The "samsung,spi-fifosize" was introduced in the following patch set:
> https://lore.kernel.org/linux-arm-kernel/20240125145007.748295-1-tudor.ambarus@linaro.org/T/#t
> 
> I expect Mark will provide an immutable tag for the bindings so that it
> can be merged into the samsung tree. We'll avoid this way using the
> property into the device trees without having it defined into the
> bindings.

No need. Any merge back to DTS branch would anyway question my pull
request to arm soc, so I am not going to do this, unless absolutely
necessary.

I'll take the DTS once binding is merged to ASoC, so everything will be
fine as long linux-next is fine.

Best regards,
Krzysztof


