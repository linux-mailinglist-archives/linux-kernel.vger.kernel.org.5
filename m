Return-Path: <linux-kernel+bounces-17065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC68247C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8328255B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E692D035;
	Thu,  4 Jan 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GSnxSEUI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA452C856;
	Thu,  4 Jan 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag53CVUWHYoiNLoyVg5Ftw3C78kLNnzBevmXT/Lpb4PK167eumoSnXNoaboeIhR3DiHqkQzXRUmsz3grQ2CVKKRDLosuAP7wHzh+TNm3UYsBurWtxt4cqDoJZRmr73deA5b2lqcyD6BPZUCdsXHXPkO1w5vUb8Dgr4+Pu4gvCBFplZqvpD3rmxvDa4l284Fe0FPU4roJo/wDhUavB04zK3FVd7OQ3AVfWg0HS8LrvzFg+EVJWswNf77lwOkBEiC0Mn/EOn+4aLiPqyKjMaAHzeK9z4zZV5ecQi2uuhyKQK9eHtdxDFQFV7aI9W5Nos54w/ADAl4yoA4XtREa4ZnzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=OsgHWFOqpkZ9f6rLTjdJZbGmeCbmFyIL74VqNTQYEV3vimExq1duSJ7nb71Wj8yyqw/c6r6HQ57yO2LK7BS6X+deg54q/5v2O9GO75ZKXGgPheXwYV1+IUHhJL4qQnEt9/yfw9Lley2BWJazcjj4Mo4e71kl1bXU23eIyBlNd2uCuobU3i4Lyp19P2HAQpSI74v47wnUzxSThrKaT3ftpD53lGoYlhPQ9S833YeCFTZLZ+Ak0Jnr5hZJ+sar5/TLh6Qy4YvUEUbhlLxV9yH6qfgkxUT7dIqYnk8jOhRIsIONqULaAljbelLvMupw/LfIKrBXTqYQ8CcqXlKqi4E5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=GSnxSEUISUYUEs2Xna+SEX/OFaXEJl7UdFirS+c4IWl9DjxZzbJ7XwWhOiiUS7lJpn7jK9N8buxkK8Lsr4AtI3uSDP7TjCdB31+Jsh14YkgK8YO8E+w/PtKArKq2uhMfo9h5qT/SzKpQYBa7rCZ7b3R/5ntVFSC2H0UcS1qxwaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:48:12 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:11 +0100
Subject: [PATCH v5 10/10] arm: dts: marvell: clearfog-gtr-l8: align port
 numbers with enclosure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-10-52be60fc54e3@solid-run.com>
References: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
In-Reply-To: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8a8fb3-272e-42be-99ae-08dc0d4d5150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3dsszoaNtynyG8jkUgZ7FkWNjVPKIyBZSf6KGR7mx/nOfXN098WhH6MzK7SWydTTZLhOAePscQBPGK57sX0UM/Z/kf0pCqQ2Kq7UtyTAB9Z+i/2RTVTZ4t4QcUSSKQq5jCtmTc8WAnjZ8FzgQGQZNhMylF4MEXh68UwyAcfLGHNy4OobPy1MsqhCVHwbstgwIeTNIk1cBunpi7h4TGl3o7qO3mOZ9p128RPBCkZF5iFH4zAOblp5g7C4W67+tXBjzqWcvJaDCfGaifgFu0tAmwEOS0RFAhHyqXHwvCGuvM/XgQWGTfMh9cfc6P2wGuVIhyYIk3UpgHNAVyKdAgFuGLCpqKLXVw0irEjLSz/J6dkaPE7GZpgQ6YIJZh17PZwiUX5bVgy8A+lZRMkGx+2gy+1vLWqU+GOU/hSTSdWHLt4e7ITacqkNjGL0LhViKOfsHScQ93Y6bnOUv5ecRp/0HB3HX7aJGVXlpu4clNfQ+OreJPGOZUJmsnapbQiV7dFuMOzUvgqcAmG6gIXtk3oraMjlC2z4WQTlR/IaubuSeQiL+aGTmHHckZFKxw9sSGSwUY2xF/tcJUpQrI3Gtrs3d5yV0uJDtjseWNCSROcyIHtffSrobiw/SSymb89QsKlG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(316002)(110136005)(2616005)(83380400001)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ZXVzUvOFFIUklvTWIrQytpVjBlT1ZhdHQ0Q2NxSkNLeEZ4V2NDclFRMkJw?=
 =?utf-8?B?VUh1cXRmNUNOMTBkTUpMelJTRFBLV0lqb2FPR3BSMkYxb3MzWUg5OG5pdkRh?=
 =?utf-8?B?WC80b3hkYXFqeTE2enVLTWdGZGViYmIwbS9pT3BWcExEeXBsQjhRZGFIbU8z?=
 =?utf-8?B?bzFmU0lGY2cyQ3pLTUUrNFdtT3Rpb2QvU1BZdFVIc3FqazZkUjFObGhqN3Jq?=
 =?utf-8?B?NDQ2M1hJWnl6WHZsT1pPcko1N0xKZXduWGtxbTZpdFNvRVJUOW9zTWRDWFBP?=
 =?utf-8?B?Si9idHYvSHJhdDVZT3Q1cFNPd3N5K3daMGVVNEJ1dFlrbUczY2IyTEJCa0F5?=
 =?utf-8?B?Zk9lVG9Ta003bXkyRkdwRlYvbVpOUXpoQWVhS2s5STN3bUdlWjhUYW5ZZFNh?=
 =?utf-8?B?OEowcUwvaVRWWHRGNnZDOWZJQjlYSnVSdytubCtFZC9Yd28wMXhmZXRYaFhw?=
 =?utf-8?B?WnhDczJhbUE0TVgwdjNrVnVmUmlJMHdVbDhoYm8zQ2d6cVZmSlVtU21tanR2?=
 =?utf-8?B?S0lLWVE2OTVCa3IzaU82VlhSTVB1RFJ3MVpzWEkxQ2tqbGcrajVLVVBJZ0tp?=
 =?utf-8?B?N0xxaDIzcjFhZlN2VFdaNGRndXFOeTdIdlRTUlZvdEJueUhLMnF2cTZib2ZC?=
 =?utf-8?B?M0VvaXJLdng2Z3FuL2p2NmFPSlM1cWtOVVVaaUlhMW5QOWZyc0x3THdXYXl0?=
 =?utf-8?B?UHo0QndIRXlxTjBWOUgzSkJ4SHNZVzhncjJkUHhRNlYxZXRMcEduTmVHN1Ux?=
 =?utf-8?B?S1FDM3NqcDM5Q0Jvc0Y3KzhIOFZGMXRhYkpJU093ZHhQK2wvM2RSaUE2L2lk?=
 =?utf-8?B?T05vQlljbTgwdFBhcVNUNFlmYmJSNTZRd09PVmt3eFNRM0ZtYm1Ka2k3c0gw?=
 =?utf-8?B?TTBwVURuZlUzaE85OC94eHZHa05idzJsZnhrRHBUeWZZaXJvOWJaYTg5WG96?=
 =?utf-8?B?c2FkcUNRaG1sV2g3TkVIbDVsWkRvU0tzTi82SHZGV1BUNUk3eURsNEFHMjJl?=
 =?utf-8?B?K3c4VXBxblcraGVvbmFZV2hwQTBuWERNVHhGS21WSzVwS0MwUUc0YVo5eWV3?=
 =?utf-8?B?VUNQYy9tRTJYNURlRURNcW9hd3RnY2NuMlBjcFk1L2tKV3BYZTRmRnVUQzl2?=
 =?utf-8?B?d01NRFRsT3prTDB6RzRJdmgzaEZ1bUgwKytiT1JMQi9BTmxoOXBxUUtocjRF?=
 =?utf-8?B?ZVg1VkMySEZhZUprenZ1NVBPN3dvdWh1MUt5dE14LzIyL3dxT2N0RUpDTTY3?=
 =?utf-8?B?ckh6YzJGMWlQWGMrOTIrVytuZ05lWXhTMGtsYWV3Vlh5Z2YvWXJGNGhIeG5Z?=
 =?utf-8?B?c3laZVhjWmkyR1J0aE95SlE5aXl3Si84OVMwRHk3SmJieTFUaXUzZkR1Zk9n?=
 =?utf-8?B?MlRZU3FWSjdLOEdPSEFFN1NoWGROdlg0bVFWNzhMSnJDYkl1UTFKUEcwMWoz?=
 =?utf-8?B?NTFaVWRUYzI2eDQycHpybmxycUpILytwMytHbWJrNVVkQTdMcXMvUmVMSEwr?=
 =?utf-8?B?U2VkVlFoRldEdktITk1sNTV1K1lkeWwrRXh2N1lDSXZiT3BsVDVCKzVHWER3?=
 =?utf-8?B?cDc4dStHKzlwdUE2YlFSRFRGZG84NysxelJaV1h5ZEtKd3R2RXp3NHc3MWJ3?=
 =?utf-8?B?TXc2SGhrRTFpZGl1V3MreXNFZFl2cWN1YlZPemRwdFJFMnU0Rlp0TnN6Mkhh?=
 =?utf-8?B?b2RPeEtUOG9ReDdKV3ZtcWhGT2Yrc2NwUG9TWXJiakZlcktWQ3FKd0d0Y2VZ?=
 =?utf-8?B?TUN5RklBcWdZUXNpUGRqTjFRMnlzOFF4VUlaNnlLaHhtbzNEd1dERXhlM1Qv?=
 =?utf-8?B?ZmZLTGlJeWhBLzJkL1pHb3JoNE40bC9VUjg5VTFjMmdpK3AvWStYUXZSMTlF?=
 =?utf-8?B?Q2p3R2VPMWxHNytZeHg5bUZHbjlBNHdIWnZxeHBZK2E5MUtiRGlXdWxrcW01?=
 =?utf-8?B?MXZQb0h2U0g2UE15anBzSmlIRllKa2pNTHhMRjJGTTJlRDRjbkUzM3pHY21i?=
 =?utf-8?B?bll2SjRENk4vdXJ6QmltRy9qMjVlenU5UHViL0hBRTl5TXExNkV0OVNQRjNk?=
 =?utf-8?B?UHo1RkxwM0VYRllNS0hxaTdpQWZMeTBpYnU0Y0FwTmNvNnNQZ1l0a1dzVFN1?=
 =?utf-8?Q?oOUoGFKUzKBs3OKDX2cNRmQNn?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8a8fb3-272e-42be-99ae-08dc0d4d5150
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:10.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3KLQlSOYVXktBVsPD0V0A/ADE2VVU95BU5NkLpIlc9DxNxpP45tDitGVNoxRJWfb0VDQSofwH5qMODNkqJw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Clearfog GTR has an official enclosure with labels for all interfaces.
The "lan" ports on the 8-port switch in device-tree were numbered  in
reverse wrt. enclosure.

Update all device-tree labels to match.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 2df388f222ec..da6981677b03 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -32,49 +32,49 @@ ports {
 
 			port@1 {
 				reg = <1>;
-				label = "lan8";
+				label = "lan1";
 				phy-handle = <&switch0phy0>;
 			};
 
 			port@2 {
 				reg = <2>;
-				label = "lan7";
+				label = "lan2";
 				phy-handle = <&switch0phy1>;
 			};
 
 			port@3 {
 				reg = <3>;
-				label = "lan6";
+				label = "lan3";
 				phy-handle = <&switch0phy2>;
 			};
 
 			port@4 {
 				reg = <4>;
-				label = "lan5";
+				label = "lan4";
 				phy-handle = <&switch0phy3>;
 			};
 
 			port@5 {
 				reg = <5>;
-				label = "lan4";
+				label = "lan5";
 				phy-handle = <&switch0phy4>;
 			};
 
 			port@6 {
 				reg = <6>;
-				label = "lan3";
+				label = "lan6";
 				phy-handle = <&switch0phy5>;
 			};
 
 			port@7 {
 				reg = <7>;
-				label = "lan2";
+				label = "lan7";
 				phy-handle = <&switch0phy6>;
 			};
 
 			port@8 {
 				reg = <8>;
-				label = "lan1";
+				label = "lan8";
 				phy-handle = <&switch0phy7>;
 			};
 

-- 
2.35.3


