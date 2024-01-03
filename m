Return-Path: <linux-kernel+bounces-15444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34952822C14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BE71C233EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479DA18EC8;
	Wed,  3 Jan 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ciLaHOPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81618E2F;
	Wed,  3 Jan 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IouSe7GsFOCGvsManaWUP6+EXjmyd84kmHpFHwXzakk0OtWk54x8JigpyrL5WEmveW7KkHCLhKz8Fy0wQS9OUFurg04pmGaDb54yiI/4oUrip01kkH4fPz3rO1HqYSxTrdjNIORuZ5hHgsEvIbNMBildTBwsudQiGjeua9q+rHBh/CzEYMJ08Z5zfG9iHN2GeUIHiPK0uOiR3DOXfPNV9tlHtzGo7E1nSLxxowfQOQjyJ5yqHk/K3wqupGYvy4A3GgLn78w0GK50MIF535X8vLchuLLq9HJj9/hDas62Uq2zetpiOPz2eluQsd/NWuIBy7XoHPiZcQ8XzAAnGdtWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=ABxtn+wak1ugIDEk64mXyayPVK2nVBHFzsr8njxln95s7V4lJ2uWH774hsFfNsvtFzXPeX+yEeWDmIbV6b2E14l2TXZvWDb1UTXKV3dDEe8Xg5zvkrxGcrvzpcqtOtEn1Yr/p0z8fvfavrag+VvcmlH9TpnBoozgHof/BtTAEcw6bGCW/LFuouKOG2lvAx6F/m34xdLY7rWHvr7k9qJV55wokEUQy8ZUUrTmCswxyWdBu3c7hlOabS9IXyhphURuC/SnSXkD7vfiK3AKeZVmqud0tA5ab60c7RKafRX1owlCE9Ci1FUvoPOk/xDra0dkTZctpH3EnQe9KiM1gOaBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=ciLaHOPopHHkh1Pe6xaBcV/Y6nDpY3DdYbi0vuxfYkrB+dPBusf6nBuyDkkEpIcijmQZrj7PM0ARPMdiUsEyVFh9VyGHqscAtSKzxAyFDvhi3gis4LsnkEsuNas5q+tNwJFl9KgGJg7W2O2lOkLkiF48VR0dTQmbOZhyetZbm1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 3 Jan
 2024 11:27:21 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:21 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 03 Jan 2024 12:27:14 +0100
Subject: [PATCH 4/5] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-add-am64-som-v1-4-dda1f9227aef@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
In-Reply-To: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a52aaa9-bb31-4211-5671-08dc0c4ef34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C6jhaEQBEwOaf9vC77mmL9v0eaIwGKn46YdK7V3WuWOaHb999M8Mj3gowmiyVJgcBI8hYXekWg5TZ3pnBmSNT/SgNCtPLmBkr1RPpVWBWqc6u72Zp3QMvWkbNYgBntObxo7NfFjtohLY1QZMCTihex5qTDeAwBaibXKUyyRCI4vr6XkgD/6big91D/FQu5rKa68Zbgs+qbqMIvodZ8p5X+PwGDP9Fr9gkgXSQyBMd1MW7s34UlwhZnXI9+Hw8o5NcOPVfgH/Cxxfe9zoptSg1B6ULzFWld0j/b/qebLQ06UEpfT6DRzFdQ4rEwOsDIf2pFBx5PjaGmjJwbAhXJPv/gophTWBBmbJDbYOORBr619KZwWRYinV+lWdcztXqqT1QBBZzBfmNB8fd6sIlQLaDlBKPoPb/XS6oeT9WT4XM4sIadABD+/voWo4m770hMpsnfmXUiNHRjZSbVC1UAJbgT19m1Gmoz7kmGl2G75BlWkyjm7aNpBC7zruCcKhfgtKaChmdFD8h65fBFNcZKuvmRcp9Y3AuanZ2lOFpyZWThjhyQsJwHqHhxMMZWhs6kKsqxjeDfPLyDGeiX+0G22INHmXC0R7ARLV6JkVP8Tu3JgLJEQBVZYWsOs1DeS5R9sr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(7416002)(6486002)(38100700002)(26005)(478600001)(2616005)(41300700001)(36756003)(86362001)(52116002)(54906003)(66556008)(110136005)(38350700005)(316002)(66946007)(6506007)(6512007)(66476007)(8936002)(4326008)(6666004)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SThZaXZvbGo1UzNKR3pFUEJQNi9hZkh0MkxKNWluNEF1amtJUFRRNE9aYTN4?=
 =?utf-8?B?WjhFUkxnK0thV2xFd1pibUVYZXBLbG50MHRVMlptZGQ5VlFnVFVydVYxbkxq?=
 =?utf-8?B?bjhrSHJZbmExRjF0WWQvRHpkY1NMVlZxLy9EL1NUSEdPZWM2dGNjbWVnbTB2?=
 =?utf-8?B?eUlPZzRPaVBsNFJtZ2ptdUhneTlKdElUamxidFNsSG5NdURyQ0VxNzV3M1Zs?=
 =?utf-8?B?aUs3TVBBd3F1a29RYmdKcjZFUjUrMlVNMUsxTkFya3BGcU5JQ2FYOW5ybG9l?=
 =?utf-8?B?dlpXbldYTkUrcWFBNHVwc2VKa0h3WmE2V242d2JQbXBVUEMzMUNIRTNPdDcy?=
 =?utf-8?B?Y2VGbW82WUpZQjE5NmQ3WVM5QWdqSk9MT2kzbTVvOW1rSWRvSUtId01BVHNv?=
 =?utf-8?B?bW5yOUVkU1ZwVXlJejJ6RDRQc0Nzc0xGYi9maTNXMGIxelZPbHhLUUZUTytn?=
 =?utf-8?B?V3Fua2VBdThUOVdKS1l1cmRZQ2szczdtY0pDWkF5U29vb2NZSUIwSnI3YnBV?=
 =?utf-8?B?UXhkV1g1aEMyMXU0RHFpc0RSZWhRTjlUbm1MU05haG5YYmdhTnB1NG8yWmxm?=
 =?utf-8?B?U2JiL1B0eDFQamdiNytCU0ttRUhSZ0RGNEdDalZYS3RsY2VreVJBQnVuWElp?=
 =?utf-8?B?S1JONnF2WG9BZUE4N2hFV2VKbHVTMDNOcjA5TklpYmpqT0FmVjVYYSt1WU50?=
 =?utf-8?B?alhXUzRXUkhpNkx2NElENmxhNStuNFNxamxzWURLYWxZb29yRHVVWnl1VFVK?=
 =?utf-8?B?YmNBTXVzUFhVeVNobitGVU5sbjV4UjF3aWpXcUdJK0krMDFHTHJkVWY0MnNO?=
 =?utf-8?B?QTVYL1EwTElBVEpvVUh6Wk5oVUduSVdFK3BRc3NqVG9QYklYZFJrVnRGaFBs?=
 =?utf-8?B?ZjNGMHZ6Z3oxMEE1TmpxTExES0k5eW9HVnpjT2U5R1N0T1BpdTQ0QWxuUFNG?=
 =?utf-8?B?T2lKL0M2QmIzY1RQOVhSWllyT0sxWC9SczdQVzZHTFRJMXVzOUtxbnVYY1Fx?=
 =?utf-8?B?djhocGNQYmlDME5Qa3JEaksyTTBkbWRjTVduUzNhbjZ6R3ZtWHdveld3bzNl?=
 =?utf-8?B?ejdFcXJNdTBXbHJGVG9mUTRza1VUdkR4eG80dVhVUHJtMlE5cHpqVU1wZmpo?=
 =?utf-8?B?V2lJQ2tnd3NSYllCYWQrSW9rdEh0WVM4YS9MRUNaQ04zejJOTmpWRTExQ1h5?=
 =?utf-8?B?REliRml5SnpDVFV1VmtZbmdKN0twR0UxSldEcy9YMVNlUWdqcW0xR0QrSDdq?=
 =?utf-8?B?aE53Z0pscE93aFR5cVVzUmozeVFnL3NMRWEyR3ZEUVl6R1h5TklyRWcyT24r?=
 =?utf-8?B?VDROdWhEUWk4WVZtYy96QlRSTjB5VGZrZE9uMmEyeURLUUZxYWNhK09xUFRU?=
 =?utf-8?B?OEMvYnRaNUNhcEcwRmplaHNsaDhnd0VyWG5FQW5XTTlHNmtPN21rSW93VTZY?=
 =?utf-8?B?WHU3QjMyNW12ZG5zZmtXMGcvaEZUSjN5c0kreFk2RHBXbm9ZQjFkeDRDK2VO?=
 =?utf-8?B?aWhNT0N6dUo4YjZRNCt4YnNHdnFldDF1MnZzTGNFbHR1MVFWSDJaSTdGbUg0?=
 =?utf-8?B?U0FtTGxwZmlKNnBCbU9IbFc5T1hkREt2QncvNzFNOEhPc3kwQSs5ZUd2YVls?=
 =?utf-8?B?TUY3R1VOWjFuV01oUlhZRm1zTFdSeG9kWnEvWE5mekI0MHdwdHAwWk9rQnVY?=
 =?utf-8?B?akdEbFVoVDJNdEpTN05mMkNYdHBZYk5IS1ZjOXluZDRMR3JDTEtQS1p4dUg1?=
 =?utf-8?B?VGdwNnBka2ttaXF0Z2tTbkRUU3hoMytzRjUvaDd1eUN2NzY0ZlhCck0vdXh0?=
 =?utf-8?B?anBkRi9RUXlhYnhoS3R3UkJudU1MS1FkSjVZb003WWU0ZG9takN1OEppVEJj?=
 =?utf-8?B?cGNyc09IdWNMWlRlRTgwaGRYbU81dDVQWVdhVFZtR1dZMnFScE85emRFeW9x?=
 =?utf-8?B?aElxcHdkWmRJVDV0dUVET1d1blBUTFM1WFRadFNRYWhCWlR6ZjN6NExEKzNs?=
 =?utf-8?B?OEVyWW9iQnlnZlpQY0k5REJreS93K05oSzF6bjhEandMamRORzJvUnZyZkhK?=
 =?utf-8?B?NFV1MEFoZjFoN3VXOEYwUWgxUFdnbDNTeE5JWUZjVFNKRURpRFphaHRZUE0w?=
 =?utf-8?Q?O5IVMjHvM5DtDNbOEW7AFQlws?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52aaa9-bb31-4211-5671-08dc0c4ef34e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:20.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLkbn8+2biqdNHU6fEt8+V5cFIlVZIRRTPLGETGI9mjQs8/GQtbEbxhAlswnE7wpKdTk0RSoT99nKfALZ+aSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136

From: Suman Anna <s-anna@ti.com>

The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
derived from either of the IP instance's ICSSG_IEP_GCLK or from another
internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
instances. The IEP clock is currently configured to be derived
indirectly from the ICSSG_ICLK running at 250 MHz.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0be642bc1b86..8130ee02a3d9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1232,6 +1232,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1373,6 +1385,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;

-- 
2.35.3


