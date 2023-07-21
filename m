Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108A75C11A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGUIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGUIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:16:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002E2708
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:16:30 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6j7b6KppzBRRLF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:16:27 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689927387; x=1692519388; bh=3kX8ehbe2xlWt10B+oMBvKX9tRH
        gA1MMC1mFKxCLQTU=; b=nHEPFvxd7OmcH1hmcgYRFhsxwmOZqhybUJwqaW9pkHk
        iusQwS6bSgSJmQyzwx+xlGrz1MhrPvDeyg88n8V2ycuJaeCMUv35zIZcwp9TzTXU
        W3mWlhaLQ9c8nHLAVuSEjflPepKwysSdJl7ndl+HhhX1WVXL7PP6scf9EgHjMdN7
        Mo6V6gqcxT8Y1k6oTg7NStt0SXVdjO9bTOpqaCq/f5nPQRpcrylfOWbBH3ecNhIi
        lEs6HEt3hPV9rqMlpiYctqFVQs9iigeTYnEQYdY7dBPm0r4gzFr9nmjHp8I4BsSE
        Jx0U62sEcsu5J8By2f8ZhfaFpZNzf6/cWoL3HHk2JRQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2UQb01KlfqBp for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:16:27 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6j7b1wZczBJk55;
        Fri, 21 Jul 2023 16:16:27 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:16:27 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/acpi/boot: "foo * bar" should be "foo *bar"
In-Reply-To: <20230721081515.5836-1-xujianghui@cdjrlc.com>
References: <20230721081515.5836-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <687638423c7d6f729c26b6dceca4520e@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/acpi/boot.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a6866c..457f1f6622d0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -254,7 +254,7 @@ acpi_parse_x2apic(union acpi_subtable_headers 
*header, const unsigned long end)
  }

  static int __init
-acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned 
long end)
+acpi_parse_lapic(union acpi_subtable_headers *header, const unsigned 
long end)
  {
  	struct acpi_madt_local_apic *processor = NULL;

@@ -307,7 +307,7 @@ acpi_parse_sapic(union acpi_subtable_headers 
*header, const unsigned long end)
  }

  static int __init
-acpi_parse_lapic_addr_ovr(union acpi_subtable_headers * header,
+acpi_parse_lapic_addr_ovr(union acpi_subtable_headers *header,
  			  const unsigned long end)
  {
  	struct acpi_madt_local_apic_override *lapic_addr_ovr = NULL;
@@ -344,7 +344,7 @@ acpi_parse_x2apic_nmi(union acpi_subtable_headers 
*header,
  }

  static int __init
-acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const 
unsigned long end)
+acpi_parse_lapic_nmi(union acpi_subtable_headers *header, const 
unsigned long end)
  {
  	struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;

@@ -517,7 +517,7 @@ static int __init mp_register_ioapic_irq(u8 bus_irq, 
u8 polarity,
  }

  static int __init
-acpi_parse_ioapic(union acpi_subtable_headers * header, const unsigned 
long end)
+acpi_parse_ioapic(union acpi_subtable_headers *header, const unsigned 
long end)
  {
  	struct acpi_madt_io_apic *ioapic = NULL;
  	struct ioapic_domain_cfg cfg = {
@@ -576,7 +576,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, 
u16 polarity, u16 trigger,
  }

  static int __init
-acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
+acpi_parse_int_src_ovr(union acpi_subtable_headers *header,
  		       const unsigned long end)
  {
  	struct acpi_madt_interrupt_override *intsrc = NULL;
@@ -618,7 +618,7 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * 
header,
  }

  static int __init
-acpi_parse_nmi_src(union acpi_subtable_headers * header, const unsigned 
long end)
+acpi_parse_nmi_src(union acpi_subtable_headers *header, const unsigned 
long end)
  {
  	struct acpi_madt_nmi_source *nmi_src = NULL;
