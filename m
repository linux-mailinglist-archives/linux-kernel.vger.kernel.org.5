Return-Path: <linux-kernel+bounces-124966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0EA891E53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066AA282791
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105081AC013;
	Fri, 29 Mar 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrnOqRm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43D14E2C9;
	Fri, 29 Mar 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716522; cv=none; b=tM4yy/+3/YYvdUMHBZEwuqFBgDHSbhkQX27VvC7isl0GAP6Aj2tl1Xj2EXFxKeXNKoBx9iiQeHKztut/O7gm0dKb02RbOL9riYc2Z4rRgO0ogBsyfBH4XLPtml13V1rWxcrxCGY3w7jNGgr/b3bRMZ0gM6lW+4dqn3VNiRTYCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716522; c=relaxed/simple;
	bh=GxrkUBfErBuPqs7D0mlV016hRVzmj1cw++ndtNpyer8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsUXLLEyO/WA97u/vBaR1HJKt4F7UZ0MixVpmRIT+TerUhgkgjUnfRnOwGc8lhHC1u7ij8CqgPJCcOrtKN/qEJl/rYdCyFI4DlkHPGtSNjKpvFs4xT9dKiThdv1frs0dqfI0NkKbLuAEnYcQKk4Ey3beoj03TQjYe7mdrdSCJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrnOqRm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C66C43390;
	Fri, 29 Mar 2024 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716521;
	bh=GxrkUBfErBuPqs7D0mlV016hRVzmj1cw++ndtNpyer8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrnOqRm2t5QAUr0ZsHBfBcZur6HJBzI8tTo9EWectPQXUWcD1v+apaGeuqF4ttZX4
	 7EKMymy+8g64QL/JDHTQUiUB6vfA65WYizQXtzURTjRlPccX5B8UJhVUR9Q5bhlLYU
	 KHxVgfUn3atJO4TRz9BONyKZvVFL3jLWmMgIZ6nb/zZAwUHe/S3xaslmfFFpcrqC4U
	 r1d0TLt8s6HN6nxboYP25CYUj43fQxKWxXE7sRaSEHrl+pcEUaFXrmYcpEOYDxw751
	 x8oIIecKz6+3WoZIISW1ttsI/KOcb93ta15ivA5xhbEbGiHfgM6jENoAGKS8U7slin
	 3XN8X9h3Gzm1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 30/34] Input: make input_class constant
Date: Fri, 29 Mar 2024 08:47:31 -0400
Message-ID: <20240329124750.3092394-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

[ Upstream commit a4735d40a5da96a637af6e5bf9f6ec8b9d996acd ]

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the input_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20240305-class_cleanup-input-v1-1-0c3d950c25db@marliere.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/input.c | 2 +-
 include/linux/input.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5ca3f11d2d759..5c26f1e2c25a0 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1901,7 +1901,7 @@ static char *input_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
 }
 
-struct class input_class = {
+const struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
 };
diff --git a/include/linux/input.h b/include/linux/input.h
index 0354b298d8749..6cc4bad37f40e 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -512,7 +512,7 @@ void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 bool input_device_enabled(struct input_dev *dev);
 
-extern struct class input_class;
+extern const struct class input_class;
 
 /**
  * struct ff_device - force-feedback part of an input device
-- 
2.43.0


