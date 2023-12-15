Return-Path: <linux-kernel+bounces-515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE35814254
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2D71C20DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C64D2F1;
	Fri, 15 Dec 2023 07:25:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46D16418;
	Fri, 15 Dec 2023 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id D06EC7FE2;
	Fri, 15 Dec 2023 15:25:36 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 15:25:36 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 15:25:32 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: <krzysztof.kozlowski@linaro.org>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<jisheng.teoh@starfivetech.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<samin.guo@starfivetech.com>, <wim@linux-watchdog.org>,
	<xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Fri, 15 Dec 2023 15:25:08 +0800
Message-ID: <20231215072508.3498476-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <40b5d1a8-37d2-4c68-8d16-33c92c3e5716@linaro.org>
References: <40b5d1a8-37d2-4c68-8d16-33c92c3e5716@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 08:39:46 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/12/2023 04:30, Ji Sheng Teoh wrote:
> > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > watchdog.
> > Since JH8100 watchdog only has 1 reset signal, update binding
> > document to support one reset for "starfive,jh8100-wdt" compatible.
> >=20
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  .../watchdog/starfive,jh7100-wdt.yaml         | 48
> > ++++++++++++++++--- 1 file changed, 42 insertions(+), 6 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > index 68f3f6fd08a6..79082c5f9971 100644 ---
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > +++
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > @@ -19,14 +19,17 @@ description: isn't cleared, the watchdog will
> > reset the system unless the watchdog reset is disabled. -allOf:
> > -  - $ref: watchdog.yaml#
> > -
> >  properties:
> >    compatible:
> > -    enum:
> > -      - starfive,jh7100-wdt
> > -      - starfive,jh7110-wdt
> > +    oneOf:
> > +      - items: =20
>=20
> Drop items, it wasn't here in the first place.

Ok, will drop.
>=20
> > +          - enum:
> > +              - starfive,jh7100-wdt
> > +              - starfive,jh7110-wdt
> > +      - items:
> > +          - enum:
> > +              - starfive,jh8100-wdt
> > +          - const: starfive,jh7110-wdt
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -45,10 +48,33 @@ properties:
> >        - const: core
> > =20
> >    resets:
> > +    minItems: 1
> >      items:
> >        - description: APB reset
> >        - description: Core reset =20
>=20
> This is not valid for jh8100. Move it to else: part. Here maxItems: 2.
>
Sure, will replace with maxItems.
=20
> > =20
> > +allOf: =20
>=20
> allOf goes after required:, see example-schema
>=20
Ok, will move it after required.

> > +  - $ref: watchdog.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - starfive,jh8100-wdt
> > +    then:
> > +      properties:
> > +        resets:
> > +          description: |
> > +            Must contain Core reset entry.
> > +          maxItems: 1 =20
>=20
> Instead of both, items: with description.
>=20
Sure, will use items instead.

> > +    else:
> > +      properties:
> > +        resets:
> > +          description: |
> > +            Must contain APB reset and Core reset entry.
> > +          minItems: 2
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -69,3 +95,13 @@ examples:
> >          resets =3D <&rst 99>,
> >                   <&rst 100>;
> >      };
> > +
> > +  - |
> > +    watchdog@12270000 {
> > +        compatible =3D "starfive,jh8100-wdt", "starfive,jh7110-wdt";
> > +        reg =3D <0x12270000 0x10000>;
> > +        clocks =3D <&clk 78>,
> > +                 <&clk 79>; =20
>=20
> No need for new example with difference in one property.

Ok, will drop the new example. Thanks
>=20
> Best regards,
> Krzysztof
>=20


