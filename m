Return-Path: <linux-kernel+bounces-162256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD08B58B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D44289877
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C31118B;
	Mon, 29 Apr 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nVjbE7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Op/UpWeU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00110A1B;
	Mon, 29 Apr 2024 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394149; cv=none; b=R9h5J7uo0VRzUu+qzbiTvxnDvRuwqhbn/gGjRQOmc3rQn/uvXUkecV6sUl5QZNPe91mFXNTQMDbJklgUTIX1yS+DVziwd2US9GXvttLbigoXPK6D3xz/KTLkiihMQcHCi60SPOIYtf5uirl4rpMci6aVyrXi1LqorMAv6vEdSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394149; c=relaxed/simple;
	bh=W++bsTCgt8Ak/qvxrG28b6/jckWokkT+K0XZBHvpYNY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tF1foAOO0aidj+Ub51wAz4kzllcxAIlfcR4vo/AOaQjdSEhO2dmu/GX+NHpuC7D5ZgTJkAr+q5vG/VI+64+SP/fgOv5cI2VvWCpbiENW6ngFhiPLLZeH4NMMYVdjOpwNREvFDbrZXpSFhdCDOv8M5fjz9HmWRcbg31or5oHHfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nVjbE7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Op/UpWeU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 12:35:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714394142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/HEyswWWxEYsgZH5K3MXvim58TtiuexS9UWmxw+jw=;
	b=1nVjbE7GDK5i6kstvTxUkjO1i1NkzrRTq2ygDvVGTl8MGfagyCfkCbEKh2fFw1zrY8xRQ5
	evphsVltqGWX38J3Adf6BTRkKpw3PqdgtYakI3RX/G+ESJniMdX2h2aUg7cboIwTJo5Daz
	+qKIGrvXEJB407M3inFCp2jiH00CqXa/IslUx4PnlVX/2MHgPeJLgF49HzRlg8/CTURrr1
	CSu/id18r/O2SqhfRIm/+Dg6rpxooAUZLH8Mz4HSXUjVHA7ufCiz6NnURZSZlTCkZXk+0x
	YK+AWSEdWLlWxJpWopx6Jrt7XArQFkjWuF8/21+7oVkK/rmYq+iS3t4LWrhJ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714394142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/HEyswWWxEYsgZH5K3MXvim58TtiuexS9UWmxw+jw=;
	b=Op/UpWeUKWL1SvQmd+tE+QaxNnWFtqdVphGs6Onss3RGuIHtoVJv+hgL9H2Hr/D+Kv8JCp
	gflEsaNOAapiqzBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/apic: Don't access the APIC when disabling X2APIC
Cc: Adrian Huang <ahuang12@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <875xw5t6r7.ffs@tglx>
References: <875xw5t6r7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171439414186.10875.17224463643261311678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1e1dd773644e9de88f54386f7147c1068375fc75
Gitweb:        https://git.kernel.org/tip/1e1dd773644e9de88f54386f7147c1068375fc75
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Apr 2024 00:30:36 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 12:08:07 +02:00

x86/apic: Don't access the APIC when disabling X2APIC

With 'iommu=off' on the kernel command line and X2APIC enabled by the BIOS
the code which disables the X2APIC triggers an unchecked MSR access error:

  RDMSR from 0x802 at rIP: 0xffffffff94079992 (native_apic_msr_read+0x12/0x50)

This is happens because default_acpi_madt_oem_check() selects an X2APIC
driver before the X2APIC is disabled.

When the X2APIC is disabled because interrupt remapping cannot be enabled
due to 'iommu=off' on the command line, x2apic_disable() invokes
apic_set_fixmap() which in turn tries to read the APIC ID. This triggers
the MSR warning because X2APIC is disabled, but the APIC driver is still
X2APIC based.

Prevent that by adding an argument to apic_set_fixmap() which makes the
APIC ID read out conditional and set it to false from the X2APIC disable
path. That's correct as the APIC ID has already been read out during early
discovery.

Fixes: d10a904435fa ("x86/apic: Consolidate boot_cpu_physical_apicid initialization sites")
Reported-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Adrian Huang <ahuang12@lenovo.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/875xw5t6r7.ffs@tglx
---
 arch/x86/kernel/apic/apic.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c342c4a..b229648 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1771,7 +1771,7 @@ void x2apic_setup(void)
 	__x2apic_enable();
 }
 
-static __init void apic_set_fixmap(void);
+static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
@@ -1793,7 +1793,12 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
-	apic_set_fixmap();
+	/*
+	 * Don't reread the APIC ID as it was already done from
+	 * check_x2apic() and the apic driver still is a x2APIC variant,
+	 * which fails to do the read after x2APIC was disabled.
+	 */
+	apic_set_fixmap(false);
 }
 
 static __init void x2apic_enable(void)
@@ -2057,13 +2062,14 @@ void __init init_apic_mappings(void)
 	}
 }
 
-static __init void apic_set_fixmap(void)
+static __init void apic_set_fixmap(bool read_apic)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
 	apic_mmio_base = APIC_BASE;
 	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 		    apic_mmio_base, mp_lapic_addr);
-	apic_read_boot_cpu_id(false);
+	if (read_apic)
+		apic_read_boot_cpu_id(false);
 }
 
 void __init register_lapic_address(unsigned long address)
@@ -2073,7 +2079,7 @@ void __init register_lapic_address(unsigned long address)
 	mp_lapic_addr = address;
 
 	if (!x2apic_mode)
-		apic_set_fixmap();
+		apic_set_fixmap(true);
 }
 
 /*

