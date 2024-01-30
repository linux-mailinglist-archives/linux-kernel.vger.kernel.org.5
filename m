Return-Path: <linux-kernel+bounces-45356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AA842F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB17D1C24515
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4637D3EB;
	Tue, 30 Jan 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ8rXa/J"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA47D3ED;
	Tue, 30 Jan 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651874; cv=none; b=PZIGnDMExYDlFAWnPBPxGUjXWXlUkuvhMm99RyVapk+KZYN16RL/qQRvxh27p9CuZKgU33cgOlWpS+WMWbwKeKet968xfTa2oVCBy4Tzov6NoXMHqJ/zzeIS1LpMTquWxd+ND2w9XpeKlcj9oyFmwmayPO12oLRckRhrZ1Tk9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651874; c=relaxed/simple;
	bh=HDWDAcQoYXifJAgQU95qvjKYaNNSaHnT1PVLpa+0ZHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8w3OpW29+q0WKDjxqFMWcBAsPKJ2Ke1rv+UnesKv6SEmg+GplATlk++Q2ayaa87vFonQsxt2gR7V8qk24o/uKqc+EnsyAVIJCXPxDHCwiAH4/AF0eSkTns2SzD/JRr7APtZHABpwHU2zqGbyeDRuOA8JNKg+4lImmbwcQbSzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ8rXa/J; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so607259366b.3;
        Tue, 30 Jan 2024 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706651871; x=1707256671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdh/VQpoX951eaSBCyP28Nr1FHihNafI7p4+z0vryQs=;
        b=KQ8rXa/J37U7wb7KHrtHOx6czJ6ul7t2tz6610jCIPG0ZC2WCmfGmbrkM/gouYvKKd
         GQg7mOIQgrasd7+iHcEl40IqKZA/jOqoLoSMEjQny6FbgJJZKkaHSAA74g9gpA3oFPMb
         1ypx/9QebExnKgN0fFvgLgbhwp3Ph8cyfoA+X5hDoFvFHdxgM2/4q57AdYYeyGaHV7hA
         DCitzktYTyUHXqbys4HEkBZTaoEkg/Nd8vhfmjKMeOUekZ8bXP43jJ1zgmyw+KaoocET
         srS0NwkZjszcqjax0V8g46FvYzL43JXHRUoHd4jz959hTVAat3aEaOo3huKqCMxUkGRR
         4Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651871; x=1707256671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdh/VQpoX951eaSBCyP28Nr1FHihNafI7p4+z0vryQs=;
        b=kTGB3WCubst1/DcxXG7po9q67EhDvomWhKTD8mhAxsdjZJpEk2WOao8tOY3s92wJiz
         reZ52waM+gmIhp1Iu9CD630r3gpLffUb/VBsPsxi4DG+6j05NuP5yl9imj3Sx7HYczn6
         ol12HaGwifLL0bWSu01U4/sgg8gkW8zQbCCX6IynA2i6ZxR8WJtoKq4EWKZe/S2yK6UQ
         KfFoVDjs0dimwxeU5O93enXWiWgCpxNG7cMVHvuyfSo65vDir875+kKUuHXYc+daP1Q9
         xW/NuozaAHSJJsFBnegbuTnMvIQYw+VQtrFjSss9P61miUTxn0Z85cYgKZOkSAlOFqxY
         BJqg==
X-Gm-Message-State: AOJu0Ywa9smqYU8DSH9d9rWaib6vzl1LMBBXqUAp321+d9cJ6LkxqJpA
	t5+I0e2omJ04FnB1ZubteM+Ff7HcXa5ZxKnDGghJBL7GzYeuIVFs
X-Google-Smtp-Source: AGHT+IEQSbMTrpr0DCCyf4rAOMtntZKl6TLmVGMeQghYBiFGqw3C3cfdFBUahwQOq31kv6SqyZh6xQ==
X-Received: by 2002:a17:906:4ad2:b0:a35:fbc4:4c20 with SMTP id u18-20020a1709064ad200b00a35fbc44c20mr3161908ejt.6.1706651870454;
        Tue, 30 Jan 2024 13:57:50 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id x10-20020a170906298a00b00a34a20b247fsm5519809eje.84.2024.01.30.13.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 13:57:49 -0800 (PST)
Message-ID: <c2adae73-9f1b-467e-880d-3e87eaeb10ea@gmail.com>
Date: Tue, 30 Jan 2024 22:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the
 json-schema
Content-Language: en-US
To: Rob Herring <robh@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240123082100.7334-1-zajec5@gmail.com>
 <20240123082100.7334-3-zajec5@gmail.com>
 <e17b85b1-7f1f-4b60-89b7-43f560466cc2@collabora.com>
 <20240130203413.GA2290196-robh@kernel.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240130203413.GA2290196-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.01.2024 21:34, Rob Herring wrote:
> On Tue, Jan 23, 2024 at 12:20:29PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 23/01/24 09:20, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> This helps validating DTS files. Introduced changes:
>>> 1. Documented "reg" property
>>> 2. Adjusted "reg" in example
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>    .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 +++++++++++++++++++
>>>    .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
>>>    2 files changed, 47 insertions(+), 25 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>>    delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>> new file mode 100644
>>> index 000000000000..7340a2512402
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>
>> I think that we should really move all those clock controller yaml files to their
>> proper directory, which would be
>>
>> Documentation/devicetree/bindings/clock/
>>
>> ...because those are clock controllers anyway and the fact that they do also
>> provide a reset controller doesn't really justify having them in arm/mediatek.
>>
>> Besides, I would appreciate if you could also move mt8186/92/95 and eventual
>> others that are there to clock/.
> 
> Yes, please move it.
> 
>>
>>> @@ -0,0 +1,47 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pciesys.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek PCIESYS controller
>>> +
>>> +description:
>>> +  The MediaTek PCIESYS controller provides various clocks to the system.
>>> +
>>> +maintainers:
>>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - mediatek,mt7622-pciesys
>>> +          - mediatek,mt7629-pciesys
>>> +      - const: syscon
>>
>> I know that there's syscon all over the place and, even if I admit I didn't check,
>> I am fairly sure that there's absolutely no reason to have syscon there, and that
>> the syscon compatible never did anything for (most of, or all of) those clock
>> controllers, at all.
>>
>> I'm not sure - though - if removing syscon during the txt->yaml conversion is
>> acceptable (yeah we'd be cheating a bit), but something makes me say it is, because
>> the bindings couldn't validate before that one as well.
> 
> As long as you state why you are removing it in the commit msg.
> 
>>
>> Of course you'd have to remove the syscon compatible from the affected device trees
>> as well as omitting it here.
> 
> You could also do 'minItems: 1' and 'deprecated' in the 2nd item.

I expected this to be quite straightforward but I can't get it to work.

Can you tell me if I'm making some mistake or is that some meta schema
limitation?

properties:
   compatible:
     oneOf:
       - minItems: 1
         items:
           - enum:
               - mediatek,mt2701-hifsys
               - mediatek,mt7622-hifsys
           - const: syscon
             deprecated: true
       - minItems: 2
         items:
           - enum:
               - mediatek,mt7623-hifsys
           - const: mediatek,mt2701-hifsys
           - const: syscon
             deprecated: true

Gives me:

Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml: properties:compatible:oneOf:0:items: 'oneOf' conditional failed, one must be fixed:
         [{'enum': ['mediatek,mt2701-hifsys', 'mediatek,mt7622-hifsys']}, {'const': 'syscon', 'deprecated': True}] is not of type 'object'
         Additional properties are not allowed ('deprecated' was unexpected)
         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml: properties:compatible:oneOf:1:items: 'oneOf' conditional failed, one must be fixed:
         [{'enum': ['mediatek,mt7623-hifsys']}, {'const': 'mediatek,mt2701-hifsys'}, {'const': 'syscon', 'deprecated': True}] is not of type 'object'
         Additional properties are not allowed ('deprecated' was unexpected)
         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

