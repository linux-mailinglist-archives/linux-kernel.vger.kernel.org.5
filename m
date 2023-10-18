Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152397CDA78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjJRLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjJRLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:32:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2095.outbound.protection.outlook.com [40.92.43.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3913D;
        Wed, 18 Oct 2023 04:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmDVWHexC0tQFcsTd62SqV/aLT+at3AqjxMo1Zlj+KRRH6/qmn1RzOAti3HRceIn1vjDin9ug7GXU5D8px5WgCzmZaYWTELiZW3hRg7a57cDKkXRkOu0auM8STyD763N7FBbXDSptWI8VE6a+vNeMR667kTlQEI/WVCA/N+nkhKvHqFrrW6QLZ2mBjzUXgcR8HyHdykpxDL6ELtg+7gILa/X4YNrQ43AGadiqpXkWyz/tpjp0ZUMS1/IphIp7EqMmR3Sj2GfrRZSKDgkVn/ZxNQvl5u7GBO7hCkcFmyBlBCgxEHWxZH0MLtYvro0m/oJIZSllACUtna2vhYZ7NzuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxdFQHva1tIfHsLwtonuuEUHgRqniT4rOOd7FVoCvqE=;
 b=NcFv15oY3bkc96bVyWefDUKrxDjWEUUPH0FHaurSs3WsX+yQQYcwQl2WbEqCvgkMtWtkT2oynqxWG53/P9yU0R0jm83NX9sFTtQaDaTRKjZfH3t/s7XZQDso2N7jEkGqpLMrVRKb9DXJMmXoZyjJRouBR6z/7UXDGwEuAfIB5XYUEzvxHsTdb1wh7TP6icFOqyJEsj7bPkeYmwo5KYiPQeNR223jFxsKc3jSI7CkHd55tMYzEkq0MCumNHeHRiuqWKbMte/TnYe7b2mjDW0N9zQ2aSoj5IWPvhCE6/mQ1uO/L8Uvfq3sdqUiEb9fyE7HTEPl1oNZeKst0B7vVku5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxdFQHva1tIfHsLwtonuuEUHgRqniT4rOOd7FVoCvqE=;
 b=V9Wn/6gT0+P8Pm8g6acYWkvDKVs0DL46HjU/cgAXmV2nxRDsQxdH6PedB03HbAEdXzkMyOBrfG9tL8T3DCQfAshSMpN+ktABkc87vvqmSY4NwLDuvLEX5uEBvRjceUTqCGypL4CiJr/83D7r9i8e3Q9THp/kvqKDGwjAmx+c9rlUinadIaC7jAcHkQ1pCzHwt1o2CIpgH2w8Af0g/JrdT9fwZ3faQSzuGEiVwHguAvtNT8lhOYxHowArkoZc6D48jk5jAW4TOuECZuJUuw9KlL8vQjNwiJpES25ZGcIeY58+Pb9/qr0+s2JOhBwAquMGXlEK6X8JdBossQDATqfN/A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4772.namprd20.prod.outlook.com (2603:10b6:930:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Wed, 18 Oct
 2023 11:32:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 11:32:41 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v3 8/8] riscv: dts: sophgo: add Huashan Pi board device tree
Date:   Wed, 18 Oct 2023 19:31:53 +0800
Message-ID: <IA1PR20MB49531A5F6D6D398A089E0F49BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CRhN/S6ZeOCrGtsoa34BwfxNtc1DWL+uwymuLhpXJCY=]
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018113155.1605537-8-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9716db7f-0247-432a-74ce-08dbcfcdf06c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXT2JF9N2kvKdDG/Bj9sjh8ocjsDV1NxwkNaUoNAtcN5jz9rcchznGM42hg6rA5KCT8Au2J/U2FD+gRwk+GIraTnOrMfTAPBsvdQ1kWwuN5bkDYpsapOaKEM0z7Z9gvZp5lJzvq3WV0U+liEkdt+w2z58J6bd4ehcf5vltjazjtrS27nJnof77zz3m/uch4lBHsCwMhOBVlJdSEgOS/mr1V1Tn9swDgsXEppA02x9mBrsxbl2ghYDd6604bkvJhSqzkFBRCr4iFOJqrOmbh01WczhYYaoIwFtF3kGXZqtatRiifg/CTtpcihVn2D2GVMN2s73Z+4ueDb75aCdjPwELLYscrsQcvBvONb1yWYNdER1QG4ALJOBAcPGc1YSGrbjP12M11Zxtd7Gf3VzfXoUqkr0AKzzVYWTr5CMuZd6hu+bY4pgZCZvF8lKs/wWa8Ub/rwnExkgIinHiy5rWsgoxWuYqk4C09FkwoBwdcDjt+QTGmtN4Kxl/GnDITm1Bxwxpl0v8f3t0U9ZCA1AgcdNOHDM+p8LMs3EBKtF7cQ/e8YTpEkwVtELSbN1Qje7AaJd9xk46v0NX3iPB0mNSonA+W0+u6r8auJNQycV/YDgrSedcuBb1GjGLDHKDdrNTDNO/6D8QCc41Md90arMJe+heibqYbGziXACAT48tb3+Cs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kdu1VHYiWqBoOwRty27SIwTGAVR1cXFtDtR5soX7xjgQxiWBwEG1yQeEDD8?=
 =?us-ascii?Q?feyFGpT1jvAgEKstWets/Fh7fSRYqQ6wC7K7LLgpt4bmbbvpuKakxq5Lkay8?=
 =?us-ascii?Q?UEYknTugeykRAsjSD1BjmFtTipz+qVsXi5NbZ9Nbi/imI+dZU6JEagpF8Fui?=
 =?us-ascii?Q?XHsyQex/72k8UhobqrYTWjcQ1yub73WdmHoQ1r3qOpehsAD2XXi2eJ0aOT9x?=
 =?us-ascii?Q?YC+Aduk9NzHmTiXSdDeOypXxrpJQOTTh4EDLGK3gVgpm0mQ+SBivpEamo1TL?=
 =?us-ascii?Q?aKMSJxuuTEKdVf++1/VhVuGUZb3itPGSRWefPbgJkLhGyMmmOcMkqJjXtM//?=
 =?us-ascii?Q?xi8cyTuuqibg9qtb27CCmOJpszpJrz4iVnwOe1j0iEGgK37mAqouIqw51l7l?=
 =?us-ascii?Q?bVAmbvNSXbs9tO+Wcmyhx9nsxkixhESj7A1ayR5qvgUUnmFTqBjvOhufRsf+?=
 =?us-ascii?Q?f5y494FxhhNtACp8YGzTCIN4WgdJb7yGjdfeRmse1lBzOoZR2zsNVFf4LFXU?=
 =?us-ascii?Q?+fmybNqN1Vz+KZSIZjcTx9HpveXxdQlJY1h8kRnbsE9R3tXs9XKM/WN8W9yG?=
 =?us-ascii?Q?Pg51kWrV2n1C1s3GGsrmaosJFGB7s77jJxxLow8eKwlX8tccSQD73GeOg8iW?=
 =?us-ascii?Q?PI2suql/vHM1Dau/Jxx3hTie61empvK3rxd7B5JSjsrOx2RfZythHZ7X0MP+?=
 =?us-ascii?Q?CbjKbKZe9QV4H168XR6lOCSkep6DAuQTvLcpuSCopm8NCciXaxXdibhSejaN?=
 =?us-ascii?Q?pNrbx1biJQmf3a01nYmJWBcKzXizaY3Q75TliTBPDg4iP5FloXwimQHA6WS/?=
 =?us-ascii?Q?Yd0mN1fKnH8hPXbv6vtwrm8nRCx+M1npTBbDYtm/IFUz7f3eooxAyjwA2C9o?=
 =?us-ascii?Q?8ReIwlExPIDX9oXD56N518bghiE83ww6uqQP8Po6cFp6wnHYUCK7NipuNc8C?=
 =?us-ascii?Q?Oks/ERWUu41CShg27xjJA8Y6DqM5QjuPwlXQniI7at8N9LHbgtZufbcg8Vhs?=
 =?us-ascii?Q?rJNBjp+y/8i9n/QxdVyTCYjU5tlruWcFeA91Ik3pjPn849uqN0OyXh5AGN5J?=
 =?us-ascii?Q?7Uhn8RJmAaYPH6nPG0rLrxZpIrBEVczDnSB1BACUqr1Zyzb3JPtiVDPt9aLL?=
 =?us-ascii?Q?L4EiW7/HRlJMotbp08/QPzguXUDM8HXLtZJUC+zxLYI/CsgiI88Aghk/Spbt?=
 =?us-ascii?Q?ugjn8GjYtXsyYaNLex0HeSq8Az0JtPCuvbSWKh8aqPRQtsfI+iD54jwYkUE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716db7f-0247-432a-74ce-08dbcfcdf06c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:32:41.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree files for the Huashan Pi board.

Note: The boot of CV1812H chip needs a rtos firmware for coprocessor to
function properly. To make the soc happy, reserved the last 2M memory
for the rtos firmware.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://en.sophgo.com/product/introduce/huashan.html
Link: https://en.sophgo.com/product/introduce/cv181xH.html
Link: https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/build/boards/cv181x/cv1812h_wevb_0007a_emmc_huashan/memmap.py#L15
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/sophgo/Makefile           |  1 +
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 3fb65512c631..57ad82a61ea6 100644
--- a/arch/riscv/boot/dts/sophgo/Makefile
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
+dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
new file mode 100644
index 000000000000..aa361f3a86bb
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+/dts-v1/;
+
+#include "cv1812h.dtsi"
+
+/ {
+	model = "Huashan Pi";
+	compatible = "sophgo,huashan-pi", "sophgo,cv1812h";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		coprocessor_rtos: region@8fe00000 {
+			reg = <0x8fe00000 0x200000>;
+			no-map;
+		};
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
--
2.42.0

