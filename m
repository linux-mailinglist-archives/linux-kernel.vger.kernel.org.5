Return-Path: <linux-kernel+bounces-44607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F048424F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B71E1C248A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE36A01F;
	Tue, 30 Jan 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCoCCTXv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F527EAF1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617902; cv=none; b=dSHjYlEb56WrKvLz/o0vCdMomtECM3eTw/yDeC5RRiKk1LqYW48JgVvRJAHV9Hrl7rgtLuGSqedrwAZFVkUtRKSks1lj7slwtVjd5FObP43YeFTHd8j1b2L0t6mNYTVpJomN+itS3hNtaIoiVX4BEgp/oq3VQLb+hn5DjNCyRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617902; c=relaxed/simple;
	bh=mxdUU1CF2v3l4RRY2Mhy++oHyImsF+xN0NaEsypry4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPHbJGLsRu4J6wZXxpPmJBCWaywFCxEoOIEziHnCkgB+txN4sJBCL157oSTdnAJFlfyGEYLPYWROBSuVy3rpLdpmW7rGuDZzqd4eYE/mJ9OD/qTuyiKLDwAXML1nfCIE5NTZXrAYN/4nZooXkXRUKlMUadAxwfDeP5MPVrGKHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCoCCTXv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28fb463a28so458482766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706617899; x=1707222699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAnrNLVLFOTYMykh3jYjbXCRI01GIesumi9M52SBcRE=;
        b=oCoCCTXvW6KKaT++KacK0m9LQ3mmOpBVbX4e3x0sLi05PsexAU9988F0E3wS+oOB5P
         GWnTe5+j0AcxF6l5JrAb30UebuYdGQq5bAcf5sdL9auEvkUBU3rn96W8i/39iyTNOQo7
         sPuVfnk0Ky6O4vF9V487qZtb5vemlSVfDFhITLqKBwMV+zH8MphZDEZ8Uz6VMw3FYKuc
         NGsxSRC2+F+3i+QvUKuj03GfCK6MUAKpVEZXo/Zej1OBclit3nIvr1UCiH5QIb+Jiyjy
         oXu/mV7UgdDV6gCThAM9Y0OsKlvOwfiEYVH5rqP3w5PMPnVVETtrErQZK3ftqSpGQ56W
         Dh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617899; x=1707222699;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAnrNLVLFOTYMykh3jYjbXCRI01GIesumi9M52SBcRE=;
        b=oxHACdGJmBrw+cEj3KSQDupUzHJRvw25JfUlOTa1XyufBIwISuEC9nEaUEeBq4hIUZ
         ZX+JIoLyklR7NzJCA33sb7sgURX9wGtsGGSDiGHCmvpDMsUYaNbh/v4Ia1UZyY2mXsQ5
         fITBYXQA7AgR5JINO4u6k44YF72WuissKv0MtdS5v8VX92gu4vCLAj8ylq2wn6GT1Cg5
         NSZZnC37WboOKdrRWG6NtE4lSpCNOPLFlxmQQFVYwtkKYwKX9qFpT6hRiZARIzTZMuWN
         NBcnCsxhT08Cvx2Y3Ysaf9Oj3IVOm3oM+dQ/jTl4cV1UIXAVvxpTX/UjZMVNpKFM7uTa
         LMZQ==
X-Gm-Message-State: AOJu0Yzip5Tvm31gc9MveG14wQMnhCKqky/AoSLwQ/c4/3x5S0PUFq0n
	taH9GaEUQ5isPJLDenBxG5hiXDe/U6KT52J5YCT+qaTRgbF7GBsprxXzxz6i/sM=
X-Google-Smtp-Source: AGHT+IEqgGeFzDhHkdk4fKghgmKr+f3lbOk2kxZzAkqkrbuYbePVncsJclMTKdU9c1PhBMM/KQW0dQ==
X-Received: by 2002:a17:906:684c:b0:a35:a4ca:111b with SMTP id a12-20020a170906684c00b00a35a4ca111bmr4397193ejs.33.1706617899205;
        Tue, 30 Jan 2024 04:31:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5/BOpjZqqKhKXvjozVn4KaojKMZ7wBixeFxFZ+kmEUo7s3RNdgM17GcukSYTLU0HkzDcNzEltVnnDqtOTneNZGHHh1Ny52NFvvAg+Ddrz++Y42K/CjOaZddr7Acq3Xk0yZLd4lgYzVGrhJ8GPDnrdtR/1fnigvEov03ESQs6xJOfylqKU67Alpj2HvAvpuUxNlbU8Z+Owt0pluv5V1PCKnxTCEpAnJEZC5W2wA7SP/bZnpt4DzbNglsbQtrqQ+EnvsSZKtWEKFl5+JtLrY483aUFlsD4fKPlhqSuP4VlcM2VtrE/RX0O8BhpgsO3TthbhbVnWSCH0pdaNXlWhmjjXZ0ON8Q2cvxRF
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vg10-20020a170907d30a00b00a3522154450sm4408147ejc.12.2024.01.30.04.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:31:38 -0800 (PST)
Message-ID: <021f3f6f-0aa9-41c2-a220-b1e6efad2880@linaro.org>
Date: Tue, 30 Jan 2024 13:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130120807.460335-1-naresh.solanki@9elements.com>
 <b305291e-199d-4a0b-b24e-09910f1eed37@linaro.org>
 <CABqG17in2+0eHMRBvyunWKizgSBpYPq+CGsMO7FQo13pApPvaw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CABqG17in2+0eHMRBvyunWKizgSBpYPq+CGsMO7FQo13pApPvaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 13:26, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On Tue, 30 Jan 2024 at 17:49, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/01/2024 13:08, Naresh Solanki wrote:
>>> Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
>>> reserved ranges.
>>> Add input-enable property to allow configuring a pin as input.
>>> Rearrange allOf
>>
>> Why?
> allOf is aligned with other implementations.

Which ones? example-schema and other implementations have it in
different place. If you align some parts of the code, please align to
match the correct code, not other incorrect. How to find it?
example-schema is the reference, recent commits are also sometimes good
indication.

Best regards,
Krzysztof


