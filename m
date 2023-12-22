Return-Path: <linux-kernel+bounces-9425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C881C553
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB90E1F2443E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194718F63;
	Fri, 22 Dec 2023 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWnnq8CG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95358F40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e33fe3856so1758817e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703228232; x=1703833032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7HtSfzkXQNBPpoJY9d0W5X8uOCX+xlvlcP9g0PM8a8=;
        b=YWnnq8CG9GQcqgePLjo+byOe573Q0fn7RvFB1thKOlmfu/+5PKnMxr+jgEwkeuLEI4
         nDC6f42OUXMZ7Z0fhno7hU/0/gXhqYSFScLdOlO6DCC4suLVfpuvVa+ukITXTL29TGMq
         WnrDED8pgex+f9M1uEt1zCORllSyj4XMF4Uzakoyk3h+XpsHewA9Oc1/Lx7V32ca+jFd
         WIcunn6En7YT8a3JoeayqEPjLvWqUKv39oJB4I7i/y3djL13sYAZZw7L6AuZb+NEofoh
         58g+tU+Qaxe2acpCADHAv+KBwUoEiukthTBh7Q9rEWRoG1K/v8CJW8t8Jl5T/gzbOMUh
         rE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703228232; x=1703833032;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7HtSfzkXQNBPpoJY9d0W5X8uOCX+xlvlcP9g0PM8a8=;
        b=FqG+VgA39dNeGaPHY1rGihWytfPpTLcXonPCcMql0lbDWRldNBT+C8220dg68NwplW
         XHJ7EFxOSP20Bqiolh0I8lHg2iRQDJsSlX1LwLmS8gSERkv8MVI7pg24DF2ETkUorxSS
         Oh3qI/ZirBqJhjVGGMQJ0t4wPvRGwzL/8cAXYPwXIMWNfqIxcQOXLNo3jK+9jFXBWrCE
         Lmw/cv0cZTXO+ad2JlDYQhNpGpZ8WzvZ7O8TkfdqWKEd1bSiG2bJYngNr7zJQsose0PI
         CoEFEUVQnHSL2xZi9Yw7kEXeihMv0AncnXzK7x3k9VVXbW76KvsxqXOzGI/ca7ZBc+MR
         nlzg==
X-Gm-Message-State: AOJu0YxLnIDkFM2h8EmtNP/XLnIG/x4ZLrxWTP9O1lvpY3i/uQ9JBPId
	Xz5fzvx6oJqKPt5TiNEme+esCNZSnvI=
X-Google-Smtp-Source: AGHT+IGWjYYu/zqf5xHQ+ZzSoryk2b432QGTm66c0N1EKEblnPfbIwGru5HSSP4GcDWzu86CT9RGmw==
X-Received: by 2002:a19:f010:0:b0:50e:55d2:a690 with SMTP id p16-20020a19f010000000b0050e55d2a690mr251944lfc.78.1703228231480;
        Thu, 21 Dec 2023 22:57:11 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id 19-20020ac25f53000000b0050e3c28d98dsm468936lfz.283.2023.12.21.22.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 22:57:10 -0800 (PST)
Message-ID: <4d4b9d90-ad04-4751-b3c6-09be5f738cd2@gmail.com>
Date: Fri, 22 Dec 2023 08:57:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: MAINTAINERS: add status for IRQ helpers
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20231218102845.41875-1-krzysztof.kozlowski@linaro.org>
 <cbc4247c-323b-4f4e-8963-fcad7da9528e@gmail.com>
 <5397da38-80e9-4e75-806d-0b92b2b5d475@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <5397da38-80e9-4e75-806d-0b92b2b5d475@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 10:02, Krzysztof Kozlowski wrote:
> On 21/12/2023 07:17, Matti Vaittinen wrote:
>> Hi Krzysztof,
>>
>> On 12/18/23 12:28, Krzysztof Kozlowski wrote:
>>> Each maintainer entry should have a status field:
>>>
>>>     $ ./scripts/get_maintainer.pl --self-test=sections
>>>     ./MAINTAINERS:23368: warning: section without status
>>>
>>> Fixes: d55444adedae ("MAINTAINERS: Add reviewer for regulator irq_helpers")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    MAINTAINERS | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 30322190a72f..6fd22db830f5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -23367,6 +23367,7 @@ K:	regulator_get_optional
>>>    
>>>    VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
>>>    R:	Matti Vaittinen <mazziesaccount@gmail.com>
>>> +S:	Maintained
>>
>> Isn't that a bit odd seeing the M: - entry is missing as well?
>>
>> This entry falls under the drivers/regulator, and as such, is maintained
>> by Mark (and the "umbrella" entry VOLTAGE AND CURRENT REGULATOR
>> FRAMEWORK has all needed bits and pieces, like the M: and S:).
>>
>> I think the current MAINTAINERS entries reflect the reality. Mark (and
>> Liam) are THE regulator guy(s). I am just doing bits and pieces here and
>> there, like reviewing the changes to these helpers.
> 
> And your piece needs S: to explain whether you do odd fixes, maintaining
> or supporting. Although I understand questioning this with only R:, but
> I would argue that it still applies - reviewing odd fixes, reviewing
> unpaid or paid.

I still think this is a bit silly :) Reviewers are not expected to be 
picking up the patches, nor are they really expected to be writing fixes 
(although I'm somewhat committed to that). Hence, I'd claim the S: value 
for a reviewer is very irrelevant for other developers.

What many of the developers care is getting their changes in, or getting 
bugs they encounter fixed - and I bet the S: is used to get an 
indication of the likelihood this happens.

>> I guess that from a technical POV duplicating the S: and M: here is a
>> bit pointless, and as all duplicates, adds overhead when changes are done.
> 
> M: is optional, anyway the M: field from regulators count, but status
> can be different than from the parent.

I guess that in this case the status is not different as Mark is 
maintaining both :)

TBH, Even if I think it's a bit silly to have S: without M:, I don't 
care that much. From my POV, "Maintained" is the correct status. (It 
might even be "Supported" for me - but this is kind of shady as there 
may be extended periods when I am expected to fully focus on other stuff 
during my paid time - so, "Supported" is "Supported" only when there is 
bandwidth) :)

I can also be "maintaining" the regulator irq-helpers in a same fashion 
I am "maintaining" the specific PMIC or IIO drivers (Eg, I do reviewing 
but patches go via subsystem tree and the subsystem maintainer is the 
real "gatekeeper") - it might make more sense if we add this "S:" line 
(for the above reasons).

Well, I'll leave this to you and Mark to judge :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


