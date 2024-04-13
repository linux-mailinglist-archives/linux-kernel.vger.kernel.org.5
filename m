Return-Path: <linux-kernel+bounces-143898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483088A3EE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38DA281B31
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AF056B73;
	Sat, 13 Apr 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShoysSgk"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F856B66
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044927; cv=none; b=VHEraPgX3W6RxHf9VeYhpoZzx370Opo2hM+xSObH0iFJaYDHCtx65mgYBlWWNj0B6Ljm5oXdZR/fqJvlbPJp1vSFtcp1zP//7UTKvRHvVDgjAT1fgfDTuoW5DVOQVs/7zmCRL0tYn1HQA8aB8vdPTN8mMDfeGnwKk4QApGSHRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044927; c=relaxed/simple;
	bh=+rtvXJGrFoV6DxvrxDEit4iUkaYFDITa0hMuslGkKJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgNpIkdMFGhHSy2IGK7UPwES604se9ZPiTvRC+SLqf7uFO2M+s1LUxwECQYUCHJUSmTTbi98ID/NJCCrf58URYpb696kS+jKlziIczm92EX2puQQf/HrBQSGG26HB518DpvsJaHTqcjejiull4YHYCL2yRoAfB4x7X+tyw/GXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShoysSgk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d87450361fso24434311fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713044924; x=1713649724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TVpy+9I1ztI2Fb9ich6Wpfu2migTSgGWbIJwBWgMhAw=;
        b=ShoysSgk3sJ+undu24sgExBENuPV/6ND8uuXnzH6/vG+cTR7lSNwyAcFcu36PceTg9
         xUF1ccbevWfYo0YYSytOGzVrXMkwvOBv1kFGgEAwp+GH+AzlmmeGLmzva/tb9HP1WTG3
         tZM4gL5euSKRAVBfMREo6xMEqH/JIF3QKYzwDGrPKlkzzLKOJCyASvpx1zoyrpfHjNEz
         sDus4Xy9FdC1AZlxktshmlUMRvII0XVxwsj/fa/wUNA9bQ86/3hjXuTgY2EteixucdiZ
         hq9D7i55JksOVIjuY0L/7qQO/1IBul2MT1/9ahEdBxfRQ3EJvDi+gAddlbRr7MeVhRjf
         XwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713044924; x=1713649724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVpy+9I1ztI2Fb9ich6Wpfu2migTSgGWbIJwBWgMhAw=;
        b=FP257v+F8ZW/xVbsW3CRY0oCBEnJ/OIApJuj54wLbTfQN+SQYxExlIy7E+s+YG7gMS
         Nb27vukSyEC6wXo2O0eQjXHAETGKgx7GxcIRz4G3/h2Dk4tnN6tfJ7imKbdbemicj1cD
         iplk7q5WwEGCbIlWJ141jsVDLw2UnzJq36EdC9xVKBYe90dyfzj3uSc1FP+AKl5gUE45
         o/pDxfwRZDad6QtBOiLvx06TTsNdG5FXFKh1ddraK5ty3VzDD1nTXcaa59aFNUW1e9Ns
         PoksFCx5D1AUXhxWx9px//YVIeCaDr9hmE8K9YYUqK9jraqLD1zLWlk7CifJabg1E7mP
         S94A==
X-Gm-Message-State: AOJu0YwOoNgKLm/iO8YpmWaIp9FOgJgoDQjIvCGNfNWFZqe8zxA5JRql
	dn1zLEx53GXOTAKhyjeoClzASE81aNdljZ3jqX5pRvNN+bwy/Uoxzg+lEwuEw0I=
X-Google-Smtp-Source: AGHT+IEy4vvBVpGu7BH8HttXfQqpj2nQnyB9+ZKuEnMMc/DXS89RuEbcHExyLyjVVChRtnybBGvB2w==
X-Received: by 2002:a2e:a370:0:b0:2d7:7bb2:7afc with SMTP id i16-20020a2ea370000000b002d77bb27afcmr4039996ljn.3.1713044923614;
        Sat, 13 Apr 2024 14:48:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7db8a000000b005700ef75274sm981556edt.33.2024.04.13.14.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:48:43 -0700 (PDT)
Message-ID: <cf4ecd86-a216-448f-bb5a-2f02e5dd8e3b@linaro.org>
Date: Sat, 13 Apr 2024 23:48:41 +0200
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

I complained and NAKed second patch.

Best regards,
Krzysztof


