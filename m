Return-Path: <linux-kernel+bounces-94328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CD873D73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E421F23BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509A13BAD2;
	Wed,  6 Mar 2024 17:24:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD17605DC;
	Wed,  6 Mar 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745846; cv=fail; b=W0b/EDw3F3Cri9dox6z+wX8ea+u8og+TqRPsechZ+ZKzEmEOv2b+ry71Qa5RDJKYjZ+Ift8dDHdNPgaXEujn7zFQX58V9HLF5ujmQZbq4EjGlyX6bfOer6YCZm7SWVMfDv/p+u1jy+6IKYTbgSsbj2cTD3DvEEETSjKBEVFxtUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745846; c=relaxed/simple;
	bh=ruLSbQZfw4F7ha7h+7BUfNVIlsMkIacYgq+qnvgPgQk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pawhfh3YRO9+fzr7nsd6/jRedz38CaZdbg+r8TE2IckDBS3oqRDUmTBr1eFrKzCUcHcQPoYIsVuHCbNFRYzkkauTxgSJfulM0fieZKoy0bvnAeASLpXNDQIgiotuvExZ5pZAUENqVs5nUuoX2RFQY824+2LioRAZDXqWjdkrQoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA9y2LV8QqJJwyZG6VML+ebxhu1x512Ke1raKIQFI/iH07oGbnToGA6F1DAQldweUcD7Efel/0LnSsxnKra7fyKpJcEnrABPTPzceYKuTDS8oWkS0NpVkOxK2K2tRy1uUXImT5+sE//6yBATq+NHmSV42oUnRpINXhbr8WbhbGPAfvDxUCX26Hubd9h0g8t5+uibugbAiOswVvhuM8HRqD5n4CCXSPYxIhR2xuLWCYmqJzEISsau3w7X1hn2en+vJR7z/s2jJmPzJP4FEkvrOwpEjnVZNAtAeq6vP76+shHyF9N/WCvBrggR6546bwKl3sHZ2Vs5bbU0HghL4hYFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjPu3HmoRqXxTMrq8/4Xh/+FRgsoE/H1VR/fH/N3uEM=;
 b=nqNN+PoSk4ApZytMsykfFIJYqb6f91d4wRBTG0U2SH4Ncs3/RuV8nKCeI2B1wkI+wB5hBDwyDz9ygnlwHy9Wntpf1y8Bhw84eZNXu/CFMwyHn5SWsr5aNdU8XHN3El0Eih8ykhsWORiHoVtFagl5xcEin2q9KprK0FBSQhUp+U+MstOJpAtwv5su2wBL2Yc/ZHjtsB/TSKvgCPpewsAgHWqpjUgS0wSL6Vm9rqiyk8A6i77OJHaP2rDtK4zmDCzhLEb9U44bxByBtLRXmBt1YWT5ZPGlRpsbm84OzF1vPidEWEZ78uhbvYw4PTOUQGY+/F9ULWMLWilMlGyCXsw28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1043.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 6 Mar
 2024 17:23:58 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2cf:d7c2:e40b:d36e]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::f2cf:d7c2:e40b:d36e%5])
 with mapi id 15.20.7270.046; Wed, 6 Mar 2024 17:23:58 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan.linux@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] clocksource: timer-riscv: Clear timer interrupt on timer initialization
Date: Thu,  7 Mar 2024 01:23:30 +0800
Message-ID: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1043:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5e1a72-6791-4f6e-1b24-08dc3e023529
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iH39KKqYwZopLnHPLu+H9Wfea7LrAtSoEwTfOlbN60JngROcpA9wHX0bdOmHzklQKHbAcbLzMZLRRLAXwwRHk5LEKfjdmfAsR8OkNitm9DicpgTDRv9J5xzstR8U+7bM+H0PgqahCb4joMBlc1ICIf4/cj5GPkTwQ4de4C6JpkBoQcbj8bDztzaEngB0EfjFMs9Mm94IghDyCizuyPoc0YA//IGEdvZbxyjR4iOuzjoHtZEqO/UomJTBsR5LiLscCzbDD99Hy//FBuYjkvlTBP8vMUTZegMqA8zjOqxAYDzP5MOktApyxYnfcAFxh4s8neUH68+zaczJyUETaYLF8k/Gu6GYNXqG3GNWarKzijVKbAhLzSF2fRbXd2iw6EnWyUU6MsiRCmPS1vK8TL3WdJa+r+5vJEG4vbdwsJnmiJ62bP2MkI95RjMaG7my167Mm+5qGf8PJuEcdvJ0am3CXsBmst+8+cC4P393c0zp2iCP9alqNHUkKFlaiD2xK/itMHtPS5U79b/EHUll2KsdcSjzlJljbi9RWtHImeNpPLdnmRu8OtjOvCVKuFtZlY8wsRjKg3G+uLPQUxoSULOEdH11d1cMaayn9byxPxcKWfWVDyqaj2KYnIuo8hnEzSjl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s12m7vI4iOByP3EoE/70ntbeK5DYTdHCdSAvC8RjeATvlQEP+i+QJf1o+72e?=
 =?us-ascii?Q?2/8vtKgcb2RHIRGY2u+P9M95Z/hL4U0/ttHy0FhD9U9B+pQ6cvgAbZ/Bx9d6?=
 =?us-ascii?Q?cWcrVkfkdKBi4zdm1kE+du+bwDZhf/89aHCpHMP9VKLyyPP3bVIbnZ3Tz3M8?=
 =?us-ascii?Q?dKqNU5iZtwERjS7BDT+vmBIwg+hv/iBzVQ8Xq5tGj7C+jxI9Jm8ZR+t2sVRy?=
 =?us-ascii?Q?vB4+2mdTccxp63YvyHaOxOL3YJu8NL7o8Pqok5G0esMZz9CfFDS3xTVOYxxQ?=
 =?us-ascii?Q?Jd4HU3XlWKkvvCK310uDL9Qqy0awa+w7EKmfwL7gUmqCrFx2ohGUPg4TMxiZ?=
 =?us-ascii?Q?SZCiZ9T1NPAAVf/L2IvlvUSRxDnqd/TtOzLPWHbX5SIKE9oNUqbNIJet9rvJ?=
 =?us-ascii?Q?5zH+yJDtlgWls+3X2Sa04wOYWM9xpLNki+K79frtEhLKYiIkr8FetGq6Q2t3?=
 =?us-ascii?Q?i5ppwo4RDxlm6wKkgf/1r3SVmbgg3WL8nwePxDcg3xhoMaeJMJPjLHmr5FUo?=
 =?us-ascii?Q?PoUcj/bwX8cQemBytq1ZWJ0FykhiuiE5FiAgujWVoUA4d5kvcQ1ARAuoQtZy?=
 =?us-ascii?Q?6klcnnzwaRWmVPxBgiE1KsKjHwJgpycCuy36eNGDCJ9b4EwskjCCB9eUzw2V?=
 =?us-ascii?Q?H2uZ9arueyHHMxeFeyGTLdyHfgjcELviD3EFUSQQurL5Z01Kg/7+c5niuvmi?=
 =?us-ascii?Q?RqX1OsctJ+FfP5iTVMqjiCP5ucBLB+tesPyE8V5Ztw8IrhJZU3Yb8DhIyBr9?=
 =?us-ascii?Q?2yAZ6Lie7HZzoPh3ububat7EfKpdloB9G4C3ZTHt19loyT++cf3OE9Jf0clc?=
 =?us-ascii?Q?0iOt28QyuPqOlJ5xgoFMIeOw+msUclHK+7B/LkTfig3tOwi3pp2Q8E+9Urlp?=
 =?us-ascii?Q?sYDjl71S31PwKUAGaOD7dKrpnA0sqmhkYjM18iHxWy/7jo8CO9U29IX5xrmQ?=
 =?us-ascii?Q?Im+DhR97paeZvIrtgoERjuRgleLYYedInHzMMth3JaVA6sVxkPaHCt55sF3Z?=
 =?us-ascii?Q?382PqKEfs3NIjsO6EJAKFfJU5dZqNyqZzzibxbc0NCa3mxOVRcs9T/kBWko9?=
 =?us-ascii?Q?WOHdnZoJGK6xQBw3KBRXdj0+9mhNT7ga0jcYZ31EtrZzXSnDJp7JQRRlbix+?=
 =?us-ascii?Q?uHrQbVOxmMdvhFzLME4cUGNdMIL/67x/+YbbJDjrVKj8EhbuXyWRNysVn4vW?=
 =?us-ascii?Q?iWpZAzBvLjGpGt9xhEpMkoeIVd50LSc6dcR9yqSEPnMY92hM9L06FtxEtHId?=
 =?us-ascii?Q?EcI2K53m1qffg82B5fldr8OqmakLBRTT3o5nZKEye+idQCRvWYeMezy8Tlva?=
 =?us-ascii?Q?hQHRgup/r7O95OCLftZlceU/OiBA7dobjK5ze/Sgs3xpz8/YeXskz5mxXVbB?=
 =?us-ascii?Q?FLXSaXD6b/6GM0HoJt65VE1DORjFrJSZh3zdNykCJPMQdnsPwL+7nA9wFKp1?=
 =?us-ascii?Q?oD0sf1GQnLLJdiZ3VTBl2Rrpa1EwUWGKciEP2TE07X63PrGxZcM4qMDckWK3?=
 =?us-ascii?Q?miciC0MnMYH7RKnAg5PXRNjTz8tbWaD/E1ZdRjqfV209UEhmMSlpqYLXn9hK?=
 =?us-ascii?Q?5JD2Mn2INKXVkUYa6dmBUPTkFAYKZ4k/NjHSAnSPAzqUGuGp0MX4OHbSwPue?=
 =?us-ascii?Q?cmq6s2KfocuGkDyaoba+St4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5e1a72-6791-4f6e-1b24-08dc3e023529
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:23:58.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Jmw5zhTrAkPDbGFlCtDB7So/u5ZcrMIwoOOmMCsNaMPSbG7/MCQgLOb8J9TP2OoeefTZ1v5AosMUidI62cHs+ABNjQCpLI8u5XHzrjDQXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1043

In the RISC-V specification, the stimecmp register doesn't have a default
value. To prevent the timer interrupt from being triggered during timer
initialization, clear the timer interrupt by writing stimecmp with a
maximum value.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

---
v3:
Resolved comment from Samuel Holland.
- Function riscv_clock_event_stop() needs to be called before
  clockevents_config_and_register(), move riscv_clock_event_stop().

v2:
Resolved comments from Anup.
- Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
- Added Fixes tag
---
 drivers/clocksource/timer-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd66566..79bb9a98baa7 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -108,6 +108,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
-- 
2.43.0


