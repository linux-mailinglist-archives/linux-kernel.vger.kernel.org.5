Return-Path: <linux-kernel+bounces-102877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23487B7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42F8B2190F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F3EED5;
	Thu, 14 Mar 2024 06:28:19 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA2DDC5;
	Thu, 14 Mar 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397698; cv=fail; b=oK4v6MrW0aXdXBs5Y4BoYjoUZrGoaGW2H9tmksmV+wkOUGuaTuGVB/CVeLtEwo+W7kszp00YGfOVTo0VuJ6b13IWpk2ahUuLXUsrQPKQc1xmKBI24ElIYQ6HlB7j5c7FqIWZkG7ALwgQ0QyJz67XbLdXB46YdnJUp4avdB73xpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397698; c=relaxed/simple;
	bh=wf20tkl9HzCPo08rC0L2rOCCfY25r18NPGf/5YpzLhg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CBvijYIHsjGZwgumiuSFN/VGc1sRROTBqkkHaoLZ2BnNTIBuhvReSSQ2oalBA/tSzxyZI2VQptxBKzBrVVsRmEpPAm0qgsIk/cUW942OzX7KFJJA61+n8AecxCEt/6v9RPQTYZX5xG//c+CAzWJi146MXMsP5aAddeojysvsQks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLgVRxhTdn36x8MP7I62wUSFXo2nc6tQXX+X3Qm0VmBMubEm54tbjpdSbhvETt632iCPqHRjXxLib19gmH+cLT+M4VH4yP3mix02gLvWdqKwsKtUG9QPN7XEcFFSfOxiTpWmg1DKT94dqC8e3iiOfUh7erkTEqz1qI4LeduA00k8/VPXMc9u/nPnW70gqCoa3xGduKsBwLCogvcHgaG5yzEoI8gokkfCPKamyQLRKN4L16j30DAzTCTfVnD/R64BJ7/G35rqHPocMFZ2YiZUmG9d6VwrG52Io9xGpyp/W34dJONODiqFyIL3NByS3tIWsR59eU8VWxEcSpSHXKW08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmlD+i32KmtemhzEjsCjBVKXQTTNmkiO4PxseY/02mc=;
 b=TdQE87ToA2yHTeeemHfoy395BhpTUDab9MPfNk3EJn/zIXSAUJM/VQ15wmhKd8ZogilABrL5ZCb0g+0A5TTMVdVlAmfzaL9LED47PqbrDJM3DBD8krWXmwI+E46BolsrBxxhizYF8swlZgPYnp79zeOOhup3i8xGqwsBNGRMzDqufFk68efjEHy2d1SJEKYK30dfhonUXwOgzV+lm6NfLqKylRSrEwtJPdy2fbipa9yImTN4GiyzkGquaqQPl9pbm3B2SdUs2qT4Zwa6KEDgJWH6TC+t8mV7ogY2kvn8w9hBTVLoN8M0AcL16S3NhQPC0zqsFcAdwRHU9LxV+kItvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0711.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 14 Mar
 2024 06:12:21 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::a038:3f49:b470:9207]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::a038:3f49:b470:9207%4])
 with mapi id 15.20.7386.017; Thu, 14 Mar 2024 06:12:21 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	geert+renesas@glider.be,
	joshua.yeong@starfivetech.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	conor.dooley@microchip.com,
	alexghiti@rivosinc.com,
	evan@rivosinc.com,
	ajones@ventanamicro.com,
	heiko@sntech.de,
	guoren@kernel.org,
	uwu@icenowy.me,
	jszhang@kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
Date: Thu, 14 Mar 2024 14:12:01 +0800
Message-Id: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::9) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0711:EE_
X-MS-Office365-Filtering-Correlation-Id: 00126156-7df6-4479-6d8b-08dc43edb55a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tmF9tJHDJFmaEm6Q27XN8+IBB3hfVzHGr8eRrVnScxIySRMh6pmNuc91qLPZgRhIaQ3/WakXJ5+z27m0t9srAff8ysQVHtHI3uasEXmJpJUnvGLD/iTUIp6nh/VzXZc1K3lQ6v+JOyPTuw9m2yynVLJwW76J5NtObLFrwm4TZJjwthumpVUG0S7sb+HDpAonYQNt8SrAAuZmEi83uK/W1z5NaU0xvBiIGdjqKIAj93clhFfgqqi65u+2vosOaPrhtdP3vxe0rVY4so3/solOFZo84GbPbCD4Tfo+l2MCH9dpLzORlqUm3QIlxlrIDolgGxYc7fM3CY3lywckw2YZEJIOrHCx0fuXfTngawEnhTAsFPcZ7pSs+e0JhkDzCpnYMzm6sbyuwsRVrnKO6IpTokx2UA4UboHXIdpQdcTyBibfmw4C6t+LI9yuFIT2P3jCDOLxXz21MrHHUuDemaJxiHXAocbQwM6DCZGRleU1Y2gzeOc4BzqPJCgg9smM1tcmHsng+8WLSzfhPX1gPpZzu327BayILPwdo9YUJ4QB8t9jjDvCKQh2SzSUYqd45FHtqtCyFqc0UQU0YGOSvL6gzAsU+6/t7VL1dICGYyhjYEewnDZwweyjiFRWIUv8K23wF/ZcdKNyUmsOgypFVNza3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JPOR+XEVXf88c7y3FiWDmvA8/pPT3dykUkbrFEFFQyL4I9l7hNEkRORctLY4?=
 =?us-ascii?Q?F+w38rckxkz0E4VUvHS+0JvqZlpedOmSBzweYzr4Ob35HrR4JdTMlAPgZAps?=
 =?us-ascii?Q?VzpUIHgpNx+3xwznuNRQI6EoiG+08NP0wGe9UmsPpe1wwN56DURhOe+Lz/Tv?=
 =?us-ascii?Q?zYCs+g3SHaXz2+oEisINVEhc/mNuhGXxtK/dzESiAfo9dIJNRUc9u7YYAmzu?=
 =?us-ascii?Q?VqlF9042zl5Q6ta6pVqhHjubE8UdvMyYgNiQRdrr13xWclsd3Mtdg15nAIG5?=
 =?us-ascii?Q?Iv1NG83Uk3tbx1dmT1doM0zxat9mx9lUq2Ii2AO4e9uU+rokMwQdsK71tLE7?=
 =?us-ascii?Q?+6Rx8Fc1HPISc+HVUbTD68E4ZBtnRbt5zaJEpaIz0v1cDdub1ZPjwjVEDa7o?=
 =?us-ascii?Q?ONorodTpgyjsuA/N340UOOjScTk9Tob5x5VuwVzoYe3/w4yUHiouITXzvLVZ?=
 =?us-ascii?Q?iIsa1lwiDTeHt8RWCniFHDiEfNtcuUIgX0uxEJWC6xDFkgLpbDUj3OQzzRTb?=
 =?us-ascii?Q?0gSzWJX1p4NOItEFWLIv+/lv2sfRsS0H9wFXItkSQFUCjSAs8VOm5vSBIQbi?=
 =?us-ascii?Q?CZHhfs/a3Ga+vrBbBQASYlEVQjP3+zaX6e6dsyZCf3X1OUWjKmHhJTvIBokH?=
 =?us-ascii?Q?tmHvsZthzTkt38wjXQulBEFQObih/EM6UDQuIIvr+W1Gg3Yqux+4DBQb0Eb1?=
 =?us-ascii?Q?iVuTkaWmLQjlev7HwVSalyuTXqeIyLyD1drHnyd4aqpc4NNEefpfPrOhsS48?=
 =?us-ascii?Q?Uhr75VxXgDJDhGLoMtbu3IRIjUAZa56qOpEELKOJxh9L1FkBFbxQ+QTn/bFc?=
 =?us-ascii?Q?Q0J0Ei7UiajOvN+idLUmWIONfEjvstp31WHjtnf+b60w0lPcyb5k4tEr1M2o?=
 =?us-ascii?Q?A13N9vDhEVNif85FfZs3M+/6qr8kY0Dq5+AJY77o+uvF4ILMlrNkQLIDc9z+?=
 =?us-ascii?Q?e5wOAx8HAnfqsTpGaNTQZ5hQjcv+5QtUt/UDWl+L+3eg7+2rtf95UoD5zlgt?=
 =?us-ascii?Q?TsF0vbzJyHuiGtEXJZsOvbE+HNiYyEg0DwzR0gExB56Npy8gkDpGnbhoMNs+?=
 =?us-ascii?Q?sF4F55d4jkAnRAxOqQgjA1WhLkvEJzmtIlvKXy3qqAMmTJOSYL+F3Mvts3Au?=
 =?us-ascii?Q?30jyCNZs5j6LVbtUZGk8GxtKs/HtT74EdUBWPg/Hfggw+966ZB0ZDP7hU3Mz?=
 =?us-ascii?Q?T404Z8CQvQqqNLVhWVfiFSsgrfhmsAfAMxmWQidbeJ51XeL4/OE4J+sh89W/?=
 =?us-ascii?Q?doqKcNvvqDX0D2thtsXPRvylw00WneQ5SgO/8fBa5PCNlZTq7hzSOIc0S1RU?=
 =?us-ascii?Q?c+by6f5qAXCKrmGsXWrJKBx+1sN2iIpZXxSZIL88UhJulaiguL32CAjUGveu?=
 =?us-ascii?Q?4ywrop0Bl5ZdaOybD88eMfe5ckwpafc6F7y8GsJo7qSZXSQnV0NYZb5eb0fr?=
 =?us-ascii?Q?xsOx0Vg7tMY+52/Hdf1sxxElAO0BBpt3OZ4d0JOjxDKfI7k+fQlKN70aR8cX?=
 =?us-ascii?Q?fYjfXgQatzUWJFR7C90pjc6lPtITnRPVgyJmRSFn3yHbkvQws7GqBRbDkiCY?=
 =?us-ascii?Q?BJdkujEFaWSJRv3TzfE7/Hizf3S/JolgIH2clGxWo9Ui2SIXNxkQkI2j7BCe?=
 =?us-ascii?Q?GSLdbs+h8j355pWLabsjFTk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00126156-7df6-4479-6d8b-08dc43edb55a
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:12:20.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4nv5icP5FDlLBWmBXfKU94dPFloAEdkn/zK3PsTumX6msKDYR/jpw6zXIOL/wsvtB3USithObJn9HisLh7Ls78/OU3f4W0407ro4RNVTKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0711

StarFive's StarLink-500 Cache Controller flush/invalidates cache using non-
conventional CMO method. This driver provides the cache handling on StarFive
RISC-V SoC.

Joshua Yeong (4):
  riscv: asm: vendorid_list: Add StarFive Technology to vendors list
  riscv: errata: Add StarFive alternative ports
  cache: Add StarLink-500 cache management for StarFive  JH8100 RISC-V
    core
  dt-bindings: cache: Add docs for StarFive StarLink-500 cache
    controller

 .../cache/starfive,starlink-500-cache.yaml    |  62 ++++++++
 arch/riscv/Kconfig.errata                     |  21 +++
 arch/riscv/errata/Makefile                    |   1 +
 arch/riscv/errata/starfive/Makefile           |   1 +
 arch/riscv/errata/starfive/errata.c           |  95 ++++++++++++
 arch/riscv/include/asm/alternative.h          |   3 +
 arch/riscv/include/asm/errata_list.h          |   5 +
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/alternative.c               |   5 +
 drivers/cache/Kconfig                         |   9 ++
 drivers/cache/Makefile                        |   1 +
 drivers/cache/starlink500_cache.c             | 137 ++++++++++++++++++
 12 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,starlink-500-cache.yaml
 create mode 100644 arch/riscv/errata/starfive/Makefile
 create mode 100644 arch/riscv/errata/starfive/errata.c
 create mode 100644 drivers/cache/starlink500_cache.c

--
2.25.1


