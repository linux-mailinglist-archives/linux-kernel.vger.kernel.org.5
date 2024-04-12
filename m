Return-Path: <linux-kernel+bounces-142238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7B8A295C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7761C283A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6967205E22;
	Fri, 12 Apr 2024 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="i3WAUav3"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763BC50299;
	Fri, 12 Apr 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910606; cv=none; b=OVJbueF9b93t38ZyJyAZ8wEffxX9kfsf57QvUTIz38m67S8u5skSv9hnqU/V0e5GlXy3TGEdrNXHsuflN2vQdWRSpfGNUJ2VcQD4aWp0tLiii+XnPOj0MlBG8uis0TzKXVav/QFeReSLKbEwQYLByfoykav4XXPbFi1uFnr2KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910606; c=relaxed/simple;
	bh=8KwRrw1FvglWtjh9OmpBSdmXr5luoBzt7GXnXaxrha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qrn9Zz6k64hfxfbFc/tOLsCdQc6MlGJzFOeV45EM7k18Sq/oF/WnzlmcsavBFdeK7ErQWIMNgYtfzWaOG8+G3PoKwJSDrdzslUM7JyWfQxdsVHPClMqBIiu3pDdpa8eua7SmQ0CkrduWbDWnnqdxU4TonZvMDIMC4hh4P4IgCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=i3WAUav3; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6D660120057;
	Fri, 12 Apr 2024 11:29:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D660120057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712910598;
	bh=KkfixobzzUFH/w6sv2wN1/GNm+sz+aoWpuk7u8Lc5PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=i3WAUav3rZNm0jkz/QgPAN/+xrYedE5Mq70+lpf3LFkZig4ITtkQOIy+Skz45JbPU
	 B0SOjba+3OMXd4EFUkacpbGexzMdRsjRGvovXSQz+TfFwtDQXVTDYpcmMSCW0JDjR0
	 CLmyuwdZKuHBX8tgknF8GyWuWYcKrrfgB4D1XJ+uq3AdlMhgGatjOu44bBSTFnce4r
	 NY5JD14T31li3pUidfNL8g8e+PGhqg13zibe6BgeWWvSNGyuJ25Q8ewEddRHeJsoqZ
	 bUygN/5tgB3IrjNWMPkSBXkNfHc5wcEs51AqIOol8kK8yIwPWKbFSZeigAl3Ci3IjT
	 fzO59KuBEomSA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 12 Apr 2024 11:29:58 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Apr 2024 11:29:57 +0300
Message-ID: <f48ec4b6-d266-4108-bea8-baa741f2925f@salutedevices.com>
Date: Fri, 12 Apr 2024 11:29:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] pwm: meson: dt-bindings fixup
To: Jerome Brunet <jbrunet@baylibre.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-pwm@vger.kernel.org>, JunYi Zhao <junyi.zhao@amlogic.com>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <b6jyherdfnehu3xrg6ulkxlcfknfej6ali2om27d7rjmwncwxz@3wrtx6sv4xm7>
 <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
 <1ja5lzovj1.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <1ja5lzovj1.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184683 [Apr 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/12 02:59:00 #24750120
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Jerome, Uwe

On 4/12/24 11:04, Jerome Brunet wrote:
> 
> On Sat 02 Mar 2024 at 16:50, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
>> On Sat 02 Mar 2024 at 11:04, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>
>>> [[PGP Signed Part:Undecided]]
>>> Hello Jerome,
>>>
>>> On Wed, Feb 21, 2024 at 04:11:46PM +0100, Jerome Brunet wrote:
>>>> Jerome Brunet (5):
>>>>    dt-bindings: pwm: amlogic: fix s4 bindings
>>>>    dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
>>>>    pwm: meson: generalize 4 inputs clock on meson8 pwm type
>>>>    pwm: meson: don't carry internal clock elements around
>>>>    pwm: meson: add generic compatible for meson8 to sm1
>>>
>>> I applied patches #1 to #3. This doesn't mean #4 and #5 are bad, just
>>> that I need some more time for review.
>>
>> No worries. The change in those, especially #5, are pretty simple but
>> the diff are indeed hard to read :/
> 
> Hello Uwe,
> 
> Introducing the s4 support depends on this series.
> Is there any news ?

Actually we're waiting for the opportunity to introduce a1 support too.

> 
> Thanks
> Regards
> 
>>
>>>
>>> Best regards
>>> Uwe
> 
> 

-- 
Best regards
George

