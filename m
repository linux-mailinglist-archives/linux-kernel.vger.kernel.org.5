Return-Path: <linux-kernel+bounces-144640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C98A48B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34009280FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044D208C3;
	Mon, 15 Apr 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JwKCMWVy"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661E1EB5E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164861; cv=none; b=ZVdKc4mHv0RRBXNal+J45v0ddgwralg/D/Tx6nN8++xJ07nseteezbndIO1WB3WLkXFO1xeChPLAfLwqpnq5r94W0EmF8ePELCBwz5J/TYNoQXsk3RJxXwomBwc097tnv4t4CtMxqNdCWwODvCkNyaV3WEEF7yRFAgddx+Xnlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164861; c=relaxed/simple;
	bh=lGC8Hd/ZfHuggdNJ7W6Fv2MXl9PblSLZMK21JFpc2+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=blWBcztsPzX8+y5lxNPbUWwkVjiE+l0QEHBqJ4vA4dM/dU28l7Qwa0U2UTt4n4rLsAiCLnwLhMLB5ULMaXp3Qdf00d4FtoAh8CFvBMH2xfG7ZlipeiYs3+PpxsNp0/nnqYqPQ7ujFXDOsCwqtseUjwI8rOwp1evxFS1FiHal/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JwKCMWVy; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713164851; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=f78laVDT74bv+AVMGVZViOyOOk+q6lg37f3PWzvCEN4=;
	b=JwKCMWVyY+J/FzE+qDRuBcyWZrDCwN4heGSus5vqlpxCzYQfdJh3vlZt/yjnBwpbQR5SoL4HEq06ntDKTnA+5U80zFKj6jeEvex+tcO15JkX3r10cj5rOJ0LS2wCGPPX0IVSzFXbm+vlBj/qBmWhBXUcWTf0P5EYUxtjyalPucA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4WgZ8V_1713164843;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4WgZ8V_1713164843)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 15:07:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lucas.demarchi@intel.com
Cc: ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] drm/xe/irq: Remove unnecessary semicolon in pick_engine_gt()
Date: Mon, 15 Apr 2024 15:07:22 +0800
Message-Id: <20240415070722.5131-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

/drivers/gpu/drm/xe/xe_irq.c:279:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8757
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Make the commit message more clearer.

 drivers/gpu/drm/xe/xe_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index 996806353171..5b1a2f46a1b2 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -276,7 +276,7 @@ static struct xe_gt *pick_engine_gt(struct xe_tile *tile,
 			return tile->media_gt;
 		default:
 			break;
-		};
+		}
 		fallthrough;
 	default:
 		return tile->primary_gt;
-- 
2.20.1.7.g153144c


