Return-Path: <linux-kernel+bounces-23297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277D82AAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E8C285645
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75C125CC;
	Thu, 11 Jan 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="GLTzNfYQ"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8A10979;
	Thu, 11 Jan 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2B4FD100020;
	Thu, 11 Jan 2024 12:18:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2B4FD100020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704964727;
	bh=UXndM8p/4aKoblfGXlaKMeR9wEisIhlgDyx4qfEBvak=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=GLTzNfYQ9ryiP6Mh7Gm2l/CwRbEJ+cggSlPGF1EF9tbflb6MhChmbKv7Kmk5Y1PJ2
	 y9+fG+xiBQpPWDayASYdF29elnqE6dZfwfyxdXg6hvg+tNRRhZPhYqTo6rYyMLPgLU
	 5GWOavcYIJnaVmgKBsP5sLkTVkJrfzb0xLKFtho7kO4Y9BH8gpOkITfiHd/fCtT7Np
	 lo0ad2Rhu2g95lO2bccLTdWQtxPhScGWnK/dXFTjLBGbArP/q9p5IZfaLp30cnDCXK
	 SX6YBADZKWZStYqsYTKj7jtzOKO266NtdznPyVm6iVrhiigMwP4BEemS8IEX4sshEv
	 xB/0cVt9TDpvw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Jan 2024 12:18:46 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 12:18:45 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with mapi id
 15.02.1118.040; Thu, 11 Jan 2024 12:18:45 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
CC: "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"artin.blumenstingl@googlemail.com" <artin.blumenstingl@googlemail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 00/24] Support more Amlogic SoC families in crypto
 driver
Thread-Topic: [PATCH v1 00/24] Support more Amlogic SoC families in crypto
 driver
Thread-Index: AQHaRAFT58y12An6Uk+iikjI6uDH27DTV/OAgADMFAA=
Date: Thu, 11 Jan 2024 09:18:45 +0000
Message-ID: <20240111091840.7fe4lqx225rdlwly@cab-wsm-0029881>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <ZZ8HP7dJgVaZLMw5@Red>
In-Reply-To: <ZZ8HP7dJgVaZLMw5@Red>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A7CA03D58C39E4DBA767BD5D753EAA4@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182549 [Jan 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/11 07:45:00 #23086920
X-KSMG-AntiVirus-Status: Clean, skipped

Hello!

On Wed, Jan 10, 2024 at 10:08:15PM +0100, Corentin Labbe wrote:
> Le Wed, Jan 10, 2024 at 11:11:16PM +0300, Alexey Romanov a 'ecrit :
> > Hello!
> >=20
> > This patchset expand the funcionality of the Amlogic
> > crypto driver by adding support for more SoC families:=20
> > AXG, G12A, G12B, SM1, A1, S4.
> >=20
> > Also specify and enable crypto node in device tree
> > for reference Amlogic devices.
> >=20
> > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > custom tests and trcypt module.
>=20
> Hello
>=20
> Thanks for your patch series.
> Unfortunatly, I fail to apply it for testing on top of linux-next.
> On top of which tree did you have tested ?

We use 6.5-rc3.

> According to patch 01, you used a tree based before "crypto: amlogic - Us=
e new crypto_engine_op interface" so too old.

Will rebase over linux-next in v2.

>=20
> Regards

--=20
Thank you,
Alexey=

