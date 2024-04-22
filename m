Return-Path: <linux-kernel+bounces-154270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985208ADA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370FC2871C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230E316192D;
	Mon, 22 Apr 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAX6XeOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D98161305;
	Mon, 22 Apr 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830187; cv=none; b=Z4Jo3mJ155ASo8w5HxDFxhGU7wpbP8jf47J4kmOwMlxy68qd6f/ODeYyP5LIW3QzklL1S3VhiCZj/lhrpEDwiAPvPAVLHXZsqwB8yzyuAb/8930O7lBC/K3XSKcU1Uu5B7Vq19HChNepLhQH6NcwbyFUsIeEf/JcxBGACP+kIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830187; c=relaxed/simple;
	bh=P27UnTmy6IWo4KqJtsg6h0+k3t/WMu6SHlGNvklgRtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/TuhUKpHWIS0dCypQARN2iPrKS13v069LP/vnVbEoXkxjPFJ6G+yqj68ihlvNIE9o2RWYdPBfgknJv0vtV4h3ykvcswmbjS9UiXppbHVqMEGMcs/Mv/QzhREYpWh0VetEnODrT8BT0Mf1kZRPId0cWUtC//K9bNtXeI5meoc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAX6XeOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52261C113CC;
	Mon, 22 Apr 2024 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830187;
	bh=P27UnTmy6IWo4KqJtsg6h0+k3t/WMu6SHlGNvklgRtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAX6XeOMHTg5wUdjDUaWWKT5K5Tc5oyi7mytj3DE6+fDSNXXKqsmYSzcMLoYS7H6K
	 HvjoWIUmSuit3Ru6q8pP57HWC6GVu1H6fkqvPgglvQaeepKXec8WCX8DEx7nO3M0h+
	 4abaoRCFPPW1Nr0b0B+C6s8IBdADbl/WFOUbZ3TSryNuEalXdrBkeJKUbNQriey11G
	 vb/Cc2QMtGmBu8wY/yiosMn/IjiBHM/TuPE1roPSH2Pxn4OODP21kJ4RQpIltdqFC6
	 MmQK3BhgZu4VJ3W6q4MsuwDbyrbsoJSmDJADjsUJ0CZN9AUITIZpQp/M1XDNNbSqwP
	 fIRMvhn14CabA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 09/29] memblock tests: fix undefined reference to `panic'
Date: Mon, 22 Apr 2024 19:16:50 -0400
Message-ID: <20240422231730.1601976-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit e0f5a8e74be88f2476e58b25d3b49a9521bdc4ec ]

commit e96c6b8f212a ("memblock: report failures when memblock_can_resize
is not set") introduced the usage of panic, which is not defined in
memblock test.

Let's define it directly in panic.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Song Shuai <songshuaishuai@tinylab.org>
CC: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240402132701.29744-3-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/panic.h  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tools/include/linux/panic.h

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2e..07cfad817d539 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/math.h>
+#include <linux/panic.h>
 #include <endian.h>
 #include <byteswap.h>
 
diff --git a/tools/include/linux/panic.h b/tools/include/linux/panic.h
new file mode 100644
index 0000000000000..9c8f17a41ce8e
--- /dev/null
+++ b/tools/include/linux/panic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_PANIC_H
+#define _TOOLS_LINUX_PANIC_H
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static inline void panic(const char *fmt, ...)
+{
+	va_list argp;
+
+	va_start(argp, fmt);
+	vfprintf(stderr, fmt, argp);
+	va_end(argp);
+	exit(-1);
+}
+
+#endif
-- 
2.43.0


