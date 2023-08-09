Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA377656C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjHIQtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjHIQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5DD1BFE;
        Wed,  9 Aug 2023 09:49:31 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BZ/XvBizNSRZH3+jEVSRii67c4wak6kwB/D6ykNTW7o=;
        b=FUZmK1x8YJQNA/XhektLQ4CZUuUUqszLnB5SgP+FJC8cfo67U68Zzs91Dy73jrgrmK9qkv
        Qru+4Xp6yUIONMpbTiXTMmI3HARjHGpYuisPTG9PxoKmqo0w3n84/2TZDTOFkLJFT+caLg
        oDRL0MPe2qmDGUDrs/sSR4SzOoeUV5eAVc/aBmwiQfh4iuBHm384dclW0V5kn5y23fcYxX
        B5SqWaNTQZTPjEMnMaWzMx5HrcGdlGN0Xl4HhYgCYAp6xH2WUfaMFZaLf3Sp7p3SYETxHS
        FO7Q6SS+BvypQ1WOANgH8OMV/9QRJDY/vy69pX4e0B1QxHaCvc80hv1NldcA2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BZ/XvBizNSRZH3+jEVSRii67c4wak6kwB/D6ykNTW7o=;
        b=qlwBvR/O/hYAHpw5wXekVPqsUvFMPsrTIXe39SK0/HGn1TOb9I8kRcbwg2gjyWi3gXk9Oz
        bbs06LOXu069qOBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/uv: Get rid of wrapper callbacks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159976931.27769.9436204031161182367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     69297283bf5757dc41a42cc34c6a86006e2a2391
Gitweb:        https://git.kernel.org/tip/69297283bf5757dc41a42cc34c6a86006e2a2391
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic/uv: Get rid of wrapper callbacks

Why on earth makes a wrapper around some common function sense? Just to be
able to slap some vendor name on it...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f532c58..f0580a6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -783,11 +783,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static u32 apic_uv_calc_apicid(unsigned int cpu)
-{
-	return apic_default_calc_apicid(cpu);
-}
-
 static unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -838,7 +833,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
-	.calc_dest_apicid		= apic_uv_calc_apicid,
+	.calc_dest_apicid		= apic_default_calc_apicid,
 
 	.send_IPI			= uv_send_IPI_one,
 	.send_IPI_mask			= uv_send_IPI_mask,
