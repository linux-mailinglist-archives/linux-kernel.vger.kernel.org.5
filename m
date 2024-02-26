Return-Path: <linux-kernel+bounces-80682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2906866B27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61771C223E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63364249EE;
	Mon, 26 Feb 2024 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U129Lutg"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7C20DD3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933114; cv=none; b=dwO4Ht/G5IGG83jIDJVEUjjRbQsY2Y42Xtk/RZh23Lv+B3Kecp3xVvRNEjsI4oMUytTxuAXnysCVUD/7ew4Jnp3oBx7Av3PyUf1l7HoXkWrWvdntGrxNhOYwotG2QTMkPb1uAi7vqSH12+cqc7HIMbFUiqRmxG5q35C8Ll83dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933114; c=relaxed/simple;
	bh=+NYXiToGv6Bw5ipxy6JHiAvqvCchBBV1B9pFU08SOFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IX9MmnDszK2mFVtgviTghTVd1udYZvImJUxICPqZ1+2FdMCRwT3EINCTqY88a5h5j6Cuhe/wK3m9IJi3UzELpIiJuxvseeWdW0xN0mzI54T0/5h6umYoiIDrFGuTjvDqSUFxrZeRHVDUe9HtLFopDcdo0WDT1byxIy9xfui0JPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U129Lutg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so706164a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708933111; x=1709537911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhl8D1trvmYSomiJ2vy2c18xLRQl5neLGIl58WAU5a8=;
        b=U129LutgN3V5IgRggPSDQCeUzIfTLzBhyEoBnRGCnJcKeLIehzNMKRP8XIgowV8dM0
         uRxJextY/rJHq6SBsPRfkwZTVi3COejALzTL59XnkJ5c6LBE0f78gEhZtDRDmqPV2xnX
         /3vA24ew211JUs1vl7j384jC85YUm1bZPJnBL1ptrmtzFqYTYTsEw1xJ+H0q460FrgfY
         00a8ricSiI7D+1FPPwAXqAWTQTUFaf1MivVCo/jz44/SUsVpUlfoiI+NbFaj68s1Lvpw
         AlvPU/h20L+uwCZH9JlbiA2midLOePd/EDxySoyDRLSLHXLhS35bBxCOJDyOH4MCl0lP
         ZIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933111; x=1709537911;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhl8D1trvmYSomiJ2vy2c18xLRQl5neLGIl58WAU5a8=;
        b=a8/MDRaNnvF1IOwoPmAvr7UPCnIVFdssVhDN7YJwwDXViO2SP6DW6oeoGnUaDFe07z
         dgEPMRB4Eiu2OHbDB9V+e/4ycVxj8OjhQHRJEVCPDMCFGHY3xddBF0p+m3cEDwzdKmFD
         N6QR9NAw18VA1wUgDRA3RRW82BlQATzH3w8jWmxS43+QavT955DPpUTWvTKGJLyNxijG
         BdYLg3GxyAgzoA8Jxz4poaL+hktyJWfcLhqpPwJ4LE9U4o7gE4oTHRCgUh1X8cBw+Hxy
         fzz2C/sKfqlDppUOqiIVQse4Zy3s/QltxzxpHwQfEM2kZVoePbsAJZBopWUiMswNR2To
         yMuw==
X-Forwarded-Encrypted: i=1; AJvYcCWtcy/t/iZ9jToKImFJx+9CbWcOQfU+rsHc0hgdv6PUqHALbBi9QtrCLN/z27b2oehtFJVqIwWlLu3T9LTQX/sLr48yBhxv0rWPd5JI
X-Gm-Message-State: AOJu0Yxw3lKXBbi9P9bVo9G1ezEAbD4V6YS4NB9O0lXMuRpNEcCIEI4Z
	242CmeGGpUdEnAWY6fm+AeuLUHgzEly000SXUKhHv8XSleibQ1DzPnSZODyyy3s=
X-Google-Smtp-Source: AGHT+IEIET3+k3JIWIosASTG2pQOTXA4W1e+XHd5iJ+6CG1WBhOYkYClZPLIBBcXL0cYCpN5iLhsNQ==
X-Received: by 2002:a05:6402:5246:b0:565:e282:33d8 with SMTP id t6-20020a056402524600b00565e28233d8mr2174754edd.38.1708933111003;
        Sun, 25 Feb 2024 23:38:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00563f8233ba8sm2070682edq.7.2024.02.25.23.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:38:30 -0800 (PST)
Message-ID: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
Date: Mon, 26 Feb 2024 08:38:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: leds: leds-qcom-lpg: Add support for
 PMI8950 PWM
Content-Language: en-US
To: Gianluca Boiano <morf3089@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240224224951.1357644-1-morf3089@gmail.com>
 <20240224224951.1357644-2-morf3089@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240224224951.1357644-2-morf3089@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2024 23:49, Gianluca Boiano wrote:
> Update leds-qcom-lpg binding to support PMI8950 PWM.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> index 6649ca2ec805..ea617fad5a4e 100644
> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,pm8994-lpg
>            - qcom,pmc8180c-lpg
>            - qcom,pmi632-lpg
> +          - qcom,pmi8950-pwm

You will need to update the if: as well. Last commit Anjelique Melendez
made there a bit of a mess... Please rebase on top of:
https://lore.kernel.org/linux-devicetree/20240226073713.19045-1-krzysztof.kozlowski@linaro.org/T/#t

Best regards,
Krzysztof


