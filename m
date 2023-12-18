Return-Path: <linux-kernel+bounces-3833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329F817383
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23EA3B21E03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1F1D14B;
	Mon, 18 Dec 2023 14:27:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F129EF9;
	Mon, 18 Dec 2023 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6CC4E820D;
	Mon, 18 Dec 2023 22:27:25 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 22:27:25 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 22:27:20 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: <krzysztof.kozlowski@linaro.org>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<jisheng.teoh@starfivetech.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<samin.guo@starfivetech.com>, <wim@linux-watchdog.org>,
	<xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Mon, 18 Dec 2023 22:27:11 +0800
Message-ID: <20231218142711.961120-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cb16753d-ebec-4342-bed7-ee9a895c8547@linaro.org>
References: <cb16753d-ebec-4342-bed7-ee9a895c8547@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 09:41:07 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/12/2023 02:48, Ji Sheng Teoh wrote:
> > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > watchdog.
> > Since JH8100 watchdog only has 1 reset signal, update binding
> > document to support one reset for "starfive,jh8100-wdt" compatible.
> >=20
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  .../watchdog/starfive,jh7100-wdt.yaml         | 29
> > +++++++++++++++---- 1 file changed, 23 insertions(+), 6 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > index 68f3f6fd08a6..ab077f64a83e 100644 ---
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > +++
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > @@ -19,14 +19,12 @@ description: isn't cleared, the watchdog will
> > reset the system unless the watchdog reset is disabled. -allOf:
> > -  - $ref: watchdog.yaml#
> > -
> >  properties:
> >    compatible:
> >      enum:
> >        - starfive,jh7100-wdt
> >        - starfive,jh7110-wdt
> > +      - starfive,jh8100-wdt =20
>=20
> What is happening with this patchset? I asked about one specific
> items. you know - comment is written under specific inline quopte.
> You wrote in changelog "Drop items in compatible field.", but I see
> oneOf gone!

My bad, I've interpreted it wrongly.=20
Will rework the compatible field to this instead:

  compatible:
    oneOf:
      - enum:
          - starfive,jh7100-wdt
          - starfive,jh7110-wdt
      - items:
          - enum:
              - starfive,jh8100-wdt
          - const: starfive,jh7110-wdt


While reworking this, I've noticed reset field with maxItems alone will
cause dt_binding_check to fail with following error:
'watchdog@12270000: resets: [[4294967295, 15]] is too short'
This is fixed by defining minItems and maxItems as follow:

  resets:
    minItems: 1
    maxItems: 2

>=20
> I have real doubts that you ever tested your entire solution with this
> binding. Where is the DTS?
>=20

Currently, the DTS is still in internal and yet to upstream as it depends
on [1].
[1]
https://lore.kernel.org/all/20231201121410.95298-1-jeeheng.sia@starfivete=
ch.com/

> Best regards,
> Krzysztof
>=20

