Return-Path: <linux-kernel+bounces-71111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE285A0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329F0281200
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0124C2563F;
	Mon, 19 Feb 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anFXOSDX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC728E2E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337796; cv=none; b=QTTF4rkaWuhpN3BGr15+OZmIDkfGD+OT3flpodMi/5VklPquKgfg2dp9tjVxQyhY9g+Anq8e+KtrJkiZWTXSeLzkNeVaXn33/9KzCLhD1T47ZtyGF3PBuWCmU+3dItaAq6Umnhs+Yy54+WqrbmAO823YHhDWgOgA2Y9t8UtaSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337796; c=relaxed/simple;
	bh=ddrK06DYYlWFp/8o1bKXY+MqFFxKPduBG+KoHpQXtnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQZGYLKtz5z9d37kSjoW+o5zxp5SyeVqrV4VnnM54SsPsJGDSqE1b33brLK7nKbfc8RJ5E4hTKlJWbJCH/XzdhKg4V1dXqoSuGT2wB3cYcyRiy2cIRuHoIHQCmiZ42M32Lmwm7pXRoMGlY8rnJ3/z/CITvrxcYKGD+7mYJzJOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anFXOSDX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6144281a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708337793; x=1708942593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7Lad/UmGJgb5525hSE9P/XpX6hMriuonfy0h/btJ74=;
        b=anFXOSDXGaWKLXnFw70c8JtAHphhOXV8mwldCzg6B5Dl9KCR0d8RKlZ011KBkzSyaR
         P47lRKxSF5Q4SiA9GRq1VXWYUfNF8Wg7xOAjqfE/IJRHgodsVUADT21bFDbVRKfKyf2P
         F7FpkvTuADJGExcOr6QWYFFuCAcP08Eib1g9Xn8O/rn00KehGmqu571SHwPS4o4uztus
         o8aHWPEdELhEgUHaePyHvQbWHozYstDWq120i+v+1SAHZGCi344S1mb22sx8mtBTGEg/
         3/iTvskGn4OuNjzRbiEsHgvq9fhi9JQC1WT7ifXXY+DvEGLoH7tNDNuP+yIlXiZ/eNLI
         ni1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337793; x=1708942593;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7Lad/UmGJgb5525hSE9P/XpX6hMriuonfy0h/btJ74=;
        b=PZ5I/xC2hPbebuXAHdHzKNKgW+2NRfqRV7XPr8hYmqPX+Y/m2B6XXJMToM4lyX3B5v
         2p4+UtaOgfK3u/YD6ziy0b6BpoKiOTRSo7WAZGte7rtM07bRYtW54Osm/1sEq2Puzt0q
         9dxRooDrCPTlRLxWLpYYZgo7aVlGUw7H8cXJ7DK9OrxyKHN6pGFk78PK/SNebuUrsraX
         2vSD9zRYuaxLjKH/n4vt5ZfAaac/VPI5i2sWSNzt6BippgjbGfcCRIpwkkdBxyYWjZAL
         CLby0DmJPRqw5oelGc7NxCS7f2a40KBJ66uem6G8XiHgoVRcxC9DgTZ/YKtBgzHLN5Hd
         Gc3w==
X-Forwarded-Encrypted: i=1; AJvYcCUl0E8W3ecfMLKd3CZ3wWaC+4lPA9NoWDQOSqbGJHSIBXJFUUAM8rYwX6v2/vztRvliQlo7JbRGMMp1zn5AaKXrbBSDycVpH5d68q5s
X-Gm-Message-State: AOJu0YyxuFAE/ZGucAyh8LzEf4j4/Q+9EWc7/jgtsHL3k56U5ZgvSVT+
	cQ+1glYoVGY9cPJm5fTz9X2YVhtmKods3UKW/4MWO0jSu9LPHOJ8wk2LJsK2NKQ=
X-Google-Smtp-Source: AGHT+IENa4i0UQzIyD/tV/wQnoCaQZIG2aVhQsRIDX2/LE6pQ6khHX1I6mzlZXGgqlAR3Yp8LR32Yg==
X-Received: by 2002:a05:6402:214a:b0:563:bd95:4e8b with SMTP id bq10-20020a056402214a00b00563bd954e8bmr5758346edb.11.1708337792697;
        Mon, 19 Feb 2024 02:16:32 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id e18-20020a056402149200b00563c63e0a13sm2562753edv.49.2024.02.19.02.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:16:32 -0800 (PST)
Message-ID: <85538095-9550-4b24-b147-bf765c296a01@linaro.org>
Date: Mon, 19 Feb 2024 11:16:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
 <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
 <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
 <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com>
 <CAA8EJppuNRB9fhjimg4SUR2PydX7-KLWSb9H-nC-oSMYVOME-Q@mail.gmail.com>
 <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.02.2024 05:29, Kathiravan Thirumoorthy wrote:
> 
> 
> On 2/17/2024 10:15 PM, Dmitry Baryshkov wrote:
>> On Sat, 17 Feb 2024 at 17:45, Kathiravan Thirumoorthy
>> <quic_kathirav@quicinc.com> wrote:
>>>
>>>
>>> <snip>
>>>
>>>>> Reason being, to access the NSSCC clocks, these GCC clocks
>>>>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
>>>>> should be turned ON. But CCF disables these clocks as well due to the
>>>>> lack of consumer.
>>>>
>>>> This means that NSSCC is also a consumer of those clocks. Please fix
>>>> both DT and nsscc driver to handle NSSNOC clocks.
>>>
>>>
>>> Thanks Dmitry. I shall include these clocks in the NSSCC DT node and
>>> enable the same in the NSSCC driver probe.
>>
>> Or use them through pm_clk. This might be better, as the system
>> doesn't need these clocks if NSSCC is suspended.
> 
> 
> IPQ53XX SoC doesn't support the PM(suspend / resume) functionality, so that, can I enable these clocks in NSSCC driver probe itself?

Surely the platform can s2idle..

Konrad

