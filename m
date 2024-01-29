Return-Path: <linux-kernel+bounces-43010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBB840A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8BB25A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1C15444A;
	Mon, 29 Jan 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sm+GMl2y"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE115442B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542787; cv=none; b=AfNn4Qa/zlF2A4bxEPtZQReVpEMB9afqPzjuNFl2Tdqh8BN05D+jJ/IiLQWEP9Id5YmnqMo6fjaQZHWOXxDGONfj8Dh17eHKCS51Ir3Xdq4wPAARAlut7N2Ni8Lwq2xcDc2mR2gUt0PLuOjBcmgl5dK8Weaz+4+J/c3Pao4owiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542787; c=relaxed/simple;
	bh=n9nCPEsYfSINBzdyiWwPDZaTjNh9Nu8piVjbdDNZNaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN+WFYW1sIa9O0wq9IosdADQeUAFbpvcOpDWUcczfkNxSofcgTyxhEDPZX08y1IeMLZedkl6uPdGp1u7hAeVQFWhmzC8ZEmq6y8GOa4iZT7oDIXV6N7gTgdvM5edlQ+re2Ww4O5/KFmxvX+3Se02ZPlz0RFliSwj6toBMTJK2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sm+GMl2y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a358ec50b7cso234737266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706542783; x=1707147583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkgPevqiSgLEurIHYt9EjLvopYwvRhZn075Iur8KFvo=;
        b=Sm+GMl2y8tOGKqYtPVNOq1jhjqwyPwwO/T18UJfhyBgXSDiSAss9BLVfivLp9M74dk
         voA+ol+TiiQ+aPTKom52KOsOWQXMHveQezNi7JWSTpNYpyBVMKAA1mFgG+LBB/vHnpU4
         AQCzcwGIIC85dmB9NFTNRmWmNbnGJ7edS+HdhjOJB4mmn6kZe5oNORF9Vqk6APBoWj4z
         x96LVpdu4fVkRZ8i7Fnc6beOthBoktgmy4STV+hDYVRSfDTIJ3qXc/kGhM128ibZb8RI
         +0/bvxWEW8c6hLCSh7IXmVvNlTOslBlSCrnakkG8PRJhZnrdc+3qA4WduqvY2qHCWAm2
         DCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706542783; x=1707147583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkgPevqiSgLEurIHYt9EjLvopYwvRhZn075Iur8KFvo=;
        b=WuesCZYl7mNNp95AeOapdmluShOjscwFScpWpMCp8/6BLN4PjKhKrtqByKedmLLniY
         YnuJBoJRgNSnrJuGyUiSDGS9dFOy0Q+Q8qHPphYlf64Mt00JElm97jKbN+savcqB+6sn
         hedM6DzBDYWu8hPysb0b4VvEeOL1wvFeCZjtF95CsYCfo26ozLXqL4in8LOwV+sMDnM/
         8N3Sc3VlZEqt8FnIIeor9XPa54A/5G+cVd4dqOpAnFBIjoLGg992Rf56xIU3rQfSsJH1
         7ZIn2RoKJuxq522jcBgFKv86yhLew/LOqSHp3YCuE0PlCxGMwusf/6T7WeXJXx4EXgUY
         xMIA==
X-Gm-Message-State: AOJu0Yw/c7bdrhS0nNY/5fVTmvqdo5r+Q/jIKhj/rgiNuO5NToopoVT4
	4YNAEsXigyIRLMf5/HNeqSJmfill2pfQK2q3AjP3LDGQqAijorP+g8fTBhi70No=
X-Google-Smtp-Source: AGHT+IFYdid04IRF9e/VP+vofbM/pi1HxoRfriJJXvBTTWK5vVVNdrOFgdHvYkqQr5MJ2VEfT5XIwQ==
X-Received: by 2002:a17:906:31c8:b0:a27:5fd1:791f with SMTP id f8-20020a17090631c800b00a275fd1791fmr7553364ejf.0.1706542783559;
        Mon, 29 Jan 2024 07:39:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id wb1-20020a170907d50100b00a3549e9cc45sm2802574ejc.88.2024.01.29.07.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 07:39:43 -0800 (PST)
Message-ID: <e25b28f7-5f32-4b37-b898-294d50adaf8d@linaro.org>
Date: Mon, 29 Jan 2024 16:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] clk: samsung: gs101: don't CLK_IGNORE_UNUSED
 peric1_sysreg clock
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20240127001926.495769-1-andre.draszik@linaro.org>
 <20240127001926.495769-10-andre.draszik@linaro.org>
 <74b63fd9-bf7a-4a88-bfa9-a975a4f12bca@linaro.org>
 <7d42f80acf7c8bd3882f5ac253a761c71de2034c.camel@linaro.org>
 <e845e0fa-846c-4f26-9d8c-79eccae72cc2@linaro.org>
 <7537f9d4c49a5f3891dba4a8f68ee7332f045cc5.camel@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7537f9d4c49a5f3891dba4a8f68ee7332f045cc5.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/01/2024 16:21, André Draszik wrote:
> On Mon, 2024-01-29 at 15:08 +0100, Krzysztof Kozlowski wrote:
>> For this case #9 must be squashed with #3. #4 with #9.
> 
> Will do as you suggest, Krzysztof (I think you meant #4 with #8).

Yes, indeed, the DTS patches.

Best regards,
Krzysztof


