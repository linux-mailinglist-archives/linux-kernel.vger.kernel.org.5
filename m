Return-Path: <linux-kernel+bounces-70829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBB859CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B300A282584
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CE208D5;
	Mon, 19 Feb 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLVnJH3g"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C3208CF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327787; cv=none; b=XtvSIVZ7t07xvR8tOE/VdiOK6EYAuPWGtnPD0Yf2xKMWB8W7N2XR9DwvYDtHyGrTPJuGy2Sa5CXqnUJQJAu70X2t722gOczHiTgzQjKjQU/lNfxJMcK7wince3VjlxESeqOvu7UiImsiaDFSl3hqxPCYrIRdznGM+VsIL8gTsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327787; c=relaxed/simple;
	bh=jD6ZT7NtXE92gyDK7I3qiETqpZ4SXekF9xy37uqgKBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9jbZvaR7IJLl2M/yCaa/5+C+TeP6uYJvhMJK6u1VHB/HAv3TcYnNRLYsDzdgX2BSLnATaWYio6v+YV/4MuCJgs2ZSIJVPH3sxguduOcuLI9QDk76ycCG9ZxXJU9FwS6hVMu7pCbxnRvTnu3VlNeMxbpjZja97d89p12MbyKoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLVnJH3g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso19424935e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708327784; x=1708932584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6HgckqjOZjOrTOh+zrkH89puWDcJWpAY231AcFw2yyk=;
        b=YLVnJH3gkjMVpDnoW8ntIGsocqKh7Ropk/ktQB44VO/b5U2ix2DSEizMjkq/PpnV+l
         ekMyYUCwyttRu4pJYUEfp5pByxtt0LH6bXSI6Zzyjrjk8WaZBOE7zGATrfGgoGJpGgCs
         SKF9JYd2hIc6xFFNBVNTVGA8vvTY0BSJawzy0Kds3GzB/oRAeJgq7y03yWgL9T/81gN+
         aw+DJBbIw6afUMBvd08rhLt2D9Ps0ggb19xcNbFGp0fZTEyMP3/6Pfv2G8o0+ptinMck
         iAtMkwWrapE7iK1x/n54dGNdRRXNkU9LbqaPyhiokWIybZ9IgO3+IpRBaQ6xJGmr6B0/
         WlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327784; x=1708932584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HgckqjOZjOrTOh+zrkH89puWDcJWpAY231AcFw2yyk=;
        b=xM0qQSk+tZu1UgWei4Yjma7GOQ+vlqegxsIxkn7Lb4SRbpFOQldF53MW5x6/57yORB
         Qma8zqXBL/HsQCwDXcQyGR7B4XF521GLzjBUbFneew2GEpGYGKo4TdOSivx4Vuc0gc+z
         qf230QHl+d4KVAITAMwV6nzZO2fiXrsaVqr+pUCwl+G/b9MimUTg1Jaov1lC7f4oxlsM
         McPW0vkGoSMW5eAHqxhfCUzrB04GfYkUNDXoUYIityUXhNEi05bXlWpEy/C4oeoe5HXi
         7jy3RCHSsJqM1l69IIErb2Znc7/8RWIkvsNhzx63PYWOc8c+9cpU3a176rHCeei1FLGO
         ARhA==
X-Forwarded-Encrypted: i=1; AJvYcCV3iZMO1KGiMNtngmJkvhXK8ovTMkxWWK00+QGJJq7i9EJv5cp7EAaXKKFtmAjIlKv167DT9jD84Y49Q9PF2zuVC9InoDo6a39I1FJI
X-Gm-Message-State: AOJu0Yw1P8nllSpS+QZY8yK/qAIcL/DSDOXNLMkJdwT1/NdHHGg30qkS
	lAY8uqqWTb/2pgPRvwqVGzatEsb3C6atshfc61+0HB3oiw7Xkbqo7eTreAe7xK4=
X-Google-Smtp-Source: AGHT+IHZ7iT9pE68Wjv+JU0N7sjHpk2GrdLMYnk9ucDBkpDHw2pLyk9c+ADztmIHmHdhtDjicpckUA==
X-Received: by 2002:a05:600c:5104:b0:412:65a5:c9f4 with SMTP id o4-20020a05600c510400b0041265a5c9f4mr1222769wms.28.1708327784463;
        Sun, 18 Feb 2024 23:29:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm10334522wmi.34.2024.02.18.23.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:29:44 -0800 (PST)
Message-ID: <6d9b1197-0dda-430d-8429-57c6ef98e48e@linaro.org>
Date: Mon, 19 Feb 2024 08:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: mfd: add entry for Marvell
 88PM886 PMIC
Content-Language: en-US
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>, Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
 <20240211094609.2223-2-karelb@gimli.ms.mff.cuni.cz>
 <20240215142052.GA4180777-robh@kernel.org>
 <CZ8ATPJTOA3U.2QJSJY50EX2YH@gimli.ms.mff.cuni.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CZ8ATPJTOA3U.2QJSJY50EX2YH@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 16:10, Karel Balej wrote:
> Rob Herring, 2024-02-15T08:20:52-06:00:
>>>  .../bindings/mfd/marvell,88pm88x.yaml         | 74 +++++++++++++++++++
>>
>> Filename should match the compatible.
>>
>> In general, drop the 'x' wildcard.
> 
> By "in general", do you mean for the drivers code also?

No, not driver. The rules for wildcard, that they are discouraged, are
DT binding rules.

> 
> As I have mentioned in the commit message for the driver, the other
> device is very similar and if the support for it was ever to be added
> (which I personally currently have no interest in), I believe it would
> make sense to extend this driver. Is it then still prefered to call it
> all just 88pm886 now?

Extend the driver, it's unrelated. Binding still should be named like
compatible, because that extension might never happen.

> 
>>> +properties:
>>> +  compatible:
>>> +    const: marvell,88pm886-a1
> 
> So the file should be called marvell,88pm886-a1.yaml, correct? Again, is
> it prefered to call it like this even if the other revision could
> eventually be added (again, I am not interested in that right now

If you already add two devices, flexible name would be fine. But you do
not add it now and you might never add, so keep the filename=compatible.
It is fine if it has also other compatibles later. We already accepted
many bindings like that.


Best regards,
Krzysztof


