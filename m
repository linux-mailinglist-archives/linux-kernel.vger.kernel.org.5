Return-Path: <linux-kernel+bounces-120284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C288D551
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C52C2A5023
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C57241E2;
	Wed, 27 Mar 2024 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbhTlD05"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A82577A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512271; cv=none; b=LSWCgdSC3+2YejK0SBxIGADyoWOHeayBytB7gGe2rDPauAyNSKTSiJjBLEs5bfkIrY2AS47Vb9X6X5yxiupA6PDyjzOrEac3vhl5FJhNv7jSfERA4FgQZdjcG8qrt8irjrg2hLQGCLh9ouUMf7O77WyTpUJz3HYN6y6f8IgqRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512271; c=relaxed/simple;
	bh=dnWx/tOA3ujLDTRjAPgH5cNpRXyNmOoS+V1Uc6WEI74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5cg0N5DYnduHUURnrt1iuU4R4tkrqpS3HBCZqVoyNJEIv4EY0Wj5UPB7q+9L/D9Gr4Pz6pS0bMl5uixaCFmFfmoHOjtTssuQxf3fDkwaJ+PJEt93+Z5JvvdNY4sU8orQqc+5nuxJypn65npyYikLwJStjmL7KzdifLciRPidxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbhTlD05; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so833223166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711512266; x=1712117066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ylqoaINJKjY6KxvMr7XBu8tTBBrVTZkDyFAlF9BL3/I=;
        b=GbhTlD059MDl6RkQExk6EVfYd2nP52OEGB+NyDjTpqPS+9wg/zElGUBhQmYwTkbWw3
         /lZ+TGU2oREu/P+S5+A2mcT2mWTYe2fe0LebhF2XV7qlK7p8Y6aMG3U7CvkSjm/aRaXk
         8e/7UaIJi2RFVG1s3iP9Ix0glZ3Ykdk9gmpwlFVCTbYHQKdHezQem0zB819iJTudOjOd
         IZ0v/qFp5dntfZyqxnp+zEeb8klt+M5FeCqjkKYTKvpoUgYc8QP6diCbQCp0LRKV7A6p
         vVlgyLO16R8h9/MHtcXlAdz4oEUEZSW1URZn6W6OGIs+ISgFuW7DD58PKD/WRtb1o6Gy
         l2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711512266; x=1712117066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylqoaINJKjY6KxvMr7XBu8tTBBrVTZkDyFAlF9BL3/I=;
        b=pCh7sNVpCKMk+zgs4coqarhFYIPNU+N/cATMaDPqGRQi7mH1Wx7hNtHNq+NBK2OOx9
         SF5Sdps+x7RR9C3h86SArCaNCulpZ9rjoh+d2BhTAx++i16CuPWWQBZdirzhbZDBJIWf
         pS4NLvh4uaSLLLkKTGb3AWQKaweIJn1NpQbqY7jPRMgCPRhLpcdQnsXAdxsWXUh2z30q
         ZCMBVSU48d61w12hE2zX2Led+BzpPStXXNEzSx78Hvf0eoVRCobDdbQplAje2sd7iOK8
         eNG6/6SXuqlJxi1XfthK57BweYaaYJY4rdnz6/OSYzeA9d8wqaoJZwwwWndkkSHpqdoN
         K66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcE8rAkuKcrlhjMZ/29vup00cv77aCnaJvrql6uSRS+V/zWeN31s1IMNPJi/zlS0igkov26WhgQnRiV/6dp6RnKCTqDK+BhgAgyafJ
X-Gm-Message-State: AOJu0YwDhDrOD3tIop1/XP7ICUNSf9IsQ9KCn9PUzz3+vDUTFpJ1y1Ox
	bwrbi5ubnNDStbaUEuX53EsKaS19gZQ4MWcSNd/OsCBiBAGQ9WHmfECzMTYsukA=
X-Google-Smtp-Source: AGHT+IHLRvepEW/fgdeY0FRotqmd3js3U30b3tZgzw6lU1Fy65zuTFJVcFKec+SLMfuDkmHNZofZ6A==
X-Received: by 2002:a17:907:9449:b0:a4e:693:3089 with SMTP id dl9-20020a170907944900b00a4e06933089mr295277ejc.2.1711512266321;
        Tue, 26 Mar 2024 21:04:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id w12-20020a170907270c00b00a469be48551sm4912138ejk.45.2024.03.26.21.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 21:04:25 -0700 (PDT)
Message-ID: <b5938894-3e8b-4928-b82b-f13e5c196f87@linaro.org>
Date: Wed, 27 Mar 2024 05:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
 <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
 <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
 <68dbebe0-acaa-40f0-9a5c-fd49d265ae08@linaro.org>
 <33cb5ab6-1b15-4903-a5fa-f0d2f86fb438@notapiano>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <33cb5ab6-1b15-4903-a5fa-f0d2f86fb438@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 15:07, Nícolas F. R. A. Prado wrote:
>> Other reports, like for cases when only parts of patch is applied, could
>> be also useful but I am afraid you will generate way too much of them.
>> Binding is supposed to go via subsystem, DTS via SoC, so basically 90%
>> of patchsets might have some sort of delays resulting in dtbs_check
>> false positive warnings.
>>
>> For my SoC I check my trees, mainline and next, and keep adding list of
>> exceptions for expected issues. What's useful for Qualcomm? Konrad,
> 
> Is that list of exceptions in-tree? If there are known false-positives (issues

None of the warnings - C, sparse, smatch, coccinelle, Coverity, dtc,
dtbs_check - are stored in-tree. I don't think dtbs_check should be here
exception, because all these warnings can be fixed - it's just a matter
of effort. ARM64 Exynos is warning free since a year. ARM Exynos
similarly, but with one undocumented compatible and few bumps due to
intra-cycle DTS changes.

> that can't be "properly" fixed), they should be public knowledge. And if we all

They are "public":
https://github.com/krzk/tools/blob/master/buildbot/master_build_common.py#L26

but I don't know how to make them public and usable knowledge.

Best regards,
Krzysztof


