Return-Path: <linux-kernel+bounces-115219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03844888DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9609B1F277C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772091CBE14;
	Mon, 25 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGWc7OnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB322E81A;
	Sun, 24 Mar 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324308; cv=none; b=PWiCeXSRPHvdfMzyXItsXMHHpkP/yfB3u+Wh6bukj5aHkh7Hdzh9QyznsyW607C7jh9s6abSsKRsUP/rN0FAA9Ftb0IquWRdN327fwWgNOf41+AoI6D+jvxkZkmjOSh4SIXh+FjVFbROQi89UzPeTKXuPgBL/kO07ZJwrSz5IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324308; c=relaxed/simple;
	bh=YEoU5PFm52D5s+v/MhMGx8B0s7OKjBl9UBYhekISz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLYVx0wvI4KzDTIxVS3dp3ypsJa+3LlYSJRVA1RhHmf72kwP4MTgGvibU49AK+1ekFI72sXYP9yTBJz7mShT69x5GqpF310xoiXycQO0llhAdeB48AequMpVevfdHyRswEzqp/6w0jSW8VA6L7agr3T5oVJCQDLQy7mAlKjlj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGWc7OnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB85C433C7;
	Sun, 24 Mar 2024 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324307;
	bh=YEoU5PFm52D5s+v/MhMGx8B0s7OKjBl9UBYhekISz4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGWc7OnL6PCEdcHp+H0h1t3MagDZB+D6TMVLGKvqdHEJAO/e+SBadEUYrTVPV6g7U
	 JQcGHqsVbJYtlkCOfwPLLK27Rhd6Khai2fGK+6Pn/bSx7z+Ty+ivP+lCOExHBzw/qe
	 6XDaAQ8coiGumJsUZ2yeSI1JQNhNicn1C0Rk3tnHYDfkZEVERkm8EihajeN3jH+iNN
	 hmmF0w/SHObZTpdI0HK1PZvVO3t4fccc/p0sUrzIiibV/66V2GZb9Pcv18XOpDnHPh
	 2jVeBfFhuqTB0fU3rO/OwKH6rr3uunCMRY+VFNR0uX7aKU3Sw/kDKLnNnu45AMWYfY
	 RmtG9YqFb8bmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/148] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 19:49:03 -0400
Message-ID: <20240324235012.1356413-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index b14bff7b4ec88..b9874324d1c44 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3990,6 +3990,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
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


