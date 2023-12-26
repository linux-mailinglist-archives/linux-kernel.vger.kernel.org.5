Return-Path: <linux-kernel+bounces-11611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6F81E8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32C0B21FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31B5466B;
	Tue, 26 Dec 2023 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="reUDWgcm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E353E05;
	Tue, 26 Dec 2023 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYbg+Mja0If4NbR+qGdexsgYDqzgpRi/si2zyaFzN2MDhnGvEsfq/OhEiTw3oDD3sdEB5MHL8VQFiKyLxcU4IdOQU+0adQdJdqg8UXrgwj7hd1Dd+YbTyK/80w2U+yy/mXqguTGKXB2YENt1ezO7MlDAk3n1EIshxvm5BjI6NeOjRdV1R6WhgsVyNkzAkvUox0mpKR5E0e6SemGZKVjQI0theD8Pn985a5ebVYKeXbTWQj1+81ZXfg69FmVcwdKQ2IwlsRmzSRxDu/AbIdYxqwYbsqxMNaCiXrrtjTkuKFcu/uyXtQg9Jny9RPksdOBHGqYMISsSCkKqWonoKgGVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=nOHNRKUjG0QcxJLDJ15m5KzRfJUqIX6Tyj/H4cLOmwDeFwTjqlhz0IfDh8nl89vxJCfpRSUj+ulcmBBI4uE1UBJx5pxUFVwwfuwtCW60qiA1icsmpSx8vjdCxzcyW9SK5XyrffVi6jx1s9UbhKlOzsJOPGLS4l5x7TaMBPwQBgXkXWMku/E3kLhH4ZsdeMN+oiwcHUdx0fH4FYztSZdXY1QHEsqT5KR9k02ak0Auzfrhqjb4OXoYan9mca5cHVuHuc2d1KoTA3Aj1GuD8JRGJenJlImM3WchvcLfLJte01AQ5UMk6ImzmFNvNKDhYHaielWwL9llE+L0dLJN28vTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=reUDWgcmUsXFUBKrBDaQuhphBXbwhciH5WtgUwSiw2JJPLqb7/4lyK24+OeYzsNDr5bXiNjWDlXgAulfU137dkx95els7lsXsAiRx77IRDvH9huy21g7T7Bvy6kB1gmF/koEc668GNlgCuX35VPartRXWhLDlV964PvIxp4x+v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:53 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:35 +0100
Subject: [PATCH v3 4/8] arm: dts: marvell: clearfog-gtr: add board-specific
 compatible strings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-4-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: 164ab316-89f9-4e86-2221-08dc063e234b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VnN6lVmlYB+AZbt7+toz704+dYJxqneDeyJyZX6tIfhLEhO4MbzTfaNuI2mWgno/M3VG6Olj1lRP7jIhAgxR4ZFhqB0efPL7WtjYHTZve8wMP9bjVj73yniMHSKpKYqfA5XlJl6LsqNP/CvBwVqwGLI4jrVMNlpvpUw6Hsa9X+LiyrWrm2KRbZ+iG5QmUN4cL8CcMIdUx0gwleagYJ5D17jHlDZigUT5y+cxFWqKCbPv8TXQLSS54e60bfpzCUauJMkvDuvyVzX4LpN9yC6K2bBzJzmwsBB2gNBjwTPHznjKGWS+p15MOm7MAx5jjSPRyfoVmrUvgsoWaa7gQHOxe0qIcGypO0CbrjD2hpMJD2AsOeEmk7uZhNuRSXSOk9BUPNy6pRDCp54KropW966Pc8PHghHukBSRCDJAJIqBVarjJ3sHK8l/zk+8Yp03L5U3HlrcMymYOBH5EzjA73TNToP+iuh6YZiVoHX9njY9CqVKN+628XwP/pNb45U9gYoDeTO0XIgoJ2sMg6bq9CSYj+JvGY76u4IENqXvIdvGb+wyjjf+4tIUqTT6pps99YcNkzDqf8Lf10tb0GklZirPn+14ohYCB/qIdYf5oPRMJvFX8QYzblZ9eRxszJa+7/aI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkF0YjlvNk0wUmpKZ2tleFZabVhuMDBEZzFuM3RtWWJIU3JYQlJGMFUyZVZQ?=
 =?utf-8?B?dmx5REdwbGl3eldNRjFET0V3dldjajF3Z0NuckIwWnJGM0s2OW1DdHQzYlp5?=
 =?utf-8?B?N3hDbDFQdE81eTl5UjBWdmcybWVCVHZ5VnkwTVZQRTA3SG1MR2hVcWpLVVEr?=
 =?utf-8?B?azNmOTdVdm5zbnpybVNxTFp0OUN3ODV2a3NBWi9HVjlSY3dmS3NuM2psT28x?=
 =?utf-8?B?UkdieXZReWpNK3FzUS9sQmFTRTBidFdVNVhYdHF5WEtXMWRjVnlicEFBWDV0?=
 =?utf-8?B?bDhEZ3JuMkxpQ3BudUIwMlRCcTRJbDBLZDBXWFVCOXhqNmU3WjdpUVZwOUtX?=
 =?utf-8?B?OEVEcFBDZG8vZVVaKzQxTE5DUFpLUTZ4ZSsraXRDdmwxSnpId0NRVGs5ZU5w?=
 =?utf-8?B?RzRKZ1JsMFV3QWorbkZkeGVJbE9JZm03NWJoVCsvSUlqNG9jdURQSlZPODNv?=
 =?utf-8?B?dG1lcENUYTRPZmRhMGptMk5DeVhaUlBZVDFUT0txOURudHkxNTVEVVRpNmlt?=
 =?utf-8?B?Q1VVdkp3WWlpcW9IcEMxM01RWHpXVno0VTZSd0prU0FRckVxVHFvTXpROW0z?=
 =?utf-8?B?WFJmYW5XZGhESnlxc2IvY1IwWHM3ZHIzZk9maVdQM1U2NjVhSzBNc1JMbFdi?=
 =?utf-8?B?MHNLK09CcnNTME9uRW51RGRWY25aYjAzREZvNXRZTm5hZFlJZHlLU01JZ1JK?=
 =?utf-8?B?ekl1L3FqTHZ4NkRnMEJPaDFFcVF1YTFDenJZdjVlN1dSMW55cnYzZkU4b0xr?=
 =?utf-8?B?STRTNDhqblFodStDOW5rNjZaWm84cFBWZEZienJqdTdiSmxIL0VXUklGNEpv?=
 =?utf-8?B?dlYxQkNZUjBpQTZuSjc3RzBlUTJsRHdNTzZWcU8zaWFZMEx3Q21QRm1LOVJ4?=
 =?utf-8?B?dWpweWdvRmpsRTh2WmpFN2dPQjlEWTkzaXRFYzZoRU1CM29XSEdIUWI0ZEMw?=
 =?utf-8?B?YjgvNlZQTjYxY2pTUGNkaHBBbFhFK2pYc3VsMkV2M0Q1bmZ0NGhyUlJ0WDg3?=
 =?utf-8?B?QWhZZ20yMHZqZEplM3JaR013ckVqWUtveG14SC94emI1aTVJb1N5dW9uMXdZ?=
 =?utf-8?B?elNGK3MrUWIrYVZPT0ExMHAzbUhjQUVGRTgwdlhqT0VFem55NHVCa0RJaVlQ?=
 =?utf-8?B?dE0zVnQzWU9IUE4wWGdpRXQrTmJGQ2dpQVR5dzFReXVNRmtYdk5xZkJjVmZm?=
 =?utf-8?B?eHRleXV5eGpSMFdmMW9PZlRhSmQ4dzE5eElhWDVHTUdLS0MzUHhabW5JQWZs?=
 =?utf-8?B?QlBRekIwMFlHNHlaS29mbmZvNGNIaEVRVW9UVzJrdEVNdGpzVm5jN0txd2dW?=
 =?utf-8?B?UWJJZ3B4bmJsZlJGNloyVHJNbGtZY01SV3hrN2EzY0toejNZQkVLSVkram9X?=
 =?utf-8?B?QndrOFYweUFnK1BXUTY3UEFVWXhJdzdJRDlvTjVhMlRrN0l6L2gycHNGZjFQ?=
 =?utf-8?B?bkk0bmYxUm5tYmNwUzBCRWdvNzlpSXdWeVR2bUdtQmlpWVlQRmRsVW92a3Yy?=
 =?utf-8?B?ZSt6TjlMbDQzaFZQSkpXWUNuTnhGV051TzJPTG5EVXh2eXUwVHR4aWIyNmNX?=
 =?utf-8?B?NGJmYy9rcVcvTXJIcU5GVjEzdUt2RlBmVzR5dFpITm5qSmVpV2dPbjNmRzQv?=
 =?utf-8?B?MzFaWjNyUjQ2cVlzemZYZkpuVG95K1prQnhrMWxxME52R2phNlVQT2RCeWVC?=
 =?utf-8?B?VEJmWGZpVkxDYk5FZFpSNUJYY1VCdnZWTUpqbi9DSkNGbWxsb29IUko4T2hx?=
 =?utf-8?B?eEJNQXN0U0I5NE1vNElYbXdWbkpYcnBMQ3NOWWFVUVN3c0xYUHRaV0s2dlpw?=
 =?utf-8?B?cFJoNG13WlVYR0pYbzVoMXpLeTdDNThoS1hkNEp5MDZoeHNudVU4VFF6eksw?=
 =?utf-8?B?MXdpbEFZSmxQWDhTbXpmM3RYeXBUNlRzY1FBbWdaRm83d09ZeTVBVFJQTWMv?=
 =?utf-8?B?TEZIL0xBemhuU0RQV1dvcnQvbU1SbCsydGJpM1RSOUEyVEhRamhVemZmdmR2?=
 =?utf-8?B?Smo0cGt0Yk9qYzBBelZGV25hc0ZzMURzemRxOTZobFlZL0UyVThDaHIyVUJj?=
 =?utf-8?B?SHhsSG9IaFd1d0Z3dFBNZEhLcmJFRkNWcnlPWmRqc1F3Vm4yZ1BKeERsRDFx?=
 =?utf-8?Q?PsSKA12pmIF1WDXRYDlFjywpV?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164ab316-89f9-4e86-2221-08dc063e234b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:53.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDynqOqrvJ5OI6RgxxO2RD3HFCXNpkI6WSIg4ZM412jnMuKQHOkEenfb42+uLP3L1HJysa7O3Y4tAYUDLg7ABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

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


