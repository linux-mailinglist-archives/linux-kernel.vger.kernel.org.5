Return-Path: <linux-kernel+bounces-131079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8A8982CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BD6282CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5386E611;
	Thu,  4 Apr 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hi1rzrOp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C56D1B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217894; cv=none; b=J9ePVh/jfcd59hObEd4pW1IqjsmeENCN+DDOwvRcrjOLjOXXq0qZKrrhL6KhWkLB6FeJnCAGBkb4gD3jM20gMTU9OvR5nLxxAh5dJvQMBSbRbde34vWSZDezqr6Xdw1E5cuZH/tlCaWLcSAEGOEMkq7741vXbxSwf45cRF6Icog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217894; c=relaxed/simple;
	bh=KNYxvFJYXoWRu/+uOkrbBRzvRbbI6L12DQyHCnufcB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8Nf89CWcVu/HEverbCIF8hrfkGsN2X9eZt4LKTlvRaIe9G28x/ShsXRwWXQrJiMgx+0pNRzOU7Ra1d/HyG1DcmUVRWCj7jpiXRbGeSRN+uhwrVsZa1syF8KaBDEmDq1+ZSg/MeYWgGDcyzWFrnZ3lbgZPb0QkUOsu6WQ9F4A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hi1rzrOp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a472f8c6a55so92896966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712217891; x=1712822691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wcaH9vepF+Ltu58WkYmkLPVSGIlRNFXKUIujqsaErZY=;
        b=Hi1rzrOpqjwOIvG9MZF7KpdMNlUY+rMgbBX2julzkzbIZWbDIYHlVL+BHDnjOSOslo
         sw3tnebdglVpRyVSUOAleeiupzMO/xMYXar7hAfOOUdjHAuXpl7WmAq+nVCBK+MLSH8Y
         tk8nVo3W3QsAmD5Kb4lsWcNsXm38NVrtjuP3KCZCsPxg1WqR21kdkliD9cfT72c/pKhU
         lAbmAOrFhfDndDXVQWoAuce3CVmviSpfu6rlbLdIV8GoxwaXQlCTRKABJo8eoXnTyHQQ
         68n8fUC0eC6RdMp7L9844dpGqR4hvWTCOWbQ64pTw/c4+uDW8x1ZOntn+uKcGVQyy0dp
         0CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712217891; x=1712822691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcaH9vepF+Ltu58WkYmkLPVSGIlRNFXKUIujqsaErZY=;
        b=LU/JB2dShITTwUWu7ybtqO3UMR3Tymku6TdkSBIGPReCE0R8cTl0zWJEDRurk1Xa+e
         3WfAl5YXfdqblKspd7Mgg1NYe7JjXkr8CaP5CNHEgdaGeGvt0vzDjnF5bqVbzMUiEDV6
         ml114ccEh59o4XV985KEW95rmjB18hbfmvYZS1kwdJV+u5BZys85XajrsXvSxsyXzOCW
         koot54m7j2GmMFpBMhGGxlr8mij/gaKYRWxF2Icjqnh1wfPAu3A+eu+siDVt4zWqBURq
         GccUdq0LE+Mo2dSniBvw2NAmQKs+e6fjagQjSAG1IJjAzemGh9/RQhSmNqwlucHrzRvZ
         UhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgTDM8yxvnziG5UHMoDacd4/KVx7hp33pXeEBQg5gWm7AG6L5SszuDsRWUYK5hJLrhWIYNneDe/EBvRng2VeznMJTDlhaiLehmrhHF
X-Gm-Message-State: AOJu0YzW7CcNJWuGZYY+pl7r6IqHK/gs6elBudZNfVpH8Tz5MT1XRFKd
	BIKJ+ezuJQ0vd6UN6t2HMjOUIc8NXq4S7x3HdPKXMgSM18XKk3MwSY0qVKYNSDE=
X-Google-Smtp-Source: AGHT+IGdGll2OVTQrzOUNpFtKjGnITOkrIL9R6rmlNbWzUhTVNFEVGiGh39Cy3aAnYwpV9PwqbUrxw==
X-Received: by 2002:a17:906:349b:b0:a4e:8b31:1f43 with SMTP id g27-20020a170906349b00b00a4e8b311f43mr1042574ejb.14.1712217891302;
        Thu, 04 Apr 2024 01:04:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a4e5866448bsm5727745ejd.155.2024.04.04.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 01:04:50 -0700 (PDT)
Message-ID: <e44e6138-6da7-4242-8831-dc80c40826f6@linaro.org>
Date: Thu, 4 Apr 2024 10:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] usb: dwc3: exynos: Use
 devm_regulator_bulk_get_enable() helper function
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-6-linux.amoon@gmail.com>
 <d6d5f6d4-1d34-4d42-9afc-822a014063dd@linaro.org>
 <CANAwSgSe37Pn062enCLd39P+RXU1VCZugyz7oDRafpnU1FyN1w@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CANAwSgSe37Pn062enCLd39P+RXU1VCZugyz7oDRafpnU1FyN1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 09:38, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Thu, 4 Apr 2024 at 12:53, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/04/2024 09:13, Anand Moon wrote:
>>> Use devm_regulator_bulk_get_enable() instead of open coded
>>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
>>
>> I fail to see how did you replace open-coded suspend/resume paths.
>>
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> V2: no changes, did not find any regression in pm suspend/resume.
>>
>> No, that's not equivalent code. No explanation in commit msg.
>>
>> You already got comments on this and nothing improved. You just entirely
>> ignored received comments. That's not how it works.
>>
>> I don't think you understand the code and Linux driver model. This patch
>> repeats several previous attempts with similar issues: no logic behind a
>> change.
>>
>> NAK.
> 
> devm_regulator_get_enable and devm_regulator_bulk_get_enable
> both remove the dependency from the driver to handle the regulator_enabled
> and regulator_disabled. ie this removes the regulator from the driver structure.

Not true. Please do not paste some generic knowledge and assume reviewer
knows it. Instead provide proof.

> 
> Since these functions set devm_add_action to disable the regulator when the
> resource is not used.
> 
>      ret = devm_add_action(dev, devm_regulator_bulk_disable, devres);
>      if (!ret)
>                return 0;

Listen, you already got comments on this at v1. Address previous
comments instead of repeating something unrelated. We should not have
the same discussion twice.

Best regards,
Krzysztof


