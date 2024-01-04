Return-Path: <linux-kernel+bounces-17063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C08247C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910441F272D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7302C846;
	Thu,  4 Jan 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RJuKkR6I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8428E25;
	Thu,  4 Jan 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHZZfwLhFEpybVz5ZPYdXQapeCyd6LyMAH5hcidA1J9876S9/A9HmHKmKQc51YnH+3pEkqzxB2GuDyiRFV3sapkj/O7rf3E9QbjcDbLePlETt0BkwkzgzTC4f6Igpf9UNgn/gMNgd7bLQJ8b+Lztj1BLxuvENtWaE37aZpqyM+ygbffPt4KBDFxpDT7haZbNCkmz+7tdxMYfga5MRe29lyD8SgwgvheEYsNu27WQ6G7W9ihP5sLRccts8NxyOZDzNSorDCPsDlr5NqUgDoGUvXcTlvOs7F8wTqpHBtahaVu8q48QAuZBduFAjy+3ZhVK7XKkcpIdoE/PR7gYq+xMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFmZllzHlSUDCDKuNhPm4LKlMrCNc6ZRhQ/e2lShv04=;
 b=D9A1X4qDrJFkNaBGl0TJGJhKJK4R2VZOd7ymdWi57s5HPrJkpMJ8YYHnNk6+mlByv/44DuopyVTGN9Vy54LTB7u6cXUEfcAp6Q/JBKYHNgbALTrLxWu/LIkvcQ/rzee/XZd8dh0itaKg/9XnVJMT/rLdBM3xdJ+hnKQ9IH+/hQnARjr7n24gaNT4Aohw/NWSdFJ2V+titp2iLFR3j1s0b1D3JLZ+UHV1tbSh0n+2Os/nuzyqZBYURDe/5XGc1gOWH/ItES2TBYYTfC2UU7C/UwdGt3E94/OcnzZ4xOug9oKFEvPTfCFNHSd0VXaQzsw1p7wrUer6MyQmmNxoNcy0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFmZllzHlSUDCDKuNhPm4LKlMrCNc6ZRhQ/e2lShv04=;
 b=RJuKkR6IhhtWegWklGc3kMJ7sw2hEqU3kU6eLg4/w7C3fJ56KrjJNhayokjPfEr/f7UyVofDUkNZFADiSpL0GCfg3U5QfjAc7lA/yvowDWNPKndw07faE9xLXaWjToKbXUnyV0UChxCX9mIewlAFq8Te890V8e2agoesbATLHII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 17:48:09 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:05 +0100
Subject: [PATCH v5 04/10] dt-bindings: marvell: a38x: add solidrun armada
 385 clearfog gtr boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-4-52be60fc54e3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67da69ce-8232-41cb-18d8-08dc0d4d4fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMuwS8kzSqhkkDhXwUS6lR/7xxzxvouxqzLad0sit/hhTJxxHyfzFoxmYP/Jf8SVTB9WfbEK09oIkUfHMLDbTZ2jyY0nitdnnLi7QFRDeXg50Og10X9C1ylfVyURJQnCNe5Nr7GJ5Hx5tLsOo6AtL5UW9hOk9VDCqozYDij5azIXw0EDtCyoL2RliPxZAMr+LTfTQuHci8o+nYqDAEZ/4ZV8EaoT2iAf1xxQ2k5T39Pdu3bmvF/T1meAQQJUsOMbq+WgW3StFeo7g6/hmURgglbeJQhVEYWpF3HnJ2dyJA/Ipaolu+r5LHb9SP10w71kOcWRHYbSQDezoQC6cQDxE25/m5krbQ/pATw3mUbU5whwk/JfGcpzr4PEuBDnPl9L+FlxXjHkT8iOwV8uky1AMwiPo5cA61IZmK+pnjcZk0HUnMRPCXI5e6kTrHXaw/MwYIKhSejP5w05yefCe7Rtqq2vjPOeZfmpJQXdx7LsoUlnqCQ1TLzYiRr3WXnoFOKx4N6uCU915GLIixhfvM88MxsSqLdUdEQKESOGB2UbxRJvxofQsoOX6NURFOqExuueMGcYt3pyAnfh8YY5K79i3t15cJ8+nfVn11PpAnELADiAnS14GxLpQSTRZYPti+h0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(6486002)(52116002)(6506007)(2906002)(8936002)(41300700001)(4326008)(66556008)(6512007)(7416002)(66946007)(6666004)(478600001)(5660300002)(8676002)(316002)(66476007)(86362001)(107886003)(38350700005)(36756003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njd4aXdxMEY4YjN2MnFUaTBPL045QjNaVmpkUHdiMGk0akN2QXlvb0dyTy9r?=
 =?utf-8?B?a2pRdUFjSlFYeHkzRDcxYTRBL21rZFBxdTFReHE1VGtEbUNIdjBTSStDSlhs?=
 =?utf-8?B?VUZqbEhDOUEvRDRDUWI4V2hrNCtsc3ZBN2JaOHM2SDNTZXhETXpqdU83ZURK?=
 =?utf-8?B?elkydHJaeHBjZHF1WG1UZ3pKSXlILy9tNnk3am9wZkg4dTZ3bXlzWDdyRW5F?=
 =?utf-8?B?a3NwRmxIMDJ5cUQ0MGwwT3hlVFNmTW1nQ1huMklsTHdSQ0VxU3lzRmVqNjVW?=
 =?utf-8?B?V2I0N2JJcDQwYWI2RnJuOWNoTUlvYkdvcFREbUxoMWcwRGpwTVVRTE5kbTY3?=
 =?utf-8?B?S2lPTGQzQ0xGRTJrOWV6RGZBSDd2OGQ1ZFBIdDc4NWdTckRtNU1SMU5pREw3?=
 =?utf-8?B?ckIycW5FYWU4SFNCOXJJSTRPSHdta24rbWNGb3NUUURRZy9tSHpxOUNLMk5C?=
 =?utf-8?B?dGw3YWh0Um5OQWRUWTEvWkpiV1Z3dkpBN1Qvc1ZSeThUVDJQMmtmN25kWUJI?=
 =?utf-8?B?VWlzSlFsZTF2RW51TFpETFJiTzBPWVhLTjYxd3lpVVVYc3FEKzBjSXJFOVhm?=
 =?utf-8?B?MUF5bGNxS0kvVzJhblMvQ3UvQ0N1S1Rjd3NzdjNWQWdxZGNnbnRVSk1xeEN1?=
 =?utf-8?B?dVZDSTErODU3T2xuNE81Mnl3Z2Y1TGRKd3lCOGhhQ2Q1WEJuUHM2c08zYzgx?=
 =?utf-8?B?OGVhYmxDZE5vRXpHZGJRa1hTcEJYbmhlWEprdDVQbEp6bkRnUzI2aGRqc2JQ?=
 =?utf-8?B?bDFueEIrY1liM28vUlZwUzdFZkkxMmx0SDc0U3VveEcwRkJxbTBVWUdhVFJG?=
 =?utf-8?B?cE10QktQSFloZk5rRkZqZ1krbklHcnFWeFQzSzFQVzZHSW8xWnYxTjExRHBV?=
 =?utf-8?B?TDg4emxDeTFGMWxsSjF1ODl5ZDFwWVJNK1dvR1dkUTQzeFBaWGlQU1NLQ3BZ?=
 =?utf-8?B?Rm9ZMHBjQ3pXYnRZWU1wZlM4Y3pPTCtXVXQraitlRjhEbktpcnN2M0RVYVpQ?=
 =?utf-8?B?NUlSQ0t4NnNHZDllNGI1WWw5eXd1Rm10ZWQ3bUV4RXFLRlZrR2MxRGE1bW56?=
 =?utf-8?B?VytZM2FCZ0FqVWpSK0E3NDV2Z3YxazFIWmUvakEvOUxvNlNzU09TVUxZejN4?=
 =?utf-8?B?VlZEZ0VpZ2pwbE1jRG1BY0FXdkFFSTJ1ZWp1clFkRXNZSVhtUDN3WUxqemlK?=
 =?utf-8?B?d29ZUFV3R2szWVNQd3pmWVJvdmVHdTdjNFN1azNwOVVPYjQ2M3BzNjVwTWx6?=
 =?utf-8?B?S3pRMWtnRHF3cDhjSWtKWmxhUUNDc2d2bHFMRlVnZ201clozTlllcGJCYk1I?=
 =?utf-8?B?KzY2Y1BzU0JuUmkrZU1kRThzTUM2ZnFhQ2xyVWk1T3Zjc1pVOTdFUGxTeTZy?=
 =?utf-8?B?TW44YnBWM1Y3NzZBNWpsYWhIZ2hzT1RxcUxvS2RVb091cHpvY3pCamhxenJs?=
 =?utf-8?B?VVI0V0s1SUtsSG1PWXlUU1kwR0VjWmNTdisvS2JpNU5oSlcvL29sSTF5aldB?=
 =?utf-8?B?MVBqRUZOMUxoeVQ4Z2JmZEtXeWZqV2drazdWZEk2VnFza3VmWXJXamhibWc1?=
 =?utf-8?B?a3BXZWFkVS9obEZCMlJudWdLQ1JYMWlCeWpsaVVTR1RwZ3RKSlJQVU1kalNw?=
 =?utf-8?B?aDZLVkZENlBhL3oyZ2RoNmIrK2dKeHpHTEVtWVhjV1krU0tBM1lKRDY3U2My?=
 =?utf-8?B?UXJBaHNXRmNZZmFxNklzRXp0dFJ2Wk5oa1gxeTlxR1RLT3pVcnR5bDRDYkFt?=
 =?utf-8?B?RnNXWUpTSjZVV3lodHd1b2pta3NsYThZd2JmUjcwc3UyZWpDaHBHZnRweDha?=
 =?utf-8?B?QXZNYXZoeHdVZUp6YlJ2VGY5TXR3Z1NkNHdoWVBublZaZ2xjTENncFlDWHdn?=
 =?utf-8?B?RExVcm5vR2tnemhqK0Z5c0pNZkVXTmRYMnp5VzFReGxla3lKdThqcklmYnRR?=
 =?utf-8?B?VTE0MzEzM0tNYjZoeTBQZ2V1K1BDYVRBOThkUExpbDN3aW9DcVRkZjM3YXhw?=
 =?utf-8?B?aDZmTDVWN1hPb0t2WXhvQzdXajlPS2VMY1BEUU5SZmFva24yaWVJTWdzV0hY?=
 =?utf-8?B?SzROVGNUR1E5TDAyRm5nV1pNdjFic0dkN1VDdVRtMzRLeVM5SEcrcnh1UEov?=
 =?utf-8?Q?6T+NwLy1ArJu8nY0tIz+G/neO?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da69ce-8232-41cb-18d8-08dc0d4d4fb4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:08.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujiqhrky4HLfqE/M6AvkYC/ZPYlxwFpv7DaVCBNyra8jlLfOtJjMweR+NbooOpT6DJmL2NolaKTzF8xcyFVOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Add DT compatible for SolidRun Armada-385 based Clearfog GTR L8 and S4
boards.

Despite similar name these two boards are designed differently from the
armada 388 clearfog base and pro, they only share a name and general use
case.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index cd5e5f88d8b5..cdf805b5db95 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -30,6 +30,15 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description:
+          SolidRun Armada 385 based single-board computers.
+        items:
+          - enum:
+              - solidrun,clearfog-gtr-l8
+              - solidrun,clearfog-gtr-s4
+          - const: marvell,armada385
+          - const: marvell,armada380
+
       - description:
           Kobol Armada 388 based Helios-4 NAS.
         items:

-- 
2.35.3


