Return-Path: <linux-kernel+bounces-119015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23988C2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F32C3171
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AC6D1AB;
	Tue, 26 Mar 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7kq1/no"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADC1EB56
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457788; cv=none; b=ZvPtR/QoNitfyyi6lkQNp46+BtWjjaGncP+1r45E0++f1rwhLUePkIMXjsXzcFqWBbdCRVSiMnJTjaRCGIzNYXrX/Gea9gOzbfXrWdmvnt6QTNCvoxjtdusIeKCIfhfoVtHBqKBl7vV6H/G3LYMMZu25b5mbYpZ44DDIlWo2mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457788; c=relaxed/simple;
	bh=YwtCMJg1Rfup4NT8V7Oo7K4rKen6x1h2pzIusMuhhp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ienimvpkzQr+lOyxl1yTVydUmZuP4L1Pc5MxqnLc6Yh1KEe2xnJRBFgRflQcwquMUDIFnM56sSibLPpNK3ngNFzbrZEHG6lqh1zo0LrPCriaojAJIPiflb7UwxoVW2L9wITVhbhw4qIDvuvx0lSzH7yMd7AvEXu4Ojt+hkPIO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7kq1/no; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso698405566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711457785; x=1712062585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sT8OjxdUQAjzr/9I2o/yKQ2o8R3+ehvtYWeUDIQGp2Q=;
        b=o7kq1/noAzjkHEV0L07zOaWm/UR9/+B5i7DSN2hw3ZQFWaRikg4+2f74neOduU0KY/
         OZ0Sd8su2PBsPRwaxgJy+LuWZzzm2vtwe9vWkjuTC7XMvjCJgODq+usAe7b+OLIKq0av
         CEf78/2QM1eTdaMvvwecnN709WaZ4Yb11U1BH+kbzk7qhuEnodgPdcMRSvnKu8g7SMLW
         syfk6B5HVo4Gmd1DGjqwzvuNSN6MHB9UwoyyxIm1KMbcCfwsfFgg8qIWvLTJDkuChbmh
         8m+rL8SSB4OVh1fwzXEDhaIU+GoqcATqGv6621aev3ecs4JKpajoi2GkqZFOvpt4nmRB
         9O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457785; x=1712062585;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT8OjxdUQAjzr/9I2o/yKQ2o8R3+ehvtYWeUDIQGp2Q=;
        b=cxEi3Y1+vg8SOWJTAU/7+17cosWBeVejslpxiP3N425Jwa9hVWjEyg6mdPZ/ys1MkP
         zu8aB6nIkLmJ4UIZzl4jkvIVZYQbVSZ2Yc/g+JRc/Y+pehuMjCM91tSwJ79Cq4oeZYMD
         Q5K4OsD14xoInveGP64NVlxt6MibJmBEIg0tx7klr/4XCVUP3VZbq9p6ymmnnEA47Ltq
         g/nefJW+Q/CPOzWeSKg7zutzxwpZPFDiWlYEmdMfbviEfrEf3AGR9M2aJpS41Bt+dyGD
         SVZ10bseCY/ppIPxFYAD+p+qLOL3keo/r8utcfUWJ1FOc/P7lFkh6Izupkk5i1f7g83L
         tTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC93r7Znq00EnkLtwUV2TuaW+q7RDDLfzQQ+m4FpPsIBXEps9mUmhcgv5D2y4+HKNHsaUEXsjl66/T1ZcvGvJn/sPqBLlPQzf1nxN8
X-Gm-Message-State: AOJu0Yxp6O9kHYF0Bui8v/CiWk2e/H/82Kg+XVznBM16pmXKa2ez2kPh
	7soMKI81HbGhH+4B74VpTzHsY2btcqpN/u9Y4H9H/0pSp3O0HK2WeWNdXBvuQ08=
X-Google-Smtp-Source: AGHT+IGwEwrTsGbZnoPQM2wsJJefA/6J2PARa12wK1WZlpE62Ba5CCqMUlaxcnNOMgCIBJTpbgXTLQ==
X-Received: by 2002:a17:906:66c9:b0:a47:20c3:7c51 with SMTP id k9-20020a17090666c900b00a4720c37c51mr5961573ejp.71.1711457785034;
        Tue, 26 Mar 2024 05:56:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090639c200b00a471cbc4ddbsm4210480eje.26.2024.03.26.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 05:56:24 -0700 (PDT)
Message-ID: <1c6d995a-b1f1-48ca-b85c-f69071e7e3bb@linaro.org>
Date: Tue, 26 Mar 2024 13:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: hsi: hsi-client: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
 <2905247d-03b0-45c1-add5-d3c2a986d87c@linaro.org>
 <hz4fbdix5yaz2wtdkjkf23pc3m4kbeavynvjagundqvv3bisor@lc7dev4667i5>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <hz4fbdix5yaz2wtdkjkf23pc3m4kbeavynvjagundqvv3bisor@lc7dev4667i5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 13:45, Sebastian Reichel wrote:
> 
>> but more importantly: some properties are now excluding each
>> other.
> 
> I think that requirement was already there.

Right.


..

>>> +
>>> +allOf:
>>> +  - if:
>>> +      required:
>>> +        - hsi-mode
>>> +    then:
>>> +      properties:
>>> +        hsi-rx-mode: false
>>> +        hsi-tx-mode: false
>>
>> I don't understand what you are trying to achieve here and with anyOf.
>> It looks like just oneOf. OTOH, old binding did not exclude these
>> properties.
> 
> So the anyOf ensures, that either hsi-mode or hsi-rx-mode +
> hsi-tx-mode are specified. Those properties were previously

Not entirely. anyOf should succeed also when none of them are present,
which is not what you want in such case.

> listed as required and they are indeed mandatory by the Linux
> kernel implementation.
> 
> The old binding also has this:
> 
> hsi-mode:		May be used ***instead*** hsi-rx-mode and hsi-tx-mode
> 
> So it's either hsi-rx-mode + hsi-tx-mode OR hsi-mode, but not
> all properties at the same time. That's what the allOf ensures:
> if hsi-mode is specified, then hsi-rx-mode and hsi-tx-mode may
> not be specified.

Then wouldn't this work for you:
https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml#L91
?

But if you really want them to be optional but excluding, then simpler
syntax is:
https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/

Best regards,
Krzysztof


