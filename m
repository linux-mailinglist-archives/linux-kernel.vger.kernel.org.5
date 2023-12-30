Return-Path: <linux-kernel+bounces-13468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D240D8206FC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDBF1F21C12
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6214AAA;
	Sat, 30 Dec 2023 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Ku8ipLCL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16DC8E0;
	Sat, 30 Dec 2023 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEGCNhbtzikaKpsUE2QIhqIIUuD/EQixEeromo/lTgYVrIP8u6aX7ZWC8gtwUMbD+vVzcCC0ogOoHiPA1sDfWuv+Vm2ieIXQOrbBL/HBU5Adx8khr4y6E32pY8P3SGMzV68s+p3nC3LlqCXOPoAFMn6f2ZR6kpmYApBFwleLpbbwdPg/2GRUrIVodTYK/0CEIuAb6e7NTzQzwyf1+3pRJH5grq5PJMCSG/VSl5rWv6Sj6hHFdj+OcxjMC2HzC2YDWDOLJ5dia81bycXNQ9hsdQVidbel8Syk8UNuID4po1aA1IUGKkYbNcAgedZGhtzWtb6KvukaXLjW1Pn3B/Gubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42WnqD0/4HuqWDFVsN1eUAvjX4GJphQJ3fdFZ5K9Ags=;
 b=lJf98C0SKOFCyP6IgZwb0xfp1hkiI+1f6LjzL+DQakConYfcC4zVSJrxftXMRM1HFZ2Msuear8KINIhjf7cm5WSRLqXL7M/w/jzGt+gMayOEgg9MINt040AegzlhXwz7RfsRyiiDI/+FnJxtUCvb5rJ1Q+7C+QkZhFmrqk9u6BvcXKCTnSJdWI32AQ+SaxhensmKNCr7OIpeI2HyrS/aVYULtfIb9b8W9HJDRA6xKo8m7AV0EjIH80ujS0hjW5gS5UyAUrJ6j6ehRIOfLVBXdM9uyyJdUHuOYdtdM8UWcGAzdPFjELsOcrXGlzyZw6ZTEcA/psfxENu4+Vm661tvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42WnqD0/4HuqWDFVsN1eUAvjX4GJphQJ3fdFZ5K9Ags=;
 b=Ku8ipLCLhLaoxSp/ld4jUtJr6gx6xGKxagxeNV39Uhu/aj/yDGgiZ34xwtN7S41ScBxvzmmRLH1FhW9SXySEm1S7fnXVvIelhMC1k8BCQr/1Mvi8/T+r61GLdNLdfznoyH9k+BujwIor3UFTxnEdIq3qrhN5OwganVe9L5465rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:47 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:47 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:39 +0100
Subject: [PATCH v4 05/11] dt-bindings: marvell: a38x: add solidrun armada
 385 clearfog gtr boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-5-1d7f0e2c7128@solid-run.com>
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 10af7657-a1d4-47ac-8e8e-08dc094e408d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E+uxFNZkYAwyJHCvKN+2ydbsWpaGTIrqanCxaQJAtg134aEuA72Cbegu334wckCA9pZA78gxS578WsnxRzkvqMeYI1S8FKKgJG32JAPSEbE39nAJiMyJB1GWSfyPOiWaqMDqqIExsO+tm1OBymxEIOQYLXJweomEM9SQzP+2Q6Y4qcPEjyA7b4L0c7pfN1GOv3m2T+X2FI1Vof+YdUzrJAhNxtXN/KbrneEkpNdI65ztlZ4pXcPDBAoybsXYfDUCMdpF02UR3XeBZdqyp5Sn0bM08ChLBs4YjEWJPtePZ3gYjQu9skZ7n9nhqZ3P1W7LD9xTOcjEksrfV72dAyQIslEjvNuCnPXMqpqjvvwI5vd702FnJYOTztCMPUSMzG0mh2IMP9XaCBmduQBOAKdvwS5J3YFesL8kpng6dJeShtcv9yLXU0AX+C9kA6cx0aAhLTJ5lUyKZD4z2D/Xtr8XHTgvJc/M7kEQia/lRVWFP5CpMiuDJYtStsCoPXkwsxcEcmVZpMzr4WKQ1M+xv2H190mIYcDuhKh2C7UUNOUTtOzv3E9TCNIBsM6QIbv7YpbDjo1KLVEWZVlGrCWpIoBq0sfPdM6DU2LJOd0zG//Z+rZBOpean8Ff5TuAo/4woetq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhEZUZFQWRwdjc1eTRNNm1DUW55MERwK3pGdlR4M08rNlIyVmcxRk52SUxF?=
 =?utf-8?B?OENPcmRxU0pKTEdzdTJ3ZnlHWWtrVkRLRG5RcHhnK05JVFduZWt2bllXeWls?=
 =?utf-8?B?UEo3SWpWQnhieVMzMGNFNTNIdFNmaDJ6ZTRqSHlhZUFGQW94MkNpcksvNzVZ?=
 =?utf-8?B?TnBpZTJ0Q3ZRZ2ZYdXRsVTNOTUFVL25qOU1BeWFiamQxbzczYkUyQ3VydzJo?=
 =?utf-8?B?MUNGYnYwV1NKd21nVHA2ZzArdmdyUnUvR0Z5WmJBNEpVS245Vm5lam0wSXQ1?=
 =?utf-8?B?UFBtWVJWNWpYTHFiYmhhcStmS1JtcHRsaFJzeENJSExTanEzc09iRmIwVnUx?=
 =?utf-8?B?b2lsZGI0bXRkNWR3U3NSSFkyZWpmVnc3U0Z6a2tCYUtuTndCblVSVUtsV3Ir?=
 =?utf-8?B?VTVMdjY1V01sWWU3U3hGeEMwT25TUnc4VmdvVjhDK3J4MVBaMFBhRTlOL2Z1?=
 =?utf-8?B?OGc4L1o3OUtrWDVRemxIRGMwQ3VLcW5nQmcxN1ZZTjgyV2tDa3hGSGtOeHc5?=
 =?utf-8?B?MGdnS3lyZC9OaWZmcGEvWURVbHBxMVRpV3ZzUFROL3VkaEd1ZWg2U0FHYi9C?=
 =?utf-8?B?M2ZyY2dON0d2SlppZU9KMVJJcDRnRzRROERXZjdvUU5ScWs4QXpBcXpWSG5s?=
 =?utf-8?B?eHBZUUdaTEFpR3p4c05ac1Q5Z2JEZkt3bHQ3c1NSSzAwd24yQVVGUjNTNjFz?=
 =?utf-8?B?Wk00VVBKREo3RXRnd09uK2lvYit3cGZ3T2Q1ZCszQTg4eXNXbm1HVnNyZ0lR?=
 =?utf-8?B?S2V4eFkrTHRzRnhnSWd0Qm04K0dEbW1SWEZBUzBYdWZFSURHU2s1NzdrSmNh?=
 =?utf-8?B?UWZSVVZpc0lnNFk4MWdKYmNJd2psUTh6THRtVzZZdWJ3bzBjeXZsUkN5SDhH?=
 =?utf-8?B?RWE4UkJmZ1F1T25DZmNpakFYaFBmQ1R2UFNzdnE1YjM2QWpNVHROS3RDbnZR?=
 =?utf-8?B?emdiMUQwYjZ3SUhIWitkRlNIbWlRYlhONmVjNlRtMzNMY2ErMFp2Wi9jZFQz?=
 =?utf-8?B?cmNURXdNVk5uUHM5K0RUN1JEQ0pQUnpMcEZqeEh4cm5GaDRtWEM2M2JieC95?=
 =?utf-8?B?SmlDMXNOMWhFNkFYUTR5YWVUejlDK25Da2hXdnF4NklBajdFZmRJT29vejMr?=
 =?utf-8?B?TXNUR0FBcVpkTExBTU56bjExL2ZvQlJxSGJkVzNzZGRBakJtZXJjT3lsRmhU?=
 =?utf-8?B?SGFKU0dqZ3VOTVpzVnJpTXVlTnRkUzJ3NkZGT3RaMlBUelNvUG0wVlNmdjJh?=
 =?utf-8?B?dUhBUndXaXNUbW1LZ1dHREdpMU1vWjdXYmgvRkpIclJERFhGdVNSRmlCMTNu?=
 =?utf-8?B?YXY3cjBQb1Rxa3lZcGQ1YVNoRStObm9SNnRHdGRlSWFZaXV3eEtXT1FRUDlD?=
 =?utf-8?B?UTBIVmRoRnRDWlYzOW9TREZyY2dYT08yTEtOb01lMzZyaEtqeTh2NTAvNmxP?=
 =?utf-8?B?ZGhWTW9FcStBbHQ2c2ZUSG50U0p4Z01PdmdxNlhDenpidnN1MmZtNmFCM2dy?=
 =?utf-8?B?RlByZDVmNHBreGFYT0VMMDlObmI0WnhxS2ZXbTlZc3A2bzVVNUZWRGhIcjRv?=
 =?utf-8?B?RjBiM0JuL3ZOYytZd0w2NVNIdllDWEhRWHNqY3B6TXJ4MjBCTkNsRXhZZGtt?=
 =?utf-8?B?Q2JFRTdRUGdQYUFTZnFDTm1vUk1TZ3VtNXlTTDRJUnZmenpqdzl2TytPcnNJ?=
 =?utf-8?B?NjBseWI4dzB2R25EekpHZThLc2VNcllGbnRUUy94RHhjNjZxMzZQeDd6Z29s?=
 =?utf-8?B?TVlLakRPUGxCcGt5R2RLRms2b0xnZVZMWTh5K3NZMHRVSis2VHg0ZUpZcVhi?=
 =?utf-8?B?RjdiZ2tEZDFIQ1dWZCtJSzZ6WFpldis2cjdiZnBpTUoxd0g2clRabGd3UFR0?=
 =?utf-8?B?eHU0RzlzS3o2akJWdldaYXNPNXNTcG05ZlFyZ2pBdVRyTjlpMkZXZldmZ2Z0?=
 =?utf-8?B?OGFuM1Bjam9PejZzT21pakd2RzRmTm12Q0txQTZhbGl3eXBaM2VxTUxzeVhj?=
 =?utf-8?B?R3RRMk5ZU0o4WXVjVDVRWTRpZmV0SkY2RG5Rb3JMMlBXWjVsK25kbk9Nd0xk?=
 =?utf-8?B?NDcwVEc1bnB2dnA3bitZTkx2bzVnR3FOcTVKbmc4ZGxwVytKL0JvMXFKMDhI?=
 =?utf-8?Q?4Ad+fESxBWXTjiQMxNTLg0+dR?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10af7657-a1d4-47ac-8e8e-08dc094e408d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:47.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjKzCkCAEd87P3dvr6c84KiLxf7na8PyuzmTxbi1lbDfAiBMfmY1lcExOJlKwach29AwXU+nlDyRbu1NIkncWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Add DT compatible for SolidRun Armada-385 based Clearfog GTR L8 and S4
boards.

Despite similar name these two boards are designed differently from the
armada 388 clearfog base and pro, they only share a name and general use
case.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 3babda0d575f..13f9aba97511 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -36,4 +36,14 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description:
+          SolidRun Armada 385 based single-board computers.
+
+        items:
+          - enum:
+              - solidrun,clearfog-gtr-l8
+              - solidrun,clearfog-gtr-s4
+          - const: marvell,armada385
+          - const: marvell,armada380
+
 additionalProperties: true

-- 
2.35.3


