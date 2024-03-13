Return-Path: <linux-kernel+bounces-101061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EDA87A1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C29282A07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1161D26D;
	Wed, 13 Mar 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTZP6Cg5"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F75C13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298529; cv=none; b=I3/1eLkbcgmQu1ysnUsIgoGeX2/FV70kJSn8DxPgZDw+BUfUeIIq5gdbyvYUNb1CxDPH+6YBX5VrGio/3kYACiah5GE/Zm0Xq8Hwn2Rh/wF2R+aTSkvNnGUOXI7QjFhEXmQPCMPdUQ2gdPgobub0FPrrv1/Y8lX4Jm2faClP4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298529; c=relaxed/simple;
	bh=kPI06sB6xWjY4Nh46oo5Dut+IQk6CE9LUEOxQjhntok=;
	h=To:Cc:Message-Id:From:Subject:Date; b=CMewTEkvj58zaZTSpkAQhBmuJKamFB00p7ttYUtTDzODIojh0TByl1UYOIowZD6avvt3eUNlTMlOE4HGPvIy4WdpMUbLiv+9wPMjxBtjlolr3UfDeYqvDH3EwlSf/v8D6bZaMKLGHH5zwETVl3BLtZkIMIvPj/dujz19vJ6jSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTZP6Cg5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8E2E9114010C;
	Tue, 12 Mar 2024 22:55:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Mar 2024 22:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1710298525; x=1710384925; bh=Wd0ecGwUYOXoc
	0YecPtDjx0iAVO+pH45Y6w0F5eyEtA=; b=VTZP6Cg5A5Fv6v6Ad/FOdNQICO3CO
	bMuMGo11Sfg8wrT9lb57XKaqeb/RwMGzP5RXOUezS3IaSS/tBrIK7l/E7Hfe6rxF
	FKa9A8N/7faJUKcJz4XA/G1GogVkCLzO7e7sE/UfopmyA1ZbKNT30Kw4RXl6EZnw
	czNggLpwZ2ZRNoNLwQYnEacqbxsqIQczhfwdcFrrKeWAz5ToIxKj7uQ628hkBn2k
	O5t7etwfkVtCJi4mezEE6GMb4i17dan8kVOmcmlwjMHb5YyGjoVnsj2deJr8bvru
	DRFkoOHFNO0ac9pj2OIWhMYkRUHtp0eUJ4KX+EkJ8ygN2+BaZFXT9YcSQ==
X-ME-Sender: <xms:nBXxZRKMKlkSiV-liTa958xS0K_kf6Sv0vkDUwZBF637MCndDBE8TQ>
    <xme:nBXxZdLrgzV7TKccaNGfXgGoBextE7k_DFFJ2C6rYzVHPiX1Q1NvhNOksf-8tvLtT
    EirKA0UPsoJoKpZVCA>
X-ME-Received: <xmr:nBXxZZtsAsgHXEq8ZyNzt-pRgVHotrxXWqyDd1vVclKM65dGx1qsdEIjIq9GUcHEGLEEcodam6c6GbaZ33FYuMtm4uBZSbZFEDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvvefkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheffgfegfeevgeevtdeiffefveeutdeghfeuheeiteffjeefgfegveefuedvudelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:nBXxZSbsYiReli2o7BlESE2qf17lZaPPdllArD5iZr5iSvCLRlOKgw>
    <xmx:nBXxZYZ0lEFTnwq9UE9IlxMQTNg83vKt-TTkuWhomydhApK4p9tZGA>
    <xmx:nBXxZWCdVG34u3OxETgdukIS_Qv50Z1dpiYsiOigxmB8KHoEJ6jf1Q>
    <xmx:nBXxZWbTiFm_JxuwOxZ2go_s7ZSKerelbcVvcBlMIWs0u0hv7x8Nfg>
    <xmx:nRXxZfUon8JRfL8JBJGEY_iZvhW3qa-VDpt9skQ31IwVHuIyAd8Ufg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 22:55:22 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <419fcc09d0e563b425c419053d02236b044d86b0.1710298421.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] macintosh/via-macii: Fix "BUG: sleeping function called from
 invalid context"
Date: Wed, 13 Mar 2024 13:53:41 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The via-macii ADB driver calls request_irq() after disabling hard
interrupts. But disabling interrupts isn't necessary here because the
VIA shift register interrupt was masked during VIA1 initialization.

Cc: Joshua Thompson <funaho@jurai.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>

---

This old bug was found while testing Geert's CONFIG_PREEMPT=y patch.

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
CPU: 0 PID: 1 Comm: swapper Not tainted 6.8.0-rc7-mac-00232-g88f8d9d514ed #5
Stack from 0084be34:
        0084be34 0054af2c 0054af2c 00000001 00000dc0 0084be54 004980b6 0054af2c
        0084be68 0003f920 00000000 008012d0 00598ff0 0084be7c 0003f95e 00543a0d
        00000132 00000000 0084beb0 000f44ee 00543a0d 00000132 00000000 0000000a
        002ef380 002ef380 00038166 004897c0 005a95a0 00598ff0 00000000 0084bee0
        000567d8 008012d0 00000dc0 00000034 00002000 00000000 0063d1e8 00002092
        005a95a0 004c9706 00649b30 0084bf08 002ef962 0000000a 002ef380 00000000
Call Trace: [<004980b6>] dump_stack+0x10/0x16
 [<0003f920>] __might_resched+0x138/0x150
 [<0003f95e>] __might_sleep+0x26/0x72
 [<000f44ee>] kmalloc_trace+0x94/0x1ea
 [<002ef380>] macii_interrupt+0x0/0x576
 [<002ef380>] macii_interrupt+0x0/0x576
 [<00038166>] parse_args+0x0/0x3a6
 [<004897c0>] strcpy+0x0/0x1e
 [<000567d8>] request_threaded_irq+0xa4/0x19e
 [<00002000>] _start+0x0/0x8
 [<00002092>] do_one_initcall+0x0/0x22a
 [<002ef962>] macii_init+0x5a/0x94
 [<002ef380>] macii_interrupt+0x0/0x576
 [<002ef380>] macii_interrupt+0x0/0x576
 [<00635bee>] adb_init+0x52/0x114
 [<00635b9c>] adb_init+0x0/0x114
 [<000020c6>] do_one_initcall+0x34/0x22a
 [<00002092>] do_one_initcall+0x0/0x22a
 [<00038166>] parse_args+0x0/0x3a6
 [<004897c0>] strcpy+0x0/0x1e
 [<00060006>] rcu_exp_wait_wake+0x618/0x92e
 [<00621ace>] kernel_init_freeable+0x156/0x1ae
 [<00621ade>] kernel_init_freeable+0x166/0x1ae
 [<00635b9c>] adb_init+0x0/0x114
 [<00498e4a>] kernel_init+0x0/0xfa
 [<00498e62>] kernel_init+0x18/0xfa
 [<00498e4a>] kernel_init+0x0/0xfa
 [<00002700>] ret_from_kernel_thread+0xc/0x14
---
 drivers/macintosh/via-macii.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index db9270da5b8e..b6ddf1d47cb4 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -140,24 +140,19 @@ static int macii_probe(void)
 /* Initialize the driver */
 static int macii_init(void)
 {
-	unsigned long flags;
 	int err;
 
-	local_irq_save(flags);
-
 	err = macii_init_via();
 	if (err)
-		goto out;
+		return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
 	if (err)
-		goto out;
+		return err;
 
 	macii_state = idle;
-out:
-	local_irq_restore(flags);
-	return err;
+	return 0;
 }
 
 /* initialize the hardware */
-- 
2.39.3


