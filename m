Return-Path: <linux-kernel+bounces-143744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B018A3CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DFE1F21B57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C545038;
	Sat, 13 Apr 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Px4/kXuk"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F81AAC4;
	Sat, 13 Apr 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017058; cv=none; b=UrfXhqbEUFjUJ2R2fsVZQ/gjR3G+abPvk2nBTf8a67qqzFTl4Vqx+M3MnBcxYKIovQXyE588fH82ogrr1LxEQdvGZIqgg8ViajZm6kuhxxMSgV1i/v4er3bw947Uhb8qQHiLPgyAhvALOrLz5/2HXCJDDiHTc4imI/lH20Til1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017058; c=relaxed/simple;
	bh=5hJR7Ru+XomF3n9mKOm3xJbma6kZ/IDKC9EDikaVd44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LClhMqAxkpBCp0Rw26AXM2HpQc90hWdOzo/MRlwKTZU35Iw0StdhaW2hkumLebCPHwsyhSf0Om7zp6VTDQMyzpxjpyHN3SnaHuMsmRICU5g5KZHve5Vl5+fmKGCEKBgcySiJ02Dedg9VUNoo6W57r/KnXUU+loS5TIxViK/bGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Px4/kXuk; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vdzDrkNrdPlGBvdzDrdQ2P; Sat, 13 Apr 2024 16:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713017048;
	bh=3oXb08cbb/bJvN3axG/lDrCM0AQ1pV4xL9cabkqd+XY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Px4/kXukbIVdawoPCnGeFXq5hFouWEazH/Vd0PDBOLsLIGmjy0ZTgwNyGJ29vNcA/
	 Rm6qttTSqG7UrcPAgeYfg/rKzlqBlh4/bup6XJN8ZvnhP/zVhMwaToC3ZeqIZ+L5oF
	 BovCUBT3Vnk/DyQ+VIcM/QDJbwTLH1p6PR/oSVoj3bvt6M4jPO/WwOH85p6UyFkJT1
	 GTatqb8PuBBNgyrCckZ5rJGtDFBeYtAA/bi5Z6DrtkaAs3hN+m2y0Rm3Xk5YRCB6iq
	 gGZ+i34W4xymcT/GQDUWWxRSbg4DfCbrqn7/adTBUNzHTtO+4mtFSFWOJwUjBKkvqx
	 XbyaLAO4XPxlg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Apr 2024 16:04:08 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: qcom: rpm: Remove an unused field in struct rpm_cc
Date: Sat, 13 Apr 2024 16:04:04 +0200
Message-ID: <9f92330c717e6f2dab27b1307565ffb108c304a7.1713017032.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct rpm_cc", the 'rpm' field is unused.

Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring.
---
 drivers/clk/qcom/clk-rpm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index 745026ef4d9c..9da034f8f2ff 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -98,7 +98,6 @@ struct clk_rpm {
 };
 
 struct rpm_cc {
-	struct qcom_rpm *rpm;
 	struct clk_rpm **clks;
 	size_t num_clks;
 	u32 xo_buffer_value;
-- 
2.44.0


