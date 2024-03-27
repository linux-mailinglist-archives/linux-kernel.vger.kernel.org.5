Return-Path: <linux-kernel+bounces-120578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE488D9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053CB1F2DC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9F381C6;
	Wed, 27 Mar 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxiMsAr8"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACC4AECD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529656; cv=none; b=Bt1ObAXJhk8QAwGCkvzOWg5ZdEmjAYiN+xT9w7YKB28ISeuOsVYgpXRDq6TApsYHmwdhz6Dz38YTCNZkkaBGyppdwAR9l9ac5Wqrz/oCrygm5/2n87f1IPrcs8nWUUiSkMHzlxFJGZMwF+izK+9dE10/c4dO0XRPnNKo/2Bk5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529656; c=relaxed/simple;
	bh=hkf8WnDvTMlPg6vYOz0rZWJ004dc3isL15eaguR8UQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPWJTPgUY+lAzevbRX/I9XCULL+iQ4zaUDF8G79ey0wMc3hw1RwpO+GZudK6+XNC0maFydNWvIBtX3aZVtUtWfNAs2PiD688VZSZ3O2vaLxD1aGD+t3pCr/eqpd3Da+mtV6pl0VojznUdJA49LlVlx3MRE0qmSjG4KMZkzUANB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxiMsAr8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso3268821fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711529652; x=1712134452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q42Xx003fo9Z8ScGicRWE6228uDZ9drjWZazb7fWQns=;
        b=NxiMsAr8rP/4p6fLTrXpJK7AjR24hFIM+Skt84C0lG1jA2q86kdzx2R8LgjJ+bM4ap
         iSntd0SWNl5BtT/T73QUMAyz+w6RN3rv0Czr6Kegwojup0tgRbU99scHkgmQZ6kx14uH
         Q3Mgj56ax2caak1/RfZMRLnulSHPTGILxXp4DpRebhS5hE6xhtv8lHHxoes4sLz3PuDl
         aGLAZdWvJp4Gk5QPqHQgDqQ4hceMWtOAMAN/qvS3DpSPPu5HReG3AcX/jgWhTmrn0kjj
         83WG0JXjM5X4ocI3ZMhz2Ug+Rg7nMpTnSddgUyY8RY0husqAKOZFCpcRukPeucvGnFXA
         SU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529652; x=1712134452;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q42Xx003fo9Z8ScGicRWE6228uDZ9drjWZazb7fWQns=;
        b=H6FYWITs20oYH1j+DzEj25qidN+6z1165euKn08IAbjahCp2cgHjtIkXBwbYd7+p0U
         IEfJBNkZ4XQi9OgH1rw8uIixFAaJ5kl1mhxRTIJqFP1SoMcNg/ldVe6naA9W+Cq9fCGF
         ien8N18lDwJ7svcMFCfHNQnvrB0rRvpxp/O7xOq07b8CNnP6smWdK0ayh8g9UPneb8rf
         /NRHRQ3Nwss5VYgUnLTgg5gz1MdbDoQtbcepRgsuw2cn2iEyAj0KBY4uTrubcrQvHjt4
         YpAR/O5MlnfKD0aPAcVrV6ilfkVmf+t1bWoxGJIHgxSFx/CvYCjIaS3CUVfk1Q0uI7eJ
         Ysww==
X-Forwarded-Encrypted: i=1; AJvYcCXBXa7dmwrSgAkNYpxFTM0XciqXFfcBx3dGPYKpWEYzdseu16haZEEfs9JdmX0kOrumxlawiWqrVscu21wuKLMjdgLTvwJDCfYWoB1V
X-Gm-Message-State: AOJu0YyAe1WKMDF7RzBlycBmWzGLZ4TRvqnYyIfmakFPOoQGoHGKdpEJ
	C4r8aZngrWim+0LHKn2IvfZ9k1XEuGLmdOcg6gN716xm0E2Uo1mj5r9Nmbn1Ndw=
X-Google-Smtp-Source: AGHT+IFGqdMX0eI8HzGYgZWnnEWT/3VvnRNpPIfN+vapB2rLZsqbXL0Ikzt3PaKKJIzPYNbY3akEsA==
X-Received: by 2002:a05:6512:1395:b0:515:bf94:cd38 with SMTP id fc21-20020a056512139500b00515bf94cd38mr550686lfb.36.1711529652297;
        Wed, 27 Mar 2024 01:54:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id ij5-20020a056402158500b0056c09fda4e6sm3651763edb.54.2024.03.27.01.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:54:11 -0700 (PDT)
Message-ID: <7bed14be-2850-42b0-abb4-43aad25a19cb@linaro.org>
Date: Wed, 27 Mar 2024 09:54:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: add SA8540P gpucc
To: Johan Hovold <johan@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326140108.21307-1-johan+linaro@kernel.org>
 <20240326140108.21307-2-johan+linaro@kernel.org>
 <a6fbbfd3-516b-4269-b4b2-611979b62fd7@kernel.org>
 <ZgL6fE8bFx7H41kr@hovoldconsulting.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgL6fE8bFx7H41kr@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 17:40, Johan Hovold wrote:
> On Tue, Mar 26, 2024 at 04:59:43PM +0100, Krzysztof Kozlowski wrote:
>> On 26/03/2024 15:01, Johan Hovold wrote:
>>> The SA8540P platform is closely related to SC8280XP but differs in that
>>> it uses an external supply for the GX power domain.
>>>
>>> Add a new compatible string for the SA8540P GPU clock controller so that
>>> the OS can determine which resources to look for.
>>>
>>> Fixes: e60b95d2b687 ("dt-bindings: clock: qcom: Allow VDD_GFX supply to GX")
>>
>> I don't get why adding new device support is a fix. Commit msg did not
>> help me to understand it.
> 
> Yeah, perhaps I could have expanded on the problem a bit more here.
> 
> Hopefully it's clear if you look at the cover letter, but the commit
> referred to above should have added a new compatible for SA8540P which
> uses the new supply so that the OS can determine when it should try to
> look it up and when it is required.
> 
> The Fixes tag can also be dropped, I admit this is not clear-cut.

Some sort of short explanation would be good in the commit msg, so Fixes
can stay.

> 
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> index f57aceddac6b..5b385e4976b6 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> @@ -28,6 +28,7 @@ properties:
>>>    compatible:
>>>      enum:
>>>        - qcom,sdm845-gpucc
>>> +      - qcom,sa8540p-gpucc
>>
>> This looks fine and pretty trivial, but I really do not understand why
>> skipping our list for automated testing.
>>
>> <standard letter>
> ...
>> </standard letter>
> 
> Spare me the rant. This was obviously a mistake from reusing and
> manually amending a git-send-email command from shell history and
> failing to notice that this series also should have been CCed the
> devicetree list.

That's not a rant but a template. :) You know, some people don't Cc DT
list on purpose, claiming "it is trivial patch and I already Cc'ed other
mailing lists". I don't know what was the reason here.

I forgot one more template to add:

P.S. This review might include comments based on templates. My intention
is not to offend or patronize but streamline my review process. Thank
you for understanding.

Best regards,
Krzysztof


