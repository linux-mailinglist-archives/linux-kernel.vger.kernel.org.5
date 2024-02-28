Return-Path: <linux-kernel+bounces-85104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98086B075
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DE6B27008
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA614C59D;
	Wed, 28 Feb 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vVU5JbFI"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B816CDBC;
	Wed, 28 Feb 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127432; cv=none; b=Gn84rqy6ZNDLYnS44YkBUUK56FoLc/foVCvZIVDVLk4jHxSc3fzOtTKZVSMEP/296JQn5SiJHeMZaJnChbw8fhpFvFCbs0KrRF+dJLu2bBhVgi8Fhqke1gli/Dc2jPHt9DUDvc3LRvM93cWIY58d6+xQVB2VFxbgdj04S2A/ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127432; c=relaxed/simple;
	bh=ddrGq1PYFEZRFjXjELgtDdkhdZ0Hcl1sDKmCR90e5sU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OhtRn9l4w9NrGzM/LvmOiDTItynLCa2/qZV6CA6iL/cuI4GKwzT1v7Gdod0Ny0cQnj9aG67AXBSEuzSI1hnMzV0NVBdGAto0P8TG0n5wS6pJDwsqUaljbpCmtIZiX8CoDYKunoarT8JGKBADzgBewVLYHnrTN8VDVba5GBMPE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vVU5JbFI; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3D22D1200C3;
	Wed, 28 Feb 2024 16:37:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3D22D1200C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709127423;
	bh=lJqOIM7OsyE8lty1WXQViweyrfNmBhB/Fjd3i8JuK+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=vVU5JbFIqdv/2Ml9TpFG8JCqWbaAoZ5OH2ikRwkgAVzDwyGFulSNjo+LUwOxt66PL
	 SFsYgdVb/xYyDX826cAXBPEKCHxmXHkAz9fEJx0ok5dwMJbry+Pyi/GmR4s7Zexi1t
	 khVPSL1jcxFTwA3pQDfASaFVm2UoyfAjVT3mGnOylPsC+6EaJzoWPEvU1SxlAKVW8s
	 Vhzsq+j58GTFM6HsC/H4NzeqxjWj1ZOsFgnPs2TaoNIYFdcLVQ9SblsSW6N/brX8T0
	 zPGxG8pFAfdjoOYRfqkaWRhAFNb7oOJ3ocmApA64mXxhSleTdQQVz0F7amSc9Ev/9z
	 X5GmhrVWe7ocQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 28 Feb 2024 16:37:03 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 16:37:02 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with mapi id
 15.02.1118.040; Wed, 28 Feb 2024 16:37:02 +0300
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
Thread-Index: AQHaXbqRFptCyAwKyUyy1Cn5x5FmZLEHrLEAgANeQYCABgkagIAOlJgA
Date: Wed, 28 Feb 2024 13:37:02 +0000
Message-ID: <20240228133656.24bic6djmjvkill7@cab-wsm-0029881>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <ZcsYaPIUrBSg8iXu@Red>
 <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>
 <ZdL713ae1swwTU_B@Red>
In-Reply-To: <ZdL713ae1swwTU_B@Red>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E91E88FC744FBA45BBD1A9B1BC1C41E0@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183823 [Feb 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, gist.github.com:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/28 10:18:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/28 12:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/28 11:31:00 #23869932
X-KSMG-AntiVirus-Status: Clean, skipped

Hello,

On Mon, Feb 19, 2024 at 07:57:27AM +0100, Corentin Labbe wrote:
> Le Thu, Feb 15, 2024 at 10:47:24AM +0000, Alexey Romanov a 'ecrit :
> > On Tue, Feb 13, 2024 at 08:21:12AM +0100, Corentin Labbe wrote:
> > > Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a 'ecrit :
> > > > Hello!
> > > >=20
> > > > This patchset expand the funcionality of the Amlogic
> > > > crypto driver by adding support for more SoC families:
> > > > AXG, G12A, G12B, SM1, A1, S4.
> > > >=20
> > > > Also specify and enable crypto node in device tree
> > > > for reference Amlogic devices.
> > > >=20
> > > > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > > > custom tests [1] and tcrypt module.
> > > >=20
> > > > ---
> > > >=20
> > >=20
> > > added patchs up to  "drivers: crypto: meson: process more than MAXDES=
CS descriptors"
> >=20
> > Including this patch or not?
>=20
> The crash start with "drivers: crypto: meson: move algs definition and ci=
pher API to cipher.c"

Unfortunately I was unable to reproduce this. I use Khadas Vim1 board
and my custom tests (https://gist.github.com/mRrvz/3fb8943a7487ab7b943ec140=
706995e7).
Tried both build as module and built-in.

Can you, please, give more information? Maybe your test cases?

--=20
Thank you,
Alexey=

