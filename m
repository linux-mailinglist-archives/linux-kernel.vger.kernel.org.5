Return-Path: <linux-kernel+bounces-17059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5338247BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D0A1F2726E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ABD28E26;
	Thu,  4 Jan 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GAt7f4cf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01C28DC9;
	Thu,  4 Jan 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOW3/WmjvHiR8cnOoKBI0rhIlg/aibDfywBYpbBiktB17D4OTUtiGP55WRb/+M3UJ3MbV2tAd1CWIM9L7Xo3vDbqdz/98Hyd8sxWO5UQV9+orWiTx4spu8V8gjvQIcyyxvCtU3nNuXDIvOc6zKPDsVXLjLjI9pHS2qqnuz2V45O35EhZ+SbEq3T4hZRW+x1ftQltw5hu57SwEiOTcBhuOz64+j4gUURivC6S+SOgO16bq7y1FvsxOyB+rToxsewYzT8Q/Jesq25pNNiA7pnl0ixgqW5Dxfw1qhhgZxsdubXNjJ4pw1Sm6pSBhwPanCgIk3U9OpZv9cBf7DZwXga90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=IHqLxfetMpJr+HoZxZrIdCWeTPpQMITWLMhRCByCf4DqmZPucfFKOM9KdAlus1DAb6fNA1eAKn4gR535gWhXFx77xZyKJeAqWJPwrs21UvV01iKu/fmUan31hePWN8P4fmxeUm3O7dDMVX+oB7KMOw0fs0KHZhD5RlturHIdnuQjGUQRmDA8c4ignUuTjjMMz6/9Lj53U/VD9l4oJ3+8eoJo0VnFti2zps7sjx01g8zk67vAYtxBXIQJBUDVAw9Q0hnqlKAjU6fO5BpcMUtc2QSYuBDoBYhbg1MrlQDnYi/R+zesplGI/8p6U52gmCCsrQhDuz0f2em6xDUVa9GBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eVb71Hg6FixSBVV0em2rboA8oaGpIxtsGng3PO8n9Y=;
 b=GAt7f4cfE7fSbtUzfFXRU/AfZQDfrbstf1uu1T646F2ES8LnYpbwOUyWtwGq4EycsZqLS35mu+biSP7biqiV6GWbdzkNdx+191tLsHBrrihuDp87hFUXHR0K9a3M+cXeD53vsSd0npgn2E/Nezbs5e30JDvJQZLw5c0IKJm3ATM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:48:11 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:07 +0100
Subject: [PATCH v5 06/10] arm: dts: marvell: clearfog-gtr: add
 board-specific compatible strings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-6-52be60fc54e3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3c43a8a-8b6b-44ec-9f6f-08dc0d4d5039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U54pqjhdk2GaGNdnl8qMKn8f72RVbslYVd9bLIRG5C2hcBFlZFhLkVFG/6jKBXFDZ9Thj3A9twgkdY2UXI0aB9cYr41IrSHWuUMblDKqosi92TjQH1BfimOTVLN6PvRmSjVDAaSD00Eiir+RfK6fB4WWBJ02wZfm/xu2pIytaPa/E9qgCiuYMPhC+4p7atDrk386LZCPNR943x73srTiUPysvM5sENCC9W8QE86qZrzDHoW0H1cr7RuEMeEIpp8H107PCI0UvrNpYY8da7gZkf2WbY3LtY/gyBjF+onl3kUS0t5m/MPXTtxEUiIveZirzSWlt2BS7BP4f0VJ5a10Clcm5IGHVS/oudG2LysmJhAvbT4SOJe0qd6i2UAyzjF2Rtu/KkvrlTlJuytVE9g7B6b1AI5BQulIvNyt7GQPEsaW7eWYeQVhYhUL4d5PYRCZZRfwUPDJ+Y2G+gWR3sTxmc/jzslX93ChMYH2v+Kunr1b0xP4KWq2D5PfD6kwjQY7FtkHecIS4bTJJDFNfD0NbvtMba6Bj2mvzMhd84vV+xY7S7OwSw5AUSNhoFJC79AgLwBr33jqUCjmrJ9GCqt9/sU0m/zj/AcLT0tqxLrTB0IFjwwD7WRTlMA709Rym2fv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(6666004)(316002)(110136005)(2616005)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2JlMkhwYmFiSi9wQVgxWlp3QTQrZ0FyUkdSenZxS1gxK2xGcXBkWFoyL1dS?=
 =?utf-8?B?dk5KdW03aFl4TjYyQk5xendXdkZVRmVlOFBHdXY5WFpkQ0VNZzByWUpuNFhs?=
 =?utf-8?B?RXpGanFzWXlKU200VDZ0MTFJc2xDZDRiSEhaR1pqZFA5SmNDZGlDMTZsd2Z4?=
 =?utf-8?B?NGJFaHdUcWw2c3ozSk5IWTI3OWxIeHg3YkRHeHh3dGluMWNoeUJwTzFtL0s4?=
 =?utf-8?B?QlVKRzVHZFlSbHU0U0wyZ2lGTHdFa3VHcHFjTmxWcUVlWWV1andLckpaaDd0?=
 =?utf-8?B?a2I3dG81ZEF3QXpsU2xqanFGaUIxd3FMdVUyM0t2UjJzTkdLL1RURTdoOFVO?=
 =?utf-8?B?Q0hRRm4xeTVWcmZ2S1pNaVQ3b1dqc3V4WU9XN2J0N0UrcmRLV1o1NTQ4dE51?=
 =?utf-8?B?NUVvOTIvY1hFZWErakRQaDBXVGhJUEF6c0lSZXhrL3owbzNWSGhUdGFwYVZl?=
 =?utf-8?B?NXgvYXFWNTZGeXAwdmMwQmNrdk5zczQycms0UUdCOVlWR3Z4bk1oLytaRU1I?=
 =?utf-8?B?YXp6SDhDbS8yYm13bmwrRjFOaUxkejIxWktlTTdTR2J4OEZ0aThuNitZMTFP?=
 =?utf-8?B?QUJJQjdSb0dZdklRR2ZrTmtFbDBYOFNmQ0N0TGFicVpsN2tETytNR0ZmcExk?=
 =?utf-8?B?dTdaTWU1cUM3VlVyUzFQV0ppT3crU1RESHhhd3Y0MXRGMTRCUHcvNEF2Z1lQ?=
 =?utf-8?B?Z0hhSHBLL09IaFUxQVVEUi9BUzlOSnlYMXJDK0NJMVNhQ3E0R3B1dGQ3QVF1?=
 =?utf-8?B?Q2hqTWh2NzhiSER1d2cvbE1xMEJJTmYyLzBOd3BIdWo0WFhkTUI5T08wT2ZH?=
 =?utf-8?B?U0pxTGRDVU1GN3VweXh4dFdGTWgyZDV2SXpVdUk0N0xXQ3FIOWxmSGM3TWN6?=
 =?utf-8?B?SGFaZ01LNmVJL2k1NDMrVEFCN2pGMTZwbWJwSGhMVGdMYnRQUnJBWHdaemw0?=
 =?utf-8?B?U2IrU2RyOU8xaUVRdGRPT01TZytBelRLWURqY0w1dVU0bWJDbFNEb09mMkpD?=
 =?utf-8?B?azIxSnlHa0gwTlZuN0ZhaklzZi9TR1NPOHBQakcxcHV1Yzlpb1ZMS1l2N3J2?=
 =?utf-8?B?Q2t5bTd5YnNNUXlrMWVtZ25KZFlreFpJMXVIRVA3QTF5M1JuNHZJNzczcTll?=
 =?utf-8?B?UVRib3Y5dmlrdTFKbWtQeFlZRlYxbGgybEI2bHVmVWpHNTRST0xJR0swWHRK?=
 =?utf-8?B?YkJreGRaR0NCaWxSY0RmOXhNaDFxbitOWittVkk1cHFTU1lLeWY4WHVsbyta?=
 =?utf-8?B?NzBqOUVtUlZlcDhlcG5CRDY5TTBGMUEvQVpheS9HWmw3aDVYY2RlNElkY0Iz?=
 =?utf-8?B?NmtZcUNEM3Fxdm92SVAzNG82c0dIL3o0V2Y3aUZ3MlhsRWw3ZU9Kb256TkpY?=
 =?utf-8?B?aVpSREtPQmhMc3AyeENYUHR3Y2dYb3piVlIwMkpuVGhkTS8wWHpGamJSd1RG?=
 =?utf-8?B?bkNYT3hnTDQ2WFQyL2pJaWxyTXJGUHdkSmF0YnJ4RnFsRDRyNFpxSjA5SEVz?=
 =?utf-8?B?S0JNSGtMektYK2k5RGpyYW9adGMwMlBVRkUrcGlIREhLSFY2UUZMaTFPV3Bl?=
 =?utf-8?B?N2kxTi9ZbEVrSk5ZVWhaRFdvMnFXSDdGcVpUeUZ2dlM5b0JXL1NjbHJla3JF?=
 =?utf-8?B?ck1uZWszYkdSRTFpRERFYmhhM1p4WTI5Zzd5U1NCUWpLWTFHOXdNNk0vbUdE?=
 =?utf-8?B?ZVh1T1pLQWJ0d1hsdUxveG1tV28xR0hNSzBDWjBBcjNjc0E0ZGw0anQ3Nkg0?=
 =?utf-8?B?YzZsMlhoc2o5Q2JROVc5dXdoSUpUSGJIbXFRU3hLZXNoNnRwdHIza2pWcXNU?=
 =?utf-8?B?citvakI3dTZ5V1R5S0wwQUkwSEdBaTV4UWRKZXZ1SjNCdkoyQTg0Wm8vT3hi?=
 =?utf-8?B?OWlXbHRLdDFXQ3hJQ0dBaWNLbHlsWis0MWdRQ1lQU0NBTXc4QjlQaXVSdXVv?=
 =?utf-8?B?TUgxS3diR0d5Y1o2eWdYM1JxcXlDTnIxUzNFSHMvRjBmd3BHZytxdTAxbmx1?=
 =?utf-8?B?a0ptNVF4d3FmWWE4bi8vaDNhQTJ4bmtlRFlxZy82Z0pTc04rRUJvOW84WlN0?=
 =?utf-8?B?bEhKcXA2dDFzY3RGZkhlN1czVEJxU1ZTdm0wKzlsd1pvOTJuRVNpVjRPU242?=
 =?utf-8?Q?aEyae/nLSR44qxQWopnUsvj4t?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c43a8a-8b6b-44ec-9f6f-08dc0d4d5039
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:09.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjqF73CJUSK8s8+c9RH1yG4jQWAJfl8rY7R+oHfWs55Pyx56Rzr2+Zm2GuDBcfcBuHLCS8UaZlhnelKG4o45jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

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


