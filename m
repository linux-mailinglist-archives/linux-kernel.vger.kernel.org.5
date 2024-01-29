Return-Path: <linux-kernel+bounces-42500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978384023A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4D11F2223D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3765786C;
	Mon, 29 Jan 2024 09:52:39 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B656477;
	Mon, 29 Jan 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521958; cv=fail; b=MsH9bLwWN2FHyoZ6PQW9flKIt1iHi8qTT6QJFdon8+wYlaYKW3PLNKlsA5NCDMNwVKXAhqIceLz8Rj9HRZU3IU69M4vviaPtdcYf1zm8ZoenCCRcnT8XDVUPlyyTzEtTkWuyvhXFxzxilFAj291qyXnd3azj3n7re7l7JLYPBFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521958; c=relaxed/simple;
	bh=aNkcCeGeo/I8155uoDm6ePT6azVHAq9sHYa1tPNuOzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pM5A2lGJ0lPYqO8M+m8ay3avFUqtOI+A8UHNOcN6zcilZr7viv+njVE4n8IavUs2SrcrNFhpm5Tx0/iXByTZiQw96ai7ankCBm7WMiG+iL3Yj5HJI3fZM5fVcinLYy1c/m6qzGiyKBvQ/YEVFWelYZDSj6U/N11jwAHGkokFxm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eziZe9T5yJ50tKCJlrnA0MaDAQ66fb1PhDN86K48K6+id/Mu9ryZJI/vP/9eX30Oo046xQDxEMHXGbOCerk+Mr7ke40K1lzu4w2E23quVx+NKTfqduM1sewjH0GMGyt+FburtkjgnS27lM0U69OLENgULMFRdQce2HeNmTSCIjOpffZOoa2Jx7I9L5ZvBoMZ/FEvxhEdlnIbiktm78vYgWrtmNEJWz70ISC8d2NdqRx/GHJzeI1pMOFyA26C88vGvDBS668qJS7yFroK9+Omninx38Q0S94RfLx0qnEwYuxOU+8vSZ9lYdNPzUG8H7YzIszuzYkYPiUHJS6ESS+s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwCfdG7Wqc9JK+/OLoeHcLJKRDhGrHtGeA8TlzrcX8Y=;
 b=PLg5HZP6BwA7fUlU9mAz/Wnwa/vzev0vSYWdROg91mkM1/VwXzrcmZ2bwrXm5/K6J2LaaLPJrlBLw5xeX+0zfFf65bbSSuNAMk4JI7fTclMihwmQcw+vxX8b+mTX8V2ff2WoWYPH671clsUqkmaCJ93DQtwu5jwhCcWhFouLTAyUI099Q/QINxCA3dDu34QdXHo+K+n/09jeFfi5lmWQVKPOWaoSuD+Y7sobcdQ2IrpEazEy7rgJFOSWChct2I8/bzCAtdtuDGJUqu651wjOnxcxUjfnG8CTPXPNUwrOsvXvA5ibjjNqU+Ei0YTdG7ClJv/hu3emXglV73bPniWjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 09:52:26 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Mon, 29 Jan 2024 09:52:26 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 2/4] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
Date: Mon, 29 Jan 2024 17:51:39 +0800
Message-ID: <20240129095141.3262366-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: ce923316-b59f-4012-b441-08dc20b00009
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kExfpsZokADbk2pbmLmvXkMyfDjlgFP3qlr90G8LrQMMOP/++Z7WjiCJMzEW6F3A+vwOspYuUhY8KB4ILEWOLuMpARwAO8Fw530/cdd+5cLMnPGzRCexP3MakPW0qwjInwZURQvOjTZrCQ2qpiub2vBX4F1VNfwQhf55LmflAgtc4zgmN5cKiX7lGyK53DAIX0jLlrxq4B89YELA00tZ8eK4TC+flAC0lVwoSZSJimoR+0SgJtrkxHHMx2cGOfOAIB57Mtt9llPbpY+IuLNcdMV5TzYZYdS08aLT1RgBNmHujqJskmOrjG55XWk6FTPAiEsE/VTziSezT7+TWdq3Sn1hJ3XvjAF9yTyAFMALcV1TWx+gYK9fLLxxp4QSWn2ci2lc6sOFO28e47e9xsUB+ESlatkdGKmJ4FsYkfKuOWas/0O+pPQwdve/F+R3O8Di70DUXzrWX0uYOMMhnJRH4gphBmWhotRMu1M2pUGkte+6oor2A9O1PL5Q7K3VzC5AaW5muCYh+G4JyKHyZ0/9KKQFvxMM/Vm7e2nhbNN7tUMqGudA7eI6L1vOqlu6dIyXniXzhiVfzfuwCrwb4PN3xA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(4326008)(7416002)(8676002)(8936002)(66946007)(66556008)(5660300002)(110136005)(86362001)(2906002)(40180700001)(38350700005)(966005)(36756003)(52116002)(54906003)(508600001)(38100700002)(40160700002)(66476007)(83380400001)(2616005)(6666004)(41300700001)(1076003)(921011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ePUQcjUdJQd7cli7Rpp6njgiF/mtFpdrFXXzV7G7LjGUpl/6qeJMdm7oPQHG?=
 =?us-ascii?Q?uPbfJ0JT2R+Me2KwNUGggHXOVUyiAdLLgK05EdASNc69+8t9lbBt+uxRTAgo?=
 =?us-ascii?Q?Ssx9TPHGHo2TKVu1o+yhaRBx6fjYvlMO5+FiZELpAL+AdGCBb8Okltdcun2a?=
 =?us-ascii?Q?L2y75zIQ/gfmYMBT67uQkeFeMzOETwC3CLwGKsZTSG4q9l6p/M9jdgJ8EcgC?=
 =?us-ascii?Q?zx0mcsCtWB6cc+x/nilRMsqIO3ptdNL/VCVpMkKFy0ZmEDHP4JJAREF46Zp1?=
 =?us-ascii?Q?HQBJC+6OdpyjjFyJdfGK3ghQE41mWH5QU6f4Il6n0StvHYN7uC6tYVJ2l/yt?=
 =?us-ascii?Q?VFY85kgLAUvDaSbSEnB9pXblE4ArEimM87qR3yzre1MHm4AB1Y/N8KtozPDG?=
 =?us-ascii?Q?vEaZ/qB/STYg/kaoylcGPBqI97oOz59hCwh+0rSkeYenQhW7ISYLkEalApog?=
 =?us-ascii?Q?PiEA1FS25C5hGglP71nDbPsqUBw235Xa2TLHoNCcJER4HGAo6WCT2NIDsvjq?=
 =?us-ascii?Q?CM1gbjjQKBRoQ4lMMqCrrfEYNZjokh3lIuPst+yyikWqEAhIgXgtFiHiw41y?=
 =?us-ascii?Q?Q2CNfgy9K7A1ayQ23M8TM1psgJ7WDpzXS6GfD3RvcDCPvUv9IYyvLL8/tFzi?=
 =?us-ascii?Q?RbQjk0PM4p/CTCsclIqcBVhJ/84kLwnSHLbIcH5kMhLlYL7Sm5btF3MfIY5/?=
 =?us-ascii?Q?vcM62XdLIZAaiWpy7NHBWGlasVyXBJezHRDFT9+snWtBv9jFSDC8CaBffIUi?=
 =?us-ascii?Q?3gxphGBEwe0l6t7g/YgrrKaKuxzx5sOelwgd2b0et1lUEkDQLjEZa5XDq7ay?=
 =?us-ascii?Q?7DYha2Vd6aQza1oXTrFP+d6JawjfUqqhc5PYSkF0gKcMnfRRZjb4roHFWvvL?=
 =?us-ascii?Q?KMSm/bUbMxqXeZ+dMoON3oEppAmSuCO/aDH47T348osx1uBil4zlCTarTlsZ?=
 =?us-ascii?Q?BhVMKO6WWBTW/t+knADUGDDxgju9rKMeOpmVvECHCdTdz5sht4T5dkhwZRRu?=
 =?us-ascii?Q?6lfFQ+dowozqxnWxn/8CKNgqfoZFBhea6nH90FKVzpTq5Oo0Q9afg/WRkzEP?=
 =?us-ascii?Q?AZWqjExumzcbKritOLAfqUPFFPny3ram4B7klLz4lo2dde9wbZbkV38/vMe5?=
 =?us-ascii?Q?d7Q0m1heTGni8LT1Uiy1ZmunDXYBojcB6PTbd4Tbo5XF1fBCqX+LihPykYYO?=
 =?us-ascii?Q?gP63KD97I61EoG9xkmxPu9Y/8f4jFiPBNZfVhvowpj3FLMQgPVHfKy1UBray?=
 =?us-ascii?Q?Zhf9ioO/+CpZcEcSKIOELulJ07QS3wUoL3OIrOCgoFYQVXwxaMXLKm6PIrCL?=
 =?us-ascii?Q?vaJXnv1Pr5aYWtcHbBVV5cY4Y/M+0JHfiDmZ9DpyV5gyqg20Ct/Mi/7b0D1y?=
 =?us-ascii?Q?smr78ZNG+6lMVJn9JlUttm/twbqxE8U2ZxT+snaWbS1Ne1jKCtjXiVrdV1Cr?=
 =?us-ascii?Q?P8eC4hju1iW+Ok/9QCC7BK4WtkQXXfd5JOBPauQoDihPhoVBPRtzfDAxJMSi?=
 =?us-ascii?Q?MRllDR29NZKCya1+lr+h7kRpSqdS63SgZSLOE1NRXqZyZMapb9kYrdz/tpEV?=
 =?us-ascii?Q?zI0Phsu+1NkTLe/tJxyycJ3SYUBMkhUGy+JuMoV064uk03aZhNY7/qddirtr?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce923316-b59f-4012-b441-08dc20b00009
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:52:26.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDkieMXweT13cjw/TkcRC6ZZBcUmHJFrSm0cLbNyz8dtNDn2tI0rxunoKBwPGKHxl48h/8LJXnge3nZfihx4ML30H0e1Xnurs09qYsg4Y/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

Add device tree binding for StarFive's JH8100 StarLink PMU (Performance
Monitor Unit).

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../perf/starfive,jh8100-starlink-pmu.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
new file mode 100644
index 000000000000..915c6b814026
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/starfive,jh8100-starlink-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 StarLink PMU
+
+maintainers:
+  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+
+description:
+  StarFive's JH8100 StarLink PMU integrates one or more CPU cores with a
+  shared L3 memory system. The PMU support overflow interrupt, up to
+  16 programmable 64bit event counters, and an independent 64bit cycle
+  counter. StarFive's JH8100 StarLink PMU is accessed via MMIO.
+
+properties:
+  compatible:
+    const: starfive,jh8100-starlink-pmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@12900000 {
+            compatible = "starfive,jh8100-starlink-pmu";
+            reg = <0x0 0x12900000 0x0 0x10000>;
+            interrupts = <34>;
+        };
+    };
-- 
2.43.0


