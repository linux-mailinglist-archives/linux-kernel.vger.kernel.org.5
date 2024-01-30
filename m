Return-Path: <linux-kernel+bounces-44281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53646841FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790FB1C264C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA966B5D;
	Tue, 30 Jan 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgD+XqZG"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2266B57
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607602; cv=none; b=pRWeIALkc5PZs4oeOiCPJ076vhfARYE5y/4Tl/LMLFfgGIjXnStm24NDbTr7Iowc5aGraVs654wuQzCb5tYOHJW1jEHX9fdp+nQQUtSSUl8Ku46QmGvahBDc1chY/DAovfqqhmrYlyw7aTsJkcr0lpEgDJGGPEwy0PyZvna282Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607602; c=relaxed/simple;
	bh=sqjBSjiIAiPzVydwvpARikkoctAVPgNVNSiqqVZayNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMFQMlsqF+uALjz5gDBxzn0RFKIycVQT9a5F5MGeb+iWEpD2sJnkSE8ycIkf2rLUWRoKE6tUpyuFgP/qbzlfXjVLVqyoEd6XbwGjp02S0qNwf0RnIKema6qr435mTlnwPzEkoTWze/pOruoc4vh7tF0rp2+EEmjk2V41WJqXNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CgD+XqZG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a36126e7459so76816566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607599; x=1707212399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9cfPb4W5k9B4duDj0ed74N38vchVtwGZnJWXfHN68Y=;
        b=CgD+XqZGNTcEe6d+oXBxts1dhp02XLSJ0cyrgQ2aKmR428t5naHWpTnBfJhFzAU3Kt
         hpXi84J4YS1XgiDzFtpEaYfTSP7AUCb+uBhpx57FfhOQAktYl6EeVeGWxKU3LzHe2u/I
         +f8oZuxyQDYgdmL5C9ofrX+WM2n9dkdGQEbDU/tEskKFWnZ3Y1JZ95ODwUcGHUNZH50R
         +ydR4yrl9Ej2wL0v5RiignGzBr1rc3qxq2soEd5GiOtX4IE3hVyrpQN6uvAmNNYnOsl4
         ArigLJIphTKorDDw82mmznicZQtRVEzgQZgk+fTXh/IIB1udALFzkaBMV2OgSOK+J+qk
         JXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607599; x=1707212399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9cfPb4W5k9B4duDj0ed74N38vchVtwGZnJWXfHN68Y=;
        b=YY1VYO4LobQIuFkXgDDCAAXwJ0D253zaId839eUoI76nqtpqt5LBbuikifnK1pDGlO
         +gnrbTNHKd4pLry5hw2ZA45iGyJqIbs45JmXucwjBKSBJZqKYsuPYLhmBSDkugxLzu7x
         3Nq9+iHxt/OpKuSCsSdXhCXKChoJ0LT7GEqTAQKEP+yhOlN/JzDEnCq+WE4XmuWUTNDC
         xliIYTBOfqYMCjnbv1uNyT51C+W7WkSdg523I4oTwa1sWS4HTx6KtLy/CxCi4pjFq6bf
         ZzSuQ0lzuXlb0QVb7tXj7dEHdzaYpuagRqK1axRA7kUD6FGgMgukg2MSoIpGoPZA8eMM
         r+vg==
X-Gm-Message-State: AOJu0YzYHV5tUTXcR+T/9e4rrYn5ufP3h0jATpdfuphcOpkBS5NmmzRY
	iNA4oS1tl7yHm3gW5+oTrK6/7xEkuWwqyu99aPpy7a97tRYfWsJ1wHCLJvH3W0k=
X-Google-Smtp-Source: AGHT+IHkd+Zd88JeDXPCLK6I9F6Ulh4JNK7qznck4C7apqUj6lWZusJ+ynHeltFvsS+TGJ1CugoU+g==
X-Received: by 2002:a17:906:c8c6:b0:a30:76dd:35cb with SMTP id gc6-20020a170906c8c600b00a3076dd35cbmr5961607ejb.12.1706607599085;
        Tue, 30 Jan 2024 01:39:59 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm4909455ejm.48.2024.01.30.01.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:39:58 -0800 (PST)
Message-ID: <06356847-edfe-4073-a370-90f57feaf64a@linaro.org>
Date: Tue, 30 Jan 2024 09:39:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] clk: samsung: gs101: don't mark non-essential clocks
 as critical
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240127003607.501086-1-andre.draszik@linaro.org>
 <20240127003607.501086-6-andre.draszik@linaro.org>
 <CAPLW+4mL1gb_R8PhKaMhwOUTa0GDqat_9W=348ScYj+hBarQJg@mail.gmail.com>
 <d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org>
 <CAPLW+4kSka+twSoZmQeMsh3RWermrGG-wyENrr14AmX3zZ2eqA@mail.gmail.com>
 <bbaab3addf958bc1f484a20ee0bdb65af05cf5da.camel@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <bbaab3addf958bc1f484a20ee0bdb65af05cf5da.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/30/24 09:31, André Draszik wrote:
> On Mon, 2024-01-29 at 13:16 -0600, Sam Protsenko wrote:
>> That sounds reasonable. But I wonder if that bit (about making this
>> clock CLK_IS_CRITICAL to make earlycon functional) can be documented
>> somewhere. Perhaps in the serial driver (earlycon function), or
>> somewhere in device tree bindings? Because otherwise it might remain
>> an arcane knowledge and people won't be able to use earlycon later.
>> Anyways, for this patch:
>>
>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>>
>> and if you think it makes sense to document the bit above, please do.
> 
> Will do on top of
> https://lore.kernel.org/all/20240119104526.1221243-6-tudor.ambarus@linaro.org/
> once that is in.
> 
It was applied, it's in linux-next. I like the dt bindings idea, it's
the first thing I check when dealing with new hardware. No idea though
how to add comments just for a specific compatible. Shall be a
description somewhere...

