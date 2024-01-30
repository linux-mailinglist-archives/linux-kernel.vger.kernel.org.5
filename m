Return-Path: <linux-kernel+bounces-45120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949F1842BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21BB28A4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C5B78B54;
	Tue, 30 Jan 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiQrgwd1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9cL7vkI3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F178B4B;
	Tue, 30 Jan 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639795; cv=none; b=Op74YA8lonpHSKm1KSil+cuHl5ChpLIsH2qXYzTIXnAGAOdpiB2PrjyclLLSiuM85UUUBF26MxPyDkbm+NkyMKYTHrKNIUVli4QYH/uX5fAgVlbtPxYjbhu/YWVj0aJSw96Vq7nB7WKSfSJ8DAFHYAnrr0lnML/6OYswizbFzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639795; c=relaxed/simple;
	bh=cA5Zn5/WMws58Qtz6JIub0Jb5+CjAaFY21Nf3/33IwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RJUtalMng1FXV9QFqHdXYRf2H7InWI5qtVadpEXB4lNLcT3X08iuzQgsrAC3X46h/CKnp7lGGJshHY31gt3/VwplkhRYJqmrhdm1X8EfeCsKPYTAVuwk7XhBr8cdP8xfp/DMTr7gb2hPH8UDb1ZHE9vqXT/oytbiwII4aBNeaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiQrgwd1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9cL7vkI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 18:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706639792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXC4Tu4W/PI2o1wNKexythDSeKUb+mJhHwcTcpw7PM=;
	b=RiQrgwd10ALmpLA4fIu+swhm8HGByb5Ye4aOMpNbTcIaVvJEEhNKT+o4JpAGSAdM/GcAYJ
	IAr3Bus93v60R0Puk7XClSDV3qll/UOEafxkNCIwp2Lka6R7mYLYWO7R4ANUqmNcU5JW47
	G5fBQqUN5v2pdRYgiDxLgxlrMcIlzNhXgb1IraJZZHxGexBK4ZKyAF9PZm7ddzTCIIs12q
	T6kpAdKRvlTej9XfU6f9w7RmgjIUPdFx/NLoImUCPLoxUXl31Q1iBTIo/bYo3ac+csNIP0
	+M6iWHmiaulng7Uxb0tyEzAy9w7bnFxVswYTez5oOo1XKUkN4+wIk2nhQ/FyUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706639792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXC4Tu4W/PI2o1wNKexythDSeKUb+mJhHwcTcpw7PM=;
	b=9cL7vkI30um2/OJ+IjRdYfmnr9Fru6hMxY2iSi8es2T5Ynq+KnOSKKtDYt+KgxfXMZufz1
	JizSW+6nshmALEAA==
From: "tip-bot2 for Thomas Zimmermann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/efi: Implement arch_ima_efi_boot_mode() in source file
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240112095000.8952-4-tzimmermann@suse.de>
References: <20240112095000.8952-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663979187.398.3170118854005669182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     785ddc8b6bebd958a5b6fb7b6b4aa6584c2f0cb2
Gitweb:        https://git.kernel.org/tip/785ddc8b6bebd958a5b6fb7b6b4aa6584c2f0cb2
Author:        Thomas Zimmermann <tzimmermann@suse.de>
AuthorDate:    Fri, 12 Jan 2024 10:44:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 15:17:17 +01:00

x86/efi: Implement arch_ima_efi_boot_mode() in source file

The x86 implementation of arch_ima_efi_boot_mode() uses the global
boot_param state. Move it into a source file to clean up the header.
Avoid potential rebuilds of unrelated source files if boot_params
changes.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240112095000.8952-4-tzimmermann@suse.de
---
 arch/x86/include/asm/efi.h  | 5 +++--
 arch/x86/platform/efi/efi.c | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index a5d7a83..1dc600f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -409,8 +409,9 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-#define arch_ima_efi_boot_mode	\
-	({ extern struct boot_params boot_params; boot_params.secure_boot; })
+extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
+
+#define arch_ima_efi_boot_mode	__x86_ima_efi_boot_mode()
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_get_runtime_map_size(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e9f99c5..f090ec9 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -950,3 +950,8 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 	}
 	return attr->mode;
 }
+
+enum efi_secureboot_mode __x86_ima_efi_boot_mode(void)
+{
+	return boot_params.secure_boot;
+}

