Return-Path: <linux-kernel+bounces-6766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36712819D30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0301C256CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822120B30;
	Wed, 20 Dec 2023 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="HRLRxzNu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEF20B03;
	Wed, 20 Dec 2023 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsxcGXTRItPeWLwxUi9hYwOLnOCEiTgiGZvsm/ex7RiAjsAWalWRBD2tv3Cpd7vL7W2nPCELsiKtpQ+knUCsCklNmCPa4vxecSVlrWGHAGbDD3WwLhdXVARTHAP0XNRrbRD6VXrvsClYjUxj4Wyu7HvmX7rtpIl9nlzIITwpNukQ/LUDN5GWfe+38GHbQAwAZ4zk05Hw0kR8IdZQkzEnkAWjJa3y/GDmaITjQWvzFPoTHw9wUaku0dHbiqPOciEqgrxUKVEB13hYHjQ12PJs20URYbfr4nT63n3b+3eAmIrre7yBT0DIkbvYyYqj+nTSv8iSxsuQ7vztjFJogXhwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHTXGgB/QZ5hKpEz1UlTrycFSe6OfPKsfEa01mT83KI=;
 b=CSnqFRK/D567/Tqp8SMNK9IRl5vUxPNd7M8vho2rnLKZJj4dIk+eTtjZlureaNScDyJr0thb1AlpV0awltrud7QnYblExpeOOLXbD38yFrPL2ZntrdpvqQeL44SCGG2pxWQVGpD8Ni1SFtLaqWE/o3Z63ILgPU9SrgG3npu8KdmKZPzpPdvAwDf0Oe6xMvmsqAI9TOBUm2SnNS6ORutTNwJhud0lhZNpvAQPCA/si36f/ilsRX+pSno2/XDIG/GHAXqdjlWQUSW3ZNcK2v5I4wS0bflanTyBARt9E6Rpd+FF48yPZXlcYjRihE1bqeVP2TDP+YWt/KQDa1cEgLAVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=huawei.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHTXGgB/QZ5hKpEz1UlTrycFSe6OfPKsfEa01mT83KI=;
 b=HRLRxzNugcJLw7CsAy4VzRftSizlpT2FzJhmqqfVM3cfFdrvold61Hb9Nl0mCQcgjsf0JOyRd3yVEmST52x/LOGaG1z5UBKPEJK4YhJUmMKenoIq01v1d2H202Q1PkF+7ZH71CNJAejWViNyCKXi/Xt3e8C7KI/R/2QoT18bq8IoxYvMerjbM5rYW6/oDcNM1S43A8Jv/9fIdSA1MyPw8Lrx1gzsf79ik9//OwXycyRiFo0p4ura0PW6pkTePc/8NnPniFkI9bbvWQLplUdtkxp/TSBfOqaEzdrQYnRrtI6sEpoLRYKoC1v3qrXZWBPgaDg5ekfvdQE/4RYQbgXkhQ==
Received: from AS4P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::11)
 by PAXPR04MB8701.eurprd04.prod.outlook.com (2603:10a6:102:21c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:43:00 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::ed) by AS4P191CA0012.outlook.office365.com
 (2603:10a6:20b:5d5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 10:43:00 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.51) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 20 Dec 2023 10:42:59 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by PAXPR04MB9108.eurprd04.prod.outlook.com (2603:10a6:102:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:42:56 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::5002:554a:3ace:1f8b]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::5002:554a:3ace:1f8b%2]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 10:42:55 +0000
Message-ID: <ca96c5d2-33aa-496b-b85f-531e628cb6d6@topic.nl>
Date: Wed, 20 Dec 2023 11:42:54 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Conor Dooley <conor@kernel.org>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
 <20231213094722.31547-1-mike.looijmans@topic.nl>
 <20231213-diffuser-disposal-ea21bbce8b64@spud>
 <20231214102244.000052a3@Huawei.com>
Organization: TOPIC
In-Reply-To: <20231214102244.000052a3@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VE1PR04MB7471:EE_|PAXPR04MB9108:EE_|AM4PEPF00025F9A:EE_|PAXPR04MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e04fb0-a106-489b-111a-08dc01486f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 LlXu+eRUjVbNym9nti5WxPNkEzZnKAXJVKvr4iwoHJmGfw6cuw8bAPLmdXcT2OKUu0oRozqxw6/5oMkmx21PwAc96mYj/IqRkIanTuMQad7x+d0ZBUJVflHoZm2VATHfiBp095MbyKGrcP0GLY8+jB8KLFDIf0xnlBT0zwgabQjPs77JzwyQ0fgXDjyUUN68UlK0zO4g9qEa9yDgQwW7JPGCjMhyRfSlsyMcUVP2fc4I2LkQMYrKPY0RcGHWdOt9HStn8PpNsejq/W2Z56UZw0FeK3s8UMEtp4oTlhraRC+80gCHvEkfGV6k4wbrmrQxE7yKNco54eQHiolT1gXpAwdA3p0WtoaQj0TRh9OD2JNi1EYS4QfinioJERiGeLFh1bPIr2b/GFQZlKHWu8BFoETWltyx8sywX3X+VWgVLliconVEE+k3IuVmiVid7MBwAWLvHMqJBlUyIsnMmvS/cSsqg2zKz7Kdb+kgmaCSgyyXNOZZNddB3tV1BlIVNBySS7Fhu5gpk6Bu4tgaTiru//O8GCgAVT26bYmazuk9mR2DNeT4OYQaah0G02DA8XkgziAirg9dFfsjTxuasXhe9E3X4sF6avx9mDRO/bEorcMp5M2VgTXOLkB4FLPXjitqO/RtjMqWkn9tMv5HUXNJKPNH7okUxnW6LIOjQVk9Z9Jz8wjZO7ec9zgebFTboMCMWvyOSQjg/6gr4yahSKlalw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39840400004)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(36756003)(38100700002)(7416002)(2906002)(5660300002)(83380400001)(6506007)(53546011)(2616005)(6512007)(36916002)(26005)(966005)(8676002)(66946007)(41300700001)(478600001)(66556008)(54906003)(6486002)(110136005)(8936002)(86362001)(31696002)(4326008)(15974865002)(66476007)(44832011)(316002)(273104002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9108
X-CodeTwo-MessageID: fac2d985-2de5-4a08-81bb-e9e6443fe64c.20231220104258@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9fc4e06f-ccac-4726-c844-08dc01486cee
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0wdIQLjVXYTs2eOJP2EUpoD1/Vl5GTFWp8r/THrYWqimWnzwqFTST3bpJ1MJw72gu5B9e0IqZ3WgGJQ3UydbwGXBT79rxeVRET67/r5YqdbVA/y7fBAyDNZ+cUW8ZGOMrbqTu3b+M0kWi6dHtoB8u4qku7nTSmo3nFDybbpWXrC0Fag73vVtLFHBfLx8DWAj3AN5zvXcwSTHp9VEVLXNUi8gVAnLnqhzQ2imQsnJ6Gl4ERU5Ti3DnPxyhLQUnDQBu3AIuweNMB0Jla4nKP8tjKzWIjK8HuFlh6wqzWMuNOSV4f9nkfLoyyT5hq4Wz2PnqKhSmnkEJtx2CUFT/Fwnq+Io/YuG0UrvHSTt8zTEXtViXHk3XhqCncZJxAMvXsVLwNFh5euV/QYWRFsIKQxgNV64Qbry2KQfP6o2VQom3g9XG7PeDXW20bAEh3BGwifkraeoyj4WAUkQoMrXpBmOVxZ6zM9rAdAGqjBLtB3i/5m+5iMhAeL0KbTiCJemhjAcjniuLVcZVoJ3AyGbt2BbkaCNI41GEsNB7LGdcr/G9jwKwGiaA3wxUASGuCyHN+oc06vR0LxIabsxDn0Y/d2oGdYnwj4GTp0JJtQRBe80c8der9b6DWjkvVHeZuSEn50Lxyp87QI6QszuAZC2I4PFDwA7JI2Cus2sD3MnCgiBXqSn8+/TSCPglxIOT3LlfqbKSLoYO3eML0HP3rHTP2O7nFzv2uULXg86STFs/5iPahb0VLRD9IVuGalGKSkYwK2AWGgXVFuUYm5x/prsPM51hHy1SMU+YXq4USbMmLZeOKU=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39840400004)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(47076005)(7416002)(6486002)(966005)(6512007)(26005)(478600001)(36756003)(2616005)(336012)(356005)(41300700001)(36860700001)(7636003)(7596003)(15974865002)(83380400001)(86362001)(31696002)(36916002)(6506007)(53546011)(2906002)(44832011)(40480700001)(31686004)(8676002)(8936002)(70206006)(316002)(54906003)(70586007)(110136005)(4326008)(5660300002)(273104002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:43:00.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e04fb0-a106-489b-111a-08dc01486f9a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8701

See below.


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
On 14-12-2023 11:22, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 16:23:43 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
>> On Wed, Dec 13, 2023 at 10:47:21AM +0100, Mike Looijmans wrote:
>>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>>> typically used for ECG and similar measurements. Supports data
>>> acquisition at configurable scale and sampling frequency.
>>
>> I think the commit subject and body here were accidentally copy-pasted
>> from the driver patch. Patches for bindings should avoid talking about
>> drivers and focus on the harware (unless we are talking about LEDs or
>> motors etc)

Yeah, that's what happened. Will fix in next version.

>>
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>
>>> ---
>>>
>>>   .../bindings/iio/adc/ti,ads1298.yaml          | 80 ++++++++++++++++++=
+
>>>   1 file changed, 80 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads12=
98.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
>>> new file mode 100644
>>> index 000000000000..7a160ba721eb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments' ads1298 medical ADC chips
>>> +
>>> +maintainers:
>>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,ads1298
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  reset-gpios:
>>> +    maxItems: 1
>>> +
>>> +  avdd-supply:
>>> +    description:
>>> +      Analog power supply, voltage between AVDD and AVSS. When providi=
ng a
>>> +      symmetric +/- 2.5V, the regulator should report 5V.
>=20
> Any precedence in tree for doing this?  I thought we had bindings that re=
quired negative
> supplies to be specified separately if present - so this would need to be=
 2
> supplies. e.g.
> https://elixir.bootlin.com/linux/v6.7-rc5/source/Documentation/devicetree=
/bindings/iio/adc/ti,adc12138.yaml#L37
>=20

Given that some serious thought...

Splitting into positive and negative supplies would make sense if the chip=
=20
would have terminals for positive, negative and ground. Which it does not=20
have, there's only positive and negative (which the datasheet misleadingly=
=20
calls "analog ground").

The analog voltage supplied to the chip has no effect on its outputs, the=20
analog supply must be connected between the AVDD and AVSS pins. Its relatio=
n=20
to analog ground is not relevant, so whether the voltages are +5/0 or=20
+2.5/-2.5 or +4/-1 or whatever does not affect the output of the ADC, which=
=20
only reports the difference between its "p" and "n" input signals. It only=
=20
affects the range of the inputs, as it cannot measure (p or n) outside the=
=20
analog supply.


>=20
>>> +
>>> +  vref-supply:
>>> +    description:
>>> +      Optional reference voltage. If omitted, internal reference is us=
ed,
>>> +      depending on analog supply this is 2.4 or 4V.
>>
>> It may be worth mentioning here what the conditions for the internal
>> reference being 2.4 or 4 volts actually are.

Will do (there's a 4.4 V treshold).


>>
>>> +
>>> +  clocks:
>>> +    description: Optional 2.048 MHz external source clock on CLK pin
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: clk
>>
>> Since you have only one clock, having clock-names (especially with a
>> name like "clk") is pointless IMO.

True.

>>
>> Generally though, this patch looks good to me.
>>
>> Cheers,
>> Conor.
>>
>>> +  interrupts:
>>> +    description: Interrupt on DRDY pin, triggers on falling edge
>>> +    maxItems: 1
>>> +
>>> +  label: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - avdd-supply
>>> +  - interrupts
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    spi {
>>> +        #address-cells =3D <1>;
>>> +        #size-cells =3D <0>;
>>> +
>>> +        adc@1 {
>>> +          reg =3D <1>;
>>> +          compatible =3D "ti,ads1298";
>>> +          label =3D "ads1298-1-ecg";
>>> +          avdd-supply =3D <&reg_iso_5v_a>;
>>> +          clock-names =3D "clk";
>>> +          clocks =3D <&clk_ads1298>;
>>> +          interrupt-parent =3D <&gpio0>;
>>> +          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
>>> +          spi-max-frequency =3D <20000000>;
>>> +          spi-cpha;
>>> +        };
>>> +    };
>>> +...
>>> --=20
>>> 2.34.1
>>>
>>>
>>> Met vriendelijke groet / kind regards,
>>>
>>> Mike Looijmans
>>> System Expert
>>>
>>>
>>> TOPIC Embedded Products B.V.
>>> Materiaalweg 4, 5681 RJ Best
>>> The Netherlands
>>>
>>> T: +31 (0) 499 33 69 69
>>> E: mike.looijmans@topic.nl
>>> W: www.topic.nl
>>>
>>> Please consider the environment before printing this e-mail
>>
>=20


