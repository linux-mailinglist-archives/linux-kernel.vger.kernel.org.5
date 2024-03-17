Return-Path: <linux-kernel+bounces-105440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD6587DDE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B9C1C209D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448961C6B7;
	Sun, 17 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Z4kUHGOp"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613201C696;
	Sun, 17 Mar 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688827; cv=none; b=Vx1NqfNWDDtac0duSSYg6C3haPvjwemj6m0cQnf4RHzpxs2LU5qTpfEeB4C1I8VUDr7i70m+Im99ljYT4C94NCw0UbwVuflgSZOORwcRgemJkaHaCssStmBsgR+ALlSWUJarlAfBF8bqu0PeUl5G8g3tFU5jdaCm1wcVK29e+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688827; c=relaxed/simple;
	bh=VoSqNLYv2i0ZbSLZdhqqHqA7Sr+JNd2dFFiH2pYAt6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sCrjhl2agSlbzYgwUys9c1raSRmOjUPNFQitsZO87osNJEoxfxfx6aHWoV8Dfh+51bS2bH4iGedml7r4k4d9tlvJJJySdCx6hLRSl7yd26m9Ka5/ps8hlNvPzx0CzogBa+8PjmZNwH45Htwy81aFB1r5CTj8uH6m2guDROMHmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Z4kUHGOp; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7F206120006;
	Sun, 17 Mar 2024 18:20:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7F206120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710688819;
	bh=V0nv3zgvdKj1Lp4YbBHZoSBadq2eA8+xFKoUJSBsE9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Z4kUHGOpgIiCzFmKxPX172UziPQP3MmtXzVPzlvesuZGwluMZX/bjigs7i5+lXJYO
	 6b9FqZ+r6vlAHIU/wzGgGT94z6UfCoYQUXHy1xTxSn2HrLAmTz0ULFYTXfO4LfiOFc
	 9g4taKa3wMlaJe2D6Ef5VK6K0BRWjGOal61J71l3vdKiIeUCeY/wEVD7xdvf7moVIw
	 PXvUnF7/gcArytcKWO4A5rnMV/2ILBDsztpsrjWVROQ4dGjUvvTcvA9veec4CWA4B3
	 BxdjImQ9mx8cJ7OZigIn9MNGcZA5hCaFuXaJDFIQwPfrH4Jr7BO3VQKepAodb78gkQ
	 cNLMfIrTdStog==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 18:20:19 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 18:20:18 +0300
Message-ID: <3ae535cf-9a89-4187-a761-8390d649b00b@salutedevices.com>
Date: Sun, 17 Mar 2024 18:19:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/25] ASoC: meson: g12a-toacodec: add support for A1 SoC
 family
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
 <2a41e8b6-7e8a-4995-a1d7-c5d30e53c2d5@sirena.org.uk>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <2a41e8b6-7e8a-4995-a1d7-c5d30e53c2d5@sirena.org.uk>
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
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/15/24 16:33, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 02:21:45AM +0300, Jan Dakinevich wrote:
> 
>>  static const struct regmap_config g12a_toacodec_regmap_cfg = {
>> -	.reg_bits	= 32,
>> -	.val_bits	= 32,
>> -	.reg_stride	= 4,
>> +	.reg_bits		= 32,
>> +	.val_bits		= 32,
>> +	.reg_stride		= 4,
>> +	.max_register		= TOACODEC_CTRL0,
>> +	.max_register_is_0	= true,
> 
> If the maximum register is 0 how does the regmap have a stride?

reg_stride inherited from existing code. Apparently, it was meaningless
even before my modifications (the hardware has single register
regardless of max_register declaration) and it should be dropped. But,
is it okay to remove it in the same commit?

-- 
Best regards
Jan Dakinevich

