Return-Path: <linux-kernel+bounces-103409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0E87BF08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED38B23461
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEC70CD0;
	Thu, 14 Mar 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+xQoArD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74E6FE02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426921; cv=none; b=F4VyBpu7u7luMAPpPIYK9kSD+DvQ0iTXELw/9JKYWajL+lmbtdOXzosnoDbyHI5+VZu9kJHH7sYucqqWuO4WVykc2NoDY/4bZbkLoGm6xOx7/Mqja/3MnYG6xvLEbL/NUMUBmTA5vNWn/l5fUx+8indg65rLHc2DlyygEUHefHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426921; c=relaxed/simple;
	bh=AknrWmWDD8i+Y7dd/gPMPigxGYow5u8RUdyw7tjVfZI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CuDWFS7pIV0Eso54YuzuetNmSreWlBbX7vZAmh54Lp+3N16S2jlSC1fhQ00bI8I2io1BVOCOqnjSXFozG+mULvP2MXG+7cLkw91utJ5wYYu/Mmpxi02ItVWzuBbPiPUQ8QBAuteDipIsuX6aM1FyefeDrJaKqmlkbZ74QLIbMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+xQoArD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so447125f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710426918; x=1711031718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlfXWz2bHcMeceXPmCS8ZEw2z1gMzt2SLSx+N4MGu4M=;
        b=h+xQoArDAOOrE9cRK4Yg7yz5acO3SPqj7RZNPn6bA9uQ3Q+GpJDiP+Y32odGj+wCIw
         IRJMK3aMqEnabNVisekxATC1l8OquvmpU4co7Wfu0+eoSefcZEL5DmN10nJjAlvktN8A
         anzMCZz0L0UeaFoWuV5uxLyxlrOeoSk1g0nU23MvbFWd+1OEtuE1OJp8aK+qKQKAvL8D
         Nm2WMFidlVqptx2A065xNkoSoZpPGKvEHponNv1BtWWbKNeJ1dzEHsxQ51Kl51oPvAlP
         dc+KMPSa6RAzEGNAkF1tOnvzNT2RoDDfWQXxXYpcw29nUuRVlzeCKG5VW4md5dPfWF36
         wzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426918; x=1711031718;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlfXWz2bHcMeceXPmCS8ZEw2z1gMzt2SLSx+N4MGu4M=;
        b=FCePzjjVfxNloRKF75IdDH5KHJ9hifhSDbDHmq5Ll0skEX2siGE7ucgg+bOVUjuUOS
         XbcYjsrE1aZh6mso2mA+Tlzv9Zl9VQhFmwyiDWPJGVdj/Id4OhKgLJ9wyNPBCm7YT+5t
         icdMnqTLFKslWK4YawUtKzqhciGtY+wM9kuLna7YzGRqIBusOiD7QRQr/Fu60vbuWfhc
         2dqOTffjKg/1fbroL/swcVScw0CU+aG42X6Sm363QFCoOkTPgJRqruOexcLstsCIGeU0
         MHUU3UFcw9bnSBfbzdX1u4US8tHkbdqBWx77D9ukAMPfdQuFNFwnRmruJGDu5O5+lwU3
         3fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNGGfI7CbeYnYbFSmoS5GErtUQVwKI8Ej0v6CUrNf4WLXgJKXmuF8UJUjICpyJwF230LojPpHop2PAnErBRgY8JrpmskN8eF/LNzDD
X-Gm-Message-State: AOJu0Yzt279qmmJ58pii/HuqIrKdfUeJmW1XV4obVaMSXHEsUltfgmi2
	i0Ne4epvRrhUUeWyFdynZOE4OtkoZCk+RLbfgKPgEPv5CHXkUayrfc7KEyfRrS4=
X-Google-Smtp-Source: AGHT+IHnbAtEB8fZkJ1NYRXHqIQKiPIKagRXRe3HFnoWOZuEMo8a6yhPPUxxt4o30LCM7sIZJ4Op+g==
X-Received: by 2002:a05:6000:d01:b0:33e:9f65:3b62 with SMTP id dt1-20020a0560000d0100b0033e9f653b62mr234671wrb.49.1710426917814;
        Thu, 14 Mar 2024 07:35:17 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b0033ec94c6277sm871235wrp.115.2024.03.14.07.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:35:17 -0700 (PDT)
Message-ID: <a5eac9d5-1e88-4d7a-b8e8-677f6d116782@linaro.org>
Date: Thu, 14 Mar 2024 14:35:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for multiple
 DT
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com, peter.griffin@linaro.org,
 linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev,
 linux-mediatek@lists.infradead.org, Simon Glass <sjg@chromium.org>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
 <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
In-Reply-To: <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/03/2024 14:20, Caleb Connolly wrote:
> Hi Amrit,
> 
> On 14/03/2024 12:11, Amrit Anand wrote:
>> Qualcomm produces a lot of "unique" boards with slight differences in
>> SoC's and board's configuration. For eg, there can be SM8150v1 on MTPv1,
>> SM8150v1 on MTPv2, SM8150v2 on MTPv2, SM8150v2 on MTPv2 with a different
>> PMIC, SM8150v2 with no modem support and so on. For instance, suppose we
>> have 3 SoC, each with 4 boards supported, along with 2 PMIC support for
>> each case which would lead to total of 24 DTB files. Along with these
>> configurations, OEMs may also add certain additional board variants. Thus
>> a mechanism is required to pick the correct DTB for the corresponding board.
>>
>> Introduce mechanism to select required DTB using newly introduced device
>> tree properties "board-id" and "board-id-type". "board-id" will contain
>> the list of values of "qcom,soc-id", "qcom,board-id", "qcom,pmic-id" or
>> "qcom,oem-id". "board-id-types" contains the type of parameter which is
>> entered. It can be either "qcom,soc-id", "qcom,board-id", "qcom,pmic-id"
>> or "qcom,oem-id".
> 
> Thanks for working on this, it's nice to finally see this logic
> documented in the kernel.
>>
>> Qualcomm based bootloader will use these properties to pick the best
>> matched DTB to boot the device with.
>>
>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 90 +++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 7f80f48..dc66ae9 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -1100,6 +1100,76 @@ properties:
>>        kernel
>>        The property is deprecated.
>>  
>> +  board-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    minItems: 2
>> +    description: |
>> +      Qualcomm specific bootloader uses multiple different identifiers
>> +      (qcom,soc-id, qcom,board-id, qcom,pmic-id, qcom,oem-id) to select
>> +      single Devicetree among list of Devicetrees. For different identifiers,
>> +      the selection can be done either based on exact match (where the
>> +      identifiers information coming from firmware should exactly match
>> +      the ones described in devicetree) or best match (firmware provided
>> +      identifier information closely matches with the one of the Devicetree).
>> +      Below table describes matching criteria for each identifier::
>> +      |----------------------------------------------------------------------|
>> +      |  DT property  |  Individual fields   |   Exact  |  Best  |  Default  |
>> +      |----------------------------------------------------------------------|
>> +      | qcom,soc-id   |                                                      |
>> +      |               |  Chipset Id          |     Y    |    N   |     -     |
>> +      |               |  SoC Revision        |     N    |    Y   |     -     |
>> +      | qcom,board-id |                                                      |
>> +      |               |  Board Id            |     Y    |    N   |     -     |
>> +      |               |  Board Major         |     N    |    Y   |     -     |
>> +      |               |  Board Minor         |     N    |    Y   |     -     |
>> +      |               |  Subtype             |     Y    |    N   |     0     |
>> +      |               |  DDRtype             |     Y    |    N   |     0     |
>> +      |               |  BootDevice Type     |     Y    |    N   |     0     |
>> +      | qcom,pmic-id  |                                                      |
>> +      |               |  Slave Id            |     Y    |    N   |     0     |
>> +      |               |  PMIC Id             |     Y    |    N   |     0     |
>> +      |               |  PMIC Major          |     N    |    Y   |     0     |
>> +      |               |  PMIC Minor          |     N    |    Y   |     0     |
>> +      | qcom,oem-id   |                                                      |
>> +      |               |  OEM Id              |     Y    |    N   |     0     |
>> +      |----------------------------------------------------------------------|
>> +      For best match, identifiers are matched based on following priority order::
>> +      SoC Revision > Board Major > Board Minor > PMIC Major > PMIC Minor
>> +
>> +  board-id-types:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +       Each field and helper macros are defined at include/dt-bindings/arm/qcom,ids.
>> +    minItems: 2
>> +    items:
>> +       oneOf:
>> +         - const: qcom,soc-id
>> +           description:
>> +              Matches Qualcomm Technologies, Inc. boards with the specified SoC.
>> +              2 integers are needed to describe a soc-id. The first integer is the
>> +              SoC ID and the second integer is the SoC revision.
>> +              qcom,soc-id = <soc-id  soc-revision>
>> +         - const: qcom,board-id
>> +           description: |
>> +              Matches Qualcomm Technologies, Inc. boards with the specified board.
>> +              2 integers are needed to describe a board-id. The first integer is the
>> +              board ID. The second integer is the board-subtype.
>> +              qcom,board-id = <board-id  board-subtype>
This is a recursive definition. You partially described the individual
fields above, you should do that here.

What is DDR type? What information is encoded that doesn't make sense to
describe elsewhere in DT?

Same for "bootdevice type", why would you pick a different DT based on
whether the bootloader was loaded from UFS or NAND? Why does this
information belong in DT?
>> +         - const: qcom,pmic-id
>> +           description: |
>> +              Qualcomm boards can be attached to multiple PMICs where slave-id (SID)
>> +              indicates the address of the bus on which the PMIC is attached. It can be
>> +              any number. The model for a PMIC indicates the PMIC name attached to bus
>> +              described by SID along with  major and minor version. 2 integers are needed
>> +              to describe qcom,pmic-id. The first integer is the slave-id and the second integer
>> +              is the pmic model.
>> +              qcom,pmic-id = <pmic-sid pmic-model>

Same questions here, why don't you just walk the DT and read the
compatible properties of PMIC nodes?
>> +         - const: qcom,oem-id
>> +           description: |
>> +              Matches Qualcomm Technologies, Inc. boards with the specified OEM ID.
>> +              1 integer is needed to describe the oem-id.
>> +              qcom,oem-id = <oem-id>
>> +
>>  allOf:
>>    # Explicit allow-list for older SoCs. The legacy properties are not allowed
>>    # on newer SoCs.
>> @@ -1167,4 +1237,24 @@ allOf:
>>  
>>  additionalProperties: true
>>  
>> +examples:
>> +  - |
>> +    #include <dt-bindings/arm/qcom,ids.h>
>> +    / {
>> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
>> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
>> +
>> +         #board-id-cells = <2>;
>> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
>> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
>> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
>> +         board-id-types = "qcom,soc-id",
>> +                          "qcom,soc-id",
>> +                          "qcom,board-id";
> Forgive me if this is a particularly cynical view, but this seems
> incredibly blatant, the "qcom,board-id" property is deprecated for
> various good reasons, just using a key/value map where "qcom,board-id"
> is a key doesn't change that. There are two main issues I have with the
> proposal here:
> 
> 1. This breaks backwards compatibility, millions of production devices
> with bootloaders that will never receive another update might be
> compatible with the downstream "qcom,board-id" property, but they won't
> work with this.
> 2. A top level board-id property that isn't namespaced implies that it
> isn't vendor specific, but the proposed implementation doesn't even
> pretend to be vendor agnostic.
> 
> U-Boot also has some ideas around this issue, there you can pass in
> multiple DTBs and provide some board specific "best match" function.
> I think there's definitely some value in exposing this information, but
> there's no good reason to define the same data as `qcom,board-id` while
> breaking production bootloaders.
>> +
>> +         #address-cells = <2>;
>> +         #size-cells = <2>;
>> +    };
>> +
>> +
>>  ...
> 

-- 
// Caleb (they/them)

