Return-Path: <linux-kernel+bounces-110004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085358858CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3241C215C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ECC762E0;
	Thu, 21 Mar 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XSp17bLB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC8757FB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022782; cv=none; b=fNYjluG4gAiwX+rJLew4EUN0dcKos1AnSE7SDwcnK1T1Xh7IfQFJaoX7lh8P9kYVPM99zNGsfq/5VoARAQGc43GPx9rfZ+x9AMP/7UseC6nFOHl9mXshJDPG9RJ1ZcQbWvAfdlsMS0M8aNeDbhblwsp5GMTn4NOvi1kzmyKUs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022782; c=relaxed/simple;
	bh=UvforLwfgnlG+jp6wPQG0d7IyTlRP6uEi4yy81qpH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfEDKamlwlRMhOG619xSFL11D0ZGljOXrO5hBm3mDe5MhtdXJBXFPyxX3DMEMr3IMEbHsK3CdaZxO8kMmeRyOyx0DPgOzK32mdbVRpYHJ7miV7COwuBgaiXNXOsNnydjT72KfjNsz/3h3y/wJ9CkEddd0mlV7lXebptOIE7Zqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XSp17bLB reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 53C5B40E0174;
	Thu, 21 Mar 2024 12:06:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OyVSDZbBXt_s; Thu, 21 Mar 2024 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711022768; bh=ySNfKOBvmaBjblVhDHOEORlC5hG2HM8FoWiv/5wO+kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSp17bLBcorqiurTE1T/YaEeVhg9jfcch8XQBB3BlXIaVrMPGW+FB2MFsSFXWTBG7
	 RfvQQG8o4RmzN0PUF1B6ZMWcp0Acxhef/xIky4oXrjlj63FstUj1iKNl/8PA+E6c/e
	 7bDT9d4KnPNjrLBgdAFiQ4CpXulA947qu/d02HXGfS1XwcbmkhP7yGYfweECSyja/d
	 AmHWHK3EGtOc5DPLQw4hEKmLJDvDhHELZD2TyYn8tePfLm79yJ5QWsBBz8cYfcE+q2
	 irabCiG4qd1+h5mSvN5XYyLdlFuZgSQM0XMrlFpI+QTS0kbdluQKluziU+B/T7h3rC
	 +SDx4HSNfmfUJ9WNeBCnPNt9+eE1B8ky1uznePXlEknDtIe6j3AQPGKwuufArOrKiP
	 wZc5TjRh1CFe/1yHATVowgrb790CjVdjzAGCNK3XvKEYHwnt0J1BT1MWV6lj1gCG8h
	 a1AaE0DjZ691zbBrD68SDTgojRfK+dyxMX/J/NASWSCQA5irUFPMIaVcmFxdYxX4po
	 nRUp8kxTxPg2xzV0Zk7d9c8hyvqw7exa4Jx6TkACseoDyIq3zS5g5fzNdVhHgeJS/U
	 +fNequf0McdUq/t9EtGK9MDEwKxBkCgDfC/yHnNmuEMT7o4hsvKzJ5Y5YPpE8Bd8W5
	 V1//s3w8r1sa/5TS+ZkrGfy8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1483540E016C;
	Thu, 21 Mar 2024 12:06:04 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH 2/2] x86/CPU/AMD: Improve the erratum 1386 workaround
Date: Thu, 21 Mar 2024 13:05:48 +0100
Message-ID: <20240321120548.22687-2-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321120548.22687-1-bp@alien8.de>
References: <20240321120548.22687-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Disable XSAVES only on machines which haven't loaded the microcode
revision containing the erratum fix.

This will come in handy when running archaic OSes as guests. OSes whose
brilliant programmers thought that CPUID is overrated and one should not
query it but use features directly, ala shoot first, ask questions
later... but only if you're alive after the shooting.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
---
 arch/x86/kernel/cpu/amd.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6d8677e80ddb..c02b07feff6e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/cpu.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
+#include <asm/microcode.h>
 #include <asm/numa.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -804,6 +805,16 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
=20
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
 {
+	u8 fam, model, stpng, rev;
+	union zen_patch_rev p;
+
+	p.ucode_rev =3D c->microcode;
+
+	fam   =3D p.ext_fam + 0xf;
+	model =3D p.ext_model << 4 | p.model;
+	stpng =3D p.stepping;
+	rev   =3D p.rev;
+
 	/*
 	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
 	 * certain circumstances on Zen1/2 uarch, and not all parts have had
@@ -811,7 +822,24 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 	 *
 	 * Affected parts all have no supervisor XSAVE states, meaning that
 	 * the XSAVEC instruction (which works fine) is equivalent.
+	 *
+	 * Clear the feature flag only on microcode revisions which
+	 * don't have the fix.
 	 */
+	if (fam   =3D=3D c->x86 &&
+	    model =3D=3D c->x86_model &&
+	    stpng =3D=3D c->x86_stepping) {
+		if (fam =3D=3D 0x17) {
+			if (model =3D=3D 0x1 && stpng =3D=3D 0x2) {
+				if (rev >=3D 0x6e)
+					return;
+			} else if (model =3D=3D 0x31 && stpng =3D=3D 0x0) {
+				if (rev >=3D 0x52)
+					return;
+			}
+		}
+	}
+
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
=20
--=20
2.43.0


