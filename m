Return-Path: <linux-kernel+bounces-6780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186A819D70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7451F21D82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69B20DF3;
	Wed, 20 Dec 2023 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="bEIKJuG3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9920DC9;
	Wed, 20 Dec 2023 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J80cGGAZbzLTLnTl6LI/ukFxIPYMGgjByiOs+kaOJ7OS/VziR3tuy16sn+HGY7x43qmrZfnEbDfGcpseYkwHGfaD8bxjZoDaeUEZIwcg2aYO5R7kWMNaqGHk722NRVJD6Q3KPFr00eBh0sEr2uVS0mhOPC4r9T+HG5dg/hSNyN5nKZUhW7fNVftIi4uC/AUVaujSwn866oyqgqb1YsjEK1QqPHdsINqpWQcvBJb57/DQWqfW2mVzplv8atB/qhHTzqpsRVcqA+06pYAjhUXJ8ARAwsB7nYOOkDigxYmILK6VZpm3m0wOTrOtPymO6rVmhUe+uiHulXjX6WXUuQs+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcGDCZJGHd1Ok3xtJgHr3q8B2hRSMMVuRkyw7BspheI=;
 b=bxJ+67z2uWn/8EzYKx5rFtK6P3ZFVNglnYGoBeT4SZL4L6HBlLIi5w9NdKgU23XbPrzvyS/XCgmRhgF30RqwcwiEctfng0yHiGxWJe3LDi/RrO2m78eT3vAHTk2eMwEfi0I3Nko6iTIiyXd4uxSxeHgvHbA+BIODehaI2G3mWUegf0phbH+Bm/VmdrliU4/lNAZUfteMbhs9FZQf+q7x7wELgEYzZq/UAnIsUcdMCQkvG/rBFikdk2pWXe3fJi0rAI3HSvg6MbUmkSb4qQ0658Pyd1X5yVd7uamUrRsQanDcwUNbbcGTYJkiEmkxS6sobePNHf+nexcx76HA/zYJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=huawei.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcGDCZJGHd1Ok3xtJgHr3q8B2hRSMMVuRkyw7BspheI=;
 b=bEIKJuG3zpjkVrk9xQaKyTZBiju6a8nVtTrbmPi10chcM/h4StbRFSWzMceh/6f7Hsc2OhkOTYlUONYatgsoz9JM2OuBC+NvH+s2txgMGLtNN4+Fn581YqHUQBHoFtSLmnhqLr526fz/ho4K84Xl1vkFyQOnwcgB8Qp5zCdpFkc8jv1qlXn7ZZCn2QE/W5sD6uDwrktXFjoIvWVRLISLwL0DOfcPkE2uDy3S/ByXUGx88pHdRXUfEIjcKZoqMmECV6kQcC4t5Cf09/bf7VK4Gnt4RV46C8D7lUkI62DW5KNebsNLupiRQFeBlFJpAE2btcj91SQImigIdO7COGpm5A==
Received: from DB8PR06CA0050.eurprd06.prod.outlook.com (2603:10a6:10:120::24)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:58:08 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::19) by DB8PR06CA0050.outlook.office365.com
 (2603:10a6:10:120::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:58:07 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 20 Dec 2023 10:58:06 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:58:02 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::5002:554a:3ace:1f8b]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::5002:554a:3ace:1f8b%2]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 10:58:02 +0000
Message-ID: <02cbc31e-ec6e-4b3b-940d-da51567c197b@topic.nl>
Date: Wed, 20 Dec 2023 11:58:00 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Content-Language: nl, en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
 <20231213094722.31547-1-mike.looijmans@topic.nl>
 <20231214111107.00002fd8@Huawei.com>
Organization: TOPIC
In-Reply-To: <20231214111107.00002fd8@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0046.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::11) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VE1PR04MB7471:EE_|PA4PR04MB9566:EE_|DB5PEPF00014B8D:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: c4334100-65d8-4ed6-19f8-08dc014a8ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 vKjsXgyrJPGS29S9RltwJSa4X9VzjiPojw8VTae16KZTZ83djfUtpB43hfGzm8cLpSLYd4hvy6S9CLqJ2gv6rYWqhyTyY+Wa2/MudsIw8yx8KKohZDLKnrb/ShrF2XVfTAnlVnX9FFxkRNvM0st3nURHvHMAJoK3MLwLOvIMqtZxIRVrhu7roFKAINxsncMTJBfTUT/JAgD1jKv/Si7sRRMInEtlM7psMdVScWUowOU5h5KYIbBANUrVFZe1rCKdKQVL+TlHRZafAQf9KSumy4/cMWyF76zzY95odLkf2KoZBopzKMY5o4SCUPiklTyefVWNX2LO4CuheEIm8zwYXnwApDN9yh/+Hy4tZEgC3rhzMx4QiuON1qVVsNf2UG6hkOJgurzIAtKqoK06+AAtZyLWi50LpGEwA/I0+NrK6Kw7+vkFK9lbi8sAI8t5E17aWYHrOjGORbfnr20TCczCNrq29eiAkEtD3U3su5zVlCE688XOpV2APhtUaDjY9+a4jil+r+b7PGBjhn2YXeHfQabRW35XCU7tIWgp9TTUfz/f4NWO7V3oYaIZFziSFzd8agqX7s77lhWx8LR/f3K7DEMiWJbcNBA5GOqdFND7u4IMcWR1KLZP8t+O5KhSZBtvQFt3ukHR4crC/cAc5zOQBO0hhAewcd8Le87iXCSit+w=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39840400004)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(316002)(6916009)(66476007)(66946007)(5660300002)(54906003)(66556008)(44832011)(8676002)(8936002)(4326008)(53546011)(36916002)(6512007)(6506007)(2906002)(26005)(6486002)(966005)(478600001)(31686004)(2616005)(31696002)(86362001)(41300700001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
X-CodeTwo-MessageID: e107655c-4b32-4455-8c17-63897b753d9f.20231220105806@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a6d51a1-c9db-44e4-6377-08dc014a893b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jvHCiOFwAtnsD7GlcOsyRL3yP3KRUrd0AehqqRCV4JhP99ViIPXFdXObZW4zbvMdkVQ/Ba9SgbK+xU1R3OgaiCTEAboZZS3lS5tGUlxakIYfzwd9GazD9Im6SAuXZz7YUvUjEl3UKJ1mPd3y8pwahSFbopBVPgOv6lbIGJYssBx8mN4bbQha8rlmJvJUCxJ93PWwT21/r976m/w6pDyzw2o/B0g7AXqx2dmLnhFIuECKsKOXwPug+gUC1Y1HZit1VJ1NCYscQwyZtElh6Ju72TleUfbJMhLC/tQh1rV+ygrlh0cfNm7hiS+iWpRY8wEHKxopiV+6BP6F6QyklCCyuov6sT7Y4Se6gLj9lT3Sfg8RW0lfZa9WRPf2Ddnh+/PNZW0ogBRUyo1IrKiu/HcAfTMP8PKOsGHph6ng5ZSVZ1XLB8zxB6EmcUL7YZsRDK+dU38eXJgerXTVwSr3qRxbfPqZRCfvmsrjCOW1jW/252QgDcpUR2+mtw4v7rvDCu0DuG7k5Az/WgCea7bKu4Dc1Gvxd1qaWnVnI0i/eYwGhGqhUmhfB2FE4DeHsJO0afXMPEMDhoB3Fk/4A6TocOFTbHqWeBwjwt+pqGvF0qeJC/90vOhLsZrONGV73uHtEaD2AxB4RzQWauqT6xHqgnMIG3nXV8fppw3MzDVqdq2LiU0bU5M8p4Ah8VjMejrj3wz8DcNIw9LeHfjzEqXGEoxN2aqMrmlV04hs19fqTJgu1xIyDpg+FpOFzXyzFnHeVHZlcNG80yLie4iQuPUYnhX6Lg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39830400003)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(36860700001)(7636003)(7596003)(356005)(36756003)(86362001)(40480700001)(31686004)(31696002)(6512007)(53546011)(6506007)(26005)(47076005)(2616005)(41300700001)(336012)(478600001)(966005)(4326008)(8676002)(8936002)(36916002)(6486002)(6916009)(83380400001)(70206006)(316002)(54906003)(70586007)(15974865002)(2906002)(5660300002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:58:07.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4334100-65d8-4ed6-19f8-08dc014a8ce5
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 14-12-2023 12:11, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 10:47:21 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>=20
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads129=
8.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
>> new file mode 100644
>> index 000000000000..7a160ba721eb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments' ads1298 medical ADC chips
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,ads1298
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-cpha: true
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  avdd-supply:
>> +    description:
>> +      Analog power supply, voltage between AVDD and AVSS. When providin=
g a
>> +      symmetric +/- 2.5V, the regulator should report 5V.
> Commented on in other thread.
>> +
>> +  vref-supply:
>> +    description:
>> +      Optional reference voltage. If omitted, internal reference is use=
d,
>> +      depending on analog supply this is 2.4 or 4V.
>> +
> There is a dvdd-supply as well.  Might be others. Makes sure to document =
them all.

Extra supplies make sense, I'll add them.

>=20
> Should probably also document the gpios as the binding should attempt to =
be as complete
> as possible independent of what the driver currently supports.
>=20
> Lots of complex options for this device and the use of those pins, so may=
be something
> that can be left for now - but the patch description should then mention =
that is intentional.

The device has so many options for connecting stuff... It's indeed possible=
 to=20
(also) use it as a GPIO expander and as a clock source and more...

I'll put it in the patch description that the definition is incomplete by d=
esign.

The main reason I'm submitting is that this is about the third time I've=20
written a driver for this chip, and I'm sure that other companies are writi=
ng=20
their own as well. I'm hoping this will result in some joint effort to=20
properly support it...


>=20
> Jonathan
>=20
>> +  clocks:
>> +    description: Optional 2.048 MHz external source clock on CLK pin
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: clk
>> +
>> +  interrupts:
>> +    description: Interrupt on DRDY pin, triggers on falling edge
>> +    maxItems: 1
>> +
>> +  label: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - avdd-supply
>> +  - interrupts
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    spi {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +
>> +        adc@1 {
>> +          reg =3D <1>;
>> +          compatible =3D "ti,ads1298";
>> +          label =3D "ads1298-1-ecg";
>> +          avdd-supply =3D <&reg_iso_5v_a>;
>> +          clock-names =3D "clk";
>> +          clocks =3D <&clk_ads1298>;
>> +          interrupt-parent =3D <&gpio0>;
>> +          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
>> +          spi-max-frequency =3D <20000000>;
>> +          spi-cpha;
>> +        };
>> +    };
>> +...
>=20


