Return-Path: <linux-kernel+bounces-30352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A19831D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7721F250EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840382C19E;
	Thu, 18 Jan 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DitAwJ3b"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A51E494;
	Thu, 18 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595781; cv=none; b=EomoY+PBcjaYB9VgwUBxTxYjKFiBiuCh6elyiVauCAvy5gM+bUbRqfAwVXyr8ag9VK7DsCpeY6Ib68mPDdcvYxyc6S2czb0IVnVcmdIa9D7HIzYz3qZaxscYC1S4YbFe/HSqlJewQ23SIgEgiK/0iSINd7oPqghUyy31kLlXb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595781; c=relaxed/simple;
	bh=wcbZ7v76tRyhBtRUKZXECR/2Po0l+UcB5uxgbPcmCS0=;
	h=Received:X-Virus-Scanned:Received:DKIM-Signature:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=njfyIqVAAxVHXqCVAwS9r7RkMUJcWJIDnjI+jk3UAAPwURvw6VBnmPEivxpNuce0Mnxs+o7dy/aCcNbKD2p1eCRgkKFg+/IVIEW5ynOV7aua1qePaFPScl5krs7aBst0ok8/LgsUBAYqZjL3npkC6uvgj6Pi2Jzi+NvrNK6k62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DitAwJ3b reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 23F6F40E0177;
	Thu, 18 Jan 2024 16:36:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5XjpfSoLKVy9; Thu, 18 Jan 2024 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705595772; bh=+tZQFnI6rl5JS9Eyh8uFIPriD1WGVARI0bN0k+Y1Xw4=;
	h=From:To:Cc:Subject:Date:From;
	b=DitAwJ3bHB/rItyAzqmTeNCxUQY0DuVN3sk8Srlgbsa9+yiC8CNv+vc5TUXDGe5Kj
	 kwqQRh9oMQuGemGmInUSP8UwYWq4gVt7b5pWzdECn0Cix5bQkJpj3ePyvHPni7X2PJ
	 ejTMtBJ/fdhPKinXAia/55GvzPMrv47ikgCSa6nJAIclkcVQby9aNsxt45EH1xdi5T
	 CZt1bx42dQfKsI3/t3MywNU9UAKvLTIjxpiRs0imbjI/XZDnZFT24NABjXWQls2iyx
	 ZnS/Lygo4hMyYS7qSRV/cKNbg4qyHIlxBozrtkd9GNbnssdoTTjzgLRKl8jbMKZHJB
	 eTeuX2UTjlctdtQbH0ZIXGzPnvHighWUg9aKeQkArzZI+UDOAB0HC410OCdrreZQk6
	 ByRdZ/sPpKQJei2gcqpkEArS0F/bhw3GoiC2aveAVvBTU5gsWZ0K2QpbxKIY5/fUwU
	 bwUdBSdxqTqJ1Ixf909JOAgzwMwXOxmzmLhlpkX1RKzYiCtJc+cxlIN88Joyl7JOk/
	 xz8jTDMk8AazhUOW9PRikHFtdVelJZu+rIMnSv5j6wHmUFddCm4qRZXuuqUIxr4eZZ
	 PPNov3I9eWN2zTqd2m7l6dD3+GZRwjL5ija/pkgB+Xmk/GIuisqH0ixIWF+hhQux2O
	 LyyzgFdWkBcjlVkDdjYy+KCc=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9C9B40E01BB;
	Thu, 18 Jan 2024 16:36:07 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	X86 ML <x86@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/kernel-parameters: Add spec_rstack_overflow to mitigations=off
Date: Thu, 18 Jan 2024 17:36:00 +0100
Message-ID: <20240118163600.17857-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

mitigations=3Doff disables the SRSO mitigation too. Add it to the list.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index a36cf8cc582c..65b47c23d55a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3397,6 +3397,7 @@
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
 					       retbleed=3Doff [X86]
+					       spec_rstack_overflow=3Doff [X86]
 					       spec_store_bypass_disable=3Doff [X86,PPC]
 					       spectre_v2_user=3Doff [X86]
 					       srbds=3Doff [X86,INTEL]
--=20
2.43.0


