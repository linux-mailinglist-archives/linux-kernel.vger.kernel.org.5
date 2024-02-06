Return-Path: <linux-kernel+bounces-54468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E784AF93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1C2857A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23712B142;
	Tue,  6 Feb 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM2Ej1iK"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390D12AAE5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206575; cv=none; b=oCPugHLhTj0aAzTR+TVWY4kQxsnaMK18kWUmBXHdUUs0fxqO/U8ttqRMH6/9Vy6Itn2qKdBwnpsHJ+ldWj+gcQXtUe9gtYd6lROgJYbrSKDtxcVsBX+WLPxc74xYLAIkCG63D3bEVI7qK7WW00m3OTrp5BTBAvJ8CYTZ/2h0LyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206575; c=relaxed/simple;
	bh=IAYcVfIEefTzb9r/jF6UVgYVTXhDLRMfP/QVelM7FvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdJJLeXBuoIyHCFxIQir9rK8U76hIYR2XkcnS9BjyzZwV6Pd+FyPA4lrm2HvyHQHbZm9/5ZgZvca7OgLVSfWg91i27uv8CylNXYWqFvj/tmm11WGL+V7f6VVLcApYQm96ubi+QRmIrq4Q8hth/SWIh7vMb22X9/xvczBBR6s830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nM2Ej1iK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a8900bb93so38558531cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707206572; x=1707811372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/BOvPPP6eQRU8r4VxyRyJ7KpMAy4/HaHrxfYwTXIiw=;
        b=nM2Ej1iKjU3SOkBCZII0neiZJMa7+rYZ9xLTAWT8Byl7Dk9L3ihlmdaOh/0FzZlGNW
         okjbYXNHq86pul8I8WzqRJetwnI2BJRU7kUPXD4qFVa8NFSPcQO3VbA4bd/Dj8kQq1Ms
         kb2yjnptsXjNrXcOabyb23tAFP8Z2U6LJkgg5/RDUFJZN8rFTXtW+YzcVFz4Jm7gUHp6
         Gwd890gF7/7auDd/uD8jsqly728RW/xcah3UL0Gyh89u7hYMeGwXlbyeVByffLbpZh1e
         IyUoN48O7Aj1P0D17kr7e6r3BTJIRZNe74KkPEr+iGTgdlzajtEijBmZEnh2+GsUdovD
         BOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707206572; x=1707811372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/BOvPPP6eQRU8r4VxyRyJ7KpMAy4/HaHrxfYwTXIiw=;
        b=wka8Q0zFbD6KeqNQT6JS7qhmtNXRa3HULA+pf4fi+y5qyQIA2rjY7R3I54TWvFEEkM
         YRpXwKiZUA3/qfO/vTi0zg6Gif0GafIUQI2PuLXnVigxcxqNp4c3R3p+9RLnA8LpxtYL
         pmq3RKXFWOl1BAUyEd1f4bT7B70W+eUdkRJbjQCUscm0maJMx1Z0hJ12mT/CwHACxgc0
         WnT8JBruK2K7VJoLsx9Pyy7ITFl6mghbrqYZ3afdlJXahRPGH9Y7kvmqIgz4L05XXkZy
         4DAjkbVp1ngi9WpEKUnCpxSgEA4k67UlKuJRoTx7p3OoeQuUDSnHwfj6i61CjSc/J24W
         xYLg==
X-Gm-Message-State: AOJu0YyAY/6OewefPbpVj4lpgzK4uASvEjtM1lpRTZhXxuCd70yRdF2M
	1RbOJXaksCXlDI4Kn4RgpAAunM0sMR3gS28fxVhPM/LRBJSrMIEtiGLdlzUNL8w=
X-Google-Smtp-Source: AGHT+IHUpyNC3udm9w52KfXteldORZSTrL35/J9Cs6UWq8r/xyOicSO5VYld9SE0KYWGVbmTHQJi2Q==
X-Received: by 2002:ac8:1389:0:b0:42a:b2ad:21b2 with SMTP id h9-20020ac81389000000b0042ab2ad21b2mr1496686qtj.36.1707206572214;
        Tue, 06 Feb 2024 00:02:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvSMhlO2qsBqTOR9VWQHHj3ghx++vPHx+HFviV2LyV5Bh5dhaXMrCROdV0pzOl/ImimVcFtMatlu3FN1M0/XlJoYyRg4NMzlOo1GI6V5cNH9y5sIrJwRgPODBLTMQx89bBnNZySY7PJRcgZFsV33EFMKi27zsd9WBEjwfFHFZxmhkzeYLLxMd5gGxgyo9VO6y+wKwMpA7dhB2ZRgqReFJGOLP4tf/P7bZAq6tWTQzlbnL6ApskdE+LTKDXZdMtIEGAHoCR4g==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g24-20020ac84b78000000b0042a25f3950esm682570qts.75.2024.02.06.00.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:02:51 -0800 (PST)
Message-ID: <12615b4d-5296-4fd7-9395-6a7b6df27764@linaro.org>
Date: Tue, 6 Feb 2024 09:02:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl
 entries
Content-Language: en-US
To: Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240201140134.4345-1-tomasz.figa@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201140134.4345-1-tomasz.figa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 15:01, Tomasz Figa wrote:
> I have been no longer at Samsung for a long time, the platforms
> that I am knowledgable about (S3C24xx, S3C64xx, Exynos 4) are no longer
> relevant and we have people with better capabilities as maintainers
> already, so let me remove myself. Thanks for the nice collaboration
> everyone!
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks Tomasz for the work!

Best regards,
Krzysztof


