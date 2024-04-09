Return-Path: <linux-kernel+bounces-137079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B889DC18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B90928333A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8F12FF65;
	Tue,  9 Apr 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AXB8s412"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E712F5BD;
	Tue,  9 Apr 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672474; cv=none; b=Ou7CEtoKskesx+vzMDVt6PUlcCbQy9xZukCrzrJnh57Rjj6RrRSiIUJaaN1Cz7WqSXUMcw5WShay7d77iT1m9niKV2FDJA4jlurQabtCyk59sbRQXK9hA+0YXAD6hQgztAQXjVx4r0cX8wkRiVK4hXE6vNSOR0EGW/FLqwR75AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672474; c=relaxed/simple;
	bh=sdTINZRe6/HjOBVJ9C9IQxqKUVQS44ToJ7dO5OXxeaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QMT365Ni7yPmtOJbQB48QScY3nXMomrb81/eXEEdgNOKrRcPEiLdYlSjYalW5FgxZoPLRGvhFYg5Jb1pY3K9wpkqpYMsWMqVIXBNJag8YDrqkPN3auvGUnR5xS5AVjAO4/wFUxL8E8R7Z34bUFtRbf6AeNJkWsoMTbk8JqL0M40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AXB8s412; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9067610004E;
	Tue,  9 Apr 2024 17:21:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9067610004E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712672462;
	bh=PqqwNRBmzHK+DLV9MrZ64lR7K93sMpyqnXfDyXtgkGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=AXB8s412EtfApS8JBXRYpNcDBCIAk+Bj60Eme6Ex5OHAdTHuR7Q2Tb50sbPVdLVnX
	 q7AX0kE+CynjDrR6AsNocwr+RtVRL1+TFDId4nFNNeHzfioyvtg7j/wysx4lP33V+A
	 5cImDkLmY0ar3yfgCWzEZTg1qxG2EosPttgDd4z3dX8Q3AaaDu7ZXWc7rE/besRp1d
	 49GAC5BsCSWwLo9G3qv+0AxP2ymNMS57KMbZV7O4rrrl2Pxn5NsFOoZ9ahgPgUdg8G
	 jSkDjp8cLEWo0oXTo3mrLpqJPfbx5hdFXuFMgAscb6GQWC+5p+qvQjCWxlAHuKPkxn
	 NKZ899P8uJOTA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Apr 2024 17:21:02 +0300 (MSK)
Received: from [172.28.160.201] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Apr 2024 17:21:01 +0300
Message-ID: <c9fa6376-a88d-278a-7c20-813f0e8975d8@salutedevices.com>
Date: Tue, 9 Apr 2024 17:10:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240408085931.456337-1-avkrasnov@salutedevices.com>
 <20240408085931.456337-2-avkrasnov@salutedevices.com>
 <20240409134718.GA1050037-robh@kernel.org>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240409134718.GA1050037-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184638 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/09 12:42:00 #24719205
X-KSMG-AntiVirus-Status: Clean, skipped



On 09.04.2024 16:47, Rob Herring wrote:
> On Mon, Apr 08, 2024 at 11:59:30AM +0300, Arseniy Krasnov wrote:
>> Boot ROM code on Meson requires that some pages on NAND must be written
>> in special mode: "short" ECC mode where each block is 384 bytes and
>> scrambling mode is on. Such pages located with the specified interval
>> within specified offset. Both interval and offset are located in the
>> device tree and used by driver if 'nand-is-boot-medium' is set for
>> NAND chip.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> index 57b6957c8415..80ba5003ca70 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -64,11 +64,25 @@ patternProperties:
>>          items:
>>            maximum: 0
>>  
>> +      amlogic,boot-page-last:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          The NFC driver needs this information to select ECC
>> +          algorithms supported by the boot ROM.
>> +
>> +      amlogic,boot-page-step:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          The NFC driver needs this information to select ECC
>> +          algorithms supported by the boot ROM (in pages).
>> +
>>      unevaluatedProperties: false
>>  
>>      dependencies:
>>        nand-ecc-strength: [nand-ecc-step-size]
>>        nand-ecc-step-size: [nand-ecc-strength]
>> +      amlogic,boot-page-last: [nand-is-boot-medium, amlogic,boot-page-step]
>> +      amlogic,boot-page-step: [nand-is-boot-medium, amlogic,boot-page-last]
> 
> You need quotes if using the inline syntax.

IIUC it must look like this:

amlogic,boot-page-last: [nand-is-boot-medium, "amlogic,boot-page-step"]

etc.

> 
> Rob

