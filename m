Return-Path: <linux-kernel+bounces-144518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09A8A474E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7B91F21A65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A991BF53;
	Mon, 15 Apr 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jBrNmqEV"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4315E9B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713151673; cv=none; b=HmVsFNr4kotauSKG+L6efQ+6yM5mWGxAzQmi63BEVU+TZkJdrkrMEtONgevxzNMWshUnuBauZqcD3lBERdwXQJcPGm8JCuPgzk3V5wR7k55XWfqOS1lC2PN3+ZUiPITBnLG2CFihSN+fVeSyRCvFiEUUFYRAE18Xl0w426dPHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713151673; c=relaxed/simple;
	bh=MyUllvTfBQBfZUtQz7lxs7i6VVrl2wGXBvhPHGAA6gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QcaLTPZOA2Vd14ndp3+56EmhxxY+bxaS6f5ceAvk90uS5sCXJlvxm21Au7Hur6il0mF5GsqBakrW077DYwu04CxyCjhKEvXBLSahv9or8kVRBy1z0pX2HTLoGkkdhagwKqJCHajtPLtg0RID7DOWroj4Wwy9NIoBze1hY6lp35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jBrNmqEV; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713151662; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HQ/ETOKOJmL/IZamalPpP4votWKbCg1bK9n71loVHb8=;
	b=jBrNmqEVEtP1+Yt5PKzTA9tADN4JewqhWol1HgDaaMvrbj+9C2s6s/eUOoi4Zsmzxy+5E45yAk6mD8609q1mUoYdamsbXDbmG0J7lv49cvm8Mkn3nIYrTkVUcLExe8LSVW2T6zNg4FhErqoqTl54Vj+GWiffTYcZKKTAsaIEuRA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4UNuFG_1713151654;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4UNuFG_1713151654)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 11:27:41 +0800
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
Subject: [PATCH] drm/xe/irq: remove unneeded semicolon
Date: Mon, 15 Apr 2024 11:27:33 +0800
Message-Id: <20240415032733.39584-1-jiapeng.chong@linux.alibaba.com>
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


