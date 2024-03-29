Return-Path: <linux-kernel+bounces-124435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87189178E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226751F22B46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B66A01A;
	Fri, 29 Mar 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LazhTRsg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D576A33C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711390; cv=none; b=JeWXnSQw3S5eqql0Af69QaIt1YLoZ6svaOo3Ht4RhDIq01FrN6B0xZHrLYT+zZB9/HXiW75UIQgNUJhkTHFqPkii6hElsMb8VTSptiGuRbM3IWBdgHLSSVKEUI0Ja9tM3nWChpDT7bVFbzCAXFBhlN+cWsvg64079FSUM98PhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711390; c=relaxed/simple;
	bh=40WtYJbAU4b30g0/xtT6+8q2lSioiXVNAK6CMQ5hwzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaXM1RM4aW70oQuVss+4yICJ0aA+CvKHFJWUlLXNkXxbl2F+0sz7eHtwNqYuwRybiI3PFS284cpEa3hsh9j/MFxDYMmAcOUXSrUOLWjisGK4O1f1ERvz5C5TWhC+RTQq9cqz3jkuJdrxtCVtKrtsi9WaNYyoRKZI8yRD/hZrq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LazhTRsg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4e37d4f4c0so50844766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711711386; x=1712316186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lVmBSNWpQpi1Fd8w64VPbDT2lIt0Pb3m4TwwB/26vRg=;
        b=LazhTRsgDTATWf5QxrCp4CXvhs/gqWDWi+4XZvqycaWQSz8bU2UlZpC0wL4nImf28F
         v9sd1SiaeO+6pCcZrE1gfLpXWuo/DGKxaoPjzC0tCs5ybXiWH5YfY2GAEo5vMrAap68S
         YYauB8/p6ccFXcs5gl2+GxU6PhKU6d878ZIppJFvWJK487NTOAiUOZTDDA8/waQIQIMO
         8m3l/sZ8uvme9Fl1ApwIwgGL9MGTO2D3wG7vvLZmQGbqR8hTXV/MR/jxK/fkOWl/L5Ol
         a+W/Wp37xC28iOfmVfGrhYzRRL8FNEoGLOvvUD8NIhcxmeK07duAj8r5n/cj4HQremAv
         zM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711386; x=1712316186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVmBSNWpQpi1Fd8w64VPbDT2lIt0Pb3m4TwwB/26vRg=;
        b=Nsoy1Rm5e2+mXMewYvgk/hgE55BVlVNF/wP0twVQR9h0knmAWvWiRXLQMQlyqxjcIX
         kuj8dU0xz0RdCFAt049vyjLL3ioKvITK0RZGiV9o13YCtf6q/x12HN9+mPNPlYoKRmpd
         OiOI1O2XqjCyMcoB+2lCM+ZmSqzcyFiiMxehCmh4atu2+tsywa1//Wb+moR2WGFWzfKO
         c463qoBhbQFMJBWA/28R/dmfyPxQSBf3kMb04CNEnJq0g6j24SVKRk9OWQg6kWC/fk0v
         rI1cfoOrYeWnI91mR0YwshCC7YD0UObG5snK6DI3RyBrs6rvPiQkB066dmGOUrFZWLO1
         NxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBQJCz2GxnZIsvP84oNc4sPwXFul/dx+OkZjwr85go0wUOdPFMTOdekHb34G8CPt2DymRwA//a2Sgl2sr7cG+VZJGKmxfre0Uvf0vg
X-Gm-Message-State: AOJu0YxATDQUE/d6+nxlprUkbik9SjlepG84/mD1CGnkLJy/IEGNN1JZ
	XLEdk388nIy3SUrTgsoBliCCdZj+UDk5ypn5zYHxMkOm+oLbYxKvj84+DFaG1cU=
X-Google-Smtp-Source: AGHT+IGNoup+3tVG4uto0ZZklAbiSvizNtkTqmmQZzXRlBNKHEjA3YKPEuQWJ1T8j+Y5jdH37ltApw==
X-Received: by 2002:a17:906:c78d:b0:a47:4be8:3c05 with SMTP id cw13-20020a170906c78d00b00a474be83c05mr1164748ejb.20.1711711386624;
        Fri, 29 Mar 2024 04:23:06 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090609b100b00a4e0a98befdsm1807270eje.213.2024.03.29.04.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:23:06 -0700 (PDT)
Message-ID: <b1233669-275d-4108-b598-db0ca7154056@linaro.org>
Date: Fri, 29 Mar 2024 12:23:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM8475 support
To: Vinod Koul <vkoul@kernel.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327180642.20146-1-danila@jiaxyga.com>
 <20240327180642.20146-3-danila@jiaxyga.com>
 <afcbb668-ab9e-4f97-9014-ecbd5170ab92@linaro.org> <ZgUf_I2KBMhenNEv@matsya>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZgUf_I2KBMhenNEv@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.03.2024 8:45 AM, Vinod Koul wrote:
> On 27-03-24, 22:38, Konrad Dybcio wrote:
>> On 27.03.2024 7:06 PM, Danila Tikhonov wrote:
>>> Add the tables and constants for init sequences for UFS QMP phy found in
>>> SM8475 SoC.
>>>
>>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>>> ---
>>
>> Worth mentioning that SM8475 is a respin of SM8450 on a different
>> process node, which probably forced some electrical changes.
> 
> should the tables be resued from 8450 instead of 8550 as in this patch?

No, and the reason why is my message above

Konrad

