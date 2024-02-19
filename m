Return-Path: <linux-kernel+bounces-71273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC285A2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DA21F243FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603202D051;
	Mon, 19 Feb 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CTItosMf"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101662D04B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344113; cv=none; b=pj/kVYeu9DfRpISskIYPKB3YlcQjeWqwPU1yEs46CW+pZxRJ3ScAwM+ODOpk8w7vTK8lucEGdvn1dv8lg8P5tas4PA644bTn8pS/ofapbJM+UwMJjxNV7YxIF3Ag1d/db0rWxcgSIPagm5AQgJ7E02o5WPLIqUX439676cfgZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344113; c=relaxed/simple;
	bh=Qd+RI16juGVjN7zrBNOH3Q/KIOhwUI6VbC2DgVyOadg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qeD2gKBfnzyxvW+EDjBW/06f2eHMo4qSJd9tj548nTnVttkzNwG5nkZf0bFrZsIERmk/em4Arzt9kvH26/QleqIbUBTzGtyGLuM68lXpngE/F+tiq1GD3iR26AyHLGuYvOp/bAhQiAo4zqRQ7dKz7SQ+mVR10lt6ijZTyE/NDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CTItosMf; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rWWze
	ynqvpKTE8wM5BvJ7WhI4cRh2jw6a0Kbi0ZwsdA=; b=CTItosMfLTdC8dozrCo38
	53GssiMoHJxhFpmG1TKAPgS1VoVYZ8So0Fzs99MPM0SPLMcfa7YmoHjQ8BQ4dXVw
	rGsCo0ETcFLt+lpM32nsWFw1HWIyK2yyCGi9DpdbSBImo6qmpahm6s0+wjUthBE+
	QReLqTb/JJkUsC47UeLe6g=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wCnzosNQ9Nlm_S7Dw--.54357S2;
	Mon, 19 Feb 2024 20:01:21 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	s.hauer@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Remove AR30 and AB30 format support
Date: Mon, 19 Feb 2024 20:01:15 +0800
Message-Id: <20240219120115.1306717-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnzosNQ9Nlm_S7Dw--.54357S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47XrWkGr4DZw17ur45KFg_yoWfuwcEk3
	47X3Wfur4xCrn8Jw12y3y7WrZFy3WI9Fs2ga9Yyan5AF1vvw1rXFy0vry7Gas8JF42kFs7
	GF1jqry3CFn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBKJXmVOCUBxqAAAsW

From: Andy Yan <andy.yan@rock-chips.com>

The Alpha blending for 30 bit RGB/BGR are not
functioning properly for rk3568/rk3588, so remove
it from the format list.

Fixes: bfd8a5c228fa ("drm/rockchip: vop2: Add more supported 10bit formats")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 48170694ac6b..18efb3fe1c00 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -17,9 +17,7 @@
 
 static const uint32_t formats_cluster[] = {
 	DRM_FORMAT_XRGB2101010,
-	DRM_FORMAT_ARGB2101010,
 	DRM_FORMAT_XBGR2101010,
-	DRM_FORMAT_ABGR2101010,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XBGR8888,
-- 
2.34.1


