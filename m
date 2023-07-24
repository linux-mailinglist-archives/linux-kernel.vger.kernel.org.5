Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77F75F8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGXNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGXNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130035B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:25 -0700 (PDT)
Message-ID: <20230724132047.263219045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4kZ3PvNOs70jkSxz3FTMqFuUfjlVkf/AyOBE0F2Qscg=;
        b=NZO0pDmeItSEfgxwuwp0KVUWXbQm/C5jL4HHX1hygAq395GSBukbr+yKkv/LSKT6wbc/EG
        GtzuD0VP08WaYPYEgZj13acAiixkRVqmSUUmnm09SmMJI4wFMtifI4seWyo6xhq5JKTGAl
        7athhe2sfp6VN/iyeCB68r4BCWbBg6tW1zqVG3ZATvlf6Vknfzn+j6gCHEwI1tHSX06TEs
        AwEpY1ZEBvPTfWTE19Kf8LdHz+8Ztd8ObWpb/714gdtCyaGBWhxeRK7QQGdMZOZzi1KBbY
        GDzEShikvc1u41b+GLDlnxi8flu9IeEiCJt/vQJWGHoUnpY/qwHKGgKA4nwM8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4kZ3PvNOs70jkSxz3FTMqFuUfjlVkf/AyOBE0F2Qscg=;
        b=QIz9cMe4NLEoUhBoZfOjEYQcRNFBv/7AZdrMjAuOlldAcMtMN5eDWPxfnQfGlWuqDFue6U
        8KzK/NUvJBPoezDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 45/58] x86/apic: Remove pointless NULL initializations
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:02 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wasted space for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic_flat_64.c  |    2 --
 arch/x86/kernel/apic/apic_noop.c     |    2 --
 arch/x86/kernel/apic/apic_numachip.c |    4 ----
 arch/x86/kernel/apic/probe_32.c      |    1 -
 arch/x86/kernel/apic/x2apic_phys.c   |    2 --
 arch/x86/kernel/apic/x2apic_uv_x.c   |    2 --
 6 files changed, 13 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -87,9 +87,7 @@ static struct apic apic_flat __ro_after_
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
 	.init_apic_ldr			= default_init_apic_ldr,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -65,7 +65,6 @@ static void noop_apic_write(u32 reg, u32
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 	.probe				= noop_probe,
-	.acpi_madt_oem_check		= NULL,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
@@ -80,7 +79,6 @@ struct apic apic_noop __ro_after_init =
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -227,8 +227,6 @@ static const struct apic apic_numachip1
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
@@ -266,8 +264,6 @@ static const struct apic apic_numachip2
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -48,7 +48,6 @@ static struct apic apic_default __ro_aft
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -150,8 +150,6 @@ static struct apic apic_x2apic_phys __ro
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -811,8 +811,6 @@ static struct apic apic_x2apic_uv_x __ro
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 

