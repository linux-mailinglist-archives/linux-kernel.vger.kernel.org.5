Return-Path: <linux-kernel+bounces-11486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7A81E71A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80941C21265
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CC4E1CE;
	Tue, 26 Dec 2023 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BzRPrgId"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD674E1CC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSPvx653ZrzrhgXAnZYk1zg5NLT0jYiRQGfYQcI54Ccxm2vHMOFzdUgHqtO5IrtZY60Lw+3mXLxpnBWSB5FvpCioSRga3WUBBtZcNQjSqfBMCEPSXLJYwb8IJ9hDMBDBmJqb61oHUWmJTYxsAq36NhMK5oh5dmxweUSyEFLEZAz8sS5joizFllHgNvXN5VbTSOwHVXU3VVooM8sjkTblDYO7KdFXtEAKOzN14LiaKN83Pz237OrRxIO6BTWZ+ZvGw12zNceIboUxDXt8KzJqPrGINx6qMe1FLCdNPbCtuyz9SIxSDtswwTMyT1wiiJbyJMMXST6LSlvThGqWFZGI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox66LgmhY5KCTpcFnlH6JS6DY38wnJQk1cG35MZ1K74=;
 b=d0LuuJp5V8KJNzeTQ9C6h4cG+qVY1dpdtI96ljayLisitOf7OfGZgXtNJ/Rl92qgpVAy7E2QNLyzvV4JezlbGZXUFIvu9DLZgcUTXv+/0RaWCJLMmtXb/bJqx2D1N3uBiFxJgdZO/KGU499jLaN4Kz/0xs58XxEgjzn2Ao/Iy598cb3g4oPe08QpQu3Y39yjZ4aTjVHqVH9fVyb7gVbJENYqDoSgt1QDhnyg6BQaogQPn9n6k/tbeYZ9FwaqO+VSzXL6QSn7CuRmg+sh+Fg/WDtDUivY5mUkfVq2nnvqQk53FBw5cOr5tNQXgiyyz+FS5jQjYGIzfsDXsbrutlxGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox66LgmhY5KCTpcFnlH6JS6DY38wnJQk1cG35MZ1K74=;
 b=BzRPrgId+9h2L3m3WvsNpX6fNNe8PIJkt7hw5nZj1F0Hle0l/15Ak1mRBfCN45dMjebWavwnAxRyU+IJeJAL+dWoEfI/UHMqgB0RWtppyrbgsutpeabT9qGc5B7/+JNFVH4UDGitACIxJA7x1JRfq/hNL3kjOOrMo5RAv6exmaBIArQud33cqOdQfGyh4WlyNHs5jXmfKb0hKvBYMOsv00lB+xD8MJpKPOh/8MxCov0UKPosaTIQuL8ZLXCjSxbJWNnLu546HoywESxalQLhPLsur2zM+1TSi1d6sP8Q9mqdqHgQ8eXIBM5ZoaHccOC6zKl5URgFYGQLAzgdMuUK/g==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by SJ0PR84MB1799.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 11:29:39 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 11:29:38 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Baoquan He <bhe@redhat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
Date: Tue, 26 Dec 2023 19:22:39 +0800
Message-ID:
 <MW4PR84MB3145D3EB871BBD59AA71C0FC8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YCLSsDQ0MboQT6JNZa4aDpz5A11Vqc+Nxrn+RH16wmA=]
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231226112239.2018-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|SJ0PR84MB1799:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a11503-b3b6-494e-b4ee-08dc0605f1dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8dt5XL5DAwzOJri04TNt2KC1WdKXJFfqL02yIRRvowrl1Y68IB7C5sBCSwYoKt9adFDr6Ez9gNQ254ZlZwWcZb1ikBaTjB9ZBZw0X+GWocGnu6M93wC3y3Ls4e0txaFciepIwlnMT6kvO24T84irit18kpcaQNgh2EcizlzjZsGy8YOzfQfsB+EFxS78hLaxxHK+zGJ8zAAAJDTWvA9S6n/qw7r+s3l9qY6W7SPGGV/adZr6UBtuBG2LSnS70G8LRyaWWKbRASRPbpt4F4FeaFnexyOQbDxMxL/54I5bqISKkl2IDR21IpEUinqdZKvwIJSm8Ia6182oJBUw46V4Vw7OZ5Z1Pq/q8I8F/HgIakvuMnj8x8OeyoXqX7ynmHhfwP0FAwHJCA+c/OMK+saJB5xKXtFzksGaWu3whVYqnEE13zuOsCrYbM/wFTFYr/ewTiwPt8I3fAYsa8gGJqTQgPLj7ryWhty3W7nhhWn3PFjxoB/oAkXadsAfIvBdEqJ/InEY7rD3ZaV3d0msz7CRcYm0ufbmQ+ogtU/RyrYaGnUpKMCe1gVf+rrgo7sujrd8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpRgVzm/Ic2bAIJERJNkAjBa89wPgb7eXqRj/TosM/bGLSe/0t6ucs7hD70r?=
 =?us-ascii?Q?Zq6dFN6wUWZ69qEzLRrAoiUa8NYHZXm4YjtbeQt28T83XNBdyyvaQzAHqs/G?=
 =?us-ascii?Q?/sXlY+YDPhTZYq03L2OYywOL6oIY6Xkl0coADN+de8lQ6N3BTTbjK/YVALRz?=
 =?us-ascii?Q?U86PSv5J2L9iAImBIMcUMuflox2h929hF2yq2LEjMuiCLw1i7dDmRpTNvUPa?=
 =?us-ascii?Q?QoE3dzBH6bePuvjG/risxvI77VoNdpem5YQH/ECCOhjkDc7zQ6uTADD/069b?=
 =?us-ascii?Q?ex6c2efDr578QkKPVNqOYrMHe6YcTc/RaW9KXMSMbOcxfiKmmjebW20onyXj?=
 =?us-ascii?Q?RracxhvDEXsa8aZiY9IyGlxNzKBY1+gEhPqRHO/j65polBM20V4TKoIMobfZ?=
 =?us-ascii?Q?H3h37YkbqNf0Cm1Lt6zD/gNGiXO1ugWPdcACwsEIAwuEa80Sf2SIbjaPtJU5?=
 =?us-ascii?Q?MaGFiRLeJmZFeighFWxQPo8ScCm/y2x6CC8chMy+WTtpQQ2YJeEjekFBJOhH?=
 =?us-ascii?Q?Xe/mPFsAO/VotMioCDwHcXnYy85KJPWGiRBXy/RHtCGTMIenedF4Jy9TirK8?=
 =?us-ascii?Q?1Jkt9yJAs9k7qD9eCVguS5OyBtMC02TaNU1pKBYqzTz3giaLYwcxcGSS64nr?=
 =?us-ascii?Q?StrKiZSTpgMag3xTSZw9Wm8Kz2LjiZjqEx/qxzz5D9p/r1AMQFQl8gb6uHsl?=
 =?us-ascii?Q?OBEeuI2FXC2UP9yGdASXt/EbOxzyRBO4MLq5rzusICS/RWWgIgdLxBlXW9/Z?=
 =?us-ascii?Q?xJdUrT3kIsXW0Us7kovynqW4Zsnv+OC0O+Z530tkwEPD+5NOKsfMT+Hr7X0A?=
 =?us-ascii?Q?LohqYlNkxMfRpN7JihUa5//OwxSFF9o9Gog81X3FKM/4jJVATVW72vJAeXoH?=
 =?us-ascii?Q?rJe4YwN2f2w1DIJOzQD2ztVx9BwxLwPay3rqCDB1Ar7TCG2g+Y1DbUgHQVg9?=
 =?us-ascii?Q?irFU0i+oMwootaZfRSCfJ/EG7Ac/6SpSXjuAJiORDGBhbWa+z1qNZGUK5u10?=
 =?us-ascii?Q?ggra5eLNw4O73LHFzX6aXi57EOQhHW+3I0Y0C3BE9gJJ8dmOQSwvfXO+QPV/?=
 =?us-ascii?Q?bD3U/t3TtWaPPOTr7sESdQ3deYrkzNeLs67S9E3Ym4sIHTKRConv4a9KztpI?=
 =?us-ascii?Q?a+S0tipkSTKyNcZJrjY9apytAlPDfk8Oa1piLnLSXFYZtU30k1W72dc2ZpCk?=
 =?us-ascii?Q?uj3YUysQeYcOS7qmfEx50NZ1f/FD30iD01FtIIDc4Zaq8ITnKMVP3fDtgX4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a11503-b3b6-494e-b4ee-08dc0605f1dd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:29:38.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1799

From: Youling Tang <tangyouling@kylinos.cn>

Remove duplicate definitions, no functional changes.

Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/linux/crash_core.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 5126a4fecb44..02397c5639fe 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,16 +87,6 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
-#endif
-#endif
-
-int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base,
-		unsigned long long *low_size, bool *high);
-
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
@@ -111,6 +101,10 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 #endif
 
+int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
+		unsigned long long *crash_size, unsigned long long *crash_base,
+		unsigned long long *low_size, bool *high);
+
 void __init reserve_crashkernel_generic(char *cmdline,
 		unsigned long long crash_size,
 		unsigned long long crash_base,
-- 
2.40.0


