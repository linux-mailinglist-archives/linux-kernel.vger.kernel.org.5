Return-Path: <linux-kernel+bounces-75024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4D85E1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B251C208D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338280C06;
	Wed, 21 Feb 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onuYCT3Z"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C648060B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530387; cv=none; b=qKIAskUqjERCmgjyYX2MPuQ8u493fOzYLI3b0RRUR8EMdhwMnpnrnthYUzc35Y1FRDyfni5u60BptwRQ9gBT5w3UmLSl7QvenLAz1RBBlGjqWZpAjuY1Dugw/g2ecNctBg5kNCwXoPGd/oFuoBw6gSIDaQfC5wHuu5bGlBphIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530387; c=relaxed/simple;
	bh=4u19Doe9WOme6QBmQv0E9NzIlDVs8/8g1iuCZsf5lCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5S+kuv4UD6CRIiZKuUuoK4p6yOqAS03h7NGM6xXyxX8mzVrWRkw7o49UENVqzR8nYjh/pkRCpFnhE+gz3x2pgZPr+O1RR6+o6bgfiqzsrDLbc3xe3zxMQA3/HYsF1xfNs4Zmvjkep9BS4vrslc6Js/zRVTzC2ZxiKQQ0epVuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onuYCT3Z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e550ef31cso77551966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708530383; x=1709135183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGE12FNjwfVB9Z5KAUPLcY6M07RBRWLS9k5mqeWGlxQ=;
        b=onuYCT3Z9NCtQUXpiY4ePCyUAcmKy42cTb/rG7M6gRr5b8NyFSKgE/RL4yWYTljJHq
         j/ohlmaZcNtVV5A6GNRP7YpD6roFa2JtlIvswOkoBrU0DKvBplg6py+ml6CQEef+5lh8
         FXswnV++osFbxo3Hr6JdcIZIDhfa13b6gej6Rf5bDyDENsvPZd5y3kh3NtQxGTDpmF5N
         ej8TeTafkjZulVKx4OJzCuhnACqIXM35ZzzaPJcknBAP8SrfJC4vcpa8wlAnSqQkq4Vr
         6ddTXtRq5axI6YPJdMRg1JTI/ap9GO15E3MoERCN5TCcokqJkCIBTLVhVS1D9IYEvdPO
         YLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530383; x=1709135183;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGE12FNjwfVB9Z5KAUPLcY6M07RBRWLS9k5mqeWGlxQ=;
        b=SfKUgLBpeJJUzkOsKVmSyP9CRScfFFLTPCBLYt1i58ClPSRwLQAOtsT5Yvd38kNfPy
         58C+iR7Ygub9ZO3F/axnobcN4aLKPYu+GQ69LBWgzxgIxdUIEwej+EgbPnMp4Z3JUCT6
         dZdp9fJFXoC+6dXZIGKye4TjOq7E523T6ovQoh9EeL7gokT3GhxZh/TXJVB+Mm4D9nSJ
         mUapGDy25E+6rvj/dwaJwcU5Q4oySdBhf/w/zTKXqXdp+RiWymrroYt8yDiwsd7i78RK
         nTYTzbw96NjfBiHDS6sJK+XMwuEygT4/sO1u1hqOKbXSyHnq7ekR6gwVcqtEUg2oYXaY
         zHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWYyzrrz8lje9VyXU24rgmBU+c1bOuxMQ1Uu1Ipsr7jv+ViFddx6X198LrY5m/AkH2UGb9KwShmHhkzfIV/GJqypzvcUSfLdSjWlB0x
X-Gm-Message-State: AOJu0Yw5uGGFN+Hf5pLSUAqt/xrY/gyGgZGm2r64OApWia7ihAQP56zc
	C8NcNjioeWlOqmAeedhuNqRq3nB+yn0PJhiBoIpI2soHJjJ7dgUJt+nsc7UaYEY=
X-Google-Smtp-Source: AGHT+IH81+w6k+TQaik05ylbqjz8CnYcPV1ycpSNlZDF9OhyZUqOt80kH+mbZX1sYBLGSYMqYQcTNg==
X-Received: by 2002:a17:906:b7d6:b0:a3e:b21c:c7b4 with SMTP id fy22-20020a170906b7d600b00a3eb21cc7b4mr5548757ejb.42.1708530383480;
        Wed, 21 Feb 2024 07:46:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id jw2-20020a170906e94200b00a3f0d98c125sm1499114ejb.155.2024.02.21.07.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:46:23 -0800 (PST)
Message-ID: <908e6db9-0323-40b3-bda5-02b0a645e4d5@linaro.org>
Date: Wed, 21 Feb 2024 16:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@redhat.com>,
 Erico Nunes <nunes.erico@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:41, Arnd Bergmann wrote:
> On Wed, Feb 21, 2024, at 16:24, Maxime Ripard wrote:
>> On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 15:48, Maxime Ripard wrote:
>>>> On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>>>>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>>>>
>>>>> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>>>>> use on my arm64 boards, does not have any problem.
>>>>
>>>> Is it relevant in any way?
>>>
>>> Yes, because it is justification why we are doing it. Each commit is
>>> supposed to explain "why" and the explanation here is not enough.
>>
>> There's a why though: it makes Fedora boot. It might not be enough for
>> you, but that's a different story. So, if it's not enough, please state
>> exactly what you expect from that patch description so Javier can
>> provide it.
> 
> It's definitely enough for me. It makes a lot of sense to have
> a defconfig that boots common and popular distros.
> 
> I don't use ZRAM either, but I can see that being useful to
> avoid swapping to SD cards or eMMC when that is the only
> available swap device.
> 
>>>>> I kind of repeat comments from similar patch earlier:
>>>>> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>>>>>
>>>>> About XFS: I don't think it is needed to boot anything.
>>>>
>>>> Just like 9P_FS, NFS or UBIFS.
>>>
>>> NFS is often used on targets, e.g. my board farm, but also by other people.
>>>
>>> UBIFS was added recently because one device was using it - you needed
>>> it. 9P_FS looks unnecessary.
>>
>> So all we need is one person or use case to require it? Sounds like
>> we've checked that mark here.
> 
> I think we want all of the above. We can probably drop ext2 since
> we already need ext4, but that is a different question.

I'll send a patch. Ext3 is there as well.

Best regards,
Krzysztof


