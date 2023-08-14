Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F077B4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjHNI4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjHNIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF010F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:35 -0700 (PDT)
Message-ID: <20230814085114.301935500@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qdYGHf8yT/gB4O6cmEBR3VKAOVLhFCZDX/t11ieb+ro=;
        b=10Ht+OO+Uoa0b5Xrjvc8/M+k48npCX71PHilfCqJNwuyLLNlN743NNnes21us/RfaY0iTK
        MzDPvwZVjQUWn8BWpDeH/6Zek9rIriH/opgdPUiWDzFqliWw/RjQ897eQFQsPSA5fuCajN
        6K6QrxHUzkDT6p1VwQjjVsIyh8HYvw2642ZFTKUPX9VbzPF8T7ckVlIpg5Ig8/hX5K6TNH
        CwjpV/A16Fz8wvBSSvk2kYfwyNjHv14/cDA6EDeIQFu7Y6rXLwDjZowrRJ6pu6fIY9qbPo
        eZbZsWP5e1PMzCyoiAMefcjl3XXWi8SUHMXAVSfpMp5VgEXZfXXa8PKi5JkOTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qdYGHf8yT/gB4O6cmEBR3VKAOVLhFCZDX/t11ieb+ro=;
        b=U8D8LVuZac0lWRhZ8P0i2SUgJLNsWpXHfFP2OYNIchaUFMNQ6uv9qNy4h8QRtt1Lj04D7h
        5JNprjJoaT05dnDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 38/41] x86/cpu: Remove x86_coreid_bits
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:33 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/include/asm/processor.h |    2 --
 arch/x86/kernel/cpu/common.c     |    1 -
 2 files changed, 3 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -119,8 +119,6 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
-	/* CPUID returned core id bits: */
-	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1712,7 +1712,6 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
-	c->x86_coreid_bits = 0;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;



