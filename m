Return-Path: <linux-kernel+bounces-105591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BA87E120
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFFB20F16
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5502206B;
	Sun, 17 Mar 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="d2g4D0qY"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B31E488;
	Sun, 17 Mar 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710718795; cv=none; b=ZiR20CvJkrZZhohM817t17Hlzr5PKhM+DxW4biv7PPVGMuIuVVJSeRSEkbxHSYvMjQJ8fS1zxqJpRH6aRwSMSTPHiR+i/+va8uHS3SSRbYTH99x5I96rAwnqG7dFVN5K9YgvjhIntuXbprBBOgEcUfAbW25viGw7pB5eUJgwkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710718795; c=relaxed/simple;
	bh=xrdrLONqXUisegUxaeWCoF7p1xx5KhI42epdweRiOW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hAqgqqbLtml7S+B7+dLryJ8IE8D2vBzc6rANBvbEwWUhdsnQQ30f6ByjhtfOFuMjWOgvt7qRwen4zshGPc5S1P5quNUgXeaHacdYccximOmGEoqNJC2Hjmgh2Q4qVr4iEkHx2y4tK0O+OZm4GK2unTBuW/FhwsU+8iSvljxwsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=d2g4D0qY; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7A96D120002;
	Mon, 18 Mar 2024 02:39:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7A96D120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710718787;
	bh=bKsdI1eMZNCKrRBjX4TwkOfAmnVx5pDlExnmUyzw5I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=d2g4D0qYg7zCodKeZgunyPQ2KHFeWySByW3jsDIdDJPoZ45ddkegxgysUiOXg4C4V
	 dKCzGIMi9BrjxQg67RAkFBWIN4xHn8l6Uzhd1hn2Xqy2zDM7RyVemTuTVMJu1a/ww/
	 BmlnccNSzsyV3U6K4jD9fCGzBve5aCH7TNmBFhdfYFDj803QgXT743kOJdiMWYg+v5
	 1itPRU/yii51uY2BbU2auMmX4qV8ZkTEIqANPaliE4gJ1R+RdMRgGOmDib81FFzL0i
	 ETOVXcFgC+4fVWh/MtRgHAdAfBm8HZtpKBkt5p+NQSWWhxf/tC8zXByk80AicK4rgg
	 RAAcvadico93g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 02:39:47 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Mar 2024 02:39:46 +0300
Message-ID: <7d61700d-bfb5-46c6-bd45-a18aecf06a5b@salutedevices.com>
Date: Mon, 18 Mar 2024 02:39:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] ASoC: dt-bindings: meson: t9015: add support for A1
 SoC family
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-12-jan.dakinevich@salutedevices.com>
 <20240317190316.GA2071139-robh@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240317190316.GA2071139-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/17/24 22:03, Rob Herring wrote:
> On Fri, Mar 15, 2024 at 02:21:47AM +0300, Jan Dakinevich wrote:
>> Add "amlogic,t9015-a1" compatible string.
> 
> That's obvious from the diff. Perhaps what does 'a1' mean? What the 
> difference from the existing compatible?
> 

a1 means A1 SoC family. The difference is described in next commit where
this compatible string is added to driver. Should I duplicate here the
explanation from that commit?

>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  Documentation/devicetree/bindings/sound/amlogic,t9015.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
>> index 5f5cccdbeb34..ee8bd57dbcf9 100644
>> --- a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
>> @@ -21,7 +21,9 @@ properties:
>>  
>>    compatible:
>>      items:
>> -      - const: amlogic,t9015
>> +      - enum:
>> +          - amlogic,t9015
>> +          - amlogic,t9015-a1
>>  
>>    clocks:
>>      items:
>> -- 
>> 2.34.1
>>

-- 
Best regards
Jan Dakinevich

