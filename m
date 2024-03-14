Return-Path: <linux-kernel+bounces-103792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73787C497
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0B1F2217B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006647640F;
	Thu, 14 Mar 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuYUUYk0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79F76049
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450733; cv=none; b=sk6TB5fWVYyeCqBZlnpo7+DER/SrkicG15PYgIGFxlJEXv3f4GKHcE2Mk1wVNPGTNFNu7O3SMi4nQd/Cwh/a/ZA3ZaS/wUQmDAAudbUhGGQbgT50qPYWwmlSgWRUImxLljztzaOTUstWI8nfqtVdi+BD7YJQQfSF59J4eFgvaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450733; c=relaxed/simple;
	bh=VQAxS9UlhaDxtNiBi9XLQsLHIPtqwmP3APdnk8j+erw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if/KIaCMdmtPjAiM8ukohXjH4atx5u4pbqraq4hwWN9O0JJJsRW/I6XElC5qWMeLqAqYlw8fO4SMFf+V8Fscd8gR1peQE0ZygBkpL21nwd92Xmgl86UFxVhkMn5IFs1zVEtMjy9PVFfx+J33KOxBRw1U5ki5gpdizkmWZWWpJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cuYUUYk0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a466c85ae5fso188074666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710450730; x=1711055530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLs92Y9LtVh2vMfCgrmAPa3vJkKfjO8HkqCB9AzDoYc=;
        b=cuYUUYk0sz0LlqPyBDLf1bUzQ61j7n77KxrzhXePlUiphbCZO9YXeviT+0GWa8Nhsg
         bGQoBl5f3B1qdqQ5g8F1al/fNSDpSQzRLvBkLs0z1EU3sV2UkbGJ88NKFs/w8I/vRKSH
         48KXtZMiXjBNgoye/y/LD1SBuOUnpr/zfPCjHCZ8XFGEBHXvq7VL5bYibDyhrWAqQ5kh
         BMjJBVW286LqdBtfduNKrQV7mDv39vu9GVEfTlNImF1vJazKYUX1t2ypjvA1EzriIPIo
         KeO7HV1HFEGdjVgchcmMv1Q6xnIWGLZWQhZs1J09wazBLXfdjJipY0F8Jsz7oXdIL+vO
         WWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710450730; x=1711055530;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLs92Y9LtVh2vMfCgrmAPa3vJkKfjO8HkqCB9AzDoYc=;
        b=E1oNtOW7ZAtiSOkUP4awurAlg3beXN+EUY8Y6+MXCAswKCK29GtcU4qbG70c/XtVbv
         isJ2frb4lSGsKncuslHsQkVe02/zvjrcGEqeYDBQEIpKjq40IyfMDhLQoXizRZUy7gv/
         hUtpIh66+Vb0JrPjpLfqK7zNnU+zKpIni6OnKVtLb/Q5wqnBzXVJwme5B5G+HL5OvjKT
         9FibXwKsclSgC+J26Wjka7JMF1SOQ/9Ye/GA4bCD4sBupZm0Y91fgljruDGo+L21srrV
         ZwN/7OwrMIXb7yZ6qFOhc4oCgrjV/HF1j25Rwq1pF45yOm0BWeaIlM5IRQt7Cl+QQdp2
         c10w==
X-Gm-Message-State: AOJu0YwGStJ5WE3e6+EUPoFLwIo3dEqsuxfoZEGzwhVdFqVip79L8U++
	uoAJqUyXcz3wkD/f7Ea3ZSQPIBm6BCwyFnhtakMIbcbGVrk7ihDtm5ety9irHhk=
X-Google-Smtp-Source: AGHT+IHwj5yGArBwzsmIws1hzvuHYMA1RYMPtsqGuhKTIt51xsMOfO0SrPSQ7xgex7bZxVXePI8HgQ==
X-Received: by 2002:a17:907:c30e:b0:a46:7335:9c6f with SMTP id tl14-20020a170907c30e00b00a4673359c6fmr2037854ejc.13.1710450729848;
        Thu, 14 Mar 2024 14:12:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a42f6d17123sm1025222ejc.46.2024.03.14.14.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 14:12:09 -0700 (PDT)
Message-ID: <5fc9d434-d30b-44a0-bcef-f5c32f938034@linaro.org>
Date: Thu, 14 Mar 2024 22:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: adi,axi-pwmgen: Add compatible for
 v2 IP
Content-Language: en-US
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, dlechner@baylibre.com
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
 <20240314204722.1291993-2-tgamblin@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240314204722.1291993-2-tgamblin@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 21:47, Trevor Gamblin wrote:
> This adds a compatible string for the AXI PWMGEN v2 IP block. This is
> nearly identical to v1 other than updating the example to use v2.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


