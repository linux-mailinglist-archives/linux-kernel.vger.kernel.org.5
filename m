Return-Path: <linux-kernel+bounces-52942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CC849EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EAF282B70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F332C91;
	Mon,  5 Feb 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OOCwvCd5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C92E416;
	Mon,  5 Feb 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147981; cv=none; b=aBnoa85ipNRiw56m/+XDVhPaPDfwIl0FlpSNG+FyecbI7rtES2u1n4Gcde3nMI7CePCd0lguWXahFPv/bhcbDhOPukMP8N/yfyCj51E8ecDZuJ7wVfp8Kw9MbQr4jfMqPb7wtVbYu+2QITunyuxKx7DFELPlMi2Vuuay7Vi2kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147981; c=relaxed/simple;
	bh=99DLMoiQw9UdibYsb7nW4kjtVppg2enuDKrfn5xnVBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5XrCojhOyBsHcfOTRZ9M4noEFF2anA4/zWpQPd880C+Qge4EUscyUY3FScBbkeAlPhMu5V79gS5CgfztwcdqCxv0hhp42IHf/Moc6JT7LhVuFQ+ucsUmwmxg7ABX5TxQapqPmVEeXKGKiG5PDNzXC6rqVwScF1lYrd/QTlDkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OOCwvCd5 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DC5940E023B;
	Mon,  5 Feb 2024 15:46:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vjXImscZRHXO; Mon,  5 Feb 2024 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707147972; bh=wbm3Vi14SEHcJedVBXKYDq7ca7nh/UFMqRcdkimkw/E=;
	h=From:To:Cc:Subject:Date:From;
	b=OOCwvCd5/pLan3qvX+REeAAkY0+icWbWTYpNGlSt7Fr4ugiRQm2mHi1fI4867IU8m
	 SZUQ8Zb2ZJ1eEoyh7Rd5qExLze2GAViBfTc6e75cXvzo1rtDNuL4R7tMkPWOdhYKy0
	 UexLSiEOvw9/8PfrZBf5gtz0QvndmcZwmh8M2C3UhNISgMzLy14edLYbnfMux1HlFc
	 3K9Jqz2mmYAtw7eV419OJOrH42CrHfrlCBgdk7qKKN90ZMn8xt3rCyofg5+C8VoWe0
	 Z8+0tZHhDDOURvqCqMxQ+Q+KFcrivqDuleR+wZeQWX6xc6w4oMxwCabTwKir5qUJAA
	 o76ILQ/lUENzce4AyygZQfIDC5a8LRLikIoBmVYZlie+EXM/+IKhI4g2titKHjmWPx
	 vpeE2bK80HbifGq+wjhe4sor+f+DhbywzYclEpqVSs5IHNODDCV1D7FP8zSs3yr7CE
	 tM29DcXBkIzcFOcNf9+M/S0TzeeSBWeKiKSuzSGJ99q26/nEFZHX1ftFi6DtL/JO4P
	 sHpfQn2X094jQwxTXAZLEoXfICYAfFbsob5tkTJBDWldYVuMD29XHFXuZwQEGJeJAT
	 bHGeXyB9MTnvsS2HGxVTxkZuqjpRc0qkdBPzRyi4XJaBSlHnwcKgEnL3kBNP9wqomT
	 fHGJ5EaHm9EFwuJKpaYgNHpE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C55B40E01A9;
	Mon,  5 Feb 2024 15:46:08 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>,
	linux-crypto@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: ccp - State in dmesg that TSME is enabled
Date: Mon,  5 Feb 2024 16:46:01 +0100
Message-ID: <20240205154602.21411-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

In the case when only TSME is enabled, it is useful to state that fact
too, so that users are aware that memory encryption is still enabled
even when the corresponding software variant of memory encryption is not
enabled.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/crypto/ccp/psp-dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 124a2e0c8999..56bf832c2947 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -156,11 +156,14 @@ static unsigned int psp_get_capability(struct psp_d=
evice *psp)
 	}
 	psp->capability =3D val;
=20
-	/* Detect if TSME and SME are both enabled */
+	/* Detect TSME and/or SME status */
 	if (PSP_CAPABILITY(psp, PSP_SECURITY_REPORTING) &&
-	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_S=
ECURITY_OFFSET) &&
-	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnece=
ssary when TSME is active.\n");
+	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_S=
ECURITY_OFFSET)) {
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+			dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnec=
essary when TSME is active.\n");
+		else
+			dev_notice(psp->dev, "psp: TSME enabled\n");
+	}
=20
 	return 0;
 }
--=20
2.43.0


