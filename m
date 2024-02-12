Return-Path: <linux-kernel+bounces-61444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB8851272
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188CE28145C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C139861;
	Mon, 12 Feb 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWlI+1Hp"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60523984B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738008; cv=none; b=Lo/1h4qwhONQ+cGNcy5MYFZSP0JYS9yukt2HMgCHqczd1uVf1lhXqxK/xu9DK2/49do9ug6LzELofUQ0JhelXDi5wonUzXV4DnFHzgKmJ70Om+ONIdssQk4DT6gnX6IX8O66IwDqtXWeYFgZX23nQn04rXJ/Lz8sDBYTalPGASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738008; c=relaxed/simple;
	bh=ygE4hjHtvYFk9ynQoR72pqSQFtSB7oKOejQq+q0Lgi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK8zHlhCNq+QEEZ9hQijulFJm2MNamWgBIohUditwUsugMZhGvF4ERWGIczMVlVvpdXj5gs8k9dXy/YFkgbf2L1I+OZg6/4Zy/f07mh0kl+JKhVURwLmAGYPd+MdsqstqIP1YXNWHYEO6brvqvdhd+JAdY6M4K3X+ugx1fK2sbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWlI+1Hp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so38825731fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707738005; x=1708342805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cix5ZtnoCmOIiuaEuRec/NdTK0f9SpFOdt4zCyFXUrM=;
        b=UWlI+1HpVzBxan1KEwvowelvmLsK8K84E3T06ebjDV6np4ZEKiaROEZubY7z23Zjke
         urAz4MzUai2LG9OJ3SLqgG0aXRjiP2/GuGQoKe5fBLvuvv3mV6YLIJXv9PDP43Js9peS
         2O/D9Ar2rwL/oXyYDi7mC2SEVcUby8+N/DWKrkAket33L6OjQEvtbLvr+6Vzfd0X7UuD
         NKcxw092CsEoxABBEDhDw2XxuDlTMG4a3B3nFVw+hs25FbhZJstKva1nehnZeHGZGfzR
         YqZXwHfZVFIXMa4VTV4E7SyFg4DAAdZdD7KEHfTLhy0nVqyhLpf1rV5AY3ZqPaFceZ/M
         t8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738005; x=1708342805;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cix5ZtnoCmOIiuaEuRec/NdTK0f9SpFOdt4zCyFXUrM=;
        b=SyG/rKOCRUQ0VQVzFrsk2OCM9u+tWu7HBFe/+d1/w6uCqGXsjoMyvCwT454B3JHqAI
         JeHq2DtHnh1z0UiFaCAj9gah4lzadfv5V1zQyTg+RJdXHXx/bLahC5++iZXxJbmRLdda
         YUlshmJqDZRXSJPde3eJ3X4SnGsVDEHooKazl6NmykME9JptTre6jOa7dE1oaq5WMjoz
         99l6i73V5JOHofx1WH80RjTMXnAADDPYr6EW1pYWQYriuwslbP4J6O7dfJgoSF9t3Zlk
         bFfU+zDaSieBdpGaFC60Xq1Vmo3lzRfOVZ8dK4IQkIOc1u4+tctIb9w6ToJJfan5oDoM
         fy0g==
X-Gm-Message-State: AOJu0YyTRol2HwiLxfI1y8C57xzDCYI18Za1QX0pVgKFjiCsM7/q2tlO
	rujxuL98nS+7Wj9yEqyLxiwfJw6GAKuZQO2gY6yNxhVN4mQsIwKrcHJ/NlCntkI=
X-Google-Smtp-Source: AGHT+IGOtW9v1V5/2nMwqpHWs3AVS5Ok+hRTyzTz0Mh/YtNXUPnumH3/sVgrog69xf1525AgyMYb6Q==
X-Received: by 2002:a2e:a0c3:0:b0:2d0:5f2e:5b35 with SMTP id f3-20020a2ea0c3000000b002d05f2e5b35mr4432794ljm.30.1707738004956;
        Mon, 12 Feb 2024 03:40:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURfTC8OcuRPlk7TCM6aiGxC9JvFKALb/B5thA/6YANJ+ji6U+EHtkWYNtHF0b5TJMvh7OjQn3n39LbhK1H5kvytxaZ+fUnKufqtLm46UZqaLHCIIT0c/L7SEgZaOLpw2trHMLDDrCgHBw690Hyut1VhFOF+V/kTZzH1ioh4UuFNMhTF6zUG2nzbvaSpRSjA+vqsjWpFYbTsRqDlTHWJaaCrOFUMHmClKjhctplZGa57e6bDpa6tMOZLQFCk+Cbkz0W2Pr4gzTARaPisfculr+/6gglpFrtO8RFsK7Uj5iBzvYZRD+2ajTQ3XDrPdUoRAasJ9t8KqXL9FMxWw5oA5sYgEe4XLM9Hwq7rfAx4+qTCI7eI1gFgKuXxlblvUaDOquDS10LT49WKgxGP1W49l32rqTZhNkEJur2JikFyIjOTra30dATZFaaMqYmHYzXf3iBwQytiwzj+ENFg0J+mEpo+GmMFUSrJVsMFoNkfBj3nqTH/Edbidb142M=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b0033b4f82b301sm6664027wrb.3.2024.02.12.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:40:04 -0800 (PST)
Message-ID: <67a6564a-00bb-461d-b7eb-ca169df6d251@linaro.org>
Date: Mon, 12 Feb 2024 12:40:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
 <170737972037.52344.9107022607101399076.b4-ty@linaro.org>
 <5972b6a4ae8669e2a9e872278b740b182217906b.camel@linaro.org>
 <dce39e15-32a8-482c-8751-af4a133f82d2@linaro.org>
 <c16c1f18a8c6f33a608618d4ccf7d8c8dbb6f88b.camel@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c16c1f18a8c6f33a608618d4ccf7d8c8dbb6f88b.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 12:30, André Draszik wrote:
> On Mon, 2024-02-12 at 12:18 +0100, Krzysztof Kozlowski wrote:
>> I can drop it, but the actual problem is that what if downstream keeps
>> changing aliases? They can do it...
> 
> We won't care at that stage, downstream should have no reason to divert from
> upstream for numbering at some point in the future.

What do you mean by "no reason"? The reason is they can do whatever they
want. Some project leader says: "I want this" and they will do it. They
won't care about our upstream choice at all.

And then what, you change it again?

If downstream was caring, then they could pick as well aliases which we
already committed.

To remind: the downstream was released 3 years ago! So the downstream
DTS is long past "beta" phase and should be considered stable. If they
keep changing the aliases after three years, then they can keep doing it
for next 20 years.

Best regards,
Krzysztof


