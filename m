Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB84813018
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573050AbjLNM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573001AbjLNM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:28:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCEC11D;
        Thu, 14 Dec 2023 04:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdpi7Uy3ppXkhN42q7GqvtNYgpadC2kYSFN5xq+5ZZLOWA6MLaYobhHYhEwIjAbRkbQKPD1wSOVzpgmGX2zawj4UkBZ3ejF6W62+h35AFz65KTV7O2+pY7LaN/DYAbaOMZ/Fc2os8vPaeXrYevYa6TMxAAdwzuHTTyFJJbKkdDKcNbYERahxjC8F+o6g1su5hlWoDphFLkMRotREQwVx+W2ixg7sBE49stLCriszvcJK5ZqlTG8JTYTzzNCZ1j8SJzviCC1ZYRUgUYg/BZmEdMY2MmV5El6sj5Y2whsvieHK8KdoiE8syHvz+h6OewlPCa0S0cAUY3l/oDtD9Xf2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es6AFBWC5C9c+MetW7eHK7A12GsBI6/TnXy+EUpugIs=;
 b=TgBAOZtbQjJHmgxd7LkH2Z3kP7NSnQTNx23EzbCkb3pQ6swJkBqLMmKORl0vAS0kvIBPd+OJq0m9/8x7RZ1GyltbTZcXk/RIB9maSt0OeZam729WjZiy6oQ/HbDSMh0tuyUXa28RULcyqKhxk+Kxt/JCy9QzH6/WI80v3b9Ib0b9SPRawMehujxg14VCPHK6g4TjE7OJKKFjzCNqbxqh6uoOshCtM0jVPAOfaydbDP1yRMg8aSvZyBVO4yO+LZqNoJfeDiSEX0hp3DEMp/z1CI76L6SwuU5B0dOOOYE3xvAI6Q15UorPw0KgYbG9RTgbWuWy8Dm3/8AF/oLgBwZbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es6AFBWC5C9c+MetW7eHK7A12GsBI6/TnXy+EUpugIs=;
 b=R8F8Q+h5GfOf5MsQiigZOac/RF4hclThYF1Z25svztyhLjY4mOH5iwBn50ITujFC0C6FXzT3mxXTKUIQvjYVrLD6K3x9glLxlf9ABtGp/lX60ywuQiZlElbxn5z1oT5aLH25XfKQLoxmAG9WQmmwV2JPORSt5xUQpZ7JCdrJGlNshxY3Lnr+KEsJdYFm/SS442JuNq1KKLBci0ZTiDU4x3DKXDLlSLuUSmJCz151oD7GRz41RlK00dsZOfKhF0fi7E2ioZdBLKC+IY91b3B73zeV4BJyt2aZLdimSOEXiyqb7ShvmRWCRaRG//TNVC4F4IFDsB/fHZDBQi1RnLenVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 12:28:44 +0000
Received: from GVXPR04MB9780.eurprd04.prod.outlook.com
 ([fe80::69e:3527:b31d:9449]) by GVXPR04MB9780.eurprd04.prod.outlook.com
 ([fe80::69e:3527:b31d:9449%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 12:28:44 +0000
From:   Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
To:     quentin.schulz@theobroma-systems.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: make Haikou buttons compatible with "gpio-keys"
Date:   Thu, 14 Dec 2023 13:28:01 +0100
Message-Id: <20231214122801.3144180-3-vahe.grigoryan@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
References: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::33) To GVXPR04MB9780.eurprd04.prod.outlook.com
 (2603:10a6:150:114::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB9780:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: f66ad913-7a98-4f10-5395-08dbfca035bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkKn74HVjuPPPPg+nNPFjQ/SL8PxByfzZNNelv7iPRP0lArcjop90UGgl1Kbw/i5WXdd5t/8bFxvQkGyNWqYUIvKbJemTwiiVumXWtWnVtOKn3r1qNVvdOe/ZslhG0r+ts6JihmeM5MQXSr0kEakcrsjIkX91N6Tk9xDkcz/2F/22mlcnCxwrZg5EOeDqqX2UkbmXHG9JTETbkxjvl6SuDpLMzW5Ax8CfgPAVUhcqAZsGUHpYWTG96H/HYv0UePDNL7xmbh2LHZOUIiDISJSodJB758xJJwGSnJYuHFWHyZ2s0Ru+v684tWJo0cwbPZ3ZM2sCL/IE/LQkW8fAj7nOP1TQUhgSUspjBjzvjLmzr4aqdJOV4C2jl9jDZFA5y/dEg0Ehm0K/65h0aZNRAtvW8KxLX9TiOWR51xlC1rWyDqTjP7ZbhhBiP/bPUk1ek1G5Di6T12pR0Mbm4DK0sRJpxE0pZox7XBuw7yCEp7Ed2/pCTrAuxzhu/11hvtj/7P32HRKs/2PqEX2fni2fmuGunni1k8qHXoYiKGJeDmVR8dXSDD3m/2/vOow36Ei5KtnQRIiY+xCgYBFD2QahFksNaFNswZAQDpFY+CscusTKa4G+uqe3O48/3W11sqOc7Iq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB9780.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(6506007)(6666004)(6512007)(6486002)(478600001)(83380400001)(107886003)(26005)(2616005)(1076003)(2906002)(5660300002)(41300700001)(316002)(66556008)(66946007)(66476007)(4326008)(8936002)(8676002)(44832011)(38350700005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lc3qBCqXfs6jgvsS6wZngG56dBP2inxqQS7s4viKVd3AbAxdlFs+8c85LU8L?=
 =?us-ascii?Q?p3UOGVCmtFeYHOIqbTc3yKyV63qbyZY2dYZoq2/xfj7HOA+9VAaWja/UFP9i?=
 =?us-ascii?Q?bIeeTIGhoZ6LB7S6WVP2J6G5hjF57WK7PIwQOA3yx/45JBhJScsfIYfwBjBt?=
 =?us-ascii?Q?OGyLpYVLH1TNdSDpvhjOZsK7cT5uq7LWX+4A44XuerjjqlsXB+RyT0JAUKh2?=
 =?us-ascii?Q?hUDCM0Wl1U+iMPVWkR4jMsZuyqLcuBZxZ5OIWpajEGA8tFayq4HqnPq5+20o?=
 =?us-ascii?Q?UsPI/JzV8lvV5CkktvtT62NKeq3ziEE88yDRpq1RHL8F7IE732Fbo9hkV/vC?=
 =?us-ascii?Q?pp/fLjvCX4Dwu8QVNU+pEWaA0u5SuqcbIxMAoZEsynTUp9r7H1uvKPPMTFDp?=
 =?us-ascii?Q?iqioWvgwVtCJ10oxX1PEHzdg3McWmVbjVd0oXmmo9eqJvEE/NZr9+f3bDBkh?=
 =?us-ascii?Q?ER4LcbPAPkwAyM9RVHBmZYnmBUFamXp0d5G+YoHlOA5DFUjuhdJkYYdnwtVD?=
 =?us-ascii?Q?zeJrl1ohrRyS7EZ0XojH5KTeZ+qsuSUySl+Go1VX5q2LVyCR+uu6P/3QhfGL?=
 =?us-ascii?Q?VE/NEceUu/u8IR16l+kolASXm+v34qwYsePs/GaXAJnDgX1IBBCV0GuOMXEC?=
 =?us-ascii?Q?gBXeVrn+JMQvEmz3mxL5KTMWL2iYGbwlHj7gdmXnbiiSkogEMzDknx2eSugs?=
 =?us-ascii?Q?s0/WgG0ICtqn0GhVEWAYXUCOEJMyljpWjqyNNOYMNtlxoaG2i7lFAeJkmgE8?=
 =?us-ascii?Q?SO4rhQxTUMaM8ThV9T9TsxZdSI2xByFKuNxzsj/jXAu13cXEPm9AQRUi6lGa?=
 =?us-ascii?Q?11LkeYkO/KVHfby+ankQ/Rf44t0wHCO4CvRnRm3ga3YfjrAvuunvHB8WUKVd?=
 =?us-ascii?Q?SDcR2AyOY10tXJ2Bn260hGKJDijWK3PW/Kywk+tEzNw71qM/sx9AxkLUGwrK?=
 =?us-ascii?Q?AAgR+8lffqkoaZ1CctjsMDI+GzKAD5JD+Lg2ldI9gdX9y2Opgt171tRE0cYn?=
 =?us-ascii?Q?ntqiZ0XP1jpi2aI5JDXfHGpwJKxXnXydaELDEPDI3s2NUnQ+MYObaWbOQkcA?=
 =?us-ascii?Q?WKZmw2U4XYTywdkBSVD1X9/AqMuOcbIg/BQvzQ8zNuCJ4yK2XTyQoWIkm0Ke?=
 =?us-ascii?Q?2w/QWBIHFK5P3NtxUpagd90+DB4iNq7apN3maMmK2yi44+OJcF76m/ynKGEd?=
 =?us-ascii?Q?SB0Y++152Pm/tndihSSAhEOqHbGn88UVJzvJWU3aaXhkMGQVUgpzMU/Sav23?=
 =?us-ascii?Q?3wJ0Nk33pM3cGzJNgtNJ+0zCdrIzxCMRB3ALC+YcLnixErOzBU9KC8fDfY2K?=
 =?us-ascii?Q?uRMq0LgJ810VM+6NKJ620DL4UY4qjWl/aH/L0Xr4ztmY52A7y/pl4DlkwdrC?=
 =?us-ascii?Q?tYbCs3ql00zbHCM8jKYUnmAbHC+3VQCcm/Mi92X7hVl7cqE9eQsJCh/JTFcP?=
 =?us-ascii?Q?qzerhVnMVx5p3XymbtjWHU9SVqzr1A/by6PUZgGeXhfAEljSbgMqzr0Fn2Db?=
 =?us-ascii?Q?tbuZzi/5P85b7qyMjTjs0pTfLZnBeq9Fyn2jLiH08LFTU2CpJ1kxIyXr7NC5?=
 =?us-ascii?Q?ViNSx6QGzBEDMbNLJateUDpWHqMzHIvJOzl2/S6WLOT1c6gFFpLIuvHzYKEa?=
 =?us-ascii?Q?F9A1RiV6EFnL1a9eb5+mMws=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66ad913-7a98-4f10-5395-08dbfca035bf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB9780.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 12:28:43.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXTBF3U9eSkPoqXsJOFQnssEDt52Z7oUURcTgg72dKfxFtkCqG4hOnb8ykmShF5f0zWuc4peGLr6OjAFC0P/b2i6aWTNsJyeJnIshfeSnXL9BbGbVycFozkauEG1UvWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haikou is an evaluation and development platform for System on
Modules (SOMs).

Haikou devkit exposes multiple buttons so let's register them as
such so that the input subsystem can generate events when pressed or
switched.

Signed-off-by: Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
---
 .../boot/dts/rockchip/rk3399-puma-haikou.dts  | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 4f2d4bb12032..18a98c4648ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "rk3399-puma.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Theobroma Systems RK3399-Q7 SoM";
@@ -18,6 +19,38 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&haikou_keys_pin>;
+		pinctrl-names = "default";
+
+		button-batlow-n {
+			gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+			label = "BATLOW#";
+			linux,code = <KEY_BATTERY>;
+		};
+
+		button-slp-btn-n {
+			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
+			label = "SLP_BTN#";
+			linux,code = <KEY_SLEEP>;
+		};
+
+		button-wake-n {
+			gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
+			label = "WAKE#";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+
+		switch-lid-btn-n {
+			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+			label = "LID_BTN#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+		};
+	};
+
 	leds {
 		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
 
@@ -165,11 +198,8 @@ &pcie0 {
 };
 
 &pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&haikou_pin_hog>;
-
-	hog {
-		haikou_pin_hog: haikou-pin-hog {
+	buttons {
+		haikou_keys_pin: haikou-keys-pin {
 			rockchip,pins =
 			  /* LID_BTN */
 			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
-- 
2.34.1

