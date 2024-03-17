Return-Path: <linux-kernel+bounces-105477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C787DEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77A1B20B34
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E51CD2D;
	Sun, 17 Mar 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cX6WFVvU"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBDEBB;
	Sun, 17 Mar 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693639; cv=none; b=urZzltcPFzl6i9+tChu5AJdmz6CLqmvsFfnl+chyljcMG998exEzNowqohuvaVywT6gvcsDbovclxYHC5BY4Y7YJBCAS/DBx8Aa4OdL57Xm4l95zDvPMMvTnkVtMSqe0nVbO8QXLnxftyfjmzxk3UWT8pJ+tatm5D0U47Us7f9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693639; c=relaxed/simple;
	bh=TsgecbNrptHCzxnVHx58ycAMglAxWaTNOFIfsslw0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rTZQVYfPxZdc10lm3Ojr5qGJJs37wKcLXQe6IX4yaIF5NnJyB9MIENhndASCUYjkRXMKnhP5tEm4quXurfcNMDzRzpYf1kt38CTyH96+TySAtitWeBZIJpZ++GhxLJb+rA61xdMQP7Q8OfDrZGbGUCGXTUPys9GCkgi+vXWNQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cX6WFVvU; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2AEC8100003;
	Sun, 17 Mar 2024 19:40:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2AEC8100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710693634;
	bh=lEq6Kb5vBlzArU0pRaYlg7z55lfmTSD3KSjeJpJTu0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=cX6WFVvUwPP7EJJVC7Yvc9c6ByHDR2+CHSsC0r6Y2Rl7LGFUXFVzGeYI3V/szI1Zj
	 RQQB0n1/eioqV5ehuDnSCJmpCzMnS+PgN846loM74ow4lQtw+YAKEL+ko1F0Y/vWLt
	 blXftJAp1ZnqZQYMFOagvdTc+qDTpXVEut+4LWx/KCPVtvSJWPEmtvXFYO5dk+Dkvp
	 iScd+8DVRSRQEABtMNGzm4nYtRg3dEOYd71UqJ3iB+Ay305ITReeLR84GBaJEmiQti
	 nbZM+0KHX9wiXbINL3lENyc6ygjhxaMe2N9RnUW5Rne1l0kK3/wEIPuRm8WrRgXRsu
	 7LuQz9Th9hROg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 19:40:34 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 19:40:33 +0300
Message-ID: <b6fecbe4-862c-4ebe-9f56-8514a3c226d4@salutedevices.com>
Date: Sun, 17 Mar 2024 19:39:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/25] ASoC: dt-bindings: meson: axg-sound-card: claim
 support of A1 SoC family
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-20-jan.dakinevich@salutedevices.com>
 <1jr0gbhkgp.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jr0gbhkgp.fsf@starbuckisacylon.baylibre.com>
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



On 3/15/24 13:06, Jerome Brunet wrote:
> 
> On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> Add "amlogic,a1-sound-card" compatible string alias to
>> "amlogic,axg-sound-card".
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml   | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
>> index 5db718e4d0e7..492b41cc8ccd 100644
>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
>> @@ -14,7 +14,11 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    const: amlogic,axg-sound-card
>> +    oneOf:
>> +      - const: amlogic,axg-sound-card
>> +      - items:
>> +          - const: amlogic,a1-sound-card
>> +          - const: amlogic,axg-sound-card
> 
> I know the rule about SoC related name but it is different here.
> This does not describe HW in the SoC. 
> 
> The axg sound card is just a name, much like simple-card or
> audio-graph-card. I could have named it "amlogic,my-awesome-card"
> 
> We would not add "amlogic,a1-simple-card", would we ?
> 
> It is purely a software component, which aggregate HW ones.
> 
> 
>>    audio-aux-devs:
>>      $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> 

So, I can drop a couple of commits like this. Right?

-- 
Best regards
Jan Dakinevich

