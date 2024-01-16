Return-Path: <linux-kernel+bounces-27368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D982EEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D497DB230BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEB1B96B;
	Tue, 16 Jan 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtgTVIhA"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0121B81B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55790581457so11210248a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705407329; x=1706012129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/kk/O+CBQq1j1li3fi1pfcRqWXCdCx2SuioSuSfFP1w=;
        b=WtgTVIhACCEs5mx+Ws04Fc03pyV4aqMKnkNBNz6973jwJAwW6xjZ5KG+OWteNJkftW
         RCUE689CkQ8C6nQ78q+tzRvO9xMp5XOnZEwLyLeMqdlQDKhX6hfVu+fWS+zsAvwjcmsx
         p82JWtATHO51ecFOnhykc9qHsGiOb5XDyaZAhmdZJng2dW4w6+c4AmRZAY6EbwAhklPf
         9ceqm9Hox1VN5BmRCQRj+Mdo/EdW2DAxyj3OeY9zTZfKehhlBoMCbuaycCY67EtAb4VI
         oRF3k1zNTEV0y1aW2hyBMnmQFLnI2fr3EmdYiLa1/1/CRAq78opoPDXo23aInKBw3sMh
         OfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705407329; x=1706012129;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kk/O+CBQq1j1li3fi1pfcRqWXCdCx2SuioSuSfFP1w=;
        b=v/8B6fxLvPd7yAoYptjW+B8DsJY5vx7BEnT9tLVyA+knt0j1EDvKgftHfJU04FlCMu
         da8FqR3US3A2agONoDzi10d3VWaohfugluvR2cRqQt1ec5rV0e1BErR156GZga5Z+7vx
         LxhPqusE+iI0vFE+aBH7m5DCQzdEZrEaKcimdr9V2lvYBNnvqsBSrmIE5UnCSBkLvFeA
         9AqE4pvjcqhXwTw8Du/JI2w7AvkL5o0Q1J/bG4auSIIMFIfE3XDB++EPjfAOGE/dgrU0
         FmKxaEcBgWvFNFClLoKlrVA8oJYKud2dSuKaLRvcxgPymuw72Z8HthHvZIsI+1vlRoGs
         Wc2A==
X-Gm-Message-State: AOJu0YxVvikfVQPeOtvDXuRxk5YoyaLLEH12gHqbXgFbPeCSx0FXfk7w
	MtUAFCSmI1iq9fUsPVDwi/VpOK2lbb3kzA==
X-Google-Smtp-Source: AGHT+IEwxFWU0HVj73235n9DWQNSKJOTuUjeFLvXg7/pyeoQbu4ZnHrHCnBnuulNQwp8FgsBy2SMgg==
X-Received: by 2002:aa7:d4cb:0:b0:54c:e28c:2086 with SMTP id t11-20020aa7d4cb000000b0054ce28c2086mr3923869edr.38.1705407329028;
        Tue, 16 Jan 2024 04:15:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7cb18000000b00558e38d4c6asm5046806edt.93.2024.01.16.04.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:15:28 -0800 (PST)
Message-ID: <52c0b805-bcbb-47e5-bbac-e527e9dc57a6@linaro.org>
Date: Tue, 16 Jan 2024 13:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/01/2024 12:37, Chen Wang wrote:
> 
> On 2024/1/16 18:06, Krzysztof Kozlowski wrote:
>> On 16/01/2024 08:21, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add documentation to describe Sophgo System Control for SG2042.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46 +++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>> new file mode 100644
>>> index 000000000000..7b50bb56b4cf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo SG2042 SoC system control
>>> +
>>> +maintainers:
>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>> +
>>> +description:
>>> +  The Sophgo system control is a registers block (SYS_CTRL), providing multiple
>>> +  low level platform functions like chip configuration, clock control, etc.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: sophgo,sg2042-sysctrl
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clock-controller:
>>> +    # Child node
>> Drop the comment, it is obvious. It cannot be anything else.
>>
>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>> +    type: object
>> Why isn't this merged here? You do not need the child node really...
>> unless the clock inputs are specific to that clock controller and you
>> will have here more devices? But where are they in such case?
> I don't see more devices will be included later. It should be ok to 
> merge them into one.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clock-controller
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    system-control@30010000 {
>> Why did you change the name? Please provide detailed changelog with
>> explanation of such changes.
> 
> I changed the name due to I find the 
> TRM(https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst) 
> call it "system control",  so I changed it in v8.
> 
> Which one do you prefer? I'm not sure if there are any requirements for 
> this?

Node names should be generic and follow common guidelines, not match
your TRM. Please use the same name all other devices use for the same class.

Best regards,
Krzysztof


