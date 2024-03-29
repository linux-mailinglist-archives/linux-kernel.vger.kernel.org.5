Return-Path: <linux-kernel+bounces-124797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2DE891C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391B9285679
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6718BC5F;
	Fri, 29 Mar 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z64K7x2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4018C9D3;
	Fri, 29 Mar 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716153; cv=none; b=oJUNMBVSu9YCUrARVCPM/IBc+YEREi4ib2huHgW4WdblqCrL/MmcSHPdFNUXu7h0lPm5WQdlc1u30dCoDCrY9mkpBBqimUnjYthJsbUyWM+BZulRlbiLKOcq8YTX3VwsXk+uOVUqObJIsqI+TvjbFk/lQjpfmYkntpXB7V6bN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716153; c=relaxed/simple;
	bh=lrT3/5EW+go1p7C3oYph3/zyeXMsbRRexmI7l1NDZFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtiVE5Sh8nX25Ykz3Pfv1jYuZIL8hrXVPUuqIJOBulZVaJsJhB69ZJlTh7XS6Gf1rBDwuMVoujktgywNSs6izCL3uKMybUABTfM4JecFw7FVFgrbIKPVQJwFk6TXD5jqyCicvQ1adckukdCYOs/VvD/0yIqDJz4DYB9mcyloJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z64K7x2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A865EC433F1;
	Fri, 29 Mar 2024 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716153;
	bh=lrT3/5EW+go1p7C3oYph3/zyeXMsbRRexmI7l1NDZFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z64K7x2ONNZiqkZ8udOzMSzuDuF4ggnVcDbFomYN47ToWU1SU/H8y7tXj2JjOCkRw
	 hwDb+on01sRfHZqTozNgrz1of0l9bfnB2w91bBcTHnMHpahSxWBLdDfhvW2wlxdM3G
	 pZAED0OGHlmnepOE1Y1uB8TvMRIaBbmrnKD/0XDj1w0tgMDb0RXP5ta6wPwcjCSU1K
	 x0dYQRLDZyumdyOyzKfDfENZZHsNSfwxZULxFbiQ9eHlYn6Bc6ELbp5HYgPof8L45z
	 5Gr0Stb3+s/k1YoRIO7nVWNbQWpjS7IOJUD0bbXjdXsFsYh7hcRrHZBl2BmdKT5vqo
	 MxYHH0E9aR/nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 86/98] Input: make input_class constant
Date: Fri, 29 Mar 2024 08:37:57 -0400
Message-ID: <20240329123919.3087149-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index f71ea4fb173fd..c3fa43514dc6f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1918,7 +1918,7 @@ static char *input_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
 }
 
-struct class input_class = {
+const struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
 };
diff --git a/include/linux/input.h b/include/linux/input.h
index de6503c0edb8e..c22ac465254ba 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -514,7 +514,7 @@ void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 bool input_device_enabled(struct input_dev *dev);
 
-extern struct class input_class;
+extern const struct class input_class;
 
 /**
  * struct ff_device - force-feedback part of an input device
-- 
2.43.0


