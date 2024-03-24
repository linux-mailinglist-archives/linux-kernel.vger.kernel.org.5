Return-Path: <linux-kernel+bounces-113827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F882888EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D531C2B38C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF7200A30;
	Sun, 24 Mar 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od3EqcTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC89144D1F;
	Sun, 24 Mar 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320864; cv=none; b=rhArO/jX4bKRNv9ZNg+wAIz8+hHib5SW4LXdQf6T3unPvQa3dhF3joRgUFVofkmsQf9vkxlRTf+QgBdK5h/Tu8i3FBhDHj/o1HfWBPH6GUoGQsc3vF+yPNtLgiqZUtWhAhmyv8rIy3vL2KXQ2X0wWMOrSG/j7M7IE3tC9fHFl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320864; c=relaxed/simple;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI2/qnw/7gpLE8Hr+J6CT2gY1s/ikwCEGU26Xc3fakZyzh3v5JzNt6W5IVndIlpL/EoRllSn6sGjSjF/iMSI7nH3pMqSyigeL08t0IevuQToVTh2qwsqi6AtPUefs/tbl6ABjXB1V9JCDqlBCsiQcAPhaAbISFQkjurhdOTJ9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od3EqcTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2188C433C7;
	Sun, 24 Mar 2024 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320864;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od3EqcTukUCe20CqSH6h0/Vv9171ImSqslz5oOahccCIqJx/3/1JImyFVNbY5kg9d
	 kv/FhRAn3+u61CS9OtN0OFKYMaglJT3jNJBwdNTTfMxxMkC2l4crJ6i0US5ywigMLM
	 XEhbs9e7B039MeJWEiL3uNIxmrJSvRK88zK1/FEu4NLd7l4fdKKZSAJuRbu/TuV/1D
	 RReANefuM7uWJCFG5xLLeymXI7o1Y41htDNNk69PGpUOM8Oe30zPyaBs6hM2u8VKw5
	 hHDbicLEBwl855/APMO/4PtrmH5guEk7bw/75UsVlZIRcDGtNyUY2At5bTKG58SGYZ
	 T9zQ/bYiUSikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 428/713] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 18:42:34 -0400
Message-ID: <20240324224720.1345309-429-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


