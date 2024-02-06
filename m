Return-Path: <linux-kernel+bounces-54641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4E84B1DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CE228101E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E512E1C5;
	Tue,  6 Feb 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4j3laHXV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlyAuetE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527E12D75F;
	Tue,  6 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213726; cv=none; b=gDlvrbU0ixsv+cEeZKoHCW6XkXyvOt82s7PaXVZL6E9ouBXjJheIk/tKvEGFMBuwxsLSqXHsjjN6veqQc6vYOArWUSd/05gVSttOvpPgDPQM9NJTIIXOvxeFozWUe7lrb0q9k6zjY7F1waULqqgUlQ8+wsgMZRvrJviKazWu7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213726; c=relaxed/simple;
	bh=NTfMPbcLXHzOEzBkAFFoK6F8lJR6D3zYbcL8c4upvs4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fsJ3HwKjWAn/JfbPir+gzB3qvBXPfPjBpl/rzSuqK8KlFzDFs5jTul38D8Y+bVmrwDba0Q0pkh1kJZM0bIdLukiOlJEFzgkrKb9z/1O7syhYT4yLSCzH1/Aa6nglR76IducY1wl79UcH+IkZmd/CqVx27kqJrz9+6oETjGrT+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4j3laHXV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PlyAuetE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Feb 2024 10:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707213716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pw8nOl6Xd35BIIwnw4TJPtMp9fLUt9BWbETiOqwVMss=;
	b=4j3laHXV/SVhfmDa1q8SrWGXQgYi8uEXbmhrEvLm8f3GJVd8RZfHn9Ck0MFDZfjomuwfK7
	/G2lqJnTaue+IaNUgDxdEGhfeB9t1zrsMbe5WyuF/40v2F37fytKaI1ZOJwTj+wGlke5SM
	YI9NKduEy9F/u7P5+jQ0i09D28X/2qgQKY8ox4qZC0t0bI3DA/NNDoi4cacyDq5Yx1xPhp
	3g4UhsV13smS2PcXPvzdfhb16MTT7HLyP8ZHpgK0hm1YD1f4LaoABwyaU/l8yZeVPQ/POG
	hPZ4xGiB3GpGeh1jbIVGFSP/BKg/1QVvMevk4TCx91P6aD5PXqiK50OldR3zcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707213716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pw8nOl6Xd35BIIwnw4TJPtMp9fLUt9BWbETiOqwVMss=;
	b=PlyAuetE1RmvWeEp7wlRTOajknyHzOEuuY5XKy7rASTWd6s/Y4irdwmQxMUWkQgfa0IUUH
	ka6/GaZ6y8v/8PBg==
From: tip-bot2 for NOMURA =?utf-8?b?SlVOSUNISSjph47mnZEg5rez5LiAKQ==?=
 <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add a message about ignored early NMIs
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Jun'ichi Nomura" <junichi.nomura@nec.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
References: <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170721371582.398.17711309093977482776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     ac456ca0af4fe9630cf84e7efd20b7f7bf596aab
Gitweb:        https://git.kernel.org/tip/ac456ca0af4fe9630cf84e7efd20b7f7bf5=
96aab
Author:        NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=80=80=E6=B7=B3=E4=B8=80) =
<junichi.nomura@nec.com>
AuthorDate:    Fri, 02 Feb 2024 03:51:58=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Feb 2024 10:51:11 +01:00

x86/boot: Add a message about ignored early NMIs

Commit

  78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot")

added an empty handler in early boot stage to avoid boot failure due to
spurious NMIs.

Add a diagnostic message to show that early NMIs have occurred.

  [ bp: Touchups. ]

  [ Committer note: tested by stopping the guest really early and
    injecting NMIs through qemu's monitor. Result:

    early console in setup code
    Spurious early NMIs ignored: 13
    ... ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_crat=
e.local
---
 arch/x86/boot/compressed/ident_map_64.c | 2 +-
 arch/x86/boot/compressed/misc.c         | 7 +++++++
 arch/x86/boot/compressed/misc.h         | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compress=
ed/ident_map_64.c
index d040080..4a029ba 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -389,5 +389,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned lo=
ng error_code)
=20
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
 {
-	/* Empty handler to ignore NMI during early boot */
+	spurious_nmi_count++;
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index bf2aac4..bd6857a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -52,6 +52,7 @@ struct port_io_ops pio_ops;
=20
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+int spurious_nmi_count;
=20
 static char *vidmem;
 static int vidport;
@@ -506,6 +507,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, u=
nsigned char *output)
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
=20
+	if (spurious_nmi_count) {
+		error_putstr("Spurious early NMIs ignored: ");
+		error_putdec(spurious_nmi_count);
+		error_putstr("\n");
+	}
+
 	return output + entry_offset;
 }
=20
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6502bc6..b353a7b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -59,6 +59,7 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern int spurious_nmi_count;
 void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);

