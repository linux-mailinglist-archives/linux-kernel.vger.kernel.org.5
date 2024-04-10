Return-Path: <linux-kernel+bounces-138350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1789F009
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E151C2286A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C98159598;
	Wed, 10 Apr 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="CS/UYqwL"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC02159583;
	Wed, 10 Apr 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745563; cv=none; b=LSNSYFi4rbhMA5XLrlf+9N+yQF5jQAfiByYrE0ys1eMTSLV3MRe9ImkhV1psGXz+eSyLSokMroJxclJsu9XVD5+hbD+N4WAYOrCDZBbCWA50s7G/SCFI96E3uQKghvzSH9lSeSmwCahSwAo4/rrkqt1E+J/atuPaswPQIqJ4SaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745563; c=relaxed/simple;
	bh=PCDujvrJmHAKcuWNCqvSMKsnICM+G/o9ZW/if72dDBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5VfIrAV+7kG3jPZWCXkdyd1r5pUIB+yuqM7jZ6qhy6/eGqGhwi0WpAvZd7ZEYDg7xRG0JTTDSaCzvYZCzb4404XQfTfScdPkFZzVmS3GEc6qXJyNZOPJ0OLJvd3bo3gzgASUJO49tYqxa/KyF/UO9Mc4bLX4kHQxNRAVbcJsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=CS/UYqwL; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7C7EC120040;
	Wed, 10 Apr 2024 13:39:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7C7EC120040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712745555;
	bh=VgW1qDMO8PWM/O8EZhSuhbAcY1BZE0vdgsOCKDWUWxQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=CS/UYqwL+D63xVmLoxh+smpQLDcRGs8BiucMk4L2yDZKz7mCHGHHbBvxTF3Mq3nq7
	 Uynp159IUfh/sddTkWqy5uwBv7M4T5zum2cpoHZyavdMibJSilafPlIWtgzaXpjAX6
	 piXBMbO65U6MtMoe9vcHgfhaqgyiBv/+v2sEssS0cS0CbM2wsEzVaBtO5rr73+95UV
	 Iw45CJ+MhmfpNnH9jHRXtmxfw13rdnm5xisGn7pooFNNPqf7TG5oqRNZz3I3GtSp03
	 V00HmbW19igOToVHyPNvSlAIJWBpR0ZB81HyfBS/jB9ZQcaqrAbQ1lkuStlOvcBOR2
	 Q4+z0M+u6v//g==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru [172.24.196.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 13:39:15 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 13:39:14 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with mapi id
 15.02.1118.040; Wed, 10 Apr 2024 13:39:14 +0300
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
Subject: Re: [PATCH v6 11/23] drivers: crypto: meson: introduce hasher
Thread-Topic: [PATCH v6 11/23] drivers: crypto: meson: introduce hasher
Thread-Index: AQHaf5Lb1cJ4FzSnKk+fpINGfswrY7FZG1UAgAgZ3AA=
Date: Wed, 10 Apr 2024 10:39:14 +0000
Message-ID: <20240410103908.suw6x3pywk73nftp@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-12-avromanov@salutedevices.com>
 <Zg+gnrO/wX5S+zlw@gondor.apana.org.au>
In-Reply-To: <Zg+gnrO/wX5S+zlw@gondor.apana.org.au>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C48013566364C04996A07E062F8DF7FC@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184649 [Apr 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;gondor.apana.org.au:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/10 07:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/10 07:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/10 06:59:00 #24735327
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Herbert,

On Fri, Apr 05, 2024 at 02:56:30PM +0800, Herbert Xu wrote:
> On Tue, Mar 26, 2024 at 06:32:07PM +0300, Alexey Romanov wrote:
> > Introduce support for SHA1/SHA224/SHA256 hash algos.
> > Tested via tcrypt and custom tests.
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  drivers/crypto/amlogic/Makefile             |   2 +-
> >  drivers/crypto/amlogic/amlogic-gxl-core.c   |  25 +-
> >  drivers/crypto/amlogic/amlogic-gxl-hasher.c | 460 ++++++++++++++++++++
> >  drivers/crypto/amlogic/amlogic-gxl.h        |  51 +++
> >  4 files changed, 536 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
>=20
> Where are the import/export functions?

Sorry, I miss understand you. What do you mean by "import/epxort
functions"?

>=20
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=20
Thank you,
Alexey=

