Return-Path: <linux-kernel+bounces-23326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AB82AB17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE1C1F24335
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9E1172D;
	Thu, 11 Jan 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hv+QwaFh"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AD15AE4;
	Thu, 11 Jan 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6FCAB12001A;
	Thu, 11 Jan 2024 12:33:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6FCAB12001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704965624;
	bh=g2h5bYKkZTz9VczCxo+jetZF5Hf3q3K6NtzYos+6www=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=hv+QwaFhRIfcXBnzqCt86ytpeqAe3IB3Zih7TDeTVwsDXnJ5lvTAUWu1RMrysK102
	 EvpbRu63DmoC7FyMEdhATPCbKCejw8uBEnr/+8aqgyTFG93TyZn4cbXSl+dEvJIPOM
	 UsZwjGAOV/8lheFvK7phAmZgQWKVL0FWHX7ymy7HRZkuARDEMLNeDomBukU4wfbx+p
	 J1RgwKkE66nM3NNoiO2PNlCXXE3lIQIYmjnBrbJ01FaxO6KawPVF5/pnGkg2h0hIl4
	 m11Mh3WUSM2dcPpqc+LhjKEe2o8h41dDdW1IUywxPE54GR8xflW+A76XrqrdtPSY4O
	 PUYF4a0PQQlPQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Jan 2024 12:33:44 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 12:33:43 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with mapi id
 15.02.1118.040; Thu, 11 Jan 2024 12:33:43 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
CC: "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "clabbe@baylibre.com"
	<clabbe@baylibre.com>, "herbert@gondor.apana.org.au"
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
Thread-Index: AQHaRAFT58y12An6Uk+iikjI6uDH27DUE2iAgAAUzQA=
Date: Thu, 11 Jan 2024 09:33:43 +0000
Message-ID: <20240111093338.la4rdg5jxkpc7hz3@cab-wsm-0029881>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <b2caf65d-4bc8-4e16-b4db-b24006e3dce6@linaro.org>
In-Reply-To: <b2caf65d-4bc8-4e16-b4db-b24006e3dce6@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <526DB4079F018E41B016430D6453B89C@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182551 [Jan 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;gist.github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/01/11 08:51:00
X-KSMG-LinksScanning: Clean, bases: 2024/01/11 08:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/11 07:45:00 #23086920
X-KSMG-AntiVirus-Status: Clean, skipped


Hi Neil,

On Thu, Jan 11, 2024 at 09:19:11AM +0100, neil.armstrong@linaro.org wrote:
> Hi !
>=20
> On 10/01/2024 21:11, Alexey Romanov wrote:
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
> > custom tests and trcypt module.
>=20
> Thanks a lot for the patchset, it's very welcome!
>=20
> Could you provide some procedure used to test and test dumps for all the =
platforms, like `cryptsetup benchmark` or a summary of tcrypt tests output =
?

We use the following kernel module:

https://gist.github.com/mRrvz/8d9277d57abb4d21568725785ec9e939

and don't forget to define reserved memory region in device tree.

>=20
> Thanks,
> Neil
>=20
> >=20
> > Alexey Romanov (17):
> >    drivers: crypto: meson: don't hardcode IRQ count
> >    drivers: crypto: meson: make CLK controller optional
> >    drviers: crypto: meson: add platform data
> >    drivers: crypto: meson: add MMIO helpers
> >    drivers: crypto: meson: move get_engine_number()
> >    drivers: crypto: meson: use fallback for 192-bit keys
> >    drivers: crypto: meson: add support for G12-series
> >    drivers: crypto: meson: add support for AXG-series
> >    dt-bindings: crypto: meson: add new compatibles
> >    arch: arm64: dts: meson: a1: add crypto node
> >    arch: arm64: dts: meson: s4: add crypto node
> >    arch: arm64: dts: meson: g12: add crypto node
> >    arch: arm64: dts: meson: axg: add crypto node
> >    arch: arm64: dts: meson: s4-s805x2-aq222: enable crypto node
> >    arch: arm64: dts: meson: a1-ad401: enable crypto node
> >    arch: arm64: dts: meson: axg-s400: enable crypto node
> >    arch: arm64: dts: meson: g12a-u200: enable crypto node
> >=20
> > Jan Dakinevich (7):
> >    drivers: crypto: meson: drop status field from meson_flow
> >    drivers: crypto: meson: move algs definition and cipher API to
> >      cipher.c
> >    drivers: crypto: meson: cleanup defines
> >    drivers: crypto: meson: process more than MAXDESCS descriptors
> >    drivers: crypto: meson: avoid kzalloc in engine thread
> >    drivers: crypto: meson: introduce hasher
> >    drivers: crypto: meson: add support for AES-CTR
> >=20
> >   .../bindings/crypto/amlogic,gxl-crypto.yaml   |   2 +
> >   .../arm64/boot/dts/amlogic/meson-a1-ad401.dts |   4 +
> >   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   8 +
> >   .../arm64/boot/dts/amlogic/meson-axg-s400.dts |   4 +
> >   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   7 +
> >   .../boot/dts/amlogic/meson-g12-common.dtsi    |   7 +
> >   .../boot/dts/amlogic/meson-g12a-u200.dts      |   4 +
> >   .../dts/amlogic/meson-s4-s805x2-aq222.dts     |   4 +
> >   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   7 +
> >   drivers/crypto/amlogic/Makefile               |   2 +-
> >   drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 591 ++++++++++++-----=
-
> >   drivers/crypto/amlogic/amlogic-gxl-core.c     | 260 ++++----
> >   drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 448 +++++++++++++
> >   drivers/crypto/amlogic/amlogic-gxl.h          | 116 +++-
> >   14 files changed, 1135 insertions(+), 329 deletions(-)
> >   create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
> >=20
>=20

--=20
Thank you,
Alexey=

