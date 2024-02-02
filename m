Return-Path: <linux-kernel+bounces-49906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C24284713C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9161C2607E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321DD13E214;
	Fri,  2 Feb 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTRodOTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676B60249;
	Fri,  2 Feb 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880930; cv=none; b=DViYL3lo/niD85UY3OOaeh5gaS+4EGqUaaKgMCyep9gvWU4my49mEGHTzJfsdYjeUg1awprt1d7kurLhS2EBCjNkMDN/Vrd0e9lzfWpL5mhTorSPW6BXu0d9IUnixx3jatdiw8ucSEoGkgFtAGnQjdHPoZvi8OPVvp5pp8pW9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880930; c=relaxed/simple;
	bh=K6THucq1Y36mjX1mtaVBB8G3stK33EV44ZYVaZxE6qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5sbbmopCZA1ydvN7iS+WJs27edghEB8V9VPfHJ6gm/0O+btwGXLns/3giuPiI3gN6kkeAeiNZqs1E3pN/wJirL7KsIfuMYu/VqcFNjFNRDVCT0xpripcDaZ+HRm8+18L2uioLZ5F5x/4LmvxyfQR+qvhduqFqJ69emH0ZW4Vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTRodOTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1525C43394;
	Fri,  2 Feb 2024 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706880929;
	bh=K6THucq1Y36mjX1mtaVBB8G3stK33EV44ZYVaZxE6qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTRodOTz25bBMg9dt1yMLRJ3+YxQ+CO5lRLU9KR+IXHRBEaqEVqK5H2LrBtzcKJTY
	 IGXcZzof9ZstcCQUBorzavfa8x8coAOwES6EkkZ6JrIBHmUEwH8pa/3ztbj9lZ1lPq
	 /BiXHn7gFbuMsG0R/1TTI7Am+58h8RYbgLCXSCoG49rEfryZhY7N7VpiNERlTjplB0
	 Rx8q6DOdmiWeuvgb3Oa3Qbk+8r5LDNxEUv9MQPxP+/OMwg+kXk6X1zF2+QRQ5Ccn6Z
	 yvdmPOK7cH0a4Ptz6/rbYE1z0kdet4ukcmkGoz/uy00av3vFr4Fjwf3wZUTNUINzKr
	 qlTKPUmZTtmiw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Revert "kbuild/mkspec: support 'update-bootloader'-based systems"
Date: Fri,  2 Feb 2024 22:35:19 +0900
Message-Id: <20240202133520.302738-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202133520.302738-1-masahiroy@kernel.org>
References: <20240202133520.302738-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 27c3bffd230abd0a598586aed0fe0ba7b61e0e2e.

If this is still needed, we can bring it back.

However, I'd like to understand why 'update-bootloader --remove' is
needed for uninstallation, while 'update-bootloader --add' was not
called during the installation.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/kernel.spec | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index ecedcfc11e73..c1b745967f64 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -107,11 +107,6 @@ elif [ -x /usr/bin/kernel-install ]; then
 kernel-install remove %{KERNELRELEASE}
 fi
 
-%postun
-if [ -x /sbin/update-bootloader ]; then
-/sbin/update-bootloader --remove %{KERNELRELEASE}
-fi
-
 %files -f %{buildroot}/kernel.list
 %defattr (-, root, root)
 %exclude /kernel.list
-- 
2.40.1


