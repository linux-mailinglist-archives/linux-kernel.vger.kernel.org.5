Return-Path: <linux-kernel+bounces-4979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DD8184B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D50284FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A314282;
	Tue, 19 Dec 2023 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puWFRBLb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C431427F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55370780c74so2144642a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702979125; x=1703583925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRlR9bbBvVyS6S4VmsMAEYTreNTHrgGpvzAcX5l7aOY=;
        b=puWFRBLb0WHp7aVkmH9pI6NMtGwCFK5wdVk+KzSPDHfHjDV0J//SV1BcVzD5upsyuW
         hEvsHJh8sBdwGcdcCRqH5Vk7DQGk4vBKWhtEhIo5DMbj6zEgqud4iICkWqIDxselQSaL
         vgyt8oKbZ6u+i3D8CPB2DXyU4Z/hFAtQNZ6uGmSUaQOJKR9zqJeVZgyf9F3xORSqB0fJ
         Z1baYSzP9qceB1khgTg88QiWhmAgLssbxyxC/VLbNGWcNZ+4oblrpcc6FfiS5KVOWsfM
         07GZ6Uyc5c+71Q80ZNqCAlsAkL4ojFuh1R41AYc0cyvkXx8MbOhJiwFYcknEQiVZmwtC
         Sb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979125; x=1703583925;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRlR9bbBvVyS6S4VmsMAEYTreNTHrgGpvzAcX5l7aOY=;
        b=Pt2pwoQIbtbacAM0VZ3D8lRbQTYdeiwFeZTdb5nf5mcp8lQbE/t9RURuYocYdaXHMt
         HPc8NmX6Uc40mzAY8Cst/nK7LnnG/1w8icy5gGyg5sabrtR/hij8R5aDtug++LSYqGLk
         mBRWqGzBCOhTDeMbMNICWJ4R6AkQgNrwxA2BfFodMqI5aiHw56BzyNitV8q6wv/oxfnZ
         PoaIjPTw8i8IHMabfYxcI2c2PUbXIcxYV1moHo6+m6vrfsJnBuLM7wzUD1kZnpHoa68e
         r+9TP44lAhimz71ZV5FUWKYkKczbdiMDWy29zQXK+Yy2f9HFSFVw9QPi4DL0cPf0UQNO
         U8nw==
X-Gm-Message-State: AOJu0YxuubCUPfp4MV3dmELnZR17dL0pHGIbcFDY1b5dkdXPLkxMFE7b
	0mRGT75t2RCZ/GhtehE3/UQMug==
X-Google-Smtp-Source: AGHT+IHf8gGuEoTDXOjkv3mJffP1TiyflDIBb8/woby5n1sbsurZ9BxF5yRg+Y2XEI8mLA7wCEt/tw==
X-Received: by 2002:a50:c089:0:b0:553:51ba:7402 with SMTP id k9-20020a50c089000000b0055351ba7402mr1342619edf.36.1702979125113;
        Tue, 19 Dec 2023 01:45:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0055267663784sm5407107edb.11.2023.12.19.01.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:45:24 -0800 (PST)
Message-ID: <4ab88316-6168-4cbf-85eb-abd4945b809a@linaro.org>
Date: Tue, 19 Dec 2023 10:45:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
 <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
 <4c31adc5-3fc5-47bc-9766-6d3d1eeddb65@siemens.com>
 <fbb29d81-9ea0-4468-ad47-f6668c2be277@linaro.org>
 <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 10:03, Jan Kiszka wrote:
> On 19.12.23 09:48, Krzysztof Kozlowski wrote:
>> On 19/12/2023 09:22, Jan Kiszka wrote:
>>>>
>>>>> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
>>>>
>>>> Ditto
>>>>
>>>
>>> This is adjusting the existing LED nodes in k3-am65-iot2050-common.dtsi,
>>> not introducing new ones. We can add the color properties in a separate
>>
>>
>> Then why aren't you overriding by phandle/label?
>>
> 
> We could do that as well if we added labels first (they don't exist so 
> far). Not seeing any difference, though.
> 
>>> patch, but the node names are now part of the kernel ABI. Changing them
>>> would break existing userland.
>>
>> You mean label. Why node names became the ABI? Which interface exposes them?
> 
> root@iot2050-debian:~# ls -l /sys/class/leds/


> total 0
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
> lrwxrwxrwx 1 root root 0 Dec 14 21:12 status-led-green -> ../../devices/platform/leds/leds/status-led-green
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 status-led-red -> ../../devices/platform/leds/leds/status-led-red
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-green -> ../../devices/platform/leds/leds/user-led1-green
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-red -> ../../devices/platform/leds/leds/user-led1-red
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-green -> ../../devices/platform/leds/leds/user-led2-green
> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-red -> ../../devices/platform/leds/leds/user-led2-red
> 
>>>>> +
>>>>> +&dwc3_0 {
>>>>> +	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>>>>> +				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
>>>>> +	/delete-property/ phys;
>>>>> +	/delete-property/ phy-names;
>>>>
>>>> If your board need to remove phys from the SoC node, something is wrong.
>>>> Either your board or SoC.
>>>>
>>>> Any removal of properties in DTS is weird and unexpected. It deserves
>>>> comments.
>>>
>>> This goes along disabling USB3 which is by default enabled via
>>> k3-am65-iot2050-common-pg2.dtsi
>>
>> Isn't this mistake? Common part enables only these pieces which are
>> working in common hardware SoM. If your common part of hardware, which
>> DTSI should represent, has USB3 then why is it being disabled here? If
>> common hardware design does not have USB3, then why is it being enabled
>> in DTSI?
> 
> It's a trade-off between adding yet another dtsi for those widely 
> common bits vs. adjusting the differences of only one variant from 

You don't need to add one more DTSI to achieve proper architecture of
DTS/DTSI split.

> that. We do the same for the Display Port so far.

DTSI represents common piece of hardware, like SoM or re-usable blocks,
not trade-off.

Best regards,
Krzysztof


