Return-Path: <linux-kernel+bounces-136990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C289DAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFACB246CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2B12F5BB;
	Tue,  9 Apr 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz9+bP/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9171136E1A;
	Tue,  9 Apr 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669991; cv=none; b=JkoCTvv/wIo8ep5Gxx22yTT8uAs6LRFz1hX3p1H4hMigTPU4/G61qaKD12TOqSITbVhyMU+tPhQy5aCnOwyMLRaqqc1iIghsbbvzlpq72s+MeZW8uNC7GivEglVPnC35X3YMkfcqvOgVRuMTcScgaJU/agXRSxQvDrcjxTxcfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669991; c=relaxed/simple;
	bh=NlCnClFQH/uZ929V7ZbiGAE/v+SqP5ye30qi4yMGgT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pYTc8DJV0g4SoVmbAqHa9zgF4YMVwsy0nwJb1wvXpVORBntX5AOF3C4yA+DUm6ql333DQW3IbVO0bVB47a5m3zfOLPPa66sANVm66H8N/XxiNwGrcll+FLDrGH7oOUD76yLstSUUu/25jrlzOb0UxIHz33j4RR84zF1KIojEIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz9+bP/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B8DC43390;
	Tue,  9 Apr 2024 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669990;
	bh=NlCnClFQH/uZ929V7ZbiGAE/v+SqP5ye30qi4yMGgT4=;
	h=From:To:Cc:Subject:Date:From;
	b=gz9+bP/NQQKA3q5/7+iA5EmQBknvdLRXCJqhSxDYKUnYOOXHQl7v4xCI76GZyaVPR
	 t3S2pEJYWHinI58cNsT3RbjM7zqEdeMSSraZ7/BzG3u2l1743I34XsRFBPkVcGc3bC
	 Y7rRjxR94vd0rmtvzFCEcdtkx8hcc3VS8t2j1eMJFVW/ENdMg4a3qudxJBQmr9KnYF
	 d+DgY+UO7CK8zByRebkyddA+jIlCQ6zShKiVzMkZEsvb3j1WX2aR8WUkdrQAy2Cex0
	 HLlA/grRpTLYL5J/AYgQySKUTm6gOcejwYoqjNJJsGnlP810MZsFlzkVtVIVbZiFV+
	 sAwKfyMo5S0+g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel/qaic: mark debugfs stub functions as static inline
Date: Tue,  9 Apr 2024 15:39:35 +0200
Message-Id: <20240409133945.2976190-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The alternative stub functions are listed as global, which produces
a build failure in some configs:

In file included from drivers/accel/qaic/qaic_drv.c:31:
drivers/accel/qaic/qaic_debugfs.h:16:5: error: no previous prototype for 'qaic_bootlog_register' [-Werror=missing-prototypes]
   16 | int qaic_bootlog_register(void) { return 0; }
      |     ^~~~~~~~~~~~~~~~~~~~~
drivers/accel/qaic/qaic_debugfs.h:17:6: error: no previous prototype for 'qaic_bootlog_unregister' [-Werror=missing-prototypes]
   17 | void qaic_bootlog_unregister(void) {}
      |      ^~~~~~~~~~~~~~~~~~~~~~~
drivers/accel/qaic/qaic_debugfs.h:18:6: error: no previous prototype for 'qaic_debugfs_init' [-Werror=missing-prototypes]
   18 | void qaic_debugfs_init(struct qaic_drm_device *qddev) {}
      |      ^~~~~~~~~~~~~~~~~

Make them static inline as intended.

Fixes: 5f8df5c6def6 ("accel/qaic: Add bootlog debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/qaic/qaic_debugfs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/qaic/qaic_debugfs.h b/drivers/accel/qaic/qaic_debugfs.h
index ea3fd1a88405..05e74f84cf9f 100644
--- a/drivers/accel/qaic/qaic_debugfs.h
+++ b/drivers/accel/qaic/qaic_debugfs.h
@@ -13,8 +13,8 @@ int qaic_bootlog_register(void);
 void qaic_bootlog_unregister(void);
 void qaic_debugfs_init(struct qaic_drm_device *qddev);
 #else
-int qaic_bootlog_register(void) { return 0; }
-void qaic_bootlog_unregister(void) {}
-void qaic_debugfs_init(struct qaic_drm_device *qddev) {}
+static inline int qaic_bootlog_register(void) { return 0; }
+static inline void qaic_bootlog_unregister(void) {}
+static inline void qaic_debugfs_init(struct qaic_drm_device *qddev) {}
 #endif /* CONFIG_DEBUG_FS */
 #endif /* __QAIC_DEBUGFS_H__ */
-- 
2.39.2


