Return-Path: <linux-kernel+bounces-167252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFC8BA672
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E131F227E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920D6A003;
	Fri,  3 May 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQtweVUQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A11137C36;
	Fri,  3 May 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714712066; cv=none; b=S1D7CFqTusC+ZOKAYYW1CFAdyUeLAvTbQVdCS85k2a4PBknDWTLM/j4iht9cm/qUG0Uc7iDjFr/1dmY/ERPNCtC6rY9BT4XdB3g5yKr+iwhK1vLzHwXgvtu+Xr7d+hGk9JbQ4UHRGxLTGGvHUDU4Tqc0mTcm8ZA46+H7Ged6hVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714712066; c=relaxed/simple;
	bh=5Vk/o77IrN6HMyMH3vHDq6aK7PmYvi2tirm6073Fm2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGEYkgDKb05qwFSdZS1DNGSPZAn7jhPX6xhwVNxuLhux5ncEStkOj3GNubXUvqLazcnrewqrgO0btipTvihxSIn5H4ZZyUIgC+D9ree1UGGEiY9gS7V3PodzN9KA/wC5r4LZQSQiIM4ycz+mKlrCmGmvHxwuhNZ8TEmi+SMeE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQtweVUQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so2576927e87.1;
        Thu, 02 May 2024 21:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714712063; x=1715316863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loZHn25HlcmFKvqsuM9XCvTx/kGvrnibzVi5KvehX28=;
        b=FQtweVUQVNbyUpzwMhhxwfIP9Id1fHXXvN9O34ovL4Dc+1AeVjVJROnJPX7/hjNXeb
         jwJJoX7ru5aAjkdIn10PgvJuBLRs+d45ofCKf9NTGREx9qkQ5viqYJMA6NFkIZT9hkfQ
         1AAZgRBmPI7Jydl5eys13fgrCRJ+W0mfxI6fGoMGaN6VPlTrZXIGlMLyGOTo/HM6BDLg
         jJXjI1L/JYwWPWqMWltuBglNmK2KMbRIyCWyDH3YSVbLnMZ+hm6xV9A3TC4kvfMlSahY
         nzUJqS2aKJQyi2knsZdFnjBRmjCKBma2R8rDQOZ+xwBD9NOKu/R6W3QdTtlJit/MZHcG
         cVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714712063; x=1715316863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loZHn25HlcmFKvqsuM9XCvTx/kGvrnibzVi5KvehX28=;
        b=gcvKjxaO/Lq/tr2QZcqv1TpSScPQja7EpUhQnJPj9/6rynXhX0UHUb3CnyMxVRhvZK
         BPjaxcS4j6tFM37GvCl0q6C9IL5Q5isaYgIX5CersdPuYhEo37ITgsnSiyyXwrZOEPl6
         LIXjpGiYZ/1VPw3a59jrx10pJ/ZMKi530Ai+eIKNHDLwuCW/NCcfwwfWDeGTFqSEcvj5
         pJMe2erMFWPBm6aZOhGozJRuvjlHMjdLyuF6aBSqUASgHe4TuonGu56ZsSMvRgkJ9wQm
         tvTpt/qxkfL3ss7wsValISFRosSb80BWHR78GK1ZWNHU0J6aNqJ0oKunQmWzfcnHfD87
         Iy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+fz/azFrsmjEDByMQBv8SZahizSHfATy79iyFCz1EpW5gK9XSKngXTri1kd6Sa1WCRINnX8ifwL4nB2SkTNpQhFRRp1mej8/ca4H1kJ0KJJkGAljl7LM9ZQe8Y754vMpVjjqLtm2HnXxdRMOjdbsIQ/ydcoWyvTLznoPJcKJxg+9/iZM/YW3f
X-Gm-Message-State: AOJu0YwYhVPW1mc96mGvxqIY16y1Lre/urtTZVFF0poJDAhREoL+2CCd
	u9kSLdyiDeddphJamKPD6incr64HUYZcZ/Vcc9BG0LcQGc2FJD1K
X-Google-Smtp-Source: AGHT+IFQOjsN5z4X0Y11iSOg7oq/hzAzCCnkqGbNdxRqrYzdUZn7dn7SXecPkjPH+UsG3Nxix6eRpw==
X-Received: by 2002:ac2:546c:0:b0:51b:9254:91e7 with SMTP id e12-20020ac2546c000000b0051b925491e7mr1213779lfn.61.1714712062993;
        Thu, 02 May 2024 21:54:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24471000000b0051e12057075sm413999lfl.179.2024.05.02.21.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 21:54:22 -0700 (PDT)
Message-ID: <74655775-a8e2-45f4-8a1b-8046dffa5520@gmail.com>
Date: Fri, 3 May 2024 07:54:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] dt-bindings: ROHM BD96801 PMIC regulators
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <c747a3395a52bdb9b9697f814cd781fb0903b894.1714478142.git.mazziesaccount@gmail.com>
 <20240502-vitalize-oat-ecbc14647df8@spud>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240502-vitalize-oat-ecbc14647df8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

On 5/2/24 19:20, Conor Dooley wrote:
> On Tue, Apr 30, 2024 at 02:59:50PM +0300, Matti Vaittinen wrote:
>> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
>> DT bindings for the BD96801 regulators.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> RFCv2 => v1
> 
> RFC is a status, not a version - ideally this would have been v3 and the
> next version v4.

Thanks for the clarification. I've always wondered if an RFC should be 
seen as a separate series. Previously I've ended up just dropping the 
RFC and pumping up the version. This time the switch from RFC => non RFC 
was somewhat radical as a lot of the features were dropped. Furthermore, 
I've developed the 'simple' version (this non RFC one) and 
'experimental' version (the RFC one) in separate branches - which made 
the separation even stronger in my mind - I probably started thinking 
these as two different patch series.

But, as I said, thanks for the clarification! I guess it's still better 
to make next version v2 (and not v4) to not add even more confusion...

>>      - Drop regulator-name pattern requirement
>>      - do not require regulator-name
> 
> 
> Krzysztof had some comments on the buck/ldo node names

I think Krzysztof pointed out that the regulator-name property should 
not match the data-sheet but the board. If he had something to say about 
the node names, then I've missed his comment!

> and on the
> initial value properties that I'm not sure if have been addressed, so
> gonna leave this series to him.

Thanks for pointing out I may have missed addressing some of his 
concerns. I though I fixed all issues he pointed to me but it may be I 
missed some - or accidentally dropped some change(s) when merging fixes 
from the 'experimental' branch to the 'simple'. I'll revise Krzysztof's 
feedback to the RFC before sending the next version!

Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


