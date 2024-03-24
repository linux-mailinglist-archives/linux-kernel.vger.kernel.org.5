Return-Path: <linux-kernel+bounces-114283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34C888992
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07294287E97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AA15E5BC;
	Sun, 24 Mar 2024 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G036siF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A420D5C3;
	Sun, 24 Mar 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321652; cv=none; b=b+BDujXSFTmRqX46RKglVPiFQcB/HC6c+EDN7bmPPzQ1G5CvNcnarlSwrEBK8AplbMqlva7ivqQE2KoqZMLLAro/+r4w0UDHFaOXGeBOY82yDiYLVMewJIZGSwQWfuZ+/sFS3b1c+n1TIKSSt8LKqKM2ObCPWuRB6cIq6N1PZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321652; c=relaxed/simple;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDV31UD6EqbTRxS9H708yXL81L5OGlF/0M4fLTuQGDZKFTKDMbUfvLb3jo6pIwvLbGR0qomqnGvWjVSHU7I9zi9V6GE32z6ZjxOxqVrOFj//I82OQxyr2ZUjY8FeUWfxXoU4TNcI4WuJzTqeYFnyNgP816Gwau1fTrEBR5cJRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G036siF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905C7C43390;
	Sun, 24 Mar 2024 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321652;
	bh=CwWwXVhHyKnLQ10moKJIyAHUeLsBYRK/aKO6LwRtc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G036siF0eK+ypPBE4oQHsPE147nY1Nk5rfdiwIRC/TECZzEB+rKGwDL5yGtBY+PM6
	 62pk+Ibz4VN7BJQHPThtXBj32QLw7b3aJUmuFl7sqX7HMTBEP/fuTPtJp+334pkCCP
	 xXy7eKp9syuYN6W00oUxrgE0D99G2yGJu6T/PygtNfdJAQJQ1waFj3nn3Ev2RUB3D9
	 RBpDgokvCR+bJdgRrIT89uZNkHfJ5+AqCpwPar+pQHSEA4HfMdRB9GqkDtKd+4Z6Q5
	 CzNPlTYfQYEAYkxYZP3rAAdPOm7Mud8q3bDnNwINFcmvLwiUVAL54/C/V7d8/0qZGt
	 nwAAdf9RvUUOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 381/638] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 18:56:58 -0400
Message-ID: <20240324230116.1348576-382-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


