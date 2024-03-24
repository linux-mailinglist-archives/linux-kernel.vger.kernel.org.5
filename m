Return-Path: <linux-kernel+bounces-115103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EB888D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FBE1F29D33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3A01C3A18;
	Mon, 25 Mar 2024 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd8nnbRl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFA28CE68;
	Sun, 24 Mar 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324103; cv=none; b=Ukd2c0ZwCC22ZCj5wJDEOBuwys5/mDwF2hGJaJpK+ycRCC3Mpvk/gH/WO7RX6jl+jPt7DsToIP6nqfnGt0+s+9i9jmSaPGPWqSstgTk+0/7gdlmztAM7ffldbkjWF4Tdol8zJkHFOtefeDh+/txkk72DbrBpMh/VLJD9ivEWq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324103; c=relaxed/simple;
	bh=X25k7Z7+vINRWTsz5TQiny62GTHkXwas2jA9xHC2Df0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io3NU/L95CtNWaYn6kJJohKlXVyAPqCK5L6KVZWu3G0yV/aghbhZgG2lTfloj6pL/ILqY5MQMlbnYDy0HqzhWYFCmBncWq/atyQn7snVn6zq+zuge7fXv67qWBL+iCgHRgQm08qm280Uqkh0XUNgndEHgtvhbS3EwMWq1O9yAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd8nnbRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF218C43399;
	Sun, 24 Mar 2024 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324102;
	bh=X25k7Z7+vINRWTsz5TQiny62GTHkXwas2jA9xHC2Df0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nd8nnbRlJC8iiA2u6kC0eybY94O8ZMtoycBWR4QXJtuQTaUI+1CMD3QmwXpKEA+9h
	 pFUG09AxCZCOFEQf/8NQGAAArFm5Wyp+FI+Do/395vFeq7YA5AFSfd+UvTRyTlycUQ
	 9mdxwitq9JlmSPnghfi0UKNf4j4zVJeOAa8MMivHkT4jPLsv2PDeJkgpPEXYK6/BGo
	 mk5T6ueXD5EU88iewrYe+C1YjOS8wDoMzsSugq3Q18DD/lCCzaqjY7zGE3ZkJua1ws
	 aNcDb+rguCT5vb1Df0+LH531Lt6ZYcd/fDTdnp0YujAjYOkFHa1xuZoOf8XTaSkJYJ
	 lwY2W1QTFfkxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 101/183] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 19:45:14 -0400
Message-ID: <20240324234638.1355609-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 5ae13ee9272d5..252e463cc13b4 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3989,6 +3989,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
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


