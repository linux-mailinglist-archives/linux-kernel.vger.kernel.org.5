Return-Path: <linux-kernel+bounces-124428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65E891779
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA3286959
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C06A032;
	Fri, 29 Mar 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="WKjL+cp6"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B79364BA;
	Fri, 29 Mar 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710884; cv=none; b=tL+dh3/GGXwlSs/Wle6konSi1KnL2w3eEEQ301MPBf8xzs7uxSB5RIlVJ/ZCA2Bb/XXMcnvEQgkhi/wgeH3HdEI/mvfKvTaI9/7MD1c3yR3SDStyoK67R5ACkveZH6SK9YiW9WxPhLwE01MlO4bQuFoQMNQ0S//FNPkEn4guixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710884; c=relaxed/simple;
	bh=z6p08nGmnn5rR1/CMeOGPwFv//6ITv/V2s6q+dQt9Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pnKszxWWNRIggb4W1Yt7d5zeXk/rF0VAVcziCHiAdReG2hr5HKZVgWslehhvZ55PXckrrz3DlZZYeb1t+olGDAhaML+xoBQu7wRU3BW5WKu0LS18dECjMK49dJHAikcSqoVa+ItGpN2b0oGXzUqCb4ISuJ1W1tgqANxO+mgPKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=WKjL+cp6; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A777510001B;
	Fri, 29 Mar 2024 14:14:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A777510001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711710870;
	bh=lFNNpWUo5GpWFV+9AKZ9Cfm8NfVqj08JFZwNdFWkc2I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=WKjL+cp6zqFDN/D6whRQUAVUpp/FDIit+CaMjN0kz1d5zAIPPdxXNyS1P2mCOKAO+
	 NXgvBjHQ+S6JtVkha3w9clLOQaN0BdzYV1iJevPPQrECJ4vo91NQ9mawoNS95juTAY
	 1xnxZf/yb2w56JZNiExZrDNMqk8jYs+iVoSwpq0/0EDY6M79zOPmW47e5Hy8HpU6Jj
	 As6WSS1vmMGNqX/MiF0nwqRYA+ur/8SDn4hxh8HCrUFJjpjlGD8Rg+tcVocZVqoXZ4
	 MDs8Tvc1ePQPgd5h8Qm1pPjEyVKJL5d7YnB0MjKZDVlEI0+QUmp/GCdKcErFqR+eXz
	 o+2Le3qA6CscA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 14:14:30 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 14:14:30 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with mapi id
 15.02.1118.040; Fri, 29 Mar 2024 14:14:30 +0300
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
Subject: Re: [PATCH v6 17/23] dt-bindings: crypto: meson: remove clk and
 second interrupt line for GXL
Thread-Topic: [PATCH v6 17/23] dt-bindings: crypto: meson: remove clk and
 second interrupt line for GXL
Thread-Index: AQHaf5LgFGLoYbivnUaU5PLAkeGrbrFKIBaAgARC/AA=
Date: Fri, 29 Mar 2024 11:14:29 +0000
Message-ID: <20240329111424.i2zp2coznqpnibk4@cab-wsm-0029881>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-18-avromanov@salutedevices.com>
 <20240326-obscurity-angriness-d7bb48bc9eaa@spud>
In-Reply-To: <20240326-obscurity-angriness-d7bb48bc9eaa@spud>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEBAC2ABE34F8A4AB4996A1D926E8A4F@sberdevices.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 06:35:00 #24505095
X-KSMG-AntiVirus-Status: Clean, skipped

Hi Conor,

On Tue, Mar 26, 2024 at 06:09:37PM +0000, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 06:32:13PM +0300, Alexey Romanov wrote:
> > GXL crypto IP uses DMA engine, which doesn't require clk input
> > and second interrupt line.
> >=20
> > Fixes: c4a0457eb858 ("ARM64: dts: amlogic: adds crypto hardware node")
>=20
> How does this fix a commit that only modifies a dts? The commit cited
> here should be a dt-bindings commit.

Yep, my bad. Will fix it in next series.

>=20
> However, your commit message says "require" but you do more than remove
> these as required, you remove them entirely. What am I missing?

Crypto HW isn't connected to clk / 2nd interrput line, so we must remove
them from dt. I will reformulate commit message.

>=20
> Thanks,
> Conor.
>=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  .../bindings/crypto/amlogic,gxl-crypto.yaml         | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypt=
o.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > index 948e11ebe4ee..d3af7b4d5f39 100644
> > --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> > @@ -20,20 +20,11 @@ properties:
> >    interrupts:
> >      items:
> >        - description: Interrupt for flow 0
> > -      - description: Interrupt for flow 1
> > -
> > -  clocks:
> > -    maxItems: 1
> > -
> > -  clock-names:
> > -    const: blkmv
> > =20
> >  required:
> >    - compatible
> >    - reg
> >    - interrupts
> > -  - clocks
> > -  - clock-names
> > =20
> >  additionalProperties: false
> > =20
> > @@ -46,7 +37,5 @@ examples:
> >      crypto: crypto-engine@c883e000 {
> >          compatible =3D "amlogic,gxl-crypto";
> >          reg =3D <0xc883e000 0x36>;
> > -        interrupts =3D <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>, <GIC_SPI 18=
9 IRQ_TYPE_EDGE_RISING>;
> > -        clocks =3D <&clkc CLKID_BLKMV>;
> > -        clock-names =3D "blkmv";
> > +        interrupts =3D <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
> >      };
> > --=20
> > 2.34.1
> >=20



--=20
Thank you,
Alexey=

