Return-Path: <linux-kernel+bounces-1559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0EA815017
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0A1C2085A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD773FE2C;
	Fri, 15 Dec 2023 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="AIDw9EA3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07243FE2F;
	Fri, 15 Dec 2023 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2z65RJyk9cP2lZdhvoErAeHEaSPzcaRHRTf1VFylxLSpOQF6wdzFZbOV79Q6JecTzJhzocpJTPeI/cye0owVzdwvaZliCOrOAf6D5Nmtvs+Lb+VNZfl4iCxnXcmG/vVo/OiwToK+To4U6N6QPOmJ+VqDYiT9NlMNeA/SyARmuhbfrn8fTOb7rnKxkjIakige6h1QvWzI35PyW+XAhEupkFssGcuMcO/Qpv4jLkdKsdtOTUTOdsCEsDjLPeZ5B3sekiY2aB5GH1b5Cn/OvySoelL2H+riX7K/LSMppxgiUY5KnRbfNQGuWKok6ue7LhfXrGdW8EVyVTCWkZTuZmkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vS6RUGQ7ehc1eLdE8A3PYekLaSCCm+d5mKlV3mZKpg=;
 b=YCnFhpNdbT/YlbmtDfdrY2t2L8GGAQrBTvhGwDBoeCjsFZdOzTWFkKPiWAgbJvoZLkcgxQ6tSbpRQ0dJknDCZaK/A2F903s6PGdycuyzMoyQlo0eheU1hXwnyfbP0hQWreN0SuShPlf6S3AwTs0Y8JEiK76Yo8UCgDg84cJ1/v+BhpebdT1+wV6+GRyfmCiRlm/YXSXE7lryTrXVsfMAW+BhHrUow/yhEGLJJPT+ZdkhuSK/vlBgT3+6HYjFwJ88dVqGlmfgbhHVpMhn/oXqS4OZEdz4+lAZCdPmENUljG7jB8HqMow2jREsn+6lropUeB3B8I3A3QLR7MHgbGDckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vS6RUGQ7ehc1eLdE8A3PYekLaSCCm+d5mKlV3mZKpg=;
 b=AIDw9EA3sNAmOcWI5huWVXe3lgfDE0vTQyB1alp75Zt7AEwNy7y9DLcLK811AF2dc7VCgEVb/toNhK+yKzlg0nhYf0aA3qEj82TwmTCBjr0bVS/l1CjBKPTd/qX6GgyvP3qARkbow33mcwU8B4qUi2w7S7wHE2oL4C9e2SGYaV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by CYYPR22MB4299.namprd22.prod.outlook.com (2603:10b6:930:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:18:52 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 19:18:51 +0000
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
Subject: [PATCH 0/2] *** Add fixed-paritions to phyCORE-AM62x and phyCORE-AM64x ***
Date: Fri, 15 Dec 2023 11:18:36 -0800
Message-Id: <20231215191838.1925082-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|CYYPR22MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa4c4a0-f7ad-49a5-5e34-08dbfda2abe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MoOwafdYYiMB4tnLqkvtNAOoA0a9mf99aBevj1118+s7Dx/kfuEo/gqorx+QiHcuEZLOXdhdx4NzYLe2dwLA4vh0+oC0b9YAXhQBSGcGjNvqfuFf5t98L5JymKSjHJKsp5c6WSoz3ZuwB2vNJa9nUJZPQBKQDuNhjSDpyQ7n+5/cf7/Hkjzoitw+Ty1Od9a+ecm0ezIZtBL6c1XyXtNJ0OnA8kMLc4UFTk00xIAAFHJsZv/KW9vfC95OEzLPrPRkEkC7oe9p5h15p47uM40qd/2k9NNlX4arauuWJFRmCi0wk9dlgRt/w7hSgPQVob8/lk44f+lnoQzSdGSG29lA6AFOmXH7hL+ajx+z9TuLAU665f74MwQd3ehnNhk8ZdQyedc/LBTDmLtNiiJcQZtSWtaARVZ/d4gbXvittYuI2LrOUSeplpRxzJhQMR7G7y5GSqiFlOBeNaSVr8Kmc6AuTQxmobZHLey7IPCkrTZmDyVRs4l/rDwMP3IP176vhe410bTVSZmb302TvlQVdlePPxEpa/XpuzUKWjg94q9QK9F4aAox+4RL8h3m1v4TxFFhpn50I1Yn1R6xb30yLuZ5vDvcWy/zLo8HJKYZTncn3UrlBu3UAhVZFehgTV9Ah9fq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39840400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(4744005)(7416002)(38350700005)(36756003)(5660300002)(6666004)(6506007)(38100700002)(1076003)(52116002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(6486002)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckvRGbpn3wGpNdtQVym6a4pAdhLDSz2W+bkYPtVJsS7rgi5JEfBQlz1ytyd/?=
 =?us-ascii?Q?Nbce1ma739sZgQO1yrvBomtj4pLs20L8xKivLLghWa099DyheKq/hw9bvJ9O?=
 =?us-ascii?Q?XWVw7kX0UOIyS+tfMOjyJneJocr8QWrDi55z7idLOu7E79u5gHDUI6X3H0Dq?=
 =?us-ascii?Q?+PgdGdJucDH+B0esNpOHC9HT8BfVUkp25JkdnML77Twf1axLR+x/Q7L7atwC?=
 =?us-ascii?Q?7uLqjkAxzP2m3jLGPgCSPkVu6+twilWStXP4ghZBeo+Aige7y1PSgUkum2h0?=
 =?us-ascii?Q?PPhY2dLCiEv4kseUdSsuU1aVdA5VRpv090aT8ZFOH/y6DQAzaBfmdd2TrZ4e?=
 =?us-ascii?Q?tw0aNXgVgNtS+XbkEPJJ1AanuwqbUhz/k/IkH6+eUp9vgfMuPsmg8FSTOrK2?=
 =?us-ascii?Q?72xAD5bFVE8stlyJ6c1wukQ/zsV6+3Q2WDEdwvaHxIpuYUqEk5YrOGA3d34c?=
 =?us-ascii?Q?SbiFeOvhFT4OzqybCOEQ5W1zEDxbhzc9TeqWxEn6AZDpHwVFKlXsuF7IUsL8?=
 =?us-ascii?Q?jJczmGIC6JBxjE2JcCr+PQWRjyUecdjU+JPHKUTmQUbzwoH1BqrMR6RFSVSP?=
 =?us-ascii?Q?8ow0lHyN5d2Al5GWf6c3sHeeZZfQdtOxLClWfy5N8NoqQPv1R8PimkWdxHQT?=
 =?us-ascii?Q?jGWXurmggmeCNL/GF2LGTNCRXFqHJut9tzeC7lBw8f9qdvi4PXQnUES4RWgK?=
 =?us-ascii?Q?9ul93HzQT7uyEzIUTpCAtIfvqm3sFL3FLTj6Gv2wYFxqq8NnIK+QuFck1b4j?=
 =?us-ascii?Q?ZsuTFx1p29Nm+/wNjL9ibrh6bZyOuUDqZMWzz6i85yfwect37FzQBcIgURyD?=
 =?us-ascii?Q?ahod5+w52ZC3x6uoIBJFSFLaqooOcj2pi141gT6gvR40L55gCcrWPWTk2ICv?=
 =?us-ascii?Q?jQu+smnnicdkbmCvT9/WrLcJZIBZ6NXTW1xELgpZdXXuLA3ngg+JjsYlsFH3?=
 =?us-ascii?Q?LmD9Y8QiDts9zbwrdI3hcjTuvPkM9q03MeDd70H1TOPdJzJLGL78pii5hwa9?=
 =?us-ascii?Q?aUd9uMbi8i6y8I+U6dtkXFcuK/QUEh4y00/XvLVFSN07/bowxkks4wO7Znks?=
 =?us-ascii?Q?0cCUEq99umGx/NCTJl5LAJZec7i0nwVOexJlX3NCNqKaSu0+QP3NGeG08TzL?=
 =?us-ascii?Q?zNIcG3dWYD1mppsVjnIwhr+h416pwZaklKs1uydH6SgWRkIeK26+7TlpDrk/?=
 =?us-ascii?Q?yM1O/HcEIGpMPUODD+pNxbkTo3s+l1tVkm8qO8s6QasSxnJYx6LFqI+shtP5?=
 =?us-ascii?Q?HfW6AqB2Lr3zbPSNIk14p3lxyARGOkfcFxAgZwnvju4vv0pDnq6CefzMs0+9?=
 =?us-ascii?Q?h8aB5JfuYyl+7C62psT1oZOqxphcMQnnqAMFf72nkM28XXFH/mLMsEWy8UG9?=
 =?us-ascii?Q?OMlZTIiAjN8LzjEFI8u0Vjg3pAFJfxXhPVxEk1O4NLTXMz4pzSODOkfrbVFn?=
 =?us-ascii?Q?NYeTJq2sTMILW231WXuovtwA5KJPiappkCgFj2ofelsIoe+ey+6YEfljTLVB?=
 =?us-ascii?Q?nbztbQRni+12WLNu8UKOq9SogSBnooKrCZ1GRZl54AklYc7H/V41L+ojTQR5?=
 =?us-ascii?Q?dcM6TMLQ3Du4O2nLx0D7OgDHGgwBeVh4VS9S/M7R?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa4c4a0-f7ad-49a5-5e34-08dbfda2abe4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:18:51.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajQFSJnL0q7MpMJ/YDzls2+k8Ym4nmXVBy348mxN2tX0YPTF89x33O9vQZRWArPhw7Y2jyr+3BeQr8cNNlVBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4299

Add a fixed-partitions node to the NOR flash of the phyCORE-AM62x
and phyCORE-AM64x to enable the bootloader to fixup the partitions
during boot.

Nathan Morrisson (2):
  arm64: dts: ti: k3-am62-phycore-som: Add fixed-partitions to NOR Flash
  arm64: dts: ti: k3-am64-phycore-som: Add fixed-partitions to NOR Flash

 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.25.1


