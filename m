Return-Path: <linux-kernel+bounces-129894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A618971BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779B41C21DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D0148FE1;
	Wed,  3 Apr 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkw66bYO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF685148831
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152556; cv=none; b=Z8khwI2BPtJkRBNorLMAbukfmvGnXs0r40SWAOBPsgn3Wd3pTgcMIBUS/gsd+u2w8qbdxFIxi6Psai6wRlRopPuT34aOrrsL9sSSuL63yR6rMme0kO9ZnJL/azy5NuEZVBNnm4Csl+H2LQ1v4lqrm4ZLk7PlvFJwMpjYlff7nQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152556; c=relaxed/simple;
	bh=7yWRlWMYx4niS5QUoLw79toH4Ih7mDATgLXdfTdbOec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnzSMOBlhC70h1GwiUOtFkO8gjsJ8sqkRFlKE1L6TqUtQ4w8eqoA1pn6rwf20cZDTtgVr6m/a4VwveEa8j359NUI3/75rXGSFdhocRypeOFCGyGjELDwkNB8QIEVYBNWO+LEISADX0nelO4lxRfq19bqy+7r1KrvQheOod468W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkw66bYO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e0e1d162bso341001a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712152553; x=1712757353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IeDVjxJ3sAqTv13/aXHF66O8awP4FQ/ZTnlb/hTWU6s=;
        b=wkw66bYOTRUwo5rMRud8EcAqv2ZiM7emIF2Jbk7Gy6GiaJjy3PS3XkrBmkyCjZ+hWi
         nQL1LobjioK2Wqq8JImtCcv0E+kB2ARXglV6Lu/EvyKi1KngsV9oTcOSCRv7qVTPXCWR
         KUngSEud1kupF9D1RoNqMnGXIRWmBsTpCxadZ/NcmUEqr63Ym+ZnelT4FnMA3/6XdtHa
         NbYwr25ynm4zp1TirO+cdWxOYRSWEPOpp3pOZCbO1ueF2dRx7kG3kbbmLL/DhqlKcD46
         PI+G6mJJ34x+gbwSt4d11oRN4AEamkoOLQm/8wLmz4VOpoI5/AOt+dQQTr4JJdg8fOYO
         vVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152553; x=1712757353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeDVjxJ3sAqTv13/aXHF66O8awP4FQ/ZTnlb/hTWU6s=;
        b=ts60CtaWxTSD0Hiy76CR6368Tqn4NToM4dgHb3A4+qDP/sSrFuhsOUq/2xei91r98a
         be5ncqcV3pQGAX0ve8aUbU0GQm+1awcG8LsKV+ivq8IISkQ1oZY/25oH4Ebw3eILBbIG
         gAAGBd5Smwe9CxUTMg4HUIytTicjnPy2wEsQckTfpOJ3TzEWdpC29/8fNSZjj1/xjiYG
         HDs5essJzmSaIHpxMk9e8zyojyj5SZN2sm3RRs3/12UKR57MUHJOXOKS38ax9Lx28svX
         KiNe1mYjUnFUypyQBadlD5Ym5mPGN2B0fD0OjATArkRPh5bteJ6Jmx/9KwN7zg66zWxu
         sR6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6C7nM7QwddX1eZ/hLGbbXUKGor4P7x9dQiA1Mc1DFhFGrZEC6c5O2oDD9y4aIY34KIE/s102xHPwlOxgO2GUg6W7i34xSmBEOYnRu
X-Gm-Message-State: AOJu0YwZEwqAgTQOhrxDME2QpVW+lBjziUP23TXFRE6AbdO6LFoa73nA
	5/gy/7fQX23yS0bI2KTXIi5arU32DPrSoCGlC5auNfvhaLrzQ6Cu2vyajfHZLBc=
X-Google-Smtp-Source: AGHT+IH9+C9juSmV/GBuPYaqohGOY4cGhVgCt2H6EcxLrUYmesOKvHEB93iuGOIysgmB4m7ArBHZ6w==
X-Received: by 2002:a50:d596:0:b0:566:47ee:b8b4 with SMTP id v22-20020a50d596000000b0056647eeb8b4mr1682778edi.17.1712152553328;
        Wed, 03 Apr 2024 06:55:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s2-20020aa7cb02000000b0056c0d96e099sm7963516edt.89.2024.04.03.06.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:55:52 -0700 (PDT)
Message-ID: <ec9c76dc-81c3-448c-86c3-8b4cb07c89c5@linaro.org>
Date: Wed, 3 Apr 2024 15:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath10k: sdio: simplify module initialization
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
 <f78fa061-3b34-47d2-a40c-bbec744f0f97@quicinc.com>
 <87jzle5zda.fsf@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <87jzle5zda.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 15:50, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 3/29/2024 10:10 AM, Krzysztof Kozlowski wrote:
>>> This driver's initialization functions do not perform any custom code,
>>> except printing messages.  Printing messages on modules
>>> loading/unloading is discouraged because it pollutes the dmesg
>>> regardless whether user actually has this device.  Core kernel code
>>> already gives tools to investigate whether module was loaded or not.
>>>
>>> Drop the printing messages which allows to replace open-coded
>>> module_sdio_driver().
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>>>
>>> ---
>>>
>>> FYI:
>>> I have ongoing patchset touching few lines above this patch chunk
>>> (sdio_driver) which might go via different tree. If that patchset is
>>> applied via different tree, it might result in a trivial conflict, but
>>> there is no dependency. They can go via separate trees (except that
>>> trivial conflict).
>>
>> I'll let Kalle respond if he'll take this through the ath tree vs letting you
>> take it through your tree
> 
> I prefer to avoid conflicts as much as possible. In this patchset I'm
> not anticipating any conflicts with wireless trees, so if we can avoid
> any conflicts, please take this patchset via the other tree:
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> 
> I'll drop this patchset from my queue. But if I should take these to
> wireless trees instead just let me know.

OK, let me squeeze both through sdio, with corrected subjects.

Best regards,
Krzysztof


