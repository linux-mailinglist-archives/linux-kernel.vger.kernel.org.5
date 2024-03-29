Return-Path: <linux-kernel+bounces-124431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17B891782
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B36286B33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48C6A329;
	Fri, 29 Mar 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XoBe4fjj"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D845955;
	Fri, 29 Mar 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710977; cv=none; b=igSs4j6QasGmV22Tl/Ti24nm5jZp4yoyE9Nh6BYVCEtnMO2iD9Q/gZUFAEMId3AxFCFBaLaHpsJ/pFTGGcm+e1K6uNufb948+KN62LP4I+dsOLbBG9Yr5tqBmIYMgaY04rmDOhxzgxBS+pe3cPURpKCpKbcdn6mtRWou5JZWz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710977; c=relaxed/simple;
	bh=ArEQSLbqJPcHEMimLOqLCm//D1UQZkpFF11ILRFJx0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjPvCDVTBIOF1Yq5NmIEHkKXCFFqb9D2Nqe+Vcz6HQd3ZPYufLvuC2azx+LxE6WEDZJbv1ZTTVrtIK8CFfep6i3h8oT8CVxcP9MjG1THCzPnLwROdo+nyzBYS7M10rUiMNbecGK3XpiNyQnSz0ziVIxVjcq+3q7GT2RrTq7PmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XoBe4fjj; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7B52E12000B;
	Fri, 29 Mar 2024 14:16:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7B52E12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711710967;
	bh=0ZCNxVRzc7acxv+Ki46VV0opyW+7E4fQeFxNhrog2Nw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=XoBe4fjjyKj7OGt2Lh78NND/SGYknHYe2PQkTZiQEMptuI6WS7LOCeijdV53on78z
	 RXSf+HtquuT+Muv/jCmwHDtsvJ4JzH0OIzTJMrke5/CUL9UmwLDiJ9FHuaMp0nDdYT
	 05yC0Uqln/pm24g9EXFZr46jOOlPHjZ+VqOvCiUGOGooiXNAE2Y9IvB2JFltleZuuW
	 vwD9D47jP8hQEZzcLO33awJ4IYdXl/jfHivwWs/cZJzmq9p7hHPe7neaKCrEUXw5mZ
	 X9Cf1b2XLSIIYNjTWMMIwepHfLYf0N19sJdMPSZX0+pysad2QjsMTwts3uzYTaSbo3
	 TcntZiBlkEZ6Q==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru [172.24.196.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 14:16:07 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 14:16:06 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with mapi id
 15.02.1118.040; Fri, 29 Mar 2024 14:16:06 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH v6 19/23] dt-bindings: crypto: meson: support new SoC's
Thread-Topic: [PATCH v6 19/23] dt-bindings: crypto: meson: support new SoC's
Thread-Index: AQHaf5LiGOSSeLbqDUCDISKI6TxoerFKHrsAgAREyoA=
Date: Fri, 29 Mar 2024 11:16:06 +0000
Message-ID: <20240329111601.po33wqdaaqpc54mo@cab-wsm-0029881>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-20-avromanov@salutedevices.com>
 <20240326-boneless-patrol-b1156a4be70b@spud>
In-Reply-To: <20240326-boneless-patrol-b1156a4be70b@spud>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <313753CD0CABB74EBC47F28A5CA99716@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184489 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 06:35:00 #24505095
X-KSMG-AntiVirus-Status: Clean, skipped

Hello,

On Tue, Mar 26, 2024 at 06:04:46PM +0000, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 06:32:15PM +0300, Alexey Romanov wrote:
> > Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
> >=20
> > 1. Add new compatibles:
> >   - amlogic,g12a-crypto
> >   - amlogic,axg-crypto
> >   - amlogic,a1-crypto
> >   - amlogic,s4-crypto (uses a1-crypto as fallback)
> >=20
> > 2. Add power-domains in schema.
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  .../bindings/crypto/amlogic,gxl-crypto.yaml       | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypt=
o.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > index d3af7b4d5f39..c92edde314aa 100644
> > --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > @@ -11,8 +11,16 @@ maintainers:
> > =20
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: amlogic,gxl-crypto
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amlogic,s4-crypto
> > +          - const: amlogic,a1-crypto
> > +      - enum:
> > +          - amlogic,gxl-crypto
> > +          - amlogic,axg-crypto
> > +          - amlogic,g12a-crypto
> > +          - amlogic,a1-crypto
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -21,6 +29,9 @@ properties:
> >      items:
> >        - description: Interrupt for flow 0
> > =20
> > +  power-domains:
> > +    maxItems: 1
>=20
> Is power-domains valid for the devices that existed prior to your patch?

For existed devices (GXL) power domain doesn't required.

--=20
Thank you,
Alexey=

