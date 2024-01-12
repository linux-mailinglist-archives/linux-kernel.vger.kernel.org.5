Return-Path: <linux-kernel+bounces-24905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A803C82C47D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3BD1C22501
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A222603;
	Fri, 12 Jan 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Ne8LmKZ1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41E175BA;
	Fri, 12 Jan 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwkpY9nN2S6F8GS5IABVYYmuoOzc5pH+i3RH5Akc7K50twrnbPBlVq0MUqV9C6a32B4P10awqMsP19NM+IByfy7pJ8ymwWTRiWIP8rvlj3UnFi9F7diYtdui3s8XOMHXEX2nsoKmAPAyuAhLmKi2swJfpnN4RhwEaEAsbNTtvmZgWpMaNyy62t70ATH6X79XdqQXHNMjUmFZHBt67WUJhY0HDzrXfyzZ2hOgghl0/jUwhGZvCS/e4gvwu4dG+bMgIG8xW7SLtLkKccppMo+GJmn5ETtUUnVXWjZofazgI0dXa2AsjO0cZYT3oOSSJFeEp1oPWDNf36/tA8Tu2kynSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=YD11Bfkd4jVoHsX+uCXi00n51ei3nfAcqcMUurrnwn/E4oD3YbWThCmFKun9/M2cNN72VQKBk2W+Qi+7BGSjtwq6VFjbe9rVcYhhFlEDe85Lz52jFk2c3Yurss38eCw2XavcWy6fabfftzYetWqGlFfi0dnhb0Ly/34VCIrrPoIVs3EoYSH/UIBd0xjZDq+jGzNG7MwwpJ60e8TIQ3ubqFiANtQhhT6hpsI3XdeLSv8+1ZZiK5Ce2Dz+sl31i1RSRM5hLE3Bw9X+34D00KTXGAOv5mI0cNxf1gJaLZUk+7CWL8l9nlKQ9RpLq6khEkPGSP6/XaCKkFpW+kzD72RbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=Ne8LmKZ15IpcAn/JqRalPITSq7VHb9yOsygx0DI5rtUTXtSJadm1yxDRqH409APqJFddCPhJ1r/QgCIHEuL8BgYraXdZRHH4zCBvMYCe4cMG2OwQ4gUFrCG1CcQj+r/OivG6bDxch0jLWSiPsnfp8/g+E4/C3tfNZuREhURSeUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 17:12:41 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:12:41 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 18:12:28 +0100
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-add-am64-som-v2-3-1385246c428c@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>, Suman Anna <s-anna@ti.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
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
X-MS-Office365-Filtering-Correlation-Id: c046c1e4-4bd7-4611-5ca8-08dc1391af77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fGdpg/oBMspqqf6Y4NZm8aR4hPkRX5ZX5Lkaf7vGZmB9FWFQ5eUBWpEIZB4L94j4nlkt+LXezwVc7TgkXWRXvycumQrsDU2sakloMj+TF789wdac3DOq2ieLqYpe2lqg/mHMtrSR2xvenGgQ108WofkNXRYfhavI/IIBjN9ecM0Ljv7nGBa/CzTgjsnQQ+L3SHjj78VrmGu7chR1Yq3ID0VrFzVMZcBJSaHISpuIgsNWjlIQM4eG2cFbWeC8I/AJJX0AziuaIksVWXn/PKL0YjZaNfSC8rzkfvqNmGHn8widb+oZkgNbLUk26jUw61ox5WolrVTqFFe/dLT2Tyj96clhaIFqjXhH3a05AEZrOASdcssWx1hZdZvCQqCsYL7FLQ0B7D6X30nojVUNUq/MfVr3KIDCYp/OGTampSS2g/gtpyLKYeP5xQYc7Dzlaqt8P3FWdbym5vwyfp3a1f8bGZViufSBeBhTjeHO/BD7x+I0l2QqaiUH1fmhJRjXP036/mgSUSE+ql0y6Xa7LqMF7JH+ZI3AIeLD8K8CwKJSQtgaZvI3hoprDoXLFKchSmdQLn8y2r6wbtLI0BHOhWINFDyk8S1CB/bHBHXpetBpGsYUot4xgJXjJBNxd/jDD+Ko
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(36756003)(2616005)(26005)(5660300002)(6512007)(8936002)(8676002)(41300700001)(478600001)(2906002)(7416002)(86362001)(6666004)(38100700002)(6506007)(6486002)(66476007)(316002)(66556008)(54906003)(66946007)(110136005)(83380400001)(38350700005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVOUU8xcFQ0U0RHdUluS3BDZ2ZuQWdYZmI2eGFCL0lOVU5iL3cxWUNvRmtP?=
 =?utf-8?B?RWROU3FCM3Bvdk50WEtLM2pFd3N3RDJmZ21qVis0Um1vdit1L1RrUkpPczZk?=
 =?utf-8?B?clhveXFrc2RFZWJ6ckpna2tTSzc4SGxLd2N2MHU5dHltQXo4NzFZSkN6engy?=
 =?utf-8?B?bTROSnhQVGdaRkVxWkFvSWpydWJXVjFFVVFhamFsQjVVbERhNUJYQTNIVFdu?=
 =?utf-8?B?M0h6TXo0MXB0bWVKcnNvVDhJOWJpYlVyZ3p0Q3FEbTAzekNLMm92TGZYTGRT?=
 =?utf-8?B?QjAvQWNlL3ZSQ3VRcWIrS1o1SVRDaGkxeDlTTm5TUlNDRXgreEJ1d1QyNkwz?=
 =?utf-8?B?a0tzZzE0bVJxNGUrTVpWaUcycU5jaUVSb0hJSTRoNnJMZW9MU3NZRE1Ga3BQ?=
 =?utf-8?B?NGFrcVg5NEtnU3NRVlRNUU5seFJoL3VTdVcwc0tUWE9ETUl5MTdaQitrN0Yz?=
 =?utf-8?B?Qk9lNUkzaUUzeWt6ZVh6MlRFZEdQWDFqejh6MUZJL0pIbytKeWQ3TWpWTmxm?=
 =?utf-8?B?bjlnelJ2NkF2V1N0ckRhdzhRcVFUZFprUFFISllHaXU4YkVXeTR2bU1hek44?=
 =?utf-8?B?Vk80bTZjWGlFS2U0d2Y2VWEwZHN2K3p1S1F1N2hQN1BuS29sSmk3bjN4TDZH?=
 =?utf-8?B?T2VPTW5YZDhiOFU4OVYxbHpjRVB5eGlrN21TNUxuZEdBdy91UmpHc1ZVNGJs?=
 =?utf-8?B?RkxRcmNjR1dpRXlEbDBXaFJrQzlrREFzM1E2Q2ZZV1J6bzBhU2dtVXZLMUZx?=
 =?utf-8?B?TkE2bG9KQzR1WUdqeEFkVStxZFpTdTVXemZQc1lqb2g5NnF3MGtPRk9DVGhJ?=
 =?utf-8?B?WUdUallSTGJGdjBqV3prQk05RDJnQTh0Z0FCQm9DSVpyZzVZZUc2a0tCck9K?=
 =?utf-8?B?d2JVbFdDTHhXSmNsNXlrSEJab2hQUUppVmxHMVFKc1BCK0pZeHd1MjJQeFd3?=
 =?utf-8?B?QnpqOWNzcnlETml1VlMxNTJqNVFuUE1mc0JrSWtKNUhTTTFsQTVTUksrZ3Mx?=
 =?utf-8?B?ZENSNjJzSjBtbjN6VVZzajZyeWdtc2dMbGxYYk5SamROMU1CTjhPbno5UlJW?=
 =?utf-8?B?a2RFN0pVY2lKclk2eGFLVnZGMGh3TXNLMXB0UjNsS0o2NWVmazAzbzlPZGlF?=
 =?utf-8?B?RWpLcXBVWFFsbGM5cVBSRTNRdDBKZ3FKdmRERHlBUGs0dkQvMHc5K2xXRUFn?=
 =?utf-8?B?Q29mYW1YQm00WFdLOG1uVHR2T2htRCtDOTNPQWVncFY1K1MzSHVGOWFjMlBs?=
 =?utf-8?B?ODEzV01YV2ZuTFdxQnlzdnVYVXNjZEx0MkxEeHNRRG9uYkg5aGRDSlhYMTFy?=
 =?utf-8?B?ZkFlcW5TU2FPRW5sNlRQN05lRU1oOVkwSktmNTIwUEZvdk1JcC9YUnRDZUF3?=
 =?utf-8?B?WFpDUHg1ZGM3OE9iYVFLWVZKVnJreVVRNTVlOUgrS1hWbDBHTWt4TWxSeEgw?=
 =?utf-8?B?eUxKcHFLSWVBNGwxTHRmb1c5S20zN01DL0tzaG93OVNQV3JmWFhnSzE0elRP?=
 =?utf-8?B?QlpVYm55NFpIczN6bmV3c2U4NnZRRUVyRHFlQ0JNU242Yk9aNUJqMnFtQWc1?=
 =?utf-8?B?TUd1U0loU3dPcC85TFpEa1JsS2oyY0p4WWs0cDQ5VWpJd0NlWnJQTGZHQTlx?=
 =?utf-8?B?Q0VyVXJaTlE3RnNmTDhTb1JTYk94RmVuYXZpYUVHTXZnZTUwcHBNZnVuTHgr?=
 =?utf-8?B?UU5TWjhjU3VTTXYrZExGWWVySWhLWCtjZlhFdXhiVlNxSHhVRTNaOFlVcjh6?=
 =?utf-8?B?bkloUERvTEVyWGNsUTkwNEFDdEJVRWxGZVJseGRmK0tLVWplcGtqMlgxV29H?=
 =?utf-8?B?UlEzYTRXZVBwSTROaW91Uk1zYzhHc3hIMnd6OXBpY01uYUI2TnM5Mnd5dUlr?=
 =?utf-8?B?bDdBOEFBUFRqN1ZtY2FIUXpXNDJCRm9CMnJkbEwxelZYWjE1WXVMQUZ1MEFm?=
 =?utf-8?B?L1hKSWlhSlJFTU5vZ0h2VWFNR2pVNTZSQlpndlRCV3JjUVZUUmdMdkZ1ZnAx?=
 =?utf-8?B?WFRETWpXNGoyOXoxUEErSDRudVl3b1JrSUpnTGdJMFZJV0tBOHA4aE5oemg5?=
 =?utf-8?B?N2JiaGs3WXNFTTlJMjZ2elY5Mkl4MHNrMkZuM0RUckM1YkxHZys3V2FGVkxG?=
 =?utf-8?Q?GyfOIb5tDzDkWXxMtEEAOh49P?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c046c1e4-4bd7-4611-5ca8-08dc1391af77
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:12:41.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57bCnBiw9vy0RS4BJ3ib5jcaMo208nhDnr7FaLgVy5aWMLqmuFCeJ517scPj410amHoRozZjATw5xwZyDmRrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

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


