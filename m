Return-Path: <linux-kernel+bounces-45885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D684378E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD11C21F25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499D55C10;
	Wed, 31 Jan 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvD+F+qU"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E452F67
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685434; cv=none; b=R2N4kIIdOl/B/7lSNDtd4i59ICgj8S96jr8d7wu29j5gfmUZBvrEyk7zoOXuDvE+NoYW3OBoxwx/9E9fy30m4sCeR8aA5hrhW57WYDiLIERaxLsBDQzK1XIsou5yB2jKEiDwYGQ5hosEwI1eU7K49AiVAmF1+FZUhkuILZ47ycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685434; c=relaxed/simple;
	bh=52mzFLWAFvVzRxI56r6tpAuhNOUFxIvuX6pgMmHBP6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2MsLypzOIYwnoi1Y04Qe2d4+v+SBY3QCCug/wFg9abOB8XpmerIyMdAFANQ5+yHSVuiBuIlJUfJw9FwE1CcR93Z1rGDPmWiHgwFqDbPe4YeFfrq9SSuvHSThVYKqhuvhJohx/XRAM9XHQ042qxTaK3u/Ra77mqiOYcJhIGaJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvD+F+qU; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c3a14c6e7so26050886d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706685432; x=1707290232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJNMWA8oodJOdlBVGCcwoi584OUVTTefrAGCMewFxPA=;
        b=rvD+F+qU1YrqHlWVGVRjh3gcCizcm3TIkk/cF6QOC+m5eGD539yA0vo9c8XtRoV+rq
         xgNuy/htti5A/asFbu1JWQeXFkIvLN98v5tlMCMYDEkZoJDaTLBdL0mCbqkKrhN/cepf
         QJxdGPLPo0A1YKHdvm3fjmGBIyQiAnFkM3rtf8rRHJB3c8VMPMbahj/SoXJvxJgVQVLd
         /2uGlgimVsZR4M2f3twT2oaALzuK/rvfRLqHK6Vt8COD18UP7KSWjmSVcPr413ml/leZ
         /zUNp+eYUhDj8tDkPry0fpcXxhSaPtGrgJyEm+LB8RcSUWDGZXooJ6fja5quxeZTWaKw
         zXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685432; x=1707290232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJNMWA8oodJOdlBVGCcwoi584OUVTTefrAGCMewFxPA=;
        b=unYvYcZ8r55YPLj1E6obXB0WgdsHud7WEcqDj80oKe3nX9qWi8WgOmTKvT/s0z9SY9
         dGmVfoe5vwX0JhlEhju/2lunZHwCqhCGEC/xfGphkCfF6tot3+GKbsrQ5f/5YAw4SfP2
         9Dqh6YSXmfzmXuKloXVwFEJuH2Nug7CakgBUJHudX9JNj++MoQ5ed99pXAspxM+OkutX
         yRBcM7tjprXtJxYIbGY3CvrH6uhuKOzUsm9BjgLMHzF125BBhbJf4fmiVcjv2I/VyAmM
         ZOVLNJOtfkpFmtTj8rt0XQSbB/FHli3GfLxC34NPY5dMYMo5KgVoWj6qkv40+WxOts/w
         USeQ==
X-Gm-Message-State: AOJu0YzVLHumEmb9GKXOzolHFszcfqrFg5+pLXT9JiHYdKxS1tAZs+u6
	Yhf+do6dKnc/sFsqdvK8da5V1UL9ybTIjehp6SWu4SC/hvqLgnQRr5NDWgO+mYs=
X-Google-Smtp-Source: AGHT+IHjInEn6XUTctkkJNMJ3raenJfOAafSvuVd9wPAH4LejKdHhu9F5KDMhgsewRgOV1BqmmVEgA==
X-Received: by 2002:a05:6214:3114:b0:68c:6d8a:70e9 with SMTP id ks20-20020a056214311400b0068c6d8a70e9mr787941qvb.2.1706685431683;
        Tue, 30 Jan 2024 23:17:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWK6O+t7W0CmybXUWgh6zXrTgYm2+YMX+q2YfDAltJe/PzA5+9e6prnfnbpF4zqW89aWGZaAAY0st4tD+CBtv9Eh3OoPgdxYnu0ZsECN/GtJCB7NrJI/INo1GWuOF8q0kyH4PL8DNnBduu8wLIYpW7Uq+hNRcw7x6nYfXwK7eIFKj9eo3jawGDmJaUq6vfsvqea6oi9JmYO+0fFoNXgZv161Qdknj6f2/HwqkQRnjUP4uKZGjoC3M/Y4J11zIMoSNP/u/LqmgNv7wzgSwCNGZTh7VKKB6sY9VEku5i8H7fOTAeMDcPdUesFbJeMHNngvgP92QfbjTETlDTKYrgg7XV4oTmQMEDomAzJY/uMF26UN+am5uIcLvY+55UOuyY+WRKgmtYbkvCzuBUf4h+mV4tj6j3LGEkDbaA30+LBEqy0I4IgH36gpfnorO6nyoEdrxSn7bmeN47Le7XoGwtRmxH+NJl3FTDkeBOVbosTdAPcFbbH5sO3f5ffAOreTBeI/pTeK4byVP2k+N3VPipjLBkXzFyp1L2PVYFFHxS3lsKTPl+GOgt9ExTt0TnhdulJOEP0PfpTBE+XZd4DlhM=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id y29-20020a05620a09dd00b0078445f63dc4sm978318qky.60.2024.01.30.23.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:17:10 -0800 (PST)
Message-ID: <4f013386-6e38-4aa0-916f-d38e8ce5cec3@linaro.org>
Date: Wed, 31 Jan 2024 08:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding
To: Aakarsh Jain <aakarsh.jain@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
 andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
 pankaj.dubey@samsung.com
References: <CGME20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd@epcas5p2.samsung.com>
 <20240130125748.54194-1-aakarsh.jain@samsung.com>
 <9a8cb901-8021-42a3-a13b-bae10a645011@linaro.org>
 <bb6e3546-a596-4748-92d9-7cfc1f5e2db1@linaro.org>
 <010301da540b$accfe490$066fadb0$@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <010301da540b$accfe490$066fadb0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 07:06, Aakarsh Jain wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 30 January 2024 19:57
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> krzysztof.kozlowski+dt@linaro.org; robh+dt@kernel.org;
>> conor+dt@kernel.org; linux-samsung-soc@vger.kernel.org;
>> andi@etezian.org; gost.dev@samsung.com; alim.akhtar@samsung.com;
>> pankaj.dubey@samsung.com
>> Subject: Re: [PATCH] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt
>> binding
>>
>> On 30/01/2024 15:25, Krzysztof Kozlowski wrote:
>>> On 30/01/2024 13:57, Aakarsh Jain wrote:
>>>> Commit "538af6e5856b" which convert s5p-mfc bindings to
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>>> warnings can be ignored, but the code here looks like it needs a fix.
>>> Feel free to get in touch if the warning is not clear.
>>>
> I am getting below warning while running scripts/checkpatch.pl on this patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #18:
> deleted file mode 100644
> 
> total: 0 errors, 1 warnings, 0 lines checked

This one can be ignored, but your commit syntax does not look right.

Best regards,
Krzysztof


