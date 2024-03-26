Return-Path: <linux-kernel+bounces-119628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E037688CB52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE0F1C6511D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288D86AE9;
	Tue, 26 Mar 2024 17:50:11 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486F86245
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475410; cv=none; b=ooz33HF4D5l52yMRC9UnlH7yJS6s2+i0fZkxjBiMZ5kIG77zPVRl+3aXpZlXCYho9oCFo0NWYgO0rSFHlSRyccm/5iECHeLxnS+kvdLVnJUmnc4nfI6ZkVjjWmlHP7mlUkRajQomPKS1nFwZQ6ESTKUfjhlRkXPhhu+Dxubz3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475410; c=relaxed/simple;
	bh=96Oq73TAe9h0gUbbbJGjMGe+U38+ep8pHePw4yAd6P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pNLL3h6muQ/uCLZHx4wGRdAa7HNL8ds4EHSVxiDF9zlI6txRHXOX9csPuLmeK3rMlXrdLKGMbY0xvVPJbMSepesGgsS4tt/a91jMP5KMMfw/Fpe/zAgrYC7GYCuDefErq9Sgl/sDm/VjvwyegAtdSvbSxYD3RZ3B8apI9X6/YWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id 3Vpz2C00R0SSLxL06Vpzaz; Tue, 26 Mar 2024 18:49:59 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAvY-0053q9-RN;
	Tue, 26 Mar 2024 18:49:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAvv-001fMV-Kb;
	Tue, 26 Mar 2024 18:49:59 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.9-rc1
Date: Tue, 26 Mar 2024 18:49:58 +0100
Message-Id: <e17b3ac60832a3ff92d25d1a05bf814e8f15d0c5.1711475325.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - Enable trimming of unused exported kernel symbols,
  - Drop CONFIG_IP_NF_ARPTABLES=m (auto-enabled since commit
    4654467dc7e111e8 ("netfilter: arptables: allow xtables-nft only
    builds")),
  - Drop CONFIG_STRING_SELFTEST=m (replaced by auto-modular
    CONFIG_STRING_KUNIT_TEST in commit 29d8568849fe5937 ("string:
    Convert selftest to KUnit")),
  - Drop CONFIG_TEST_STRING_HELPERS=m (replaced by auto-modular
    CONFIG_STRING_HELPERS_KUNIT_TEST in commit fb57550fcbd86839
    ("string: Convert helpers selftest to KUnit")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.10 branch.

 arch/m68k/configs/amiga_defconfig    | 4 +---
 arch/m68k/configs/apollo_defconfig   | 4 +---
 arch/m68k/configs/atari_defconfig    | 4 +---
 arch/m68k/configs/bvme6000_defconfig | 4 +---
 arch/m68k/configs/hp300_defconfig    | 4 +---
 arch/m68k/configs/mac_defconfig      | 4 +---
 arch/m68k/configs/multi_defconfig    | 4 +---
 arch/m68k/configs/mvme147_defconfig  | 4 +---
 arch/m68k/configs/mvme16x_defconfig  | 4 +---
 arch/m68k/configs/q40_defconfig      | 4 +---
 arch/m68k/configs/sun3_defconfig     | 4 +---
 arch/m68k/configs/sun3x_defconfig    | 4 +---
 12 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index a6f6607efe79cd20..6bb202d03d340ae0 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -26,6 +26,7 @@ CONFIG_AMIGA_BUILTIN_SERIAL=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ATARI_PARTITION=y
 CONFIG_MAC_PARTITION=y
@@ -217,7 +218,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -624,8 +624,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 0ca1f9f930bc1fd3..3598e0cc66b0ee23 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -21,6 +21,7 @@ CONFIG_HEARTBEAT=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -213,7 +214,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -581,8 +581,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index ad0b50923d99f6f7..15ff13802a6d9b6a 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -29,6 +29,7 @@ CONFIG_ATARI_ETHERNEC=y
 CONFIG_ATARI_DSP56K=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_MAC_PARTITION=y
@@ -220,7 +221,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -612,8 +612,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index ad8f81fbb630c2bc..9a2b0c7871cec73f 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -19,6 +19,7 @@ CONFIG_BVME6000=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -210,7 +211,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -573,8 +573,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index ff253b6accecbd3b..2408785e0e48909b 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -20,6 +20,7 @@ CONFIG_HP300=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -212,7 +213,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -583,8 +583,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index f92b866620a7de86..6789d03b7b528fa4 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -20,6 +20,7 @@ CONFIG_MAC=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -211,7 +212,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -600,8 +600,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index bd813beaa8a72553..b57af39db3b4cb89 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -44,6 +44,7 @@ CONFIG_AMIGA_BUILTIN_SERIAL=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_MINIX_SUBPARTITION=y
@@ -231,7 +232,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -686,8 +686,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 2237ee0fe4337607..29b70f27aedd4caa 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -18,6 +18,7 @@ CONFIG_MVME147=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -209,7 +210,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -572,8 +572,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index afb5aa9c5012c4d1..757c582ffe84fbb1 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -19,6 +19,7 @@ CONFIG_MVME16x=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -210,7 +211,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -573,8 +573,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index e40f7a308966e8f1..f15d1009108a3459 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -19,6 +19,7 @@ CONFIG_HEARTBEAT=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -211,7 +212,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -590,8 +590,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 4df397c0395f4240..5218c1e614b5a51e 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -16,6 +16,7 @@ CONFIG_SUN3=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -206,7 +207,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -570,8 +570,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index aa7719b3947fb17b..acdf4eb7af2872e3 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -16,6 +16,7 @@ CONFIG_SUN3X=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ATARI_PARTITION=y
@@ -207,7 +208,6 @@ CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NFT_DUP_IPV6=m
@@ -571,8 +571,6 @@ CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
-CONFIG_STRING_SELFTEST=m
-CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
-- 
2.34.1


