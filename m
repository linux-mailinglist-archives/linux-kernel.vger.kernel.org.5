Return-Path: <linux-kernel+bounces-13471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D987820702
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93321F21D53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060C14F63;
	Sat, 30 Dec 2023 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Let3g5mo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23F13AD4;
	Sat, 30 Dec 2023 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAzCT50EIo7TyxfWvyYfeIY9zP5uHqYX/5GlS/OCeMlXtjVs5Bsv/SKtqa130jhP9LBpjYsEBdVzBUW6r8lHlCDFKP5wwBwKd4PWeB5VE0GzzVUuYbL8SkaYpkBkQ/xO4cHZJm4mAWRG3y1Vvs4qIqexMt9/bmwdRA7lg5/R60EHDb7Hc58fqEJoJKns8Y73gf7qB/ugDiMQqQxHOMptHXZ2lkhfYHQ2tDbLaDfkJQRrE8HpS934PCB/YbugEC12xZ4QnnLgXq3E43w/Y9wLBL58IbPOTu2bNlXqfP1Yg1h3k1kkO3xloEfAMPQlDNsQrbwgG+Y9Q6tM+DtpE8AYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=PLTr7YZ2TBTiA2zPB8yczG2j3+LnlmfAr2xN5iRCP4/3gNy0OME8vuK1kRbXdE0VrIHxPsvzKvMpMjusTk49OH9B9MVROoQuOUDYmvcD+T4V6I1phWbLJlM0uXaaPDKG/rgSSznonkMu8sZV2sT6odXYl++t+p+AlU1q5kH1FJHq0cdxK2Fxvhjas3LmP5u5i0ps6CjwigNqCLiwNrrcc9uBhaEmXNTK5ch8weOl9uqIoYhf7x/KBTMuHLXNaRWgrOOxOn/AvDh1cBaXqCG62Z2SpJjhXzt9M7aN0B48eCbPFU3JFnRqJ6PnbaJPPCF0C+FqHWo0PGzNHyOYMhVvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=Let3g5mohvIifA7Vd7LHncteaEVzUUby8ZHOQIcFHfIJt7EAFVY8Yk8DGspylhm2pXjP0gWw/i7DJ31hgbFedQeQMSzDT09yTaSdv6+ZSWMSTQea9fQHqQOwzHwLlGyFstRXB/6rUdz8ZaYbQbnq9GNAiHfFOmul3UWWNt8A7pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:48 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:48 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:41 +0100
Subject: [PATCH v4 07/11] arm: dts: marvell: clearfog-gtr: add
 board-specific compatible strings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-7-1d7f0e2c7128@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a0c1b46-d77e-46ba-fcb3-08dc094e411e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LXG/PEuXK6u2JqXofe63yozFmm8DBQ0GTZIWgeZKzoBnWaxWJDVebEz7emKWREiRpLPxlWBe/bmLt4A5zIoFED7N6dOCyXMkFqZgZCrGLqOeBsuN3GQLV6JktTGOyZtXYQtOxcYnoxrwGQd829+eeJyxFGCeo2eI9u+YyZwCWu9j+8cafeNnEWt7WWrxjMoPGlDAFE0ulJdcD/IPbcHkf0IK0YSPVb2XrohBYQMP2pSt2woGfE0emmExHZzrrQEkANOqvxGScd5Ej92wBEnGDYqbnqj9IWFm20X0u4aUHuYrYxhMM8ypLP9JcWnU6SPrbfiN7Hkzkh6yLfRxQNKYMvjS4TjizU3ICb6BHvxdUXo7w/hzCebVwxYbadHqnSwRyJ+CF1xXfHoglaDKhqF3//o7Acdsb5mMt082g3eoDBfPphB9/B96W2OO6IHQVGDPh1lUlJsicMU82V9ONyaIHMVU9h+XysAJIqs5R39NEr1MKO/2fNRfpBXSXaw0T2RPx/+PwEhwzxVZSL5Dd63wSADchI1KkbzgZ3JrbHuayRf73CFgDc0n9kfO59ojqT8N5dpFV8gXBHgEIeCRkhU053vXxwo2ZAjcCYklxAVP5ZX0xGxhjn9OqjUiyJgrPsqw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnBXV1JUUnlZRDhjMEhIQ2hJVGEydkl2S1FpMFNuSlVESXNzbk5oT3pKNW93?=
 =?utf-8?B?VHM2UVlGUmtCNkNsbk85clNyUmNuS1hPUFpwTkFPT2V4NFVpaHlPbmRwNFNM?=
 =?utf-8?B?YXNLTGllVlYzZ1RSTGdBQ0dzL3RiSjBYeHI4OUxBK2VCZU1NekFVUStkNnNw?=
 =?utf-8?B?VEZ1aXhmUGlsVjY4VGlJVmZyT0pBQ0pJcS9WQmtnOGJIZ0ZhMWVuL05nU0R2?=
 =?utf-8?B?RzR1SEt5MTNlY3BacEZoME4yM1Y2TEtWY2pYRzRNVXAxV3ljcEpLd09Xam5o?=
 =?utf-8?B?NUswcnRXMVZxWU1ib0t2Tm9xRm5Db3FRdVJKMlVRb0VCdXg4ZHZ5VTY0Y3Zr?=
 =?utf-8?B?SERMZVEyekFIMGV5RGFEbGltczlicnlNcjhYblFneFRiUk51WWJNVnBMMWJ5?=
 =?utf-8?B?Z1phQ09ndXZyTllWa1dPMEZpYW9jVVBGaWZLYm53MHpEWFhYMytpZXBHZUdj?=
 =?utf-8?B?QnRQcmpjeDMzK2taL3J1cnBybWhXSGNPaURpNjBHSzN0ZTliUHRuUWxnV25t?=
 =?utf-8?B?a3ZiZDZ1MThzYXFmU1FvUTVUOFNWdUdBOXNmc0VHUTZlT3ViVThDYkZWWGN3?=
 =?utf-8?B?RHU4amJvQnpwNm9TdW0wWks3NnNBZy9SbkliL25iekU0V0dlU0JkVjJhL1dv?=
 =?utf-8?B?SXlTTlpVZXVWSGNLekEyZlF3R0pPMWZMYXRHL0lRVTN2OXNlS21rS1JYcUwz?=
 =?utf-8?B?emprMGdYZlo0NTZoVkJZenA5bWlpak1maXV0ZEVhdHIyWFRpKzZkalh4NVFk?=
 =?utf-8?B?a1B6bVNIRkJtS3RYWis2eVhPWC81c2VPaTUzUTJLT2lSVWVPeDFDTDdhYlh6?=
 =?utf-8?B?d0VFY1c1dDM5VmlSa1Q4R0NsMHhlNFBRa0s1UDEwbjcxWDB3N1luS2NSRnhD?=
 =?utf-8?B?MXVZdks4QkQrdlAxWlFsTEwxQXVaemo3UTF0VzhtYjJLZWNtYmtsRVIxWU5o?=
 =?utf-8?B?Ulo2UTIycEVIbVN5UkVSUkJOMFkrRGdMSlkwZUI4QldJZjExTEV1OFg4YkxN?=
 =?utf-8?B?akVMSFRRcEdDVlpyZE14V2g4RXcrYjEva1F3NmVpVWxpeXUxd1V0WkV4ZmNV?=
 =?utf-8?B?UVZwWTM5YVhCQ2t1VVd1ZXh2TTZtSEZpandsQll0UlNIV2d1YnpEQlJGdUhZ?=
 =?utf-8?B?Tk43MWxzRGZHS21XS1JsWEJIOFJBWnBQaXlCWVZoS1NXZ1h4RzZYZXo3N29s?=
 =?utf-8?B?WlNXQzgwM2RSaXM4WUhtS3RNTEVxakc4SlBydDVCUHNhVVpLY0RPTE5UREVl?=
 =?utf-8?B?cXk4bTlnTjZ3WVdySUwyV3k2SWtQc3owS1RxM2VXTm8yRXdUNkdNN3hiZkFG?=
 =?utf-8?B?ZjliZ0xENFlOL2JweDFubk5hNW9OdmZFYmJGN1pqck5Udk1uSm1jNzZBRC8w?=
 =?utf-8?B?YTdtbVIycWZkTW81MWlYSlc5VzUrdXdYY2thbE1Hdld5VktQeWZNT3VRSTVB?=
 =?utf-8?B?UWRrNm16Y3o0RWN5Z2loSUJIaWFIZ2FhRVpNQUpNRWVUeTVPTmZIb3JIaXk3?=
 =?utf-8?B?cFVHWHZ6d2RQN1A2T2tPVlIyZ1RFZ2xLZ1QrTVFpcE80cmVNdG5yRGxYU25B?=
 =?utf-8?B?NGY5NVE0VkdITFF5RzJWUHIyY1dMLzZvS0I5emdPM045Vkg0c0s0amZDMkk3?=
 =?utf-8?B?T0UyTnFDOGZwZjBLMTNDcWhXVCt2c252VkN1WGF2NkNWN0tOK3hoTzBvK1BJ?=
 =?utf-8?B?Q25DTlhtRURMV3ExZXhDWDZiTEYwUXZISXpiMjJxL2FTWHFUeWc0N3lDeEI0?=
 =?utf-8?B?alRUOTVNRE9jdjdmVTF2MUUyVWVMQTJ0d0J6MzQvZ1JsYkJRSlV1Vk0wa1px?=
 =?utf-8?B?bUJtZi9vWUgyd25vZDc2WUM2YVlrMThqMmdsZ0F4NHFta1NaUHcyUVVRc3lm?=
 =?utf-8?B?UklyNGNBWmN0S3RFRnRQMERybkhaN2pCSUxhNW5uVXNOTjMycHRJWWtZSTZY?=
 =?utf-8?B?Q3R5ek5kOWFhV0NDMFRtUGlUTnJKZ2IxdFZ2UzUvcmViekhLRldsRjFYYWxn?=
 =?utf-8?B?Uk9tSVJMcmVvaFM3cmliNFNlcU1oWFRGUFo0bHVPanQxbDN2aVNSRkc0VXlt?=
 =?utf-8?B?SVNsWThJVTAwK3VsMUFWdFl0QWpVUHUrK2pPT1ljSnBob3lLSmpScmY0di9B?=
 =?utf-8?Q?tA4xzoKc5kh3xkUQybF/AYl0r?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0c1b46-d77e-46ba-fcb3-08dc094e411e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:48.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q31NKjdjNYbuFnU0dPgoSrZOCc12JdN3BafejtLV2SfgSI66O2R78kbeQ2hBN/4AjinGz0mYw41uk+4Yp8iJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Most arm board have a board-specific compatible string that allows e.g.
userspace to match specific firmware variants or apply specific
policies.

Add board-specific properties to both variants of the Clearfog GTR:
- solidrun,clearfog-gtr-l8
- solidrun,clearfog-gtr-s4

Introduction of a common parent (e.g. "solidrun,clearfog-gtr") is
omitted for brevity.
Since announcement of the two products no additional variants were added
it is assumed that there will always be just two.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts | 2 ++
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 1990f7d0cc79..cd5b070f1218 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -4,6 +4,8 @@
 
 / {
 	model = "SolidRun Clearfog GTR L8";
+	compatible = "solidrun,clearfog-gtr-l8", "marvell,armada385",
+		     "marvell,armada380";
 };
 
 &mdio {
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
index b795ad573891..4a9736ec99b6 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
@@ -4,6 +4,8 @@
 
 / {
 	model = "SolidRun Clearfog GTR S4";
+	compatible = "solidrun,clearfog-gtr-s4", "marvell,armada385",
+		     "marvell,armada380";
 };
 
 &sfp0 {

-- 
2.35.3


