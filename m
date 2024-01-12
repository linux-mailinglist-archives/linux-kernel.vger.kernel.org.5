Return-Path: <linux-kernel+bounces-24900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03982C46F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556E4B23020
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68817569;
	Fri, 12 Jan 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="PjMGV14W"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24100175A3;
	Fri, 12 Jan 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4OtyS4jjMfrkKkspchN3S45uGTK+h+0PWYb90mjXi6sknnLd9yxcYLlnZ+oAcYWOjI4vdnOZ9Wus3HuZdazcwxEb6LAYX8wEoXSxPhbxQtdV2rT2sOODPT08iXIAGS0BEh3YOPaWzyFjmy8ChKXZZ+iktOLw915D7ZBcqtCNklDBvc4d0UisYZdpjFp8kbTF6Pf+tLmGRiMuTi3+Cq0dQ7XHxHqAxivSQ6j0OzwQxWloH77+Pyi0bubQNPWMYG+ujIu+lH/oK7Xqyv+LHiwaq5AJvKaGWJZBNt+lND21Uw13669enFGlfmSYmO6K30vXlps7NUrkTZcRU4qusb17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=XB/UVLpMzsHIewGQPKS4ZJQH6f9ZKMCnLLgHVNZOEG6fQWOwJ+xqF/A5L2klRo2rUB36xzN7FivgnSkPEhSI3BX12fxoemWzbUTrggawQE88vaDjqqnk3YpeX/ZMCxb7BojV/g12efJiZxezDwrsKExup0KkteJKnnxjuOL3vpVNCcZbRC77+sZL4X6q16NX6FX9EmwnAPTuBBIt44N1QM6ClQPIe/wsy91Ib55naLXfYJAv/sGsRxlDlkQubYkIk+1y1VzZBHdGToJQgnRfytH8IxMsWYcJt0UlMPWsS/C7kJ0jgnCZP2nzKzbs4AfbavrC0BJWAwf/fakqh75vXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=PjMGV14W6oD9IkVUXt6InExr6mRJIxnv0AFA0zD1PEp0KMcQ75vIBwduWRK3hT8CBd36v/94z6dlhxBFaLfaduThDQrfvjaKE6mJvkn4XLWbGYOy7ZLrh/Al/0ewPWXWQEderkjwQmaMYrAI4rzglg0LunHG8cQQ2KLq/5vLomc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 17:12:40 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:12:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 18:12:26 +0100
Subject: [PATCH v2 1/5] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-add-am64-som-v2-1-1385246c428c@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
In-Reply-To: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ccceb1-d61f-4385-9d5f-08dc1391aeb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cm0fXe9vFCugbmgWOwmiSNduPxbsi2tWQQ0SrqfbUzitdlYJsetHqRYCnIvEUa7jJNHnYpTzUEJ1TF+KFPodWoM08iqm4ubf4EuLnl/Ty3f/PqSs6zrFibY11D8TyJia/GSw49p4w1CMMwFxMdSreQPTLTPCaYfewInK8gjlonI66C1Q6YFq/EcD5tqc/HDusNjgYtq+4akJBp9qDZn/0XNdqnq96Ut/EZiit8o0lP0v2+U0c8XCArxFwxn78MtEQ3eFFwcJt48DiB62bgfaN/MiS/WxOXwwsricZB3ZP52EmzmibjG4prdqA5tRiD/9wRpB/XM3wiaJ42ntEM0u/d5ur2qcxbiLYwBO8MiEGHrIrrVjnWYwUTPkkdcowWu7V20LeeNh87tVzRqZB0xi+qFAN7zBOF9ZmKegPXjBkimd+riWhzplYP2+P4svt7kvQJSbkDdViQCxZgxN5C1M5l6fk/aqEENQBiwmywqs8TreymLLmuO2XqPNGScWIKZBj/mzYV+pQxrs75Bfg9KcaicxUqSgLG1UJiSX5GRzghj8GVAmrdzU7QoUKp5Gx5Uc0NzdLxCZWZ1fnDR3FMoPWW3Hpt/aOw00Qhj2wy1/WH+nyjBgbMTJ6hAG9gy916WT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(36756003)(2616005)(26005)(5660300002)(6512007)(8936002)(8676002)(41300700001)(478600001)(2906002)(4744005)(7416002)(86362001)(6666004)(38100700002)(6506007)(6486002)(66476007)(316002)(66556008)(54906003)(66946007)(110136005)(38350700005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTNXU0V6L2pFd2M2N2JvZWRHQklYVm5SaG1SanpzWHMwZWVvam5CelhhSnB3?=
 =?utf-8?B?Z3VjU0tFK1IvMVN1MTQrMHhRdE95NFo3a0FiMjZoa1VwRjBIaUVJWDRQT1FB?=
 =?utf-8?B?UHZGSDhUSnBBS0lUR00wQVNsM3paU0VQYzBJbitLM0VLVGV5MG9uN3llRTNT?=
 =?utf-8?B?ZktQcHhLeDdFMy8wdUJmWHdOSVJwRW1BYUJOZ0ZpSUZaZlVoQWU4aUZ3bGJ5?=
 =?utf-8?B?azFKdHdQaFZRS01ZQzRONS9CVTdBRk5vZDBremRWS2p6MmRsR01wWWFYY3V4?=
 =?utf-8?B?RHZKVmJ2ei9DcW1WSVFiQ0NaZWNmNW5ERFZCQ1JQYkFDRGswNUQxMGN5MGZr?=
 =?utf-8?B?UHY1TzNzdXlOSFBGNnlicE1jTDhUSW9MemZGbkdvK1VIa1h1aEdIcVd1bThn?=
 =?utf-8?B?VkNNRTVvRDd6WTJYdStnVko5eWdGVTI1YWxmVkpwd2xlMWdhdThHTnVhRURC?=
 =?utf-8?B?Ukt6OVhoVFROTEltNlo1WllWaVdmVUU4Y3RyL05oRFk2MFpZaUxNM1RLZWZh?=
 =?utf-8?B?ZEpxOTd2eWZhQzVseEdzTzc3Y1lCQmVaUFZENElRSWgvZ1FSaWwyZHBQU285?=
 =?utf-8?B?ayt1TmxUcjJvMDR2dEJyYnlPSVltT21KUVlCaEphcjVpR2xHNTI1T0dJS2ZD?=
 =?utf-8?B?bHkrZHhCeDZpWHYvMnFqalZGTVo2YVpBRUJzbUM0eVdIWmFKZkRhem5QcXl1?=
 =?utf-8?B?RXNzVld6NzJ4K2JxOUZrY2FCZW5nUlZmMUpTTjFPbndSKzZITFJxR2pIU2Vo?=
 =?utf-8?B?OHI2YmkrTWp4dmtUTE5LT3ZKZ2pUMEpwQXNRZ2JUT0tMRTNQMTVzaUxxMmlJ?=
 =?utf-8?B?amR2bzZDWXNIN21XNVNqdmJHR1Y3MWdkdlR5NHdkK0FubnBiT25LdFBPMk5P?=
 =?utf-8?B?MW1SUnFNWGVxZFpteFY1OHN3ZElkdXpvSEVrbmxubWhSVGNKZXB6SElvamYx?=
 =?utf-8?B?ckFCSjUyZGo3cmxuNzQ0Skx4NTEwaU9PVytpQUR6bGdlOGF0eTN0bFdpU25t?=
 =?utf-8?B?Ukt6bCtVSmhJSlpwS09LMFVzVDk3dndWNnZ1VVE2RitIZkhTZ1gwQTI3Zkp4?=
 =?utf-8?B?amRuK01zdUFBY1BBSWVCQVpERHhtMzVpdkJLNnNXSnhRdDRZNzVPYUp0SGdV?=
 =?utf-8?B?elRlVWdmaVpOT2hNeVpVQjZaZm92Zi9RV1Z0cTU5OVB0MndlcTJRSXYvRzd4?=
 =?utf-8?B?R3I4RSswdE5QeGJZOXJSQ1ErRlI2dHNUUFNIcXpxTjdLL1ZIbjF4bFVYdThZ?=
 =?utf-8?B?NlNId0pPTnpDdGpjc2Y1bnhXSXhNRzUzbWlVQTZRQVNzQ2QvcWt5eExMUzd1?=
 =?utf-8?B?eHhsQjlIMC94b0hWWGY3TTFnSCt0ZGZLWDE3blRtNndhUnlDZ1JOQWhFemVt?=
 =?utf-8?B?NUM3a2J3R3VoMmpkOTRGd2RSa01XZGRjaHhQUVYvSlppTy9FN3ptSWhwakdY?=
 =?utf-8?B?K2hQaG1NVWZCQWU2UmZsbGl3YUp1RUc0eUtldGIyemQ4aU94VnNYMTM3d21a?=
 =?utf-8?B?ODVXR05iNUEzSVRvTUFWWFNCaW9sMTZsUzMxdE1pMjZCYWttMW5ZSk5QTHlG?=
 =?utf-8?B?T0pqeTc3bUR1N1gyZEJxbERHVVY5NlF2anUrOUFCaGZGMGNxR1lmS0RCRFFX?=
 =?utf-8?B?dTJCT1ZvVjdKOFZPQ3AvbkVwU0hkR241elpRL2phb1BlOC81WW1tNEd4d2Nv?=
 =?utf-8?B?V1FPL2E1VUt2YlpZeVg2NVd0TW52S0dsRHNUWW5qUFZBUlUxVTZCQkJxRWxS?=
 =?utf-8?B?NjlRRVM1cnNpNkRNOGhjcGJIZCtFNlYyd1ozb2hzZHVHUlM1WUVSVTkveFBG?=
 =?utf-8?B?dWpmeXgyNHo5T3k4QUphaHRzTHhBNmRKL3dkbnJUaDNzaGRiQU9Bd25VcjRM?=
 =?utf-8?B?SElZc0dadmdNcVlTTVRVbEZXVzBqUm1vZlBHUTZ0aVRDSytzVXJhQ0ZmV1Z4?=
 =?utf-8?B?d25ndFlkeGpZUzdBaEN4cmVDbWdHNUVTR3dKbVdkYi9tWXREZk1JOE1ZZGRK?=
 =?utf-8?B?VlNZdmtKSUllZHFzekVLVDlmdE1aMEFmWE94ek5JL2ZWU00wL2hVWmJUUEZX?=
 =?utf-8?B?VWNQU0lpdklwajJhM2lkRFBvWkRZVkFsWWsvbFlDTmg1Y1BSemJiNi9aMmEw?=
 =?utf-8?Q?xwk7L8L1EHI5ZNRjuJRMgxmZl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ccceb1-d61f-4385-9d5f-08dc1391aeb8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:12:40.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYSkMy2tRSDnGhyNxoWiUlQp4qLpFBFMeD5fsmtNImpXz5GrBPNYbBY7x7xcJyzfOhxhPCLlUnOO9YIwXzALdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


