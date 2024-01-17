Return-Path: <linux-kernel+bounces-28606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BE8300A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F58E287EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825BC153;
	Wed, 17 Jan 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSwMgCmQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F4C121
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477340; cv=none; b=FWY7RWH6VGgDnJbRQPhzWt1BkmzVUFJJAQaG8gsGWK/a3L1z/jUADKBGiGyBTY7LlYd/Mbx9uJ9fva4r9X5hG6j+NEu0xBRrvRlM4wV5Izkgqmj56ProYXkCwlxjuMY/VT96jUszlBRuhuC0Pm98UyH1b45lV6cNAZ+/RMfYSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477340; c=relaxed/simple;
	bh=5t5aUxxGeFjpacPv8IkjbXpGMOy8IUzHeHyCHb64jyE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=khlGyLpgSGm2XBCLtoKHCo2NocDyRuDhODKkoYogDIbC80szRhQyPcokiwNS2Y6hOIniPNx+HlxJiJ7qEhWu8zubi6iIwOnkecmEoN5w5ReK44rEUbZQ7EOmKJXvL3EBil3R2H5UQx8+e4o6TBmUbhJTJc1oc3t2kY7fcpiW/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSwMgCmQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso12910878a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705477337; x=1706082137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/A0JqxOC2yvRQmjMig0yHNkXz/q+JUU2MtZE9QrZOA=;
        b=GSwMgCmQ06aSWGUWqy97XLcE6QmmVmYbhQ6z3BjlZ6mUk0yZNXLQk/5TMPxRGPXyY7
         vNzn8sS+UET8d4FfJ7GPD/stGYYNiMobjOf8130tMgyBQP7zfLjFhvOrHy5kuiYsPegA
         KmuUKpl1UBExkDZY6dR4ISQQDrrW72MuzxoBN2Yx6wewoBNp42l4s76rfVZkIVEsDANp
         yVavmNrqKH1YBUEFGzOIgOn2RivSxfXZnIsV+i3vVKds5BEWufBl8pEFgVkooYNhSVEc
         GXmRZo3RqefuFRgwwn20HQKsnTkEb53xt6A/CB4vGl8cbzhPFP8ke0260rhnTWjIjL2B
         lEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477337; x=1706082137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/A0JqxOC2yvRQmjMig0yHNkXz/q+JUU2MtZE9QrZOA=;
        b=sJD9bylTZFL464jBSBHWud+nGP52fksFYF6G86rGULnWMUmtrBXer0aF/R/MHRcFKO
         vQbNC71eKY8HAzh85tApfhOvqqA9irhhLO9Vj8RpIlQGpgGdV2zzFtrU6nHNgHNmIx49
         MVTPeJ8YPQTJ1N0Ojy51+9DgrJIYB6rJMsJP/AEO44EWRagu5VZWSbUQJoiygBkAqgsk
         sKVixe/jQXNrZeeXbu7rCPLME7wMzkIyCXcelU74i9DA8nbpOuOAH4ir8XCqo6uUF+8w
         lONnowUEeLruoh7MkYazwvWm6UTHaY4iuEsi6Kh8a1RkUhh4nVglCBTu6xzqJeDxXmM6
         dR2A==
X-Gm-Message-State: AOJu0YxoZFKFbpn4HphAYmGXpYOAdDBOxCN9D0hRB6gDNAhxwiorIHLq
	o3xf6IoaXWuy2dQrL3W++fG72OunXvcmNA==
X-Google-Smtp-Source: AGHT+IFHcaQr/eSQm+S5ecxd26qyDD5gUg3MWl6egg/LoUVmQ4Wb1JQ9I0zyNcKCUV1e5cxeaC9PYg==
X-Received: by 2002:a17:906:6713:b0:a26:f301:6b52 with SMTP id a19-20020a170906671300b00a26f3016b52mr2651539ejp.49.1705477336817;
        Tue, 16 Jan 2024 23:42:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906559700b00a269357c2e7sm7426706ejp.36.2024.01.16.23.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:42:16 -0800 (PST)
Message-ID: <116d7421-6aff-42e8-a4a4-2251b7764f80@linaro.org>
Date: Wed, 17 Jan 2024 08:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: rk809 fix compatible string in
 examples
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-3-tim@feathertop.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240116084618.3112410-3-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 09:46, Tim Lunn wrote:
> Fix typo in the example specifying wrong compatible string
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> index bac2e751e2f2..3f31478932c2 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> @@ -154,8 +154,8 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        rk808: pmic@1b {
> -            compatible = "rockchip,rk808";
> +        rk809: pmic@1b {

You can just drop the label... Is it used here?

Best regards,
Krzysztof


