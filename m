Return-Path: <linux-kernel+bounces-23155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D282A86D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3561C23572
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F87D282;
	Thu, 11 Jan 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UrJ+sutQ"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E8E546
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2szJIaDBzj+c7ED6cS
	ViTt18x//6EWpMlrvnMlbLknk=; b=UrJ+sutQXH2F+w0Wfl3xioDMGDFGNJKX3Z
	m3uqo4FJkNIhuRvYwJWM91miKljoTa86vO3cI+I5ZLdRWtvS+xsOkeuATDxvB1l8
	sP5/ecLo9FtfM9bxeoT/WEXPXi7Wxyr4zxPYRW/NTEvSXxuQU0lxxAxyi2yNjvn2
	smjfkwELA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3P7EXmp9lTOIOAA--.3548S2;
	Thu, 11 Jan 2024 15:34:47 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in trinity_dpm.c
Date: Thu, 11 Jan 2024 07:34:45 +0000
Message-Id: <20240111073445.10405-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P7EXmp9lTOIOAA--.3548S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxtr18JF4UurWkCF1UAwb_yoW8tF43pw
	48WFyYyrZ5Jrs0gayktr9rArna9w1rZ3W8uFWIk343Zw4UCayUZFnYgrWrWry3AFZ7XF1j
	y3WkKrW5ur48t3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwFxUUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBpi1mVOBk6DggAAsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)
ERROR: need consistent spacing around '-' (ctx:WxV)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/kv_dpm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index f7735da07feb..55dbf450bd9c 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -64,8 +64,7 @@ extern void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
 extern void cik_update_cg(struct radeon_device *rdev,
 			  u32 block, bool enable);
 
-static const struct kv_pt_config_reg didt_config_kv[] =
-{
+static const struct kv_pt_config_reg didt_config_kv[] = {
 	{ 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x0000ff00, 8, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x00ff0000, 16, 0x0, KV_CONFIGREG_DIDT_IND },
@@ -931,9 +930,9 @@ static void kv_calculate_dfs_bypass_settings(struct radeon_device *rdev)
 					pi->graphics_level[i].ClkBypassCntl = 2;
 				else if (kv_get_clock_difference(table->entries[i].clk, 26600) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 7;
-				else if (kv_get_clock_difference(table->entries[i].clk , 20000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 20000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 6;
-				else if (kv_get_clock_difference(table->entries[i].clk , 10000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 10000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 8;
 				else
 					pi->graphics_level[i].ClkBypassCntl = 0;
@@ -1577,7 +1576,7 @@ static void kv_set_valid_clock_range(struct radeon_device *rdev,
 			if ((new_ps->levels[0].sclk -
 			     table->entries[pi->highest_valid].sclk_frequency) >
 			    (table->entries[pi->lowest_valid].sclk_frequency -
-			     new_ps->levels[new_ps->num_levels -1].sclk))
+			     new_ps->levels[new_ps->num_levels - 1].sclk))
 				pi->highest_valid = pi->lowest_valid;
 			else
 				pi->lowest_valid =  pi->highest_valid;
-- 
2.17.1


