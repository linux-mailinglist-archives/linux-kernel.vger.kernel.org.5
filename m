Return-Path: <linux-kernel+bounces-27179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A283D82EBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD9B233DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B5134AB;
	Tue, 16 Jan 2024 09:34:28 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2080.outbound.protection.partner.outlook.cn [139.219.17.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179412E45;
	Tue, 16 Jan 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKMWWlTaWs4W5VWKKMm4TliNd4sNNrl4OvaUuZVcHNr/pPnIB3kD6eZcMvYjJHNW5Z4boVAjYrahaR0cfmlUkQXgO3gYZMACpzZYyWcJqe1uZeO+um4Yg1O4Ak8tnlS1W6/oIhdmfC8P47kUYJz3L9wsvzpalbBz7/YVxCM+wJoQGQOp4WwF6RC2tpiAucf/bzBZhnWOqS6JuSqY1f7QA0WYhQC5JZ/xVmccN4KEuRhh/pIa9C1xwurGuSFLtbREsu5aE9ved+Ell5id6isyDeY9HHIk0l9Wvo7kQSqCmPOyvmmynTUYM7cZeqfmTRfhxWl58zYOsWVpAfrgVbNPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDbJdhz/wXtxlmddLljVjzPKSiP9FJV+l9DTkpWU7i0=;
 b=cofqoSxoe6m2Sq7GE+DCYGmMJ0DXrAVHf1cvGAZPZ7XRWBMIMbATfkQaO0I6uv3qUTQqy2IQfyr41rIzOIXsvYq3+Qhlv4ae7RuyFV1MXiVFwl4+dVegFfdfeocDfiG4I/qogZNp8XN9ZE944RQaA/pQ/P7UFPef7crv2ytQ0gquya30s0Q0Q0t5KCywWdUitohKgzT0Ppy7nFMh9ISG5EwO6ByymllD2wGEx5GX9x8vi8/+zPILMCQiDfQ+6NYpyTkG1HvbWkVL/L6EM+moqlqXO05cB1eiWwATJAUwij7K+11lQ1oypXsJA+YxZG/+lbH/1baEAzzsjk1yDu19Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 09:01:46 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6]) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6%7]) with mapi id 15.20.7135.032; Tue, 16 Jan 2024
 09:01:46 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] crypto: starfive: Add support for JH8100
Date: Tue, 16 Jan 2024 17:01:30 +0800
Message-Id: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::21) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc6f47d-0104-47ea-654e-08dc1671c47f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYDi7Rlqlc6NAXgSIsdBiYmJbtvpcfpGLGpuPnQ6ZhzAeParZOn/tCFpILmZ6/6yG1HCPAThCyqcDqJKUqN/GxG7S0ZWlm7lsUfaFfeTzFt7WLNT0puE4kaLx6TVL1WAL4mQFZzLMQKno2U17OiqzJ6ZpIt5dHC29zsiotb7UhNaT0y4Io+v/6cKuiwNBSdDjnQm83N971HyFKfWCVERtL5fIi/JaLvoym5D6bQNLXVfUljhFX1por0GR8uGXgjsTpAJvNo7FZidCpoNDqMvdsTrTf1Pd1w9pPvw+BsaZSdedovAWX0MWi8+DOcaEDVOhwwScQJV3u9NHiwzUCtxbRT7yYlamF09/qpXsFGO9pDtCYRgAZB8AH4GtPMb3PUedYni5B6EoQH92/EPaRVcutTZJnX2gSQb1RNzIdVVLxdKj45Vi9dvpV6jJufu0qd0QkhA5RqKA2ry3D3+jDXojf86pPBAedwguHCvwenvfCG3i3Z3zYeoNm0ry0lQD8x259dz+fUuFAnoMqw98Z2e3GDOb6MQFvnk7XlXeKdt5pNHXKbetHrkB4if/538H3Xjk0kulL7hSrPf8X9dU7nzr0rYKMR1HVI6GdVF9oXgR04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(41320700001)(2906002)(5660300002)(36756003)(40180700001)(8936002)(8676002)(86362001)(41300700001)(38350700005)(83380400001)(26005)(40160700002)(966005)(508600001)(66476007)(110136005)(66946007)(66556008)(1076003)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1b4LD5oo/3waiX26e6jp6AU+PZS7RG3PEAOLgDdTVy+SrsEOlnyA1XpF3D5I?=
 =?us-ascii?Q?piDq79E0lxOpQB0h4SG/BX+6Mi++vPCUXPpsYvaZ6+JpZK6t834rvIGalFKn?=
 =?us-ascii?Q?Xd+lId0m8DVnHBkJwsc5VLP0QydFyfDZK1f7OxBgf5SVxgN0zUmD5jLXEUW5?=
 =?us-ascii?Q?seYE2btknCxXGB4P8a5Xe5jVJZpDSkPjHY/iqCPR3RE0TaBqfRAQzwFz1e0U?=
 =?us-ascii?Q?6A+a09DA4M9EbYHUgwV2h4KLpueEcZuk0iftzi6Wu4RZlNrllZ16kVrG2rkk?=
 =?us-ascii?Q?otinXXvzEgXujFAfU7cRfJmZ6BTcpgWujeQs4vL6xOJQntI74TCZX8COUswH?=
 =?us-ascii?Q?7y8AT0wkzB+unvKEoociMyxBpZeXMsQ3RQwTSR7jc1eJzQIUdlBSbmmEx0BP?=
 =?us-ascii?Q?YaR3knlfipjf5qnVCaQfAGs7C4LtNrbzeMDRImTmRuazYowPywwghR+RI8ay?=
 =?us-ascii?Q?86CZQGHlPdFNczxZfWUOgCPhtp4t3AJVyS8RnJonz3HJpMwzRanqmssHV82K?=
 =?us-ascii?Q?a4jlkzuSNqRS0lzXwWsLlq3VC/S3LVL7QWdoZ79/OmBkylf166tyCcVD51Ui?=
 =?us-ascii?Q?BZZNLMiAGeDUIepL3PerdVX00UjXwFhVxJsjOD5LjckVsaCKb/zH8V7zjaDK?=
 =?us-ascii?Q?XkkzmkWQqOCVofE8O7H9YWKc54P7Hl27U+rhSKxOcR14ZUWRuQQ0HygEoG3h?=
 =?us-ascii?Q?rQkF6vmoTiK61HzKDFgkOSXiD3vbUtNfOZSo0rh4il9X1BsLXrRFnyK8HYgI?=
 =?us-ascii?Q?FB//aoUocAVqFbUOWr3UAbROsPnBgWf572ZM4FfvhsBGwsmxF+bUvjVzbgv1?=
 =?us-ascii?Q?Kfmzt20BZ+w+WrmDS7wXTbt4SPUfKMY/1cHVC3zs8NZ3XmBYkA/OpOVpxkE3?=
 =?us-ascii?Q?2Ub/Lp0Ol7QBLkpBRmkRQCykqTXqg0wZXMy6m8A1QuEOp6IfVJWwrYqa0/Bk?=
 =?us-ascii?Q?q0ed9d2R013lD0ZTgCRWoVr625Eh9j8niF0TO/nHAUXkqmxtAXVgI6OR2ESr?=
 =?us-ascii?Q?NDFwHfi3RQuh4RAEIZCq9/UBPgV8ykCdALZqI3D94iie1X0c34q/Tb8HMOHP?=
 =?us-ascii?Q?p+z07EYb8LR8rIYfSFBZUuQX/q3HJjbzTrWtpanQ2AhPcWxcYgR/RWcNmrWT?=
 =?us-ascii?Q?hwkXETC1z9MASQq87f1joZPDauipLG8y3/e5zLhx+XUS735lbQj9J2QFXrv3?=
 =?us-ascii?Q?bAGaJTvwOzhs5wWBqwsh2qkja5WU1hpejqnDfyXrPRhFiyecniWJvgK9HR2G?=
 =?us-ascii?Q?Vg8c6ZYD6PPMbH1rE+nLx9J2u5DiYJ9usLtG1q6l0aZLAhzhqAoIzXCfj9Jo?=
 =?us-ascii?Q?lpOG2W/gskIAsmodUQr36K+OyjTlYxUEu7ToifVZMH9PeVcpSMswCjFbk/iJ?=
 =?us-ascii?Q?OrME+i2F/Y9tX8sDjyQ7+4+wZ3nBIDIFeJYN94Z6QuIesbrldPiolx38IOD9?=
 =?us-ascii?Q?eqjWN8TivOiz7MO3c8dXDonENJBhPjPrz+wyiCrYjmDRJiEMwtIp4xd8GTA0?=
 =?us-ascii?Q?u6UAqXXsvRBjDD97BxKTHIlrjQEO8tRr4X1u6A+KUcqu2TdCNNaBcEKY1EUA?=
 =?us-ascii?Q?OPWHoQimal9pH3E4SINC3Ei2dzzbwyF/TcRq0ChYW16K6onQU0Tp/hYX4PzF?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc6f47d-0104-47ea-654e-08dc1671c47f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:01:46.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4oldLLuQUQphvXNm4mxhunXCWP60yema7c+CFl190o06JJp5ZuskA+mlqYt4ahgMGqiUdLrJWCCeRGBEr/Yd+4trukVM8X7JjG+/AblNgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640

This patch series add driver support for StarFive JH8100 SoC crypto
engine. Patch 1 adds compatible for jh8100 to dt-bindings. Patch 2 and 3
updates current driver dma usage for compatibility with different device
variants. Patch 4 and 5 adds new sm3 and sm4 algo support to device
driver.

v1->v2:
- Resolved build warnings reported by kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-lkp@intel.com/
- Add Acked-by for patch 1

Jia Jie Ho (5):
  dt-bindings: crypto: starfive: Add jh8100 compatible string
  crypto: starfive: Update hash dma usage
  crypto: starfive: Use dma for aes requests
  crypto: starfive: Add sm3 support for JH8100
  crypto: starfive: Add sm4 support for JH8100

 .../crypto/starfive,jh7110-crypto.yaml        |    6 +-
 drivers/crypto/starfive/Kconfig               |   30 +-
 drivers/crypto/starfive/Makefile              |    3 +
 drivers/crypto/starfive/jh7110-aes.c          |  585 ++++++---
 drivers/crypto/starfive/jh7110-cryp.c         |   65 +-
 drivers/crypto/starfive/jh7110-cryp.h         |  104 +-
 drivers/crypto/starfive/jh7110-hash.c         |  275 ++--
 drivers/crypto/starfive/jh8100-sm3.c          |  532 ++++++++
 drivers/crypto/starfive/jh8100-sm4.c          | 1107 +++++++++++++++++
 9 files changed, 2329 insertions(+), 378 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c

-- 
2.34.1


