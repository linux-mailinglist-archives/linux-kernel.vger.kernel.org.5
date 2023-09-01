Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD078FEC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349917AbjIAOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbjIAOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:11:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2100.outbound.protection.outlook.com [40.92.52.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972F10EC;
        Fri,  1 Sep 2023 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVWudaxTg8fVpcvjr3+7qdrtjixA3sNzAVl1GegDOeTOBlL5JkgvhLyAjzoh04kwK5X2M7WemOSmhAdi1upezARv0oi5Al2NzMep3QEKsJuRp4inY2R66MfFeg3jQbiZUFntmgOyjD0X+DSCRnmb+0fI2zcEelhZhfg3ei4DSS0b5fvv2Jo8dN1jkQZQ4rvxjfeFkkOgD61hUCbVxWwYQFwWMH3KtnehbWE4sfIG0ZZaM55X6S5nsbzDmgdQgZwhtX7+pmmyTafcdk94vQcqqtodNvJxtPEESqrzVVTbg3D3HGJFuuXTF2AuV3eH7n3hiwtfo8/jU2vAVR2pbjcQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrxVFPxOA8rgOiYgHfxiRF0INYUWD8JjWn2H09fdRYM=;
 b=EotYZf8P85k1fJ8K6QfNkeLoF7TNVBq29EgPy0SK6SCF60jok9eR6dmlCzz+ISUh4q1mXpNw2t70WCB6hUkSoFp45HJyuHePJaUDx4kWivceedG7Pfs85SfkfLyD5xFDcc2gdblpnNV6dSCekuRkGrzJRa25yOXEPBw5G7wggLT71x8uwM5qrxzH0gYkeCFnNLWmLLnu6rIEp9TP3zrfgON0oe6Xlvat4n+X+U1Cg2YVUIPRan0dyMq30ZEAnPqxfVQEt2Otiahjam21gVtJyTZi098cpQ2DhQfODbjG0658S9uz8ZV6EaVA2kosIF+EXcHJywu1zkNI4Swd1F5HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrxVFPxOA8rgOiYgHfxiRF0INYUWD8JjWn2H09fdRYM=;
 b=dU1e2OAMvl93OuqQLrN43RWsXFBls8vHuUE+D2v8rztL5Hq0vmtYDUEaYrtTVBfO0DB1EEHSduitKnWeeOpBsxeqffKX7cl4jGeoNcxSJcBHZZe+WgqsC9bgDvPETuXk/UO2bGiI4Q/6z42+38Krq9IcO7F+fSqhAV998vbw1T0XzWOqkAiZ96lOe3YAvCbgnljNeGT7i/OwmCffqjRCUi1vVXhjIUVdbY3ypRsKs+KJViG0UOXFNOmwpnzVlMIu+HNP92F5hDCS2hsGRkIFb04cqUKpdxhobeLEQEC9B6VT0SUpbgfC4y/hwfcZUQcSS3ANDncQDY4257a2IWwa2Q==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SG2PR01MB3708.apcprd01.prod.exchangelabs.com
 (2603:1096:0:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 14:11:08 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 14:11:08 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
Date:   Fri,  1 Sep 2023 22:10:42 +0800
Message-ID: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [goJzEa1HI8zmfnpTu+7hRD9f1kJuvQHTD+COuP4gzLCLngiBi+fUBw==]
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230901141042.1333694-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SG2PR01MB3708:EE_
X-MS-Office365-Filtering-Correlation-Id: f0786a0b-1577-47e7-4a11-08dbaaf5499d
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmoY4vkZoXkQjSGaegPD/PwJbO0RmtOC6dXHu8Lgs2e8ue3xdn/dkXKN6A81VQDacrsW2bxhWiWdrV9AM11xEHqFUSWUWeABGnhvPoWV1CQ6SqcqXCyVHtTeoXV9EHpTBaZJJnm+m5qSgT3OLNTJ8z37u7jm+tH+PqNj+7amFiMCzdJdGQPqTVoo9dV+NY5f1nL5mOTa5yP4AxQxXwsyWaobAyzes9Dsmd/GJrzoTQXBSmYAuN3CECP3R3rEe6o3TVsKiZvdUgokwh7xzote99ONvvVieKp7FdqGofRdfy4r7V5eM0YxhkzKdBJ65FxquSulHYdRmcI+XeoW/SiUV2HwXb67JgVFAawUyiAbLSrMXJbDJjE8M3mZtwtr8bsG0Ptc3kj5PfbT1ykt2Cs0MxEuwUnnOGMptbywKUd1qJsNxE2E6zSKEqpohGbRO/ctxjnP8pqSmhqzPuiF3Yt5TrS0aS7cy97YCk3zUl1khn/TJWLeFTrUFJwKd928BbHo9xUFz6ZPx7+Mg9IVkCUT+rxhuEkdAh6JZtqy5b6elf1Ly96pYpe3dSY6qPaWP+2TvhmNDE353+QtW4tCJo+i+lExQJAwAvo1rz0+8AEzQ0xux3vU3ZpgcIycV3VVAP8fFI9UHhkoBnuR7AjBi28sg8jrcxaWDLOAIs8I0mk87QaM8cRLDUXB3OmJSc82FCoD5Ju8k6REsywXT9DqkULmOYTtxYoSXfF/kXNTDWm+7Qe5K024AInpeeS59ZQ3OZ1WtRw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zDOXpsaTJdI+NU/ptN+qJ1OZkel7Xr6Txj7kDeUCpHIX7yiESvzpTBmOgwyigSM6XTZYn1ozc0ODDqc2I8jC1lx6LijNXE0tsgiwYmvTrt10y7DGi57qIK2jbeLZUaesRqCnfoTqyS3ULSJsv0EbVOlI5ouf/Iw7N63k3QZDqBEBW/UdzX7sW/i3OUQTgldWXfOnIt0kH+nRvDUFe25iz+en0D/Kl4th83kaln98Oyrs5k0kvIUD5DHu+5UqKP0+GW307RrFTprsRlI1fwI0VlZLEvod1toAYpnKmsqN0xgbKnkb6AppdchAlD+XTEfyuwP91J5kjFwZY9szfLfyWsND3HnUsrBIT6WteIhWhomv9tn+rXxuiUMXWUlunMzQUNizSv3iFHooPvBOpC7MM5gRhMH3wqC0LEZv12txn3tjCQRa2cLj2COVWwRJom0biRsJn8uZiQxqk7NdLEJ1G+l6vZKWkjPKlYiw5y0h9V33OMrCTzcbwDAzRSkm93V/yfXA2gEW28u/XuTseAYaDY4M2UxW096LF/+YZvIQljdgyfSF1qCePi6Ho/P+INRZCi2b48H8VRDsUfJ7FlhR+3NZ4NvJcaE/jDOjlNhZ6Nt/ad/GkAWB1zaFgZ2LKj4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxGDfR305uixPTrWwBDuIKgJ/BSKVx8MycYdUgPYAiYJorxnkyhcQIOmJi1I?=
 =?us-ascii?Q?RvbTiN0cyzJqGcpRsxpdP3vxEzs1i9PnmUS1Phhyxqa3gwg+2Wg+P19+1ZI+?=
 =?us-ascii?Q?3ubu4RUonIVXEg6mJBiskrT6rwSotbV/gzCin9HumJ2PxlER9OJan3srwATh?=
 =?us-ascii?Q?QS6IVu5EOkRC1oxCUQML9+70gPbO7Ril82Lb4J9WvOWqF+r8BXi1E2bTx9OQ?=
 =?us-ascii?Q?F2zSwvL9kLBOEkMQZexhL1Q1qBhzfTJqOXFeKX0+AYakqUNhTdB3kdLxQFz1?=
 =?us-ascii?Q?EEatso3T6eorTyIsHTyK+RPmPVvHctPxFt8M7mJvKoCBdGuFjO1jX/4C4RRt?=
 =?us-ascii?Q?h9RuArD61dYVkHOriY4Tk6HMrbmgxpwlugijrQK1GGc9zNrMEoNARVsEXvT3?=
 =?us-ascii?Q?KIL7NFMRDeX7UGxxK+nhYj+DMS/wVAAVBrf6skqz9XuBxAcHAx5WCKR3/ez4?=
 =?us-ascii?Q?lg0U1IyOZpT5ftUC9DpqUzeykheG+qn59H0jpJaYJ9XIyWePFvd8daghoWfk?=
 =?us-ascii?Q?C/lc7pc5HPZqk8sGOmkpO0mqJ/znVHnG/DYF83jH2aXINtNNNXFSHgkqhRbN?=
 =?us-ascii?Q?zb4eJjbDRo/SXWTo8eL37Aw7nVa4kWQ/NvZIVk4nvGMN4/0XjALCLLM3jVIM?=
 =?us-ascii?Q?OFRVPWqudh5pI4D6BK16HIx9vVHFA/y6RvNb22fPF9uSwy8JhoBl3QwIR+LL?=
 =?us-ascii?Q?EGg3HqVWSlxO9hpk45CHd3ZCX91pJ2FrpkCHYBfosOSdYYrIk9XOECn2i9HS?=
 =?us-ascii?Q?BwpNcTCWhMSVgOTRJxfvPZqPgc2cij+2NCVuNO7aJ5hf3JaNMNoDJJbvELyd?=
 =?us-ascii?Q?+Z6hpFek0Eawd3zD6HnpeQtyl1SiFhUqxqh7kCnomkWxhYYE5zCpQ46uS3AZ?=
 =?us-ascii?Q?uC/v/ACguP0gg1cK59QTwo4MEM4+SApuLAIbHfiM/5MTQgO12xSH/jAzKowI?=
 =?us-ascii?Q?bPjJXP80RIt5B7TZ1A4mYyCuHm7kQ3VuZDbnTLQHTEjn7nTbE4/zhMb7XYTU?=
 =?us-ascii?Q?vt1lH2zHJHdMf31jbXhmnuOFr6vnkbeFhCgI0/54CybZBwkAUYR3A7oUfedA?=
 =?us-ascii?Q?AnJTHOTc4CB9+5Prulz6hrq0EnXplRs6/p6FiPBr75bUnq4O+brcEmoD70VR?=
 =?us-ascii?Q?srcs6qixsvNa+vsoHLGzixMQ6hhwKh6ki6Rb8byup4mYyNJXuRDDuipOnOt6?=
 =?us-ascii?Q?wF2XSHt30ekcSyJrq6Z9vSCANm8NxppvfuYzhqLtoDRzkkUIEYHmsSCAKmz3?=
 =?us-ascii?Q?mxLkICuLQ6AHbUqcXFAe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0786a0b-1577-47e7-4a11-08dbaaf5499d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 14:11:08.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pinctrl, the pinconfigs for uart are named "blspX_uartY".
  X is the UART ID. Starts from 1.
    1-6 are in BLSP Block 1.
    7-12 are in BLSP Block 2.
  Y is the index of mux config. Starts from 0.

In dts, the serials are also named "blspX_uartY", but with different logic.
  X is the BLSP Block ID. Starts from 1.
  Y is the uart id inside block.
    In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
    But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.

+-----------------+-----------------+-------------+-----------------+
|     Block ID    | ID inside Block |  dts name   | pinconfig name  |
| (Starts from 1) | (Starts from 1) |             |                 |
+-----------------+-----------------+-------------+-----------------+
|        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
|        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
|        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
|        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
|        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
+-----------------+-----------------+-------------+-----------------+

In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
by the address), So its pinconfig should be "blsp0_uart0" (pinconfig name,
use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 29).

Fixes: 570006756a16 ("arm64: dts: Add ipq5018 SoC and rdp432-c2 board support")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
Changes since v1:
- Use corrent name in From

Changes since v2:
- Define 2 pinconfs for uart1 in ipq5018.dtsi
- rdp432-c2 use uart1_pins_a

 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  2 +-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi          | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index e636a1cb9b77..e83d1863e89c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -23,7 +23,7 @@ chosen {
 };
 
 &blsp1_uart1 {
-	pinctrl-0 = <&uart1_pins>;
+	pinctrl-0 = <&uart1_pins_a>;
 	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..50b4a2bd6fd3 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -103,11 +103,18 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			uart1_pins: uart1-state {
-				pins = "gpio31", "gpio32", "gpio33", "gpio34";
-				function = "blsp1_uart1";
+			uart1_pins_a: uart1@0 {
+				pins = "gpio20", "gpio21";
+				function = "blsp0_uart0";
 				drive-strength = <8>;
-				bias-pull-down;
+				bias-disabled;
+			};
+
+			uart1_pins_b: uart1@1 {
+				pins = "gpio28", "gpio29";
+				function = "blsp0_uart1";
+				drive-strength = <8>;
+				bias-disabled;
 			};
 		};
 
-- 
2.40.1

