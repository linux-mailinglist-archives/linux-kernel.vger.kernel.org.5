Return-Path: <linux-kernel+bounces-61198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530D850ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0851F21D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B3EAEA;
	Mon, 12 Feb 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCDo7fGA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709010795
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726259; cv=none; b=o+tT4/3141YBHDgQ0sJOqqtFynwBC/e+XNh5adb5ooA+rLpGrNi2FWPNLWtvj7g7KBh59CMTQUowfwnVOyyWQ1vx/26aXtdQRTb+sQZGmEk84AI/LrkkGpPf+q2h/3JO9gtoLQZXC69eSt39XCyS13RA+iftlcTZdR9ff9ys9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726259; c=relaxed/simple;
	bh=B3JZ8sfEo1g9KGP5ohvz7I1oTFg2zjlwuIUwHwKVAD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjp5zIk14JfzsqewC/ZuGhO8u8uNLQhshoDvcODP+/sXTLXIhilc1OkUstzEd9TC3Cf0uICG7nU01dIcKchA15ZtzM1OI33dvhIySdY0vuvvRtO1PQRakf7ZQ6rfa2Vlx+8pRooUFuH4OMzK3GHLV2/7dpW4VI7lySPhxAw+750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCDo7fGA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410deab9c56so2800065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707726256; x=1708331056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71TZcwc3zcuxniF5HfPgZF9RSNBzlNO8/T0z3a6pOIw=;
        b=oCDo7fGANNelJE1ILQrK2yAaUhgxrOzjL/Rq1qe8RHfIgSDn7WbbLV3dyOsj7Yzskh
         NVNOXE7UerC2A809UOHRg8evUe8c68PEHuMVNZ6v4tCSo4Y8etbK6GT1ci7jV5OWtIFC
         CqYkV6I11iWEfxLvkBZTehB72sVBw9rQhkN0dOkJ04XSzmvLtOiK3SuGdmbSbU3Le85T
         xGHn+/rnbwhGGFvx8z8cM85Q47DoVGp90OHK49HMgEcrytyo1R7ib8DuPf0+GhXeU16a
         SOY5u8h4cYAa52AgRisOP4j+m5G8tbG1oBQ/PH1K/eU8q+D5o95d0u4RzFOpw0tWSiWP
         a68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707726256; x=1708331056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71TZcwc3zcuxniF5HfPgZF9RSNBzlNO8/T0z3a6pOIw=;
        b=e1fPKRIvY8O+NYhHqB/Wp3b5WSU7aG96k7gvNEWSrv/mVt5upLiV4Gq9fZtXoRLZZE
         lE6jNH7/4NmyfSUVUQjl/zrO+EPHpA3NQjKOg4qbp753hZxskjL9isKUdcYP6mo3SCEy
         hS8xLJpneJUYv7nPeyvlJd4G8a7snStVCRiDy+qXmA/deBzXttYc4lZG6HeKZNijWklU
         oKK4eqounx3WUa6JjaP8ddZAE5G3hWQmLZJv36yIftA981Iee98Na6uA2SMaKlcrkAEY
         EUTq1udpEgm1WAKzeu4pQhHYgTBo7PSC+nDUl1vDkzHxoi/XlgvLzsiAMhEL/EwBLGri
         1l2Q==
X-Gm-Message-State: AOJu0YwLucmawx/3PJNvOoqPfnuVY/wrk29Jk5X8Qz0U2uU67vQo2/iC
	Q4aJFoskKROuAB52/2LK07Id1LbgxSrJfTruU1sCXNpI6t1rlVFCeDOcOg/ydas=
X-Google-Smtp-Source: AGHT+IHfyQwoCCZ2EP+SczAqdNuaJSXbTgzFnyUPfuOE/fetglvk9n82fIA7Dw6Rbn67vXviNgxu3Q==
X-Received: by 2002:a05:600c:4511:b0:410:c69f:4db7 with SMTP id t17-20020a05600c451100b00410c69f4db7mr2171281wmo.20.1707726255795;
        Mon, 12 Feb 2024 00:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqZG9F60Qxwc53IuhcAltsgH3HKrVxAOUNf7WTbp7UPPUyPHCTX/txAUjkb+4hR2zzENrZy2bpM+ilvEPrhLlIu5i+P8XW/VctY/f2lhTFpjEeAD13lqxVbt32nsDDQutytyDB3blucm3vOX2rCrtmVPzTBGY4QukII8cGE72TrG4vucARckIeGNOuGvMjsSziiYF9fVa2jzU9dLfEvUt0SjQakrJUo1nL3JMS8eHmPVI9Fkpqi08d4ooPJBoJhzIL8ePN6F2EECokip5QUHF4yK1TkMc5PlwE9ZO1cAFJY0n6CF1SjYhYSks=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5229000000b0033ae7d768b2sm6057589wra.117.2024.02.12.00.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:24:15 -0800 (PST)
Message-ID: <5bc98b2c-9200-4ddf-83bb-67d10d5a0fc6@linaro.org>
Date: Mon, 12 Feb 2024 09:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
 <20240208184919.2224986-15-andriy.shevchenko@linux.intel.com>
 <55b4a973-653c-4798-81ec-198f204a09e1@linaro.org>
 <ZcYvqW9Q1OI3AK4g@smile.fi.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcYvqW9Q1OI3AK4g@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 14:59, Andy Shevchenko wrote:
> On Fri, Feb 09, 2024 at 09:02:44AM +0100, Krzysztof Kozlowski wrote:
>> On 08/02/2024 19:48, Andy Shevchenko wrote:
>>> Add initial device tree documentation for Maxim MAX6958/6959.
> 
> ...
> 
>> Please describe the device, e.g. bus/interface.
> 
> OK.
> 
> ...
> 
>>> +properties:
>>> +  compatible:
>>> +    const: maxim,max6959
>>
>> Your title said also max6958, so I would expect it to be here as well.
>> Cam be followed by 6959 fallback compatible, if they are compatible.
> 
> Same question as I asked before, why should we have them separated?
> The hardware features can be autodetected. What's the reason for (unneeded
> in my opinion and duplicative) compatible?

And which part of device description in the binding, or at least commit
msg but better description, explained it?

For every unexplained deviation from common rules - and documenting
compatibles is explicitly asked in writing bindings document - you will
get questions from reviewers...

Please add this information to description.

> 
> ...
> 
>>> +  reg:
>>> +    maxItems: 1
>>
>> No power supplies? No reset pins?
> 
> No power supplies, no reset pins. At least there is no as such in
> the datasheet. Do you see them there?

How do I know? I don't have datasheets and I don't have really time to
investigate each datasheet of every device people send bindings for.
Several people make mistakes of not putting such stuff because "driver
does not need it", so how can I know that here it was not the case?

> 
> ...
> 
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +            #address-cells = <1>;
>>
>> Use 4 spaces for example indentation. 2 is also fine.
> 
> Sure. Btw, this is copy&pasted from the existing YAML. Are you going to
> fix them?

I fixed several of them. At some point I might fix all of them, but
that's lower priority. I wished I have all the time for this :)

> 
>>> +            #size-cells = <0>;
>>> +
>>> +            max6959: max6959@38 {
>>
>> Node names should be generic. See also an explanation and list of
> 
> (Same remark: it's a pattern from the existing code. Are you going to fix
>  that?)
> 

Same answer.

Best regards,
Krzysztof


