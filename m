Return-Path: <linux-kernel+bounces-7885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD081AEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4670285E26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436CD518;
	Thu, 21 Dec 2023 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANBzocPk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D87D2E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso591987e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703139438; x=1703744238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3X+yEQki9wQULswcB5/Ac1SroQLxYXRuj/wXSptI+EA=;
        b=ANBzocPk7FzConvWCiBP6C7Zic0rSuOAqRS/hYaxaAHSLNBP+2j9pytKcXC5pCBT7Q
         78BlJa5wcQaRIPPd3av6+KzfAwWSl9YA2qilfVsVg6X683mXBxi1z9UCKujnIwH0zh3D
         n3YJ50+hjPffZJsAug+ZBuuXJhogkCko3eA2QOnbedT7iHcEdWy/C1qxejnjf7ksocFZ
         2wh4CLYrREgXqavC6H4aLSTJv+uzwvdIaMcNWzb9ietL9cRpOVC9knr9gZ8V4YK4+jjH
         /x5ANRhg532AFltED7OGRsX4HaGaEfyFVn6BmU0lIyzuLt5QQcND2eiIEPkjkifMFRVz
         +HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703139438; x=1703744238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3X+yEQki9wQULswcB5/Ac1SroQLxYXRuj/wXSptI+EA=;
        b=Fb35y1J434knosco+RubwW9euzoq3CWqqL10J+f+BlEPNZtVFYbyaZZzuZ136zr5Fy
         fphGJ/XyHv9KDM7EO9m/LdCh71HxjQhIoQdjWETlvDQ+lBu1ChQIGvNDbg2e3TsYMByC
         qLw9n2tkwjldB5OfK+z7ZtWdRcpbIDX3VSy0eHgr66Aasu/vussahsZx+XfHA1u8JTR/
         NQo3P40cgzJeFqKdwGt6oSfxEHm2U++Yoro+qNCgrq2Ga7YTqDJwEAjdhScrsFs3vWeI
         21cSGRgdjiLKRlmeRpwquItK42sjsmSr7CiXELHgaWK7zSVQI0awuIWS1tyHTmoZ7uDR
         pKGw==
X-Gm-Message-State: AOJu0YxMIG3vsndmOPPZhafQzRVIUeyn87wwvOSyQAaYYhDOc4KyGacr
	Sfo5qnMcSHHJJTzuHx4yh6IIImlJMJU=
X-Google-Smtp-Source: AGHT+IFkOGjSb/LtEC9xzmquiUlRLQTiNPJpdKq2y/OURu37PLQxTm8hEE3J/6NK7w2kHlNbwdCJnQ==
X-Received: by 2002:a05:6512:239a:b0:50e:4ec6:ed15 with SMTP id c26-20020a056512239a00b0050e4ec6ed15mr1889042lfv.107.1703139438236;
        Wed, 20 Dec 2023 22:17:18 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id q28-20020ac246fc000000b0050be9c8b108sm177666lfo.60.2023.12.20.22.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 22:17:17 -0800 (PST)
Message-ID: <cbc4247c-323b-4f4e-8963-fcad7da9528e@gmail.com>
Date: Thu, 21 Dec 2023 08:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: MAINTAINERS: add status for IRQ helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20231218102845.41875-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231218102845.41875-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 12/18/23 12:28, Krzysztof Kozlowski wrote:
> Each maintainer entry should have a status field:
> 
>    $ ./scripts/get_maintainer.pl --self-test=sections
>    ./MAINTAINERS:23368: warning: section without status
> 
> Fixes: d55444adedae ("MAINTAINERS: Add reviewer for regulator irq_helpers")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30322190a72f..6fd22db830f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23367,6 +23367,7 @@ K:	regulator_get_optional
>   
>   VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
>   R:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Maintained

Isn't that a bit odd seeing the M: - entry is missing as well?

This entry falls under the drivers/regulator, and as such, is maintained 
by Mark (and the "umbrella" entry VOLTAGE AND CURRENT REGULATOR 
FRAMEWORK has all needed bits and pieces, like the M: and S:).

I think the current MAINTAINERS entries reflect the reality. Mark (and 
Liam) are THE regulator guy(s). I am just doing bits and pieces here and 
there, like reviewing the changes to these helpers.

I guess that from a technical POV duplicating the S: and M: here is a 
bit pointless, and as all duplicates, adds overhead when changes are done.

I am happy with the existing entries, but seems like everyone else is 
not. Still, having S: without M: can be a source of confusion. If S: is 
required, maybe add Mark as M: here as well. (Or if this is not Ok with 
Mark, switch my R to M - which in my opinion is still a bit pointless as 
the changes to drivers/regulator/irq_helpers.c will flow through Mark's 
hands in any case :] )

>   F:	drivers/regulator/irq_helpers.c
>   
>   VRF


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


