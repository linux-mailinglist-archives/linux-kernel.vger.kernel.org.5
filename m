Return-Path: <linux-kernel+bounces-49698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C9846E43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DB7298FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3667A73D;
	Fri,  2 Feb 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDH3qyaX"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD917A732
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870994; cv=none; b=lTv3MOfPRTqo05ZhWhkjQHb0D9hlvt0+lVQm3OxCB2qknKIXIc3LKnnmhQO7MRdVBv+DMUpUrJaXef/EHBqPUrChgIh0Dybz23XmmsNrfZ/+uc9MY15U2X+PfpfRYZ/9k2D0/ws9YC0VInDfmRz8RznQ9Q212uveLCUloqLYAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870994; c=relaxed/simple;
	bh=Tq53S3XqSKmPixpG2mO8PRxXSYePRUKdTcAhAwTD1ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcqBn6cm9M88E8eVGWitok90nwKPEfY0ie1j6FIEQ6Yema67NteVbHX4vgajxjTwag0aAMAtOUAv4uDvWs/PNWEYunH6+WXSQBptMJ8QiZj2Ja/UzW/ws96nAGwpwhYq8/V9VFbknS3ySN8Ghy7qrAUc8NBwgir2aZaxJqHPYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDH3qyaX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783045e88a6so129616085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706870990; x=1707475790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3b844T5139R4eYbNAZElUdeiuPv3v5NVMBih9lh2J4=;
        b=JDH3qyaXH+NWHHAlcglcVeRQSQzoOX3exS+Ogx0n7KHZkKv3MEa6EeeGoUMXDchG9F
         gOEb0P34Ea6SujbPyve6GXQ7bBoe0HIkE+CbjGUDAzyLcAH32rVBMqZVtRLxp7jNGbe1
         0RNO8jHLFETsUvVE/fqsl2qFOJmoWskr0vDeTvBDa9BBH00WEvEPy5HOekl0r6UnlPj5
         peLW2+aaeAVu/3xfXUngyvVcfM0QEAzaoUTQ2LmLGEd3yKG2cP43HLWhalbZIaYu0mlb
         GeBMtp1N64ZKcUglJayZbUgPk9wmckiP5EidT7EijcwPTli7XYa9eAicn1jChjyLMBM5
         owSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870990; x=1707475790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3b844T5139R4eYbNAZElUdeiuPv3v5NVMBih9lh2J4=;
        b=livs0vM2ieub8oMCFYK591My7uJSkDSGVIkviLFccmONzyf9Z4AyQNZeIeoH/bBFKb
         L5WjCzJgQbdC/JchKbggGdckh20oXKxrS53cZdbAArCT2JuokVU3huigdSWvYhtGmm+R
         nww/54aCc2u51MB/ToTvAXnPk3tfEURTo79+VLCGqwMDOriui9ZqGeq7CAFYYPFIw4ev
         RhQaOjW4RsxNBKtHXEEK2EUP8YIhb9jYvURs3w/cCKBuAx3a5t3acqQoUKlVfml8zgYN
         MQZNXyYidgBhUeNgJE5+90L2BDG5Hr5eqVcBhOttugxQ8nj/kRSHLDYw1gLI3iAY938M
         xXMw==
X-Gm-Message-State: AOJu0YzjgJKMUVt/1wZAKofyIi6sR9D3SlkbzuPbxu+6l2LE8knkjp0S
	Ycq5Di3GFtZ2B75/St9rZF3Hak7qMO4Et/irGFHPYbooPGEEmf/h7AGyH3cTDyw=
X-Google-Smtp-Source: AGHT+IHGvmnPYn4hEtreD5PLVWgcslKwmjYXnHDMnbZ9bJ0+WZTv3GPFXl3bRegFhGELu1XZw0MkiA==
X-Received: by 2002:a05:620a:5613:b0:785:443b:b430 with SMTP id vu19-20020a05620a561300b00785443bb430mr1707849qkn.14.1706870990017;
        Fri, 02 Feb 2024 02:49:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXa/IY8ncMkHr4op3aIGWr4vIhlog9YIH9P1fanfg6Q5rKA1ZuOtPNPKV3HmY0VEsalE5SK6KGQDfOuWR26oE5Fd6d6Fsrdd097rvaLR3FF0Iwa0906MV9v1t2zih+Hq6p0BDRDKS0kM+PnGctxKlWzvRnLuADPFn9c9IyNgcgtABcHYsIVPb7APTd1Doqq3KHK/1Hl0lGt7YO1+2SGblN2LxnTwBGz9xBemFn3w56DO2ao/k8/mLDsSi+KfWKwnbfgISsMlEu91oXGJaCRuB95rM27PovKpGANB5QgIMvLV4jNAUuev/zKUcf33ekmkKKPNZGxL3VuF5Vq1VQwXdi6y/I4S2/kKoTcdTnoR1CfAcXqwdEUHyUgZSmEl4pc2mf2qXQECBGeKkGKmRxTvwtNNztzrnSQ6anvJN1/c0MVAFBE6FQDzoh2rAa55Vcp/heXGF3BHp77jfwRRuNJx8d8QNV/o4XZ/vj2YNbR96xH5M+L8vb3M0E=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id br41-20020a05620a462900b00783f82a9386sm580458qkb.23.2024.02.02.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 02:49:49 -0800 (PST)
Message-ID: <4e9360cf-2952-45e9-8c85-caa4c0d92175@linaro.org>
Date: Fri, 2 Feb 2024 11:49:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>,
 Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>,
 yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga <linux-fpga@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-3-charles.perry@savoirfairelinux.com>
 <d5fe1ec2-b647-4902-a599-fb866e96e9cf@linaro.org>
 <1391244934.434321.1706811892834.JavaMail.zimbra@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1391244934.434321.1706811892834.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 19:24, Charles Perry wrote:
> 
> 
> ----- On Feb 1, 2024, at 3:07 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> 
>> On 01/02/2024 00:05, Charles Perry wrote:
>>> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
>>>
>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>> ---
>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 83 +++++++++++++++++++
>>>  1 file changed, 83 insertions(+)
>>>  create mode 100644
>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> new file mode 100644
>>> index 0000000000000..c9a446b43cdd9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> @@ -0,0 +1,83 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx SelectMAP FPGA interface
>>> +
>>> +maintainers:
>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>> +
>>> +description: |
>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>> +
>>> +  Datasheets:
>>> +
>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - xlnx,fpga-selectmap
>>
>> Your description mentions "7 Series" which is not present in compatible
>> and title. What is exactly the product here? Interface usually is not
>> the final binding, so is this specific to some particular FPGA or SoC?
>>
>>
>> Best regards,
>> Krzysztof
> 
> This is specific to the FPGA, the 7 series encompass the following part
> family:
>  * Spartan-7 (XC7S6, XC7S15, ... XC7S100)
>  * Artix-7 (XC7A12T, XC7A15T, ... XC7A200T)
>  * Kintex-7 (XC7K70T, XC7K160T, ... XC7K480T)
>  * Virtex-7 (XC7V585T, XC7V2000T, 
>              XC7VX330T, XC7VX415T, ... XC7VX1140T,
>              XC7VH580T, XC7VH870T)
> 
> 
> The configuration guide of Xilinx [1] tells us that all those devices
> share a common programming scheme.
> 
> I do agree that having a mention of "7 series" in the compatible name
> would be beneficial as Xilinx has more FPGA than just the 7 series.
> The name was inspired from "xlnx,fpga-slave-serial" which is the compatible
> for the serial interface.
> 
> What about "xlnx,fpga-xc7-selectmap" ?
> 

I am not sure what xc7 is and how Xilinx numbers it products, but
compatibles are supposed to be device specific, not family. Common
programming model could be denoted with generic fallback, but then the
fallback could be device-specific as well, which usually we recommend.

Best regards,
Krzysztof


