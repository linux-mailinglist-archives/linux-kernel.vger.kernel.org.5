Return-Path: <linux-kernel+bounces-47802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A0845311
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9F1F224FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388615A4B2;
	Thu,  1 Feb 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFWOTFpj"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD01586FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777297; cv=none; b=eLIasUWE115mnZYrcBrsui21+E+Z3c5JrpM3Ci4nQBsYewTYMCz4fbxDUufU0IHFrxi1lEl9vAkCCeLy+eh6MOCxKWQv8JWUFaPSrrFDhzHL9tc1uPPUI/EJj0C/C04mAn4HpDjwfy/gdQuxVakh39A+7AuE0IFKlVpo3LXHbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777297; c=relaxed/simple;
	bh=f4F6MTAQJd8Vgi1aKRgKDRrsgMlKqr4rj25u4Yl9LK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1Q48+mVqSkffxTF8Da1E9MmzLLJtgcUx/6yP+Y+lrXVpPfjgCKc8LZtEdEkM3EHur5g3TVhDPhkxZCm3mNWdC4gvq2VzgI9C+dmDH1bUk2TMd6q41GN32SLHRRZdGeeDe+qSRaCUIIs6l/9+ZCd5CXipL60OfPDlI4PgFlyP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFWOTFpj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55efbaca48bso832415a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777294; x=1707382094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REG2Wu+YiLPlR/Fe2U5NdazLcF36rkDjg0fYhPH6wbI=;
        b=CFWOTFpjPsxmGmpdD+iC2D2HCLMlx5Hav0TgeOKeVhliTy1ji4jsTglDLtOaiHTtqn
         hji6OvYDgrGwMJAFewgL+9U5CO6dKSHFJn7uX8nVtO7CpduH/FaVY7LAr3gQbTOws5fa
         WomyQYz7qvdHhaBDGb06FFwLP5csRF7UjNTmc9zHOqwVK+Sg8C1PoHNlo1xE+KNqwZCX
         +dZPdtTYAGij8aJId+Y5XGBb1FC70FJn8fQJGCMjawkl2iGPIT34wm821rql2yVzqD6A
         92McQRbqnL+JwS/ieYwtLhUnmHxTXKEf3FvAKs96txWQO15clJse2oDmLSPAryOzuHNp
         N+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777294; x=1707382094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REG2Wu+YiLPlR/Fe2U5NdazLcF36rkDjg0fYhPH6wbI=;
        b=U3nE5ogDXqm+b4VLQEA/W8HOOx5fq9VfRqvyk1XN1oyMZgpovSTXbdFDlUI9EKL+n/
         8p/lRsw2cLqM+fdkRFq1FG5OdeiZqAeU2zUEnbqt1AMlU9AwocYqCxDRIFO7m+Z/9S8L
         G0czPP1Bn2Af2Gftvp+5JrafUpIs5A+102rHTwjUS4KIbpMQsLttl54Vd0jhftXFTH1m
         BO4xJ6TJX7yBDOO2GtjImnIzag/XT8j4MlFUMLB5cakYpGI3sEje3vfhL3pZ7OC1UxIB
         f0JQmadyTtyMc2goB5gbb9rEkG+ulwtkDpKgA+yYO2H6i+D5vbkg6YOwaRErmuq6CPPk
         5lHA==
X-Gm-Message-State: AOJu0Yw8MSKUooKxxMGwvSDHIyuJa3+Uuf2lHvw7qhaPimJ+he4SOtV4
	89UQQjw2wXp77fQgcrBDFLjAE+5gj2tRQKoDl7oTDErhNW3FA/iSKh18zGkmruI=
X-Google-Smtp-Source: AGHT+IGHunBHztBsV9QJNV3FWxYRHsZHhP0aQWw0z5liuRt7YtYvFOh6Hq+hC2UtzPwBm55TJiI0Hg==
X-Received: by 2002:a05:6402:1d29:b0:55f:8031:501c with SMTP id dh9-20020a0564021d2900b0055f8031501cmr2996238edb.30.1706777294353;
        Thu, 01 Feb 2024 00:48:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVwnUU+x75+3B5JQF3koWoxHWtzzDU3y27nNIlAoyLpCtSwmwWY0H2ukZT0HttjEzwawljhs888ZL4XrracYOuJ951kwOl1QsbhDclujTHRgw+wwVojSC8j0TGTQcb7J/A/+t7aBAOjZXJlZfmnWMtqEE5Kygrcrv6uFj+IdABTLu10mynWA9IMaHnk57rJqKLlJYiZSgtLV9sVnj1M6LEPINyHwNiQsIb5eKY+cia596x4HEIpYJUihY6LZHPVySIPyB0dfZ0R0FEx9ZrlAsoUikF00w0BUQRzwk5CCck2WRNleUITaRg2jUG1cqHxTKA4QiFp4cEWa2wWCZpm2NnWlW3836Ir93es2XqAFZWCjao+70u6vABS5BfisnFNnLOcg47X66qAVaF8ELSesmrmtRY3HtCV
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005598e3d6d23sm6551798edb.16.2024.02.01.00.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:48:13 -0800 (PST)
Message-ID: <a021d3a7-93eb-4fdd-b109-76443c955a82@linaro.org>
Date: Thu, 1 Feb 2024 09:48:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131105153.8070-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 11:51, Svyatoslav Ryhel wrote:
> Add missing LG Electronics, Inc. prefix used by some older devices.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

NAK, same reasons as before:

https://lore.kernel.org/all/9942f964-442e-e782-3926-6d7d1123418a@canonical.com/

Best regards,
Krzysztof


