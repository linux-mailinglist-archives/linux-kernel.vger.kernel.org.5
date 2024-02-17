Return-Path: <linux-kernel+bounces-69902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5085900E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B77B21AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE57B3DB;
	Sat, 17 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Da2zZdvZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89522094
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708179935; cv=none; b=afX1CK2gIeb9P+k9QpIIPOBuqRx+k+G3hLz6JSnUNIuJNfyesS583ZHFJG1jeeF96Pkui25LOpvpxU6wuoY/Vp31Bj5IWqx70RINaq3HWUvhZMsFPFqv6p38lfnGouEs88K99eLwae8EDwBHhGmLvus1pvzuO1gSvMPUh2oHjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708179935; c=relaxed/simple;
	bh=LROwsAATd5dVSDId910ZrwLoi4+UrXOjNRDAAiRmhCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeGSYIEyvE9c6o59pOcUJS7HKwZqm62zW7hZeGl9LRUd15RA9iFSFkI7aZPeB1atxoOvqNhYRcQamKlVAN/HZxjHtSDTsPu/s0WxUzDxXbIIN6vcbcqeQ7MIwLjFOm6umeLWnviTC2aA/3TaK80s4MdCBniHhQW85etKlhKQ2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Da2zZdvZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso3385564a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708179932; x=1708784732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF5uDWeurLttXmHaU9CD+Ktxf1MKzf5HJ8Edg4i9z9c=;
        b=Da2zZdvZb5Nf+Wl+z1sHk/S+6SUKV2LFTNl/9epfPi7sZD4eGy0n2SIT1317Hj91TR
         12GxSc5QKYnbhqNhw/0RV5zJNkYqeS6Q0V1gFtbllO0MlvKzYTasuqJVoMMkCIRgv5kf
         A8sNRltHFVLedrb8VkHd8QMydTaBPUBGqj578971kwTcp/rVFSzurFfEtQ8okNw1fCqw
         j3oCb0T3m9FNvxoDVr3ec2gBo5weL0o0Nh+z2S7QKb2Lj0RqdgaRrykNWYchCV/lmziU
         BOBsVViIZIceGliPPlOwUJQvHCxUpKMN6t4nKzXs0N3KJ6BcdnlB1zgpf78MZnqkAx2+
         lM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708179932; x=1708784732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF5uDWeurLttXmHaU9CD+Ktxf1MKzf5HJ8Edg4i9z9c=;
        b=HhnN8LM7JEd6HmVn2e1TIE3sZ1vp4VV/QhPKoO33NjEpoG6HynpK48TFgAkssRsZNr
         2cvU7nJ1z3riQYwJTco49he0NOeVtK74wUxYAn0BgQQzsPIyUpzfFaY7XfYYOGueYrp3
         2p47BNETZQOqotgb5fIdFrGa2BBJfuUtDKYd+6PWvRWHc/UY8yldH2CayZUISwD6Vq1o
         8YMyXVpgFndkNpZI6x2vYM40AI27nozzMcwWYzaw7RxfSrW4JLPXv6n5LGxagjnSjTFu
         Bjl+iCIPr5UUoGfR9qdAoWaodd7Sz69FflPlGp3LEoWwWI/Au7Sf+D+/hZIw/w4TW1rJ
         HgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhqixd9u0AzdgOf0hAahyNkXawlPz4/2+7bqYhQgqnVO6VgTNKWTXHYG+22DQORfe0EqjBKwpJsetxNeAJtODR+8Fj1EwseaKQDA0
X-Gm-Message-State: AOJu0YxVbqAWfNvfBLfxvLrTbE59cFubv3GbiptkQce+dUHSJ/WOAe12
	gF+5mtTo/v84MFDme+06jXt41YR32oXhfLLdSuIKfg0vbl256GgKwFEUC1sYNNM=
X-Google-Smtp-Source: AGHT+IEv/N+4uAgW3VQe/hQZpRvmD+l4B9v10kkX4t4H4cOYQzY5iv1Awy17srcrCwrf84iLnCzR6Q==
X-Received: by 2002:a17:906:d8b4:b0:a3d:7d6b:612e with SMTP id qc20-20020a170906d8b400b00a3d7d6b612emr5275743ejb.23.1708179932427;
        Sat, 17 Feb 2024 06:25:32 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ss3-20020a170907c00300b00a3d32341280sm1011435ejc.181.2024.02.17.06.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:25:31 -0800 (PST)
Message-ID: <cb75c098-521e-4eed-bc3e-7237f8a6498f@linaro.org>
Date: Sat, 17 Feb 2024 15:25:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Andrew Davis <afd@ti.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
 <20240206184305.GA1875492-robh@kernel.org>
 <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 10:31, Markus Schneider-Pargmann wrote:
> Hi Rob,
> 
> On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
>> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
>>> The information k3-socinfo requires is stored in an efuse area. This
>>> area is required by other devices/drivers as well, so using nvmem-cells
>>> can be a cleaner way to describe which information are used.
>>>
>>> If nvmem-cells are supplied, the address range is not required.
>>> Cells chipvariant, chippartno and chipmanufacturer are introduced to
>>> cover all required information.
>>>
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> Reviewed-by: Andrew Davis <afd@ti.com>
>>> ---
>>>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>> index dada28b47ea0..f085b7275b7d 100644
>>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>> @@ -26,9 +26,24 @@ properties:
>>>    reg:
>>>      maxItems: 1
>>>  
>>> +  nvmem-cells:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +
>>> +  nvmem-cell-names:
>>> +    items:
>>> +      - const: chipvariant
>>> +      - const: chippartno
>>> +      - const: chipmanufacturer
>>> +
>>>  required:
>>>    - compatible
>>> -  - reg
>>> +
>>> +oneOf:
>>> +  - required:
>>> +      - reg
>>> +  - required:
>>> +      - nvmem-cells
>>> +      - nvmem-cell-names
>>>  
>>>  additionalProperties: false
>>>  
>>> @@ -38,3 +53,9 @@ examples:
>>>          compatible = "ti,am654-chipid";
>>>          reg = <0x43000014 0x4>;
>>>      };
>>> +  - |
>>> +    chipid: chipid@14 {
>>> +        compatible = "ti,am654-chipid";
>>
>> This isn't compatible if you have a completely different way to access 
>> it. 
> 
> Thanks, it is not entirely clear to me how I could go forward with this?
> Are you suggesting to use a different compatible? Or is it something
> else I could do to proceed with this conversion?

What you claim now, is that you have one device with entirely different
interfaces and programming model. So either this is not the same device
or you just wrote bindings to whatever you have in driver.

Nothing in commit msg explains this.

What you should do? Depends. If you just write bindings for driver, then
stop. It's a NAK. Instead write bindings for hardware.

If the first choice, just the hardware is somehow like this, then
explain in commit msg and device description, how this device can be
connected over other bus, not MMIO. You can draw some schematics in
commit msg explaining architecture etc.

Best regards,
Krzysztof


