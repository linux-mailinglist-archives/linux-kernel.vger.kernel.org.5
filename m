Return-Path: <linux-kernel+bounces-7971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0781AFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807451F27762
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE015ADF;
	Thu, 21 Dec 2023 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TImqD6Zz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA0156D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a234938c7f3so48153566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703145762; x=1703750562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ObjpKKsnJKpmQ7Ch+WEC9pMBWTA+P86GBMNxJkiSckk=;
        b=TImqD6ZzBrOzMvszcLRvpO3+1Pa6DxL0q6Fj2g5ev10DLRtgwKlJyYR/XaL3KkIieQ
         n+TyXTp19tRLL1SrLF4lnMXCXHkjFAtATuNQccZmqnYb+h30yWuElw1uC7TFZoqRlNnD
         ao2t6NyGjrOE8/vUU7CmPrBP+Bwz5fqeDipkH53BWPkofEtpJbmJs2U+Ha+6apyWD7t1
         iH1iqQHfLS2eG1KGxCZuO/or2b8Um0Q5jP2RW8+OvdahESqGNS7Oug0rlreNvt0IyvCz
         iWGKUhM4w9fFY70Ee3oWDjnvSgAW3Et2a6V0wk2FXN2DvXIMtUJW+vcAoGs82YjiV5yU
         l4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145762; x=1703750562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObjpKKsnJKpmQ7Ch+WEC9pMBWTA+P86GBMNxJkiSckk=;
        b=HM78ncExLVN74jF6WWdR8jyECR4Yi2ouuOiLmkK5VQ/XdKUgREq9Qg74TSlqvAOmSi
         Nwz7IIuv0f+taJGJ4QxDSAt/QuYWXnOMPwAp/Dlr246fOnkq8W9zdDNiHA7UfBwOUUAS
         rwj7ALNWXZFOpHqD07GJrM11TLHtRVygnx6WuzG5XW7g0LqzNv78IExIak6XB05Y6KUF
         QuAtwb6eoix6c5xTzmm1SVxnJsnOBldi7VcanRQbGmTRpwJjasaTzOuDVnkPPZl9eKtG
         ++deRjdZRx8AC3x+jnMQPm4UhT9IOf5W7Btp+ZdvVvp7z2p+FS1D3EyPIBKptphPGPYv
         fxUQ==
X-Gm-Message-State: AOJu0YwLwOrBI0WDN08yoM3AWO+3ptmWWBmjaGUQ1cRnbvkO56vBIZDK
	Oo2IKUGZa6QvBHDy4Tf8YD0Hwg==
X-Google-Smtp-Source: AGHT+IEqMfiWsAZ/aXh8TsZOzhL3WmvGzT96BvH8AOFV/i1xh8v3UXcfoo6Q3/kv/IYeiVs1inqYYg==
X-Received: by 2002:a17:906:589:b0:a1d:bef8:ce9d with SMTP id 9-20020a170906058900b00a1dbef8ce9dmr10138163ejn.81.1703145761696;
        Thu, 21 Dec 2023 00:02:41 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id zx13-20020a170907348d00b00a26881eeda6sm662421ejb.99.2023.12.21.00.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:02:41 -0800 (PST)
Message-ID: <5397da38-80e9-4e75-806d-0b92b2b5d475@linaro.org>
Date: Thu, 21 Dec 2023 09:02:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: MAINTAINERS: add status for IRQ helpers
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20231218102845.41875-1-krzysztof.kozlowski@linaro.org>
 <cbc4247c-323b-4f4e-8963-fcad7da9528e@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cbc4247c-323b-4f4e-8963-fcad7da9528e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 07:17, Matti Vaittinen wrote:
> Hi Krzysztof,
> 
> On 12/18/23 12:28, Krzysztof Kozlowski wrote:
>> Each maintainer entry should have a status field:
>>
>>    $ ./scripts/get_maintainer.pl --self-test=sections
>>    ./MAINTAINERS:23368: warning: section without status
>>
>> Fixes: d55444adedae ("MAINTAINERS: Add reviewer for regulator irq_helpers")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 30322190a72f..6fd22db830f5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23367,6 +23367,7 @@ K:	regulator_get_optional
>>   
>>   VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
>>   R:	Matti Vaittinen <mazziesaccount@gmail.com>
>> +S:	Maintained
> 
> Isn't that a bit odd seeing the M: - entry is missing as well?
> 
> This entry falls under the drivers/regulator, and as such, is maintained 
> by Mark (and the "umbrella" entry VOLTAGE AND CURRENT REGULATOR 
> FRAMEWORK has all needed bits and pieces, like the M: and S:).
> 
> I think the current MAINTAINERS entries reflect the reality. Mark (and 
> Liam) are THE regulator guy(s). I am just doing bits and pieces here and 
> there, like reviewing the changes to these helpers.

And your piece needs S: to explain whether you do odd fixes, maintaining
or supporting. Although I understand questioning this with only R:, but
I would argue that it still applies - reviewing odd fixes, reviewing
unpaid or paid.

> 
> I guess that from a technical POV duplicating the S: and M: here is a 
> bit pointless, and as all duplicates, adds overhead when changes are done.

M: is optional, anyway the M: field from regulators count, but status
can be different than from the parent.

> I am happy with the existing entries, but seems like everyone else is 
> not. Still, having S: without M: can be a source of confusion. If S: is 
> required, maybe add Mark as M: here as well. (Or if this is not Ok with 
> Mark, switch my R to M - which in my opinion is still a bit pointless as 
> the changes to drivers/regulator/irq_helpers.c will flow through Mark's 
> hands in any case :] )
> 
Best regards,
Krzysztof


