Return-Path: <linux-kernel+bounces-23270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0C82AA06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DDC28AE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C212171C7;
	Thu, 11 Jan 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kw54TgAJ"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377E171B2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=yFj5GxwaCMUOxN9nS2
	xcQoPLil4M8eZJj9YIdaRGuhQ=; b=kw54TgAJaeOT+0u/arryUJUz8p/UVmcJNX
	OqTL1KCVNc5rkJn7oPbG7DkLf73N2tXjANkLathlyy4hwbDR+1pvEFOa4p7hXXSb
	h4LGi/0Rdbd/vZvMLnvRIKWJZj8oE40wP7zmBJTdjDvjG5wQACT1LwLyCR70BKN+
	8gXMXvxn8=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXfxFZrZ9lRZwTAA--.4717S2;
	Thu, 11 Jan 2024 16:56:57 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in evergreen_reg.h
Date: Thu, 11 Jan 2024 08:56:54 +0000
Message-Id: <20240111085654.12977-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXfxFZrZ9lRZwTAA--.4717S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWruF1xCFyDJFW8GryfJFb_yoW8ZrWxp3
	yDWFyFqr4FyFZFkw4xA3W2gay3G342qFyxArWDZ3ZrZF4UXw1vvF1Y9rWfZFyDXF4Iya4f
	J3WDtwnrWF93A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEgxi1mVOBlCFFAAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that close parenthesis ')'
ERROR: need consistent spacing around '<<' (ctx:WxV)
ERROR: need consistent spacing around '-' (ctx:WxV)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/evergreen_reg.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_reg.h b/drivers/gpu/drm/radeon/evergreen_reg.h
index b436badf9efa..3ff9fda54aa3 100644
--- a/drivers/gpu/drm/radeon/evergreen_reg.h
+++ b/drivers/gpu/drm/radeon/evergreen_reg.h
@@ -265,8 +265,8 @@
 
 
 #define NI_DIG_BE_CNTL                    0x7140
-#       define NI_DIG_BE_CNTL_FE_SOURCE_SELECT(x)     (((x) >> 8 ) & 0x3F)
-#       define NI_DIG_FE_CNTL_MODE(x)                 (((x) >> 16) & 0x7 )
+#       define NI_DIG_BE_CNTL_FE_SOURCE_SELECT(x)     (((x) >> 8) & 0x3F)
+#       define NI_DIG_FE_CNTL_MODE(x)                 (((x) >> 16) & 0x7)
 
 #define NI_DIG_BE_EN_CNTL                              0x7144
 #       define NI_DIG_BE_EN_CNTL_ENABLE               (1 << 0)
@@ -284,7 +284,7 @@
 
 #define EVERGREEN_DP_VID_STREAM_CNTL                    0x730C
 #       define EVERGREEN_DP_VID_STREAM_CNTL_ENABLE     (1 << 0)
-#       define EVERGREEN_DP_VID_STREAM_STATUS          (1 <<16)
+#       define EVERGREEN_DP_VID_STREAM_STATUS          (1 << 16)
 #define EVERGREEN_DP_STEER_FIFO                         0x7310
 #       define EVERGREEN_DP_STEER_FIFO_RESET           (1 << 0)
 #define EVERGREEN_DP_SEC_CNTL                           0x7280
@@ -302,8 +302,8 @@
 #       define EVERGREEN_DP_SEC_SS_EN                   (1 << 28)
 
 /*DCIO_UNIPHY block*/
-#define NI_DCIO_UNIPHY0_UNIPHY_TX_CONTROL1            (0x6600  -0x6600)
-#define NI_DCIO_UNIPHY1_UNIPHY_TX_CONTROL1            (0x6640  -0x6600)
+#define NI_DCIO_UNIPHY0_UNIPHY_TX_CONTROL1            (0x6600 - 0x6600)
+#define NI_DCIO_UNIPHY1_UNIPHY_TX_CONTROL1            (0x6640 - 0x6600)
 #define NI_DCIO_UNIPHY2_UNIPHY_TX_CONTROL1            (0x6680 - 0x6600)
 #define NI_DCIO_UNIPHY3_UNIPHY_TX_CONTROL1            (0x66C0 - 0x6600)
 #define NI_DCIO_UNIPHY4_UNIPHY_TX_CONTROL1            (0x6700 - 0x6600)
-- 
2.17.1


