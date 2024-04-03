Return-Path: <linux-kernel+bounces-130355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28535897717
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9DE1F2F155
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618D16DEC7;
	Wed,  3 Apr 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsA9JWnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A016DEB2;
	Wed,  3 Apr 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164816; cv=none; b=oKhGPiNkkP5UU7w2HDV9uVFQLPntAnutKcjNDS6nXcupd6unnW8ks8d3nTvZoDUve55WVRBAb4t6Aqo1T2YU4Ma1OW81i8RDpOZWbwiVdqF1sjKfDSLEmJ8/Q5OELdK5etC/Bll/Gui8/r8sHCro+uNJJl8QqMRAeq9GgjddP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164816; c=relaxed/simple;
	bh=KGum2UiFM/XeeIttcKMIY9uAmatsd+1YLL7DOdMp7+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A90uk+jofOQNYL//ruELm+/683j+66hGJfXQeZxekkQUtjCka3LC5L/ZK6yx6zoYfOlfewxT1KUnBn0WQ/sAeW3+66Exb62l1lw8wqIGnw/hXNGLLT8pyH98SvnRPoh3Qz4oldk0vKitRC0KktYS1PoHUUQuuk16tFGhF91TIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsA9JWnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B7AC43394;
	Wed,  3 Apr 2024 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164816;
	bh=KGum2UiFM/XeeIttcKMIY9uAmatsd+1YLL7DOdMp7+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsA9JWnIt38BQ1V1Z82DSwbssq4w3UDVfbA+tdwV4U7mcyN1hsjBXjnK0we3LNbgp
	 IhhBPYrGqNpAI30jeFhTziRj+Ww+Dc/2OI3SdQjKlT1AMDyhgsFYHyanVEXvUDjFeI
	 KnUvB+szNdMOQXGhaXIG+uuc2WAx7RFOsNFptH5Yy0xFoLUxgZJjWaXNGC2jmJ1Lfb
	 E7boOvJ/CUiL69Qxqe28Xvd+4XWdHATj0XAW2uBTt9BcMyviqIvf6QPF203bQYnEC1
	 oBO4oxCCOjBxNh3HE90En9XCD0/DBooGYA4qGbKjZO8MKsQzkV3Chdjd0hPcxIzuS9
	 zDYuDgSz/UOJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	FlorianSchandinat@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 6/8] fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2
Date: Wed,  3 Apr 2024 13:20:00 -0400
Message-ID: <20240403172006.353022-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172006.353022-1-sashal@kernel.org>
References: <20240403172006.353022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Aleksandr Burakov <a.burakov@rosalinux.ru>

[ Upstream commit bc87bb342f106a0402186bcb588fcbe945dced4b ]

There are some actions with value 'tmp' but 'dst_addr' is checked instead.
It is obvious that a copy-paste error was made here and the value
of variable 'tmp' should be checked here.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/via/accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/accel.c
index 0a1bc7a4d7853..1e04026f08091 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -115,7 +115,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 
 	if (op != VIA_BITBLT_FILL) {
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -260,7 +260,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x18);
 
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
-- 
2.43.0


