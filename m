Return-Path: <linux-kernel+bounces-57327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A551684D70A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4503A1F24378
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655B36B16;
	Thu,  8 Feb 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgwIc1/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3725D50F;
	Thu,  8 Feb 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351313; cv=none; b=MSzzeaCdQlIQrvsUOAwrJGyGL14wJ/kE1KBtg/6Kaldow6c71vOtAb5f6rykXe9gqwsSlMs2F7woyP5wE95tY3qFuka2RZnj26xigdPKieh+z0kPUP7GL5yZLPmwZWCYDBhYUzslDFOfRPWWl8P1vleB7t/O9WW2K4q7SFS5CyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351313; c=relaxed/simple;
	bh=5f+GlBiJxZjhDl4Rv7fblarUlgSt/9TT1t6UVb+Nqdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svpIGC09Sn6B+GD3W63B62c3M+JP4SRTr7ACNHq4DC+pfvTnmgDEVCId/K3wjC2//DGHATgbDXQ1L6j6ELkgCWprhuBVXvcVVjrq0K/xpU9yvbTeVcWs7MqGqPyWGGgjJlAqpEj5G/sqH5YvWagR2zYs3+s40gaNSVjbGrEeu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgwIc1/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FEBC43141;
	Thu,  8 Feb 2024 00:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351313;
	bh=5f+GlBiJxZjhDl4Rv7fblarUlgSt/9TT1t6UVb+Nqdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mgwIc1/O9w/qwjY2Nz1d8Romqbt2EbHAFJ/6zmmpqCgNTe5DRalxLnnYfMefQwKli
	 B3nw7sJFvpibiPONx/JsIHBN8cY9/jFRJ3wJ2Dh21tQTYi7PYMl5tanvHWm4h2bXt7
	 V5fDe2r+qW3vqibeqNDCE1z2/x2ebMHW69N4w0JtpS4pgo0AQccYAPZih4eCLD1DTB
	 VbYlsCe0/yikg4XwZOvT6pRNOmZO6+Gsn7bmuC1Nz7B+v6lNr495Efku0xfkW4LFAU
	 mF8B7ji1So7CRtKPcSPz1/bdeKjCgChXwGzswN9n03oEe26Ovyr0siBKpidfNlCoGB
	 mREmo8WM1+FYw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:15:02 -0700
Subject: [PATCH 10/11] s390: Select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-10-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5f+GlBiJxZjhDl4Rv7fblarUlgSt/9TT1t6UVb+Nqdc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZDkOuDuKK5xpK7cUecmZlCcX4WW+zOzQ3D2LbgXrZ
 JyRVF/fUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbi8pGR4VfyW5ncJvPP6xxE
 Yuo+F2VcEonQ/mnCIHRP2aVSfKL7IUaG14liKw+aPtj99TTj/sTbzfeZ6hh2iyw2Ezluu4B5+mp
 bLgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that all sections have been properly accounted for in the s390
linker scripts, select CONFIG_ARCH_WANT_LD_ORPHAN_WARN so that
'--orphan-handling' is added to LDFLAGS to catch any future sections
that are added without being described in linker scripts.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index fe565f3a3a91..771235aee6bf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -127,6 +127,7 @@ config S390
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
+	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2

-- 
2.43.0


