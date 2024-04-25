Return-Path: <linux-kernel+bounces-158583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5268B2273
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF281F275FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B7E149C67;
	Thu, 25 Apr 2024 13:23:06 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4441494CA;
	Thu, 25 Apr 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051386; cv=fail; b=h/WLcc3r9kq3EwFYGjs42hvpVc/VN1Y2sgdqWyQxBCuZ25D8vEjynZJMvvksvrFtSrBbo4l9Tk1U2oYI+OYH2X5Jfj6tv52utfx6UEH4THF0WVAdN2wN2KiSkeNwLcWVdPnrIkocGXiISNw/U54/sRiq2tvLZz1+K2Ac/OClfaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051386; c=relaxed/simple;
	bh=mJtK3H9awnZNnuBREuluVaHJZfuUt6HWLYgginDbU1E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eRTruxAOW1m9LSiOpWr+mdW8Yu2Z+1GbLAqXNn6pj6X1SlTNGsD6MvK88MO9djAmKXTCKG/Mu1UlYz2hJtoNc91IFSXmGImsPgsmtLLMOKJ2LikVl6vcUycTlFrc1deC/81qTHOAnnDKlJwpPec/VbHb9K1hys6wR9RLbheVtJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CloMHaO0qfiujrKCAssoepeUsLFV2hffdgXi6a8O868x2Z/CbsImRk7QOlhefGXh4wYrZf0aMDEgfExCGjJd90ZmIlQxEXU4+nh/lNtaicVvnHtnXi/P69yDNh5nkoTf4NrSu2U6qc03kwDoK0CQwzM+ZznRbqqZI4U5s6WGn3E9ed44SqcNhXXT/OzcpeX/UZ8VgW68LLBoW6YA5I/Pq5Zjn8Y6ZhMIcjwqSbe9zJAdshV/QyJY60AVjPRIABrYVm/hG753CeMtsel6UArzT/Q6agXfMfzZroOxCQpUulXyugnGj6TthUehJbibVLQ0whgRpU7N2XM1XEtOY4uoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z26SQYXXM7aqkVaWv8SVjN1n2EP0zi4jOnPPszLLW90=;
 b=DukNqB+5ENdXx0Z4G7yYaoZNoUpoPf3oY++d8hezXmlsInMt3vvrwukPfymvX9KmdrPP2iqGSO/J4b2vl0bSE0ugGvVuXfJGEuxX8aV8E8x+Wp7ENtY/QJ6MV8Of8jgXtJDIvsLnNHxbscHOzxVgHtzYkv0UgxQnCfw0lIxbYDEhOOJbPRROslZGer9jpWu0zLMETRsL2+Dl3rIHIBgUaXngh5jTrrULUyO52g4UvjTKyuP6UQ4PaPxPzfGJ6CKAaobFxkr/qq13ox/vcXaQaJkdqAc19JQxNq/a/P1p5Os7xaG2oAhRCcAsYJtojZAXMYRpOVUQ4a20OfpN/XPcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 10:48:58 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:48:58 +0000
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
Subject: [PATCH v4 0/2] Add StarFive's StarLink Cache Controller
Date: Thu, 25 Apr 2024 18:48:39 +0800
Message-Id: <20240425104841.72379-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::19) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0491:EE_
X-MS-Office365-Filtering-Correlation-Id: a51ad521-c5ba-4b84-4ab1-08dc65154f22
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/N2e3Q34vsiCkTR0sashG/JOUQewiLv0YwoPyXLrpn/kCqISOM4pbC2UZTiSoRofcV/9XWcPIWpAsjWtrrkeZ/osPeqSa4SYRH+FvVKgVl0tLN+f1CsBIvB2hqCANFlxO3Nmoq+3/gEqODwW6IKHdeZ20sT0OkkZLzPPwo4CBv+yJXBh0LJeY6RCUER2EQyW32C/0k3fDG8KBDAhORy93I/hq9BFlj5jtENUbpWio5mSv5QNOmbMhXQyCqmd4U+LKSXEheTtY/TRPM4+CI9hzXwOk3kpBDOjPid7eq2S9CrlochkJQ3ev9k2LsXnLfoBTqjByDpaFolq5cBh9v7FjwsZznr4ryKsn73L7gY+13aeA3mK4baZXupB+R62SJ8GPLT3e3U4u5Kxhrl3zdHPrVcBu7s2YDUxm98UWyflzTLNB0QiJ96Pi5LUoYRBrhTyJUifeI03NlBcc6UPGNBRV4wLyga9maWbH0UIF1K77GsiGhPV7+Eq0t/xh6YoFDEwv6Bo0QmViGNXEH6wi7FF7lbYquKUaOx8c29KhP6YmeZL7dTNX88cI61tq8Dca4Hfur4U2CWphKRKEazYxMtDT3JFx+TM4RMyUTN/l3ui9ns5evX91m+7n5LvEk1xF8aknu6yWTA/fnDlisNdQbfXow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(41320700004)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BASsA5gDkVA7knwjQnlik7rzOm5T+bxTTX6qZKipjbSN/b1h45DIdnP/B+XL?=
 =?us-ascii?Q?GqigR/0rIUHyT7BERpKqcZUDFtxLr9jYCplFvzD9+MJkKWMGHw15pXmT5GR9?=
 =?us-ascii?Q?ITITzgSUtJCHh19ykPb53gd7j6Rw1gya63WD2iXugWjF5HVq7G0NA0Ny6YnG?=
 =?us-ascii?Q?i9JM0gdle6mW703RI44MvhSpDGEYPRzN/tEN3q+ozCras1f7822Bf35CLTfQ?=
 =?us-ascii?Q?EG6uEalNXUXi1wlJQlHvJjPTDubJgHx2O44fo9gKK/5GtBeFdwmM2GrH4FK3?=
 =?us-ascii?Q?BCIodB+kkuU8tyWnTe3pOF56kQZlBVDfd/mKXN9QdVSkcdaJ6OEHVB1Hx/vA?=
 =?us-ascii?Q?228Odpe05jI+I1xyz9rxKNrha0q2r3uxWsX9MYkMSGwwbw1WamSKIhI4bzOE?=
 =?us-ascii?Q?ictc+OfFMjRe1a+sfWrQqJGvLt95Yt2X11oT5JSUY+0YaDk7U/C/4fl09POK?=
 =?us-ascii?Q?E6TZ4KecJDE2Vy7WrbVlStI9i2JvCxi1YTQWldWdLBuNLSF/5f8vvzbWSEJK?=
 =?us-ascii?Q?8y8E6fphtnWfUvAeCBWfSCYLTSh4HiBlEifD/UHZqBLXz6o5pOPbX0r9WmQX?=
 =?us-ascii?Q?FNSA6bOzl0D6Uq1nKnjlgBM4qdBryi/Esf88+nyx27msi3gfY9B8j4fbHDG0?=
 =?us-ascii?Q?uc2UZ68zIOtxSYV9Ce08gjgtixQEZDAWNiLkdyW9AG/E2gh2KyPb8QxFkZPP?=
 =?us-ascii?Q?NvnuRa+W/VExHXCLbvmFC0qq8uuTB5vuOKng5lkS0r+5IXx9PmorSArA9e6O?=
 =?us-ascii?Q?NFJf2MnQoqHunADHvq5ovUm/f4VzZcTuGavfNzTj2jtXWQlfhhP3bMAcJMPr?=
 =?us-ascii?Q?x4fA5ref7ImLwd+20dF4u15ynJNjb900qq+jOj5OtyPBiiYHfiNL5LM0ZEGq?=
 =?us-ascii?Q?eMLdMePixbJJ7Fs5J8ecOtJe43Fjb/d3eDv/cuDH0EawasdhiVJ0Gg7DvU9F?=
 =?us-ascii?Q?a1uTkwP51DxFqWQ9O+X3c/dJ5DecQ2tVpKb6GDzWN0DXBeV/yW1wL5U0TFU5?=
 =?us-ascii?Q?Kr44bjf9DDMliU12Rwu2SqxUjBoRTQ1el88HuQXisKE84Jafkb3NLi0yTkqD?=
 =?us-ascii?Q?Y62eOIzHQ3RDN8H/4X/UOuk9HOlBmOosgZh7r5RAsDWicEtfssbKaIy0e0YU?=
 =?us-ascii?Q?nRdL86//e4dTTXpNHLmTBNF4n86yNTxWtFEcVNwojvhYxIdrA6l+fI/fp8zL?=
 =?us-ascii?Q?iLev/MYkrzEm++MRexqpDtQo/gIzg4V/lGOaP+KQpaUThGBQTxq+o9V6BN8V?=
 =?us-ascii?Q?wDNZe8DJNrmW1I47dYph/QyU1juJme5X7LOm4G+JP0Jcs03vc1Vvf6PNC31u?=
 =?us-ascii?Q?PNkwOVNGhqqOKeN5Kba40KGr8FX6KxBtr4oKGqelUbKawbxzWSDZm59WmvDX?=
 =?us-ascii?Q?OJGihlrHqvjRYlkhT8QdKF70A79X2Er92IXDDQ7Ncr0tTVA6TXvgu0WPafn/?=
 =?us-ascii?Q?KeUFzDEJV5Y6l9m2qrwUuSEy3BxB5bL6+ZYWmIK3sCVz6QF0begO/157P9Rb?=
 =?us-ascii?Q?ycTUySJ7BFxP+TEcWPmsbSdM+Q9q21GXCcbIeuHSOhYjC4OLeNQ7CDyaiq81?=
 =?us-ascii?Q?dtyft2yXoEAvoXXlrypIwdk9rsAGQtXmWSSeIkHBNXB/IIokJfLS8Oclu/vn?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51ad521-c5ba-4b84-4ab1-08dc65154f22
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:48:58.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30EOpDCKskbcrG59U0ZLGl8uX/X4vLHmQ/xk3NtvtjLHDQg+vX2L7UDO3qwhe7gKtcm02dXlMoAGWqpO4gQYr1C05y7rzPyxoDghUrxoAiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0491

StarFive's StarLink Cache Controller flush/invalidates cache using non-
conventional RISC-V Zicbom extension instructions. This driver provides the
cache handling on StarFive RISC-V SoC.

Changes in v4:
- Move cache controller initialization to arch_initcall()
- Link to v3: https://lore.kernel.org/all/20240424075856.145850-1-joshua.yeong@starfivetech.com/

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

Joshua Yeong (2):
  cache: Add StarFive StarLink cache management
  dt-bindings: cache: Add docs for StarFive Starlink cache controller

 .../cache/starfive,jh8100-starlink-cache.yaml |  66 +++++++++
 drivers/cache/Kconfig                         |   9 ++
 drivers/cache/Makefile                        |   5 +-
 drivers/cache/starfive_starlink_cache.c       | 130 ++++++++++++++++++
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
 create mode 100644 drivers/cache/starfive_starlink_cache.c

--
2.25.1

