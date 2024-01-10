Return-Path: <linux-kernel+bounces-22567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF9829FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10C0B2269B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860A4D5B4;
	Wed, 10 Jan 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmtIfTXP"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44C4D5A2;
	Wed, 10 Jan 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnnZYWcYZ3zaT/D0sRWBwifNHUjL6UE6e7La7GLWGwIjHoWOhsKn61xfONV11Y39isfLNDMl5jMnIoWkSx0GQwA+dluEBT6o8iOcDlDbBhO9mYk/tLFEn1M34GgpdGwssNACNYnUHz4Xd66Qkvmwspvp7/81/mXtk1YCPJ8ZlW0x0+F+3Lt0qWQvfAhsl6gypVyr0TVkxZIkKEUkhIFLp/pV1ZCjcytCfHbjON99eLFf0D9/atFKkCo0SyCzdGqh+aKKoPMjjjtDLE4vxeR2lpAaV6HGgA+DBfd2m5/mL73QuGh0QBG8LJQpRXjg1qozu+zLqOxV9EjGQ0DJScOZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FekjBzoDCJovf1NpETrhk7zj1XVCcW5BLs8dcDMQCKI=;
 b=XO1XoWXoZZ4hsHncwwizb6FuxLwH4zELQpLWazIMdyYYuqLqZJvPT5S0lFKchcDFgL/gGwk0GJjK7pyhkrm/Gws95wK66QBRNQUKvSWHpkmCyK5U5+SXCGwhmDNE4Snw9qaY1CmF8h1RVL/gB5Y0mAdEW6231Z8pQ11Kgk0EbxXTb4Rm2O4w4Pc0NasiI/OlBm41Nyh3V5zJXVHcNlYG4OJeTQ4FEH5eqgYe2SmfIqmCcJcqzrusSZNAKSLmGtjJXN9y1oEuqa0k/qJk6fg+adG6eFj2nIfLPQ6TDAXJLzMTdNax894LHiJ/asQV4YxwzpTuOSxPCH0XscZ2mI1vUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FekjBzoDCJovf1NpETrhk7zj1XVCcW5BLs8dcDMQCKI=;
 b=AmtIfTXPhQTDIqFtgJqswJV366Bn1SDTWITWDUuRHgdFYpY3EQTDeoE6LBXwEN1cVfry0r9lPZotqXURhjxF7Jb/b7aM9yVgCQtFZrG6unBRaEyRMKfF2Gimwxhpspe8mFMkecziw3LFeyDdRb6qqC+u9ytcuqhmVbGyDOs+pI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:52:48 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:52:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c: silvaco,i3c-target-v1
Date: Wed, 10 Jan 2024 12:52:16 -0500
Message-Id: <20240110175221.2335480-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110175221.2335480-1-Frank.Li@nxp.com>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 122edf99-efdd-4e6c-1b36-08dc1204f533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R+8IAFB21x62B6JCTjs41pGwqoUf5FMBkrBTfQ5o9glzdb7K6vWLplHgUXPeKCfmdjbtOfJR+eNoQvDn7ARqgIQT0/9j31RhGskC7gfBL0/RgvzXeqxg2jNDJsQF9lkDc6gnpLqN3XB5+mYcPyoS1OXCku2fkDWvW166pZ2epZWMj4GUZwqMR1UuKo/t1iEgeqjouOUcEo2uNM2SY2l+gvc2HFuAsyOKJ86J4QPzXYs19uqol+fCAzeQDp0AAFiFuTDEpTWNujYanWOudzRlEVbFToz97/sIpFC4f4f1O3rkKGRtYqLXoohQ+dQHsQw7XNM1ynLzGrX7hjYveCmp7GA3BuRiXxDJyGUMIMfJ40rY/OEsZi/91TSCFZhrPfrCmwcUPg6rWwTI5BH5Tvjq8JtabseSkod+cmBE1U2Z3+TcP09iYbiONcDOVS6vU3f3/gtCTslWryJr2AZiC0AdpEEVUcXEM9qB6boV0sKDZD0f6GOg4psEylOq8NUZJdjpR3QZtxXqubNFtj3qXXSpZXjAI/OUGssp5J9ZquK/kggUYchLiFjyu0TW3u4QOlxeYVih0MHEr3YGW7lkZ/L5Of13WpdZ0rK0Cff3gl7JUI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8676002)(8936002)(86362001)(5660300002)(4326008)(66556008)(66476007)(316002)(66946007)(7416002)(38350700005)(4744005)(36756003)(2906002)(41300700001)(38100700002)(966005)(6512007)(52116002)(6666004)(83380400001)(6506007)(1076003)(26005)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0DsXJ2vQKdxxiOKR+uVeBVjVC0WagUlpn5Q+DpP2fAJrL1CFemGP/wyLYzF?=
 =?us-ascii?Q?9QtyZ+NTVAh6D/K//JmsCN0TFvecC53q+drYEh4U/mVU3CmxM+COQ5rb9E7F?=
 =?us-ascii?Q?E0gCfgfpxPzKnNJsTQ54SLgn6I8tW8CX8pAgb0kTXtBuoc/r4G/btWXeNqxr?=
 =?us-ascii?Q?orod021svJUvS0zjg5HdajZszZ3VnVqmTDuwrm/oM2QacTMBLfaFgYPPJRbl?=
 =?us-ascii?Q?CIhZ6/K1DkEB6woFkuOkXXOf48W8bgtYEdGaaiSbgEtnHrVL0fzSthdY8epu?=
 =?us-ascii?Q?W9L8Li2Tx0JhN17e6802NJ4VeXInc6N3oQ/mkFYo5B0LM9TNiEKUl0TyZ4vD?=
 =?us-ascii?Q?EpbZ0xLU7PwUeb7apDFo9Nfai71PdTDTOCtDnSCPV8s0NlhwI4o9Ptxej7b7?=
 =?us-ascii?Q?ZrP56eWXbWzi6r/BYKihAnPbNNBVtXCNdNcjdmhDsnHj+yXYr7vfSR5/6RKW?=
 =?us-ascii?Q?asT32aLyP7n/1F18KINSNDU8+/eGttHtvo426NMzI75XusTgnffiKY55tfhp?=
 =?us-ascii?Q?cg8vAqCSsS7FsQhXgR/TPlABzGALCe0WmVhlId496V8MYQ3RKpsaMn+52hQS?=
 =?us-ascii?Q?U5OI7rq1c/hAcyw7dedYwp09WLB5w487/QtezpJ1PFXkxzeg2GqNykZ9yjD/?=
 =?us-ascii?Q?ZbLj8YJY2k6zUQo+IZSex14w2Zq/++VWZBzIxCi9rG5PbOhK4zzyF+a6B5yg?=
 =?us-ascii?Q?I+OM7ARrZ/tqrTF4twm4K8cj9vbhLl/yWG45PBze9zIbTdpZYH77iK5P3apQ?=
 =?us-ascii?Q?WL9m774lKTbprJzRQ0NbAEmbsWjoc6nlKW/nXhZoQVYulaCUQWE4dgT/heZI?=
 =?us-ascii?Q?7X0GWuQL2IAhIELbcWu9RczA7jSIdHZ6fbRkBAb9AUU2cPSyAb4Qla22NSnO?=
 =?us-ascii?Q?3o7YT6UroOpYY9pjrpo6XkukW43DIaqCJMqryK707zDUpVq6sk2a+AyZE4J7?=
 =?us-ascii?Q?fz0gXEGkFBHvrJr78tAOcZ4wrC4qfbhg0G5Ro4vXA1HxQ3y5HM/fHCMcEaoj?=
 =?us-ascii?Q?Y/zeaMH2rmxLVQh1vEyNVgfF7dBCalzXEBoYRtlx6nNksv4n3Pt1pLg3gldW?=
 =?us-ascii?Q?MP1QmvWKTwT5FfkOwRcu0sqOUQHpOO3sGmNEWVTEoYntIYCzkgXeAlumqymy?=
 =?us-ascii?Q?VVyooiH2++476BN7viNP1F1k2A6mpKK4UxtwXjPiFB69FkjszpEw1xmlYxP8?=
 =?us-ascii?Q?h4cgzXi0qoNsdKY4CrXK7Vff+zyC9xNobgxcEDLCmo2h5niy/akN3Grq6xCz?=
 =?us-ascii?Q?0/QouA7kpLgIzHMUmQvokf7pIUZbSWhN1TWkIFZMrUiVAL6lDbPN/Wd2IXu1?=
 =?us-ascii?Q?Mntqx5fCd/t7XuNj5MVo0/wqYSLG5GSTqRZq67KhWfXb4ju8ANu9LM4b8/Ys?=
 =?us-ascii?Q?YoNQEHoJaWoYoduNaOxMwND8J71oPnS8EtX2jJABu+SRDZpj0GDbwW/ybEvJ?=
 =?us-ascii?Q?0SroBeuQZtzhSGnNFFHK7/yveMiiLHKNGI6ONFYclv18m8f4AHe//4lYwPxP?=
 =?us-ascii?Q?BJX+5BJgjpRdPuaIm0LQbWLNh9AZi+qf4EWKiX9TntyEdOGPVaCR4nl1+LbI?=
 =?us-ascii?Q?lPmYqfSNmzBfSZp3k8w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122edf99-efdd-4e6c-1b36-08dc1204f533
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:52:48.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu4ISDq6Hisxafe0/mtTQcNREiymTRUa1yoyKmJvHIEJvdK/s1bSu1an2LI03i3VSsaDMxvY55yGLP3iS+07sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

Add compatible string 'silvaco,i3c-target-v1' for target mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml        | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..17849c91d4d2b 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/target
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -14,8 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
-
+    enum:
+      - silvaco,i3c-master-v1
+      - silvaco,i3c-target-v1
   reg:
     maxItems: 1
 
-- 
2.34.1


