Return-Path: <linux-kernel+bounces-25671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81BC82D46A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F882281488
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520654402;
	Mon, 15 Jan 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="C5weg/8+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF34401;
	Mon, 15 Jan 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz2Z4gsiVBW3raNZgJQp4w/J8SJVB0qb8SnruJK8oXg1FQ2IUqsy8Zd+OmIoWABu+Xgyp6n13mHBbhOX8F3gDjFwuMmh2DBL93UeTM7+agXlQZDfATbqvjezEN8EEpcSXm64Samlb3ub3ecKfsGTaEhdWjJmMCrC2CaYih7YSS+ZT8WnMAQWDxFKxDc8VJjZWEs6wHT2HQZtZSxLxGJU9ynVauWdJ87lts2uZ8m5ahbry7dvqWlg/SAwlps5pyuY3eC0XBjHg5fDXNZ+ErV38Rjm47U+Tz1LR9ClrnzRn+H+NOMM+p/c5bMij+4UBrYmbR5m4DVWwOjKo0b5cLZQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkdEg6W75GbTtEEWnE0kQkNAtfR8v5e0K20Vdr3eBKY=;
 b=el6S2PpaOt1Q1rO0W2ZDTI2rZr/6O08084PDJRx0x0HHPuU7IuYbZhcRAVzEd1066sZAsUY6bjTRUgaW9bOilnJhFbEAEaJd0u2aqq9i0xWyV5oy7xkCaE46bpdDIu8YilOmXRlApZ1bwyP0RGBaOjol0Z0BJ9u652uRGyX3Raj+S4O/WWtpyLJmfdVInDYSL2jUzctgRMW5I/8vKU5kLqp1imVgjWHG3cVvtPDTZsbIsx5Idxb99672lMC5H1DecctdVe64IVVu4kwW6BKz+5US6jBTaflZNn/IiZJCHLTqU0DMeieTVWM8S+/hXKvJIkpu54sxhs5Z/Zn5XtkD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkdEg6W75GbTtEEWnE0kQkNAtfR8v5e0K20Vdr3eBKY=;
 b=C5weg/8+6uGlPOwOCDqGJFX4ikM8hYBOS1P/Dh0N3sr/c5f9LSrLU894areEBwJcYhbz8K0PWP0/vKGvv4cGW2G6Scn42SkEqv/oX7VbKkKhDPklturwVZWzeHPlvbnOg5FZVvrtaee+zUeh3oUqc+q0/mUsXMzZ/RE9oXV6BqlSxJNtgRuAyDM+CLAMgZT8MEzahCOiLBpBPJYtGSqi1aIyUV8Q+ONWoCO9ZIUo7fJ5eBxUfTdYA879VeqquhBIQSeYEkCFbmxxGIyDOEap9n1cnuZU1JaEFSlrEcSBLOM0tH+A2PCu+CUhErdw9YBpkuZGsoKwA5LVadS7cUFNMw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYUPR06MB5875.apcprd06.prod.outlook.com (2603:1096:400:35a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 07:05:43 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b%5]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 07:05:43 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@aj.id.au" <andrew@aj.id.au>, "corbet@lwn.net" <corbet@lwn.net>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>,
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Topic: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Index: AQHaQgZuUE5b5SSLEUGoux677v5Ay7DXAz4AgAN4T2A=
Date: Mon, 15 Jan 2024 07:05:43 +0000
Message-ID:
 <OSQPR06MB725208AEF8779B0BC971DFF48B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-3-billy_tsai@aspeedtech.com>
 <20240113015556.GA3829553-robh@kernel.org>
In-Reply-To: <20240113015556.GA3829553-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYUPR06MB5875:EE_
x-ms-office365-filtering-correlation-id: 70053e65-6bac-4438-6cb6-08dc159863ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kd5ZCQcY85nSfSgM0JT7hHoTfS9liN5zZVZBJeEMFUpuhgDby0POs7MrwWr09HXVYKylE6wD+KoKpmTPsoyf3Ebf+9yss68lfTKtEQTnFlyXiy7gDhrK+z7hE3Wn2kZTeZsW71qiKjYBm84OaGUM1q7vFXB8LgFN4UnkCsYKABu679mdSK8cGbTQy493b2P6RRErmcEaF5uzUz1pX/X8SF7DKzFTkt6pd3N1+lK8KVxDvmOegf/gRa1mnAT9tN6C2AWP9zbre5ytzfJA0NJz/0TyPlFnD8d2GrDt6GC1mDPufyW/pbqQrzFRO28kt/maH7xZlDeI9+Us6prXJ6UKIABecOlFHQ0bMlQ793PE5lgdpzXid2JNZOOkZwX3N5Pptg14AlioPlEUnpC2D+xjhJFLrQNYtgYotkFzFT41hTAEr7700zXtfdJxrKVNeAttsK6lzTsqhbccOO3p+KzKz7wmxvbX9pl9p8FVBKFG3vJqa62TSf2ljFmLbJ8fMkEtRftun99/SKNJKyF4sc4pq1AIQo/lB23LQ+net1J1w4EdsBcz4tutOpk9DcSCavQOVAU/erIsh7gHYq+/ntNz4/mLZ+jw4p3GjX/UF4adZCEo34pNkIKYHbnH39WJrsvLb2qHVOiZIrO06bggCve2dw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(83380400001)(9686003)(86362001)(33656002)(38070700009)(7696005)(8676002)(52536014)(8936002)(4326008)(5660300002)(26005)(38100700002)(122000001)(71200400001)(66946007)(76116006)(66556008)(6916009)(316002)(66446008)(66476007)(64756008)(54906003)(966005)(2906002)(41300700001)(6506007)(55236004)(7416002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AfUqn26AfFtwU1HKM5xq5oVlQsIF2HXjgJWwyKR+nB516VSPyTn6e0vSHU?=
 =?iso-8859-1?Q?8q6lfN0qi7iF6E64xo+A80bI/C0YFKJq5wS0pFySEsfudc52Y/gc2f+9Mg?=
 =?iso-8859-1?Q?wrhII/wvyURVVprGWhc8i9sMwqMlrstYiAVbhJMI3Z8RF1kPLrFk/WobW3?=
 =?iso-8859-1?Q?G0Y8QjQ3e64CfQ4QuPwz6AFB3vym7ZMBVQMJslWf68ltoWSLl14Pz7tf03?=
 =?iso-8859-1?Q?lnrPVcpiIPjy0adRqQnGFq2FEs1eCtX5gfP0DeGs98nMnmzYXwUN4i+bc8?=
 =?iso-8859-1?Q?SBUgDgUOQ9O3Kr0i95qAassG3waiQiUPL4xkfidZlXZESMyxcX/Ea4Ap+0?=
 =?iso-8859-1?Q?U31RVsSkIX1CQCmS009Z4F2Icjo1JtBvRoewLPEhxFrMF6f1z/FDn9BM2P?=
 =?iso-8859-1?Q?f9NFygfB/VGdA9ssctTvnJDtmqV6cDjRvCXXpj3BqF8lxVa9ZMMe/glDju?=
 =?iso-8859-1?Q?hrXD96AEdraSSvATTjjzPmDqyB12CKJmiTpspM5a4Zemgkh5YsFdyfap+P?=
 =?iso-8859-1?Q?iE0UXAii6KFi6By0EVDrgmghxnN6ooiYLwP5vOARDhgDgvBr2ZqLg+1WmK?=
 =?iso-8859-1?Q?aIqB3febfeoU1WoyhDehOWHBzwP5Fp1p1q0n0p1i47nNwHpiLeSRnKPp8N?=
 =?iso-8859-1?Q?aV2O9gXsh68Mnw7UplS2L1rqZcNuVlfiiwocK9SSnLaWHuVhLhnRmy675M?=
 =?iso-8859-1?Q?VpcyqQpD8toNzVyJE/h2DqNSCRVGMUDSwWi6jAQhBZdZxgbZNF1y0FfM91?=
 =?iso-8859-1?Q?CfpYGLXrKjryBt6cT8CICznqGP8m32zesOlgXrUiYTcTLm4pYXnLhQeF4g?=
 =?iso-8859-1?Q?kBiSlEEcPYrjkIqnPSbE82KAr19bUIBlqYVxchpAtRFclSAWC9k/5q+xSj?=
 =?iso-8859-1?Q?vjS9s/PphI3vI6zCPWxlAd1B5ABpoGdFZ1DXwFIPwgiH+NCm7wqISx6t8r?=
 =?iso-8859-1?Q?HhISXEA67lAaHR9ja9jO7HBPj6RX0qMJmaGuYoN0ekRr26gOh4V60JPvg4?=
 =?iso-8859-1?Q?nOcTvUZk03FKfEu+zNgQImpVVO22ZZvdpVzFbBzPoTaJquOiyq+cOwCTN4?=
 =?iso-8859-1?Q?NLqAIkL8qcqTd8uc8sP1miCHAyPf8SFfy3kTUpDJlwCkRK/+6sSRdwiX0p?=
 =?iso-8859-1?Q?aqAZ5hT1fDS5fCC0KucHD6WsqqOl866fdAMJ9l8pawCYsDVEumoaZTuxg5?=
 =?iso-8859-1?Q?JtR2i+lr5PcAlTnbBjXMsk/MLHbCnu0hTj5RrpioVAeQWEh98FldkbVHAJ?=
 =?iso-8859-1?Q?+ymvTERc3kiR31CvgHoe3q9qQSCkmhUEydxpVTLiWgRALhibz4rNhFeMop?=
 =?iso-8859-1?Q?0DGc9AUZvZaS32Gs3ElKj9coNNI1uvtOHY+/cEhQjOUN1zuRK4260X7G+Z?=
 =?iso-8859-1?Q?Wcw+mVBuH9rw54WWaoO9jM/tiUt5aEBhSzLXDMmT5oh4sP3gRT0NfHTO91?=
 =?iso-8859-1?Q?tRd4zTKyfjT8vaGlb5e8npwPci7iv533HeMqcpeAg515ZmqRlZBQZlH5xS?=
 =?iso-8859-1?Q?wOeMIX762OtlwrA2Q3YtcV8J6voLV4lKOoDlU3z85SN0gPQHXvmmd9zpan?=
 =?iso-8859-1?Q?stOKNJkUD3YyQ4kJUYhVw4J4i6DMHYRIIWVoF380J0u6bwIs/qAsvoPKiq?=
 =?iso-8859-1?Q?Hp/+3Cr/VdsByqv/0ikPlBPt88wfrrgJAW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70053e65-6bac-4438-6cb6-08dc159863ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:05:43.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZnsUOnrzXiYR5ChcUUoHNqkNEk0dkI8EjAdYiIaBI8/K7CQCDzO5D4zCFLq7tD2uirtZLRcYTsTkMMTP9uQxUWz/o3yeB4OJdJzTz/lLsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5875

> > Document the compatible for aspeed,ast2600-pwm-tach device, which can=
=0A=
> > support up to 16 PWM outputs and 16 fan tach input.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > ---=0A=
> >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++=
=0A=
> >  1 file changed, 69 insertions(+)=0A=
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-p=
wm-tach.yaml=0A=
> >=0A=
> > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach=
yaml b/Documentation/> devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=
=0A=
> > new file mode 100644=0A=
> > index 000000000000..c615fb10705c=0A=
> > --- /dev/null=0A=
> > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml=
=0A=
> > @@ -0,0 +1,69 @@=0A=
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
> > +# Copyright (C) 2023 Aspeed, Inc.=0A=
> > +%YAML 1.2=0A=
> > +---=0A=
> > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#=0A=
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
> > +=0A=
> > +title: ASPEED G6 PWM and Fan Tach controller=0A=
> > +=0A=
> > +maintainers:=0A=
> > +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > +=0A=
> > +description: |=0A=
> > +  The ASPEED PWM controller can support up to 16 PWM outputs.=0A=
> > +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.=
=0A=
> > +  They are independent hardware blocks, which are different from the=
=0A=
> > +  previous version of the ASPEED chip.=0A=
> > +=0A=
> > +properties:=0A=
> > +  compatible:=0A=
> > +    enum:=0A=
> > +      - aspeed,ast2600-pwm-tach=0A=
> > +=0A=
> > +  reg:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  clocks:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  resets:=0A=
> > +    maxItems: 1=0A=
> > +=0A=
> > +  "#pwm-cells":=0A=
> > +    const: 3=0A=
> > +=0A=
> > +patternProperties:=0A=
> > +  "^fan-[0-9]+$":=0A=
> > +    $ref: fan-common.yaml#=0A=
> > +    unevaluatedProperties: false=0A=
> > +    required:=0A=
> > +      - tach-ch=0A=
> > +=0A=
> > +required:=0A=
> > +  - reg=0A=
> > +  - clocks=0A=
> > +  - resets=0A=
> > +  - "#pwm-cells"=0A=
> > +  - compatible=0A=
> > +=0A=
> > +additionalProperties: false=0A=
> > +=0A=
> > +examples:=0A=
> > +  - |=0A=
> > +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
> > +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
> > +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
> > +      reg =3D <0x1e610000 0x100>;=0A=
> > +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
> > +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
> > +      #pwm-cells =3D <3>;=0A=
> > +=0A=
> > +      fan-0 {=0A=
> > +        tach-ch =3D /bits/ 8 <0x0>;=0A=
> > +      };=0A=
> > +=0A=
> > +      fan-1 {=0A=
> > +        tach-ch =3D /bits/ 8 <0x1 0x2>;=0A=
> > +      };=0A=
=0A=
> NAK on this based on how you are using pwm-fan in v10 discussion. See my=
=0A=
> comments there.=0A=
=0A=
Okay, I will merge everything from the pwm-fan0 node into the fan-0 node=0A=
and add the 'simple-bus' to the compatible string of the pwm_tach node.=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=

