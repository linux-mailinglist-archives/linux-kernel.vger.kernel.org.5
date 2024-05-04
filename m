Return-Path: <linux-kernel+bounces-168516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D468BB97C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84A7B22BD9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28146BA42;
	Sat,  4 May 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvQ+xD6Z"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73957CB8
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714797830; cv=none; b=cj8DvsxXO0e819y50EQUqav2AKlytDQ6z0YyI/5naFwfxB0MuA5ZmPd54XU+HSZU0iLnRT1Tl9YaMQl7HTOGEPJd07iuTVbi7D2YiaGh1W+VNM4pC9j6yLQaYizFkbBPvpJ1UfyJrth46pGpglibod8f9xuV9vqiDKyqfwvJ7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714797830; c=relaxed/simple;
	bh=tNgMtZ3ADGZP5RpLtGB0Fz3rnlP7zSiJ4KzOCNwylHY=;
	h=To:Cc:Message-Id:From:Subject:Date; b=F8WS3i6TUAN30ZuhVdoMZJ9Ye3l0iqyW75IVYf7Mc4ECG4uBPBMoTP1TQPL0K0YZqNy9CqxFCB7Yl6mg3c0A8ksZmIW7bET4EWeaGk39hzrJcDLwpZuoQAxy6mt0ABLUYtGJzkagqaiGaLxj93mbS+8eNQ3U8vzpI3LB7BfrEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvQ+xD6Z; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D91091C001C2;
	Sat,  4 May 2024 00:43:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 04 May 2024 00:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714797823; x=1714884223; bh=wwhlErRrN82HW
	sQSi8hrEnxWXAk60Am1hIXNc62WtW8=; b=NvQ+xD6Z/qbhe3jxc3FBnXXI6zYAT
	ZZB+y56TwqhpWjArgOcIeFwS/JMJ3ZFjIMY7P1Gs79DodY51HHcqg1IYr3Mk4RVP
	ue7WSPvhI9Yny07iJz1Q4HTu161V6T38ulu2DjnQvuLHFpiwdu7825arUOpq7cD/
	t0X+sCIbNj2k5gE/O3FyppOGq7ZZ8vX206NpQjFFMZeWvXbW5uXvkWn4m9rc2HfR
	86DttDidLhmq4bp8Lxran7ovTUF3mCU+kuI4qGP0gXY3ledKhZO2TCCP5soImUHL
	dY7Ik2P/q0znjNvg20LcGr7XmNuilJ0Q3DUP788lxSLKIFTv4F0QC1vzA==
X-ME-Sender: <xms:_rw1ZlcQ0uqzE-PoezxF32o7jc-E4mVKTyTxcwPEVxvQBt540AhsWA>
    <xme:_rw1ZjM7SYBVfX3KMJ8D0MIpb891wwgOfITzVeYs_fA0L8_P10jWU0bK8d3RdDQT0
    Ce_ubRpGVJPG0u5OJ0>
X-ME-Received: <xmr:_rw1Zuhewi6qbI2jj1k19dZ_PC29q7RL98w1GouOGjbhfXSFnh3ZLcORYFWz9xj8nX3CMYwZrQF01odWSntE3-wxvkmd5aduirw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:_rw1Zu9Eynzl-W1E2n09CeWEdECTuPLIp-6Rg4w7VwLaQQmGm_hxSg>
    <xmx:_rw1ZhvYpeaepJcFpr5YPwfy6qk4Z1NacNaDffG_BsHHdsoqGkXE1g>
    <xmx:_rw1ZtHhj1hRTtbyMOfK1Dc5GYRGY4wsLYJccjI-5uVZCfw2udbHew>
    <xmx:_rw1ZoN9btfeS6QCuNsVo6eIxxZi7P9NH9SSAuDHvEoVZQ8plLuz7Q>
    <xmx:_7w1ZrIZEzureBQbaTtCuiinIJKJiRiec8rf7to-yZ_-RaiJvjTVDQyl>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 May 2024 00:43:40 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>,
    Stan Johnson <userm57@yahoo.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <480ebd1249d229c6dc1f3f1c6d599b8505483fd8.1714797072.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k/mac: Fix reboot hang on Mac IIci
Date: Sat, 04 May 2024 14:31:12 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Calling mac_reset() on a Mac IIci does reset the system, but what
follows is a POST failure that requires a manual reset to resolve.
Avoid that by using the 68030 asm implementation instead of the C
implementation.

Apparently the SE/30 has a similar problem as it has used the asm
implementation since before git. This patch extends that solution to
other systems with a similar ROM.

After this patch, the only systems still using the C implementation are
68040 systems where adb_type is either MAC_ADB_IOP or MAC_ADB_II. This
implies a 1 MiB Quadra ROM.

This now includes the Quadra 900/950, which previously fell through to
the "should never get here" catch-all.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Tested on Mac IIci & IIfx, Quadra 630 & 650, Daystar Mac II, QEMU.

Some corner cases remain problematic. For example, a stock Mac II or
a Mac IIci with a 68040 accelerator will still use the C routine, because
mac_reset() lacks an asm implementation for '020 and '040 systems.

However, amiga_reset(), atari_reset() and mac_reset() do have a lot in
common, which suggests that a generic asm reset function parameterized by
final JMP location may be a useful refactoring. This would provide the
'020 and '040 handling missing here and could potentially replace
hp300_reset(), dn_dummy_reset() and q40_reset().
---
 arch/m68k/mac/misc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4c8f8cbfa05f..e7f0f72c1b36 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -453,30 +453,18 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II &&
-	    macintosh_config->ident != MAC_MODEL_SE30) {
-		/* need ROMBASE in booter */
-		/* indeed, plus need to MAP THE ROM !! */
-
-		if (mac_bi_data.rombase == 0)
-			mac_bi_data.rombase = 0x40800000;
-
-		/* works on some */
-		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
-
-		local_irq_disable();
-		rom_reset();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
-	           macintosh_config->adb_type == MAC_ADB_CUDA) {
+	if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	    macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
+	} else
 #endif
 #ifdef CONFIG_ADB_PMU
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+	if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
+	} else
 #endif
-	} else if (CPU_IS_030) {
-
+	if (CPU_IS_030) {
 		/* 030-specific reset routine.  The idea is general, but the
 		 * specific registers to reset are '030-specific.  Until I
 		 * have a non-030 machine, I can't test anything else.
@@ -524,6 +512,18 @@ void mac_reset(void)
 		    "jmp %/a0@\n\t" /* jump to the reset vector */
 		    ".chip 68k"
 		    : : "r" (offset), "a" (rombase) : "a0");
+	} else {
+		/* need ROMBASE in booter */
+		/* indeed, plus need to MAP THE ROM !! */
+
+		if (mac_bi_data.rombase == 0)
+			mac_bi_data.rombase = 0x40800000;
+
+		/* works on some */
+		rom_reset = (void *)(mac_bi_data.rombase + 0xa);
+
+		local_irq_disable();
+		rom_reset();
 	}
 
 	/* should never get here */
-- 
2.39.3


