Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF6776A45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjHIUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2E0212A;
        Wed,  9 Aug 2023 13:36:12 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bW3NHrDPoh7Kc55RkJ6E3LBkWa+JClTOFAYaFxZI9/A=;
        b=Bm6S444TrzZwviK/yaACRr4SKcI1Qwc8AHy8Nwi0D+r8bR6yzkC1/1FjpE8hbflTzrYxJ4
        FqH2fuyuOT7/459QZKuQwK+a3DZnkZlvaP7qMDcYrhGC5e0XFa4kY4QV6hA4Yw6OP5Q3Tw
        gJe1p8ZeucQwcJJogqa7MqABxffLBpPhmoH8NDFCjTzTDDc6ziHozShWYnK4obgOuxG+fJ
        aiM2wAUZivSkcE16qKuqLXrYIEYkWHk82wbw82zV5a2B2fywVbUs6VUiyRuW4vm1zY+DiG
        /oqBdlIZ7kDNf4+s/6IQ6v2qViWGtqLZWpr6VQx+m7ZXEkG2r0crxz543Kw+BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bW3NHrDPoh7Kc55RkJ6E3LBkWa+JClTOFAYaFxZI9/A=;
        b=JAcqbBBByvtgLg6dIuL0mRwb6rvTDbLawGBF7KnMSDjbzUReK6JD7P9jnSVPIGGkw8f1us
        +Bs2416kMkwCtnDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove pointless NULL initializations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337045.27769.15651305500960106706.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1fddf1dcc58406e72551ca6aa6f0a81c438abb07
Gitweb:        https://git.kernel.org/tip/1fddf1dcc58406e72551ca6aa6f0a81c438abb07
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:13 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:32 -07:00

x86/apic: Remove pointless NULL initializations

Wasted space for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/apic_flat_64.c  | 2 --
 arch/x86/kernel/apic/apic_noop.c     | 2 --
 arch/x86/kernel/apic/apic_numachip.c | 4 ----
 arch/x86/kernel/apic/probe_32.c      | 1 -
 arch/x86/kernel/apic/x2apic_phys.c   | 2 --
 arch/x86/kernel/apic/x2apic_uv_x.c   | 2 --
 6 files changed, 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 1e268a0..f65419d 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -87,9 +87,7 @@ static struct apic apic_flat __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
 	.init_apic_ldr			= default_init_apic_ldr,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index bd6a95c..28b693b 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -65,7 +65,6 @@ static void noop_apic_write(u32 reg, u32 val)
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 	.probe				= noop_probe,
-	.acpi_madt_oem_check		= NULL,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
@@ -80,7 +79,6 @@ struct apic apic_noop __ro_after_init = {
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 39ebe1a..9df0187 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -227,8 +227,6 @@ static const struct apic apic_numachip1 __refconst = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
@@ -266,8 +264,6 @@ static const struct apic apic_numachip2 __refconst = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index d9f52f2..5facf42 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -48,7 +48,6 @@ static struct apic apic_default __ro_after_init = {
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index fcb96b9..47ee5c6 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -150,8 +150,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 26891ac..5692514 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -811,8 +811,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
