Return-Path: <linux-kernel+bounces-142223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59298A291D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69261C21C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9050277;
	Fri, 12 Apr 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HIj6HPsX"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B344F200;
	Fri, 12 Apr 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909989; cv=none; b=oSYak1+veenmv3EgkTeQu8GDqUGC832Wu/5rInTGBfXzoCKMoCpUcVB+BfEBAAj1j8yv4LFVNiSdaE9pGJyWSYRazTPhCImby7u5sn4Ly49T55B2mVRwmp9dJ+W5ejFLEhfCQqhI5DjAMfx92SDcYCxBsTCvDxqDOYow03dQYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909989; c=relaxed/simple;
	bh=RU+HBnKS5Cxr82FY1Pa6+30o7iTPotD1YAU45NEfneY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T3XS51jf1cY56U5LfbS6FjJgBf1iQWBWhOLwOVtE5kFUSneUo8kqn9mQD5eonUH8iDVr8m10B6ZlCtC666q4lmO2RgJF9z6ygHAdPqhkpQFaDNHQiZNGayELlyi0x4aRG4+49FEarnUJDAAWKMcDJxSfCC8DBQ3HExHPYJ88tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HIj6HPsX; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8477F120063;
	Fri, 12 Apr 2024 11:19:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8477F120063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712909977;
	bh=eTYUT+jxyV/dDyYagaIyHdQgsiA4EtrB+9ZjvPOjkEo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=HIj6HPsXkWVWaqlbjAH5FASpHggYFeqzVSEYJmS7bEALspHmVj1O4C9P1J/yVzbGp
	 XRk9F5+4yM17L6CyrliI1lxXcKgZ9mF72uOAsZsCRXrvefhesBpgJoaYJP6knI2hvB
	 JOR4iSFCrHWt/tP84RmKNsjMTG9C2lVsunDB3oGFCZp0yQjqw8QcyMmETNjsxAFFgq
	 4S6Bb0kK+1kSICpJeFjFGfHF4zCkOZxWe5ketZK2rRU8GFBXHfvlMRS3i0xI8sL0S7
	 te06ztx6nJlc3u11rABf19OklUjGnTDYptiU+CxnQWIGmF23vBW1iAAVMyTxERPMQi
	 ljZ/1zftTikTQ==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru [172.24.196.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 12 Apr 2024 11:19:37 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 11:19:36 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with mapi id
 15.02.1118.040; Fri, 12 Apr 2024 11:19:36 +0300
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
Thread-Index: AQHajBWUrVGAoz0gN0yHbEf56dYdJrFjvtOAgABbAIA=
Date: Fri, 12 Apr 2024 08:19:36 +0000
Message-ID: <20240412081931.3s2fw6hds3hh5cwg@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
 <ZhiiPVckOYH9dFQ/@gondor.apana.org.au>
In-Reply-To: <ZhiiPVckOYH9dFQ/@gondor.apana.org.au>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8A89F4D4AFB8C4ABC5358E4B1C8666A@sberdevices.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;gondor.apana.org.au:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/12 04:30:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/12 04:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/12 02:59:00 #24750120
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Herbert,

On Fri, Apr 12, 2024 at 10:53:49AM +0800, Herbert Xu wrote:
> On Thu, Apr 11, 2024 at 04:38:09PM +0300, Alexey Romanov wrote:
> >
> > Changes V6 -> V7 [9]:
> >=20
> > - Fix dt-schema: power domain now required only for A1.
> > - Use crypto_skcipher_ctx_dma() helper for cipher instead of
> >   ____cacheline_aligned.
> > - Add import/export functions for hasher.
> > - Fix commit message for patch 17, acorrding to discussion [10].
>=20
> Please ensure that this passes the self-tests with extra fuzzing
> enabled.

Old Amlogic Soc's for crypto HW used a BLKMV engine, which required
a clk input and a second interrupt line. New SoC's uses DMA engine
and don't need this.

I spoke with vendor, and they confirmed that AXG, G12A, G12B, SM1,
A1, S4 and GXL is using DMA engine and crypto HW is not connected
to clk / second interrupt line.

>=20
> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=20
Thank you,
Alexey=

