Return-Path: <linux-kernel+bounces-6748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC5819CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE9A1F21A98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1B208D4;
	Wed, 20 Dec 2023 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QY0iutfm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25D20B0A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d3748f345so3553865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703068363; x=1703673163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qy0d4uW9Tfpch1YLxptDL8ZWZMP/oKYPuFpX1a7m+0=;
        b=QY0iutfmO2p8Ubz1o3IYJLtOLIpTUDXPZtNcjSJs6rCoZ/L9JwlNwIeBW21nt/aKmm
         /9heRAVONWfdzNxBieAN+n+X1ZMcATsSrHPr9RWRzaxaPqtRnDFVmlLtqblVbSF3FF85
         v1IB9rIE1190da4oAu9Fm0kBgI7BDYbdkC6d0skuTbPhtakfwmSFwNu+PFKf+9u6+eUN
         f2Mp6jx7Lgmb27pefilaP+j76Rg1lVJ83ugi1iy9r45thTXx79ps8C8BUBQg+cXJweWq
         RbA0toBNUmUJc4fZlXeZDRblbsMxqk3QvocD+7Ld5Z/sdgSC7pZxjyE51XSx8X2Gd7fF
         axDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703068363; x=1703673163;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qy0d4uW9Tfpch1YLxptDL8ZWZMP/oKYPuFpX1a7m+0=;
        b=bpQKBoZDNCbF6mojhLdy8/pZ2XvMC98MrV9bK+CoWj6I9nRDxnpDTm725IDBnJSgRy
         cHAGHMXEoRzkD35CEZJxjSrXvN70VsErl1l8bKbHm9z8h9kQg8duVNfIXwYv+HYjEeta
         ac9xcAAITuLIik11i5wOF/XTLEGIwQdqxz7jWCATVWmWoEihkFZ1F/qRiCaeSddgfWlG
         c+xkwjazHuIFqNwpH2uRfW/oXJwCitO1HXWsLqe44B8xzT7EJMBrNh3WMMIYSgBcU7Vw
         qSxuTG2lys2yhyGeWlxB+Czn4R+EnQR3Eenrcv3ZNT+dD6i5TBqQUYONqmgm831kA8/G
         z3sA==
X-Gm-Message-State: AOJu0YzU9CSD2ZkQnAPhc9FgDlA80w015FJxHsIXqZ56FIn0yFJW1Bgu
	6kTYpvMUJoZQLp79bLZkAWB4YA==
X-Google-Smtp-Source: AGHT+IG3vRsIdbId3XtjN90S5yQC8jhQpzlZFY47XoIGVto4O61H+dsbqYf7+22ndmjirqxpaLfsww==
X-Received: by 2002:a05:600c:ccf:b0:40d:3795:dad6 with SMTP id fk15-20020a05600c0ccf00b0040d3795dad6mr321925wmb.158.1703068363184;
        Wed, 20 Dec 2023 02:32:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bh20-20020a05600c3d1400b0040d15dcb77asm6807335wmb.23.2023.12.20.02.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 02:32:42 -0800 (PST)
Message-ID: <568fb108-4f8c-49ff-a5a8-bc6da1bf7b82@linaro.org>
Date: Wed, 20 Dec 2023 11:32:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
 <20231218-mbly-reset-v1-1-b4688b916213@bootlin.com>
 <c6d8c1f2-082d-43c1-8768-c0004d3fe386@linaro.org>
 <CXT1WVQ3YTND.ICHBOMMNR837@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CXT1WVQ3YTND.ICHBOMMNR837@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 10:25, Théo Lebrun wrote:
> Hello,
> 
> Thanks for your comments. I have a question for one:
> 
> On Tue Dec 19, 2023 at 8:40 AM CET, Krzysztof Kozlowski wrote:
>> On 18/12/2023 18:16, Théo Lebrun wrote:
>>> Add DT-Schema bindings for the EyeQ5 reset controller.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 69 +++++++++++++++++++
>>>  MAINTAINERS                                        |  2 +
>>>  include/dt-bindings/reset/mobileye,eyeq5-reset.h   | 80 ++++++++++++++++++++++
>>>  3 files changed, 151 insertions(+)
>>>
> 
> [...]
> 
>>> diff --git a/include/dt-bindings/reset/mobileye,eyeq5-reset.h b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
>>> new file mode 100644
>>> index 000000000000..ce59fe5409ac
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
>>> @@ -0,0 +1,80 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
>>> +#define _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
>>> +
>>> +/* Domain 0 */
>>> +
>>> +/* 0..2 are reserved */
>>
>> No, they are not. IDs cannot be reserved. IDs start from 0 and are
>> incremented by 1. Reserving an ID contradicts to entire point of that
>> ID, so either drop entire file or make this proper IDs.
> 
> Those are hardware IDs. I get what you mean is that they should not leak

There is no such thing as "hardware ID". It is some value passed to
hardware/firmware or hardware register address/offset.

There is no point to store hardware register values/offsets in the bindings.

> into bindings. That implies a mapping operation from bindings IDs to
> understood-by-hardware IDs. Can you confirm this is what you expect?

https://en.wikipedia.org/wiki/Language_binding
Bindings is an abstraction layer, not hardware, therefore my expectation
is not having some sort of register values or offsets in the binding.
Drop the header from bindings.

Best regards,
Krzysztof


