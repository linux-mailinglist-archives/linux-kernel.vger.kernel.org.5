Return-Path: <linux-kernel+bounces-39385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4683CFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F201F22039
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143E1AAD1;
	Thu, 25 Jan 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCwoJwnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C731199AA;
	Thu, 25 Jan 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223365; cv=none; b=Y15N0LQl2iVUxCclF9ytXf7+ZgHXCoV5YmTkuqZpR5m33pboQZYcu9y+ktrwzRURAa4GZwB/CQMglzAF7DfIjachc5lMzFBmM5fgw6wVAHN10iX+48hb64TdNWN6owb6tEraGLtCO3G4B4JvDI3IV8zFxwFaD/Hg7lqyJ5htpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223365; c=relaxed/simple;
	bh=6wq1GuvDlEslZKmrg6tmS3nUaar/vpxm/uhXrm7yG3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQnzrBxybt7CZErNlPcxREPAVOWevAdcopOCgKiWAfS+VJQGiW1RTuWPMwbhal7Hozea+ehIWfhMDARttphKb+dwtTEfzitzOfEsJlv2yyrq/3lBUp/WLdUtEFZbono/qDfN4jcQLSvyum1j+OBryHxuQl117PciaZCqWfeaFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCwoJwnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F3C43141;
	Thu, 25 Jan 2024 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223365;
	bh=6wq1GuvDlEslZKmrg6tmS3nUaar/vpxm/uhXrm7yG3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eCwoJwnYFU9XS3munio2UjVcIivKmI2PwjQ22ghkTjNo8XlOpXypa9AYIREAyQAN4
	 21iGjuR68kHSLLGm7wHTcZLQC0m2slQoqlH3ziAelVTKbqgGM8jEL5SW8lcfx60IRg
	 jjAOdK58VBZkJrgq1TmcDz6sylZLkD9FTdn2cd0jvlf5NDIBAdlgI+OSoxw9biFRiV
	 Z03FwGhsZDcxccCRZj6ORNakIPiQvwwlJEwbmjdwaCa2GmM51au7ZYjoDS7+cJt+C+
	 4PEwkum142q73TJuru5DRbygyCWAMn5M3KTCjqNlZHdl/nyhyG97QiODY3zr7Bgu53
	 YxVobvzS2X+IQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:12 -0700
Subject: [PATCH 06/11] powerpc: Kconfig: Remove tautology in CONFIG_COMPAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-6-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, mpe@ellerman.id.au, 
 npiggin@gmail.com, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6wq1GuvDlEslZKmrg6tmS3nUaar/vpxm/uhXrm7yG3M=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv1TnCfHLDdjGruCEvPaHoOZztX5V6ZdWlK4/Weru
 9jnj1HVHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiMlEM/2sfzzHaUhLHYsQk
 pLiXLerRRKGXamf1bTn6wt2CEmKnzWRkWBrPG3WE1XGKp9rBogOTPwUxql+sPrnK8nZlQe/fxCM
 qvAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

This reverts commit 6fcb574125e6 ("powerpc: Kconfig: disable
CONFIG_COMPAT for clang < 12").

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, this condition is always true, as the build
will fail during the configuration stage for older LLVM versions. Remove
it.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: mpe@ellerman.id.au
Cc: npiggin@gmail.com
Cc: aneesh.kumar@kernel.org
Cc: naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b9fc064d38d2..86da0d01365a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -333,7 +333,6 @@ config PANIC_TIMEOUT
 config COMPAT
 	bool "Enable support for 32bit binaries"
 	depends on PPC64
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	default y if !CPU_LITTLE_ENDIAN
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION

-- 
2.43.0


