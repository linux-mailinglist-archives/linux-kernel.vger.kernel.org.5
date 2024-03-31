Return-Path: <linux-kernel+bounces-126337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690BD89354E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062921F22F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE3146A88;
	Sun, 31 Mar 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K9qn3z0c"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA5146010
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908073; cv=none; b=a8mUsc+/xHOBOSOcJltE7SG/tJ/rP8khklktFDqrP+ZntLnSz/XnPiliECmCouZkmS+OSIULI8DMkaj+H3+ejJTu0DiDnU1GsXQanduDqpSDRzMMYuLGhGrBFzQvqWdLe3mcAv8svCy4BGJhYvO8fNfVBwA5DIh96W+Cgpa1sSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908073; c=relaxed/simple;
	bh=IhzTBjgcSUxPoooKAQMtSfyuHxZVHsNUvUQ5FyB2k/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQagxF0d4jla9LY+rucff19mIRNg35YxMZTYo4Mph36dI0fOy5kp2UgEB9KOd22zs25YCtFKHpmNR8ntZAyvTmmcuf4ySYr9UH1DHk/Agy8p6hx5r8Yq0KYvaipnf1FcgB02AKDjBXUYXljnUX5JblH1trO9AJR2F4OtWwk/m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K9qn3z0c reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 58BE540E02A5;
	Sun, 31 Mar 2024 18:01:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JgU7a60AfwIv; Sun, 31 Mar 2024 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711908067; bh=ws0VdAWkXbMIBACYGflMkkVS5RnmQ4Ymb+wW5pLwxlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9qn3z0cErgG2fQK0eRAsEk/xh+rtwrfJum4UAEVoGvPQmGtfCgUUz6O2GazczbqA
	 t/GFxksgI+UbutZr/56EglUnmYEnleIv5qnT8EKxSXIatIB4iIrB6dou80ewPlJdkv
	 ZBSW621KvXFBF0iXLRn0KetG7Zv5e1kCmSM5xS00uo9P+whpnv9oDp89QWd2n6MCqI
	 kQFAoeOg8LW42lWka5135uc+IXID8xFibgSA/zSmkU9q+yJkALaIkKcl/WkLoMMeuG
	 Xi89RQ9ew7nQfwA4sIu3i0tKSwElv2PkwdX7QXVxtLOBeGQJiVDeQCJMkJ7MF646RU
	 Dv4Fu0K7yAac6aATtwWdnNZbPoZ8SFqObQKAWyAvHCEGSf9f1rwrj1e05qJRjunJXS
	 gBO1nTJ8l5HFUVyM7YgcMWOLilQR4riiWAF2tIhHQyk8bY2l/kaJtBTELYnBb4bY36
	 HoOD8EWkcIDGmKikUPpcHQgRx1goIClwdZuP0TLAyQM70k6LLGQnXBUAsy+7cR2/Uk
	 6t8cmG2U+Drk2lJl4/FnNLLFHAZUZ9x3qwtW4EtBiV1IoEBvpAUIfh3JvrcRXY4Ivq
	 7eSq0Zo0/Ty0uEIzyJAjiEECSupZ1ag40lpe0uNR2LFL8LLDojwHnf0I60QgaZlWWI
	 heKv3yZ2It2iF+9lsSqWtSns=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 220E140E0202;
	Sun, 31 Mar 2024 18:01:05 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] x86/alternatives: Optimize optimize_nops()
Date: Sun, 31 Mar 2024 20:00:41 +0200
Message-ID: <20240331180042.13933-4-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331180042.13933-1-bp@alien8.de>
References: <20240331180042.13933-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Return early if NOPs have already been optimized.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 4b3378c71518..67dd7c371d28 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -233,6 +233,10 @@ static void noinline optimize_nops(const u8 * const =
instr, u8 *buf, size_t len)
 		if (insn_is_nop(&insn)) {
 			int nop =3D i;
=20
+			/* Has the NOP already been optimized? */
+			if (i + insn.length =3D=3D len)
+				return;
+
 			next =3D skip_nops(buf, next, len);
=20
 			add_nop(buf + nop, next - nop);
--=20
2.43.0


