Return-Path: <linux-kernel+bounces-114876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0348891EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB91C2D595
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56E177984;
	Mon, 25 Mar 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrBRfX3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036C177AB1;
	Sun, 24 Mar 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323528; cv=none; b=l+/7257/3hkZUO1OEsncLFu3W36j843e3hQ4rGxyzRFpo6ri8+ckGdL9i9ptnmMH6MIwJMzH1CzKS/ILFN8YOEy3NSNGENouHaE++eKUQ1KB+rJufYZcKXHCGAn5ibycowTZ4AvM1e/YMNx/C82heUj4nJRTgYyGvZwhHMM7iFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323528; c=relaxed/simple;
	bh=WCiukRHj7sAuP3hE7d5o0u3GaeKd5aqEKoNYID1yjNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsKTLGAV76QunEwyulvKQpQ0p7AsVylMGSxrEdIuIXucDbsA0Mr4NiaWRYgClThGyo6VncA6PIEnaE4iRBpLbVRVj6sY5wr9RZFzz/NMhEa9opTNS2dH9u8TismxcmU+9tP8VMdWx8FxfO4KiM3twkvs39Fryg5j6BlBmmkgepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrBRfX3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267AAC43399;
	Sun, 24 Mar 2024 23:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323526;
	bh=WCiukRHj7sAuP3hE7d5o0u3GaeKd5aqEKoNYID1yjNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrBRfX3iCGiMBfUQdNiqBskUsAhQW1CBrFH040ns065BKbrNOElRD7/AJlTGdUUYA
	 as/h56sWoRtotegAK09ObLu6FjafK9fUFQLQ1EahceQILgo+juW6CmOcFytPBq9Xdm
	 iTtg7dPoey20ArF/ggHvclt5DZTp0RH17xIQ2mUz1tSBa3ak0HfBC+RtIpQx4APFll
	 RrWa36lse8T6Kmt3qqr2434c7z64ehQmB5kptTDgontStdWy9F4tHZekWoWD7N041D
	 zM1arFbvdNfy+jmH2GDUtVzNY9pvFIbmQqiq+yij5ELW/GrOoWbztbgJycE/r6zKxG
	 zg+M3dLPnL03Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 234/317] media: mediatek: vcodec: avoid -Wcast-function-type-strict warning
Date: Sun, 24 Mar 2024 19:33:34 -0400
Message-ID: <20240324233458.1352854-235-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bfb1b99802ef16045402deb855c197591dc78886 ]

The ipi handler here tries hard to maintain const-ness of its argument,
but by doing that causes a warning about function type casts:

drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: error: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   38 |         ipi_handler_t handler_const = (ipi_handler_t)handler;
      |                                       ^~~~~~~~~~~~~~~~~~~~~~

Remove the hack and just use a non-const argument.

Fixes: bf1d556ad4e0 ("media: mtk-vcodec: abstract firmware interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c          |  2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c | 10 +---------
 drivers/media/platform/mtk-vpu/mtk_vpu.c              |  2 +-
 drivers/media/platform/mtk-vpu/mtk_vpu.h              |  2 +-
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c b/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
index b065ccd069140..378a1cba0144f 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
@@ -26,7 +26,7 @@ static void mtk_mdp_vpu_handle_init_ack(const struct mdp_ipi_comm_ack *msg)
 	vpu->inst_addr = msg->vpu_inst_addr;
 }
 
-static void mtk_mdp_vpu_ipi_handler(const void *data, unsigned int len,
+static void mtk_mdp_vpu_ipi_handler(void *data, unsigned int len,
 				    void *priv)
 {
 	const struct mdp_ipi_comm_ack *msg = data;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
index cfc7ebed8fb7a..1ec29f1b163a1 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
@@ -29,15 +29,7 @@ static int mtk_vcodec_vpu_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
 					   mtk_vcodec_ipi_handler handler,
 					   const char *name, void *priv)
 {
-	/*
-	 * The handler we receive takes a void * as its first argument. We
-	 * cannot change this because it needs to be passed down to the rproc
-	 * subsystem when SCP is used. VPU takes a const argument, which is
-	 * more constrained, so the conversion below is safe.
-	 */
-	ipi_handler_t handler_const = (ipi_handler_t)handler;
-
-	return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
+	return vpu_ipi_register(fw->pdev, id, handler, name, priv);
 }
 
 static int mtk_vcodec_vpu_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index af59cc52fdd73..e282bbae8f668 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -635,7 +635,7 @@ int vpu_load_firmware(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(vpu_load_firmware);
 
-static void vpu_init_ipi_handler(const void *data, unsigned int len, void *priv)
+static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 {
 	struct mtk_vpu *vpu = priv;
 	const struct vpu_run *run = data;
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.h b/drivers/media/platform/mtk-vpu/mtk_vpu.h
index a56053ff135af..da05f3e740810 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.h
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.h
@@ -17,7 +17,7 @@
  * VPU interfaces with other blocks by share memory and interrupt.
  */
 
-typedef void (*ipi_handler_t) (const void *data,
+typedef void (*ipi_handler_t) (void *data,
 			       unsigned int len,
 			       void *priv);
 
-- 
2.43.0


