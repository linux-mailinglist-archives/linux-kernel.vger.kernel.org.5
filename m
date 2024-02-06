Return-Path: <linux-kernel+bounces-54822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89884B419
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366CA1C234FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6A132472;
	Tue,  6 Feb 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UExSV2Xy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0E131E59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219910; cv=none; b=euO6Bq5Pasib0TVyUtS5SQ3tDwexSrT4XZp3PuEeZd1aQVCAjVIZ3vFLq4buM6vZuHRkofB4r+gxKknvSV7VMAoSDvYni//JqpHUVtaQo7wqobMYKwy+kd2/4QooF0JEi4NP0b0LuJB+RWaJ1lP+TjfHWAYj96oVSuvwH1E6Ldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219910; c=relaxed/simple;
	bh=d+ylVW+J+cuB9BD5JYjwM9kSniO4Uju3oH075g5dkas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVZWYxoXKOEF28leG0c+T9NQrEo6UqDMutczbhANRVvG82pu4hVuvk8h4Ch83DqqG2xMmqBA116hHyLdUe9zPLvPjLBn0cdEe2I6OoY5kKPY7brssulCIEwMApfhEpYJhFGWlkcf0txd9ypYnry1hXBGD1fphJi/YtISCIrbHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UExSV2Xy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so4350258f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707219907; x=1707824707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gXYg6u5jc5P6zIqrkCEpI3TsgTHCAuPv259VdSvaeo=;
        b=UExSV2Xym4isWlDz39UZqUwTNBsQgZqUfPAooK+0pnGov/nLR4MwsiNXiEZaYPRLIs
         EEzLGwTBeXUv3Ff/+/2R4n9iJj10AdogXZT336iyNMG8zopXEFgEZsn+E8wa42yr+guO
         xPeZ28s9tN1gbXvEyt+5PNDBVbsNLycivvlxmwZ25IlHPA89dOemXsTfTVW8xrbzs/G2
         0VdEm5gSTG3jHaTSgWpmNFX1Kw8+xxiRAPKrQH4OfbkY0yIy1xzUu9mE12Ke1Q0kx53x
         99XF8I8XEJlJzzusdOAFfGCpEOes1+7m5NpcdZ3BqJm2f8V+d2jRVgmPySw+pms8YcQy
         Ee6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219907; x=1707824707;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gXYg6u5jc5P6zIqrkCEpI3TsgTHCAuPv259VdSvaeo=;
        b=QHsz7YYcgo+XzHy/7tY3u2Py+XmoFr9LXTQ7EvaPrCCgghlZfAQVg9PxaqgUAwJ4Yo
         aL2OlxkMMcgJ/htjAh8kbkgZmZDsK+fYpw88wIBR59+yo6+0ESSG+dpnz0zBNjJWyasw
         7SYzpSVzT6Micndrvvqx50pLWeBS9DWMe5OPyatwnPcHWYouilw0CJNHzU3HJJZepwIc
         YiHzXqgcA0HtNSc2teeBaSH3D+2dZYAI2szfw8Abxe6VDseQqpL2EZ4IxzQVKgH5Xxut
         jHB6JZ/uWhM9igzd4sofpwuQvS9SBG+7KwiHbzurdg20KKnmayyGzDtWqeM3UCbsn+xh
         NPIQ==
X-Gm-Message-State: AOJu0Yw05YQB73JlQjpr+39bGejeow9Wz3cZh45JFQHgz2MudEqGpncL
	QisEZolZZJ9dtE2/HlhmQ3rEyZu5R1aL8tiD4Dz+4MjNW3uI1c9M8PV/VS5tPaw=
X-Google-Smtp-Source: AGHT+IFrqpS39ZfwEo1c0DDcIWWNKa2E7Xl3S9BMue7A0DeU5a4cQSQLM8F5xXFfjyk4iEqRoc9HRw==
X-Received: by 2002:a5d:4f8b:0:b0:33a:fdb6:b1df with SMTP id d11-20020a5d4f8b000000b0033afdb6b1dfmr1229975wru.19.1707219907201;
        Tue, 06 Feb 2024 03:45:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6OyM5qraKwMoqBa9ZB5nr4LIJg0cAAODX53nyJGSZX5bVqLtF6kgWQHCBHv7MS9ZDkx5t7SvtvnryqUjS54CtkQJXCFEsM/Qyylgu/cxPWD1opqx0+DtgKN+VIfWJ12byNYPTEXqV3mw1gwe1U3H6mtUUiIobM9u/8d/jOwjwovBBcYzoAgN5PWJHNxXsUjgSl1IdMgkpnq9m4Ux4zLGxPp7rUbO+UX2grzyuGE8+4X545qhqHuRF86xGEFWqbZ578+xcgo1QB+PxCiLEslem6RNznQRHWWpIHokrQRCrPy3XqDq36ugVS5vdG1a8qq8dSVs05JoetCBETttoHA7e9XhjuYb4JxDn
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id y8-20020adffa48000000b0033af670213dsm1869512wrr.110.2024.02.06.03.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 03:45:06 -0800 (PST)
Message-ID: <e54d08ec-ffc5-4b24-b790-1962ee21c087@linaro.org>
Date: Tue, 6 Feb 2024 12:45:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: pinctrl: cy8c95x0: Update
 gpio-reserved-ranges
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: mazziesaccount@gmail.com, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240206112501.715042-1-naresh.solanki@9elements.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206112501.715042-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 12:25, Naresh Solanki wrote:
> Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
> reserved ranges.
> Add input-enable property to allow configuring a pin as input.
> Also update example.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


