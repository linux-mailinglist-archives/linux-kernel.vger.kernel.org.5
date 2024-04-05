Return-Path: <linux-kernel+bounces-133464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649989A413
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463611C22463
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5777172765;
	Fri,  5 Apr 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkdKURFo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2C172777
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341181; cv=none; b=a8GzVpAClvn6T1cSm0FT/+TMcrC0Xeu70paGFDW03Xo3CZ/P/jyqHgegNmhVKk+4lJ19SAuNG7VjR5YXCnX6tInrY/001LnlUXFaOs3naRjg5GXpOgsElYteuQfQin1eRT6YTv9dZx6xkeQYFMUfk7QxGH2qjPfoLp4/JSIZ6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341181; c=relaxed/simple;
	bh=cCLDIsYFejxah3kcUtD/78RZA+bRyvoysZUBeT3z5Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmaLZmtdUDSRBtDBIJzS1hGV77USL+yJM3Wa7gV53b60NfwRk1yUHDIVxQbIEMb7X8uhfIQaauaSeqUmNcnwdKYfmvx2F9jYbmg3qwwTgeooxFs7mFzAa+vDpPiX4ZVNCjSU2U6ULbEbUW5up1CWIp485pqM9KQkf5J6T5mM1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkdKURFo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1fe3f105so1181303a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712341178; x=1712945978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+1RwFx5Y5CQOS1dH67ttsjIpb2yYeYbzx39qz2nB/54=;
        b=gkdKURFo1z2kORHxqHXUDzQQQLbTZ0Pxbe/W+0q/11lRtKT0v5BD8QQIzFM+8KIO8P
         RnBUYLWnzqCshsh8rY51QbHVfVJWgp8FXYhLtru6JbkTDO3iyVtseybmVlU+ynkBrjhn
         huME40eQv9OvJXN9vetOTh3PtgJvlDrRKrlxgL8KrXvkiDPZ5pHNjCuNNqUnmJsQIpFd
         jRfffDLbwLuOHaanapLsKLR+21IM+m6wWToWc/TxRdqDyDL0k44O0ddD0dXFihlYK7lG
         Hda47jpdIUnDpANGKja3SBaJbwY2Q7m7eNi/T+F1em0bApANVXQ0eMaO4q9iV36IdqmO
         RKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341178; x=1712945978;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1RwFx5Y5CQOS1dH67ttsjIpb2yYeYbzx39qz2nB/54=;
        b=Z6x5FRYMj9Q0n7JM+y89/zCYBaAMUrr5wO/6bzzlKjUV6PSLaLCfn219JVKdh+SbRu
         TqsrSX79/aWaAU0PtBhoYC5SSUlbTns+2OKdxJPrYecuZ688r744rVWcBs26Qz7OscXH
         K/2O3BNj/NZtSrgJbRP6VORmmvNmVn5/BRv8osf3ds0rB1274fNWFjRA3B2ZdPNsWC3f
         N7h+6Im8UKwZTK2r8AiXsvKEjUUnFWqVwQbcfBMYlb6xHQ6ts7j03KswsGN5L2/k8FrT
         RYQhi5e7IimnDqdSORaDyOy5qYQFhLKdAOAOOMLKQMKL3akMiB1ZlQpMu0LD3m4g+1iz
         3Frw==
X-Forwarded-Encrypted: i=1; AJvYcCXb4qCgPE8v6C/gUbQ2m1gRNk2q3keDCFCE/63Sbt3+uRiq8oCPqG5W761aaRVcTkqjuDVx+bjwoCdTO+PRHLpbMTTQYq9Hy7dkrFPA
X-Gm-Message-State: AOJu0YwfswtafBTUbAEH/+w53o5GEv6XKYO/EcB2jqT3oOoyZ6BnXaKt
	x7Z/rh0Ndm4mCMPPSVatfunzg2ZbY1iXWUhf0/2xgL3F//Ax4NHQO+OVSdLnmyk=
X-Google-Smtp-Source: AGHT+IFJE27+I1fV34zf0q3INt5gP7v3XA/hxhqaP7lbIgf2utXVlcEuEzbd1685nzCblz2Pxk/4lA==
X-Received: by 2002:a50:a40f:0:b0:56e:3571:189c with SMTP id u15-20020a50a40f000000b0056e3571189cmr1469625edb.18.1712341177745;
        Fri, 05 Apr 2024 11:19:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b0056ddd9427d2sm1038022edb.58.2024.04.05.11.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:19:37 -0700 (PDT)
Message-ID: <352672fc-b6e1-458e-b4f9-840a8ba07c7e@linaro.org>
Date: Fri, 5 Apr 2024 20:19:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Mithil <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404160649.967-1-bavishimithil@gmail.com>
 <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
 <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org>
 <CAGzNGRktm5gMj=bhtX2RAzcn1v5ref+nV-HV3Fct56FzAzxjWA@mail.gmail.com>
 <c9084453-65f1-43b0-88df-5b73052ccb72@linaro.org>
 <CAGzNGR=2-us8GRB3RNi4_24QZ9rNBC7Lx0PFsWwbvxuRKk5ngw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGzNGR=2-us8GRB3RNi4_24QZ9rNBC7Lx0PFsWwbvxuRKk5ngw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 19:21, Mithil wrote:
> On Fri, Apr 5, 2024 at 10:38 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/04/2024 18:29, Mithil wrote:
>>> On Fri, Apr 5, 2024 at 9:27 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 05/04/2024 16:48, Mithil wrote:
>>>>> So sorry about the 2nd patch being sent as a new mail, here is a new
>>>>> patch with the changes as suggested
>>>>>
>>>>>> Please use subject prefixes matching the subsystem
>>>>> Changed the patch name to match the folder history.
>>>>
>>>> Nothing improved. What the history tells you?
>>>>
>>>
>>> Referred to "ASoC: dt-bindings: rt1015: Convert to dtschema"
>>> Not really sure what else I should change.
>>
>> But the subject you wrote here is "dt-bindings: omap-mcpdm: Convert to
>> DT schema"?
>>
>> Where is the ASoC?
>>
> I did change it, will send the patch again.
> 
>>
>> reg is not correct. Please point me to files doing that way, so I can
>> fix them.
>>
>> You need items with description.
>>
> Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> I referred here for the description, but will add items for the 2 regs

I don't see at all the code you are using. It's entirely different!
Where in this file is that type of "reg" property?

> 
>>> Interrupts and hwmods use maxItems now.
>>
>> hwmods lost description, why?
> Seems self explanatory.

Really? Not to me. I have no clue what this is. Also, you need
description for (almost) every non-standard, vendor property.

> 
>>> Changed nodename to be generic in example as well.
>>
>> "mcpdm" does not feel generic. What is mcpdm? Google finds nothing.
>> Maybe just "pdm"?
>>
> Multichannel PDM Controller. Kept it like that since the node is also

You said you "changed nodename". So from what did you change to what?

> called as mcpdm in the devicetree. Calling it pdm might cause

Poor DTS is not the example...

> confusion.

So far I am confused. Often name of SoC block is specific, not generic.
Anyway, that's not important part, so if you claim mcpdm is generic name
of a class of devices, I am fine.

Best regards,
Krzysztof


