Return-Path: <linux-kernel+bounces-63438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6858852F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625E11F2158D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E336AF3;
	Tue, 13 Feb 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7EjjPoz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYQ3uDu0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F107364C1;
	Tue, 13 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823809; cv=none; b=mcZu3LZcqr9hS6CVOmi5EpU55SQUBjY9qFdCoC6cTpIpOSg3qN2lMXDWNpwcdNO2LPSbwFyl/TUk+iBWpViC2RDo7muEgoTJnHZTjZM4UZjVDfny21s+OpLrmF+EyhAvfxYUS26yNdb2Ihv7f9OWA8VV1Ie5170a1rt+y5D/qFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823809; c=relaxed/simple;
	bh=5izMiGMvnqhgGkUvIKXkWstcbpTq9lmIY9dFDbhveDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1jcRzJqFHo8Y0vQKNGcNi4yRvJIkbG2iUTzJ9V818ClFPKBOK6mhyy+G3fSLbCL0mWFRPlPoHKOADjtD0V1OuQbPvAfAh2++N6qgFXM3HGvhilc5v+z+wYQ2SQMPYPkLLfq0sVnHXc6l95X+9e8yU8ZBQUAnQQDPSlXACU9lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7EjjPoz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYQ3uDu0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 11:30:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707823805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+Nbe6pDZ63ioQkKXid2jGstswmBXmnpdiKfauFCv7Y=;
	b=v7EjjPoza9OKUfvNiXiPXmVT4wX8iwkdLqgMLI5ZPscWM8JQq/OZMypyyY/q78AIszKc8e
	S2wmSYmYIbO2sLZUpngIGLa+eD9ytQ66aEUG5Rey6cXq10VwKn77/iU9rEGOnqPEy2VYEZ
	1pVo4YdtRbEpDYR+ApXXjuv441PUgTWI+8Noj9fMmKvVJJQ4bCwE9q8OYHm5CAUKLgKPWX
	F+NZW9o6/8BTwjaoaaTqTJ9FxDEKzqo2yI4ETDbtIohdHKdpY6Cag8JW4GJ8mBEpGl3T7m
	wkgF9bSI0DvxMJ3gG/XGOtEq/TkXrCZiePI1s4n8Tule6YnqVw+CSSymA1cfug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707823805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+Nbe6pDZ63ioQkKXid2jGstswmBXmnpdiKfauFCv7Y=;
	b=uYQ3uDu0YWWBlQjT43ZDa+gPK9vcJRneHq+PiaZTes1pD9TrRMGlVbxkgzQHVJrN19Vw1O
	5aFNOI2yXC5JKFCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp - Have it depend on AMD_IOMMU
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240207204721.6189-1-bp@alien8.de>
References: <20240207204721.6189-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170782380447.398.10866500625716475213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ee8ff8768735edc3e013837c4416f819543ddc17
Gitweb:        https://git.kernel.org/tip/ee8ff8768735edc3e013837c4416f819543ddc17
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 07 Feb 2024 21:47:21 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 12:21:15 +01:00

crypto: ccp - Have it depend on AMD_IOMMU

sev-dev.c calls code in the AMD IOMMU now but that can't really work if
latter is not enabled in Kconfig:

  ld: vmlinux.o: in function `__sev_firmware_shutdown.isra.0':
  sev-dev.c:(.text+0x2501f0e): undefined reference to `amd_iommu_snp_disable'
  ld: vmlinux.o: in function `snp_rmptable_init':
  sev.c:(.init.text+0x26260): undefined reference to `amd_iommu_snp_en'
  make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
  make: *** [Makefile:240: __sub-make] Error 2

Fix those deps.

Fixes: f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240207204721.6189-1-bp@alien8.de
---
 drivers/crypto/ccp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index 32268e2..f394e45 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -38,7 +38,7 @@ config CRYPTO_DEV_CCP_CRYPTO
 config CRYPTO_DEV_SP_PSP
 	bool "Platform Security Processor (PSP) device"
 	default y
-	depends on CRYPTO_DEV_CCP_DD && X86_64
+	depends on CRYPTO_DEV_CCP_DD && X86_64 && AMD_IOMMU
 	help
 	 Provide support for the AMD Platform Security Processor (PSP).
 	 The PSP is a dedicated processor that provides support for key

