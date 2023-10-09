Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926917BD9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbjJIL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbjJIL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:28:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2037.outbound.protection.outlook.com [40.92.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BF199;
        Mon,  9 Oct 2023 04:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsRHfGRaPm5Sf3OxsfdrQR2ZtzXrYgN4+0odumAwb1d7Nn5mB0HTQpTimHSeE+jsZFIeZAxRRNbJhF0qeiDjYXbUR9xXapVFGxPlMertjwgNdZgUhGf2hxx6Zj5sjQlhXG9tuIaFTShdUBM/i4gfqZfnV3BT4vET6seuBERbmpwHPIMnLvo56xXby1CkOg/cf8VD0Ur+ujeNWJ48sPqNNAu2V4V4JHR7jIwHVxPtpRvbIjw5KDhDa8pCaeaf5hGUJ+G4n9xK4IYJG2XoY41kOfPCW/aiPh8KqdXfOfXISslRMbtA0Qc5bv3l0jEUK9SBG3v2iey4bqZkhj11Xnzv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucz+d9gDsMTwGi+uxivR/JBx1T+GhMhp13qikmWoRj4=;
 b=bD+2WqzXmqwlKkdaxRQhRm8vlVf8iUOh+kTUu5FzeX4grx65ztibpP/kL8V26lZSEgLQDY0CNgmIQrvXG0nDC1/fwujZbgk940eFi1BMviQIvadkfPsZS8Yy6kkTXI2ApdUqtBTg0ST74wNaGDkVOMNR2OFt7X556HHXdYQvO2lYA0R7s2QhhtTkbcA7L4/sWvQZjanqKuTGsen2z3QZmAw0Gy3kii5Tzf7DoR0R/jYPTCY3VIV7lC/Rb+w2XScCx5gKvPXkwu8UhSXQsFVeYdqXfnWUzbzmVQwYOiTm1inM+XWBnFFqF3IgXWlDGtXYhkBiT68HQlZWBd7eeeebuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucz+d9gDsMTwGi+uxivR/JBx1T+GhMhp13qikmWoRj4=;
 b=uryEQvWm3R8yURG42FSwfyUcXNdK2CE+lzUWfGPjjv0iM7IJc9CuC8QGATFwR43cSGjcxx4HhoszhPtaYZJmuHG7c1MWkeEkjTDS6BcPOxzhukK4ZSekVaXuFZKYMbn9Z0KhiraYeFo0t10rwcNrfSXwg5y5ffn3bDo6q1vO1Zi/y5zasJHlYej9MTdeOlgiEQ1mrSHKJiw6Ga5LSD2r/4uXU9MCI104u7k7EcS91UOSck2GMUgFHwOP6ILy02If9CiD6D9znpN8hTKIzpFo1Cm+sPF3BONgHxOsnqj7nKDOIZert4h5PNe8n7vwUkzaejaYA0BW/4upzLVstjoJFg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6129.namprd20.prod.outlook.com (2603:10b6:510:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 11:27:06 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:27:06 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] riscv: dts: sophgo: cv180x: Add gpio devices
Date:   Mon,  9 Oct 2023 19:26:36 +0800
Message-ID: <IA1PR20MB4953F4BA74C7E9F011C88166BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009112642.477337-1-inochiama@outlook.com>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tPm0zs4VWjxp+saMIN06wsE9nTn86uqj44WaOcvipoI=]
X-ClientProxiedBy: TYCP301CA0049.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231009112642.477337-5-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d9619c-0f29-4cc5-fe55-08dbc8baaa6e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWq43NEudJFQkhn1vebhZymzW0pjfU3CIpsK8BgsudqRhO/Y7dFL9fWhbgN7nlWXZ65ip7vHWZugFB7eIO4CY8qZ9CbUEkXc0VyWfhVCku8eP3OUZDUH8Qb308v8Vj9LQTT20FT7IUiAB+jhqvXVZx67WxB0NigRzuzyOH1d3n50CiDaV2KK53L+dayf4rF6dHXLp3d+m9FcGQdsbG8ZGbe/nPgAU2olnZlirCG2zeteP8R3Yg5wjmccUuAhH86RU1rRsx+99jia59E5Gz7jRmv1ajVhzpOdXN8ScDokmT27QtX+6W9Z8Jotfz6oVoXoG6+pjP5AdtG7E4Zew+LcjvPCOFvUxXxy2+SW2XTmxl4L0GxIx8MIfE/8Krl1KYFNEYBpq/MOwCiu+o4IAl20Yki85JbvuJTeuhf/Obm8TYwJXLusM/iEbhXBw7Smt5gnsX8oeJghOyD1/ljlmng3Lt21gyv6pHbWVjqrpZ+uuF0NIjfG60DZ6rELyLMTm6TS3LtGCWHoqVEOaJU5RbDpBHOEo0beDAJsF6FTbFfWm2Ie+B86fC8UdJEeGAkSmVkM0wG/N6/OAQd3WR34PKhow2FWWqFLVcRCpq3/Fg4V65Q38R4wAgZzp3AWQkp8lzkw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MrI6K5gD2ncdc28ZFDJmARqp56eKsKqALJZ3Tr29G0lWZDEqiFHjoRJ1Pc/H?=
 =?us-ascii?Q?78VZ2rFoN1w0toVURh1PvUzGfNiowh4hSh1zLgjL6XGX8q0T4E43AUrNOeHj?=
 =?us-ascii?Q?TgJdZ5lUhcnBjqHGQ14t/6vp2O5nkQyYhuOGrbWPoQIDnjzUnjq0mxdAoUdh?=
 =?us-ascii?Q?faC09i0QL4Px7SObJqvDFfDWhYlEviC+OLM+0YdmqGFPdG8Dx/S83fiTD+qd?=
 =?us-ascii?Q?sN3EqiAuWVrnlR6GTyp/ammeZ3ZVaPONuHqDHJmC7BrxkBOtE686WoaEos5R?=
 =?us-ascii?Q?pTgHAkdFlMsmdz0D5R2uEXATh2Wi8ZpPhTFHBLE1zpWL+I1ukJDzAcrVjOmB?=
 =?us-ascii?Q?m11vcf2IwJXVuoFcr9qfPoSzSrN5YX0iQL7l9MWilbEUSzGJEBzhdNznvrac?=
 =?us-ascii?Q?izGHmKvZPqSHsPptE5plpzyxWnOYp//XwOKW6EgIfZxHTV5jLh0emFlH/GTL?=
 =?us-ascii?Q?IrgdY1g9ISyRmCFUX1+wfxonQzc2cjQfOhTxDyz8PTQfmEinCJl2syuaDJIq?=
 =?us-ascii?Q?AY2NEcn2LvN/CJXXteAyNpU/oNYZAfIL/fwXTo1eh71YxRutvQ2qtXAJZzww?=
 =?us-ascii?Q?qc76RVpMxbAZs1GAVujCaJgmL1D8X5N8VFDSRf4wZB3pVd42YmItBTiiFnFB?=
 =?us-ascii?Q?MdGrgfJUXx7WC2m+J39tFDOv5fDFEhNdeq108nCAZ7lPx0nJc5vLQtP+okp+?=
 =?us-ascii?Q?RwmMAVolYgF1fc3oyrEHF5ua0YvcXhAt7ZtToNUAwPd22D/G58Scxg6DnGqr?=
 =?us-ascii?Q?i0+rZWkwVYYjdYPOEhHjuDeNoZiasOWPfw/OajF6EGp3N+Av9ntvkPVRvmEF?=
 =?us-ascii?Q?Wr/03vhyDil/3EnFnSbuDCzkzzAuyUIKlWra8yQliThF4EieG/RQKXaRffdX?=
 =?us-ascii?Q?k6RfqkqroqiE5PzOXxIfcKzgIylTFwbaUPEe42gNLKymYaSvqnqoqr6RdOke?=
 =?us-ascii?Q?wGX23Ve3EfiYTPSiHwPqizhon9zBu9ibDKzctbz8tqEnkHa4g8hoDYolGaxD?=
 =?us-ascii?Q?Jkx4OXPsO55+rHM8C9oO1JdcrJnNMr6AY+SuijUyKvxAAnkGquNDYAadCmkc?=
 =?us-ascii?Q?+fORNLz34LQLGeZBBvCa4ZgnA5S8wV3plBCPXVvupDipH3SrrFDSnU2C8FL5?=
 =?us-ascii?Q?7UQzVsxGbgwkyyu48Mb2gjCcJ/pEkJKA3oEOEmjZA8LqeDYRn4v6XmxJ+WMM?=
 =?us-ascii?Q?bcVGR3BO4UFdwCz/j2PRlaCJSUIrzfH3c8GFmJVkFwPuIPgJqVelkZC+zBU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d9619c-0f29-4cc5-fe55-08dbc8baaa6e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:27:06.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common GPIO devices for the CV180x and CV181x soc.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index ffaf51724c98..64ffb23d3626 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -53,6 +53,78 @@ soc {
 		dma-noncoherent;
 		ranges;

+		gpio0: gpio@3020000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3020000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@3021000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3021000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@3022000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3022000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio3: gpio@3023000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3023000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
--
2.42.0

