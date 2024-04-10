Return-Path: <linux-kernel+bounces-138119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E570189ECD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C202283C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B613D2AA;
	Wed, 10 Apr 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaeV3UOY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4B13D26E;
	Wed, 10 Apr 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735833; cv=none; b=SN5TNyru/QN+4DIcJfGJVr1mIt+kqd0wNPkkRqptSvQXZh7juJ7jQBhbg8laUInUHByd1sOwUVPh8fzx3s1UzTHDvXiljExYszMeiERXbK9s37FV3lcN+T3uNDfJZZlp6FrhQUvKodhc964GIW9uuZQdLJxoVOPZLr3wJuYioBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735833; c=relaxed/simple;
	bh=N8vrAP5uFQOixMvkqZwjkipHkwliYmWjkU6FwbXfrGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oRHWWQ9bBZs+a38JjX3TUMaag7nE698uov+El3xcwBmzbGhDifuuVdLtt+G154Olp1fa//hY0dw5yZfnfbieNDVQAm/YYHlFF/G4PB7d+RJC98Hb9Pc/Bp10M3vSwnBODaFMbVvneyvCCiNMNF/1/h3JWrPZFjzp3YwRjqPrxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaeV3UOY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d04fc04bso9926964e87.2;
        Wed, 10 Apr 2024 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712735830; x=1713340630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLwE5KUr5O6m0SoJrIs5Ku904XnsinbX3SC9qeup24Q=;
        b=kaeV3UOY1bJtIR0750dqY2KbZ66jt+jr7nm2sRw6dOtwqfygTpZyLhW7XtuMkkBhYj
         NZNCsp9D49ffMeIBw2fyGaSNnwBs+yi/9Ft1AUpHqOFEOzPVwYBlOrO4P3vRqZCOXEwN
         aFsR0/bqZ2Hg6uFJP3pZnHia2C65vPg4As044DJNs2Y/d9YYH+JZIveraIqB0Xqo6gGe
         NsfYLXtgvQ2t6OvRyQjRdWsD3vqufI97NS7CQYtOuqadBnoGoWLLJa1WPlVCkwloDvoz
         Q1RkGbif+eFeqrosF1zkOhJqXe0/zEgS0CCp4kq2sAia8bIGjCxRJjcZZGuvxyHNpWsV
         +7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735830; x=1713340630;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLwE5KUr5O6m0SoJrIs5Ku904XnsinbX3SC9qeup24Q=;
        b=WTnQK8cVB30Uj6jqxyMZ/aDErImNiP67Plcjs6wGQCINgNqdDVbNCZR6Oh7t42ndRu
         huiyN9m22a8lCx9xru4pDSfFKqz67P/HOqbTWGloy2kDwVWUCOYRKMJFjiKwkmQ4Ypg1
         aSjvFgET2OSrDQmuYIReWZ2A0rX5CVnAxAWfbL2YAiXsrAyvyQUxroDM+CU+QpvuFCef
         T1Yk+lH6FOTCG8ehL1xO2JUIyKqX7AqYQNy2UpdhBQWg2lwzRBKEQeULLWP2uAt7tx2q
         BKsRXvHi+qSfWE9F+yaU1x3e2rD2/AwNBbljuDz+F0IdN8DMUvIoz1kXrctBcQMaKbFT
         bl6g==
X-Forwarded-Encrypted: i=1; AJvYcCVIObGWNXMJe/wGNKNg/pn+uwknVyCsaToKfh/4zsRFg19jj6S7SOkoPXeAVPsFfsAoEwxOFEDXe78eWXUTTflV4FjyoEoDdNwofR62p4oAVWgQa9W6QSqQfqEK1UHdkjSKwWbaKGT30Q==
X-Gm-Message-State: AOJu0YztGt/F3VyN3d8AmADgny1V2NFLwdzAXmAm7yHN1CRfsnNExG0A
	dqNDxTOa+nOCWXW+Rib4P24lYBrZGDtEcdvto7N+azhcQ/TR6fVp
X-Google-Smtp-Source: AGHT+IFyDZF1Bpt3awxQX1aOPYdX18UGVvC4teyJcPtJCZVsBciUu8dC7lhcnyap2ZII4AGmyuWEhg==
X-Received: by 2002:a19:9114:0:b0:516:a686:8ae1 with SMTP id t20-20020a199114000000b00516a6868ae1mr1228867lfd.62.1712735830172;
        Wed, 10 Apr 2024 00:57:10 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x20-20020ac24894000000b00516a01d2f44sm1760191lfc.240.2024.04.10.00.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:57:09 -0700 (PDT)
Message-ID: <3d5df067-ec94-42c6-bbd0-43ce8cd53e40@gmail.com>
Date: Wed, 10 Apr 2024 10:57:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71879
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404195423.666446-1-andreas@kemnade.info>
 <20240404195423.666446-2-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240404195423.666446-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 22:54, Andreas Kemnade wrote:
> As this chip was seen in several devices in the wild, add it.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index 0b62f854bf6b..07f99738fcf6 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -17,7 +17,12 @@ description: |
>   
>   properties:
>     compatible:
> -    const: rohm,bd71828
> +    oneOf:
> +      - const: rohm,bd71828
> +
> +      - items:
> +          - const: rohm,bd71879
> +          - const: rohm,bd71828
>   
>     reg:
>       description:

Am I correct, this reads as:

Either
	compatible = rohm,bd71828
or
	compatible = rohm,bd71879, rohm,bd71828

but not compatible = rohm,bd71879?

If so, this looks ok to me. :)
	

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


