Return-Path: <linux-kernel+bounces-15254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA582292E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5428528A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F181862E;
	Wed,  3 Jan 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V6HHqHGq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA9182B9;
	Wed,  3 Jan 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704268636; x=1704873436; i=markus.elfring@web.de;
	bh=HVKTWztEQ+2dMi/RMBadEFDB/54G8PYPCBjeOYxfJGI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=V6HHqHGq8/7QT207WLZdx2bQYB/oSpbSdwuhfzkWlRqQHYHhDSW3E7nM2WDUP5FM
	 pQ4cC4gwkxCe3cdMJGaiiATvMKn7Z4vh+0IK/4JcRG+nkBD6KjY8GPi70FpzpA8DC
	 wfXAmfHHg+QOGxvp3hOsJ90ZWrTOrwcgSiMPv+MpLIubIaIffix2ET2HvV3JNtW66
	 indm+hQMXcl24I3LJxkIYyEyRt7RKplsVh3lPTClA94DmGCeR6WfLao5cvOWGRpnI
	 pV+QFl5Q6CzpKdGwjirtQpqf51mqiggZE/AsKVY+jaYRKrXdM2Ef0azaBTPtr1oQV
	 Mv3Ea+c2EmYEH40X4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1rC6O50EJF-00zso0; Wed, 03
 Jan 2024 08:57:16 +0100
Message-ID: <8175d102-e1ba-4956-a54a-e734f4d99ecf@web.de>
Date: Wed, 3 Jan 2024 08:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/chrome: cros_ec_i2c: Less function calls in
 cros_ec_cmd_xfer_i2c() after error detection
To: Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, LKML <linux-kernel@vger.kernel.org>
References: <5db36d2b-afe0-4027-b22e-ded163a409be@web.de>
 <ZZTVtOumDlR4iZPa@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZTVtOumDlR4iZPa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BddBvBaGpdCIVj3hrd6z5dcnD233fEmCoAnbYNSrZOvfMyDxz3S
 D+21kkjr3CBDvfqRdT6yJXO/gOotBjwN+UWbL14ktUy3JzZ1YHJVGjnYhi6Orncx6IiPQQg
 qGksaB647yILRFqYQazXMWNsAurh7ybwWLIRuKuz7ySLxlunbhCMMndE1eMhrMNekmyPOZ+
 La0JTTiVV/2FJGYeQXLKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2PZBKHXO7tQ=;mPse9iXVcB25Amlj3jCFLbd6PCr
 3+RyVUq21pRAsNcBGB20v2CoZvekjt1xaGQOs1SM21rGNpBilfHpmVy1KqqoHQp7K0PZ5+nAV
 Fj3JH6wwXi1iSxerUtCpOKonQ1EUXvSfuvgYkU7+rRyxkHLvdr8nM6bO9HYfKn26ekhfMphyn
 ezGTDKRxm/nEHJ5WJ/n+JPirRnolfnJrVWgGS/WyzBz4vHmyvi99y+aq6x5gZKFYVNDLuLKL5
 g6gdqL8fDSAqYEWs/9TTE6LN2mbi+JpU5HanKr93sEgMT6si5YAZds5BhxyLJ0BrVL/t8gC9r
 5MO0aBddJ3z5IdL6kyCTl64Pp6XaA+AiLiWXMKoT56XCz/goLjyMpiYDct1FVQ4wlB7rrsJkF
 lW0KtLE/bHvakDx0tAl6+g2asnJRfz2Yh6pHtoux3hPwX00Q4HxbNhnWzt0UEurKTmY+DIQJi
 nERo3+biWBqT/iG+J/lqTcArQxnDUYWmLak+8BfrmPSndVz8sjLFUnymchMxwSrHkMfaxDHfN
 HM/QYfX0BuQtlu1EW/3zY6zHgVMqFA2lEVuaE55sjJlXyimiBKb+l9xPM3CAHcJYeVeDNf2jO
 KHuEujSkSSsb8a0X+r3cfQyToqlfb3WiyP65dUfmcssjbZoTKvlw1DHAVKZVDIhitELHca+Ge
 DWgTWA32rqRZjvUiuWOj+LwifphrSxrGm+jqQv2aTICC3DdeJalCS9Tg/V3j8M0BYAhUBSUK7
 YZfsJn1X0Au0zZAaMQZZ435c69GR45hxngmlfNqQgbZ2a1f7vaYvbK+ThpTOyTBJJfCMmdKRj
 ddFKSTVLn20kSdbrZz55y0yuM/egbD8ps7mZovBzDIhRozinuDB8iKFmiYBiqcFc5PCLjJsTX
 T2eW+ZAc07QVPO8f+gKFl4ASQA52z/UFF7nlJ/hRHQp+7utYI6bduxpmb28AA1ZxAgYkAaW1Y
 6sgS+Q==

>> The kfree() function was called in up to two cases by
>> the cros_ec_cmd_xfer_i2c() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>>
>> * Adjust jump targets.
>>
>> * Delete two initialisations which became unnecessary
>>   with this refactoring.
>
> The patch saves few instructions but makes the code less readable a bit.

Do you find advices applicable from another information source
also for this function implementation?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

