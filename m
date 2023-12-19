Return-Path: <linux-kernel+bounces-5495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54282818B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E2C286D83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946C1CAA6;
	Tue, 19 Dec 2023 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pK/pzInh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6311CA8D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-552ff8d681aso6677976a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703000378; x=1703605178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esP4uiftdE0csnkmTVCbQ8X8amlWSskzkqGnrY09tY8=;
        b=pK/pzInh0Wa7tcsJCkBFNT9kDb6oJgXlGCrfdMCmMzg2Cw2fRMMgr7pl+7vBEhsw2n
         8QBdOFHBQS/+KejPDvv8QyG1XnsGWGNO0O4pvRPjkNsTxLBj/8ITmqurMh4AROi6y6A8
         kTV3fKbdM0T9LUzbXFUJDJWu4GuTJSYHcA1cvLZ/m9sRC9WjB9Mb+2Jyp/RUnEfApnhz
         PAhuMdx0MHcPMxJ3wlxA0B0QTo8170ivU1X1iYKu9XaMRYp7Xo/4pgcN4lfpIC7wlB1W
         ofoU4eqxrPDEr2oymiTPzi5/mElM9eJInHhZYXGnaoQG/Ks3cJUrSNMONMT2GZkhP2gv
         uIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703000378; x=1703605178;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esP4uiftdE0csnkmTVCbQ8X8amlWSskzkqGnrY09tY8=;
        b=jpr+ytDdf17mLKpwdTp1hT5iEcmlyuwFMKjT4p6wO/nVvWiuluWPg0fGb+PYFfQjNa
         a4KKJG7X1adoakVfe09iW7kzH6mZ8G99YyV7iAxxe/XyPTPffWATrxNaKxTKYPPWCO5L
         UIXmJuktGQLK6sWnDP9Izh5jVXTvSxM53NCvPf8OUFgoETJi0fCkPqJx7SBRnm3SjC4N
         zgGGSsjYLTYvMfsHwv5bUgnL0JiVgkpM9mxn6oeMeMKT9JEu/On0N9c2WvnCJzuqughr
         GJ81qSum68+YSL1jDo1XT4IAISSGdJ2g55JN45dmfVNMXgoXb55yRZAAtbm1c3UnoRAm
         hTMA==
X-Gm-Message-State: AOJu0YxkkMD6Muc8omN48ARGqKTF9HNJmBfvp3gyU1dfa2Fjs5o7AQpb
	v597PRmhs7cGoc2NkfxG8OriWA==
X-Google-Smtp-Source: AGHT+IFRSqs3WrLcF6uUkEcATY0ilh4RKpIA1STPR+ujjhkHbDMIZYEriyYzG4GIwT7H6xwI50SuFg==
X-Received: by 2002:a50:c35b:0:b0:553:9ad0:1ee5 with SMTP id q27-20020a50c35b000000b005539ad01ee5mr1116251edb.37.1703000377981;
        Tue, 19 Dec 2023 07:39:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a5085c3000000b0054ccac03945sm11543717edh.12.2023.12.19.07.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 07:39:37 -0800 (PST)
Message-ID: <f6241b58-202e-4624-ae83-ce52fc286edf@linaro.org>
Date: Tue, 19 Dec 2023 16:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
 <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
 <4c31adc5-3fc5-47bc-9766-6d3d1eeddb65@siemens.com>
 <fbb29d81-9ea0-4468-ad47-f6668c2be277@linaro.org>
 <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
 <3d2662be-3a55-4390-bd2a-cfa5cc53510f@linaro.org>
 <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
 <ce6b002b-f2a6-4056-bf81-53a6c948b946@linaro.org>
 <62be89bb-1ae1-4bf6-9f9e-b6eb68e6504d@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <62be89bb-1ae1-4bf6-9f9e-b6eb68e6504d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 16:37, Jan Kiszka wrote:
>>>>
>>>> You have label for that... Somehow all these nodes are half-baked,
>>>> without all the expected properties and now you call node name as ABI.
>>>> The node name is not the ABI.
>>>
>>> Well, existing userspace uses those names, and adding the properties
>>> would break that interface. Now, does Linux do that?
>>
>> I don't think you understood the concept. There is no change for
>> userspace. Same interface, same names. No ABI break.
> 
> I do understand the impact very well:
> open("/sys/class/leds/user-led1-red") has to work for all the variants,
> consistently and backward-compatible for userspace.

And it will. The name is the same.

Best regards,
Krzysztof


