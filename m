Return-Path: <linux-kernel+bounces-63496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039A853066
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BE528686A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B213D54D;
	Tue, 13 Feb 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaiW3yVU"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649972AE71
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826806; cv=none; b=fzVaZZr0vZcnEfkA9ACF1tBI3E4zY1pycK0ZBoqoq88gzyG0l1LgCWKj6Ov6L525jXA/p5JaVzS0BnaCtNj5nl5EAO8VOKeo0jS6gGhxoF8p8otHrTGFNVbnjCQjm4rZkeGYJQsHUbB0SiW5OvUGZloEfWwHqFOmTiB0QwS4XKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826806; c=relaxed/simple;
	bh=dkNG3a3vEaFHcqF0yQ04ydyTv7pVeZI16GkBfIizqHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f15GLvrftfuL1BZtbbjfEWTas5ofn6hu04+BsftWQD/eq3MGxV7b3/sE1J9yIFpWCqEMC/guZbRECw9uqmOktiRK9SJRx16DXlGIuCbmnnn42KC2IASd8pXz8fzW5N7dgMDCH7XwNuRlyb00iUcU2Jmr4+SdgzJxwj18VuS/Z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TaiW3yVU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ce0730e25so176611f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707826801; x=1708431601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xPlUWZZfV0xhaNu68kLm2i0PctpCsJrEZhY0KfjrSY=;
        b=TaiW3yVUk74xnqMXK2Hm9ovBGUYEgSvOkFpYhFbBwhR1xA4hI//4VJAoZZKqcVSA7n
         8V3TE3YVPnTEeIbK0dS6lz52EnvNpH3SQs4xO6TBMGUnbN7hZvpZXLpMpEUGiFdZ4yK5
         icwlI+OedEWaCPZ2/B4F7LCbIXiQTbhqkmo2Irdja1b0xV8QGBhxnIPJd0LIp93XfAJY
         yNrX1fhf4j3hkm1moaYxF4yR9kFH2KGXWiiAC4cPR3SqxshuqhaMPpXdDtxWhh4B/kdp
         ebZMJ7J76jTcriYvhdxWGgJHsTVbeWz9sUxgq0ThwM9WmeKISbk/mPnq5Ro5+IVwAvZo
         RT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826801; x=1708431601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xPlUWZZfV0xhaNu68kLm2i0PctpCsJrEZhY0KfjrSY=;
        b=oDcs5ahaW0pJ/ym9wKu1SkV2VDoUkaAADdcpYxe6iCAGExiMZfDBZKEntrfWsCjC/A
         ARAiA9UA9+1Gs8dwAN50UA/LODo24pTa67egFxQoZbYghZf45jApurJRwD2jVz76D9/R
         0ww7DzZt7jKXpkgGOOJVhzZwBYZ+QARVZWlKasb3/gGqmt0/Msxn05tR+Edqg1kGEu5D
         WIyCEen4GoBWrIEBg2fSYTntrovqmtofdfSpwtZHYO8/RB/GkR41ZaS2lE9V/054Z2w/
         TXxGaGm8DF6skyO6WGUVOuA7dAYXy5xQa4ZqkyW81mw1r3mX64d0hTS7zKjRUZ1BRkGI
         oncw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyCx4W0VaDLxDGVWBhXoHLq2p8wqez8dQJnqExQc7UcByF4DQ81rXq9D292UJVUKx275OICwu51jlf0Bf0iSHPpmQJdYQtBV95lLf
X-Gm-Message-State: AOJu0YzCCNZaORE5roezPEx/7sMqob/D8d/Hfm8gIocP85Ybh4xDh3My
	CZ773XuHC8awyFNVgCCE7D9vcRtpdbpXogZ2nCOI9mpuc7ZATHTVWtoCqsPc5bw=
X-Google-Smtp-Source: AGHT+IHUxwi3PA4JrYTFCrBS1h+LYp3QjfA6CokZGW1b8LhBgcohMU1nlo/8I2FN3+A1AlcXmS5zTQ==
X-Received: by 2002:a5d:47ce:0:b0:33b:684f:4926 with SMTP id o14-20020a5d47ce000000b0033b684f4926mr8585214wrc.63.1707826801685;
        Tue, 13 Feb 2024 04:20:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbYXZDPs2FszAorijYwvV0COWbTuDQjwOYRr075aLwQyKKa/75iQxZFKUbzeYWDPApYY0X1qL8mrH0zGKq80WKJBnqc3ABf4392dHQ+y8Q+baVk6OvkziLbOdzaHv7xMM6+X55pAVE6bXCankHWBIFUyRu58B8BzgaCIlcihMQ8K+g5jdovc4WZkdlAiOuz7p7N1Xf7s9PIZbqNIsFAqPzbE4LCWM94nz5apBmxcVTNbUrT52h97sve1H1NvJgljrVd53Jfs5jzGxwRiLbk8qG+CquNM3s0mMFlto70r8JM1JlRKRkVlEAUGQyXm3oAV24fc8mOf1Dn5tDtBCBcpVv8F/Y2EVDdRBqojXV8/BITc1wp7IbbIdQtNtwhViE5oSDBsN9tJSjowvKNMA3UKoTTG5GdLlsuTzGNs9/gWzSIawNJ9ZOEOfD4Y++JqFScAPWdHDo3OBhFBjKVrCNeJpebKT/Y9/NFhylISMyiRiONIQ9T/RnDDQlUJ6nm8CcaDJPCLkEAZnScj+P60bgQA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm9649363wrb.20.2024.02.13.04.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 04:20:01 -0800 (PST)
Message-ID: <0d94b8a4-0bfa-4f1f-bd58-6a59c408b7f2@linaro.org>
Date: Tue, 13 Feb 2024 13:19:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] dt-bindings: arm: add UNI-T UTi260b
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-17-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213010347.1075251-17-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 02:01, Sebastian Reichel wrote:
> Add compatible value for i.MX6ULL based UNI-T
> UTi260b thermal camera.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


