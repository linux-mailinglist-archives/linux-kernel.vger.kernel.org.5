Return-Path: <linux-kernel+bounces-107017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC6987F6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1272A2825FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262245940;
	Tue, 19 Mar 2024 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIXD8swa"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F4446A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826817; cv=none; b=XZT1UQ4AnFDYOpWCOnfRZhQ2vcL3iv/1rYU4yEFkJdN8OdoMXM7jGnXf8aEAs2K7+DU8qGwZh56FGwbVnaA0333du7crYaBuYIGJemQlacMlXd72mzP1kB0CSgxWgCOz5Atbdc+Hjs3S2U5mJ48jLnAUN1hyAbzrw3+3Bkkpre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826817; c=relaxed/simple;
	bh=HH/JZhkydY05sA0Nccb/eagFi3pmvPYtnU/rWasXdWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOEhaM9QLEsqIXZ7dYtFP5c3kClv7SsPdBR/7+OGOqwE/KuBbzMnl71wLOLf8cmfRYl6g2DV+j/JZkoCQEFVStW44xSRdhy/g39+ot73JBnsM5H5eoTP6HfDvzO0DoaYPeoAZi24U/Yn8GTcLCjWaOdV/EtH+vjrsUzK9Dfl/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIXD8swa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46dec5d00cso29051966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710826814; x=1711431614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yg5l6ONBUvmCbF22a3St9SgW/zyEI2z95zA2tWCdR08=;
        b=VIXD8swaeZK/g3+zVGABZJFtqd+JElbBGoRe1gKPE8Hswn0vZX8IeflxVeC6qh6at3
         om+s4lvaqvVb+aIeHaIhMkzIbvltIulTMz9PQNnwwGTbabSrYyi8vGHXPtwuWx/em0ig
         ywwSoz0PFIujGm+Jp11dMmL39OABbhOoAs14YX6RH2z9D+fwmlQRxaO5sIYZZTben0y7
         Xdi8eHjxqnBpM4joz4ibyXUEqwztW23wqEddRbPbVrBlJzNi84lcvbray39iGU9KwtnY
         WzPqwlfEbnLunxrLtVI8DPFe4rYTtUq9qJgc54hLBAD0CgvqJCAWqxek4dnZfstCnQXR
         0qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710826814; x=1711431614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg5l6ONBUvmCbF22a3St9SgW/zyEI2z95zA2tWCdR08=;
        b=k7kim7H95ThcQc9Pe5jiBR6gx8awj3VRTavlULP4gFT4FEeHSdqw6FBI+ybXm71E7t
         toMxKv7rc1ibYSN/GnqgmshCV2/DytPhI91Spar8iSocVZEbTDOyRi5pXr1pPOv34kRK
         Ev8+4LFzTvs4jFfR7YXTDbZaZfNbs0sdtaIy/Td9/L6m2b3g42VBSDmELqLF1E9Hxoeq
         ceeiEm2TTALGrhgPu1ohN5WUjGLjGoLMkLUULfB78j/wu/Z2CQuVn0d/XeKmI6BHwDmO
         rxsVOMAPCUU7beKukxJdNZOj+11oOh7VOhgnr6J5TGgwSGbC0yYUVB4jNCu+1+ZWHpgj
         BmPA==
X-Forwarded-Encrypted: i=1; AJvYcCV+R/WjZ3SSVQSJIX8wiHPQMKLSpj+5y8o0HHmbsNOeZ9opSQXU+/plqxOX/rPYpZKERhdm2QsJoO/92xJwBmlaVd9g1giDebmwU2aK
X-Gm-Message-State: AOJu0YxnJSNeW3AaT2a+W+Gigwq82E/HbSOkaIxlpKTISB5UkgZ9qElK
	M6Nbz7dO4w/O/Lw0ytej6nFv+5qs2TNcR4COiGcUOUE9htwQu7l0eUpzI6YlBY4=
X-Google-Smtp-Source: AGHT+IE2UEluGxpI/Kr3fxuhDBB7SjJ8zSFCQ8tPfMeJQ9Vksmge4NDVty9dQTk2HEYyTgJ6q4yADw==
X-Received: by 2002:a17:907:c283:b0:a45:84e7:b265 with SMTP id tk3-20020a170907c28300b00a4584e7b265mr12092832ejc.7.1710826813767;
        Mon, 18 Mar 2024 22:40:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id sd9-20020a170906ce2900b00a4628cacad4sm5622163ejb.195.2024.03.18.22.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:40:13 -0700 (PDT)
Message-ID: <2fbb3c68-568d-40f5-9f48-139db9a1d7f9@linaro.org>
Date: Tue, 19 Mar 2024 06:40:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, Conor Dooley <conor@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-2-tanmay.shah@amd.com>
 <20240317-overturn-frozen-b152dc552a2f@spud>
 <1197b7f7-c43b-4ae6-b914-9e3f547810bb@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1197b7f7-c43b-4ae6-b914-9e3f547810bb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 01:37, Tanmay Shah wrote:
> Hello,
> 
> Thanks for reviews, please find my comments below.
> 
> On 3/17/24 9:50 AM, Conor Dooley wrote:
>> On Fri, Mar 15, 2024 at 02:15:31PM -0700, Tanmay Shah wrote:
>>> AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
>>> Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
>>
>>> Only difference is power-domains ID needed by power management firmware.
>>> Hence, keeping the compatible property same as of zynqmp node.
>>
>> No, don't be lazy. Add a compatible with a fallback please.
> 
> It's same IP on different platform. I am not sure how adding compatible string
> adds value. I will refactor this series based on other comments provided.

Judging by your other thread, it would add value. Also writing bindings
asks you for this.

Best regards,
Krzysztof


