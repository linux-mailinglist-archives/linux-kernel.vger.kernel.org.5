Return-Path: <linux-kernel+bounces-154748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881448AE07E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F8C1F22C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E155674A;
	Tue, 23 Apr 2024 09:01:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2107.outbound.protection.partner.outlook.cn [139.219.17.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BD535DB;
	Tue, 23 Apr 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862885; cv=fail; b=Mx7v3oP3NBln99SLXGwvc0kVo/6oWoJ8aJx7KYYEo+Xam9cl1IL9BFgRfe0WFGbE2dZm/QseRVb/yzt231T0k7/emsgL242ipIbr3ALRZOmPVitnpOSKDhkXenpfdEwJ6pfBJTdZpNztAzIOMYEpQWgmSi8w79YQb2aaSQ4ajGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862885; c=relaxed/simple;
	bh=fH+78OgKH3Y4C0RXiQYWPmQsEj2EHvqOo47cAkpqe8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H0TCaKjMqHfuzEUsUD2/8FEzXhGspBDsxuwebgceKCziFjZbs7u368P3qKZmUG3T0LhJY9z4IfLRla5knhUrzm8QQKZn/+hfrUmlTtt7LIdMSohEWJzV0EHG3OcnO1I8jV2te7oqDENXjhDN9gNY7WhwsnWx/vxx/uzLknBuXCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTe0UPOa7nIeFFAAFFd/BacSBC7fLs47hkwuonKWbypWLf/fOdikdKS5K3bsEs/rR6H/7ii+yCj34koWiYspx5EnsD1uyKhaNREG1imlWm+IVU9Sk+4iQxa813H8s3qabrkuS60v5k73Y4DlAMe8wr1a+lOVkID3EJVaua9pnHf+VKVcoANuxw7VmM12UNZWA4eN7ldnJ2tQkaoRvUkJwGRh/3I5DWo5cOlOB7BOXToJtmQSk/9hmaNhWqPQV7t58SLiiQnqsbCoXl4sHNTuR0LnO7NfPydGDlfa6KPLZKgdOAjdTxo9pkU4J7uWb/1k5v3K+cHhHVaoc8mzsfZOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1FdSEsWyXPNc6sqs8qRZz+h57DHwCYCy7uB67zeKJo=;
 b=cFjsAG1hIlf2MVrcw+mMjT/QS9vv0zMcc0y3A3Nxzytjm4jhcfYerGRFQYNv/MtbejWxH9M07RMC55dbPRQOcOYPx+fJJgdv8Xm/gS00Gxpu5Pq9/fpEtcQBYEcHT7UAv1aU5nOlLmyxscxoAmRg+RkzAWLGS1X8YaAqFVwN7I8SVfc7Q7sx3Mqdj73Un0tlEB+AAhva+E1pGxg4/iY6xv87+ZNTvWNczGWku587UU6JZe9EAbS0AVpTqP1FaO0tsU6B5FrQgtNpOiXY7CimxPOYBltTsqcIVXLgbzICeNzxGOk2mJ7ZOk5qWRHLpJtKS2OJqXSyW5kYh/T2BayhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0633.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:26:50 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:26:50 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] Add StarFive's JH8100 StarLink Cache Controller
Date: Tue, 23 Apr 2024 15:26:37 +0800
Message-Id: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0633:EE_
X-MS-Office365-Filtering-Correlation-Id: 54edf0f4-b2b2-4d34-77ec-08dc6366bdfd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wTJYsxuSg5IbdO9VWxtpL0TmEiURSyXn2fOn9ctEP0ovCFurg8Nw2FEPPXHBoMpXiFqQdDCn3tDkFh7lJL4us/iPFA938N08oWlW2NpyzNGCmBBPAkJW7SCOZQbBgExVsOI2vSAO/QMQa7mAlqZt75uVIAQDlt2II4SZpVW21Zidacbo+skNAq0z8LdmOHPcsIlTC25D+IwqR4gRVkxP7JSIXfPX8bmT97l2iSj1j7JXZ22x/PyyCaB1+fAqgCJiaSiI9CcEWroh3rrsXJQKN47o6ui+Z7CYskMKWiIPUFcFUe+Dzk/H5ZOoT4GgpY9BLVR55LARy9iuby/DaiUvuOp0iGrDpSErQ6nF8rGApDWQhfFvEkqawmvU+XMAWuczwLTaBFNDLU00tEFovUhp8+JLZPbRv/PSSfb4fC0k6vaQlRz+4EjrxVsUW/NcOMhz2Eb3bik/vJINlUQIt/vavdc/aDFrEXcYGIcnVuv8AYWTnEjKIOyAP4P2wZ64Gak6zZ0rcjLAiLHMslJyxpJgvYcJNRqgfNz3tdPBGJFMLFB6GisO8j+gGXgXVUSuRUTg8Dk/8HCbD5/a+XJ5xx6h3u45zpbqUjclZ1wErpqBRgSFOj4ppvRKffE6XPtT4eIbCueikhvwRxkP6mRYB53UIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziK1Kic23elB1axqZ6t6zOT13cy9WRrh/4jjTkFbDgVA5bJdTSu1Alawz7Pm?=
 =?us-ascii?Q?8i8tjNC5V3Amoivk9L9FlhlJob1G4pXwqhM9nUrYubQ6wE+4l6BGl8FDDAFL?=
 =?us-ascii?Q?F2yshdVJH8khs6dOXi1ypEGSU1d3QunSBFh8rDT0WNUv/AI0f71jrT0b4Vxm?=
 =?us-ascii?Q?NfES3NWlYx1sKGyuYhUT/ljfhVNVV+0zc1fsdoSYqTkRpdV+KjQIu7jhYggC?=
 =?us-ascii?Q?YW5syNPEjEeGt9kb/rS8Db+gxtiH6/ZPIYLtxJbHDZ4DS+tdJ8+iq1gr0v2H?=
 =?us-ascii?Q?oErxN0baYG6oM3WjaoLC/SAt82tI6ROHhV7EVV69MXrgJBqIjzduCET/sl63?=
 =?us-ascii?Q?uUI3JJ8/jmsOyR7PsFP4bd3xw2f1tQNNZ/aH2Ej9poKjz1edpXpGSIkvuhCi?=
 =?us-ascii?Q?/KAQPGIowuCuw/Su1KonU0V1XKwOsK46ZhpR84bWN/kKPLMYPL9Fsm0j9wbD?=
 =?us-ascii?Q?+G4O1AjQo81NpWg2M+tMvxe5CUuLoZrYxSdtWYZET7t4G/zHIOBFm9MD+PTB?=
 =?us-ascii?Q?5Lpn2Opn3MDcZkbfBn3o+m5UBGg4Dgzn8a/R7FNTXA3oWk8YTQVAqxGphzk3?=
 =?us-ascii?Q?9Pk4PUdMYqIPUl+5qko1gzPXmOpTV7TaYpLbfwPW4tzj+O37gA8EVHLaQgTX?=
 =?us-ascii?Q?/yb9XsuPLLhl8iKCXjZWFOfwOP6WkicKuFnVUTNI5C5qcPEczr8Tt+jqWC+l?=
 =?us-ascii?Q?eeHZnBBXAuQD3h4gvz9wzuvz7H5vPYVIUEpPlKfFNP17faUg6jn2dxoibsd9?=
 =?us-ascii?Q?1/h95LjkXOrE3srbBoJoQhfE1nItJqqYkGsCMwhJijjoQfMDolcv8QGQSDxe?=
 =?us-ascii?Q?X7NMmCAr85pCb98FKRcJCVhTPKIbAStFpoxLZc/uaepVQZkL/Yk/K7ZLKSWN?=
 =?us-ascii?Q?YKgLoB7yHERmCjqjO2bT28jQVmnQX6iKBe/6Zk153EUXzQNhmfo7RprObcdr?=
 =?us-ascii?Q?14T4jSDrMUU5qwdrNdmn/WMDSsOgQRY6EhKIdc6MFJwgC36t+/A3j1CxoYlv?=
 =?us-ascii?Q?3s8mzXOkGp8gO84piznZu+2gkGh+RFPir7iwmUxDEGlp16+J3/2adS9dScux?=
 =?us-ascii?Q?sgP6KEfc7yHEbYNom7sdIfSvieVN7gh1M1143vCQstBfz9PupaGYv27fYTPQ?=
 =?us-ascii?Q?tpUepwFPUopsPCwXss6L9uqrw/KzQyhNYjkU/jRkEoeVC3cjsgVUgApIS8RH?=
 =?us-ascii?Q?Cjr1dswpkSHR+ee/RdPR3iUDaNeThkm/sR0TUlioRIsrVRMC2QYGnZGmtks5?=
 =?us-ascii?Q?TePbK7ZasaS+BnJyn0P68KSb0qhxpGZ4azSXa9olHkZ9cQ8m+WjuhpRG7ngq?=
 =?us-ascii?Q?yEC3Y7rTB7aUeBvlZ8MB6BtWHAR2gmonj3Q13UEGHZ/wv82zx89OffDKVIJ4?=
 =?us-ascii?Q?04VuOQwEIMWhMhAnSikjOVIwuj/drNqzXg5yFdcxiTOlCoDdD2Zz9rw2NeXm?=
 =?us-ascii?Q?/onuGv73mqs2UnqRjXe5hvZGUA5dZsMkXBwkMB2YVVANzklG8eMMngvVfYhH?=
 =?us-ascii?Q?6Q294pCUveDVjU8Mm1ZnIRCR7nQrnCVnNzAPWLIL2w1OwLiB95UiKwWsKqUs?=
 =?us-ascii?Q?X3e3Jvtaah2SJyBcX7bseZUDwMUn0z6E8uRiE6q0UafJRxXNvG7najdFNSdc?=
 =?us-ascii?Q?/Vcm2abK4HMvNFM5XC54P8M=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54edf0f4-b2b2-4d34-77ec-08dc6366bdfd
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:26:50.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVOrSXewqRVa98PVsHg36Rn/vHZxgwAlMK8Fj+DwRKU0dMrykwUXV42GZ325xOzDz/kiuFF3rpt0kjnLx3hkzmBN7j8mtkDvL0NLnAb+VSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0633

StarFive's JH8100 StarLink Cache Controller flush/invalidates cache using non-
conventional RISC-V Zicbom extension instructions. This driver provides the
cache handling on StarFive RISC-V SoC.

Joshua Yeong (2):
  cache: Add StarFive StarLink cache management for StarFive JH8100
  dt-bindings: cache: Add docs for StarFive Starlink cache controller

 .../cache/starfive,jh8100-starlink-cache.yaml |  62 ++++++++
 drivers/cache/Kconfig                         |   9 ++
 drivers/cache/Makefile                        |   1 +
 drivers/cache/starfive_starlink_cache.c       | 132 ++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
 create mode 100644 drivers/cache/starfive_starlink_cache.c

-- 
Changes in v2:
- Change patch title from 'Add StarFive's StarLink-500 Cache Controller'
- Remove StarFive alternative from errata framework
- Fixes warning from https://lore.kernel.org/oe-kbuild-all/202403151625.boKDjHGr-lkp@intel.com/
- Flush completion through atomic timeout function
- Link to v1: https://lore.kernel.org/lkml/20240314061205.26143-1-joshua.yeong@starfivetech.com/

