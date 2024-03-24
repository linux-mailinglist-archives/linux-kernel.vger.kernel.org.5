Return-Path: <linux-kernel+bounces-113285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD688831A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A941F25EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2818D87A;
	Sun, 24 Mar 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdoOfvr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B118D865;
	Sun, 24 Mar 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320086; cv=none; b=sri9ymZst+im70qLeZMwvSmx8VdAZ9yHLpZgn6Wd+82qbZ31Z2lkJ9mFmwK3AHaWlL2OVClOa6o2qmi1BhxHJ/kUrOyoIWYFLyLpu3gj/M4mM88U0RhXyRUTKKxgXNKfzS1sCiDocLr+OQTiZZD3H8FWmuPajSl7JLmcHNhwQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320086; c=relaxed/simple;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvC+w1hzGSqa8rNu6d+4U0AZ058m9ZbMVZNUbAAR81uy8YQd1D9WC3HMjW71yl3kF4fgxE003DQrCBQ09Cn+5fsZJ5tD1YtBRI752V+TbYWIYyR7nRL/NgMKzNmOdJKIbphZqx9kEj+hiZFziLhOT9dXIwPwYcXWze7UzWwialo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdoOfvr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34712C433B2;
	Sun, 24 Mar 2024 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320085;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdoOfvr+VZSdmVC8LrtpFULwbyzXAEHQiV7h292Rjo1c7tKU8BzWvZxpeHK6RAwTR
	 /IIYioCTAvfpFQd1bl6fZojKKIqRDIqqtKOL+G72PtCPcK/NcTpe9dT+OTy/cAdHV1
	 tExhO6Uc9hBzxA7fYkRBJVzSwiZsNZbt8SHlUUqtW34YydeBAHWY7XmRRlmvkfonZa
	 gESInuNelhuTjon215wzVuxD0eKhU52jbCqEWCBnKczJshKPXOXz8Q1jP8qxEItOqb
	 AC+yD6N4KOBPMjWXbylXO39G7YmJ36oG5NybErIVjqTxIdFKQV5z7/DNh5gL2oshaa
	 W6zQ6BYC/7Bvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 394/715] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 18:29:33 -0400
Message-ID: <20240324223455.1342824-395-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit fd61d77a3d28444b2635f0c8b5a2ecd6a4d94026 ]

Static analyzers generate alerts for an unchecked call to
`media_device_register()`. However, in this case, the device will work
reliably without the media controller API.

Add a comment above the call to prevent future unnecessary changes.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 4d037c92af7c5..bae76023cf71d 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4094,6 +4094,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	 * topology will likely change after the load of the em28xx subdrivers.
 	 */
 #ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * No need to check the return value, the device will still be
+	 * usable without media controller API.
+	 */
 	retval = media_device_register(dev->media_dev);
 #endif
 
-- 
2.43.0


