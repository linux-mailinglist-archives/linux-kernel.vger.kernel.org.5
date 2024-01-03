Return-Path: <linux-kernel+bounces-15442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA33822C10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1321F2401F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5F18E2C;
	Wed,  3 Jan 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oxMeAMCP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CD18EA0;
	Wed,  3 Jan 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qpzl/dfsMDDpIaiyONv09spSWC148Oh7DceBlnVRoX2ygy5fmi5vsXm2L1y1Zg5w7h5b7NickaT+TD8Xe36REoNWvrn0hKWApR7C9186Qds3dQbhXdawDcikScvHGT/88DKOIt2EM7gGPWjaBAU+Cno/QgTPFc0U7ru4rNpJnu9C6rntBTJHTEOo03RRxBC4yLQ+XLvRNfRxCN5F9Sz50mBgkULnqe1dd5Ixegv/cbRDMFz5W1FowCDAMZXlUEWg/DS9xjIPUaJSlwei5NzNyF4r/Hdd/dTmg0E3noz8lKNbGOOHdd9vl9J1gjljTIUtMiIv/9fuQ3CHSqu4BUmQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6l8pS9eiwhWVBBJ8p1EGzbZJhSujyezmFKXITPRc9A=;
 b=NqkgG9y1bB7AZ8PrfPCE13WHyvSXyqMcU/0D87mBXS3aCuvVMzvxe0cryskjKIpNfEbPE/yAiyVvrgJQARj9mYiC/SFaXDLdixtFJu5hHlH96wxAcodT3eOKZ6snnayMwWM89IbT4LGMfnQjFHSeI0qp2/7iBIIO5vPVWNfuOmIJJ4qkDQ7x63Zsqf1PLTP0H5GAVkIYlrNkTuCCnBxy93JlaX1XfBwTw81hItXhdnhcV9Dazk4WlES6C32QuEI6NU7Dsku8d4rKnLrYqpAsDRKBYNrEvPplMDDMlAofh2h44i0aMnNRyHe//s4ceoa4leaQ01G8cgKlU42yPU24yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6l8pS9eiwhWVBBJ8p1EGzbZJhSujyezmFKXITPRc9A=;
 b=oxMeAMCPX7ulwvzkieemLdf+0uSp6iPPAzeR4RUKFkPydWtHAHnV0ZhOyEdNffzycGaFHfd5p0ifjZ/R2rrvU+ocMDcdZNoThZ+GvfbYNpNKv7e9nzpuuwxpwXKmyxj2zh3k+L6CMfuehuvKC2792HS97W9udN5VVtyrgUGka/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 11:27:19 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:19 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 03 Jan 2024 12:27:11 +0100
Subject: [PATCH 1/5] dt-bindings: arm: ti: Add bindings for SolidRun AM642
 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-add-am64-som-v1-1-dda1f9227aef@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
In-Reply-To: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM7PR04MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 051538a1-21e9-4a73-2439-08dc0c4ef27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ewbWxn+CLNd1Jg9R3Y2ZQv9CW9Q8yoztCWzKa+ieVjBBqMiY1ujr9yUeoR/nAjCABkxAiPyTEZhDTL07RcuqEdHOEQ+CuxvYyz/MT2uR7u1u90KiNwoN2iXT1ycTeyFSyzpFffEFfLb+EpR0vtW+RoRWxjn/EHsr6Mwa4Law4ZPzVysN4PRn1cNuOIFS/jB/dK0/+jJJNxxTL7SB6Yirqzai7EBw1ZN6ZIyrYgTRhiAqKUEq4Pnfpojd8MmMhxVWKGp1jVaISvpJAxLdwMibBj+DMCrN9oLHUqzaVmsnJBjA79ikHLgBD0ZPsDgxy6d6zDdZX0y9tWfGDo1aRK+SOwZo+x5kxDGWwJvC3DdcozGsap0FqPtZMCCc3joyfZA/e02fED9mPPmQgBgteAQ9ZcbnPZQjDXNDt6dyBHSvx9Q3UUIEdls1mp5bcuSpFJOAtazN15qT4kkAg9uS6FV5otX1UiOcpjHdFgpwcL3quxXwEOQSvt26MUj9mvW2AjpefvqpMXDghgdXOST0vAwoQUu6ak5gCuwNMFra+pImHH/IB1zo+p2rsRy6Jp9hTD1IswgT7Udf2vYYxeqGKzFZTmwVdGMCQ5G7wYFXcwxj0rjuXNPkss4uhZ9w+5VKsFYK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39840400004)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(4326008)(6486002)(66946007)(316002)(478600001)(110136005)(8676002)(8936002)(6506007)(52116002)(6666004)(6512007)(26005)(2616005)(5660300002)(2906002)(4744005)(41300700001)(38350700005)(36756003)(38100700002)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0dXYUZ1RURwd2lFSUtlNlFnWXhvL0lxazdwWk9XWi9ra3NzQUdXZXBaQ2tl?=
 =?utf-8?B?OVNKV09DWlNsNHBrZW9CMEMyb2FkZ1RqelllNEFsTmpSNkwwdzFVc0d3d2hE?=
 =?utf-8?B?Rm0ySkg4MGlUa2JWbnVPV0Q2akh3UGR4cGJPTUdHSDd0RWErQTFyWmZ4allr?=
 =?utf-8?B?czdKYVNvajVPVkNuZHgxb0cyaEEvdkM1Q1hNSU8rbnd6WXNyMUpsdVI2NnBa?=
 =?utf-8?B?MEZQUWRNcGFUYkdLeFRKL0xQck1OY0ZsVDR6RlY4NHIzSXRUZkJNM0xvUXJL?=
 =?utf-8?B?WmtYSGpjNEZ4Qkt6aDE0UENlQ1VWRzZncUU4ajVrWFczMDJaUGl3aHpZVXM5?=
 =?utf-8?B?KzYzdnJPR3RpeTJ5NWVPY3F3bWdNczk1c0NoYzRJemo3U2VkRndJeUpNU3Yy?=
 =?utf-8?B?N0pJeWVVbFJ1Wm9TR1F0RnFZSS9ra1plcDBFNjhuTTJxcUdqR1VnYkJnM1M0?=
 =?utf-8?B?SnVBZ3grcHdnRHZyT0xjOGE5dVRreU43bUVGUTRRMDF2OEZoQXppOFM5Vk9r?=
 =?utf-8?B?RUQ0eEJNOTZyVFhhMFdNc0E2WGRRQjJFMDNrRFBxRzFWekw3TFVrVnE1QWts?=
 =?utf-8?B?bVVxUDBCWUhzdk0xNHdTR0paM25kR0FlTHdVNnYwRGExR1R5dTA1RGVGR3lM?=
 =?utf-8?B?OXVVT3cxeDRHV3dTdmVaOVRUZ05KMkx3KzcvU29LMEVmSmU3SmRBMlBZaENx?=
 =?utf-8?B?R2JxbEdkYnZkRnovakN6bTAxSHh6S0owbVdaSWk1K2FFWlk3WTRwbWdlRXdK?=
 =?utf-8?B?eEc0WGhSWTVqK0k5SGt0c3NEbSthWHFHMnJaOG5JOWQwQStrRlYyUWRVVmYr?=
 =?utf-8?B?b1NlSXJnUllUT0NsK0luQjU3N01uU0lBeko1ZWdja3EwVTJZaTlJUE1ZU1ZU?=
 =?utf-8?B?ZFRMV2RsaFE0c2drWjFQaW5uMStRNnZHOXc5YjhwNHlpVFlsUDFyWFlpQlpn?=
 =?utf-8?B?QVBVZmxlZ2VhMUdIOEt2aTZPa0gzcWZLeWJhSU92S0tiblNsZ2pnNVd3Vml4?=
 =?utf-8?B?b2tJTWdOb0t6V0hoUTZxWlpFS3FNSUJiZzBPQVIyZUxjNXltakVaTlQrdVBa?=
 =?utf-8?B?Sit1akRHVkNRS3dlTXhXaXlZSTBxQ2tTZmFEYy96T29yeEhGUU5vVzFITXZa?=
 =?utf-8?B?RkV5aDhGd0xEL1YwZGs3d1JYYTAxQ1JJQTBtYmFON0czM09zS2NBYXlkTVRH?=
 =?utf-8?B?a2h5TjgwaDltNmx2dXpKS2hkWXJSL1NWdUc3SzN1UGgzRldpMDBoTUx5MVlt?=
 =?utf-8?B?aWY4QXF4S3R3UnhOakhYbHZubGUxUTJodEkraGFrdUNray9mUm1KOXdXUXlj?=
 =?utf-8?B?Tm9pYk9WT0dGWWYvODhFSmtLaGI1OW56ZTZpd1B5UmlEcmcweDNVS1FRci9x?=
 =?utf-8?B?SzNMdDM5Z1U4SFdoNytkeFE0eWJSa1czQXNEL1duTmhWczZqZkFWTm9Bcnpo?=
 =?utf-8?B?SHFOVlF4R0ppY2dRVmZoeElFQnBOMG1WU29DZzBWTUtDUzU3WFlidEI1SVlX?=
 =?utf-8?B?b0pXR3B5RnZ1VHdqRXcydW0wQURGV0hCbitqcURpY0tVWU1rVXYxbFVCQmty?=
 =?utf-8?B?YjBRK2JlSWZ3eXdqdFdYWVFNOFA2THFlSGJ5L1ZyZ0N3bUFLdW83MEg1SUk1?=
 =?utf-8?B?WTM4V3RvNjg2M0RNczZoeGxwY0VVU1BiZU81dUtXVXVMeDBFVnd3T3N1M1NX?=
 =?utf-8?B?T1NmTnJnSUVvcWtORTZ3Y1JyM09UUE8ySGZncVlOZWZ5QTNXWWl1aUQ4aHpX?=
 =?utf-8?B?MEM4NSs1NVYxaVdtTUZCbkR4RGhlNGxkK0UzM1BqdnRoWnlPR0xFYXp3NVM3?=
 =?utf-8?B?cUtuUjhLS2JqS3plcHNNV3JTL2h3bDd1azZFcCtLU3krOTJUVWwwRGNmWjJ2?=
 =?utf-8?B?eEhiOU15akkyTjN0SlNXR2xMWURSR2ExbStXSTFmZGZ5R2didzBxS3diZFpK?=
 =?utf-8?B?ejJOeGpwYmNTa2cvOStnL1p0b1ljTlp5b0poSVJ1RlpUMXBlTGRpYzRpRVB5?=
 =?utf-8?B?RC9CN0FzelpFTUpRZzl3MjhobmU1YitYQ0VpV0k1MGtQeVA4NlJZUjBuNEE2?=
 =?utf-8?B?QkNCbUdjaFB0MEk1bGc1Q1BjMmJOOTJld1FJMzdSRStVNlBBc0lEbE9VWjhP?=
 =?utf-8?Q?TLhHe7Z5stJV5zoE8c7P2f3YQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051538a1-21e9-4a73-2439-08dc0c4ef27a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:19.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFalbUbrHP4cO0/0v7sWT36nPEQ64l4945kF77iT+FySUP+iasejklsUo4sTLKti6BCG3Hy3weMc4puoN/J2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 03d2a0d79fb0..b9f2a8d36874 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -85,6 +85,13 @@ properties:
           - const: tq,am642-tqma6442l
           - const: ti,am642
 
+      - description: K3 AM642 SoC SolidRun SoM based boards
+        items:
+          - enum:
+              - solidrun,am642-hummingboard-t
+          - const: solidrun,am642-sr-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:

-- 
2.35.3


