Return-Path: <linux-kernel+bounces-1561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4281501B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB031C20155
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E145973;
	Fri, 15 Dec 2023 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="QFwajTfx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800B4174D;
	Fri, 15 Dec 2023 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+AS3Q3/1/eEBE7YHxlbAO4HiiVV/RvIGSJ+tVp49CNUwCfcNyuWquj0SjQnyr471gZ36JIHerwrKVkGsD/YFZhK6f3DFHNkmSLLGfpeS0gLEnbetT6rvQZTtwimEJG0pga/+o4+nJ8O8MKDTvH0Sj8Z4D6OFIHtL/3QNslfoQgeVPRqaPW+GbHzzYoaGYkFEpExRgJ5QAhSfHTlBvSHPLM68NphD65+A5AQyBS7E9OW3am+VFWwthCP6XnUTLngyInOJZo0HAKMHrFql53mZxgTFg1tRzfH3hX6aCarLUUKX1YhZyrbrdplrF8/1cwR7qElskF2pw86EXMu3/HKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONmtO/NGQOKL/PE9aNrabZtqdBllsQueeJyuyazXRIM=;
 b=A06mPfNoWf0lYueuSRcxlUceO81MTFyevjQqvcpH8nhP6NIrzTh1ZANRLfpGh1I549DLzvBdhktPV60imlpyZBriAUkW5iPX7b+lmlHFmi8X8UPZ7UTtPbH78b8Wa7m0Qalkc2BI/lQII9bJkezflJqRl+f4pVNAZKTUNVj5nuSY92WgGxF5mM5/57qrR390gCB6BxHDRWYSbw4gNpIeLdjgGckK3QrqH09DAWY3SUh7jh1Wk4LCOe+LW3gkJIty3UV/IiZa24Q3ZQUkjJxW/P8l6u2QqcX7RB00K7nWl3SA7CRzzB0YaHjMc7CmnjWU6HjKFMJyxlkDWdFEYk4SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONmtO/NGQOKL/PE9aNrabZtqdBllsQueeJyuyazXRIM=;
 b=QFwajTfxzu5q/MBSBaaKNlhAGXsxKAvrR2eBaz8/TbtbQoF9+t8s9uUGuwC+23+VQtNh7RX7JK02IVFs6CaT3+Z1W5XwZjT4Cq/8KR+iGcu+TnaTCwwLjNi6gMiWRp+R58xWnNEqjNBfXvF+gFZKpkyfq3Xe/AuVaZal88tFMKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by SA1PR22MB4902.namprd22.prod.outlook.com (2603:10b6:806:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 19:18:55 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 19:18:54 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64-phycore-som: Add fixed-partitions to NOR Flash
Date: Fri, 15 Dec 2023 11:18:38 -0800
Message-Id: <20231215191838.1925082-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215191838.1925082-1-nmorrisson@phytec.com>
References: <20231215191838.1925082-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:610:51::35) To DM5PR2201MB1515.namprd22.prod.outlook.com
 (2603:10b6:4:36::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|SA1PR22MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8f86f7-41ff-4256-47b9-08dbfda2add4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1PFDyKrBO6vLAAauHwPoBVAD8wWjc0rrRWGwu2fXR6chIcU6FLHFbk3o0IkpoxSE7BvDfzZMZx9OyUSSSQso/lTlk2C7M2zwKz4w1KCjQHM7l7WUTR/7bU8cK52SWsttAMVJxfeq8jzvU6XZe4i2lo83SHDIr6tmLVXWTnQJRzwZlq7Ud56Rh66TJIDiPBk8chrsJjo1/FWutltQ0sRgSKGwpZvAxMYvRXv57EhgXlF9+w46G+F4TO4LIg4bJ3VqROWH6tDSMauiLkXjZyYSIT/kAAkGUOKbqkva41Py48OCBE0tFqIKEbjichNuv5bYYm0jeSTXHSP+6NeX4ijIsztk0mZVXq5ih3FGT0LpBtd1jTWlEMgLmmzE0e1CS7WCPgnUVhFTeceg3JUBX8OtSEdXmqdhQyEskPl9G04SUfnCi/ZxLvx7z0bur4vfZjrS6RQyal2BhzxixTHg97cCIiaMUZiHkJVENJ2OUR2wel68E7UQL5ozgBoFAO6R1oueSb1i4VnmjNGdpRt/Ry7WA0z5eKmRL2ngidBAfopWHF3SyGmzhHKlOGz3tiIbNdFP/KQhPk3ZURO61T0+PCXUs0MEakaWWKDpEEUVCf68SSMqot/qburQZ8qvrucbRw6V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39830400003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5660300002)(1076003)(26005)(2616005)(7416002)(4744005)(2906002)(6486002)(478600001)(316002)(38350700005)(36756003)(66946007)(41300700001)(66476007)(66556008)(4326008)(8676002)(52116002)(6506007)(6512007)(8936002)(6666004)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ji6s6R7qwGLPzcJlmz/O63VeyxtOqiSlQhGYgJmfafegDgaBfeV7l/yEM8+h?=
 =?us-ascii?Q?e6dS/cXj1M7W5iJWz1kasYpEV7RyKXy8YzSUoovGUR+8+i8mbN8mKz1JElh9?=
 =?us-ascii?Q?s7km2VKATxf+ObLZ8aUaRg2peQPiTzHpsV5p2hEg/qXr97GpI18HK5xaolT8?=
 =?us-ascii?Q?1r8g7dEWL6Q2wbdi08vIDlMBE2N6nzy9UkraZqdzfoXqo3Z+bEVYos9XMOER?=
 =?us-ascii?Q?4RW66qP4I8TaLKnqQbCNg5q68tKzVYJHWVGlTbIememBM5t53mpB1EuqaqRr?=
 =?us-ascii?Q?FPOQv5Q+fvNZ0ofACz24Sij7Jr5Sojbifuytc4P/YxPd1lZXvovJxZoXVlxI?=
 =?us-ascii?Q?Y+zPtFlWcu2iEh79DIZ3fIeHVMPfgBHxcm4XtyKu4oM0VYMX4BaNA0wH+9Ew?=
 =?us-ascii?Q?Ldu/sx78M8mHqVmZi7FC+SJmR8/iSd4XjVRGDT5JYSiN/Lw2JOpgJ4neUFEl?=
 =?us-ascii?Q?q3j4DfkYbBtxxBSFIJ/pG9j7xp5cZp5m3jzo7LY7E1av1FUJkpsTinnPcxcg?=
 =?us-ascii?Q?NDo9s+CayRwmJ/pinm1Uh+nNqjP142xSxW+VlHJbKP3Y+f+t4DmI4tU3Jm0u?=
 =?us-ascii?Q?qkIxVg+3M04kdZqgzSaXFglzL5tiKZu/EclRLiEyCr9BppWeusjRfcxjIio9?=
 =?us-ascii?Q?qRT5q4DLJ5Y9C4KBZ4zDkXRLPOmPxe4UWR6dIkwfXWQ4E+YYhXFfSzapZcMw?=
 =?us-ascii?Q?UosDUBvTQbXipv6/ncbXLNfu7U7YiC08IABQ02u4PaWkWjckVPRdqDK8tzCK?=
 =?us-ascii?Q?clr7GzqRYe6Cb2rDbOw0UxAQeWU/4apUcgFICaEqRuAwoTzTHLI3nmzpu2TS?=
 =?us-ascii?Q?O2MtH3NNclYKP3DAWXy6CVv+ebwTft+beOPF+aOFNCsrwV2WYFOSOOyXUYf+?=
 =?us-ascii?Q?TKhVJMmiOhbn/7OQt7yGigXBvPLcOMLaEexhDPeP1wb+DKGClsZe1U4TI0Pz?=
 =?us-ascii?Q?l9bnwo6RrJkfr/pZ8QIYfWy+JnOmEAIxh/bJvspUNIR6HoKaySZz53Oe2qRr?=
 =?us-ascii?Q?Tvku3Wt+MohWA29ItfqCEdGeU20C/TyAtF3XDktWx26UBnXdm740nFWj41uX?=
 =?us-ascii?Q?IEM7tsQ5zNfXJMUM/tD1BiSRdzPIF3Q5PfAN6lTL7zZ5H/ong2EfHJ9y15SW?=
 =?us-ascii?Q?1aT0fXODGAoMb6AAY+7xFLcSu26gCkXweDAcL4lYD8rlBuRoUTxaPzhYBl51?=
 =?us-ascii?Q?gDfujlAK58YYBEN6oos/KCNMwNSQzMIPhUWHio0sdMgCwo+0+xubbV7swh35?=
 =?us-ascii?Q?FLx4Ce+BBd9hl+8++1gyD+POhnnh0gd6yrF+Qzs+ZW0tjQ9O05N9OwFqf+lq?=
 =?us-ascii?Q?vsipclE73YLRE7SHAqM2O7NeEg1yRLsWYTCOQ1/nJ2LCN/ZCxwVuFmmB1ghf?=
 =?us-ascii?Q?VzcTJa//JpC/rCBMUl/KLcYjKjUr10ml4ELC60ofSgMbJj8QskxYROHOEjXN?=
 =?us-ascii?Q?tCbdd8aAJfdKgD8G0C83T/C024+yJzlLjVFBv0MBO7/cxbo03+it3Z7AxL4B?=
 =?us-ascii?Q?Z46+iumtD114KrBeeFwtRBwz9nvZz3T1i+qupc3v1lFfV62msrNUTn7GyWg5?=
 =?us-ascii?Q?7PYKiV3r16+3psgcLZZYA9szODFj+R4dK22YmXa5?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8f86f7-41ff-4256-47b9-08dbfda2add4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:18:54.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wdn4p6brLhnhXkWorY3fRs/Qd6k6fkbMN1/WUrYaIy1ZYjX2iEbSjjyGbOMcPqOZ8gNQkT5YxwUQ332PttPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4902

Provide a fixed-partitions dummy node so bootladers can fixup
paritions.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index f87f09d83c95..a25ff4cf9373 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -207,6 +207,12 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+
+		partitions{
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.25.1


