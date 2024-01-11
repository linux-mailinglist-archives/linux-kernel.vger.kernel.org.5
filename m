Return-Path: <linux-kernel+bounces-23129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53182A80D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E152B1C22174
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9AD27A;
	Thu, 11 Jan 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T5rcyGSR"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF4D262
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=FRfjuPEp7SDJ4XD3M8
	xRYyAIebQ9Wi4nXcaxaXpRxH8=; b=T5rcyGSRRbf63M3pk5j3zAvxuwtPbywgdp
	ahJzFUjwD0t0TILrKH1bqysEGeNSdelENEL7NzyVmj6G04iYsuA4cUYu3zQL8tWU
	Bhr1ud1a27TMD/uvcIKLhjjG9uykcq54Ca6FSE45NFQqyv/D5BffvMEyik1dZW2V
	QQzkET2fs=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3PxKOlJ9lRoMNAA--.3099S2;
	Thu, 11 Jan 2024 15:11:10 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: mripard@kernel.org,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	zackr@vmware.com,
	tzimmermann@suse.de,
	daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/vmwgfx: Clean up errors in vmwgfx_streamoutput.c
Date: Thu, 11 Jan 2024 07:11:09 +0000
Message-Id: <20240111071109.9779-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3PxKOlJ9lRoMNAA--.3099S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw15uF48Zryrtr1kJw15twb_yoW8Jr48pr
	s0k345Kr1SyFy7tFyjkasYqF9093WkAFyI9ry5u3sxZw12kr18tFW5JrWFyr98GF43Zan8
	JF48t39rWry8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UF38nUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBNi1mVOBk3hWAABsv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
index edcc40659038..3daff9537bf8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
@@ -96,7 +96,7 @@ static int vmw_dx_streamoutput_unscrub(struct vmw_resource *res)
 		SVGA3dCmdDXBindStreamOutput body;
 	} *cmd;
 
-	if (!list_empty(&so->cotable_head) || !so->committed )
+	if (!list_empty(&so->cotable_head) || !so->committed)
 		return 0;
 
 	cmd = VMW_CMD_CTX_RESERVE(dev_priv, sizeof(*cmd), so->ctx->id);
@@ -363,6 +363,6 @@ void vmw_dx_streamoutput_cotable_list_scrub(struct vmw_private *dev_priv,
 	list_for_each_entry_safe(entry, next, list, cotable_head) {
 		WARN_ON(vmw_dx_streamoutput_scrub(&entry->res));
 		if (!readback)
-			entry->committed =false;
+			entry->committed = false;
 	}
 }
-- 
2.17.1


