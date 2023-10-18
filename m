Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B087CEBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjJRXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjJRXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:20:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2103.outbound.protection.outlook.com [40.92.15.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A60138;
        Wed, 18 Oct 2023 16:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbRZZGUh9a+9h7cBkxxr/x/eq02AnZb9fjkgAeKml6wu0BPv4WBewb0uLpmVssHDF6KWY2WUeO0duVVaFPX6zjRptytzaOIAyLCz0TPivl6J8PACjGM5QIe9KthjvVT/xejvmxoGX9P7HFUCc0rJgu5bKg29bk4eG53d0pXJ07L6QXVlYFzDZa33t8YvmBUilslwuvmHyfBU7q7Tow9kwWRCzdYKO4PKFjazM/l3mFXDNZByC2dYpM8POOy6Up+7hARl5E6RJDvu4QlD5YiA/0vtREdavpY76wcISQkK3fn+HKxmLTwzn7rsEy6syjPryad6Aa7+iG0wesPdWsfelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCQ6+teeeyU87eAdJV4y3yq9aaBdeGfSvjhZ5L1ewqE=;
 b=Cuh1cJfubNmPKC+aNaDjdE0K1BwViBZ4QDuxzudR9cC8ujNwWweQSFs10LbhIVqG/lGN5BENkPOsIEqu3yHWxDuNxVmc4ql2/FW3cqgAtmu4NhIeIM7np1uMnJdMEpEez4pTCGxd2QCycdheDcYX7NAKh4Bx6On2OCvdiiSNgk45MqE6Fs+CsVGWBD+HMYRelx9Uk8MnzfxO0dccQuwa8+Cpxw1FPAIu56JnU08UruhDcfkRWXNZd57a+sA2ADVben4dInY63qID4KHzkHVsGUD5hbZuRcnRHBCky0e7eOiiPSoSM7w75eMA8JboyAkv5s+b8RnV0pxi/HkWBllX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCQ6+teeeyU87eAdJV4y3yq9aaBdeGfSvjhZ5L1ewqE=;
 b=SP5+2I2Wvpnk2FDUdO+P5xxRLGKetDrc4zJto6jrsycvyEBLfzCKFJ+yoyrfeGuooe5FKFFsOHhfdEpsCVUCjYpU03sKjkVevpx1QiJ3C+jb7tw3R38G2wCu8shew+3Vn8RFtZORlo9QN4zFOpWa1OWYRYi9M1E73HK1NmLTjZA7NPpx6NIOmfho7TwWlH8faj2cLk5Fgs4svuGnEXC/4JQY/wDCRMcWCLQrW+89yaQRCqUYqkqz7XrW45G171LiAtIM+Thqp8V831L9HX6pYBy2uyxHEu1iU2huI5+3GhlPSmQfYDNPCTAZM66g7la23JUJbnF1j4nj7zXBIUFEQg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5087.namprd20.prod.outlook.com (2603:10b6:8:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Wed, 18 Oct
 2023 23:19:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 23:19:04 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
Date:   Thu, 19 Oct 2023 07:18:53 +0800
Message-ID: <IA1PR20MB49537B6A093A491116442709BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [arFDtoEDi3qSbqIcO2ZRPV8tf1zItChVV3NuhPD2eG4=]
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018231855.28472-6-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 075362a4-06ed-4427-f296-08dbd0309e6d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+jP4Ymm7led0hlDpKxuRxHG5YPouLLAx7pHoszD3tAGznVqRpqbrcqRMIgJBGopE6BmXXZbKUqp6swtEMg5hfgRuNt2diFNV17QTv5Ysq3Rq6Ba/+KkuI62PTT8hBnEJE9aVtQd7l41iNdKbakdOXNPq9g0YCA2dBiYCScP5+LvpDQ+/sn2ad092HoXWW5TWSktnvzO1YwnZu1MaeUgLe+qk63+UB9yfESV0vWSxD7pPALSQO4Q7L2hoP7fj63U26+gX4mkKTXZpp+dNTG2b+n9+vIn3rV/moUhLgwxbQ18/sjWng25sFmTE1sb3rSu0WrgLL+2Eac2+Ob1bK2+rK7DFc4JoS6OtnlpcaS4tfIOGeopj8i+BqoadsUwW1tLtnzMfH6oXmXfR/i7X9HJYC1f8DKFqZrTCDtI1am573orHI2g8Wn0+i4iQN4DiYX8S4vjV7aYwgVqQkIxUcsmO9eozLX3ZXCAAd3K9wIdWhIEZwQTiyi16SWSEPeDeLKDKYSA5o3VVRmcYlCCHgeXktPmk+Ey9OzIlXxqC1Z1XyQJ1dZ39yxKJjLwQ/Rmrz3iJx6YPSiIuD+F8zZZjmHRQYUYcztuKgH0kJPhhmmf+VAq65/aPUPwfV9x9muTHQTQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEO6l1ei+TIanQa8Jycq37s2vNvXI1Bgx16reAmRkGnoA0bxgJ5Cf9T+13Yo?=
 =?us-ascii?Q?YHWMjX0rFBdjJUq8Ujyw2LaoJSSpLJ3NfvJQ0a5FaEPF45nRz7j6b0MOInod?=
 =?us-ascii?Q?eVlMU+3EDy78Yg1aslU7mnIbz+82798cSWyQK1QU5DKV/gZoS8+pqaZEB1rc?=
 =?us-ascii?Q?/z/NSOX/rT7qd3zTwKY9nEqV5LLTCmLh4cTAQKA8CL8QhVNvuUpvTXp03sI/?=
 =?us-ascii?Q?7WnF2PkpAnTSXoDB/ipkQO12Zk5w+3EIsqLkmIn5QfqMb/u29kMu24+0hYh7?=
 =?us-ascii?Q?QUD80LqHEWPNZiPS5jiyuk5iB9g1NN6/l1zlh4yHdIf/ln2yup5uNvtFcXJr?=
 =?us-ascii?Q?ZsJnk9IRqKP2B51eeHvv4t7Y+gogARqK0GrSD5Nv5rmGXBHXvVGHNtNaJG7C?=
 =?us-ascii?Q?GUaa/5tXJJXJVwbJZY5yUrR+rKgiF8p9rMs6T1jg+4ty/pu2FxvuH7tQ1At3?=
 =?us-ascii?Q?uEt68tLwA6O/hOELV3kUPm4ss5ljGzzQU+KLJ/T/qDWWLxajSXOY12vmMK8T?=
 =?us-ascii?Q?zCUVqzUrCVfaVGxAXmJqHh3g0wAijwfzazLGR8ofBQAboq61xXgYNlJ5/OQL?=
 =?us-ascii?Q?oFnEyZi9EtFkEgpIGw4bSqn1vHevqCIGVFwK+d+ieYAgt+lv1HvHQD35iP7a?=
 =?us-ascii?Q?6znTwTcnEvCGsGdpmyvmwzQ7taOTghbMARoMyz7HQTqOpWBJKNRqYPTXy3Kw?=
 =?us-ascii?Q?4nsfKgugineuIhgKnl8388hOfUJPMmsBxfBW3/o6ahienBvBAZ6bNu2fLlAs?=
 =?us-ascii?Q?LjI1VJtdhSbcwJ0r0trMmbHEgPV0tZf0pzdHtRYTFWZ4uyvbhRabNL6h2fsH?=
 =?us-ascii?Q?IschKUt1XRDDK2ckxeP30+e1t0DhXzTCJoFNfJlsoD3f4wCcMDUSnf5pK/mH?=
 =?us-ascii?Q?EwD2cwjSGTsrWkAoQkEtjk4oUHviDK7tsPEPUGcraNpYKaNcEb5wgVss3SOX?=
 =?us-ascii?Q?/G3d1tewwNqsYXJ7QBUYx+xnE0BGPAHnzZ6jlvs0KIUFS84b6NNS5TAsEKFa?=
 =?us-ascii?Q?S0D9hqqwAf47hUbl6wy10nR8O+L3hi7aIWMbzzydlAxBZ0lIj+vcan/K2a95?=
 =?us-ascii?Q?RlnANrsKreR16DTo2KmBPvycPXnOF8/rxVFTBVL9AXVZwqSakPp0YN23j2BY?=
 =?us-ascii?Q?a80QGb/mYRHYKwTx7UFeeZb5mRfnVnZPm1SSZ9TOps9UAJcvQPAJ3NJX0MEu?=
 =?us-ascii?Q?3RI9NySPUtPpaRVloOYti7Kgalr4e+RpYJiYdOcj925qXc+yL90vAOV6PSM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075362a4-06ed-4427-f296-08dbd0309e6d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:19:04.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for the CV1812H RISC-V SoC by SOPHGO.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
new file mode 100644
index 000000000000..3e7a942f5c1a
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv18xx.dtsi"
+
+/ {
+	compatible = "sophgo,cv1812h";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&plic {
+	compatible = "sophgo,cv1812h-plic", "thead,c900-plic";
+};
+
+&clint {
+	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
+};
--
2.42.0

