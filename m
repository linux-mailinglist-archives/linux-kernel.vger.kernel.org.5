Return-Path: <linux-kernel+bounces-115709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA888972A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3065F1F3630E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6C20C03E;
	Mon, 25 Mar 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0/swgzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A2214849;
	Sun, 24 Mar 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321739; cv=none; b=miwCmPu205QL5+uXBG1j0vji4zOgEuTnmX8KWdBY0LTPLc0qKikOceZjtjEr1SNzUuuiI+S99I7Ju268ufNfuUwsVBaXbQO6hv0E1VAg9LS6Rd0+1+DM+SidGR3eAmboXJmUV06N5ltuJZ92B+yUgjR8I2h61zeQbY1LvbY373Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321739; c=relaxed/simple;
	bh=ZImlfLx5LP+b1B5p0xTZ5FuzC/pPyNOKVABol0VrAbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqE+RsLKh5HaI7cl1g+VGqgeb8Ai4pKwFSkBrezQ5Ki274f4SmSsXNWoa7slXc02aK0AaSeAYbs7MJYB1+FA7a+PVqurKAUOa+JvrdOYhI5A5kq06JLkeeHO/ylnFqBXo1ZCqo3a3/HeQ6OtBO8GFGbDenROvcZlZ9+IQ6cPbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0/swgzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547F7C43390;
	Sun, 24 Mar 2024 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321738;
	bh=ZImlfLx5LP+b1B5p0xTZ5FuzC/pPyNOKVABol0VrAbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0/swgznZU+2gNvgW3Cxq0wNOK1zGP19GLXRjcOAysCIlmHkzx45jidtL0OqMBmdK
	 NdaXgPafUks7PjixfhZhYNvgMMWRBE5s2z0ZpFSUDBzibSoj47tbRIm2BV5pyjckjd
	 auX44otWh1gZbKMmkJI67WSEIjvetZI6B070sHuz/UNm7owrBwd5SwWxU1pxZbiw7u
	 JptANArFKnb8JlXJ+qXzsEFOU00z0Ia8VGiPN0C03Qq6DyuuKTwrT06wbgJG/8SjK5
	 AcWEp5ErB1NFT0eY+EfvKLkHp/TIcKXd/IJieUyZVzgLVcBHlWiN3LhzEtRbh1RKES
	 KQkJkNVT4flCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 466/638] media: mediatek: vcodec: avoid -Wcast-function-type-strict warning
Date: Sun, 24 Mar 2024 18:58:23 -0400
Message-ID: <20240324230116.1348576-467-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
 drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c      |  2 +-
 .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c         | 10 +---------
 drivers/media/platform/mediatek/vpu/mtk_vpu.c          |  2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.h          |  2 +-
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c
index b065ccd069140..378a1cba0144f 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c
@@ -26,7 +26,7 @@ static void mtk_mdp_vpu_handle_init_ack(const struct mdp_ipi_comm_ack *msg)
 	vpu->inst_addr = msg->vpu_inst_addr;
 }
 
-static void mtk_mdp_vpu_ipi_handler(const void *data, unsigned int len,
+static void mtk_mdp_vpu_ipi_handler(void *data, unsigned int len,
 				    void *priv)
 {
 	const struct mdp_ipi_comm_ack *msg = data;
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 5e03b08865599..0849ffb0dcd45 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
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
diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 7243604a82a5b..724ae7c2ab3ba 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -635,7 +635,7 @@ int vpu_load_firmware(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(vpu_load_firmware);
 
-static void vpu_init_ipi_handler(const void *data, unsigned int len, void *priv)
+static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 {
 	struct mtk_vpu *vpu = priv;
 	const struct vpu_run *run = data;
diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.h b/drivers/media/platform/mediatek/vpu/mtk_vpu.h
index a56053ff135af..da05f3e740810 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.h
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.h
@@ -17,7 +17,7 @@
  * VPU interfaces with other blocks by share memory and interrupt.
  */
 
-typedef void (*ipi_handler_t) (const void *data,
+typedef void (*ipi_handler_t) (void *data,
 			       unsigned int len,
 			       void *priv);
 
-- 
2.43.0


