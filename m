Return-Path: <linux-kernel+bounces-142232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFA8A2949
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA799B222B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEED5102B;
	Fri, 12 Apr 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="C8YBflIp"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3D50A62;
	Fri, 12 Apr 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910351; cv=none; b=H+X+Se8eIf8pDKqbL5a4NwpVKH/pc4D6yDFYOLWkm64t4boEg7FSQ8UppEGoYRYdbPTt67rVMAjfX/iHMWoWioViuLTEuoMmiwYUnJZUL5AFzhIwgEWGsSNlnHqYnLfcHTrpIBMDMZ3uL6YIB3KDBKC2faf5hknK8GWIaF9mGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910351; c=relaxed/simple;
	bh=AgQMwhLM2SQJL/DxUrA6t4vddU8OTk+2j0IqX/shhbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZhr9uqlwXhDIx6G+hgZAyjOw6W3pRI9RjROcDNSuJi2cheCk/jmZ01yYIj4kPQfinDx8QzyfQg0zZ9wL5gOrIdurTjqSpH0nWaaDw8paZ61CrqaqwCc2I9prhuzJbxLou4vALE3KNlVPFqjuRJ2pOuRX1+C9n9MXmD3mFf355c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=C8YBflIp; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BA55C120006;
	Fri, 12 Apr 2024 11:25:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BA55C120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712910346;
	bh=AgQMwhLM2SQJL/DxUrA6t4vddU8OTk+2j0IqX/shhbU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=C8YBflIpipAZ1mefV1MD4x/XIVT6rsTSMbfjhioBjJDidSL6leypyb9BeXPtgCcCm
	 XPU3EBax6cIFufbBJy4gPC59D8uvydAABfj8CdDcf7YVqA7KTSVE94RmUD/v77c8NV
	 1HTkVFrhRvpTH9nBZBkdCyVauNLvXopCCWJSuavTr0P3Xhw3foVhPFW2LAzYAiqJHZ
	 rkpzr2HijTQdszf39V9GZariGuUkxTe1TUr2wiIQatAHsUv1BnmcRK5LGzLDTVZ3py
	 FhTahrgp42fUF2ac97CMhCGCpMgbEvSAIZkTr7rfAVz5VFWrDrQW1ttWNH3SeHXfk7
	 C6m2KpSMAiBng==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 12 Apr 2024 11:25:46 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Apr 2024 11:25:46 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with mapi id
 15.02.1118.040; Fri, 12 Apr 2024 11:25:46 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v7 00/23] Support more Amlogic SoC families in crypto
 driver
Thread-Topic: [PATCH v7 00/23] Support more Amlogic SoC families in crypto
 driver
Thread-Index: AQHajBWUrVGAoz0gN0yHbEf56dYdJrFjvtOAgABbAICAAAC3AIAAAQKA
Date: Fri, 12 Apr 2024 08:25:46 +0000
Message-ID: <20240412082541.zxlbnigfs733q4sf@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
 <ZhiiPVckOYH9dFQ/@gondor.apana.org.au>
 <20240412081931.3s2fw6hds3hh5cwg@cab-wsm-0029881.sigma.sbrf.ru>
 <ZhjvLMcMXKNmlCZ7@gondor.apana.org.au>
In-Reply-To: <ZhjvLMcMXKNmlCZ7@gondor.apana.org.au>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DE82C9FF3EB794695833D14A6D82635@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184683 [Apr 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;gondor.apana.org.au:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/12 08:01:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/12 08:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/12 02:59:00 #24750120
X-KSMG-AntiVirus-Status: Clean, skipped

On Fri, Apr 12, 2024 at 04:22:04PM +0800, Herbert Xu wrote:
> On Fri, Apr 12, 2024 at 08:19:36AM +0000, Alexey Romanov wrote:
> >
> > Old Amlogic Soc's for crypto HW used a BLKMV engine, which required
> > a clk input and a second interrupt line. New SoC's uses DMA engine
> > and don't need this.
> >=20
> > I spoke with vendor, and they confirmed that AXG, G12A, G12B, SM1,
> > A1, S4 and GXL is using DMA engine and crypto HW is not connected
> > to clk / second interrupt line.
>=20
> Sorry I'm just asking you to ensure that you've tested the whole
> patch-series with CRYPTO_MANAGER_EXTRA_TESTS enabled and there are
> no errors reported.

Oh, yep, I will test with this option enabled soon.

>=20
> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=20
Thank you,
Alexey=

