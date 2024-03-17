Return-Path: <linux-kernel+bounces-105475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07B87DECA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D29B212AB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7901CD1F;
	Sun, 17 Mar 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ara94oKz"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6991B949;
	Sun, 17 Mar 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693355; cv=none; b=qaifTeVqZasRAIudoqFQV9fldY6hq5UH8rVAwCM/+C3U/kl8qixoAS8/d6Ny21yp9asgaQRNIfrwNviKHk0fFCsFb+WSs1ULvYH2vZfY0ggOJnq7Ed3QyCG6lfkc9VE1JxAuKwzUOpOqxwq19K03abtC84N3xYNsu+lrMaHcR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693355; c=relaxed/simple;
	bh=gmZqrtyjjwD9R4sglF2+1zq31ebpUlWiHqXoiN/atwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GVjjoPGvZyxvrYdfCDcdyYVnZsUQgWgdUN1P1GZRz+YT95kBy2lRQEytlkT22hkTkhn0EXPwPURnSiyR63hH+0FeJ0NTQ0Qn0iVWqlWck6QXOqObr8Bcdama1jSKbvSN+FhDalp3HsoCfOZMx3WZ46GwLMdUAAzpZF3XxXHE4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Ara94oKz; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9E21D100003;
	Sun, 17 Mar 2024 19:35:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9E21D100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710693349;
	bh=Ho5gEdZl2vZzSp+HXgGh6i6bfV8nU1CpEhQEWuG2/+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Ara94oKz7OXqeuBEALrfmD21Q7S2/FkFqw9Rm4p1sWOnZzgnr1kRs62lsXW1DO7ok
	 wu+D+HmHLdD6ji8551aC9cvT/8hgancPp+ia70XsCCIz6BMnQXJl/eXHf2Lxh0rFVm
	 97LlkfOIS0UrIiP67Bji/8E5MyAa3++cbccunkLwfKx+I3E2wnPpWrcjOpgYlxO5FU
	 psBttpHSrNxMsYt3RXhy2z4rNOl72SERA9vopOkTg6XaOar25tzy6d+pLHKHyh61++
	 NGnhmG/bL2V8/zvLGsSGeR+/dwv1SxixreFtfha++c4DlLD7uZZdB8ieCblfJxpV1V
	 c0Y81H3ervWxA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 19:35:49 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 19:35:48 +0300
Message-ID: <54e924ae-4d45-4337-aeae-32eebe773b63@salutedevices.com>
Date: Sun, 17 Mar 2024 19:35:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] ASoC: dt-bindings: meson: axg-pdm: document
 'sysrate' property
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
 <20240314232201.2102178-14-jan.dakinevich@salutedevices.com>
 <ca80caab-2664-4797-a222-e14537eea440@linaro.org>
 <827c4f17-043e-4e09-aea6-0fee22d1b234@salutedevices.com>
 <16a22924-054d-4d50-9f32-cc07c0bbbdf4@linaro.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <16a22924-054d-4d50-9f32-cc07c0bbbdf4@linaro.org>
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



On 3/17/24 19:27, Krzysztof Kozlowski wrote:
> On 17/03/2024 16:55, Jan Dakinevich wrote:
>>
>>
>> On 3/15/24 13:00, Krzysztof Kozlowski wrote:
>>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>>> This option allow to redefine the rate of DSP system clock.
>>>
>>> And why is it suitable for bindings? Describe the hardware, not what you
>>> want to do in the driver.
>>>
>>
>> What do you mean? I am adding some new property and should describe it
>> in dt-bindinds. Isn't it?
> 
> No, if the property is not suitable for bindings, you should not add it
> in the first place. So again: explain what sort of hardware, not driver,
> problem you are solving here, so we can understand why do you need new
> property. Otherwise use existing properties or no properties, because we
> do not define all possible clocks in the bindings.
> 
> Let's be clear: with such commit msg explanation as you have, my answer
> is: no, driver should set clock frequency and you do not need this
> property at all.
> 

Could you please take a look on answer to "Jerome Brunet
<jbrunet@baylibre.com>"'s message on the same thread. There, I am trying
to explain what I am solving by this commit.

I would be happy to avoid this w/a, but currently this is the best I
came up with.

> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

