Return-Path: <linux-kernel+bounces-158122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420438B1BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1311F25162
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4121E6CDC9;
	Thu, 25 Apr 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7p2Loui"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28F6CDB3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029923; cv=none; b=Z4yu4tYEdhginhl4SWEV9pV37HO6xza+jyM9D5pXMO/jA8Z5T71kuIVmEcJQDHCyDGEVLic5Yfs1gYbcOVv9Ix42ZjFwVeZGUI3OlC24Mc4jlxye8NDVmrb+sLHfCiRZ/RzkcZ5G8XS+swVDrtESIk6yQdmt87+YL2PT6HeNdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029923; c=relaxed/simple;
	bh=TimvSs84J0VG+ppvvt3Vqdk8KC6q0r0cLQheUcuAQGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzWtmvsFDFTZcs/4qH2CCoLTW9aIno0MM8yKG8BJ8zq4AD4tYCILaaKsXfvqJYmr9UUipUor4eM+yHy+GPoTJYdfXSHUxEvBAhs2NyJdBdk7OKz4inAt/n3aLHZDptmpCS+MRHeTwdGY0AQigwJYbDSYAuFZSvrpROz2qPPskN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7p2Loui; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso315945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714029920; x=1714634720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TimvSs84J0VG+ppvvt3Vqdk8KC6q0r0cLQheUcuAQGY=;
        b=d7p2LouiNRaTMJX0aKk5adPATkXDrQI0YtWXXGDyYm7VZWo9E/rohuZRBzbsy3FcEN
         8pxJYYBfooSBDnCVOSXvG2yxwKUIs0GH5EX/rerAJJzV/KHY6+BB3/U2uhv6iaHAAR7Q
         2EEcQoUeb2q+JOlnjqUWhbuaa4NNTmngkZXFTwq86pWjqePtxrF+YBaXu4UnzwpY/mjY
         ZdA1X8xdhy9aER/q9ahsCyOelv22TuUY3bF5CHW68QVtS2gcNMeNCwDm4XQ32jI9ma6x
         H9p2ZFOJymEcLbuyXvQWQKJCeHXIgy20BpaPqAdX0MNt00yo+ncvlk96oBb61THv9jIy
         +M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029920; x=1714634720;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TimvSs84J0VG+ppvvt3Vqdk8KC6q0r0cLQheUcuAQGY=;
        b=USAe/YGrUN9y9hIAZq+Ubf5dY8/L/LK/kKLZH/lrtYsm0BUQpxE5iTaMjPjld45cHX
         FCqyZgcm1sxo//Ehkf2nwGP2vE3CbuboQKfb45zfYczyDh84/CRKj1yOEEbNi7bAZntd
         zb/zpNsyUl1LB9/JbPCA+CIgp+72fS0akWe7xE0GOyoYJInfETZ1oG9DCsP/4xryP2H5
         onz3CghHlO4bVZ3kN0hJIla4T+qScbX1D8QWdpP4AGmPHv6Cy+m5LSoEXVHWFBbKKLb8
         6nDqljzuzzlla+o6uOIfvU8HFQgVSUASAPNMyAEeJCJfoB0ptq4CPLlamN9IC+MR6zsv
         j8vw==
X-Forwarded-Encrypted: i=1; AJvYcCVqUfmaxVQnCX8Pr5MRQigiPV+GzeMjYGMPGaLw3UNnm2ebLKC/YXE7UuKO1oRArciFEZBYx7JdG36nIcmd/GasmVhLk58wNu2a9iK9
X-Gm-Message-State: AOJu0YzVvwCHAAtqJN28e+dERiEYgFzTZM+sLFMUwGpR8upPG31OL5db
	1fgJlpr6fC8Y6G0roD30FO2khPVj7Xh4AuA8b0KluwLbxD7ahR3xnJXSNC9MB7QStTK6vlFMJj1
	duN8=
X-Google-Smtp-Source: AGHT+IEqJlLlCxc/n+6hiZFTVXB2ppoR3eYxknvNBpoTwZiLJhPYWHYapinU5beqT3ImcZ2uExgPQQ==
X-Received: by 2002:a05:600c:510b:b0:413:f80f:9f9 with SMTP id o11-20020a05600c510b00b00413f80f09f9mr3490861wms.25.1714029920264;
        Thu, 25 Apr 2024 00:25:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b0041896d2a05fsm26056600wmq.5.2024.04.25.00.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:25:19 -0700 (PDT)
Message-ID: <635b89d0-e5e8-44b7-a243-c75fea896a8f@linaro.org>
Date: Thu, 25 Apr 2024 09:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for
 BLZP1600
To: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133241.19210-1-nikolaos.pasaloukos@blaize.com>
 <fd4072dc-7cd3-4d13-a15b-d63c675a5994@linaro.org>
 <c11194fb-0449-4b36-adf1-c15d7a66344d@blaize.com>
 <b9b3ccaf-7ad1-485a-9ee8-9a9922936e79@linaro.org>
 <77b837b8-600a-4ad9-b2f9-ee24450e8c5f@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <77b837b8-600a-4ad9-b2f9-ee24450e8c5f@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 09:18, Nikolaos Pasaloukos wrote:
>>
>> Let me rephrase the question: Why you do not have headers for interrupt
>> numbers? All addresses? GPIO pin numbers?
>>
>> Best regards,
>> Krzysztof
>>
> Thank you very much for your feedback Krzysztof, I'll prepare a v3 with proper
> threading this time, removing the dt-bindings for the clock & reset.

BTW, this is purely about bindings. I don't oppose DTS headers to avoid
certain magic numbers, like we do for several platforms already.

Best regards,
Krzysztof


