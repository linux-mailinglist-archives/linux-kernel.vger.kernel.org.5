Return-Path: <linux-kernel+bounces-102888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8946487B80B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7915A1C222EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730455398;
	Thu, 14 Mar 2024 06:47:17 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2131.outbound.protection.partner.outlook.cn [139.219.17.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FA4A03;
	Thu, 14 Mar 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398836; cv=fail; b=hIDnN9X+NATHWjWZBSPf1K4G0e8udLi6Y8r3/8HSbFwYolt5Fgv50qZNDfxbDGDBLMDDDnayiq0ikJax69wZdIGnlGw7wpXcA60UKSb5aK/tagoRxJGn2dkEmXN+maoUCfuYAlWZA+aTxhGg+hNPMltVJ3mxqkkLN/BOzXEG9jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398836; c=relaxed/simple;
	bh=ArMNK9LJj6hUHI1Rx7dTbP8QTUsJTc14t1HVwzzmCno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzg/brPO2JroAoR6qsl/wmY/ocH515YFdO+zc1Ao9jY3aN/LLUMPFhaH/yatDk1dk7CiwI6o9Ermx//zfl8mYtQ2oYGBF2jm6glXB4VgXfTqLV2CYt+Qp/72Py6MqqZdWVZkjlf+s/4xSMpCCvGnQE5pX+h7wF++Fe0nHYayudQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUb0T2S7Z2lhqEI/HiWVx67UQOoqIKGwQKn+jNdCM7FZQRpWBE0Jp82xdsxa0BQGPFWtzZJC4cJ5saiahDgW7LyvH/goq8/DGCks3pSqklVqEI/sYdv7Zhu6oE4AFmdssw8PzIW9JbLvh9AUatlEX3FccYO6vAOIU18F6tqE/PVkb99dxWkC3F29Lef+HgK15bkT+gzmgSV3cvRhCenomt1+RzmrjjBKdnxFs5xX9d3JpXGi6hw9TlZVqqtflZxftJL71TUl7NIu3YQYrNaUf7qqMuxmIB0egtQB0JWiKgkrq334IMSvHW//3K4v+3xRQPDBUOCnk2VFkWeoYrNerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQEM8FOLWcxfYvVmh/eQrm0TxFeLdfJgmFUVG6eh+20=;
 b=kfEwGQsHYFE/xMNPhquq42QIVgW6/iXbcvh6UqHsDX2ArHvR3963ILpfN8QdiPHHwIjDxvEPZL/MtoQhMSDlA30v0vaOZ8yhcKxd9BAKRGc3//yq9IgCO1ulwJVX/TatQaguJahYkTibUwRf2DIO79WxtI+JGRzRQpb7niXuh0npjXRKtFwiXngj0cHa0FNDRuG2TUxLmHxcgRijEKfbfyRi6zcwbPzsyYIz0+txuI8bieu7DPzxqmb8YC3nc/y9m8IUuHnxfiOPQpBY+kiWs4POJ60u6hZDghHjwO9gjDgt4+HlrP7+m2yqbItjs8x/E/cA0CKqdPUW2qDzaqOEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0711.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 14 Mar
 2024 06:12:26 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::a038:3f49:b470:9207]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::a038:3f49:b470:9207%4])
 with mapi id 15.20.7386.017; Thu, 14 Mar 2024 06:12:26 +0000
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
Subject: [PATCH 1/4] riscv: asm: vendorid_list: Add StarFive Technology to vendors list
Date: Thu, 14 Mar 2024 14:12:02 +0800
Message-Id: <20240314061205.26143-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86e21904-5731-4c34-d9fd-08dc43edb85b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uba59SvBHfYFhK0kZLdA2hJTtYNNpvMVKaRI2YwT2jQsV9liaMrbhliEUqKIAXzmyLvrd2FEaI3YYqR5KXINyDevVDUW3JT+0t5s4CNwK9oLAZvdumXjxub32Mg96LbVuNMWsLDVyzqPZw/RTDCqnuvA033SP97WXrSMXD6TarzNMfrkkynl6PhXWcb8F/Q2uZzkpalDygC9BgSEqcYDHfUD99Fy98Z3jR5b7FYgK7LAVSqA+pgbmrQ4Mx8g2T7LIurmbKFBlvxszjRrBFG+LrmTJdNqRpFH8BCTlaGaaY7Go2hfG55zasxuV+j6kdAGLodPAjGpAzXW6QmgteDM6/9khLQgZqQCIxaCG4O2gL0vUtxL0AtMCZOuOPkMEMsNGupJwBTEs4UlhCbEr7YvOONUqu3SGvO/fY+EEPd2cVTY7LJbywkbsfCVQe9eD2lfZGg8vrUMYupe8foL97fpYS1FTtZgCkrJpp1rRXi8NA/xJO7AlBATXT9m86OVZ9qqw4LErZY9yUnPbhU/WDTMmlTW2PSm2TZfbzzRDcW+Dd2mc9DIVVKauGgE7m/A9kJjB3czwZ+qnyYKjY8LVe/WMRLRF59jlSDguPb9WRyyZPPNR3RqfJm5nBRjJyKpoPqw5eFqiDgDcQ/vcYPEK2nC3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PoW/LxYq1q0Bp/JHxht4S3R4Uqyd3mxVdxLbxwCwYihkoeR4jIoJuJk+6RDS?=
 =?us-ascii?Q?8WmZ9Zy2DgaIBaY12BiKNYoL8I4+V6Tq3uW2r6AmOhHKtLZJC9ZfwCUnxgev?=
 =?us-ascii?Q?47Uv1h9u/PKmLMMRt4xrS0/gDlnYI4+OE07ttAVxdXvWuJ5jaqIP3M+SZvcz?=
 =?us-ascii?Q?CbLW5C/DRoUSD2XeXaQKCmRU4X7ABUBv7Jfn0l0+eti9NMoHV+AnpO+jAogC?=
 =?us-ascii?Q?z74h9AlJ1BSRFX8TWbTOqie9TRzxDDhPcU0PFMohnh/zZAHbTxH5Z4TclUJR?=
 =?us-ascii?Q?Kcleol2O+eVtfAivtcrqEZ+ImTohYoUo4hQDO7sBAQ4ZPV9RxHt1p1yJzQFK?=
 =?us-ascii?Q?mQ101CZZuu3nZwUPbfN6COpUIIWPXPJd+wnHyhdR3DLmHCVDWJr8vBhRG2Uh?=
 =?us-ascii?Q?35dMC2OqYh+tp2YLilUXmtn4uNSl5hG5zaniON+LPd4RRLkkOziaCzZtPtze?=
 =?us-ascii?Q?mMGlRcbirI2IbVfUvyoGm5zlvEOPJ6czv9Sm1cxSp2brpRG417tyQUg3rGlq?=
 =?us-ascii?Q?7CoWdmohOcTEFfVbhsz0RCk0K0E1zvgGkFzrlOpjo5elp2ymoPHH66UJQ4dR?=
 =?us-ascii?Q?ZtLAOXEEJOChm+S7Bj38vDsRYM8p8bVhqziujVa26kWqMU3enOTC5rlTUi0q?=
 =?us-ascii?Q?ZpqEEmaqq5FlJ13M6sIeeSCBmDa13e/JneNTANO+63UQZhAnmjfR9SD1Wj1F?=
 =?us-ascii?Q?Gv+jHKmrtllqZizXFih/dhUU3GdD+lIPCdYPWeEXFOUAfvD5s4QOV7cLeV9B?=
 =?us-ascii?Q?oa1h6sZhThIiN4fwJ8QDdF846RTgZX6bplUcVybx1YAJxUw2thSdwXRL7++W?=
 =?us-ascii?Q?ZSkPtJdM9dSz+ZhoXy+1UE/1P0A2reAK5LrFvbiSOu6mq3UEbtCGrSjg7Fhk?=
 =?us-ascii?Q?7rHZJbkVPq/tkj0f1MFsUcdYGZPov3Mgdyl3VB4fS5OVdL1r/L6MtXg64XLU?=
 =?us-ascii?Q?3ehC8w+v/ge50l+vAJEEMJSL/DKlXB8UmHbPzkfmUd/Dyej/jN5wxKaNHrhT?=
 =?us-ascii?Q?CEkVJrHFiG5tJHoY8cXK8TZdr5S0JELjAdXZvGw+Xkxw/MsDmQ34CyCrTu/f?=
 =?us-ascii?Q?ofnpX10XudIcjRgYVJdH+0/LgCSSph4AaxSNgm2WGbtsNB4Pjb8aV8lSW5t8?=
 =?us-ascii?Q?hxnh8dv6Ud9PJXB9ltK9DPqIZp7c5NqZB/gjkP6BLXMpICStwrHL4wk3rnWn?=
 =?us-ascii?Q?QbrOO4Ng/N08NGv1eMIOupyovzCH0HSLDGOybbKWJncTPO/zmR4EQV8v0m/c?=
 =?us-ascii?Q?uDFtuY3vTL5qP6o3szJMgR4k7YNTX6j0BBoFNcr+JFPDBdlCp6dKrV938HAW?=
 =?us-ascii?Q?fbqlUk3z6BPpKzJ2zOk9hHsWvucWMafGXDAB3dlZ6kV4ai4xioxAbdImts0+?=
 =?us-ascii?Q?M5L7M8wNG6d7TyjNYhoDiuOEvDDLlJOKne+bmjgRWfc/PeeG9nAyEjmSFBXs?=
 =?us-ascii?Q?OtUAn58EpF1dp2SgVr3zFBFOXU8rsRMrrkQomrWzJyNeqMGf9Ynij8iavB7A?=
 =?us-ascii?Q?ik0twDWnkooUdRFxcg6iwS8ppJeBgx44ZiCR/+HRgR34brF+84HrHp7gvsac?=
 =?us-ascii?Q?ww7GtpPb7IQNVtIEL4AwHYajNBnRmDHZ7s/iNBhXqFxvglfPjuBZvWwH/Dwj?=
 =?us-ascii?Q?JOJzYHD0BWtS23gXEqpQDUA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e21904-5731-4c34-d9fd-08dc43edb85b
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:12:26.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpevjTdkAACe8PMOUmLV5zWUQ5CauAY6xkxs5vdX4N75LUIxcrIvjWUqjJCjrjJqg4r0kGjXo3//M4U9iANFWH8NhyZvIp28wbzXTg7BkBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0711

Add StarFive Technology to the vendors list.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index e55407ace0c3..8c8f19ea505f 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -7,6 +7,7 @@
 
 #define ANDESTECH_VENDOR_ID	0x31e
 #define SIFIVE_VENDOR_ID	0x489
+#define STARFIVE_VENDOR_ID	0x67e
 #define THEAD_VENDOR_ID		0x5b7
 
 #endif
-- 
2.25.1


