Return-Path: <linux-kernel+bounces-129359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1689696B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DE21F2C6F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77774430;
	Wed,  3 Apr 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtvMuu1q"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33A70CDF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133971; cv=none; b=hbNA2pWgs1bBliIcYo6ZvTUf7USgCvvnKTpQFYe8GFIVYocU6cIneYrkx5LVQWKkd8YgPknca7oIfxzcQVrIDc+Kc+iHRFKBGKh87KGEnqWWhfOdXOmvbWzoYc9DaXykT2fUsrNTg9RlojPhF+Fi3br3ZL29ORjQgChuqEEbt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133971; c=relaxed/simple;
	bh=uALJs2fW5aCmUwKExr5plMae4PhdqTYTzXwAOBEagq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW9gDSj+/52GDDrY8wbmLnn/NZvvwTkmtHNxlpzr3qPcOqKIyyjdJGwucF3e4Asw1bduLtY8OxXp2BEIsMKOa55fneFBM57wdmZLI4vDOi7fiKGZjffp8eCeltVhOiPcmFIo2s91bAO7pce/5gojQZTpr7J0wDe30rs1Kx/kBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtvMuu1q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51381021af1so8466936e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712133967; x=1712738767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WzpyWD37GIueedXS91b6H3un1NtFZn6PufsmH3W5E98=;
        b=gtvMuu1qJsyAqG5PeAxHzQSJL8tBnsWLaFXIeyonX+4omD+SkPzt69z3ePezZiVSUj
         tTMSSDNaghscKNL6e8q6FR6PDTAaRFBx0lj5ZrhVbEeAiAW3Kv5x264UWEbSXhh6DqCL
         m39wgXFHThoKPclxt5LE/7+Q6tEGC4b/LopOYHw2SAiRMAFVlK0hBLL4OFmAmb0ASZW3
         RRO5LDXEg0icMZgCFxLHsKUiCvKpEXF9D89o4bFl88tZTlNgUVL5IwtBPAoARwpcAWYz
         +Vd/v1kLWQmWDI/etjBF6nuQazg/4HYt2cCSiHOxPfvPAF7occTnL0+ESr/bgivPuyqZ
         +4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133967; x=1712738767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzpyWD37GIueedXS91b6H3un1NtFZn6PufsmH3W5E98=;
        b=gv0HVhCQoBf7Y8v+n/rzD7vR3LQjvAPHtgTLurGyg+s4YXQqj2cCCWyEsWUz3dogXt
         KGIFpaCS7Fmr9dt6OmJYzNSscLeRU7X80AD2OPqm+w9NQV4zf3iWHoE0YAFHGa6yWOye
         DAvo4J2GOEUElhA+NpnC/6h5xC4qk1X2PQixl0lYbFdBlDhkaWg6iZ7NWE7M0fDxb0i4
         JN1NPGlTdTXFLRnRxpmDDAa9ripiBV1+WTiTX11c94VYMbtFdn0hU5glnAq1e0BzwAAO
         32jDYwYzHFsodGTSDh4UQfCt7SzHcukSbfWdk1s5fPRPKXufD6WC57VmnbKPW6RrDrk0
         RP4w==
X-Forwarded-Encrypted: i=1; AJvYcCUf5DWe4lJMliOucCUmGT95kNO3Qm6hFu+kR1GuwhaoMvdD+MYRvEwVotOpjokkdyFS1eMu1+kD7B7dBobYNU5kONAEyLJDJA3yTKq+
X-Gm-Message-State: AOJu0YxttSypc8v5qRxz6WIvtPWMQye0M+N+1VG1ewLgHU8pLOJ0jOwJ
	Qo7NnzbrkRl4n9S1thAJBx0nzDAI+nA5KfpNtWLSvorUDNhfNmIkUz/tajNLBkg=
X-Google-Smtp-Source: AGHT+IHHRrHC9q6+MILcKCm6lmtVLyW7n0+jKwCHWkoIFn72x5mKqh6egGchEYhlqDfms40Zpm881w==
X-Received: by 2002:ac2:4e11:0:b0:516:9792:773c with SMTP id e17-20020ac24e11000000b005169792773cmr4060635lfr.48.1712133967488;
        Wed, 03 Apr 2024 01:46:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906d11600b00a46f95f5849sm7484833ejz.106.2024.04.03.01.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:46:07 -0700 (PDT)
Message-ID: <17a700a7-44f0-4e46-9a0c-4c2da44c9e27@linaro.org>
Date: Wed, 3 Apr 2024 10:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
To: Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>,
 Ike Panhc <ike.pan@canonical.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1712063200.git.soyer@irl.hu>
 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
 <39acb3b9-a69f-4654-9749-a9af42fea39e@redhat.com>
 <368e9817-0000-4f69-9f09-568827466121@linaro.org>
 <4956933c-49c4-49ab-a91a-7e0efcc211d5@redhat.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4956933c-49c4-49ab-a91a-7e0efcc211d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 10:39, Hans de Goede wrote:
>>>
>>> must have a dts user before being approved too ? Since
>>> that file is included from include/dt-bindings/input/input.h ?
>>
>> Wait, that's UAPI :) and we just share the constants. That's kind of
>> special case, but I get what you mean.
>>
>>>
>>> TL;DR: not only is this patch fine, this is actually
>>> the correct place to add such a define according to
>>> the docs in Documentation/leds/leds-class.rst :
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks. Is it ok for me to merge this through the pdx86
> tree (once I've reviewed the other 2 patches) ?

You need to sync (ack) with LED folks, because by default this should go
via LED subsystem.

Best regards,
Krzysztof


