Return-Path: <linux-kernel+bounces-59588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E384F960
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B48B288DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59B76046;
	Fri,  9 Feb 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9LAbv+7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D476047
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495011; cv=none; b=aTT7NOuxpbVvn6zXwGR7t9pQEY/bU4R81zGPlIQRJp0wej3MFhG+HlI5KMN6jDzlNsEyNtEDQLzqhhFE/eNqK2Cm6AXm+jdtTV4D0zYdFvzI+1g8r8hK03VkMXG7zKmJbkcyo0Szd3ZaICfr1j2MZ6qbIXggKi8CqLepBFXCEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495011; c=relaxed/simple;
	bh=Ts7AFrJt3NWDHiWoNm5U/p7wsQD+7jfd8rRxodZLxDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdm9QKN+tuSn7SaCxzF3CA5dp2kQoTb6tPytfj8hG3nXfVGFsUl9cmU6APMsLGJptbE8YNFI/Q+j02qJgWLbGTRkj4GNMhayvAwzoIJ0jhd+I8vtHISs8CPZAX4XvWru67v4wUoGkeXB3Oen0ia7wZ0pbS8wrluxjRRq+aZT6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9LAbv+7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a34c5ca2537so144213066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707495008; x=1708099808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJOFI+BzNTmf5tqcKxpx9jKda2QN1EeN5ylZk90PmiA=;
        b=y9LAbv+7/AXcUUxT8UgXKKg+NP9pHh1dKCWN5Dkzbq3XjDMBOlKwJWkzt0QgsI+OiG
         S82RiPAis9eJ9xgbWmlLdayEzl+IpCpjScayUOopV3VmjJ5DbErkILQByj5rptlJ96Be
         daIKAYAQaNK6FjahnQqw7/pnLfe84NVNHdmzIDRHVxzQb9NwlOG92GIxQs0v/FknxLeu
         fOg20pVXiS7hNUo6Z94EWcqHe7TCve9TgZU8xAaOBmRwYw4PD8bh8k0e0VyWa+M5aWvD
         uATE7Z6b27MJRdZjNGIaT/sG5gNhqGVPpIvTpJ4MIveoifjkDl9BjYy8nz2a38lEFrVF
         C9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495008; x=1708099808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJOFI+BzNTmf5tqcKxpx9jKda2QN1EeN5ylZk90PmiA=;
        b=XpxhSH193p7UFVMjSujW1E5ov4Ldcs0HZ4HqjawXf94KsQXgJRzDP3EvynLoDsCpS4
         iN20Z1YlNPgBu0O3Gzob9Tfqq7aJKOzlInYHIBI6SXtrZdUVagjJnB259o7rsWzmxRJV
         v4XLkoMVxfE+j81ec2HBlAJvqhZgljMlmm/e2no22Sf9YT+hvkuK9wSc7hIOZ9Da9jPC
         G6KWnmgnaoNOxQBJ11agTB2kXxP/WyzvDzY8Ubfb/F5Eoth4SnTjT0Mhnz8IrkuKSPTK
         CSRcBwzXgtgo9oqn8/34O9AXYwrW7BKnud4Q9SbRdyv2QYv053Hu/ObgMCIhrSbjn7I3
         FDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrW3wACYu4v5n3213MPc1MovAPEQZ4JV3sYUi4CTHzuOgZ/Fc1rkmRJ3gzK+A/vMgLt644a3UULbIXjpaaNNENQZ/SSTPYHYhCPSq7
X-Gm-Message-State: AOJu0YyDsLOXipMQ8bMkJ7KvOSOavLaWLb5nlkIPtlUvKcWlbUEDiHN1
	TpoIRSAzmLtcHbLmciEjI8LzGbFYgF5U7LR/qzuiUKuT56c8PJycB0JtIOgLUPg=
X-Google-Smtp-Source: AGHT+IHOq9XQWmOVYveYDOoOnlAyT0U8zBOfOqX+6QRXoU20fZD/1k2Gv03R0mgIzQENU/3hzLVkJQ==
X-Received: by 2002:a17:906:6953:b0:a38:a476:f91d with SMTP id c19-20020a170906695300b00a38a476f91dmr1285099ejs.68.1707495008050;
        Fri, 09 Feb 2024 08:10:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWn4b0ynRMJYDsfmMdHh35qptYsQ135nDpNYt6ht3t4pOMvUlND4QX5AeKpMn9+rYyoD39QYTf3LbQlOho0C+3xpTaWAhyBNZBtNChSoM2hIuL7pdfqoAN8myNfGu/wC8MwZ+BdkGGrlaodUN6tpoTb/NlCHrYRffh9GVVjMxap+4x/bASvRy8G7a0AIiPV5A9jwD+yd1xEx2TWWWZKCTeEEkYk+E0B/R5jHxqZ2EIO9Jhp9XGDgwSXNGi2QQhCAmce/hWsOUfML9GyOBO0z1zQyfsN+fLB75MnS4Jp4bsxo8OxMfCPRHFEuWI9b8c0Lmxq3xnLw2aqKI/w6ApIpEejv04PtsGDIeQg8ou6oCUqud/kcEfo1HBIpqRemo66YwBhgYLZCZi5h6JIvW0cXCAy7Ug6q3GTT+MC0C1jRr6olOuVqrO0Qc0zDrfHeYg5076D8m/GpFz93pPSDM9JD4lHEVUbYWsvgdi4PFSUDQLLukI8edl4zPUhNXOTTIo2OvoMeCLzelEl/Jgr0/U578S+S5BSqz9C19VAXeftGYahJ27+E4uWOAPxWA9n/ikc7SoE7TRWpIML5NM5xrmAOwoTbSVf+M+DrUvxfuMzBBvFY8OMAvj6XbRzZ9IoNQPPnNl7hHr2P1o+dFnShGCrx/B2CfyJhuEat+IOIx11yRiG2p/U9rZysbFjAS5xUScdl7r8+GUqFlgzYCU0DhS0BDSxxjeWaCC9nAI9FD2BgkUfpYM9dBwS9dma1tNZlK1UPL2f2bRccmJqBb0D6EzTgUaNDd9MvrFAYlnx/IhzqS3pOVao9N4O+BTQjcKn7HCVxjVc+JwXgrJduDynPCWGxvqNOj8bpf23v/+R0dO1k+McWbbofY0NcrgYI5YSlQQRY5kAnq1dgPGDyw+rdfY9ew2EfT1mxXX7Mhg9oqmdc0nYhxn/M9GyntWgyV2e4MUCSOxhnH
 TJAg1mmSmk16+TmhHw5TqMN1ol+MwmSZ3mkdowbFeTd1OGrxiOPGPMN0I=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3bef32a510sm651049ejc.2.2024.02.09.08.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:10:07 -0800 (PST)
Message-ID: <45aa6b3e-5e76-457e-b091-084adf324385@linaro.org>
Date: Fri, 9 Feb 2024 17:10:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: display: bridge: add sam9x75-lvds
 compatible
To: Dharma.B@microchip.com, krzk@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Manikandan.M@microchip.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux@armlinux.org.uk,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, geert+renesas@glider.be, arnd@arndb.de,
 palmer@rivosinc.com, akpm@linux-foundation.org, gerg@linux-m68k.org,
 rdunlap@infradead.org, vbabka@suse.cz, linux-arm-kernel@lists.infradead.org
Cc: robh@kernel.org
References: <20240207102802.200220-1-dharma.b@microchip.com>
 <20240207102802.200220-2-dharma.b@microchip.com>
 <2219df60-7235-4c37-b79c-25e7225cb7a9@kernel.org>
 <b314e446-e79c-4fa0-9b86-c58fa96133bc@microchip.com>
 <c82a3843-1b58-46ea-994a-8350544aa30d@microchip.com>
 <e2e1490b-0e07-43ae-ab67-2efd6f21987e@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e2e1490b-0e07-43ae-ab67-2efd6f21987e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 17:05, Krzysztof Kozlowski wrote:
> On 09/02/2024 16:02, Dharma.B@microchip.com wrote:
>> On 09/02/24 7:50 pm, Dharma B wrote:
>>> On 08/02/24 2:31 pm, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>>>> the content is safe
>>>>
>>>> On 07/02/2024 11:27, Dharma Balasubiramani wrote:
>>>>> Add the 'sam9x75-lvds' compatible binding, which describes the Low 
>>>>> Voltage
>>>>> Differential Signaling (LVDS) Controller found on some Microchip's 
>>>>> sam9x7
>>>>> series System-on-Chip (SoC) devices. This binding will be used to define
>>>>> the properties and configuration for the LVDS Controller in DT.
>>>>>
>>>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>>>>
>>>> Not tested...
>>>>
>>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>>> and lists to CC. It might happen, that command when run on an older
>>>> kernel, gives you outdated entries. Therefore please be sure you base
>>>> your patches on recent Linux kernel.
>>>>
>>>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>>>> people, so fix your workflow. Tools might also fail if you work on some
>>>> ancient tree (don't, instead use mainline), work on fork of kernel
>>>> (don't, instead use mainline) or you ignore some maintainers (really
>>>> don't). Just use b4 and everything should be fine, although remember
>>>> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>>>>
>>>> You missed at least devicetree list (maybe more), so this won't be
>>>> tested by automated tooling. Performing review on untested code might be
>>>> a waste of time.
>>>
>>> Apologies for the oversight, somehow it got missed.
>>
>> The get_maintainer.pl seems to be inconsistent with the results.
>>
>> linux$ ./scripts/get_maintainer.pl *patch | wc -l
>> ./scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't 
>> appear to be a patch.  Add -f to options?
>> 31
>> linux$ ./scripts/get_maintainer.pl *patch | wc -l
>> ./scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't 
>> appear to be a patch.  Add -f to options?
>> 29
>> linux$ ./scripts/get_maintainer.pl *patch | wc -l
>> ./scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't 
>> appear to be a patch.  Add -f to options?
>> 30
>> linux$ ./scripts/get_maintainer.pl *patch | wc -l
>> ./scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't 
>> appear to be a patch.  Add -f to options?
>> 30
> 
> Why would you add 30 addresses, including many unrelated people, to the
> cc-list? You must add only maintainers (so also reviewers) and mailing
> lists.

Really, why do you Cc MM folks on this patch? Just read what
get_maintainer.pl tells you, e.g. when it says that someone made one
commit to maintainers file, shall this person be Cc-ed? No, it should be
obvious...

Best regards,
Krzysztof


