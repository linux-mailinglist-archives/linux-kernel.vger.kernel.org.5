Return-Path: <linux-kernel+bounces-91349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04424870FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1671C222E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAB7FBB9;
	Mon,  4 Mar 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBsCel6Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vf5y0E5N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8207C086;
	Mon,  4 Mar 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590146; cv=none; b=mbjAGXR4CtevlRv0xg5i6oi08C5nT+rwUr0HF1gozQ3yQ1+/JUZe4nwQ9tYr/J192kfvsOmxP0PxBdyVfkDMIcj77Eck3MDBXLLqFufEw+8gJhKx6ziclCNbSQW9nAA0Og6jmw0Ysfl3YQhzRqphBPuw0enWniOrt4vnJUdcLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590146; c=relaxed/simple;
	bh=47xWTnLRqahBzjZQF5TOdnDWtBrVJUCGzxcg+cC2IZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=etkiZfo5DEOaXnStpaIucpTYodGFlZgzp6RAaKxgdxPQ+KxKBWmHBloovVlS4KYDlHHQ0OZTOVVxKYg87XGlDcRxNPiLChW1K8WdACcBjDcuSYkFvU0y6WRV6/3WcQC1O+jYPuv46PT2A/qVNAT67Ol+zr2MNV8AA2hTUyR0QhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBsCel6Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vf5y0E5N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 22:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709590142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEcJlGiIaDa1Ol2wtmmAtLXdnRpFU6JHbDWQ947LyTg=;
	b=VBsCel6YlY43lT9QbH015kUG8u4nAzxeyAXhKTj4RZ1OjD1PFB9DiaXXaKfX2inIIuY2XC
	GghjNXzvvngrJYpz6B/pNL8OaTn59T0F/03lZSp6R/JB2+pzsIM4X2N5rBer9vOPJIPVfr
	OgUfI0ROG98yEc/boeFQiVRMLcRXLedn3MDnlynhIx3SG58ZHoaM5iyplIgvquCx1Eev70
	xMYnLvxMW7ZuiTs9cFnOaHfsoK8uiIgIWBq4RfnhBt570zrl831DqTWMf+dEEpSX0Gicwq
	USdaiMgwRUACMW5eyVUR/krYJyAn23jp5nySaQw94P1ZIJvQYxaCp8kb5rpH1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709590142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEcJlGiIaDa1Ol2wtmmAtLXdnRpFU6JHbDWQ947LyTg=;
	b=vf5y0E5NuQo9MeemU+eXuWpOi+B7Ar56xPRm7QRcA8jZQNSnxAmoqoYb08XMfFKfzh16Rf
	uxe30MBtiseJ8jCg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] efi/libstub: Add generic support for parsing mem_encrypt=
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240227151907.387873-16-ardb+git@google.com>
References: <20240227151907.387873-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170959014157.398.1604703266552857019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7205f06e847422b66c1506eee01b9998ffc75d76
Gitweb:        https://git.kernel.org/tip/7205f06e847422b66c1506eee01b9998ffc75d76
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 27 Feb 2024 16:19:13 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 18:12:24 +01:00

efi/libstub: Add generic support for parsing mem_encrypt=

Parse the mem_encrypt= command line parameter from the EFI stub if
CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
boot code by the arch code in the stub.

This avoids the need for the core kernel to do any string parsing very
early in the boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-16-ardb+git@google.com
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa3062..3dc2f9a 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -24,6 +24,8 @@ static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+int efi_mem_encrypt;
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
@@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
+		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			   !strcmp(param, "mem_encrypt") && val) {
+			if (parse_option_str(val, "on"))
+				efi_mem_encrypt = 1;
+			else if (parse_option_str(val, "off"))
+				efi_mem_encrypt = -1;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c04b82e..fc18fd6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -37,8 +37,8 @@ extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
+extern int efi_mem_encrypt;
 extern bool efi_novamap;
-
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;

