Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333017894E0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjHZIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjHZIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:38:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2096.outbound.protection.outlook.com [40.92.41.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1221BF2;
        Sat, 26 Aug 2023 01:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC2heLubiGjSifoV0Y/m59HKV1Lbg1yDvZrsiXw+wVTYoQilm3bix8USy5u8bZuMJP4Ncv5um3yz4hcwHe/yZQSG9LNcjzw7HtfkO67OcSHl31iVYA9NsCk87mwHYfqHZca+b8pPv46cJDpC8X/jfnwZtIceTBavOMjBtPWvPf7QXSIgtM8T65CFyJDbJchunL7CdCiGGlsuP3Kjz9kmrKm7bzbaDDQcs+Klxkf+wxnKGKiUJTKcc9Bz+XdXkdUunvHRKpcZQ6dy6hXKeSnBiu5039PTHWgarP4ALW9mNgUBVuvK6v9l3OCX9y4kF0KwqwQ5hTEEWAmsRARyVf858Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD7D4hOXe241VESq6IMYP/Kc3DL5yh0Yrek02YvU57I=;
 b=UfAE12YUDsb+87EweA9FZSEF+HhtYa8YBYsORqsfWcagmunBbKtHYxQWHFBMk3Bp42AT+B1xWdLg8w/4P2dugzmhwUvai/kdkyUEQgQp2eMnT1fM3lh0MSK3upMldNe0Fd3K+9dCYbqbSV0LU/euYTf1pPzbvxSLuWqKfvUnur/t0WgW0AeO9bNs7msiH2628T0TNGFgIJ1oA30TXwfBoIkCBvLYzNvzYQRGDR6KAnpKu7OtJ9vlHSYgBBCIMkY3R1EuR2a5yNnkx+dHIx6+99ejN88ys9mh0fo2H9PUgGFcY4bXAa0zlRn0kgR33L+37NRLpAwWkTyHoBKGj1YOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD7D4hOXe241VESq6IMYP/Kc3DL5yh0Yrek02YvU57I=;
 b=CCvz1UPdBx3MmcxDeaTziYuq2cR1scPkfgNY13jEsga93+KbpLqrX7s0ab9zkoRDHpRUQs/63sp/UITlvdeVFSF3Ns51WElw/NphWgx+ubHTumx5+dfjNavfwmNxAnqz7wx8vVuUU6p1ZDlJeGIxfxde/H1F72qruufMhAZEauyRA7FblXOD+uKVMyqfbK6VHrEQcywpy9FEnMCASRqdU4kYbsgQK8RChFDG4fIwWsic7lwJ/xw85Q/2Vu87AjcHmnOsC6g+B14boQB5cWrQ7ySzNin2TWBvuiv8vgOTxyKJiwbfz3G4jDthIYkjzDcP7B/rQZSrFXnQe8PT/kBdLg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4844.namprd20.prod.outlook.com (2603:10b6:930:23::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Sat, 26 Aug
 2023 08:38:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 08:38:41 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sat, 26 Aug 2023 16:38:53 +0800
Message-ID: <IA1PR20MB495310F06009AA884D0612A1BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MHffcNEFutK/NKvS6NUMhf2bYQ9cSLCmNEjCx7FQJQ0=]
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230826083853.136087-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2e1c8b-3c11-4967-3563-08dba60fd966
X-MS-Exchange-SLBlob-MailProps: fNPDeqDZc0IqNcQZ0cWXe5cnwXgLTXMXawnC9DpyrkulOlbW3559MAetkeiX/vvx7VMtdZtUmk81ECGuSBmKlY8ahOtwfP8DAoMYBPQ1Mx0vXK5/7HgqPAUbe2PyppQNJRVXwWjuQ2jWJqZ6d3SjgAQRL5VYO7lsAKfGKAoIRoQD7topwgtbO+3OG2dyk6w4nbCw3cLLakhJWS3/Xkovj0FdwdOnR2iAiHKJYk8inM3JeYc1c2M5DsccQcFdiYvNWM8Q6ilLWLke2X3ZnYrWRxnq7qsE6j3iAN/dlPF1T9qQFfiiqhbMZ2f+/K/mquZfsjnnitZD07GzJlhv0BpeekGxRN4pdSSq2wJGs8vCtiVvAXJxtSFA34TTbO13nNjaaFS7tL5efMPcUcMR/l1FKbP/MVFTy+dunz7D6AHcnQbb8JMWIvmXPUymd2khKmVv+xKLljZ5HBKY5WXzLemixxq6A+E5/eoXo8cdjt8ECiIkCeUZtlQteKc6vU7+rbe3Nr9iZsNzPqp0vwvN0Jo0fromdK03JhPWvYx5cXHcIvqxxTSqyqn9AQcDDTVfUwup6Q7CiNUq78Rj4XY4l9CtEdYtwzrRf2iDXsk0BinOlzomtORpEkJGNotXxJBLcOlA+ndOmHpHS6ezDV3Y0IOVj5qUfoyHqsa05Wp4g39Q0xUxTbzeNnFesNTSoSNpKgQxFmZQNIjn8s8ldID0hZBe4Vc8pYZwdsCnI4qG1kElKi08gc0VN6I0BfG9b/elsCaT7yC7Z/2xpQdSRPo4Pq45sA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xfzoutTd4KbPC8a5ig7BaZCmVs0y6+nriuiDMEPM60MF8DKz1oSm7RfLCo2oo5qJJ0T13u0uxJt5rqmbcH04nWtL4qweZHOTlTcgDWWykt88mYW0R9+ic7j79B0dBiPyOUYvHQbwFB5BhbXdtj+wwMmhhn2JmgbpgLbC93jv47aZ0D6ZcOZNPLNBIjRgydMVbugQUo24WYcxRcchJ+3mkUpcZtdJCrAS9QnWAryz/H9X3tZ5mFZogfuJ5foxKW2p2GCbPo26S3VFH9Fbt5jAQDeH2HSA4Ob5C+zqEFebg9tNwPR8NC2qNYEud6Io7gtctIW5L8+V/CEW+p8Qes5231HSK8/O8VbnFwdDjjdJ/5K0WG8u7tROxT+k9vVeLDk9XWgzrlEeFOmsG4c1UQetuXR7/+Tw8aKu/akW9UUgf8H5+Q5AxLNSWJZZHsaA0oPdU2A6iISqcYcsE2Ruy9ZIegnTosi2CVJDNDa8Bn1dEiEFelRIJq45fWWc9jm55t1nZUqZpdysgFtWFMtHw/ei1D8s41inKebAdYHAZHi7dbusHNf4yJSQiBJdNd9jsHoj9yJtyQJWUpLCq6JYxLM5npy3VrBucEbKF03owJlXBI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RvkwzbWBCRZt3sM5Z39tEPeaVmeKNeDc6g/MKvqGjYyi2a8TWN5BN2lHWa1L?=
 =?us-ascii?Q?QbKZWjdo0XxRZVI4ISz1lqEW3JgzocPuq/iX66KJs5LH2vKVuHVDJ8/X/f9N?=
 =?us-ascii?Q?GwWJ0YYcmsqQFd++n/XYNtGVbNsGwlmTU1RCOIaf9yOkLSD3uu6ZdBGNyeCP?=
 =?us-ascii?Q?TAMd4VvRWx0wut3t4DWv99/Vus8Bk5tK3kHJBuHflT7ovNPaQN9mtmnpfBUj?=
 =?us-ascii?Q?VVoGqeqw47002Zsq3YULKvsCjy0fDYylo5/uwen8XBDt/o4qubuxuCSbF54b?=
 =?us-ascii?Q?dDmhfnXZnShXySHsJ8W5ttBDVJAtq3r4G+uADBDzSiVSPuya3Kz160htYIDU?=
 =?us-ascii?Q?x7QyofWGrDyPPMcaUUZy0XdiYoHmcfcB7KhT84EdicbuSDG1+9S2b1FD3AR2?=
 =?us-ascii?Q?hp4Qg7JPuRbK72O++74LnJ2jyLX3BnIRM6EhI0tvRmqX0e0SRzzjzNjelVmQ?=
 =?us-ascii?Q?qmyNsWZy95u98pOOJN21Lqmvr5bK1XnQMk/+1He6g4GRLK6+gwMicAZ+qOpE?=
 =?us-ascii?Q?suxGcq0nzALS/iBZSLguFUR/Wb39XCa9V9slx8oDkOTRF6ci3zD7ZfAxa+tJ?=
 =?us-ascii?Q?YFHJFVtncp99H58p1BXhLhKwb5/2t4ZIJwg8Ksux6UIXueNudFYiQxmtJfgZ?=
 =?us-ascii?Q?oWNe1aYwgaTvYP3dVmRMluozJsQC2/apGUAbRkeqTS2VodMK3UZlbmyV70TB?=
 =?us-ascii?Q?NpXcLlbqJJCP8wCTmS0CAYhIWbFESg+YpCCJ+Oz6QP/N8mbyPB1Um2XyaKgQ?=
 =?us-ascii?Q?qQnM5djyieWkzQO5dpkadROOleKxNRj3TByGq0PDsKDaAyV9DpVBVGRfzLxX?=
 =?us-ascii?Q?tzLWsoh2y9suQ0WwQqQapFsqvdJ5JGf3wXf7H7XSyrGWfB0fAyuZkcOXL9Iq?=
 =?us-ascii?Q?KjiJKz5Wcx67olGRXMpTY6oYGeTXUaeBkxHDRxhwxHii/vRKsx01N8sr4pY6?=
 =?us-ascii?Q?MhbossKdX5htrJ6s1ck6hmns8k3b7kW7AzA40vlpLSlsOeV1PurrJbfveXWB?=
 =?us-ascii?Q?NSH2A8kivhFao5u8eVWtOonj2Lys0JR6IYRx2cJ5PQv3rdXcG4TwrxN8qp0t?=
 =?us-ascii?Q?CR1dAjn2UBb2cSOELoskWIJaHV9UgN7e+jn2kE22gh06f41GbRgWLDxLE0wJ?=
 =?us-ascii?Q?l9CbAqPsjd7cGgqsdCjW/sKdW0Wt+pbAHAdRcLtEtD+wLOc3s+Bs6ONMjEsP?=
 =?us-ascii?Q?KG6pyoIIS9bQ4ijGXNTQmiUHYWXN/nGJ2WhqkUOkzqnRXGlQ1KjBfvoAyGY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2e1c8b-3c11-4967-3563-08dba60fd966
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 08:38:41.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has several pmu events supported by opensbi.
These events can be used by perf for profiling.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977..d9031ccdec89 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -72,5 +72,45 @@ plic: interrupt-controller@10000000 {
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 		};
+
+		pmu {
+			compatible = "riscv,pmu";
+			riscv,event-to-mhpmcounters =
+				<0x00003 0x00003 0x00000008>,
+				<0x00004 0x00004 0x00000010>,
+				<0x00005 0x00005 0x00000200>,
+				<0x00006 0x00006 0x00000100>,
+				<0x10000 0x10000 0x00004000>,
+				<0x10001 0x10001 0x00008000>,
+				<0x10002 0x10002 0x00010000>,
+				<0x10003 0x10003 0x00020000>,
+				<0x10019 0x10019 0x00000040>,
+				<0x10021 0x10021 0x00000020>;
+			riscv,event-to-mhpmevent =
+				<0x00003 0x00000000 0x00000001>,
+				<0x00004 0x00000000 0x00000002>,
+				<0x00005 0x00000000 0x00000007>,
+				<0x00006 0x00000000 0x00000006>,
+				<0x0000a 0x00000000 0x0000000b>,
+				<0x10000 0x00000000 0x0000000c>,
+				<0x10001 0x00000000 0x0000000d>,
+				<0x10002 0x00000000 0x0000000e>,
+				<0x10003 0x00000000 0x0000000f>,
+				<0x10019 0x00000000 0x00000004>,
+				<0x10021 0x00000000 0x00000003>;
+			riscv,raw-event-to-mhpmcounters =
+				<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
+				<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
+				<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
+				<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
+				<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
+				<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
+				<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
+				<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
+				<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
+				<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
+				<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
+				<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
+		};
 	};
 };
-- 
2.41.0

