Return-Path: <linux-kernel+bounces-17058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6F8247BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2277B1F26F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5528E21;
	Thu,  4 Jan 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RVO3W0N3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12A28DC3;
	Thu,  4 Jan 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSDaichh8v+OQxmudyBh0h8p55wxI2GcLKgZVdTzJdtupatpnb1yICgFo3oefXiQlwmTmLvQw1TMxwioiAFv/ORkXxpbPPRjwtCzUF7/T4AKHKokYNVyxOMuo4Aa0Z93dFeLhYjdlyN6VLZy0z0W9y7EC27PhzaMV+7tt/ZDfc8oip5NCeah6nOD6vRLwkGwYZ0h3X8zcq4AdazAJlL/2oqscdLrwXw85FNH4mrh43IyKm0/Cw50bi4WsL9fTyKr8wNjuSUJFWl1GDj7f9m8YtUCR1O/9ygUB6Rp5KDenbSxoppInqznzrDiqTdUJSekUDF5dnCy5Oytl89G3hGcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZMh7FfH4jbyi1dDMTMB29O+GMdZq52dYq9LPTt8IkI=;
 b=OltJNcEmtg4VjGFR13N0JuHcqfp24VySxmmm37+Q9/hXy+OUOGH70R1I3K4GBjvjBbm0GJMNhmovxp0xK82N6JLu2kpmKpTAXE4YuPk/onGe5wxzzwyFjDlAV68qk2fiq7NBI4y3+2RCru1p4CFVfLy9o4t1Xb+f8AHTsdS/L3ExKhRZMWL+kqZLIc2RF/M5xnUVlhdRVXbsGUSInlybijz++nk9J2mnsF8ymssy5+bFVuoDH72An2JkXVY42dlIF5stOs9Ozpd8C03EvNYAkNMArx0jhpKAp/JVOy3TIe8vVhz/ZdZI8YssxZI1U3j74U7LviTdiCBr8K8BhiX4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZMh7FfH4jbyi1dDMTMB29O+GMdZq52dYq9LPTt8IkI=;
 b=RVO3W0N3dvY83PDDShbuLu3X7JXSdOKcznwNKHvs/GQATwYHcNRwF/R1psoHxUmZ4OOsSOv+T22jXIv8FbTpEtEvzhEKAhU+jsJfvPLgNF+EI//Bj1E4PP5XT2DMXPQayGAXzdmDKVIeiglqFwiGN/NYaQgDgx8uXDPoDXB976A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 17:48:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:08 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:03 +0100
Subject: [PATCH v5 02/10] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-2-52be60fc54e3@solid-run.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9a1f3c-495f-4023-07e2-08dc0d4d4f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	10jXO8qlcLWO1gf91rbWVsWbwOJDy8/+14RhH8w5ssIQbsUMajt4B733ZOZ3WSGYq/d6ZMSJucAlBRy1xC1ae2o3csTOY15zSI9xDoPUFxHd/ycuOUFGy6qNxpnCqcWKvij1IO6TgxsnoPVaK0hOm1wWGhBQlzARoaMUrwFkof8skET7vTOi48IgIkSFeMBeqe+eAsdnCawV5oGN1zvG8SXXTPzeoBI35H8PTu5Al17GjuAVBcYQi7wWvGjLN8o2ypCVDz7hyAuEO7PzatrqBdXTypiTZD28idSDe2OQuhD5ic74tcTEeHGBJW3x1LfrDSo5NkfOOQMDQV0LA3uXPQsi6c9X9NoIglwJ+Ik5YmJrtBSrSG+kl1S8xYMSN/pSbiTBp+wkO712B8+zk+Tdeb0Ze8W7m26MXVyIv8DW6r0ZNsjfzFCbxWz/3okFwx0zENf6bVA4cdjulBao7y3PuxmtW4xC11+GZ9/lw4raQKT387H4DkPbJwIN74LVuseb/UG1j1uwDMBaZGKbuxhmUtbm2zDx6/ddC+QAK14vyEwQN0/iaHXOsLtJyGB2oSf9spb+CNi1ns8+o1+rl380B3K8MLgtebxhEzEEKUdw4romk5atFwSw0bDOBP4popAX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(6486002)(52116002)(6506007)(2906002)(8936002)(41300700001)(4326008)(66556008)(6512007)(7416002)(66946007)(6666004)(478600001)(5660300002)(8676002)(316002)(66476007)(86362001)(107886003)(38350700005)(36756003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0MvcU5MNVZieERsZ0c4SnQ1RlBzQ3hKdEZJSDljaldhaEI1WldsbStzSUlw?=
 =?utf-8?B?ZTZ6b3BGSjY3TTlTclYyZUx0UHZqb2lvTFJOVm5OMjZaeTFKT1ZKNjVQNEtX?=
 =?utf-8?B?VlV1Mmp4cFExd1l4alVZV05TaUZiSVFsNUpoS24yTlNiT21xWStVUWNpc3NP?=
 =?utf-8?B?dUs0NzhUODVYRFpRYXF2Z1BNaSthempaMEJCUG9QT3YrL08zM0VEMWUrdXQw?=
 =?utf-8?B?bUlQNWNOSVpvYkVJWlpPMkI5MHh3S2hZZDJ5VXcyanlrRk9SMVVnWVA5RkZJ?=
 =?utf-8?B?bm14SlR2Q1duSkllZUNacmxGNVU5WjdCZGFjWno5bEFlVXN0aEM5YVV5SDYv?=
 =?utf-8?B?QzFHcWtid3BkTkJFcnpseGduRVJEdUoxbDl6YWhkb0RicEZPdldSSTQ4cVVr?=
 =?utf-8?B?cGRreHlaWFNNTzE5SzExYWV1YldKTUtUUUF4cjFOMk52V3RGTzZJUGhJZHE1?=
 =?utf-8?B?SXhMRGJzWlUxblRWYWVmVkZDOGxsc1pDTzA1QUk4QzBvR2xDYzZrWjBxM3A2?=
 =?utf-8?B?ZVVEUDE5Qmtmc2tvaGRaTHJ3UWhjK25pa29jTFBaZzRldVNpbUI3OXV2Tm05?=
 =?utf-8?B?RVhLUG4vamxna051b09yWHlmUHR6Um40K1d1Wk9sUTVTRFQ4dCtFVmVRdHo0?=
 =?utf-8?B?Y1VzcnVPTnhjTGpLTUhEWXFVcGVqb2ljNzdYellaVW1FVHYya0RpNVZMMTI1?=
 =?utf-8?B?UW1SclBuM0pZdFphdFpMdS9JUGJUeG1Oc0xLYUN1dkJ3Vm53UFdKc0NRT2x1?=
 =?utf-8?B?MmxHUFFmWDhSNDRydGtrVHRZRTA2VmRXMG1tQmVpOURJaG5XeStCMXBOdy9D?=
 =?utf-8?B?U1ZjLzZSKzFsNndXTEpOaXFjcDJpQXhoRktPSDJzWTNTY3RxcFZzR3c3NDdx?=
 =?utf-8?B?ekEvRUNJaENZMFFRaTU4TmRNajdhSUx5TWRqTnpnV2xTQWNybEcrUnRBMVpJ?=
 =?utf-8?B?SHVweGtqalFSRU84WVcvSUhDaWdSdnJmTlMwRkNoMU4yV01uNVMvL2tScHJG?=
 =?utf-8?B?V0o2Z0hWS1ZIaTJhTkh6WlQ2cnZzNXRKVXZyZWVDSHVsMExxMnpXbU0yc1JU?=
 =?utf-8?B?VnFwVUk4V0xwRTg3c0wzSnBycG9FK0IwT0trZTFBd1VNb1Z3UTJVUW9iaGR6?=
 =?utf-8?B?RFUwNXlOcU1KWTVXZGRneHJuc3A0d2hjWE1vL3dHc0gxMGQyL3JpTmRpY1lp?=
 =?utf-8?B?c2U2a1dIbkRLWEJkUDJSckZ0VDRnaSthQ1FWOHh4Q2N5dm5HeEJJcHNwd3BJ?=
 =?utf-8?B?emdYS2JZZndWMjQzM3pmMkQzVTIxM1ErQ0hiNXhvbC9sNDliUTNFMkJWR2po?=
 =?utf-8?B?WlNjQjI0NytaZWZZZEZwdXVNaXhIRnVnV0xGeXVPV2lPTklkL056em40eFlj?=
 =?utf-8?B?bzNOcnlSYXJSNjVwYUIzNkRpM1ZZMFljOUVobEQvQzVXTmlTY29VNEJBTXVS?=
 =?utf-8?B?RnVJVlhLcnZhaTBnak13b2Z2cW9ITDIyZjNhK2lBZDl5bjBnU3dsT2I1dG9j?=
 =?utf-8?B?aldEUGc4b3RMOXZtbTd2clY4ZEIrYTVzN2NObUtJVE1NMmhEMGphYXZBUUpK?=
 =?utf-8?B?akhpOWdCeFdxckYzRllQSVJPSHdsSDhCQXFsaE4wZzJiRTdGeXVTQXgyczEv?=
 =?utf-8?B?YlZFWko1ZkZIK0w0dUh2b3BtTnJWWThkYjRoY2pPUGF0bjl0bWROUmNUYTdw?=
 =?utf-8?B?RGhrL3VxaCtYaktlOHViMDU1UHdaYUtWSUtuV0NqTHQzblFlWVNDNmJqaUc2?=
 =?utf-8?B?UHJiMDA3QnZRbER6ai9nbExJdXhrZXZZNkNkS0NkN3dFYTJtbGlJd1djNHJj?=
 =?utf-8?B?OWdBUUNwbFNQSk5PR3BMVW5qTUJCS2F4YTNBRC9TUWZDa1JLcE9WSXF6V1pm?=
 =?utf-8?B?RmkvclpiRnNwSUdGdENlemQ0SEtKSTJPMzlydkludm5Yc2Jncko0bWtYTlJm?=
 =?utf-8?B?OG5NT0x3RXZvSlF6NUVHNzM4d0h1c1EwMkxBcmkzUFN1Uk9GYk4rVGRTdjNJ?=
 =?utf-8?B?YU54TG53YVR0UjhmV1loOXJiMFE4a2hManJyUS9QNHk1NWtkSExmVllBUGhZ?=
 =?utf-8?B?eG1xTjhrQ2RtaTc0ck9nTXhTVkRjOGJNN2xKS2lSUkdQTWsvdkRnbHYxRjZJ?=
 =?utf-8?Q?/bmZFc/X8rKs/VNPQblFrhDs7?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9a1f3c-495f-4023-07e2-08dc0d4d4f25
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:07.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkuNR76/B91i5G7nuUqwdjzNaHpozdOmRELD7aHMqlnc/yqp51mpG7m8FGWtfwhLmefzbpE7P8HpliPjkGnuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Add DT compatible for SolidRun Armada-388 based Clearfog Base and Pro
boards, which are already in place in-tree.

There are already 3 distinct dts in tree for these *two* boards,
declaring particular compatible strings:
the generic "armada-388-clearfog.dts" is a legacy name for the Pro
version, old versions of u-boot built when only one variant existed
explicitly boot by this name.
The other two add explicit -pro / -base suffix to the filename, these
are preferred and chosen by latest u-boot.

Note that both compatibles and model field include the string "A1".
At least up to revision 2.0 of the board, this had been printed
on the pcb. However in marketing material and conversations it is
usually omitted. "Clearfog Pro" and "Clearfog Pro A1" always mean
exactly the same product.

Technically Base and Pro variants are similar enough that they can
successfully boot with each other's dts. Hence it makes (some)
sense for them to share the "clearfog-a1" compatible.

Add bindings for the explicit variants -pro and -base - including a
shared compatible string between the two.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 108d665220b5..f4e930d8cc26 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -39,4 +39,15 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description:
+          SolidRun Armada 388 clearfog family single-board computers.
+        items:
+          - enum:
+              - solidrun,clearfog-base-a1
+              - solidrun,clearfog-pro-a1
+          - const: solidrun,clearfog-a1
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
 additionalProperties: true

-- 
2.35.3


