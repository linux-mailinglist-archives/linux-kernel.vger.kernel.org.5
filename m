Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079577896A9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjHZMYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjHZMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:24:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2037.outbound.protection.outlook.com [40.92.42.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD2E58;
        Sat, 26 Aug 2023 05:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxndSCVBL05i5hQX1OtnoofX45CcIzFbegjHha4ZB4S5zZeKa1nxWw2xwyiiPcNEixx5+63WoN889bLt/oCjD3z1jcUNz59XUs5WW7YPA13plQd0YgtbGxgr4A/EX3yMid9KUWeMkuCoDmnLGgsVkHxuoH9r14dpotUpydiwpwauA7v0HOdAEtF5exSnbcAd14q17K3rK0aO1+uT/Ex+CGs0BKMeFQ9xl7DNleIjWRbVMEUjA85Y3ddyuMj0oMVQmB5RqXx6HelQw7ShNT2r9xKvPnsrTBlypYXvZXZS9cdS6T48CZFFPozQNqsNQB9sRmrcYWf94nKsR6Tfz0GJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIJRodmgBKEzJIHdHkyHrQEpv3oeBkZ4tGbfkJI8AFQ=;
 b=TT2/Ng+8QwTpI07SR0ZsR41w/pseFNNx2YgnwbhsPhV4W7BKkkQSH/TxXejqjwjsQDvQUfdI74AMJaR3G9yTdtm5Xl+1ltCnWg1RpCa/6Y5HXBuXb6Wr9JDoARYlXr6gONWnh80ccCqj+YwL7hjR3zqfIMTffg/TcTY1NwqBJvrEkBXz2yOqvAl+GFLQ09KIPDaYz+yKDWWtQRWlji8/YaIG0KQTkVwMlgzj+W1td51fpxo1LTgiuupfkMI4JdpBvNnXIKnu12UuJcY9HZELx+JIcLmHa4ov4zfqZsFQUtPnNE7zfvKjtFfvSwt/6h21GfUVD6PhN3eqOJF3krVqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIJRodmgBKEzJIHdHkyHrQEpv3oeBkZ4tGbfkJI8AFQ=;
 b=qcNmGn+0EQz4fCFheaVSNMTDz2XBeGyCYCXQexDY44DpmyWKPg6zYh30f1KAB20x3g3nBoL86eLThEsY8Ya9UdpElbySXvHcXJnMhQoGv5c8zKRgC+dej5WfaAgTDC8L7/L1R4+z3cPUwi4IAwxXxa0Ie/ltmMjLbxAdBSPOOUWY93inlyYYZjKKab2ISviKyJsB6WEDZrOIDnW9VvvavN/kp9kBNcgGp+t61sU2BnKtW1WUaSPbBglGXITjZDut8rwkt0hMg9aRtMgc9YXQ3jeNPJI98/SaGwXRoAY6yyCi1hBKivKgER1hU8/nNAzur2HP2Q5JqOUt2WQhdrRrBQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW3PR20MB3515.namprd20.prod.outlook.com (2603:10b6:303:2e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 12:24:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 12:24:24 +0000
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
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sat, 26 Aug 2023 20:25:04 +0800
Message-ID: <IA1PR20MB49538F11DE1AF4A52B0F9F9ABBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RYzYcXWKkeYnCjJlXZCx8/HAnwHN3S6TFjU8lyuOsPU=]
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230826122504.294619-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW3PR20MB3515:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfe73b8-18a7-4e8b-72b5-08dba62f61e2
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EB/EQr+q11q+JsAPQ9zfesvHLrCWlIfvFrsW/v3HtS2Vcml9bmeeex43BWSzgefz4FDpGKn1WISdOA8QqXGeLicSY4GWDwIbtic1XNOEH9ioYsm1UYYzxM1ncbeAqSYnk2LtUkF2LGnr8WUraOmSp33V0XBs5t4j/Irbw1ZnBgxkXYJmRT2x5Z0svPyzbGZk5sELLO84VBjXeRGL57vbxbNLp+cwXlDvVQXovGejztHR8WYDYzuT1kZ9DlUFd8m5D7OPuXBZpw5Fkokb8PgSVqUNS6EF7q2m3LypMzW51uwI+2TJpYoAeP4E3wnDF8BcjlFupljrDWoG5Es9G0VJ+wZSdjTjj5Tj4Lyg9RjI6ujOQpQxiejb3p9h6rSnSPqY9PZogzEvVgGBVgmyvVfysMNpxLmQpYiRVHa+Pn2mrfI+b8GpY/RxvlCT5/W9uDCz8R/93Lx8HZcTmrmo2C8KRoBe9EC5hkIlCtUoOHwcuHeQdCJJCYM5wNw/mnJSU/+e+kzaQabLtXFidUikjvTSd5+gC72/VnlCH+OLVtjPiVjaNZ2rsmH2BedubCiWBK9sbcjYuL/CflhNqd6lwtR2EiOHHEr2X0DdZT6jrx3zzJ5y7Al+fkdVqXqJ0KMkA+1RObZUHt+vCl5+wvtdJUCakwcHc1QcBa1ma/81RpCrv5yQfRQPih7tRnY9T2GJJAB9r84bERCbCrlMHVO7ngW7tqq3tl2M1U7DfV8QXKX9nxOSqYGCkiR26MzqSQduyajbPCpu1gevcb7WBifODhh+d6rBIUQnoaQAY8LUZZaLEipe5DUW8adxl9KPkKTa9CfVU0pqXovaqNpwFY6NjKsw9aB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1TnXLX3mcKIxRSyPxZBLsSMv601715C8okcYF5JM8cZpqVS/HmjxbUQMGdr6TrNg7WplE6mtce958Qa2jZMQlrEsJm9QPeuukQFJ44Uv/a4apBck5k1SPxSvpUV2jmAPShzH10CqLttl0aSg+/Le7srJCd0eH9bRMBVAVWRJx5HIgSMCCHlFg3rk8zmOX+8G6nZ3ObKVJW+cJBbqoXbeE+13hFyCPTyJnvzEJHZSjUTijrfP6Vmdhg0zn/znGgyuI/tgT/lkACPpvXreBt79rZhmzLYr/HN3DPkEqmhwie2gy2XdTBJAezUw8xWQp/BtVGfmpt3mGM2LmKn+DFLFKtMv1bzfnTW6hnik839BK4/+ZMLNsOLWiczt19WTs2Mz4syvZ7fgRnDiylpjrvKXKzZTJ1KPeBtZ0UtXpYygUMmNSSe1w6MUmaUcd5EXTElq+79dudvwhRCg4VIxcQQL4Ce7zcSNYhep3IL0H7YYHDcMmBqXwSb9mpXMrFR+pCTP389Dvga8E0It6+dVc+laV9wBBzoObbn+0FnVe2jlN9Y/lf1+XuLnPe4Ouje1XBGA/SbacZ1XffF0YDslPJLRTzqiwk8LYFT0tUrmptT8jQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?liEZ0vv8QXE2fF0Rxm1VA5PqePkHJT92qi/HaIwbq9KPYYk0x9p2/8v+GWFy?=
 =?us-ascii?Q?Dqcm3Tu+iG32Sbqf/oSoNiaYSW4eoaxRQo8eEimS4t3lAGtZwBGYfFeLOyFm?=
 =?us-ascii?Q?Ve5/S8N7OHBkkmoLIbJK/yml3iKRtThj3co7dIMiIJp4IUwpgleEnn4MVW3U?=
 =?us-ascii?Q?+tavILW5Yuv5xVuxKNlxa6zwcr5RKqOwLqhi83vTJlDEihT5DjlnZBJOmqu8?=
 =?us-ascii?Q?QhnIubrhADQlT5N7FcJ7mcwGHs/2wJ6gSunbgRsUD+DhKP7S3OtAMPoLrcQ9?=
 =?us-ascii?Q?RXl43b/7WDCNwUmv4fqd22IfTK/p6Nz/WebIVQSecgdVboznxNux5Gu4aEA4?=
 =?us-ascii?Q?8oDnnBY2t4sTe03ANSTV9KpYD48wV9xeHCEqc8ulBGoa6+TVlq1KQvAUQ0qM?=
 =?us-ascii?Q?oD6KYyPa61MAkf4AP7Xf4rsHGBRMgU8A4sJ6/QWB4C2u6CxXXaTmUiJ5kqfJ?=
 =?us-ascii?Q?sMF8fvq86Nwj8264CCjiE8UfMcV6FNuXq9dkxSI7dyIQufla+aoKGxR3tRzV?=
 =?us-ascii?Q?sRaU1nbp3dtRs2PS7RKQ2HosekLfMCz3HsHA3b8kyrUPvl5dmCgjDcIiqv/n?=
 =?us-ascii?Q?Al6WWC3HC3x+RDsd1yqvdaWM8YHfGB4Q/HVul3hYdpXDwyQ/pcsflIs6eJEs?=
 =?us-ascii?Q?OAFjNScl9srZRB14Su3F6zrHHXPO/lSnKM5+hUp4iZwCcR5btZDMMn15ctbU?=
 =?us-ascii?Q?wg12o4CmuhW8jw1wG67oJ7MescrYdPlSvWzCUWI7n9ETcgHXnD2M8j+IniWz?=
 =?us-ascii?Q?ppMwVWjlZhdKi9rH4DDRDoXqhYziHewQ/I1QMuCc5yGLykMSuMKnN+3esb+I?=
 =?us-ascii?Q?J77039unGKJw/V8i2iX8ABDxdCbgPYixZDPNXiJsRPMlRwfzUuLdAyhDVjaw?=
 =?us-ascii?Q?NzTudcSiRw5OzJhqjNNYWOnlUFKpabIJRN29n0ZbTCaskN8Z7AVLywhbIK3h?=
 =?us-ascii?Q?yU18b9efxSEYDryXKMIC/hjWlMlBAoY+Py5+qhEuhlSI14gtMhB2YhFPdFXU?=
 =?us-ascii?Q?3TD/SMUlyeUQBoqNskKWYAqqQAlX9/0RlaICPDNPGbI61URlNXhHkm2MvfgO?=
 =?us-ascii?Q?+9O+S2y04yue6UC7guES6OcY7ZX40Im5+KHzyjZ1l6xJpwk35Uj70qXwO0HJ?=
 =?us-ascii?Q?DbGinHDWNV0bEOMycQ3W89tq90Gic4VcKKIN2E7andj3L7wCS2DXghDMa7Kg?=
 =?us-ascii?Q?4YT0Q4NiFX5iMyeYCv9WMheau68rLkJbRN6oi9XmdtFC2lpEpU0uNh5BipM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe73b8-18a7-4e8b-72b5-08dba62f61e2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 12:24:24.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR20MB3515
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

The event value and mapping can be found in the R1S0 version of C906
documentation:
https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
The meaning of T-HEAD events can be found in this pending patch:
https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com

The patch above also provides a detailed example that shows how to setup
environment and use perf with T-HEAD events.
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

