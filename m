Return-Path: <linux-kernel+bounces-49907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CA84713E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DE21F24CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0414461A;
	Fri,  2 Feb 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9wTjFPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35601419B0;
	Fri,  2 Feb 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880931; cv=none; b=Asuj2kGush6IkkAaYbLGTtSdhTPDhlFy6r552wodT8zsIkykBDiygeu7HLDHfL6UTOQQeSYmXnEWgb0DOiyV2Auem64shf9xzaR8NqjUJYRhcb4yWK3p2GDP69bbvT766f/tluvGGdY5w7xqMjLvY+5eDwEdaGIuddQiqUKktfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880931; c=relaxed/simple;
	bh=kEo4j6RbGBwDkaFpN5XVSmcWPQCgDr626mH0ogy5qbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTxc0neANVfYn87TPZOb34IvFKNs8JSJudYpwXjAd2x2QEdBkZMnVdN0svFtzn+n0ew84FHqYAkGjuk+J9S6icqFFwydLgfdsIwDjvQbLy7xrKZhiUY7nQBi4lX3hnkqQScb3Rh/X6+yRNLNanhrORh8d9R4WieugoIDwF+CjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9wTjFPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5833DC43390;
	Fri,  2 Feb 2024 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706880931;
	bh=kEo4j6RbGBwDkaFpN5XVSmcWPQCgDr626mH0ogy5qbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9wTjFPFPUJZK+qU5vDxPrIjjaDRM1wdNAawh31g3gXI9yurFsRiN/HBPEGxELIvY
	 9jikLJsYmkoG5bwzv5TCpYgwc6Kz9K+MpaedtrlvHjO2cQrp9s2MkrXTJ6saCjGUMR
	 EPXBmw6r6sTPzoY6ebxDZcnYdA46KIkVUUKiURoxQDvj36fiCQs0J6E72Xe0cdS7H7
	 SKodssaWEDeF9AbuLWHiC0COSXjep14e+0e7MVh2Em7QWxmWBaf82sl3LAE3Lrya2j
	 9HQ1S7hJNLZuuSi+Sz6SAzv58SSRztDl8mmcSomkIeS1PBHOKLUxhVlEVJ/7jCKNRb
	 Wq9+aaWA6wPag==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Revert "kbuild/mkspec: clean boot loader configuration on rpm removal"
Date: Fri,  2 Feb 2024 22:35:20 +0900
Message-Id: <20240202133520.302738-4-masahiroy@kernel.org>
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

This reverts commit 6ef41e22a320d95a246d45b673aa7247cc1bbf7b.

If this is still needed, we can bring it back.

However, I'd like to understand why 'new-kernel-pkg --remove' is
needed for uninstallation, while 'new-kernel-pkg --install' was not
called during the installation.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/kernel.spec | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c1b745967f64..c256b73cca3e 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -101,9 +101,7 @@ if [ ! -e "/lib/modules/%{KERNELRELEASE}/modules.dep" ]; then
 fi
 
 %preun
-if [ -x /sbin/new-kernel-pkg ]; then
-new-kernel-pkg --remove %{KERNELRELEASE} --rminitrd --initrdfile=/boot/initramfs-%{KERNELRELEASE}.img
-elif [ -x /usr/bin/kernel-install ]; then
+if [ -x /usr/bin/kernel-install ]; then
 kernel-install remove %{KERNELRELEASE}
 fi
 
-- 
2.40.1


