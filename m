Return-Path: <linux-kernel+bounces-136305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBA89D278
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2545B1C22C39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF002DF73;
	Tue,  9 Apr 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfZqNi4V"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E33763FC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644214; cv=none; b=P6DtC4/B8/uZqEfalnzF0UAUI3lzRxj/pp14tkUYGZI/+I1/MM6uQd4xVOEQhWkS3IG3UgmkrKnT70aSK0oWYoW9eyd38zw1hV4Nmcw5A4XIN+k0Ug8yaOb+FtjCCVhZMsqkhEmD1AS/b5/SIAHLqCVmGCLXGwtsigFIG/73gOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644214; c=relaxed/simple;
	bh=GLlGOxsGfKxek5hcLAceq+1uQpJbEpoRFNLaAKCpyOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DD5spyDpyhGM4WiHMq3R7ooCEZtKWcxwCvdYRwXQbAjZreOvXdnuQCZKzVoTqt9fpoa6Y5FZ9yMiu8T58xAbDYYmCGyIn4pUELMmplgkrVkybA3VTxiG6U7+TykpQTnKeILytrHXP+3e3j0dybCekJyg1e7lWtjryGcGxxqMMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BfZqNi4V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso7759558a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712644212; x=1713249012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JSfFuREisAT8UwnNGuE+3fIOXrzMP5PSYPhNRbJ9h10=;
        b=BfZqNi4Vrz2yfyEB1I6GAz0w4RWTJhvbfZAIcK7ESckoh6LxaeCoULxmZ3KkcAOQYg
         sl2ceTA/YFWgjxiSE+ka2sKgu1/Xz0/0Txawhp6BtqxESxv2AQN/Hb2sW2IgTM25NMf7
         TbF0zI1XJJeAmboTVorPHvBprNyz0fUy7iUEWwd/P3TO0xC7+tygnkbWBoF3vgBes2Nm
         UqKaeehWtfCcfuoQ/zaHi4z09FT8gVIUW8RDXLsdjYWXFmnRYeBmJjTtTAK9sPJ9GO7n
         DmIFw6faluEUi9VASzbC+Oule6bUa4yBeH3AnHtVT9Tp8fTnlh3UV2KibubHiNA0NO7F
         Cqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712644212; x=1713249012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSfFuREisAT8UwnNGuE+3fIOXrzMP5PSYPhNRbJ9h10=;
        b=lAAmCwOr3mz7uqH6TwBucKyLpyi+YZPjcl7o4A6Kw3NdKe6uJLjMFieQAli5N7KTDX
         +FNpZxVekunBSh8KvHERmz0mdPOMvqhDuLHvaIwZ549G6tcryftzlvXChiymg3Re5JJY
         9SVKds9z+OLW3kav5rt7JAWxlxh3s00o7oTG403LeA2wk1CU4MxS9wzfsrczlg9emXLC
         xo/qw5ZRRXse1MOOrkgVKXkISrS1p7ErVVHukQLNrtddqnpnSJOO7T8NbIBOpy/ITJOq
         g0JRQv+7rLDcTc9ZJ2EPANhEei50vZ0cgoSDZ5azyNhToZwrSXoWFc2AnpADNoCzr1Dj
         hQgw==
X-Forwarded-Encrypted: i=1; AJvYcCXhFjAtpB5LSwO7XRBOJI/JWrH2AhGduXTgrmdJDyRQUwIKQmRA1PcL/L2Ky/7WwXghdadkiSJ/KSeWIgUVR86Ssd8HeUqu6fF9UTCa
X-Gm-Message-State: AOJu0YzpljU1cK42oqc4yVtHR9TGlCGddYNgNFJal6J1MuOfb1zKU9ly
	/MxL9xO3krwnB21hR62tqqwlJ1v2O0eahPDIJlptiZpiEdrBX5MFLK8f2e17Lsc=
X-Google-Smtp-Source: AGHT+IG/oFIIAzcBsZm/egCPjFK0/bLUFEtPbvyxlCvGIe0YLL/tYpAaT9ndRheyNFs0seWC7a0ZUQ==
X-Received: by 2002:a50:ab1d:0:b0:56e:4039:add5 with SMTP id s29-20020a50ab1d000000b0056e4039add5mr6697537edc.22.1712644211611;
        Mon, 08 Apr 2024 23:30:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id di19-20020a056402319300b0056b7ed75a46sm4986932edb.27.2024.04.08.23.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 23:30:11 -0700 (PDT)
Message-ID: <51e482b3-ffbf-46f9-972d-875d106c2474@linaro.org>
Date: Tue, 9 Apr 2024 08:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com>
 <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org>
 <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
 <69ab2bd9-401a-42ff-90fa-6600dd071722@linaro.org>
 <CAA+D8AOP6D+xUNF_XJXt-8dMi2qFyVh-Sbe8k67CzvUbnzrwoQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA+D8AOP6D+xUNF_XJXt-8dMi2qFyVh-Sbe8k67CzvUbnzrwoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/04/2024 03:37, Shengjiu Wang wrote:
> On Mon, Apr 8, 2024 at 11:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/04/2024 10:01, Shengjiu Wang wrote:
>>>>> +
>>>>> +anyOf:
>>>>> +  - required:
>>>>> +      - spdif-in
>>>>> +  - required:
>>>>> +      - spdif-out
>>>>> +  - required:
>>>>> +      - spdif-out
>>>>> +      - spdif-in
>>>>
>>>> Do you need the last required block?
>>>
>>> Yes,  one of them or both are required.
>>
>> And? It's already there: that's the meaning of any. It is not oneOf...
>> Before answering please test your changes and ideas. I pointed issue
>> here and you responded just to close my comment. That does not make me
>> happy, just wastes my time.
> 
> Maybe I didn't express clearly.
> 
> we need at least one of them (spdif-in, spdif-out) in the node.  which means
> that we need to select  "spdif-in",  or "spdif-out",  or "spdif-in and
> spdif-out".
> 
> So my understanding is that need to use "anyOf", if it is wrong, please let
> me know.

Third time: it is wrong.

Can you test the code instead continuing this discussion

Best regards,
Krzysztof


