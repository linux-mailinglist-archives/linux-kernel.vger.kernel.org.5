Return-Path: <linux-kernel+bounces-11211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082D81E340
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86492B2262E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CF45C05;
	Tue, 26 Dec 2023 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuFsYUoO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7D45957;
	Tue, 26 Dec 2023 00:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B340C433C8;
	Tue, 26 Dec 2023 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550070;
	bh=hSOYC86raFCUruKecjUDuLV7rYJdc7Qx4RnqsBfYoEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuFsYUoOH8Sv/y6/LK4ZIIPJVOqVcmb/ZvqBwP3wyUD2nHfKUvKGxjpmxGHGNHtFb
	 0sCJz2G9IOwk8e9k7WXW4Bh0qWHUs6faBB7HhJAqDfnGGI4DLLMFpDft7go48WmPs0
	 FtXqaK7KfBJrKhG8Oz/LniXhUHf6C//GoSPYlenGQFnXZ46b4+h20SaKMsPgWZfa6a
	 gNMdn5+64Ovj/w7QMLFV4sx4jWnFmydafR2cRJFPkrqfOEx9P6qNCrU80U9i7agyYx
	 xV6NpC6y/Rbta2bGxX6foaAEDQBmpggqZo4wwPQW5sdABo+z4EQeoN7psTyFT/vQqC
	 OP8DV3Wkg64uQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryan McClelland <rymcclel@gmail.com>,
	kernel test robot <lkp@intel.com>,
	"Daniel J . Ogorchock" <djogorchock@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/39] HID: nintendo: fix initializer element is not constant error
Date: Mon, 25 Dec 2023 19:19:08 -0500
Message-ID: <20231226002021.4776-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Ryan McClelland <rymcclel@gmail.com>

[ Upstream commit 0b7dd38c1c520b650a889a81919838671b689eb9 ]

With gcc-7 builds, an error happens with the controller button values being
defined as const. Change to a define.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312141227.C2h1IzfI-lkp@intel.com/

Signed-off-by: Ryan McClelland <rymcclel@gmail.com>
Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nintendo.c | 44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 10468f727e5bb..7644edee996a7 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -325,28 +325,28 @@ struct joycon_imu_cal {
  * All the controller's button values are stored in a u32.
  * They can be accessed with bitwise ANDs.
  */
-static const u32 JC_BTN_Y	= BIT(0);
-static const u32 JC_BTN_X	= BIT(1);
-static const u32 JC_BTN_B	= BIT(2);
-static const u32 JC_BTN_A	= BIT(3);
-static const u32 JC_BTN_SR_R	= BIT(4);
-static const u32 JC_BTN_SL_R	= BIT(5);
-static const u32 JC_BTN_R	= BIT(6);
-static const u32 JC_BTN_ZR	= BIT(7);
-static const u32 JC_BTN_MINUS	= BIT(8);
-static const u32 JC_BTN_PLUS	= BIT(9);
-static const u32 JC_BTN_RSTICK	= BIT(10);
-static const u32 JC_BTN_LSTICK	= BIT(11);
-static const u32 JC_BTN_HOME	= BIT(12);
-static const u32 JC_BTN_CAP	= BIT(13); /* capture button */
-static const u32 JC_BTN_DOWN	= BIT(16);
-static const u32 JC_BTN_UP	= BIT(17);
-static const u32 JC_BTN_RIGHT	= BIT(18);
-static const u32 JC_BTN_LEFT	= BIT(19);
-static const u32 JC_BTN_SR_L	= BIT(20);
-static const u32 JC_BTN_SL_L	= BIT(21);
-static const u32 JC_BTN_L	= BIT(22);
-static const u32 JC_BTN_ZL	= BIT(23);
+#define JC_BTN_Y	 BIT(0)
+#define JC_BTN_X	 BIT(1)
+#define JC_BTN_B	 BIT(2)
+#define JC_BTN_A	 BIT(3)
+#define JC_BTN_SR_R	 BIT(4)
+#define JC_BTN_SL_R	 BIT(5)
+#define JC_BTN_R	 BIT(6)
+#define JC_BTN_ZR	 BIT(7)
+#define JC_BTN_MINUS	 BIT(8)
+#define JC_BTN_PLUS	 BIT(9)
+#define JC_BTN_RSTICK	 BIT(10)
+#define JC_BTN_LSTICK	 BIT(11)
+#define JC_BTN_HOME	 BIT(12)
+#define JC_BTN_CAP	 BIT(13) /* capture button */
+#define JC_BTN_DOWN	 BIT(16)
+#define JC_BTN_UP	 BIT(17)
+#define JC_BTN_RIGHT	 BIT(18)
+#define JC_BTN_LEFT	 BIT(19)
+#define JC_BTN_SR_L	 BIT(20)
+#define JC_BTN_SL_L	 BIT(21)
+#define JC_BTN_L	 BIT(22)
+#define JC_BTN_ZL	 BIT(23)
 
 enum joycon_msg_type {
 	JOYCON_MSG_TYPE_NONE,
-- 
2.43.0


