Return-Path: <linux-kernel+bounces-131151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E65A8983C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B68B2347E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22D74437;
	Thu,  4 Apr 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqwJy8Lb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="df9HqsCI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2074400;
	Thu,  4 Apr 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221879; cv=none; b=sNHnnm7ZuHXWdKtvWUjzWbEdyZ4DRzNob3SBel0BT6Mc3cQZb+lRK8CW1N6BPo9khl8nYNTwvpGFsauCHaKn4sTbAf/rh0aDuJE2d1oXjsG+jH8pcg2U3YEeHuEUhbe5pV3m2a6sD1JcaJHAHGIs8bBhLWG/5dogywf4fy4vtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221879; c=relaxed/simple;
	bh=n6p6k/lzQG02x5T4fSz4bMGLchasV8xiKuhC9VwpMhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hCifBYqhzpVevPPzViYSy9GDKz6yk5P2rZKZ463XR8ANnG6XLnzuTW5dXcEaEyq+jpQUB9ToBbjECRcU6zaUYkA++qM7coA8mjiufuCbh0suSu5BoqtRf/OdXW9I7U3KMMtl04T3wdTYz9r22h6OaAbPOVD2sW4KOhH2YZhgGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqwJy8Lb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=df9HqsCI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hDGC9rmC3pGIV6LYm0wQNtQvLdvNnK47d0tnk8OlT0=;
	b=BqwJy8Lb6OkvzA1FcsvlDg7D+DbXRbT4T1FEj7ue7HxFVAPxcpetro+8PrLdzeTpKl1N0E
	ZL3n6McwsyGF+eF/5iOPutSsEliyLUNyTIo5aew0Ez06bEJ/GfntAV3mRoOKdOwlEi8sKV
	07wIrDi40VulswsrA29EEbNBudGJnUCGRkMX8Lu2kYUVTRJXG71JY50EbcGH7OPUlcphXY
	r8gqpGDiG/gzUiXz5OtwPxdyyEyW8tCB7qCLiuOTCVxCa1gpDUZwMiUAPzS6cnGGkUOSUN
	tB8fC8gmDFjF4gqugu3xhoUPjohCgD4E+5BraBeDb9Eq1soFnnd5yMmx3WjoCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hDGC9rmC3pGIV6LYm0wQNtQvLdvNnK47d0tnk8OlT0=;
	b=df9HqsCIlejzfhym84YK3waW/9daiYZFUrUBfpWb3T1w6+8M3NcgNiwWGk3/709Z4r0G69
	mUFteQ+sIgSmw5CQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kvm/Kconfig: Have KVM_AMD_SEV select
 ARCH_HAS_CC_PLATFORM
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Srikanth Aithal <sraithal@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-4-bp@alien8.de>
References: <20240327154317.29909-4-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187604.10875.7369172404715557466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     54f5f47b6055c6b57cbc41a440f8ca8b2ec4275a
Gitweb:        https://git.kernel.org/tip/54f5f47b6055c6b57cbc41a440f8ca8b2ec4275a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:15 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 10:40:23 +02:00

x86/kvm/Kconfig: Have KVM_AMD_SEV select ARCH_HAS_CC_PLATFORM

The functionality to load SEV-SNP guests by the host will soon rely on
cc_platform* helpers because the cpu_feature* API with the early
patching is insufficient when SNP support needs to be disabled late.

Therefore, pull that functionality in.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-4-bp@alien8.de
---
 arch/x86/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 3aaf7e8..0ebdd08 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -122,6 +122,7 @@ config KVM_AMD_SEV
 	default y
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Provides support for launching Encrypted VMs (SEV) and Encrypted VMs
 	  with Encrypted State (SEV-ES) on AMD processors.

