Return-Path: <linux-kernel+bounces-38972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885283C935
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7580F1F23ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CB14077E;
	Thu, 25 Jan 2024 16:54:54 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2075.outbound.protection.partner.outlook.cn [139.219.17.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA361339AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201693; cv=fail; b=W3LOIQN5Ls0BJnxVDzebH9l25VJGKJmRdggDMr41jkMMmkVWFC4ASEH0KkejtSPMZT/TohIe6BtuShQjVyjw46PstOBklavfBgp+dYxr8Aow7F69p+UfC7y7qXZkwjauc5jG6AEjxsh+VtPAoz5+p4Kcs6liTfOivutxKp24tAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201693; c=relaxed/simple;
	bh=BB9kcsfcxzgsF5Cr0/D0Fi8MEF422Cp4ctFlwc/H2/c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yi934zzVV68tsohB+3J5NDucGffQKkZY/GuYPlnW2k4ksWOZG45LOLd49Nuz/Go3xNxsUpHI37K91PZt0m1jI/7V1ibiie1q4ihF4IYBSn8ZAVTbxm/S9qLoWQ5FJxYW//YcBa9609AF1PQ4Waomu1y8lxzoIzSQXDUnMpnSgIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjUD9YvHR3EL5/qvQbagrn7hoCse2IJcugEPYR3V0cMqJnVGbrCXSFvP0TFZ3uF1mFfMRbHdZDzP5jQT6C+CxFhFwIPPVlJ3T8cEUZ22HDiBvQZ7Q9kS5XM3xwvVLUp5zlkxQ7qn/HJPaDAr367DEUW9iJNHxpiKha68W0yDSim0X2Ebs/u3kctxGWRRiGGJmTc7anovIcqezImoCgI4KDPeIeRXLNdBpvLLeb5RxeH8+Aur1plwLZVn2dxqNCQQDb6+qGJjw1Gtr2LOwjmVHEK8GNuQMjM/L44rWQGTVmdFx4F6MCGIzuu7WGpu5oAgkKEWD2fBKDXc0xn0v+RnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj04M6qkisjckrAziuxY4Ncg6A1p8U5RzFfsBjh1eyk=;
 b=W6ELgTXAkAMkkpQ4wkJgVkItht91tA3dg60a3uOkx37A53JUZ4b/ykGHXTRUDPFGZ6uTFBEk+O9c2vo9B3mxTOci2BONRsaJEwoZPd+ui9fgq0JD9G64f2wF/XnBRs7CpoMiIF08JHRsL/J5E3uunuE9KgWcFseZglaTJrG743i2Eby8VwyrdJYJLytbTbQ9k0sL2muMo0zflzuqXNks/uIBj4EHtUDMlqYbcIQ+v9GqKAYTod3tpR1e3B7yP5OhlxeJTinu6TsrKF8jLk5pZxZDoEaxraWgWcoGsBlp9ihvjm0J5LRccrQ1AMt7Nj06F2LtgcH9uVQnyVgJ/18r9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:54:35 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::4d2f:3393:3d7e:7a45]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::4d2f:3393:3d7e:7a45%4])
 with mapi id 15.20.7228.026; Thu, 25 Jan 2024 16:54:35 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan.linux@gmail.com>
Subject: [PATCH] clocksource: timer-riscv: Clear timer interrupt on timer initialization
Date: Fri, 26 Jan 2024 00:54:16 +0800
Message-ID: <20240125165416.1987576-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::18) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1107:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de8e369-dc9c-4cdd-d47c-08dc1dc64f4f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tqFBeTKh5kcDmujekmXPv1UuY5/v5Xal6UZWKgtV+0SYo+BSHkkRev7SJ91kMzYJYQ1sYszZg0lvYVg6zJfpeZ//gknUXX6YnXcoRBOPEd/D+FoIiBwhV4WxNjnpWAIgnsmpWPx+XBurDwsIHY4kTfyGACMWARQIp0IU7v7zWHDgG9OY/041jPCVtZYTB7FlqxFng/zFT6tZ/uX0g7Ku0bQZ9Ej8mccAG7z/XRtvExNLal6uFmV6G6ei30IrLTWnOYuWHTfYyIpXHd7Kx8XR4zK2E8K147RVNfZZpHZTzZLI+qeVePRmUyakTox65TKR+jtu5cg9CCmsZONBMUK5cOHxjFzGZFVIjObh8/a3BDfvKLc6qOqaXwcm4sZIM9yUZrYAGFGMYZMcWu09Co0ApYsH6doV3Ldzyeq8YgI5M7jivYKbAkvYCVwaxJ6XjYHE2L7CJGeG2bLgved6zR0CT7UBK36EauEVCGxYBjjbYhC8DSVAegQSjuudKU2Wh73AY7Vttq01xXcrJLpSVbRWK/MQe3p5cteDPSNTJFugn1iw0kAbM6rOufSSDYhrLvd9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(508600001)(41320700001)(66556008)(66476007)(1076003)(5660300002)(4744005)(66946007)(6666004)(8676002)(40180700001)(26005)(4326008)(8936002)(2616005)(110136005)(83380400001)(2906002)(40160700002)(38350700005)(36756003)(41300700001)(52116002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kvhHlvYyeX2SXnSYEbJnmGWQgAj9wgcIB6hPCFElrBHbBmaeJLARNRz3azP1?=
 =?us-ascii?Q?YTtrdIS5L+mxVj5Vj+uR+OYxcBNPt2jn/Zwe3rJVlOtt7PW15Y1PAyHB3SVx?=
 =?us-ascii?Q?wQkxQMufkMamUiLhuuoUmGNLZAsAiFH3XLdX7uexWUgFeAecx3dDRUPHslbi?=
 =?us-ascii?Q?4IKX8PxwH66B3jtNojzKBL5m+cxoYZnx4W4nu0nRZyTIDe0o3Yp6uVhRxmPK?=
 =?us-ascii?Q?veD2pn3h4D/pVrikOX8XJtm3sJBTr+T78WKNBemUM0Ab79GqKpPMu6eXdcku?=
 =?us-ascii?Q?z0du+0zeC106zw5vUujxskiTjtjORoPQc0UVGI7flgWh7iOEkPczw2Qe2GMD?=
 =?us-ascii?Q?SbePBcvTezmXQlgHGOcW7dGLluRNkVrb3DmbRWY9itSZaCIZNbegHBNhSias?=
 =?us-ascii?Q?xPDkhySsUhlPoQEbgBE8QoKzV1Yty2O4cIw2qGuF1T4mwyCj8lxxl7xO1nMH?=
 =?us-ascii?Q?jPMurMKX6/3qosAmW+YH62RebqSDdOpnrLzVmvaygvJ9RKcoVmzKfoPuI08E?=
 =?us-ascii?Q?vGezIsykJvOXfLD4TMS3DM/ZrJytfTRKsyEpFyZIJBJlV6vgaJPdsuB9w2fa?=
 =?us-ascii?Q?8EZFrJFTkWVvX67AYXcih/yvQUFG9Yoju4mppqV8dcxF/3xk2XvZXkLgeqRy?=
 =?us-ascii?Q?vRNNfV9OIkw4nhBqPqAlLKaqIqLBMtN/Icp4zNV4qYYgi66+0U7q1pCMqHGJ?=
 =?us-ascii?Q?zVop9X2EZQ8KLCdu4IgNc3bQoUzg9dw/LKNF8T5qx3fI+d2KS6nCekdRwz6V?=
 =?us-ascii?Q?n3v9Ztu6KlxWMl1CgVRdvwyas8R1/ZRSgt3Xaqhs8apueqEXIYbdokX9NuT8?=
 =?us-ascii?Q?8j8ziVpWAQITIyiPLOTUnFi5K3wIH3MhilHxHNQwOmQfcUEDM6x8GVg4DpHD?=
 =?us-ascii?Q?ZN4qch0umkIHjzCcZn9303SErQc69iXu5Ob+QTQ+bz/njMBVE6BCJKv7/Skq?=
 =?us-ascii?Q?y0RO2OpUa66GB19tGuVNhvvGzqQ80ixIKcoaDquro8P6t6jumuMu5yE+2Fh7?=
 =?us-ascii?Q?D45ItQsiv2u/yW1mq307Oo5sp/wq4t81T1sIqEFDFhLfNe+oSTK6nu3Tjbzd?=
 =?us-ascii?Q?sTRI5OpYNZgqOa0ZTxjkd3Z00v772Qhzzrih+xQhyeSYG+RIRBHaTxD9qixT?=
 =?us-ascii?Q?9BxAlO6IVtE1ZccHtBQncG3PMNuv8XEsEN6pbuVDOB+YXMW0jJBEG4W2u7+G?=
 =?us-ascii?Q?RSoec5hQ2B1E02VSxY3OzHlHFe7lMmrFTQ50MuAJR7fwfeaFafa/NDuNuK9D?=
 =?us-ascii?Q?po+cRs9hpefHdG1+VxlNdVZO2CuOYdgz2dEGRQKtp0VlttDfnqltUxuwgRTC?=
 =?us-ascii?Q?HjcjLz7qwBDmS1eXSwvRf/mVoZjzZEkTJ0Tip9lzu3e3CAkVIjtnOktW46GA?=
 =?us-ascii?Q?sp6R7/z5qfnU6g2cLJcCEgZunTXdcYViDOGfPLH3kg8t0TCDYr69ZLrutaHN?=
 =?us-ascii?Q?BRaypWfKfFPrhXXuEVmFFendsKPIJ1ooxhtSGFb2YnoKC/tAjUZ4ry9HtYU4?=
 =?us-ascii?Q?i1dSQjbQkHrS0vfptOpEVDtwNdNkniiY/6E4GHEhsyk/4DBjtaz4kpdlM1qJ?=
 =?us-ascii?Q?pbL6rVMiMLfx7t1c3tZse0UKOVRkYM3N9Tv/xiB/q3UgKFYaVD5t2Ga7CIVV?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de8e369-dc9c-4cdd-d47c-08dc1dc64f4f
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:54:35.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgQEn999+VNbPFvupJZxjSuLIaxpMq3BmKxJyZQqHPi7kIL3Gmrj0Z7q6+JBihnmcRv/LKKRg1t3JPdf5dtOLhspildJpzvFKFd7w7YicwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107

In the RISC-V specification, the stimecmp register doesn't have a default
value. To prevent the timer interrupt from being triggered during timer
initialization, clear the timer interrupt by writing stimecmp with a
maximum value.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clocksource/timer-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd66566..a75a74647344 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -172,6 +172,9 @@ static int __init riscv_timer_init_common(void)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	error = request_percpu_irq(riscv_clock_event_irq,
 				    riscv_timer_interrupt,
 				    "riscv-timer", &riscv_clock_event);
-- 
2.43.0


