Return-Path: <linux-kernel+bounces-13470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE88206FF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53788B214AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F814F8F;
	Sat, 30 Dec 2023 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Qq/G7LQG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96114EAD8;
	Sat, 30 Dec 2023 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpSlte3rR2T5S+qEUJ9+Wlz9KizR7ZNXBrwQbhpaQ8O/xmYt451JPyaxURKrjcet73wRlwH1UhydgsNJMu/HhxE7QYkPgwHnEzdIKwyAfuhXJcbkINrcH5g2N2LnMbeEzjPIUMupebSCVqLVop+Ntw4GTtE+Stl36QLdQjtfrCryMObQ8CCELC9BZVPpPJivjo1r1ZmC2cXepy+/BVjWyHV79GLVaFTUqj+U3PXI9GwIJcEf7yDGeGmV669nW0IKh0YkX5cT+I/ZtSd3G5XeA6rcCwCI4vEodDDMexWd3acYMmm0C2EHQbGh9mzoeLXIRt4hlCY9EXOPFx293ruDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCBdrFu6wi/4xCggEEL2XHfnXLqWqq1GEdFnn4dbi6g=;
 b=M0VpY7aQuyujktEsnJnTC5iMBRp+rbxQqGhcnghR2YhrLQH5rXmi/1YlzZOqhb4nGwejgzB3MpeGbFbfz9/zcMfgt1I9JoQzwl/pNulS8BZ87H4j6MxlS8AKhs6W2rKzecImoO9FfK+L6B4nMfllH5iyQEVyhqIMqQQAmWcjA4yE4IPQzppxjTOW4Puv+E8WSsF0dXsy+S844aMPb7veeMLgbHVs+ucCBqeCSFlPgx/hd81emlI66+VsEyFGZ2P6Xhe7PnsAHQYj8GfYzF50vaVOqHAAF5YMuPb1qc5gMmeZrRKOxEYOZWVb4zcWskK/U1GthxFMSSrJepw/sZQ6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCBdrFu6wi/4xCggEEL2XHfnXLqWqq1GEdFnn4dbi6g=;
 b=Qq/G7LQG/DX4pBv9MrIWf1Pf2lsPRvKLJBno+iNcplqxIQM4qfu85keDJ21X2mErgDv7NZTFEzG83X/PWbIxAERoFatgO6WtD3oH5AKsRKZiaMMcJUg5j5V0dmWfIYeeDA8FdhI8vtzLfXtgk/JWWcXIRwbRC2abYydOivzhdYs=
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
Date: Sat, 30 Dec 2023 16:44:40 +0100
Subject: [PATCH v4 06/11] arm: dts: marvell: clearfog: add pro variant
 compatible in legacy dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-6-1d7f0e2c7128@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1256802-bda9-4a0b-d83a-08dc094e40d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BR1FCTkubg6lxAzakppQxN+XGd3hAh7CRhN3ZyIbkMuMLYN0aNYkKKSuLh9+xpnEVevqWlPCdiRWM2KSL+06kmFUNmGwwRPss8uslQWv6eNwMbn7iFUXW2DOYxgttQGdGo4oqOJ4jS+NvkqLykvm0hzUImxDpZWwCwHRMQahur7mqiTKoVxGZlciS9TYVSaW/HYWg2Lwuu+dbVI3VTr7rsUMx7ljjH4hgmJJUgJCfVd0TcM7yB8DHuA+LcGUI3rOZpg6krKrxg/u8RynXrxlOpWLSSCJ0tDQtdAt1Fv1yHSB2M3MxVmUJBzpjvJI3Q8zBoOFKizxXCjwG+Xa0pwrACfn07sXYENSw7mW5JNRJYT0YNGbRaezAQnB6Nkq7uMZW0yLYQ6ZPCfcgbRF9Gnygq8ONfNngCfG+h0N7VHFEewqYaouQ48ov8gDvuklEWWV+aqfmFoKE3g+ST+18gAhkm8PABOCfcw5ZkYvEl3ZZ8QHj7GHKCItT9VPrBGlfp1HNi8sZhbd4sIYA77hK/Ubv87u+mE2YP7J+L8MKRgSPgQYwv3VNFNh+qCjE8GbS+F8RsczwRhZf58JifJrsux5g1gqLb+fAeHKWCVHHG43w4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3lKQmhvYlFDNm1vZmRqcDhGTGVzb2dFWFRIeGRMQ1UwMHo3RWoyejRLREhC?=
 =?utf-8?B?TVJaSzFrbTlJVFB5WHh1Zzl0ckZaQVdtNEpGbWowZDlSdWdMdTM3T0hrUTh1?=
 =?utf-8?B?OVdadWRSZUJnT00vTS9XbXM5WDdjTlRVcDRKemNYZXNSSlBjamh0ZnZwQ3hX?=
 =?utf-8?B?YndrTlF2L0pNM1BlWmx3Tkx6VmJuajVGdlFMeVM2UG5rUlJEckNsMWVTUXBG?=
 =?utf-8?B?TXZtSkNJYmcwekp6TU4zV0RJZFQ2V21Vem11KzFjSnpHcTREVDAvUXFwTGNL?=
 =?utf-8?B?dGpmd1hOaVBLaGRxOWJ6VmkzSjNwbXRIckVWUEk1RTBJemtRS0hob29ua0Nm?=
 =?utf-8?B?Y2RadExERHovSHRRYS8yS3lERnl1S0F0dko0bUxYR0REWlN5WDE4YlJ6V25i?=
 =?utf-8?B?elRUaVB5RXlrdDVMNHEzQUlxM20ycWpaTFBWK3lJNkxMdHhWa2lwYUFSUWNI?=
 =?utf-8?B?UHVqczYyUDIvK1dNQUxxYmpMMVIzMjRyWEs3OUJ5bEk0RnJLRVprWUE3MG9B?=
 =?utf-8?B?NW1MZHN2aGN1RGJUVGN3bUUzZjRtNWVNTHZIYStpQnRBUXhwNkJCRVZ2OHNM?=
 =?utf-8?B?RWxYUGlFQWlmUEZ5ckUxby84OGs2TTZBbCtpZjJUQi8xV3c1NDVKM2hTb0tp?=
 =?utf-8?B?TmUyVmtnalBZSXhZakd1K3htL2FxMEx6T2UzUUs0aWVDbDM0UldMdWJVM1Fi?=
 =?utf-8?B?MnFUR3pCMnl0NGFUYzZSWDFoZWNoTyt5b2VDanJ3b1VQWTNrVHNERUg4SmEx?=
 =?utf-8?B?VlNnOGh4TjllRmZDam5xdldkb1p0RmQvM2VSS0Y4Ym1IRmhkSGoxOUlLV1ox?=
 =?utf-8?B?VDVZTUp2L1BCUzNsbEJFS2VqN3Q4OWJWOUZxWXNHeTg4M3dxNHY4bm50YU9p?=
 =?utf-8?B?b01zRFNIR1J0V0t5MExZZTFkaWJodXF2S1JOQWhQVEEwZFE0Lzk3amtxRkNl?=
 =?utf-8?B?NWFqeEh4QlQ2ZUl4b2U0d0RKV3pUUnBwZ0p1OXgwakIyY1FyZTMrVFV0U1NL?=
 =?utf-8?B?M29oS21FTTc5RkYzcGZtMHFPSFlBYlA1aXZQWm1sZG53SUxLWWNXU1Q4dGFu?=
 =?utf-8?B?ZnRCcWMyZGkwbW9MV3NMVXhVS2tNSldLNm9DN2E2LzZDUGlMclY2akk3UHhp?=
 =?utf-8?B?Um14Rmg5aHVZR3g4L0xVbjFzcGI2YmRSSHpaR1ZyL08xNHRVWGlyM3FRUmJI?=
 =?utf-8?B?TnNtQ09iamtHSFpTNzUzejJIMThvSUN2cThSN2gyR3BxdTE5TkMwdTFoRmNK?=
 =?utf-8?B?ZzMvaDRvTXBZRk5nUzE5bzV4Uk9vd0E1dlJRRXRuNHVjRzRrT2k3QWRSYVBo?=
 =?utf-8?B?UXBRaFRJMGoxS2xiZ01pbXRyM1dIR21RU2s3MS93TU1aQ1dkVHpTZVZpNjZQ?=
 =?utf-8?B?dkkwbzhpY1puUnZxcXk5M2VGajdmYnNFVmZUKzV0MkdSMDAwZHk0ZDJQL2Zy?=
 =?utf-8?B?aHdCeXRzWTE5MHRYbEtkdXlTbDg2WS93YklNcmM2MHQxUHUraEdGMXVRSU5K?=
 =?utf-8?B?T09tWE5LbXNkV2hUU2V3THVFTUdIYk11VVRhTTg5ejVqYld6L3R3OVlYT09O?=
 =?utf-8?B?Ym9CUUtwbHFseEpuc0hZcHRIVXJ4S1BmQk1lYjJDT1NvM1o3TFFjTlVKa3VV?=
 =?utf-8?B?WDk3d25oNVdBVFRCa05ZNkYxSHhBZ0djejc2czRuMUZSQWs4RXV1WjRsck9R?=
 =?utf-8?B?UkxtNExQUmNFaWt2c3VUc2lKY3MvTDRFbjFMRWhGZkh5ZnN5My82N2JsSGd4?=
 =?utf-8?B?eVkvL3ZGQzQrVENYMVViaVhQelMvMUNYemFieUVVMnk2L0VkeDZvTEZ6dkta?=
 =?utf-8?B?Ukk3cFZIdlc5dFo1eEpNSk9zZGdVa2RCUDQwKy9tSHUrSmd6NnpNeW8xU08v?=
 =?utf-8?B?a0tNNlVtOXZueWU4OXRCbnc1ZWdXNHhIK0lIdUNQeWhCWDA4dnF0bUE4eWg0?=
 =?utf-8?B?eHgxNkJFUEhyNHZ0NHhzT25xNnZOU2ZsSHJMdDBvdk40cWc0KzV1TmxNT3do?=
 =?utf-8?B?dGlqY1pMcEh5UlJJVGtVK0s1R2FtR29aZXBTNWw1bmFNSjhBTHIwUG04SVhB?=
 =?utf-8?B?STJvQlZrejBCQ0o1b1JvSjNidm4wU2E1djJwQnVHenMwSE5jS3lwcERpU2hp?=
 =?utf-8?Q?bvFFBLLvK5WLiV5mtW3IFIAE2?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1256802-bda9-4a0b-d83a-08dc094e40d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:48.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEL5qXJLEc/SfUuFqH1lrwZ6HeQ00qwOhPMbj+vAzxWLVFpWDzeLEOL20x7OSsMTe8joaHcnWEG21clKz2hCEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Armada 388 Clearfog ("armada-388-clearfog.dts)" is a legacy filename for
the Armada 388 Clearfog Pro ("armada-388-clearfog-pro.dts").
The "Pro" suffix was only used when the smaller version, the "Base" got
released.

The two names refer to exactly the same hardware, therefore they should
share the same compatible strings.

Copy "solidrun,clearfog-pro-a1" compatible from the -pro dts and add it
to this legacy file.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 32c569df142f..24e478a3cc99 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -10,8 +10,9 @@
 
 / {
 	model = "SolidRun Clearfog A1";
-	compatible = "solidrun,clearfog-a1", "marvell,armada388",
-		"marvell,armada385", "marvell,armada380";
+	compatible = "solidrun,clearfog-pro-a1", "solidrun,clearfog-a1",
+		     "marvell,armada388", "marvell,armada385",
+		     "marvell,armada380";
 
 	soc {
 		internal-regs {

-- 
2.35.3


