Return-Path: <linux-kernel+bounces-144134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D008A4239
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A581C21005
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAF3D994;
	Sun, 14 Apr 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cR5Oet6S"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBC3C46B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713096583; cv=none; b=Jjvg1gOr5KovOt91+7/W2fv0wVzd6xXxW2HaYWIYfD3Gn04jZORyLnJ8GkKDHsn4E1qh+blTvhkMdhbyFxRQlP3PHa4K43749DsA4inykCwt/0h65W1NAkao5/sxsDm5wjgTRvZBmwcqA82YHMZymFu3laQRnizQFnLaz5dz6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713096583; c=relaxed/simple;
	bh=LXjCc3+VvARaQ5IeRiw3JYFQzmvMmTdn3DXxQgPIVrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgsV4Q/VlHEZm8yFdP7NO0n+7WkyFt92EKkbpkQLqTrxRMRECYchxj369YVdzJmQi3fa3JMFO7Oq32Gdtt9LAld3x/jwaPjJhzvcn7/HyrtzuEb6J7Vck+AG7KDEoMyZvf9LLK2FJqsgy5TDJ2AUt5NBIo6hoSC8M/aq9dDyBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cR5Oet6S; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HNiS1
	KMxrrJC1nczoSnnrRUJUsfXNR6TsxaQz8HCQsY=; b=cR5Oet6S0/nyjW/jd9cSl
	Rl4NYL6vCrDFVGIBRN9+95M19ppZFYYI88fgtE+3DFbeIfWpOWEWS5tQvrbXBbKN
	kCx26AO7Bcb8wmuCe13C1/1PG4wUpQX3/3jm87BKIRcH9/WjeUxlTczI3MFeZstY
	zE9dTqFtzJcXZ6u3fzKyTU=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDn7yFKxxtmItV9BA--.26437S2;
	Sun, 14 Apr 2024 20:08:46 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: lvds: Remove include of drm_dp_helper.h
Date: Sun, 14 Apr 2024 20:08:41 +0800
Message-Id: <20240414120841.837661-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7yFKxxtmItV9BA--.26437S2
X-Coremail-Antispam: 1Uf129KBjvkXoW8ZrW5Jryxtw1kKr4kAw1Dp5X_Zr45panxCr
	yUJrWfGFWjq3WqkFnayrZ0ya1kAa97Kr97W3ZrZ3W7tFy7Gwn5uwn5XrnxXr47Za1Y9rZr
	Ja45AF47Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy29KBj
	DUYxBIdaVFxhVjvjDU0xZFpf9x07jV89tUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h3AXmWXxJbtmgABsH

From: Andy Yan <andy.yan@rock-chips.com>

drm_dp_helper.h is not used by lvds driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 77b76cff1adb..9a01aa450741 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -17,7 +17,6 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
-- 
2.34.1


