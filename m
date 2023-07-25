Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F6762063
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGYRmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGYRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:42:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517F12E;
        Tue, 25 Jul 2023 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uVUZAVUjxhvUeajjvgsfqI9MfVnAtjnuBumn+qjqDs0=; b=E58am1Qf7XH3NAQqeIk/3oNF2u
        e5PXrrfanUAWTC1MnHEHAM7e04VbWfjuWyx0PUPxDDYY8QVcQMZCQM23SwYuwrqzNQUuiQ7LenO7J
        yawdOwSTz++ag4x71jSbGvL1rWyVtekjc5c/0P/++9WxIwn5U3pw2R4B1ZIXXuVIaiGwL+Mj2HOUa
        JnNTkE62Km7BG50CafOssw01ePwN+E4E7hfXCFU6LOQR1D7mEswtcVxaGvahavcyYCKQdSq/+zeIq
        sAyiqOwfoIDnfnhTRBw7GlBzEKwtEDJPAVxnr74GRsK8lrDsapA8koy8k/UxGn+wlpFKZ1oIUUm1D
        PR4U4nmg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOM3d-008BER-0s;
        Tue, 25 Jul 2023 17:42:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Docs: kernel-parameters: sort the LEGEND list
Date:   Tue, 25 Jul 2023 10:42:47 -0700
Message-ID: <20230725174247.32393-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the list of kernel build options and hardware support options.
Add a comment that the list should be kept sorted instead of having
new options inserted willy nilly.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.rst |   23 +++++++-------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff -- a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -89,10 +89,11 @@ reveal their parameters in /sys/module/$
 parameters may be changed at runtime by the command
 ``echo -n ${value} > /sys/module/${modulename}/parameters/${parm}``.
 
-The parameters listed below are only valid if certain kernel build options were
-enabled and if respective hardware is present. The text in square brackets at
-the beginning of each description states the restrictions within which a
-parameter is applicable::
+The parameters listed below are only valid if certain kernel build options
+were enabled and if respective hardware is present. This list should be kept
+in alphabetical order. The text in square brackets at the beginning
+of each description states the restrictions within which a parameter
+is applicable::
 
 	ACPI	ACPI support is enabled.
 	AGP	AGP (Accelerated Graphics Port) is enabled.
@@ -127,9 +128,9 @@ parameter is applicable::
 	KGDB	Kernel debugger support is enabled.
 	KVM	Kernel Virtual Machine support is enabled.
 	LIBATA  Libata driver is enabled
-	LP	Printer support is enabled.
 	LOONGARCH LoongArch architecture is enabled.
 	LOOP	Loopback device support is enabled.
+	LP	Printer support is enabled.
 	M68k	M68k architecture is enabled.
 			These options have more detailed description inside of
 			Documentation/arch/m68k/kernel-options.rst.
@@ -139,10 +140,9 @@ parameter is applicable::
 	MSI	Message Signaled Interrupts (PCI).
 	MTD	MTD (Memory Technology Device) support is enabled.
 	NET	Appropriate network support is enabled.
-	NUMA	NUMA support is enabled.
 	NFS	Appropriate NFS support is enabled.
+	NUMA	NUMA support is enabled.
 	OF	Devicetree is enabled.
-	PV_OPS	A paravirtualized kernel is enabled.
 	PARISC	The PA-RISC architecture is enabled.
 	PCI	PCI bus support is enabled.
 	PCIE	PCI Express support is enabled.
@@ -151,9 +151,10 @@ parameter is applicable::
 	PPC	PowerPC architecture is enabled.
 	PPT	Parallel port support is enabled.
 	PS2	Appropriate PS/2 support is enabled.
+	PV_OPS	A paravirtualized kernel is enabled.
 	RAM	RAM disk support is enabled.
-	RISCV	RISCV architecture is enabled.
 	RDT	Intel Resource Director Technology.
+	RISCV	RISCV architecture is enabled.
 	S390	S390 architecture is enabled.
 	SCSI	Appropriate SCSI support is enabled.
 			A lot of drivers have their options described inside
@@ -164,15 +165,15 @@ parameter is applicable::
 	SH	SuperH architecture is enabled.
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
-	SWSUSP	Software suspend (hibernation) is enabled.
 	SUSPEND	System suspend states are enabled.
+	SWSUSP	Software suspend (hibernation) is enabled.
 	TPM	TPM drivers are enabled.
 	UMS	USB Mass Storage support is enabled.
 	USB	USB support is enabled.
 	USBHID	USB Human Interface Device support is enabled.
 	V4L	Video For Linux support is enabled.
-	VMMIO   Driver for memory mapped virtio devices is enabled.
 	VGA	The VGA console has been enabled.
+	VMMIO   Driver for memory mapped virtio devices is enabled.
 	VT	Virtual terminal support is enabled.
 	WDT	Watchdog support is enabled.
 	X86-32	X86-32, aka i386 architecture is enabled.
@@ -186,9 +187,9 @@ parameter is applicable::
 
 In addition, the following text indicates that the option::
 
+	BOOT	Is a boot loader parameter.
 	BUGS=	Relates to possible processor bugs on the said processor.
 	KNL	Is a kernel start-up parameter.
-	BOOT	Is a boot loader parameter.
 
 Parameters denoted with BOOT are actually interpreted by the boot
 loader, and have no meaning to the kernel directly.
