Return-Path: <linux-kernel+bounces-105460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B950387DE2A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3D82811B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F91CAB3;
	Sun, 17 Mar 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Zn4i5CUG"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438D1C68F;
	Sun, 17 Mar 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710691006; cv=none; b=tijDRold05HFw2+wUwCiNXM2xzqu3+pzOABoTweebDs7XlLDZrXXIe0C7w7TlQHxbq+SRphfzAbCFt4HF97VHX1ERIUpEyr+W4O6opj2HkULqCg55ffX48rccSW48wLuqstv1DiwzIhlovZc7Wh5LOXd5N5JFjamUUVwfh9TIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710691006; c=relaxed/simple;
	bh=LOpDTryQU9TB276fSdpuc7hzwIz6lRjRgZpEEbygp3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RCIhiT20W4MyJd4XQ+hBLnq2GSpkdJr4UwYdE2y6C4BNysJzopJorjavJuQqJYUzpDchcDW9radxR+fm1Z/j7WWSaMKodTFmLqtn2JNCCKstTtt1C1AN0obTqPCOim+eT7MEENYp6uyIZd3n2MhJr8qe8L3OVTOzP5B0XqpCkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Zn4i5CUG; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DF8FA100004;
	Sun, 17 Mar 2024 18:56:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DF8FA100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710691000;
	bh=Cfmvtd8+RWjDHdplGc7y/19DFlRbIEeWUqLQYoQINEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Zn4i5CUG1rPcaaBktZp5q4tiGyqYkTpX9uyN9C9GryTrFOVtH+MG1VhRCoV+rEOEs
	 fAg+L62GHJ977FjWkckAtdno5kHjtFyisRNEuYQPFdjwon/kdkrBKmsKlth+3NNUN/
	 MRV89kKCp3EtotqGmP98txRu/b12yEjgZX7ZVq3hNx28eHWiRF/AyQqd+a2dETp9NP
	 IKdwbVCZGRtzgXQvm9Phx5fHovnL2QBjoblSNtuKMvyneuR77JOvhgysMrQHBV+Orb
	 y5GVgzZPqE9IeS/sVC+9E1aw2jlfaB8pHxfuTdGtU81C/7WHpIp+jY86YpImq9xgx3
	 sZHQAgm4ifuPQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Mar 2024 18:56:40 +0300 (MSK)
Received: from [172.28.160.49] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 18:56:40 +0300
Message-ID: <827c4f17-043e-4e09-aea6-0fee22d1b234@salutedevices.com>
Date: Sun, 17 Mar 2024 18:55:57 +0300
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
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <ca80caab-2664-4797-a222-e14537eea440@linaro.org>
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



On 3/15/24 13:00, Krzysztof Kozlowski wrote:
> On 15/03/2024 00:21, Jan Dakinevich wrote:
>> This option allow to redefine the rate of DSP system clock.
> 
> And why is it suitable for bindings? Describe the hardware, not what you
> want to do in the driver.
> 

What do you mean? I am adding some new property and should describe it
in dt-bindinds. Isn't it?

>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>> index df21dd72fc65..d2f23a59a6b6 100644
>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>> @@ -40,6 +40,10 @@ properties:
>>    resets:
>>      maxItems: 1
>>  
>> +  sysrate:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: redefine rate of DSP system clock
> 
> No vendor prefix, so is it a generic property? Also, missing unit
> suffix, but more importantly I don't understand why this is a property
> of hardware.
> 

Answered in next message.

> Best regards,
> Krzysztof
> 

-- 
Best regards
Jan Dakinevich

