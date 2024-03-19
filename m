Return-Path: <linux-kernel+bounces-107300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0487FABD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C132828D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D177D088;
	Tue, 19 Mar 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUT1bPQC"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CE7CF07
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840704; cv=none; b=G6wjZ9B6H4aTAWNKJmMGihs3A35QGsDp+yd/sIiBnjUxqxkNd1UPP+vBGvhQCvm7d9sisPvl44L7QPX7QSLaH6zTfxGP57J4dwQ16+DzOopTZlpfiIKDuW7kEFHvcPdBjjAwtYalOlOBaQ8PlyjiCj/wLAfeHrgYKIKVzzEnbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840704; c=relaxed/simple;
	bh=REPKP76FKYRIlT2nLlBWQvO1u9WaatIZi9nkolGnRgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCVuokRoxAvIEiFbRRmu556r3OexdbEbY7ev8UVFmPI/Zodl9hhdntmc6yh0yYZ+1jOEj5Gsk7GtcRC2e/0vb1Pe6ilNqqp8rtQ6oSuSsrXQfzCiwFeTntYugGOiy5T1vA6hRrTXiXLp+ii/UzLueSg3lDCZZQY9jPZbZ4BTk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUT1bPQC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6696031a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710840701; x=1711445501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vqXt6FNYM7+WhScgMZhAmJx3W1Xg1L9EnIDuPxpSMk8=;
        b=jUT1bPQCayn4OpGvnCzmnQT5RpERsenBMvc6inpH4sHWN/XAPxNr/iqZAI5iY/Nrks
         rwecNqYWi9txltTA8y7QBV7oRjIoMvke3Rqedx26fscf503Gcf5GKRrs40Vxg6lrmWL6
         cEyIlbafJTsgnOjxNkvifzegjRCIOAgMFNOMxVhVzPcdTUFmz3+ecxa6oZDOoqmr3CaE
         nXUsbiQjUzsUANH1oLraoh4NAvdK7Fo5OQjSH4gvFJ0LFWfVg18RaPjZXVero0k8oWFO
         OBUZ2uGlfhQRX0jrKDQJTF+Jrv1+dU9zvBaKF0sAK+0qZgaIIRNiQSOjY3D0rjGcODTF
         IuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840701; x=1711445501;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqXt6FNYM7+WhScgMZhAmJx3W1Xg1L9EnIDuPxpSMk8=;
        b=dl3RTE2VVRkO/+Hw8gZJ202zRKH86DPTqmLb9cJoDpXtRDG5a7aqZwUDVjaX36aimQ
         0ComECsAg0rP0qGfdCN4lpL/1jc23MS+NY9uoFx4MxQCIqCN3F3RirtTt329UyIUuXrU
         gJylY5i1FrKwJvosEIK5iZewkQ+y6WOB3Pqnb1NxCqDI8VO90danx4H2g37DjTHHT1Dd
         ntWHmiCDHXmERzlzsAqdjTlN4UvZaaJVVcczNsM8/8aqmXWljevFkO94UbgHvgGisDXY
         DYcdIZs0gOCUUw5RmM1v/CZMxt0BPI6QZDLAWc5cKAgi3t2o1FAx2QqOkNIcn2ijSse2
         /bbg==
X-Forwarded-Encrypted: i=1; AJvYcCXKVTDJP5mNMuAcIEpF7JhT0eCV/mLwn+Q4w1ouSxwbUh+k+YY7yATs/ajVvqFOXqylhyUHfTWUrcnvNNFdTOMKynYBsbt3fHVrj0SY
X-Gm-Message-State: AOJu0YxPxh+AW+I2s8pot015P6jDhxN+/eb2p90kHwC5d5V3zGJYwIiB
	Cx8miuRcX16vDAyFx9OEcWVGEYC/88n/H14s5dr1uJoT0lvZpKj9IytcsWrbO84=
X-Google-Smtp-Source: AGHT+IHDKQKMxRW9umwUH256VRLPVuzmLJipnN6Ucqw+yjw+b5IxQV0P9OFyO2GVuWCiNBDxIeL/pA==
X-Received: by 2002:a17:906:ef0c:b0:a46:c01b:7e2c with SMTP id f12-20020a170906ef0c00b00a46c01b7e2cmr4320148ejs.75.1710840700830;
        Tue, 19 Mar 2024 02:31:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090670d100b00a46a04d7dc4sm3944468ejk.61.2024.03.19.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:31:40 -0700 (PDT)
Message-ID: <8caabb1a-dfba-48d5-a794-a26d0286bad2@linaro.org>
Date: Tue, 19 Mar 2024 10:31:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naushir Patuck
 <naush@raspberrypi.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
 <3834dd0a-6dd0-45b1-8b9c-0c840aaf8cf2@linaro.org>
 <22225e92-803d-4aaa-b75f-cfd1d7d8c279@ideasonboard.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <22225e92-803d-4aaa-b75f-cfd1d7d8c279@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 07:46, Tomi Valkeinen wrote:
>>> +  reg:
>>> +    items:
>>> +      - description: CSI-2 registers
>>> +      - description: D-PHY registers
>>> +      - description: MIPI CFG (a simple top-level mux) registers
>>> +      - description: FE registers
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  port:
>>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>>> +    additionalProperties: false
>>> +    description: CSI-2 RX Port
>>
>> Only one port, so there is nothing to output to?
> 
> The CFE has DMA, so it writes to memory. But no other outputs.

You still might have some sort of pipeline, e.g. some post processing
block. But if this is end block, then I guess it's fine.

> 
>>> +
>>> +    properties:
>>> +      endpoint:
>>> +        $ref: video-interfaces.yaml#
>>> +        unevaluatedProperties: false
>>> +
>>> +        properties:
>>> +          data-lanes:
>>> +            minItems: 1
>>> +            maxItems: 4
>>> +
>>> +          clock-lanes:
>>> +            maxItems: 1
>>> +
>>> +          clock-noncontinuous: true
>>
>> Drop
> 
> Hmm, I saw this used in multiple other bindings, and thought it means 
> the property is allowed and copied it here.
> 
> If that's not the case, does this mean all the properties from 
> video-interfaces.yaml are allowed (even invalid ones, like pclk-sample)?

Yes, that's the meaning of unevaluatedProperties you have a bit above.

> 
>>> +
>>> +        required:
>>> +          - clock-lanes
>>> +          - data-lanes
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/rp1.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/mfd/rp1.h>
>>> +
>>> +    rpi1 {
>>
>> soc
> 
> That should actually be "rp1", not "rpi1". rp1 is the co-processor on 
> which the cfe is located, so it doesn't reside in the soc itself. But 

Where is the co-processor located?

> perhaps that's not relevant, and "soc" is just a generic container that 
> should always be used?

Does not have to be soc, but rp1 is not generic.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation




Best regards,
Krzysztof


