Return-Path: <linux-kernel+bounces-115948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7588899FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF55B304E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655339097C;
	Mon, 25 Mar 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsBzCO/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46C1FC99E;
	Sun, 24 Mar 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322187; cv=none; b=lstYZxbe5J9qVp6F0mr9HUohfMZfZMQwzziv7brE1DwqTapTsUARLqEF/owZktME710gTjdZMl4SO+iJCjLS1ZipX5JzCfv5BFD+15h0WO6kKRGEWUy/nhMXezxh8MlU/c7rcGluHKXlffGoX71DimkekmGwDzuCW35PqkWv004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322187; c=relaxed/simple;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6hXsHZqSkvds9lMb8fq+ghSwFoL7OZrM3qK+prGcAHEEcQfI5n7BmfDv/eve9be2+hpWYPVvSHKJkKVG6+W5I76XXnwRCQcA/yhwwG0lNjNasMdNNAYcJWNvQsWih6peMSJ0EbJx+C+kEdu006YsqsAC+pFXbuLoSr2hhutbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsBzCO/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4148C433A6;
	Sun, 24 Mar 2024 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322186;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsBzCO/GYnkCY9U/SDgvnivtAroLNV1SsdTzvK+15+gOa8naqgQrt3biuRGHvvXCT
	 8ICq9TYwIJqD/qGx3zhvM7uFSiS/VHnKuA+zzZV9wErBzU7b+RfwYKr8Ge3N30OPOj
	 Gtr6J5sy4sCArD4VgUXFoKOwJa0QBf8TJCjxH7xW7Ibk4DGa5ykzfxXafNKKoyw0HW
	 GGFXzkHPMppBbdknEOW6qfYuJ7oYGmt8Sd/GYKsK/gWCnp3dUr9dw+dfRp+kRTaijK
	 5hb+JselbRb6GcX5vqXhZpB29LUkU2ACZNGpMPOOX5q+YaqoFVkrWoAf9Rf+OZ6s6j
	 /aBrSclmvc7VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 265/451] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 19:09:01 -0400
Message-ID: <20240324231207.1351418-266-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


