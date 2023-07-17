Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8F757073
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGQXUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjGQXUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:20:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D686134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:20:00 -0700 (PDT)
Message-ID: <20230717223226.297124390@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOCeYzZlZQBijmmlwD90S/EyiYlmy0xrZba4W3Pw3yw=;
        b=gaLKj7OKk74d7dKsCAAq7iQL33bF5KOQHpAirffn2nbDIIuBzBtnshkDVGTF32x1xIVXfT
        LX3O50t4S2wv9IHgf3zrr5gdye+KbDjqzKwAuwiT0zbljANQHJyiJmNm7Qr1V8hP31xQWa
        bZbK89/vR5cpBemdihkFd0b+8ZAZ1qKKdgsbMR+/eLUdbZBb5t87k8C6sNYIcnutq3UACy
        T8YUZMvV7eihKLODdI2+oRaEXmt7rLdAzXfmXxDnAdScRZaIxI4thHsPEY6xJtZ2Qrt8IG
        yOOK9KXY4jTB02SimLzFHp8GNC45fVqza5ArahhrQjrcAMkODa0OeJAYNCIAxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOCeYzZlZQBijmmlwD90S/EyiYlmy0xrZba4W3Pw3yw=;
        b=/0Z+SKoUfHQfzCGrNIiYa+mNxhfgHweJlWYXN3rENFQkGK2JhDXuQhwiFm+3p08Oy+yRgU
        R2Tg+Nr2LiXSuyDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 54/58] x86/xen/apic: Mark apic __ro_after_init
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:58 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing can change it post init.

While at it mop up the whitespace damage which causes eyebleed due to an
editor which is highlighting it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/apic.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -123,9 +123,9 @@ static int xen_cpu_present_to_apicid(int
 		return BAD_APICID;
 }
 
-static struct apic xen_pv_apic = {
-	.name 				= "Xen PV",
-	.probe 				= xen_apic_probe_pv,
+static struct apic xen_pv_apic __ro_after_init = {
+	.name				= "Xen PV",
+	.probe				= xen_apic_probe_pv,
 	.acpi_madt_oem_check		= xen_madt_oem_check,
 
 	/* .delivery_mode and .dest_mode_logical not used by XENPV */
@@ -138,24 +138,24 @@ static struct apic xen_pv_apic = {
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.max_apic_id			= UINT_MAX,
-	.get_apic_id 			= xen_get_apic_id,
-	.set_apic_id 			= xen_set_apic_id, /* Can be NULL on 32-bit. */
+	.get_apic_id			= xen_get_apic_id,
+	.set_apic_id			= xen_set_apic_id, /* Can be NULL on 32-bit. */
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
 #ifdef CONFIG_SMP
-	.send_IPI_mask 			= xen_send_IPI_mask,
-	.send_IPI_mask_allbutself 	= xen_send_IPI_mask_allbutself,
-	.send_IPI_allbutself 		= xen_send_IPI_allbutself,
-	.send_IPI_all 			= xen_send_IPI_all,
-	.send_IPI_self 			= xen_send_IPI_self,
+	.send_IPI_mask			= xen_send_IPI_mask,
+	.send_IPI_mask_allbutself	= xen_send_IPI_mask_allbutself,
+	.send_IPI_allbutself		= xen_send_IPI_allbutself,
+	.send_IPI_all			= xen_send_IPI_all,
+	.send_IPI_self			= xen_send_IPI_self,
 #endif
 	.read				= xen_apic_read,
 	.write				= xen_apic_write,
 	.eoi				= xen_apic_eoi,
 
-	.icr_read 			= xen_apic_icr_read,
-	.icr_write 			= xen_apic_icr_write,
+	.icr_read			= xen_apic_icr_read,
+	.icr_write			= xen_apic_icr_write,
 };
 
 static void __init xen_apic_check(void)

