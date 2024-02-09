Return-Path: <linux-kernel+bounces-58925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D108984EEB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FC1F26E61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B75C89;
	Fri,  9 Feb 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Jd8arB0i"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF34C98
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443936; cv=none; b=u/EaKnthXqCj5wSl7e6LtafLXkmXk3haacbcp66/UYfHRXjewj2tPTdLvOLmgPjVnJ8IBq15GkIF3vCn4zH4ETsoMNpUi0S1b6oDKIQBLs1qzfvocf0ILk8WPmBXO8/xfXvY/fH/qsgLLTzY+zcPHCtQncp/qL2wLC02hS2/cF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443936; c=relaxed/simple;
	bh=9K4qlpEjpmKzBQgUkXVOyjVzOou7v33BoUG8m6CCbGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfzgjyto8YJ5DciCs88kurPr0h1e5vgs4+cPgqQ7+stMq6XK2WNVrtXxThnTgxqwCTHhGeExiaIffgInEzkuQT5fDZyC3VlhIrGPxcWzv2Yucwg93LT8eIuxz5Lzz1UtJMkQvh/mPVZoyj/cTCl/88fQcB6JghCAGYaz9hkRn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Jd8arB0i; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=hIePBzSeO/3D5e76oY9PllApDN+OlYoSau4JtfpyyAk=; b=Jd8arB
	0i5IIIb0whlyKCAitOeYKO1e7xb+GvxxzHcNJ5DKkhmkybovHTeuPK7r9ojaZ2aU
	CpnWUxAFKB1/6PCrDrnbQ2kQc0vcNH2wEn0rFZ5CrA5bmBMt/7Pn66V8puLBNg9h
	BdL9loFJI/xBSBM3m+R8V1RH7g1s4VgBvLLzWSkGe+DuVrj+rzhXsYNpQtxMGTWu
	w/VMNozjtDk0iVULKmdrXMCUq6UboeoP8VuRkWi701M0A3Lva9cQiq+44+C3dSCh
	FzPAvuzvJxNkgr2na5+7VqJi98JBaCDacvKeHm3g8p3vrXgRZ8jp2fOdehLdU/Gc
	rU2drZp6BMsFEaLQ==
Received: (qmail 2792299 invoked from network); 9 Feb 2024 02:58:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 02:58:45 +0100
X-UD-Smtp-Session: l3s3148p1@TGKaROkQdLMujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mfd: tmio: remove obsolete platform_data
Date: Fri,  9 Feb 2024 02:58:16 +0100
Message-ID: <20240209015817.14627-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 8971bb812e3c ("mfd: remove toshiba tmio drivers"), all users
of platform data for NAND and framebuffers are gone. So, remove
definitions from the header, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mfd/tmio.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index eace8ea6cda0..bc53323293a3 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -103,31 +103,4 @@ struct tmio_mmc_data {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-
-/*
- * data for the NAND controller
- */
-struct tmio_nand_data {
-	struct nand_bbt_descr	*badblock_pattern;
-	struct mtd_partition	*partition;
-	unsigned int		num_partitions;
-	const char *const	*part_parsers;
-};
-
-#define FBIO_TMIO_ACC_WRITE	0x7C639300
-#define FBIO_TMIO_ACC_SYNC	0x7C639301
-
-struct tmio_fb_data {
-	int			(*lcd_set_power)(struct platform_device *fb_dev,
-						 bool on);
-	int			(*lcd_mode)(struct platform_device *fb_dev,
-					    const struct fb_videomode *mode);
-	int			num_modes;
-	struct fb_videomode	*modes;
-
-	/* in mm: size of screen */
-	int			height;
-	int			width;
-};
-
 #endif
-- 
2.43.0


