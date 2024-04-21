Return-Path: <linux-kernel+bounces-152521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB08ABFBA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473E51C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E619477;
	Sun, 21 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jjmKcyAA"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8D18637;
	Sun, 21 Apr 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713713872; cv=none; b=TCeDRDHA/wJs9evNoJBykbr4zN0yIjM+0wUHb0Y8kUOXT2XRPvAI6vaaKXSvdNbhrHThpcT5/MmzgC7pIok646PXDTfDOZ4l9USzmoR7oVjBIDj5u2VEumIpa3H4FLsZlypolxR80e9BvErZQFbNyx25YUCfkLtAVp3cx1xy7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713713872; c=relaxed/simple;
	bh=Noi3jv3WhT97IlFTg5yPcmRTYZ03tHGamChGjSBgpy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Aw0WvOFQKR2tB8wrM0aksTE2tSV5BS5jtSpqY0tXDQG1qRZzFbMpUGxOZPkRV6PdiYdfe8wi/haHGb5ePhXtX3HmWz/XXSvaYh/kdXhJMvYvJo2bjpKf4e+ILVj0iXJv1pRABbRjURBXdGcHymFV1uh73wcmO9p5w1dRphXxUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jjmKcyAA; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CA84F120005;
	Sun, 21 Apr 2024 18:37:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CA84F120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713713858;
	bh=hogG5LV3BYlzBZpuc6YRB+xya+znZiqbrBBz/0q4CZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=jjmKcyAAMkHb88S6n3mQTDSBb3v0dA3c9JdNCBzllHfsVjlMM6Ir0svf0YlQWeNJ8
	 IYhVDYPyzlOoOV1idB+t0mIOyjsDDe7lWg+8gTld3L9/8VuePjWnSrdbxObtVIW954
	 5FIWG7lEfDNXzWp9/zzPIyIG0inxzxugaGntNvOdnX+UHO8tikUrHBfeSNWv/l2m/2
	 nynf1JK1nw4hbdM1S10TQ374Tn/94UnRiqJGWlyRxJ/g8ixKAJ2YfzmHD//KoBzEyP
	 Gc2/FQLPWWLjaB66exJoRiIKklp/4Q4yMcwTlBesDhRobtILnIcc7C3ff/klIIEuBl
	 /129qqGUTTp2g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 21 Apr 2024 18:37:38 +0300 (MSK)
Received: from [10.8.0.14] (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 21 Apr
 2024 18:37:35 +0300
Message-ID: <ca1b1263-1574-4fbe-913e-f68f6c59608e@salutedevices.com>
Date: Sun, 21 Apr 2024 18:35:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/6] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
 <07b1ca57-49a0-4151-99bf-caac053eaa01@kernel.org>
 <0194ddb8-6e93-4a77-9fdd-93fc79a4e03e@salutedevices.com>
 <7746a6a8-110f-4920-9f15-8fb592e829ff@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <7746a6a8-110f-4920-9f15-8fb592e829ff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184821 [Apr 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/21 07:35:00 #24905600
X-KSMG-AntiVirus-Status: Clean, skipped



On 4/21/24 17:02, Krzysztof Kozlowski wrote:
> On 20/04/2024 16:48, Jan Dakinevich wrote:
>>>> +                clock-names = "pclk",
>>>> +                              "dds_in",
>>>> +                              "fclk_div2",
>>>> +                              "fclk_div3",
>>>> +                              "hifi_pll",
>>>> +                              "xtal";
>>>
>>> Make it complete - list all clocks.
>>>
>>
>> You mean, all optional clocks should be mentioned here. Right?
> 
> Yes.
> >>
>>>> +        };
>>>> +
>>>> +        clkc_audio_vad: clock-controller@fe054800 {
>>>
>>> Just keep one example. It's basically almost the same.
>>>
>>
>> The worth of this duplication is to show how a clock from second
>> controller (<&clkc_audio_vad AUD_CLKID_VAD_AUDIOTOP>) is used by first
>> one. May be it would be better to keep it... What do you think?
> 
> I don't understand what is worth here. Using clocks is kind of obvious?
> What's special?
> 

The special is that the clock "pclk" for "clkc_audio" must be
<&clkc_audio_vad AUD_CLKID_VAD_AUDIOTOP>. This thing is not obvious. I
can keep only "clkc_audio" node here, but reference to "clkc_audio_vad"
will be undefined in example. Is it okay?

> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

