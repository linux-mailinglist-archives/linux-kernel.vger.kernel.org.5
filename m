Return-Path: <linux-kernel+bounces-156529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38198B03F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A68283128
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1474C158A0E;
	Wed, 24 Apr 2024 08:13:49 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B7158852;
	Wed, 24 Apr 2024 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946428; cv=fail; b=bcZzJUQs8ApuPrh+TeDMzc70WDEDAivrcJ8oOpjufsQgqccITuWDGkoKtoOD6SMAqOXp6aGe1kJpCLHeb8UXR92QTJnLvJGvKVj4g339Lgy9nQiW9jeeOn1I58ihzdl2qQqUq4yc7U7YUEtSqxVQipvDLN+ztiNJ4R1t08zBTWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946428; c=relaxed/simple;
	bh=7bs9DFiAPydOLrz8koLS85SNVBEvy8oPmrho0DF9BQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L9J4e5zoJPllz/I5R9t0Du9954BzTq4mFh0ARS34wuRhTJyjv/BqTkATNuzdEd3BkvGV/OiPWyG5wfAkPUZelkG8X3b5aDVKjKT29scrWyd+G2CqioZp/ODQS/BnxKtJjQjek+ltQS10lfAs/3RjfgvB5bl8zn/fUgIX3fpIuIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmC8lsp2jKPTyY7jRlfo5OQy803PZsUEb2KZyDsreqsRVHQclVtPfMaOH+TFv6GpRlX/2bWrTrVuZ0f/wMhKJDCFoRDi732/pMocIIIxK3UWiMWwE0XlEvaPfN83QRcu4Xulyg8OuMAmD/MMx2PnVdsDyoSWDkvM4trb+AkYkR/WTg63c1hfTivh3eNHhAEcE/EhJ+WLejKJbqDfl4vq28AA6pt+GBLXmR1bqsKuew4OaHKfow3iNYYuBum8a5DX5LGSNb2f0StTB5+K8r+ti+8ZyAuL3d1VPRNLB0qUS03QS6Jhblsdt6ltL+u7+9CUJ3nfF8N+wmRu+cVKLsFjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg9jfm2RdfID9OVLaH2/GdpLKSbONvmMc77/ga5YeHQ=;
 b=gC6FlEJMKdjpH1WkHK7Rh8ICNTA0fltotowTG5tx1BlG1q9tFuPw2XfsfwcZNDtNuQBSiNRgyd71z53NxM6APQKKhQU3ol0TXPfESmb+PafCvZvCt5gpf+uT82MLmIkwLIzvCypBInE6OJFz1jTAtKCN25JVLtLNN+4xvssqRyi1B3QK/jTGH8+C1VuvjNMoWORb0eR7h0pyw35ZtXeGvx3Vczy4sf6XWuR3l4+5nj60ABCosBl6zXWZmqchGX8pbCGDN5KVhaAhTc68rg7rGzQPLGAif2eJAk8aXzBiCZ+Rur1A3JjbL9Lx06nAHqb+xeIH30nyLqs4MU4IY7XBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0460.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Wed, 24 Apr
 2024 07:59:12 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:59:12 +0000
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
Subject: [PATCH v3 0/2] Add StarFive's JH8100 StarLink Cache Controller
Date: Wed, 24 Apr 2024 15:58:54 +0800
Message-Id: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::15) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0460:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b56d7e-8a11-4feb-67c7-08dc64346dcb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1a7SMoek5HN/7ol4MBX9CbJ93fIwYhJkxXkotu6oYHrzMIpwIgCBwcpDZ8Yv7BZuY8QbuCTaXFBxfK4OSGEUXRtUO5G0/kq9yoG9UkEn1+GrdmV5XUjlXYSCsrBvNJW4mxRooX1dpe1/FyodJdoJ13ZabcQfLvpS9OS015M8P3VpDGXTu/DvbKQCnRg4/9FxzjWtj9lgVFb/4g99uybAEisDWgqzBluHuLnMPhAdfdgCsueW6SblysR3mNLcQhn+zH0tvyP8i8zja3cw+NOCxnjCbYsCC380XUbsp1FRm0/R5YxY497I/JBVdzVafoC3R0ixeFCptpfAEUgY2IXhfgGxVAmsU0rR2SbCl0l6tNfmRtrEqsOMikOfNJHbhNRZpm/kC8/rdt+/xNphm3709hlKvIM0mQhzGoB9zezwdQNNKNXoCLVcIfm8QeFTPA1U3BLJnkyO4NGXxkEVMQtsJRM4mlhksVyyCy/Jr4c9Zj7T5SLrpQifn1XMGq+AFJVxxmDhwyes5QJHDHEflLi1Z/Ll7xD1cw4xb0/3FI9Y+wyt/RN6HQdZOVsj7sCtzPuaZ+8Ov1fpvroPpGnehbXfAUKbwwXnYTW2bAYvammUvVIQjx9oeuPuDxUiUK1N6By19qJ3TbISLcxDRk+RWoUjCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(41320700004)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9VbbWUPk6asUWJ79YLi+o4C/4LCjMG2j9cdJa/Gb76nA9TEo9L9XHIBCTVH?=
 =?us-ascii?Q?4SbOuhL7z2iGYlYMNDDJV7E5jFUFb6zBrFTDifWKfrkb7jkH5V18CyKj+HBA?=
 =?us-ascii?Q?2yLH/uJHjPr7Klbfzuo+zH0skfz7QXOfVEl90AGUDZiS5WHQfwWQkVx1wWBb?=
 =?us-ascii?Q?ODdpyhnfCbGinM/Dc4O/qvseeqruNjl/W+FkW7OsKbgJOo9N31+I/pDmjQL7?=
 =?us-ascii?Q?Tl0rJqkjZI9oFFWgRGwHkl6E51QVuryv3/Su/MId36h8l1R/XUSH7HZIlKe5?=
 =?us-ascii?Q?NcpR+W4J5k1SdRMRXRu8D6FOSWIXH9YtUAFbuuEd1m4aGPfaogbDPF8s3P4C?=
 =?us-ascii?Q?Ci5o7oforgmi1Gfv5cBIDXO3JVTAv/3IbnZxrPtZ4urClzRFCIiw81hb9NDe?=
 =?us-ascii?Q?Xax78LeRnZgc+4FRe4S1abn+AOM4zZvpHCKiWwD3hwwhme4MMIp5mF7Rm338?=
 =?us-ascii?Q?dYw8B2+0xY8cUGNf5d6XiKwGt3oSKZ6yh+EPZmGftcdcTDp9rn4FGPcCaPUu?=
 =?us-ascii?Q?d4O8iuWnQ+U46UeAw/1Ksr6jOvLnRBX4SNBiDWPVb5bnAojyEbeFurtuerZT?=
 =?us-ascii?Q?I95l74FB5OWe7J9WH1xVF0pRDeeva9gM8FbFvUnM0EY6vQVsM5jMAscqgtSy?=
 =?us-ascii?Q?BFgjP0BkACkHJ9LC0UZx1hvhDry9uCn7UMofc3boCbX96yzco2lbcn6sD52Z?=
 =?us-ascii?Q?vOZdQRjzOArvUPnaFCvENNk+RKB7q8n83g/ANWh927t4S/x26uDtr55sr8ax?=
 =?us-ascii?Q?DSjjVVsSCBbtt3dpoiAsNrn18239ukatBKVGaQH0MtKh2UF8v7fr56R0rE9v?=
 =?us-ascii?Q?BjS5Xwc5JBjUVVsVTt+6GwqKOc4tHtVPpgBtRLruLc94VMK/QdwDV1uk3ETs?=
 =?us-ascii?Q?33PG0D1dvXZ8naHVWQbwsxr6iLd5uesSU8t/vx196yzK+elvWHmUxgw56w0U?=
 =?us-ascii?Q?Jfjp1BEEhr5bpvNjsCvdM+r9n9VqYJvFWFY53BirHCQTT/30nHxKOBiDPkK/?=
 =?us-ascii?Q?KNMB5md1Orfea7xQejjl8HcBznvbHsT6Jt24ALWv/e6fBd/cxZxDmVHIj7bT?=
 =?us-ascii?Q?MJ1PqQ+FrrqRBBCC6Eik1RF91GTekTTahIsBrR2aLhm/hKhutDB60t1ETe9S?=
 =?us-ascii?Q?F8PDbwRx9A4T7nmXiYb1XDy+Gk3woc+u58PinFqDxVYn06tg1/gUD8xhRagU?=
 =?us-ascii?Q?C6IYd8tjC6/Ea1PongtwNVWJ5TYIFn4ri89+ULLA29DahYYcSHrrxZuyhHub?=
 =?us-ascii?Q?anf2F+wgsAWm9yZz+65RXhEFplBCr8oshKTXh/ED9SW5FFiOtULMa4huU9bk?=
 =?us-ascii?Q?rwbbZpV1zAWSObddy11gQBek1Rx/jV3PbAd24qv3Bgm4IGpunKvSCb1HhBUq?=
 =?us-ascii?Q?hk0nx4HuUUFDZIJ665KLKrjUasXIbQJhI+QSMv/yt/tIfydT3e4cHXgaYgQS?=
 =?us-ascii?Q?OPT1UTijMX5+XejePBUAiJg4VCuPE9hPsxPU7iMYWCppaz3lvjwNZq8UfywU?=
 =?us-ascii?Q?BegSxxBhFmi9KHUW7DwQFm/dEmdcSNQIqpSbRKuv3eyM0/LO+jgpbTTd4vCc?=
 =?us-ascii?Q?6Qc9O1OOJyfLQ5Mg3+RUXS1h9xbpy5qT09Kv0LIo6xB2LilTRZIRn63l43SF?=
 =?us-ascii?Q?xROZ4RskSlF7NfHVXa4t40k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b56d7e-8a11-4feb-67c7-08dc64346dcb
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:59:12.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue5PKaIF4kR4wDTbivcPcOSDSTswl07rj+g4Q15/QrMLuD+CDtTyuf3UGkPF3q8LTqQIiM9P+fwpWwtTxBRcI20opxIZa9tdR5q9P4HW5O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0460

StarFive's JH8100 StarLink Cache Controller flush/invalidates cache using non-
conventional RISC-V Zicbom extension instructions. This driver provides the
cache handling on StarFive RISC-V SoC.

Changes in v3:
- Fix code syntax
- Link to v2: https://lore.kernel.org/all/20240423072639.143450-1-joshua.yeong@starfivetech.com/

Changes in v2:
- Change patch title from 'Add StarFive's StarLink-500 Cache Controller'
- Remove StarFive alternative from errata framework
- Fixes warning from https://lore.kernel.org/oe-kbuild-all/202403151625.boKDjHGr-lkp@intel.com/
- Flush completion through atomic timeout function
- Link to v1: https://lore.kernel.org/lkml/20240314061205.26143-1-joshua.yeong@starfivetech.com/

Joshua Yeong (2):
  cache: Add StarFive StarLink cache management for StarFive JH8100
  dt-bindings: cache: Add docs for StarFive Starlink cache controller

 .../cache/starfive,jh8100-starlink-cache.yaml |  66 +++++++++
 drivers/cache/Kconfig                         |   9 ++
 drivers/cache/Makefile                        |   5 +-
 drivers/cache/starfive_starlink_cache.c       | 135 ++++++++++++++++++
 4 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
 create mode 100644 drivers/cache/starfive_starlink_cache.c

-- 
2.25.1


