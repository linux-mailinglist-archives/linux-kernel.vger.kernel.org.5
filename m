Return-Path: <linux-kernel+bounces-122673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D678188FB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA6A1F239B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972659B7A;
	Thu, 28 Mar 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFVXROwB"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84E56B77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617726; cv=none; b=gdz+XCkFATtB+14Li4XpzQBhYNveQHrNXo2Uie4O8T2N+RDe6q2LgyjTvYrxD3wCxxQL8YZtnzHsx74vOTDBK01Jct3AKI+jnLEbsj40/C11wcu7mvPjDzGKHKCsvNjPTkXvyJlydFmSwI7Y2DSAtEgGQbTTo3wSx81LSH1ZiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617726; c=relaxed/simple;
	bh=PWuxq/2CwP5hxfBNCaTdeZ56jw8z5y3o69HmqmrMyh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bx9RTys10QlL7/BPlyiQ+KUil9emKsz2ixbmQh7pg1h7xmd8OdzivV9RMAtDEErCWUboIyQn7p1H/3xTdiUvxfc/l2lyrtcOL6dOYkbwkJZ4LjQH/K5UpKLpkxjLk9wv/c2+OsvmHnQ9hvtjG0ogdPVCELfmg3cQUeqz3OiPwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NFVXROwB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso7630501fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617722; x=1712222522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VeJGr89MvdJCsKrJ8qPyuwdAbnPV1JKLjknnd6gQow=;
        b=NFVXROwBmCyZeakPlS+e5JEuY34x2CZwhJpjy/ecyl2zci5DvcIDc9jFIMb9ZhYErI
         IFS/34gj7msKPBJJHzhtSb8VgUAtmBWNcqC6b9mpRpaQog/70eYXVr9Yvuz2Nq+ox32d
         ZZCqAIqL0ANrN6cYzBlP1vSY5msGxIownUytlNHRM6+Qymameeez785bakdKd1Jmulet
         VPkwqmDOuKGWDRq8bgvG4dSKeQg948S+xi1t/u3zrCHtJB/0YHaQFhuFDijmlqRJKKNo
         U2yn1/qnsa9MYwOaqZLDCNcBEb6bWJ49BjmKklK1f+QwhL4jwrQYc/firREVsGOzYpzc
         n/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617722; x=1712222522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VeJGr89MvdJCsKrJ8qPyuwdAbnPV1JKLjknnd6gQow=;
        b=Q9NmzcwtGVRALl5YxPgWvOYscy47lvfU7AYRfDJipOgPSlYjAUzHceJ+l/h5xypIFA
         jHygmt4JJnjYac/Orr6sUlKBRbQkFV0S4Nj5HZLeIJRdTU1YPz+KFp4GPvK646vn47A8
         Fdz27MRDEmg/paxyfZw7aXNopgy/32YxriPlV34OhI6YfNWhGqFYVLrd2o3LwVAZA0Q6
         dJix+qviGWGreDlq59wMzpJVkdEC+pNGcMEi0W9QM+IBga8I8gTmkrb8MctJIjcJ/QxO
         rm6PkZ3ebtOcTgqx3Bij7lPEOi2iFX3BBU4xOVPjZ9xtEdeTIpj3NeYq6AvaLSZj0cuI
         0TiA==
X-Forwarded-Encrypted: i=1; AJvYcCXBPy/CxSA82+xx4QmuDgeQ7geQhF/1fs5XYtHK0ABCUWfWyuBHRk3P4cutZy1ubqkO2DDVog7pGv9Unwi46jpK13Z66zNBf2jnSoJo
X-Gm-Message-State: AOJu0YxT07yIarOj36l8Wwel0pmZ/LkDj5GBczgr0K7grSY3tqllL+R6
	d07NICFvvCXXjJyxvByrLRYdCGkn/yptRap5si814X4/AB9TpMBF53QChC/EA2hVe/OIoPSyplk
	w
X-Google-Smtp-Source: AGHT+IEByn/Uj2jLharZ5hJEyo1dPkVvQOyE3ocYG8KWTDMwI0bxSgFNh0HMP8KyA55NcUIHStpeDg==
X-Received: by 2002:a2e:b613:0:b0:2d2:6193:6d53 with SMTP id r19-20020a2eb613000000b002d261936d53mr1449773ljn.13.1711617722472;
        Thu, 28 Mar 2024 02:22:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b004147c8dd13fsm1678429wmq.30.2024.03.28.02.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:22:01 -0700 (PDT)
Message-ID: <9ab1fc70-fd01-437b-9020-49618924ab30@linaro.org>
Date: Thu, 28 Mar 2024 10:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240327220320.15509-1-l.rubusch@gmail.com>
 <20240327220320.15509-5-l.rubusch@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327220320.15509-5-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 23:03, Lothar Rubusch wrote:
> Add spi-3wire because the device allows to be configured for spi 3-wire
> communication.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I don't understand why after my last message you still ignore my
feedback, but fine. I'll ignore this patchset.

Best regards,
Krzysztof


