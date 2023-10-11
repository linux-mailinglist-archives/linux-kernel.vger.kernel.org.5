Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A67C4D26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjJKIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJKIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:30:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBA9D;
        Wed, 11 Oct 2023 01:30:12 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:30:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697013011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9fhabdFY85OZWqZt36fI3rnF5gFBzXAgjbPAo/WTLM=;
        b=jzp0imOYfNfeWxvYhTtCD56JkT5w2zQHjJ7Ww8WGaca1lHqztGLQuO4xUHUXrcOkJmC302
        TBHAh4YY/SXRMOhpTT9tOfilvN+yRFXhitZSpOdMjNdxf+OBuG8IxqEPmwWVAF5Y+Tu8/h
        KM9jgkMFHkwAKGFJgMl03QvzAuZ64ix1mTXFYIlkwpCQwK6TBam1HMewFBT0ta3vF0PYUL
        6xp5ijFBXiOaNASvCMdoNTV6csWi4bFW3XBPLWXTdpgYCw37kmhrPkgS3Cf845rFoAb1l9
        aYLXOUJlvgIT+5fqLZBf5cyvhoFRTD5nFHBHAzVBdL1/wPhF3JCm6ZUiUYLwrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697013011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9fhabdFY85OZWqZt36fI3rnF5gFBzXAgjbPAo/WTLM=;
        b=udflPfjgJDtp+fREDqRUFLcQuqoQVXeOMDemMQSA12pM4Mq4MuJQj+B4Xyqhz30cKHZYbH
        Uk5kVsfVxF7OHiBg==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev: Drop unneeded #include
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010145220.3960055-3-alexander.shishkin@linux.intel.com>
References: <20231010145220.3960055-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169701301076.3135.13127013166356652434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d6f274b7c8ac52abc81e898b62c3ff63fbeb11b8
Gitweb:        https://git.kernel.org/tip/d6f274b7c8ac52abc81e898b62c3ff63fbeb11b8
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 10 Oct 2023 17:52:20 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Oct 2023 10:15:47 +02:00

x86/sev: Drop unneeded #include

Commit:

  20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")

... forgot to remove the include of virtio_config.h from mem_encrypt_amd.c
when it moved the related code to mem_encrypt.c (from where this include
subsequently got removed by a later commit).

Remove it now.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20231010145220.3960055-3-alexander.shishkin@linux.intel.com
---
 arch/x86/mm/mem_encrypt_amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 62dde75..a68f2dd 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
-#include <linux/virtio_config.h>
 #include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
