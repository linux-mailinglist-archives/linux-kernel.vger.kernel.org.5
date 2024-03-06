Return-Path: <linux-kernel+bounces-93391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A36872F02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D704FB22261
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD55BAE0;
	Wed,  6 Mar 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BQrNUg1/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A9171BB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707853; cv=none; b=sYv5srdr2GGlMqTa5uNKjandqtuMS6OSoTHW0+An8bmtqtdroMakcd/brO03aQLTcBeyIFdVY4VyyheZHCuCnEJpDYLJ/GqJCmRUY5Rwz49/Y1v4LQ66KjCBPGsJtvZZ6RWpLqNPdiVJPYtPOROqlQ+PMizm6z4Y73EInFjsUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707853; c=relaxed/simple;
	bh=8BjGn9fcDjxa92vW5NdDP75CxusHyCT4O34v1ZpGAHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E9FG9ZZu7QXTeOH6iQtz76cfZHY+XIsRXPb8Cdly8h1wlbQux8wTShWEo1UocGSEazqfKWXJ3xmbzJjEZsIRIVRRoOVgyN/vlJRk+hdKOc0zJJS/S4tzoI9E9fdpYng1xHnAWUz8IRSvdNVM7AXO5fbanZVvVV0Z8dSpY0BU4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BQrNUg1/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709707845;
	bh=8BjGn9fcDjxa92vW5NdDP75CxusHyCT4O34v1ZpGAHc=;
	h=From:Date:Subject:To:Cc:From;
	b=BQrNUg1/1nSRcpAUqzJ1ItjSJGn4L+zJZ+OKvtSIcXmFrRv/u993UHWvudtvgUfyb
	 Ur750q6G3UGVQZ7UO2Gaw/+Xy2GRKa80dpLBOaWwiv6j4WIg2DERS676g8ZC7pAmSo
	 cbGnZlIuZd/63M865eVY+496/kntF/GNoDu76g5Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 06 Mar 2024 07:50:29 +0100
Subject: [PATCH] x86/nmi: drop unused declaration of proc_nmi_enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-const-sysctl-prep-x86-v1-1-f9d1fa38dd2b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADQS6GUC/x2M2wpAQBBAf0XzbGosuf2KPLAGU1rakVby7zaPp
 9M5Dyh7YYU2ecDzJSq7i5ClCdh1cAujTJHBkCkopxLt7vREvdWeGx6eDwx1iTwSNTSaai5yiG0
 Us4T/2/Xv+wFejER9ZwAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709707844; l=983;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8BjGn9fcDjxa92vW5NdDP75CxusHyCT4O34v1ZpGAHc=;
 b=d0NlgwWVo++RGHlapaUXxSPgvkKCCsilxNemr8ilYjryyjMQNmLjKkAe1GTW/3XfQfVMkyANW
 7vw7/3PS/NrCgoqAkJhWWulO3LEAcqjgxYIHIsF9g2GJ5h9D9LYoJeF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The declaration is unused as the definition got deleted.

Fixes: 5f2b0ba4d94b ("x86, nmi_watchdog: Remove the old nmi_watchdog").
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/include/asm/nmi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 5c5f1e56c404..41a0ebb699ec 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -14,9 +14,6 @@ extern void release_perfctr_nmi(unsigned int);
 extern int reserve_evntsel_nmi(unsigned int);
 extern void release_evntsel_nmi(unsigned int);
 
-struct ctl_table;
-extern int proc_nmi_enabled(struct ctl_table *, int ,
-			void __user *, size_t *, loff_t *);
 extern int unknown_nmi_panic;
 
 #endif /* CONFIG_X86_LOCAL_APIC */

---
base-commit: 5847c9777c303a792202c609bd761dceb60f4eed
change-id: 20240306-const-sysctl-prep-x86-eb0090b27f43

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


