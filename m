Return-Path: <linux-kernel+bounces-138836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D693589FB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76E7B2CC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8816E877;
	Wed, 10 Apr 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZH0ALDkG"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C992AF16;
	Wed, 10 Apr 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761307; cv=none; b=IPzKfzjwkpO/hKn0HydGATBznBxe6JW2lY+JimfsK4crWf6+9H/fRw4jUZZwpBiqt1FGCYx2yLuxGfcnEZILpr/x+nrosOKBBFdMPXL1RAxGcoW7okfRQ4z/+L1sTeM+vt69F5UQqLnrspYC21cy92dvs5kdzohAFY23t1RnEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761307; c=relaxed/simple;
	bh=kkXbdZNH9h55ww3tWrdUPk17fd5BeR//NtkGf/l8KO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nAOcFfe6DCgacQ+IITCCWfP2SElByZbBriaRLCGS556e4dsFmJlMkLqrrBHlYUB6TeXv2HwpBtuj6An11B0L/sYI6UN5ZSVU0eFQRSaFFss3ES8SmOg+pRq9fYjM94ym7Y7B6sJ6jxoIL0jfD9mXzfjznJA0DePR+8VnbL4SFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZH0ALDkG; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B4C4E12005F;
	Wed, 10 Apr 2024 18:01:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B4C4E12005F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712761302;
	bh=q1gcIhloFFL/kbDvWiIUFlnWRSNETi2Q1q4ICf8bZ6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ZH0ALDkGOFqCk6vAz3G8gC5+qvvZ2daY3q3VrOwr+zrqqGSGa07E84C9GlJDBT58g
	 koMTQTOIv1J0nS663xzaY8Hld8Kq0yA6yu2lMLIrTzdKnnG9+rVXy4KttYznHyKy6E
	 mRSM+KL5H38VTy3Wi9YNjGCmax06SqZ5m9vbNN6G1wBz+r92CwlDhrnS7IfqMxxEa5
	 2+iPeI6dnMXqGnRNqt8Iy/pnF2vWaowH6VPsS4IDwSSYGy7qZP/H2hOBZwCJv9V8gf
	 1GZ/hsQFjDTN4H9z/uCGwDYzkCnnO8WibNenQmM2eVgWayLolSqKqqYkNCmvcqkwZa
	 G8jph7IqvgDqw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 18:01:42 +0300 (MSK)
Received: from [172.28.64.75] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Apr 2024 18:01:42 +0300
Message-ID: <b623a374-4e2f-7160-8d11-75f9beaac42b@salutedevices.com>
Date: Wed, 10 Apr 2024 17:51:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240409181025.55504-1-avkrasnov@salutedevices.com>
 <20240409181025.55504-2-avkrasnov@salutedevices.com>
 <20240410122356.30852b3c@xps-13>
 <588551c9-3426-e623-e2aa-70b040c9324a@salutedevices.com>
 <20240410170040.37a59ff6@xps-13>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240410170040.37a59ff6@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184655 [Apr 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/10 11:03:00 #24738255
X-KSMG-AntiVirus-Status: Clean, skipped



On 10.04.2024 18:00, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Wed, 10 Apr 2024 17:48:02 +0300:
> 
>> Hi,
>>
>> On 10.04.2024 13:23, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@salutedevices.com wrote on Tue, 9 Apr 2024 21:10:24 +0300:
>>>   
>>>> Boot ROM code on Meson requires that some pages on NAND must be written
>>>> in special mode: "short" ECC mode where each block is 384 bytes and
>>>> scrambling mode is on. Such pages located with the specified interval
>>>> within specified offset. Both interval and offset are located in the
>>>> device tree and used by driver if 'nand-is-boot-medium' is set for
>>>> NAND chip.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>> ---
>>>>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> index 57b6957c8415..b86a1953056b 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> @@ -64,11 +64,25 @@ patternProperties:
>>>>          items:
>>>>            maximum: 0
>>>>  
>>>> +      amlogic,boot-page-last:
>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>> +        description:
>>>> +          The NFC driver needs this information to select ECC
>>>> +          algorithms supported by the boot ROM.  
>>>
>>> Shall we have a length rather than the last page?  
>>
>> You mean rename it to "amlogic,boot-pages-length" or something like that ? But I think
>> length in bytes is useless here:
>> 1) boot rom needs that only some single pages are written in special mode (and as I see in
>>    vendor's driver it also works in pages).
>> 2) NAND driver operates in pages during write/read such pages.
>>
>> So length in bytes will be converted to pages anyway.
>>
>> What do You think ?
> 
> I didn't talk about units :-)
> 
> Maybe: amlogic,boot-pages would make sense? But pointing at the last
> page seems weird.

Ah ok I see. Got it!

Thanks, Arseniy

> 
> Miquèl

