Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089E80324A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjLDMQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjLDMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:16:14 -0500
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EEB106;
        Mon,  4 Dec 2023 04:16:19 -0800 (PST)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
        by mx08-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B481nlj032500;
        Mon, 4 Dec 2023 12:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=dk201812; bh=03lvoCeQ04hQOY1NWBBAM
        4YDoRPF10gZ19zh9THL3/Y=; b=amaOP77rCcFYGcGkqt7aLDEbVqO0CXaB4NUyH
        fWl4avEUq7ixDjeIM5a4K8laG+8bPOOK5HUQujAGgzlUTFJpMV3e8U/EhaBZsFda
        0+16Rxluq4dZNl5J6lLfCGy/VuvN6M9Dzmu4jz8sQPVobg1jGuMWfH+jiJ091p7G
        1qXXSzN6IgBQ/aImVuDl0q1dzlWOsKPmhDrXlXN+MwGPQxzJKkOg/HepJ3Hj8pMz
        iEFLU0gUPEGmS0jTPncDlqoNiAll11zm2/r024z3KW9ifwwqLwJNmIz36ZETRHTJ
        O8WGkeoea0hq4Gjwd9Q+CqTYKy8Bi0MF/RtBM9I6xvoJBIKyA==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 3uquqss8yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Dec 2023 12:15:56 +0000 (GMT)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 12:15:55 +0000
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (104.47.85.41) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Dec 2023 12:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFljnHCG+jjimHGJkXUUYI0niBoAGe6+2jz9znhtpiNRKKFEEySp4gztmPAXxrwS1w//7JhtY3BCpkgGwrNSwWDT2VUSzcqONE81u+n6R5xMbYUFBvM5CKm+MiaadCSLJyJ8b0Jy9j6qrHhsDW/+2qT4GPFx+4ipSpmlncJRA53h2YxKl/Wznb2d2e5e6CFqqD5v0BzUfgejWxQAe8GKK9P07abvse5VCi17FXXqVAW1odFfYcHZdi3VfiI8CVL3vHe2iMsKMYvn67IH9zD4b1d7SdI10W/zSoXO8669yg4iNJsdNBL6BdevKO8+eF51pC89ydvylvEHjiiX7/QMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03lvoCeQ04hQOY1NWBBAM4YDoRPF10gZ19zh9THL3/Y=;
 b=gEzuXiODcLLJnijPZTqVSsHcSIo+zjebPFpxuZY6+5sXocapaskXzDaWYjn+qvssjSdrezosjJGWiDHADt0zhiOyUHOEpKXSOLG8PPwmnjH2fBE4tZUHj6KsebRoKbOMqyGQkks10MyzMh15vASkwP27OkKimHsb1thQ5AIzYdF6AA+zcqdMqPAXa8sDMNxTeuxHxMBWEKfivMKd6qi/aBA6dkgoEMN7G41b+naB/XZYlZqbSlkLuhOtOvgeoMg78w8jNcx9dh0TtpLuvjC5m8+58Pq+y2wgZkzzJiVREL10IKbLmxycIlL83hcQ9ywq7y+FbAehfePR6eBLeV+tAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03lvoCeQ04hQOY1NWBBAM4YDoRPF10gZ19zh9THL3/Y=;
 b=G6rS6xMv+zYSK6eT4xC1MXhrLoG+bnKKcgGvbu0kt+jAF398R76wuvyIagJMoJC+nh2PU6gRRZfx5AKztJXB6Fn19TvVQR8+t0TmvAk6bKbbxSMGCVirdZlIr7P9w4iGgVyP0dfsGAmpNm8gd+bwfZ5Jj576ULi0RHE0jlfgTa4=
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a0::8)
 by CWLP265MB6561.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 12:15:53 +0000
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34]) by CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:15:53 +0000
From:   Donald Robson <donald.robson@imgtec.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mripard@kernel.org>,
        Sarah Walker <sarah.walker@imgtec.com>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Date:   Mon,  4 Dec 2023 12:15:22 +0000
Message-Id: <20231204121522.47862-1-donald.robson@imgtec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::20) To CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5770:EE_|CWLP265MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd58e93-cf38-4381-35a1-08dbf4c2c30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tHz+SFN7TYakcFGHzOss/vakkfBFDMjmWtK++H5DSp+jHJ65+TDRAp9dEKARsJdNBJ5OysREnArb7BYLagOTUv+qqAJHdbzTbWh7DBLlVdQEDKSoVmfEs4FiMxou2Pqw5sy2uy628U7u/JUPYWUulnahFxWpXm6NphSmwsNowbTV4Xi7xJcNbXxqBjXzyDr754Qadk34aQdcyCLscyyHzGLF0H740e8KN+mmOaRgQBcEZPsnvsrUw1Sj8/bLYRwmjPr3DGIQ8LhDgEt2GNpm98WTp/+mWz3JbQAg5G+9hPysByyeV5CxltlkwkowAWCL7ddQ3xuQuZ1gDiswrSuxWkV3cW87dWFokCZix+OXKhjZU5IajJFG3VYEnqg9/GhHr1eB7eZhmbX+UY+B1qO4KVC8SjKK0CGdItoJn4fp6HbUZTHhZwVKBQ6lSo8WUKiLp1bq5nOl3a8nmrcDVKL6W19NyKGW04KZj+M93mZL3UqK7dQxC9Kn5xMt391FNGFHKSqnT9gD3KZnLZw2KiKomJu3v7wePkihblfgCa7qwjOdTJ/yhGzK0bbk6wZKoXxK+wph4zqgozqK72Hl2vAk8CSO0WACRb8pwXYcopjGm2mlrpYNZ66CSJs/dHaN8Vq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(107886003)(1076003)(2616005)(4326008)(8936002)(8676002)(6512007)(6506007)(52116002)(83380400001)(26005)(6486002)(478600001)(6666004)(66476007)(66946007)(66556008)(316002)(2906002)(38350700005)(41300700001)(36756003)(38100700002)(44832011)(86362001)(7416002)(5660300002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kioflheg2ORRZYMMC39D+qNqPsHaLAip1F5wR0QLfTJtSumJki+oVZ/kbOp?=
 =?us-ascii?Q?c+aw3y1Fc7bFkpKHnHB85Y5gmcovp5fsVfpzuBMxwDw0aZD22LciCPNatFXp?=
 =?us-ascii?Q?RmWVBINcn1B75SfSJei0U0XWVqGOkfKkT2cIKrRLF4dfyC1pWE/34ifSyRN9?=
 =?us-ascii?Q?ySUDOFcmOBIUhcclmk5BeOrOW4RF/AW9ZFK5F0PGrl1GE38EokC3MZnLy3BH?=
 =?us-ascii?Q?1DFzfuyGyF3/bLsH/eo05SKawqrrz5l9HdHB6v+DYYsxGKRzuLh4D060c6Wt?=
 =?us-ascii?Q?5FTZ8qqsc2R+9a9ueyYByCLGYO3+sEMLgKmT52+S/b0p4DHuci9b3/E++eQu?=
 =?us-ascii?Q?IOlTTwezHzvrbOUcITTyL5nCzMwJvkOzAZ7RKLYj5ogzjUpf9K+gDJx1UkFR?=
 =?us-ascii?Q?LNFhPk1NemboB30CXtrM3rPKQrG4O90eQNr+G4BNhbodmANA5j3LArVRLxRf?=
 =?us-ascii?Q?aXRyyJ1uWkyS6FEA5TZuGBvaiuUaL3qB2LEPqkXF76XOejoh0DkAdRlchD6A?=
 =?us-ascii?Q?yWgDHK2MV51/cm57x1nH+ExnEcaF6utGZOU452aPccUUGZDQJl3edn7AKqp2?=
 =?us-ascii?Q?efsahNMFKF2Okx3OFE169gEqgA5dwijj+zdsiO6cntAZ18RSDOOOmgtaUoM4?=
 =?us-ascii?Q?Jd7SN5qTvUXIHorYjiNc0Ja2NqdjQ4/ybcneXEkLquJEZ0LcVzoEYefuIx9Y?=
 =?us-ascii?Q?mi843LoM+sNRzyvXmTP+FzIWNYcKTmJDXhKASmBkS+aOvv6U1+61vJzNjedN?=
 =?us-ascii?Q?JBXFubH9eh/DjxGGHt1UlYGMk+3+UcTeiDXXnHrTjEuZZYYm0niU3Oo7g3+P?=
 =?us-ascii?Q?qRft5MvltAjDJ9CACX2iFBt+uc9Ev0fdAQUhRyyaF5/ClxJf7GQ5m+clNbwM?=
 =?us-ascii?Q?EgaurUNwlk/0o2zx72uO5P3LNwTzKFJcL4RGyQk6Id5gn9/I9pQCjaAlf3VH?=
 =?us-ascii?Q?dg0h+qDmLv+7gCwVODa1PdjVz/YiktLupa6RhJUya5B+h7hp+FUfJuxBhd+K?=
 =?us-ascii?Q?sCZl4oSK5h42Dm4sFbcTZa4IPJ7v/oMu+Ls2s+goIorp1APULv2HxBCs1XXZ?=
 =?us-ascii?Q?UiIKNHiJwSinxEcPJBz4cvE2nULJ4ZwzIWYSnB7Cr8K9ytc8gHIKj+WVIHPs?=
 =?us-ascii?Q?cUkw1e0saoTnNRdG4EEA603seD+rqoUtIeOsHrLoByMP3logUcnI3pdIuclV?=
 =?us-ascii?Q?qqh6otCpnjvm1C+keggYcDRhMAYvL31RyFid3NHep+s6pjCkRXnDwg8kqwsU?=
 =?us-ascii?Q?8uIFp36L/33hgzIUHsebbTg7KZ+x1DxiU82HqT4KJwIJmFGId8a0Hkr+gfeS?=
 =?us-ascii?Q?mHeA+BnPcUdyaESuQlen6BCmjiGxW5fSeFw9xWNxD8pUlzpGVb4Ep2hleqQV?=
 =?us-ascii?Q?g3eyX2aHcfNU5Yu78fsemUa/CAEukJKj2wFT/PgDA7yaPjWJmvOD7xf6MQLY?=
 =?us-ascii?Q?g9wXigWcZn8N2WhwTuLV1lFe+q8fmuo5jkgK4/tghcqTobgtSnfpK6eQ2zEl?=
 =?us-ascii?Q?qzSnYwIMFesuW9qEq5WGHpJW1Tlgn1SXK06pWDvAdeOO1FaXlbzapSU35qki?=
 =?us-ascii?Q?FIP92adUV3MZpqn8XK16nHP7aw2obRUCgf94t+WuaMc9DIQi1niOR750stIa?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd58e93-cf38-4381-35a1-08dbf4c2c30d
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:15:53.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z23racbHt0ychrJeK6xfrmOe7KG1rhxUh+GDGUvvTwwtnB9m4gQXAQDoCbsVpKz7P87J+Ux1MqVjYts9VvttPIfD8D80Guy0NhLa40MgXUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6561
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 2-O5ULT6QSoMNSNHQk0Ktd-eaM9vOMmr
X-Proofpoint-ORIG-GUID: 2-O5ULT6QSoMNSNHQk0Ktd-eaM9vOMmr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarah Walker <sarah.walker@imgtec.com>

Add the Series AXE GPU node to the AM62 device tree.

Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Donald Robson <donald.robson@imgtec.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e5c64c86d1d5..4338fd8ab2d7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -965,4 +965,13 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	gpu: gpu@fd00000 {
+		compatible = "ti,am62-gpu", "img,img-axe";
+		reg = <0x00 0x0fd00000 0x00 0x20000>;
+		clocks = <&k3_clks 187 0>;
+		clock-names = "core";
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.25.1

