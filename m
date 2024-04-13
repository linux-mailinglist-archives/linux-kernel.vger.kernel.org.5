Return-Path: <linux-kernel+bounces-143900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC578A3EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48521C20BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C05647E;
	Sat, 13 Apr 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7peV9X0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3455C2C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045039; cv=none; b=tBJcsw+G8PVCsePwJkeG1ebpnMCpB/MY0/r8UnzlMLQJRk5vVd8OcVMA+Hu3ZuuH/pJ3u89L5ovd9yhsAJg3ve4CmfHO8U9FZUniMuBp639u4duXJuW9knhfXlGp5W9b0xcD7bg3WPya/cKjgZ5W5FUt52wTqJwoqL2v/7IcjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045039; c=relaxed/simple;
	bh=ZRIGw+x8TNRdB7oYE4uKD7tYv2FJDL5aXqCT2ZNSbgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxlOjqhzn24NN2POWmuDG7QExPrX8LPqBVDCFRpDBCBDFdyyVY8w3CGmKKpCB3cFdzBpVAfD7YpcNvroIwdKFo5BLqRhCiY79crm2lsbHUSfY1ewGReMNhNi9RWJAcySO3dXFCcUiWbT4TnVFBalM9X6uS2QcqHDNrvziz07uwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7peV9X0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5252e5aa01so66585866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713045036; x=1713649836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHqLbpM95T46jY2G3LKjaBLxKzlgWtGPZ5BqrENl9bI=;
        b=r7peV9X0LKNrmIuNgK9ToCvITTp0HmcbWsqGvkbBeqoRJ2KghdwodnkVWOaeXN5qHZ
         sqtQm95Wvt68b1x0wAsfpvQ6le05ueH8ZyFzcDu3Nud2MfCHKeWvU/TIWUiccZG/iLie
         kq6uA0/QmArhFnACBc70mnhLb9Hfx3dUtet5sA8TeHl/Y6CA4cXYEJlvfgXblEi7adTh
         V9o20NUxKm6u4dNckbB2x/p4TS+oTKTDQHcS5KP1MBiTotaJe1r0Mi96EeATY8vVmi4f
         ln00MVTprPSStIPiKOwz67SlMeRWnYYEbDh9bfEByXOByXAwZsakTdu0KhqGfHmtPtId
         +/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045036; x=1713649836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHqLbpM95T46jY2G3LKjaBLxKzlgWtGPZ5BqrENl9bI=;
        b=Xd2IYw16NMn5PVn7rlHB+tSzR8HkhHLrTE2o2hs7n+N+5TsJuUBYXUtmI4ldnff3uv
         js9ZTPi6UiyYjPVqSqLi2P86lDfXXbMTkOFmeFV96rWHc9PuUzWHq+JTQtkYrdWCifAN
         MlyTSKgSwOu9yjp6br9sUvT7X2IQAyy0rWI6wNF95LOkkttmBz0AZ7ntVlTGpGz/eUd+
         gt6OtBzG5Oiem0l/CIj7Vun+S01LolG38yDP9oZwsamDvFy6GZI08ICVWeb6KaacQK5j
         SYfrMyRHQAcmnl0mM8TADO3WX7HpTwYQ7zyxhoaw8eksL7/g5+Apk490E5B5XN3adL+W
         ee4A==
X-Gm-Message-State: AOJu0YyytNaWlc3TGhKYW5o0sNBgUIdnC3v+VjfpBNKL5PN8Zbq8g2+m
	6DaLDSiGPyixq7yh4wCOqPAWRdaGXt4iBOZzExV+WtmxP3I4z+3CwqGXkajYM/4=
X-Google-Smtp-Source: AGHT+IGW6R/ADBB1svJsE0JdG8zJxO2UqYfdatZoGceeJi1SVPdBmEd8nxrrpLnengfRAAUROidAFQ==
X-Received: by 2002:a17:906:32cb:b0:a52:5457:1389 with SMTP id k11-20020a17090632cb00b00a5254571389mr834949ejk.3.1713045036108;
        Sat, 13 Apr 2024 14:50:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id si1-20020a170906cec100b00a51a8d91397sm3463927ejb.73.2024.04.13.14.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:50:35 -0700 (PDT)
Message-ID: <b6f05fd6-34a1-4c81-add4-36308fd87352@linaro.org>
Date: Sat, 13 Apr 2024 23:50:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
To: Jarkko Sakkinen <jarkko@kernel.org>,
 "M. Haener" <michael.haener@siemens.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <D0JBQ0A9FXUS.NH8RBK4KXXX8@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0JBQ0A9FXUS.NH8RBK4KXXX8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/04/2024 23:47, Jarkko Sakkinen wrote:
> On Sat Apr 13, 2024 at 10:15 AM EEST, M. Haener wrote:
>> From: Michael Haener <michael.haener@siemens.com>
>>
>> Add the ST chip st33ktpm2xi2c to the supported compatible strings of the
>> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
>> Profile specification.
>>
>> For reference, a datasheet is available at:
>> https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf
>>
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>> ---
>>  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>> index 3ab4434b7352..af7720dc4a12 100644
>> --- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>> @@ -32,6 +32,7 @@ properties:
>>            - enum:
>>                - infineon,slb9673
>>                - nuvoton,npct75x
>> +              - st,st33ktpm2xi2c
>>            - const: tcg,tpm-tis-i2c
>>  
>>        - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I'm ready to pick these unless Rob has anything to complain (hold
> to next week).

Plus, even the first patch was not tested... I already wrote it, so
let's be more specific:

NAK, not tested, even though testing is trivial.

I don't understand why opting-out from testing, even for trivial patches
like this. Automation, expressed by get_maintainers.pl, is there for a
reason.

Best regards,
Krzysztof


