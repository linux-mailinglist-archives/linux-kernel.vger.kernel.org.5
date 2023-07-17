Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9B7570A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGQXnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGQXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:40:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78568170A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:40:35 -0700 (PDT)
Message-ID: <20230717223225.754957545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AWaEZw8abvCPdN4y6ge3RbIG2SvdzHbMvIezw0K7Xt4=;
        b=xGjM4LiVIbDvVJpkJPrQjEaRdgsQZ5akQT26sx1478B5xJtClRWnFpiaKg73W7rzbSZpmu
        9cb7VLiK5CNVLJ5SHYsYbijnVeRnYRWCVGZPuPNVABGDN6I316EFSYjcFOKx6ciTTNfR3n
        a4fJw5/BrbUnbDa1uZqrO3gk2aue9kBShZmUFi4KcEScPYmBEcz39LIzG4h+18Tmw0J+AV
        plvIkhV8AXnsb6I7C/fh75Q1t84rIyI0vtbIOhwrFOs82rOUbvUDPvhEHNC/Ngmc8B3SqC
        A8zsj2dI2QBlNMn4UuoXUR4vFt2nDiZeJj3AIF9IOED0DEFurHtRBNJcH2cCEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AWaEZw8abvCPdN4y6ge3RbIG2SvdzHbMvIezw0K7Xt4=;
        b=h2M38jF60O41a5q3PzJBQp7a2b8q3FvZ1CwUp7sKuTEdAmME2dg2o+DJ2A9C7h8M3Z6mqd
        JhNoR9No5x4mSIAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 45/58] x86/apic: Remove pointless NULL initializations
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:44 +0200 (CEST)
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
 

