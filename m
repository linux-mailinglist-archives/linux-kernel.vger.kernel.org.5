Return-Path: <linux-kernel+bounces-92773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFD88725C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E233F1C20A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7D18C08;
	Tue,  5 Mar 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGIeWcC4"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273218AE0;
	Tue,  5 Mar 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660022; cv=fail; b=JpgWkoGd8UaS9Ar7FQj5qppJWZ5b9ExKpg0Mgf4jpsk5gjBQ4TtO8ONcg4piMojSZyofa/aM8R9Leb9+abckj3bI7CXzW7zGLVahcqlR0/sqN/Gllj5ecjMNz023KCvwy0HAvJouGvOtI3dLRzvCMHEBVtSyiHK9Rj/QSawfAYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660022; c=relaxed/simple;
	bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l+jVCnZHUyCrgpD1zhzNzYgyQCJgMPLjD3BYVbM3OVdd57WwkAVbvuhQoChxTz25zh9I5vmU4ObKNVITNSYScwky0lXf48AEYJmHEOgOJpLubQbB7JVbbflr+mJbhscp7w3//vY/60TDoLKvLUe0q2CD4BcGNqR8JAnMzJFIKFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGIeWcC4; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npIFK6cjjqUS7Q+2u5K72TiYLnZY3lgQ8fKRnkkjacWUWaDSu3eZeUE2F+fGR453HKRzE/DP+HGQ8Vru534GK3x8xyHtV8PMEdfZcH+IMQOmcG0BIjtojTenQQNXJluWWLrLv5MIZbUmuO1tcNttc+RjEb6poa0OCfuoqPMM324N4LSp958Yb+O4C2e9TJzXHnjmyUcqw/YVSnLZoSywaBlgyFbtwmUNTW04gbK/eRF3MmNp8ESuAC2sU/x83dosYUb8Gz+gHIPzwRJZq/G7q+WdwMIE0W2fwXeWDeV2KoBPN6wwVEeZiXxHcm3KFLDPU4EKwy7MQNeXfsKql/8+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=cknMgitn+MXoLHYSgQLaIgpgstPeIMPWesDMVObK2vEfzZKQWyehAxbc3sszDKwkmWl8GkCkxBQN1jXdpEB2pLvPoMKNUwM/8EbZxZ/fjtV9U7vOMNd0Qgj86mgY3Qpo6tW0+1Y/lQKkV9atmcOjopw7UjDdp9JJxbYVhhD0minbSvt53sS6YXZMD18/RVz16D0ry/GcJvBRLGfgMLL8yzoqNsNESRjuZtdfpjW7Ac0RP5naannga9qjYeE0n7fYF5dzqbKDPbd2q89yTvgHjyeFgl6RQ2dyaI+F1e2JWcLxW8uFW4o/RZ29NY5SxZ5egKsvLFzoVnjMhNX7zcMIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=ZGIeWcC4+hjj3R/Y0MDEfQ5AAHObBitzroETyeAN0agvDT69+wHIYfKifwXBLc3VZ/8HX/Ngyi+fqF4Q9jU1kSXfVBTyYCmq24DYPsp72iFf5h7G1xkUI1PxVLHsLW624sNa7ZfNpas8u14YfB8cjMn0T6FDFPholJQs7hQ+nVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Tue, 5 Mar
 2024 17:33:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:33:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 12:33:05 -0500
Subject: [PATCH v4 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0,
 spdif[0,1] and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-asrc_8qxp-v4-4-c61b98046591@nxp.com>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
In-Reply-To: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709659997; l=10528;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
 b=chMUJ7/XT0uXG86bVjfTRkPeJ8jj6HQXKQdDUNHBoCNlKTGaBtHfJIf/01fGrJO08pw2JZ30p
 8eWnX0LvG1CAgwLrHRREHGyo0UzK8QxMiMUz++bsU+GnyGE15IPe85/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d3754c-fd88-4178-fb15-08dc3d3a63ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FvP1mygq/vc1Ilq5QJ13MLIDFSkNsO4uayvr7mMv+/AyIO5i+8ktfL15bXaKtfeMwWHEez0ZRVsxMeA5fQY5NOSg+dHN/c9767gt/Ft/BQwHfWI5MJyhB6EOH55UjmbEYhXGxT5xg4Jqgd5Y0m7RRjV1+WIBVyxZVNbhjnoX9orHqDtA7QOGytIBGVpfrUUBKJdFUXc6HJtqHURlz1Rs8lrXVAaz+sEZO8YlipZPn8YtoRrZxi73kdiONhMHqRfPevvolpB02i9b5GcOxKp8TSji0f/Dbvn07mE7lQdkUO5TJKzYeXJZjCPR8oxDdKPFeR/QIXdNnseRVtEPoxn0ZfA1ZUrbw+kW0cyEh08hpwHABX3UdfnYtvuwEmHUUunxrNVnmtXJCWuXL8e1BENi+T4p8bACNS0B0jsteIDnANw8gq/4UGrs1rH44msi4rQmj6+QCpBgdszO+ELYzzJw+vPB28p4ZjmNxUSVW+FC+6rWSXO4WL3rzzVdrhKENycA7f0A6uxHJ548+zVnHRzJ/4FfDEji6n6grge9Li5s904TUIBEJrb7nypuceIKXoYUAh0nNKAZv//VtcO/SxpMX19e1SeNJuEsI0q/54o/vKUN9xQi9a0Mj6FeDUcmJbjqmYdMQq/pFZ48srcBikm9e4nfKJmPyrX/1z1aaHnOf2A5Y16aqbaILGwkAxiJ78FpMZEgRiO3TRgZZvSMbmMTJaEHcT0ApPsREEY91MNVd80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjlhcUdTR0FOV3QyaVo3SS82ZVRWN2FHc2RjdnFSUFk5UlNOYzE2aVZIQ1Bx?=
 =?utf-8?B?SnQvdzZ6RFRqZ3hnT1doTWdaQXZDVkNjaTB1dzh0VGJqUjVOaUxraWl0MmtO?=
 =?utf-8?B?VmErSnRRQUV3V09ZNUE3dHI0WDFzRFFuOEZuUW0xdXo2dk9JeWU2WHVyeWJK?=
 =?utf-8?B?aUV4eU9RTEFkRVdDS3Z3QmJHUXJoSGRWWUdibnFpWnJFdUVFcnlhdjRCcmlx?=
 =?utf-8?B?MEk3MG1XUkVwWWluc2xPT2VMV1RCV05tYnEydWhhZzFzT0oxTGVyM0NsYllw?=
 =?utf-8?B?SzF6UU80ZDB3dXY3aFFBKzQwNVlzWDNGWW45NWw4eTkyRVdzZzJyYVFjem82?=
 =?utf-8?B?Y0NpZ3J0S0F4ZUVRaTdab0dGNExGVWhobkNsZlJiZzh5d1EySDRlSjFNZnlD?=
 =?utf-8?B?L3Nib1RnbmRlYXV4WTVKMThwNzVWVlY4QW44VTVUZmxEYkdmSkE2SG9LSys1?=
 =?utf-8?B?OUZPVk5ocTVMUXpQcVFDSDN6N0VjcGRjdzdsUFRqd3FIb0lOVTZQN0d2QVh5?=
 =?utf-8?B?WjJibEpCNTFpU0R4TVhLdVBGNDc1MXZFZTl0SUpQQXR6dFZac0xGV0VUUmlx?=
 =?utf-8?B?Z0krNGx2dFBVWXpEYThoaHI0T2dJWkF0MDhpZ2t6Q0c2T2htWG1qbzJFUG9C?=
 =?utf-8?B?eThRRE9zM29NVVBhM09ORHlNWDNjOTY3R1RlenRSbmNqU281UEJIcXh5ckVt?=
 =?utf-8?B?YkZBU3NYblhBdSsxSENteXZ3ODNVYzVtV1ZIYW1UdVEybk9sTkxtRGRMS3U5?=
 =?utf-8?B?QTdyVSt6cWtuRDB6NE5qbWNOYWFMYTlEeVR4WDBqazloUTArdytiK2kybW12?=
 =?utf-8?B?UGNTWnJJclQxMGlnNlJVSXVPL1BpT1dUODJBaUFTMTdFdDZRUUlrZlhoQW5H?=
 =?utf-8?B?Zmgrbk00d1FSRzd4V01uQVNNWjV1ajZXVlIwNlljR1VaL1JLOHA2OXVKSVox?=
 =?utf-8?B?Mm5HYjYvcjgrekZLaXgyV3d2VlNSYkdVMlFabnhmb2dqYy8xU0YyZ2NZdW9q?=
 =?utf-8?B?S1AzK2ZnODV6TDc0ay93UktLNXRtaTVxQ2VveWNWb2VraGV6cHNoSDlFMTZE?=
 =?utf-8?B?UFNjdE9nTGpYenRodGlOOWNFbnRHVnJob0RHN0VFa3k5Y1BQc3A3UXRsc1RX?=
 =?utf-8?B?eTdic2ZTZm5qRVgrMlhJcmdIOHFQQXpuRk5jdktSL2xnWXVJbG1TSDhzTnEx?=
 =?utf-8?B?Y0U5V3ExUlpEQjNWSUJHRXpkTE1pOTdwU1N5ZVp6OXNCcmxnKzFWcTJwTW50?=
 =?utf-8?B?RkthZUpQTWhIWlVVZWgwZUN0c1dHYXV5Y0lPb1QveWlqSDJPNjAyTVhZR0o2?=
 =?utf-8?B?QS9EOUJQUWNzK1FRUmtuY0g4VXdaYXdDK3B1UFFrTlgrNlRWNDBJRVo0Mk5X?=
 =?utf-8?B?QVpub2lDVlhtVnN1bUFBVkJscnFGeXpXS3QxRk9DNU1YMXd4a1RQT0UyQU9Y?=
 =?utf-8?B?Y1ZKa0NSK0hZVXlDTU55WGo1M2lvVXRYamI0blQyUWlDRnphOXpyNVNsVFl1?=
 =?utf-8?B?cHRvMXFPR0NIdkJDTWVrU0x6WXZPdjBKNmpvTnFNMFM3a2VPS25HTnZvWWVD?=
 =?utf-8?B?N0g5QXprWHp1Tm4zRzFhT0hVbFJ6QlB2M0FnVTNCWkdDNEdNN1VvQjl3aGd4?=
 =?utf-8?B?RlNRYkJpdUU0czVSWWlNZnhRcEM4N01aM0J5eXVhOFR5bFVvaDFrTVYxSWxm?=
 =?utf-8?B?Qi9yY1dtajYxQ28vUXEvL3VzOXQyNG9hZjcxZzMwZDYvUG1iaXZtUmFHWHd5?=
 =?utf-8?B?SU9xM3l5TkVGcTZSRXZHTlRTNmQycUt3Z2VHTldpWWNIWldmcTU4V1o0eXBu?=
 =?utf-8?B?WTlTcFdNMzZ0K2VBM3ZJaENaemZxWHNVMHdmZ1Z5Q016WFg4bzE3OFBxL0hq?=
 =?utf-8?B?S1dTbW4ybVd2RXhNUmFmNG9Edm9jZWpodEJTaHVZalhyS3dXWGxaNnp1MkZh?=
 =?utf-8?B?MlpXdW4yY3VaMnJCUTBOV3RHblhDNjB0YlFCQm43am1sOUNPeGJYeGowRnMz?=
 =?utf-8?B?UHRXd1g2bU1oUDdUNGRRNHVFTG1iUy9iV25YRnhuOGJMempUNnNsVzNPdjZj?=
 =?utf-8?B?RGpWajBMd2RkYTI3T290czRvL3dWOXJOdW1JeUd6b0tGKzJzaTFWMzNTWVVD?=
 =?utf-8?Q?4lVIWyCcx3WBci1W9XyKOG+bb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d3754c-fd88-4178-fb15-08dc3d3a63ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:33:37.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1M1+doEbl786LSCEm8555yhKSVmmfdkjhV1fgT8/p/vJJ67wN59Qc2M/G2fg60PnYZK9fn4cBLUsrhTl+pdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280

Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++++++++
 1 file changed, 304 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..78305559f15c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -481,4 +482,307 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
+
+	asrc0: asrc@59000000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59000000 0x10000>;
+		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc0_lpcg 0>,
+			 <&asrc0_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma0 0 0 0>,
+		       <&edma0 1 0 0>,
+		       <&edma0 2 0 0>,
+		       <&edma0 3 0 FSL_EDMA_RX>,
+		       <&edma0 4 0 FSL_EDMA_RX>,
+		       <&edma0 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <0>;
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+		status = "disabled";
+	};
+
+	esai0: esai@59010000 {
+		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
+		reg = <0x59010000 0x10000>;
+		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+		status = "disabled";
+	};
+
+	spdif0: spdif@59020000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59020000 0x10000>;
+		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif0_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif0_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+		status = "disabled";
+	};
+
+	spdif1: spdif@59030000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59030000 0x10000>;
+		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif1_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif1_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1: asrc@59800000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59800000 0x10000>;
+		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc1_lpcg 0>,
+			 <&asrc1_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma1 0 0 0>,
+		       <&edma1 1 0 0>,
+		       <&edma1 2 0 0>,
+		       <&edma1 3 0 FSL_EDMA_RX>,
+		       <&edma1 4 0 FSL_EDMA_RX>,
+		       <&edma1 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <1>;
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+		status = "disabled";
+	};
+
+	sai4: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 10 0 0>;
+		dma-names = "tx";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	amix: amix@59840000 {
+		compatible = "fsl,imx8qm-audmix";
+		reg = <0x59840000 0x10000>;
+		clocks = <&amix_lpcg 0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+		dais = <&sai4>, <&sai5>;
+		status = "disabled";
+	};
+
+	mqs: mqs@59850000 {
+		compatible = "fsl,imx8qm-mqs";
+		reg = <0x59850000 0x10000>;
+		clocks = <&mqs0_lpcg 0>,
+			<&mqs0_lpcg 1>;
+		clock-names = "mclk", "core";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+		status = "disabled";
+	};
+
+	asrc0_lpcg: clock-controller@59400000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+	};
+
+	esai0_lpcg: clock-controller@59410000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "esai0_lpcg_extal_clk",
+				     "esai0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+	};
+
+	spdif0_lpcg: clock-controller@59420000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif0_lpcg_tx_clk",
+				     "spdif0_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+	};
+
+	spdif1_lpcg: clock-controller@59430000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif1_lpcg_tx_clk",
+				     "spdif1_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1_lpcg: clock-controller@59c00000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+	};
+
+	sai4_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai4_lpcg_mclk",
+				     "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+	};
+
+	sai5_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai5_lpcg_mclk",
+				     "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+	};
+
+	amix_lpcg: clock-controller@59c40000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c40000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "amix_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+	};
+
+	mqs0_lpcg: clock-controller@59c50000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c50000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mqs0_lpcg_mclk",
+				     "mqs0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+	};
 };

-- 
2.34.1


