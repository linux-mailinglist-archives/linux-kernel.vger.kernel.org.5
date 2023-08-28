Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4178A4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjH1EaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjH1E3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:29:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2093.outbound.protection.outlook.com [40.92.22.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224F11B;
        Sun, 27 Aug 2023 21:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlflKsYB5NJzWocOrM5WDuqAeFpd3+wqI6wgb5UfT47lbjx/gDenvamkQe/siHVSTyazMwsRuNaNhZmk+ORjYAwwdGaratXyJBPmF8jloFvM7rsVBlmqbOFVn+1fqIxcAel5DPGh1ahTJkDjKWz8CqAGIp7ywGo4KZP1Fhp4AX8iCMrQ9RYw5RXkjx6uYO17eVtH/Q8ImJEXnfwEQWQqQGXbfCcvExv/doAYuYnTxUrJoCoL39NaM87K2eJvi84l5AsLhN6XkGGr6lgdZzV0/aAUmVR6IwfcpRdC0ljSMGLvgI8rEVxpCHhIO4jSlGcE6HbJLN5sKI93Y2h2r5HNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NQE9upNQ3IadmN7eI59MzCMkoOLPkdZE0l6EUJlrXU=;
 b=E44lSHnBaP1vYM80jjvKh5jEPyLTLUXqHNH7dPuMAopyoHvkQYFbPNcqjZjEXMx3JXaYNL5u2MchkE7Ke22nNFVt2fj/gp6FFhrnoagU3w8aIspsPKI2I0KNR2krNyL4FxbcV8VpamIQzyFpYYroUp8g9Mg8vcrMhq3PbU4dNd9KVAIVo8364xZaPV1zh6nQDLhSNpLUI4J/RTAhgiQDpLNVk3d6GHgV/AmXn8FW2AEy6jSQJaEmEfPDkUKGCJanDbNdRovRxjgPjhDABOfgnMCqX1SvyM9I5+rubRkuIP3The0ybCsOxSNlLXKvY2pPLixdWvX6FYYMp3GEYMdczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NQE9upNQ3IadmN7eI59MzCMkoOLPkdZE0l6EUJlrXU=;
 b=jiHwIbyw10DT05AHJWbuxvq8Xoqfy8iDNe8Zkz9Fguczfilu5jvml85wwt7271bQzJUmLJHNSgGFq6A455nmf7lYDRCxf4LVxIjmQIF1/16CpHqrGsFoPfDThguvqLcrDJy3Pg79Fk8ByGnfduILoYwuHnogUBbe+8mJSft52UakpT6+4Qa1A6e3U2XcLKQUuioezVAc9FYBcIA2tI9/cQsrna31rO95u6wMR+pRY31Fvpjt4m9sVHEjQpMG3u6uSMT4gKOoEmKui+tszOAT0eloTQgYSC8COi6SzKcWblJAagLGKZpRkcNdlonvYUqAPyeKhkpKRjLVecT5qEpQbg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3381.namprd20.prod.outlook.com (2603:10b6:208:266::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:29:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:29:42 +0000
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
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] riscv: dts: allwinner: d1: Add PMU event node
Date:   Mon, 28 Aug 2023 12:30:22 +0800
Message-ID: <IA1PR20MB49534918FCA69399CE2E0C53BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NJyrwR3WLTYvrL3WfJLhyd9GOjEVD6HUdBDM5E5jJlQ=]
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230828043022.252724-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: 1994859a-7c27-4fe8-a5dd-08dba77f6620
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4ECsMdgbaV/b5CZ/hsW+YdiEPPQHgZGV3HoWHQgVcKP+niRMR92j1F4q8YNfbLB69Z9M5zm1MiasBr57csq3RvqObwi3B/pWCVmcNbdBlokxszblaISj7RWQkyJupb9zp0ZJUx6Gxgosw2tcO+23mVzzNDSk9Z5uQOzFtC6a30O/Ckrho95JzromeJbmrHVoJmphK6XaGwAWveuSu98iAr7xSbJmXuIc/mg4AM7e1FGN220fUwyP3Rky1xf7gnpjOcY2kcsElOR+Vgq7y3Wwk/FcvVILlh05Ke+3Hk07wmiHLOd6M7wZPXqu6EKd958jD3yjwv/CQwqZKf9vOm2436LvcZmIkVcfGOs5HK7cz9iDMWhdUT70HSujp9I4pmLSTYEdPlM7ITZmcI3CNFq5IPKpQ87TBIPb9ybsghAk7KkqhGnIYjOzvNQf63w0wAj/XM8oTQoZAsZFN9+1d1LwnAeES+TqBS3QLX12bR4GmgXmMXzMaxpuZ8HnbXqYGXrN48dT6iI6O0P7xA+oEz3zQQl5k1s1wWzDuxVVpo34rlkYenEIgIuqsl3BIWldOMqQ7v3YMhhad6yu+DM3ptiDr37CcQnT/LJkGYVU3hgNeq1kxIFJp+pOHNe6/m3ReojbssZ4lPUkSBKw40+W5KXk7GefSDYq8H/QNw+ELmSTlechaNLgh0qJnG0CJcprTxl/JhZk5mbIluG28DQqy0gRvVk25Nx+kMdSD/666J9LNYnCIDRJspy3a2Lgjrxbcy+hrPPW4zTJDPREz4ND1KOvQpL9xWyJ474kAomwAO2+R0kDXlXYU4GDCGCkeX5/cfBHU2BUfZ7lzLcoQtIuWaQa+wUf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/0yqGPCmbk8TZ5ZJ4hc82pNtJfpLqQaI1ckuF2axxP3e5J52RcqduwzB3bqrrNTrfxdhPp9aCMeG1EwTkNSRMKkGLub1iTk+fS6V4y0QATQKg4AOXFOJP87V+L3kRNDc1L7M8H+GR9buaUF/ZoJtxxJQK2LNwogRZ0JfNEf7Kj7jVaSHMsiv/YP4PcZFNiTc4jTdUIts+UGAdo1ekj0AFJpx/LGAM1XZ0TlyMvSbvI/lcZLN7Lzcb0ZH4BXEYD1h5ynjZf/hkbLMphum0E+GCWnBw9okY6x0uGd2DkD87G0p6z6cRU8QNhLz2cub8Hk2rdrZnSEdgL4tsOzscbJPJ5Osil6kzqCjVg58uU+6gLDT1eUEkEMMz0f+iyCx2yHiusDuTHwt+6LFcbVrbZ1imAuuAAF397UD7kmQ4joNv26GjHNLBKHvt4gVOv16hrPeUqbQp2VPhS+AYP9dtvx2qmAhET6LfMA/vEuKjTQINqZEi/6dJhl95k0/8cgGxQIa/fXuhVSYpbFyBkFQlDI4EwvsbwLeX5QL5LhTm/QEPEx4TWEmx1aw1gl644MDPQgGCuWitrynSPQ5NzCCMHfxdtWvJvf6VWgT4xGZL6l5Bg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKHtGRkrVrQpJW8ox/3Q72qPq6YZJZXPLQHQ3BzWSOawzDruiWs3MXXdow9q?=
 =?us-ascii?Q?E8tG/uvC6i7XT/Pa1PuIeVt/FQGNlAwuZNa0K7TeiRR606Q04fuxZzfsSXb+?=
 =?us-ascii?Q?/uvXsYD4oKmgSf62LdgJBAQAbVlFKDVCqlHNqkPVWpUqPG8KWnhu97EfvKMa?=
 =?us-ascii?Q?U6pbRfy3Zy6ot/2wJ9xugOIc/EZu89icug1bnKA6DEOkIvON5GKirvFkSMV6?=
 =?us-ascii?Q?8aTshjumpXyxSqGBn6gXjtyPEm3B2aafGw23iK9mXDG5iRL0y/Cx01HfoWwO?=
 =?us-ascii?Q?Qi9baoY2HzD0FVM3befeYBTYMcFdCOpCSiJMJFC/tfTUuTBYqxnePYADXNyY?=
 =?us-ascii?Q?Mk95b9VLxo5KSW3MmJJfouObZS1s3QQcoBKvGfZuH9FKz9phN2j0TY8NVwEO?=
 =?us-ascii?Q?4Ozz+/tglIAvZENBt3ebLZ0S1vOI2s8TeliKB4xQCNOvJh3zi5FbvrSC5uzO?=
 =?us-ascii?Q?ZyxU+bdR7Rf2rN61JNyEYot+xUO7NRAbiogZi+VikMZELbH+Kkeljlq5VWnL?=
 =?us-ascii?Q?+gvWcKdam4WfLj/ZXEIbSapKM7o3NeI5UvDsUGIbE64UQLnK+hq3argZwH8S?=
 =?us-ascii?Q?a25Mqs2ZhOVNv8JwHLRveway3ApxGLyY97lG11fmDZnSoxendC65QpAWj22c?=
 =?us-ascii?Q?7O+sJx+Q9AFRl7vHfh+G3zEOAaFfTN1LfdDppgnH8hNMXwn5PDL5sQyw964p?=
 =?us-ascii?Q?mL7baWJ4kZhICs0TQrTj2fL3hxf4UWvBEZmjnar3iXZwOZfgxyZFviwvzqYG?=
 =?us-ascii?Q?aaFWIx6UTCso0QbhzINJwFaCd9RbXitPDybLAEqqK5xC8e8WuZFq4b8iS3EX?=
 =?us-ascii?Q?TAgrlQhlC8Ta53z4kbZ6tLwWDPK/26XasqwF+Mc94tDPSWSNJcRSVl+5nDxu?=
 =?us-ascii?Q?cQ4M7eWaUx0fnpFw9OVTVisbTQEmbREtJtyAYQmLZFs5Ffb/S1jOUmTlBfiS?=
 =?us-ascii?Q?qurYFNB+73rAV3nwfnXrzr5B9jZP8ghuUA8khbPhX1qk+5kTB4cFHVwYlyIx?=
 =?us-ascii?Q?QIDoeql1LQ5iJ3xySR/C7ZAO70Cf4D4lmrPOS8B6D4E392BdmTzuuR5Wfy5g?=
 =?us-ascii?Q?lZqtxLEZumK0xKu465yXpL2Q1/h3G3AxdKN2tVnZWoB8KI4Ie81vV6LPb118?=
 =?us-ascii?Q?6fgywthjQ254aNMXJloW/XkGpm4W0YJ8L2EItHm7Uzp8NGMkd7gn2lEeXiwE?=
 =?us-ascii?Q?FMILFRMs5O0KC1TNkDUkaoWumcTvIBXZ3nE5Cv6kPelULNL1zota4/zTooQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1994859a-7c27-4fe8-a5dd-08dba77f6620
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:29:42.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has several pmu events supported by opensbi.
These events can be used by perf for profiling.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L657
---
changed from v3:
1. remove wrong event mapping of 0x0000a
2. add reference url of c906 events implementation (D1 only support events
described in R1S0 user manual, but event mapping is the same)

changed from v2:
1. move pmu node from /soc to / to avoid warnings when checking.

The meaning of T-HEAD events can be found in this pending patch:
https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com

The patch above also provides a example that shows how to setup
environment and use perf with T-HEAD events.
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977..53a984d78e3f 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -73,4 +73,43 @@ plic: interrupt-controller@10000000 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	pmu {
+		compatible = "riscv,pmu";
+		riscv,event-to-mhpmcounters =
+			<0x00003 0x00003 0x00000008>,
+			<0x00004 0x00004 0x00000010>,
+			<0x00005 0x00005 0x00000200>,
+			<0x00006 0x00006 0x00000100>,
+			<0x10000 0x10000 0x00004000>,
+			<0x10001 0x10001 0x00008000>,
+			<0x10002 0x10002 0x00010000>,
+			<0x10003 0x10003 0x00020000>,
+			<0x10019 0x10019 0x00000040>,
+			<0x10021 0x10021 0x00000020>;
+		riscv,event-to-mhpmevent =
+			<0x00003 0x00000000 0x00000001>,
+			<0x00004 0x00000000 0x00000002>,
+			<0x00005 0x00000000 0x00000007>,
+			<0x00006 0x00000000 0x00000006>,
+			<0x10000 0x00000000 0x0000000c>,
+			<0x10001 0x00000000 0x0000000d>,
+			<0x10002 0x00000000 0x0000000e>,
+			<0x10003 0x00000000 0x0000000f>,
+			<0x10019 0x00000000 0x00000004>,
+			<0x10021 0x00000000 0x00000003>;
+		riscv,raw-event-to-mhpmcounters =
+			<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
+			<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
+			<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
+			<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
+			<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
+			<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
+			<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
+			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
+			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
+			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
+			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
+			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
+	};
 };
--
2.42.0

