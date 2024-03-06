Return-Path: <linux-kernel+bounces-93491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E432873093
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D58B28E63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE395D48A;
	Wed,  6 Mar 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKCZTUd0"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FE5CDD2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713296; cv=none; b=EY76py0vonYInetGnLOr8DTFmRA6zM59rMyum9XCbgUP3E/pOIsB/GZj3me7hJVk47f/+tnQlaaVmLsQucSJCkRHc6eIOEQSvzJmOGfS5yZ3wX7sGoMYlAaB6XdoSRaXGO/N3WZ+X2+OrH8wTDHA9Futnpa2kNJeowE13xG8tFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713296; c=relaxed/simple;
	bh=UvsZjDqPT1S2Np84REw+zWEhb+wHYVxM127m3ZQEIZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+ovE2FvWybbYObeuQUq5d4DfHSnxtGxzhLKOVlzeVN8FsE1DcatFPP7BAqlzp/1CvaE3wt4i/9FYNhJZvLFa6oMokkDQTD9Iz95EXWHwJRq0s2TgwVRN9IBI/FJg3hsdsQImzcSnRuR84lzJuAk2zTnssSoE/U8jJ3UE9rpsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKCZTUd0; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c870863216so30456139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713294; x=1710318094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8aTtUjDS4K2DXIpYTlNqMZB+SKPeqhA/7PjV1CZm4Q=;
        b=WKCZTUd0xr1DSS3wJDu9vn/zqYG7BsHdXxxjP2TaKfLHBZMDdJUdRFf/IpzcYZU+0W
         cyFMbTcs8sLEwYd0BjmgXcZlJa8MYWX/czn69sO9IzIc6naILKqCYsS9yXhC6LhpBUUl
         IAiZ/qAtMq9SQRWDPbgIGPftTeiCYqXWZgtQ36pKy8XUDVF4+8XK/Gt0+Jk9tLztYNhz
         9im0aBFrtlovsvbsmL6JyM2se2LL5d+cv7wS7fCRh/OFl/lwHzQexQTmxCpj26EsmjiR
         nkCUb8BK1obkHYQv5Vi5YC3d6O3y7gzy3sk6N8gNezRtuvXYn5VOgmNblrYk2Gkg0p94
         AnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713294; x=1710318094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8aTtUjDS4K2DXIpYTlNqMZB+SKPeqhA/7PjV1CZm4Q=;
        b=TCCXFkgx0uLucJ1qS3cMl9TcF/N/1TSclqxtCCftVtPa3kAQJFPtN+ljN76qIRFCW0
         j3o4CKIxUCG0C7tgkEMOkCFFw4BtpnN1jvKq9Bi6o7T/d8cSfPqmT+Gz6E0VaPJ0gkVz
         ZUDxJmI+wvYJaHHHAlYY2OD95kYFhdYzUj4LEVlAqLSO5bc2l8EBEp1J+8lY7h9mn6Bv
         0h85w4wFN9qUMJh2C/FkKlCRXbuj63B4Bg26r4nZhZ2dkSaDWnDTPkARU/BpsqaCqeoJ
         LDk6yKOwRYR/2cKjnzORJcdToi1P0nDKKOir3it9ycp9KfF2ZIR7Y8TQ4zR+e1lPdfOi
         +1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUwXC/gjmxesdMws8MXbt86vycfH6S7zDGuy7PXDxU+KyUNPmwkx5BOLutSJAPu0uBLvEcHGTc8gJvNph8HaCPUzRK63+4zLgxY4zm/
X-Gm-Message-State: AOJu0YzP62YBvi6MzNCVn5j4f9fGvv9JbBpSs93OisDiO5DFNkK3yHun
	Rf63RSxpIVpIEi7hl9ZJFzcU6Rtz5vdHY66eoMfbE1xB8LMLuuAyEevDhiNMLpI=
X-Google-Smtp-Source: AGHT+IHP5Mlf8s3lcTSNL0LJFQURwWQwIjurrNQzrERKX0PHH79cvXz9X27SMhCwvjwJ+uG4XsoqMw==
X-Received: by 2002:a6b:ef17:0:b0:7c8:6e53:95cf with SMTP id k23-20020a6bef17000000b007c86e5395cfmr3638659ioh.3.1709713294353;
        Wed, 06 Mar 2024 00:21:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id eh28-20020a056638299c00b004743c6462d5sm3228461jab.116.2024.03.06.00.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:21:34 -0800 (PST)
Message-ID: <ae3f9ef0-8e51-4c0f-9b60-c6dfebb1ab0c@linaro.org>
Date: Wed, 6 Mar 2024 09:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: altera-fpga2sdram-bridge: Convert to
 dtschema
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, mdf@kernel.org,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301161648.124859-1-animeshagarwal28@gmail.com>
 <20240301-uphold-numerous-305c3702805b@spud>
 <20240304170759.GA752387-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304170759.GA752387-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 18:07, Rob Herring wrote:
>>> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>>> new file mode 100644
>>> index 000000000000..88bf9e3151b6
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>>> @@ -0,0 +1,23 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/altr-fpga2sdram-bridge.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Altera FPGA To SDRAM Bridge Driver
> 
> Bindings are for h/w blocks, not Drivers.
> 
>>> +
>>
>> You're missing maintainers: (shouldn't dt_binding_check complain?)
> 
> Yes. Patchwork says this failed to apply which is odd because it is 
> doubtful that altera-fpga2sdram-bridge.txt has been modified.

The file was already converted by Michal, two months ago!

Animesh,
Please (almost) always work on current next. Also, before doing
conversion check if there is such work on the lists ("dfn:" on
lore.kernel.org).

It's waste of your and ours (three maintainers...) time, since this was
already done two months ago.

Best regards,
Krzysztof


