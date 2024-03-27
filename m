Return-Path: <linux-kernel+bounces-121134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79588E2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0411F2CB00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DE175574;
	Wed, 27 Mar 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCcelS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A17175569;
	Wed, 27 Mar 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542167; cv=none; b=Z6n6UBATuE2J54muYQI4l3qY06W3Tn2kmJLHqXNGeVyUtJZU9VcIdL8Xart/z0pVwS/Re6ZmOmOBy6SFQIIV0N05cETiXXaR/RdlcnQq9IfUNQNBjlUxDEsbphlM9Hp/DjAX0cwuXHwXvSBzd3bUvxn0+m2i4bORFwgBbJ2cpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542167; c=relaxed/simple;
	bh=spDWDPd/dlIwz2jPQOOv3QYSRiK5aiSBNfx9Tos4VRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/W4TgFg/NE+xpkHsG7MehWdYhm8oT5KU2OpUvpvfEpKXL2itCVbDl2WYhykIORb1c6K9PX6PvdqxO9Xq7Gs2g1nmy5PJJ+r0JYAOw2UP1Hkiiy/mr3s0HOfcYD8cktAs/grs0g+3DuFpiy6uyrWO6uaHE8qD1fj22zySd6EfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoCcelS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E70C43390;
	Wed, 27 Mar 2024 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542167;
	bh=spDWDPd/dlIwz2jPQOOv3QYSRiK5aiSBNfx9Tos4VRY=;
	h=From:To:Cc:Subject:Date:From;
	b=AoCcelS57NWJrSsTXkrT1TDxtDfnOt2W7gzDqwFfYSk9dMbYUMgnsAida03v35kve
	 N57nSw1Memz4vvO/+U62NjGGaCcHGTrQXlBDkyhlnrRI/wYaEB4jsHqcrz8fEv4NxF
	 AyGDXDAlrDt+hU+CY5yLpbAJdlOB1VI92yElPYXuy7cUbjfFiRS2qjUJ7CYu7vCx1p
	 Vx1MjU/z8ANCATModh9kuOwfd7L04vjApN+UOMtbj8jzXTdMWQr/Gm2z0KW4aAqEY5
	 /D7nApLNj50n2xFlP5eSur2ATJk7mMpbmuK87hQ5AckS2tlgHkrmgP98HzIkOut/2U
	 jmwcBjWg8EV7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zack.rusin@broadcom.com
Cc: Niels De Graef <ndegraef@redhat.com>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/vmwgfx: Fix possible null pointer derefence with invalid contexts" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:45 -0400
Message-ID: <20240327122245.2837938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 517621b7060096e48e42f545fa6646fc00252eac Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 10 Jan 2024 15:03:05 -0500
Subject: [PATCH] drm/vmwgfx: Fix possible null pointer derefence with invalid
 contexts

vmw_context_cotable can return either an error or a null pointer and its
usage sometimes went unchecked. Subsequent code would then try to access
either a null pointer or an error value.

The invalid dereferences were only possible with malformed userspace
apps which never properly initialized the rendering contexts.

Check the results of vmw_context_cotable to fix the invalid derefs.

Thanks:
ziming zhang(@ezrak1e) from Ant Group Light-Year Security Lab
who was the first person to discover it.
Niels De Graef who reported it and helped to track down the poc.

Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api")
Cc: <stable@vger.kernel.org> # v4.20+
Reported-by: Niels De Graef  <ndegraef@redhat.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240110200305.94086-1-zack.rusin@broadcom.com
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 4c22fe7ec79b7..cc3086e649eb5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -447,7 +447,7 @@ static int vmw_resource_context_res_add(struct vmw_private *dev_priv,
 	    vmw_res_type(ctx) == vmw_res_dx_context) {
 		for (i = 0; i < cotable_max; ++i) {
 			res = vmw_context_cotable(ctx, i);
-			if (IS_ERR(res))
+			if (IS_ERR_OR_NULL(res))
 				continue;
 
 			ret = vmw_execbuf_res_val_add(sw_context, res,
@@ -1266,6 +1266,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
+	if (IS_ERR_OR_NULL(cotable_res))
+		return cotable_res ? PTR_ERR(cotable_res) : -EINVAL;
 	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
 
 	return ret;
@@ -2484,6 +2486,8 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
 		return ret;
 
 	res = vmw_context_cotable(ctx_node->ctx, vmw_view_cotables[view_type]);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 	if (unlikely(ret != 0))
 		return ret;
@@ -2569,8 +2573,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 
 	so_type = vmw_so_cmd_to_type(header->id);
 	res = vmw_context_cotable(ctx_node->ctx, vmw_so_cotables[so_type]);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	cmd = container_of(header, typeof(*cmd), header);
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 
@@ -2689,6 +2693,8 @@ static int vmw_cmd_dx_define_shader(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXSHADER);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.shaderId);
 	if (ret)
 		return ret;
@@ -3010,6 +3016,8 @@ static int vmw_cmd_dx_define_streamoutput(struct vmw_private *dev_priv,
 	}
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_STREAMOUTPUT);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.soid);
 	if (ret)
 		return ret;
-- 
2.43.0





