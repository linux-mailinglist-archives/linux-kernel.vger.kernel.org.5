Return-Path: <linux-kernel+bounces-66713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB485608E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F73A1F2399E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959A12E1C9;
	Thu, 15 Feb 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PTvYSRzc"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5F133422;
	Thu, 15 Feb 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994057; cv=none; b=ottbys2YdDIGZsjR18wZj2eNgFoFbeQEifbs04Je7ffUbZgL15xZMqdlv+hCEzDHFNXIQyQxRMStWYexFhTiyhZdUk0hMOYT33wR9ZLtNA9DgAo6bd0jXgIzopEcJEosU6GhfDO9pmiFuWl8wSPZV6RG3q3scyacuJ9tRwK0Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994057; c=relaxed/simple;
	bh=RJDAsKe/aBk8AYh4rDTIh54ZmBRzY5mDVvLfCyAvXrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/jpGRjOCb4A4nZXz76qe9QkNGF0keO79GjR8XsxJ/wHYzlGR7A3heoYtiPw4eV6nRWnbzk4HbPRr2gyRSWI+q8BdEklk3ynSQNaxL3cAqbcxBxmnZtNS8BeJkkEfIKwGhuGtBQtGJWdrSq5b5LnaCdj4sG3+qDRPP9b4mih4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PTvYSRzc; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6B7EF120005;
	Thu, 15 Feb 2024 13:47:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6B7EF120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707994045;
	bh=ZMXILtHC08+ORAOMdLV08SaTMzWfQR2g0BN83OzVl4o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=PTvYSRzcm7SkQ4jmbt1M7PmtlwMEnEvbr3WZmXhSFIcOFzc9cdquy/XKZkT5huX2u
	 0AZXiOZOKzSsxdfYtEuxuMPmtsjkk3ZKiGom90RpxVZeu/6MD5eTQAZRtIKOnftDcy
	 CWhPun885cAV33ZVNJurwC4znQqBfkk2r6qgmUb8Wm0rPu0rKlUsWPdbEt5nxSgw5q
	 7j/JRhaqbHTm7ud9Mm3ggCE3NGiRTWXBuzEI4w8JjHjb/mr5JpWCjhQKVglj+v7Dw2
	 yzWuiweq/lABslXYAN+1gr9/1wuUj6qvaOqTbgrjZujD6K2+w4cHGFx2eDqHZAOz//
	 cNma5geBk27bQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 13:47:25 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 13:47:24 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with mapi id
 15.02.1118.040; Thu, 15 Feb 2024 13:47:24 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
CC: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Thread-Topic: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Thread-Index: AQHaXbqRFptCyAwKyUyy1Cn5x5FmZLEHrLEAgANeQYA=
Date: Thu, 15 Feb 2024 10:47:24 +0000
Message-ID: <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <ZcsYaPIUrBSg8iXu@Red>
In-Reply-To: <ZcsYaPIUrBSg8iXu@Red>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02AD52C50B92B74A88D1647594C86269@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183458 [Feb 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/15 04:37:00 #23614209
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Feb 13, 2024 at 08:21:12AM +0100, Corentin Labbe wrote:
> Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a 'ecrit :
> > Hello!
> >=20
> > This patchset expand the funcionality of the Amlogic
> > crypto driver by adding support for more SoC families:
> > AXG, G12A, G12B, SM1, A1, S4.
> >=20
> > Also specify and enable crypto node in device tree
> > for reference Amlogic devices.
> >=20
> > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > custom tests [1] and tcrypt module.
> >=20
> > ---
> >=20
>=20
> added patchs up to  "drivers: crypto: meson: process more than MAXDESCS d=
escriptors"

Including this patch or not?

--=20
Thank you,
Alexey=

