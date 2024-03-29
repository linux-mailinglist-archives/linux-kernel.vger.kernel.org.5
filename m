Return-Path: <linux-kernel+bounces-124929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630D891DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023F7282ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807C1A4C1D;
	Fri, 29 Mar 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEbrRgXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF811A4C0E;
	Fri, 29 Mar 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716444; cv=none; b=G7890A57K5oJLjD1wwXpigFd9wGLAZIob2F4qGlOwD+GNW2fWedTdrDjPdWNNsZVIvwPw9nM5xSkiqq8rxbIHfI77gxJAGO6XYJB7bBWjmeNKJ6VN0YhbMBP02LtnrAHet9KIHQD23x/JvqqFGjUU44KQFj2+sZIj59OP6dg20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716444; c=relaxed/simple;
	bh=zZ9Pp+gF5Nd2ff9Hb0BYwi0APXWGdw1wvGYH0OFOOH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+SsPgXI0ITG97p7nbi4Yc8hAQPPwVepQPHXPBIMaiFcVbKw67tmIKaGZauXdXkBaToeIAKjEB8SZc49fxc4ZimCwvAR2A/JY2sfcurVmqwu/Dth7nmKlWXoDhOTY/6PVqiSUgAz+LM0wVORUOxCrPjh2YEgIrlsFONollUGmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEbrRgXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D8DC43394;
	Fri, 29 Mar 2024 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716444;
	bh=zZ9Pp+gF5Nd2ff9Hb0BYwi0APXWGdw1wvGYH0OFOOH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEbrRgXj73lv4wxzJHu1hAqktHjSfioIA08JwDhnpjm6RfVK0kfLfBjRg00cJYXfU
	 6cPdljFYhCAkdDGLNtjSyCGBG3AadmRzx7GKLLHAOB6FkciDZkQJz7TYDVs4zWzDxu
	 0i4bvhjliRkjhzjKRB3bVul3O9mWDd4scYAIg6nlpiJW6FJ7Wj60RTxRO4ufyk3nib
	 IxItB7NhTTVUDSmH376kZnHdwZmwgBHzYI+K3hcvVZX0D23gqo9mG5o/0DDi4lETaF
	 m5ljgIuyya4JCtKf7kyiOZRpqHZ1YFjBj5Y1jbVuUNzRGUzfnKGJE8Fjwo8P9PanGc
	 v+qL1R1rszgqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 45/52] Input: make input_class constant
Date: Fri, 29 Mar 2024 08:45:39 -0400
Message-ID: <20240329124605.3091273-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 8b6a922f84702..067a9b1d5befc 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1918,7 +1918,7 @@ static char *input_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
 }
 
-struct class input_class = {
+const struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
 };
diff --git a/include/linux/input.h b/include/linux/input.h
index 49790c1bd2c43..fa656f30081f6 100644
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


