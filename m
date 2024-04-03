Return-Path: <linux-kernel+bounces-130367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A3897897
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01ABCB37CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3CF16F906;
	Wed,  3 Apr 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ELnJhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866D16F8EC;
	Wed,  3 Apr 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164846; cv=none; b=OP5whj2GvB4IC/Fec6yzpDF9FsUyOPhsZZDtv3B1XyY0ywXDzYC91ne0UufVmqsAfBDdyJi3QoXos5PZOxNRZQYdvokdm6m7LBPTCI+TXSRxIGirXIwQZdeDH4+W8t2ejLKwWUUEuFKLj+y6iOgWjPq1EZXtugc4zjMkctZyEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164846; c=relaxed/simple;
	bh=b/MGW6VFVIb38l7fDj2wuOZ7BQMsikKluRpkQVd+jKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsWcXgvD4TD37K8rCPqQJsp4u5G7X4Sk9Y98ufARqCtp0ON3Xb53LdHEDRcXYel21HgZyD3Y7WTkUtN3VySFMm49b3BnQK74VNN6biMtBkJkNYCgC4MO+xW9YlXSDk+ZQvqe/w0LkRJmXt7cRGUHe3gco1utyLLjhH6tvRfnPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5ELnJhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6162C433B1;
	Wed,  3 Apr 2024 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164846;
	bh=b/MGW6VFVIb38l7fDj2wuOZ7BQMsikKluRpkQVd+jKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5ELnJhEcHPkn+aLUu/rwIMPDBO6TVVcV6sJdii24KK/qSay8DpGc3ycdUnVv9zom
	 SNcGGNdJDijNOkmib4BUiCuKYeCpuTTue7VAIHdnyGXfwe3T2qyS+EJHD+3iid44wG
	 V4P95MmeZHbfV7W+dbWsFMiGa1ZgLuZ9GZIZS7ImnpFLy1RAT2M/oqLCkMSxt2cJvj
	 G9J5GucnE45VaauVoj3hWLfKnx8Rh8OgggUsfkuB0iEM052guSRrL2AHVsBf68X6Lo
	 Ty3UUSS1EvftljzxNNEWsksd9nZewTIYuYYqdzdV9lbzSZrL61If4x0/7mB+K98llE
	 ZHOwmG51CnILQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	FlorianSchandinat@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 4/5] fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2
Date: Wed,  3 Apr 2024 13:20:37 -0400
Message-ID: <20240403172041.354877-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172041.354877-1-sashal@kernel.org>
References: <20240403172041.354877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index eb3615c69987e..f542b01568df9 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -129,7 +129,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 
 	if (op != VIA_BITBLT_FILL) {
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -274,7 +274,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x18);
 
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
-- 
2.43.0


