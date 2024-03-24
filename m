Return-Path: <linux-kernel+bounces-116063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902588954C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8676297C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB5B2811A0;
	Mon, 25 Mar 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEbqJETY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60713C672;
	Sun, 24 Mar 2024 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323479; cv=none; b=LX8hmcmFXxrfBEJuL0WyyN+dJgH/FaueAp9BX/X6gTgHRon/Qli1QWh/C/SqoVPu2uCd0w9qKpeAn20Tx26AXWZfFJlGiUa5aZeaqPEi9yWCpJ5hyL9rASybLuIxmiQi1S5Z6uCjJJNLCZmjREp+Q3rQ4A188kszuGNO25zsNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323479; c=relaxed/simple;
	bh=jiL9wfyJXlDE5MK27tjQQfAKCMTvZq36JY4t91RIOjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItUx9/2z1Q6FInjQy+rq7rKlJY9yiqEQXT/bfaHQ2bqH5E2zFvv85NSMCfpaP/ceGAgZuBRIrwvpvEFZW+rQw67sqUlfF+PX635/2kp/kprdZVWOP8HfrYwX3E92as5evZEyaqNZG7J0/nA6LAPo+KfY329DWVm6pMPFnK5bzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEbqJETY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349A3C43390;
	Sun, 24 Mar 2024 23:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323478;
	bh=jiL9wfyJXlDE5MK27tjQQfAKCMTvZq36JY4t91RIOjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEbqJETY6ouO8KEkO+z6wTooNmD9cTSIOt0eFi9tWyJkh5TtjzBZddRgeCkrVxt+b
	 TC1K3ilX9ZjauyHV4Iy1QqLTv3WPAxM7g8Wx2MXqFAtFsw1Bkqfwm+bszHjnwhO1hw
	 Xp2XiSPT8x9H+rkEB4JXkG8DwTem318ylV/0PUlMMKExgkL59qTpot/uDAr+yeIK6g
	 1CYmnU2eYje3agreM0eMb64NSO1nM9TApqjW258QnZhoPZ8I9CPX+0ewZW6lApAkkX
	 bX37XE6kv3IVc0g5aq7ZYpjHGVWfxIWGDQsoHsVxryfdKW4V3cdKEo4lMhR4AIRNKg
	 SH5RYcpoLTD6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 183/317] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 19:32:43 -0400
Message-ID: <20240324233458.1352854-184-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 92d867fc519c4..8ab10518957c4 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4099,6 +4099,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
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


