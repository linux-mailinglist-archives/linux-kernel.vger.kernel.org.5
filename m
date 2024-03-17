Return-Path: <linux-kernel+bounces-105400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769B87DD68
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCFA2811D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70C1C2A5;
	Sun, 17 Mar 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="o04TGxXH"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F400EAE5;
	Sun, 17 Mar 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710685809; cv=none; b=a6BZjd1sA3L1DtLlR7cS3E7FfKeKKw2Z4LpFsxdRGLfJ26R4heS2P/AyY5GfqlF5UePcZuNs+kpat5A86JlTGDyg5Pk0M8XjKllRphWSU4AO2bhVnT3UMGUkn0tGk3v9KARy2u5+v8KDxzASIY2GQHqMYqyvrxPWa8XGXksMpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710685809; c=relaxed/simple;
	bh=mACvWHc/sDSGl1pEWdfQ6+2WTvuB/H3LPCOT9PEacq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CgHnxryP/B8fnZuk24nPjjH0FYroi3IQTRGKlDCwapZaXbG5c2+8v1DsHbj2eFUac/aR1uyeR3dP+6axqqRBaBFGqarJBp5J6KoCabrewmLt/QEiohn+L07v+Sz5OF49Gav4cZTBcTulfM3A0x9Z9eVW5c4ZwEtVE+Mx7kfQ2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=o04TGxXH; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 46CC2120006;
	Sun, 17 Mar 2024 17:29:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46CC2120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710685797;
	bh=U7iGhIFEEZJr2pptTT9ef5adqscsVQVXDtlJaym04/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=o04TGxXHCIs+xdCGFZjuqAqJVDHx6+acGPFOJSTYaI6LnxXuT8PcQ2yvRfSAbQQIk
	 4meOHYBpCBtgy/6fctGtrJgHf9RoHbQC5eYtno1SL599F8tytgg/CiwhCp8Osay7L9
	 Fic1MUlA5kG6N9L8C5c8T1boCun87MWSgBEP5oNEUUhBfjk/xX7tJvibi212XHDZqB
	 kgeVfleDZbV3+LhqdLQKJr06dAulZcGzbggyE5O2wYng6Y4wBesR6mKm1yxL4aMynW
	 OVCBmur3qSylI22aidgBK/5UDVhbBzQZBBzNmjILssrsGHJQV25KrvxHzWRuz+Kvr0
	 WFngVLFSl9yvg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 17:29:57 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 17:29:56 +0300
Message-ID: <5a541ea3-ac4b-4606-9b6a-b103084b30b5@salutedevices.com>
Date: Sun, 17 Mar 2024 17:29:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] ASoC: dt-bindings: meson: g12a-toacodec: add
 support for A1 SoC family
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-9-jan.dakinevich@salutedevices.com>
 <f91ea77c-8170-4ae6-850f-3d5715d83855@linaro.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <f91ea77c-8170-4ae6-850f-3d5715d83855@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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

I mean the following... This commit adds new defines to
meson-g12a-toacodec.h header. These defines are used in the following way:

sound-dai = <&toacodec TOACODEC_IN_A>;
sound-dai = <&toacodec TOACODEC_CAPTURE_OUT_A>;

So, can you make an advise how to call something like "&toacodec" to
which I declare new parameters.

On 3/15/24 12:58, Krzysztof Kozlowski wrote:
> On 15/03/2024 00:21, Jan Dakinevich wrote:
>> Add "amlogic,t9015-a1" compatible string and new device tree phandle
>> options.
> 
> I don't understand the second part. You did not add any options, no
> phandles. You added some defines for something, so say what are these
> "something".
> 
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  .../devicetree/bindings/sound/amlogic,g12a-toacodec.yaml     | 1 +
>>  include/dt-bindings/sound/meson-g12a-toacodec.h              | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
>> index 23f82bb89750..c47604aa590f 100644
>> --- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
>> @@ -26,6 +26,7 @@ properties:
>>        - items:
>>            - enum:
>>                - amlogic,sm1-toacodec
>> +              - amlogic,a1-toacodec
> 
> Keep alphabetical order. Don't stuff new entries to the end...
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

