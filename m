Return-Path: <linux-kernel+bounces-124808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318AD891CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E138DB26B27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B531148FF3;
	Fri, 29 Mar 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJPQaDMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB931966B7;
	Fri, 29 Mar 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716171; cv=none; b=V1RqZcIm2JYbGvlyKlDr3UmTHZCWM/k10gRKLQBtcbZCZS26CILkOL/f0m3stoRQAUEOoaWIPqCRvs7H002rtXy5/Lj/HjY3V9uKrJEVKeYfAeGQjnV1c+vupkTZZtmNm/Y3ZxG8APJQRDXHqAsTIaP/V6ByKuFgXIl5hvFq0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716171; c=relaxed/simple;
	bh=bQ6t7H5CtU7xN2Szuq+lEthMgQEZWj/OElMP3vgr//k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qktn9xvslxXO957CEUIjicU8D/tJglcjdn6gUa4FlQSLaPWSc00CI9oszaSx3RnUCVCmOkYU/OoYIPcDxkKCBWYLwQx2aV2BkN3gAxQu4m7WVjTrdzmIhyFFRYDYGFcj+8XDGtLcwJrYS3tY8O73ynGUavnZMKPehY8ZKdsJ6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJPQaDMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEDDC433F1;
	Fri, 29 Mar 2024 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716171;
	bh=bQ6t7H5CtU7xN2Szuq+lEthMgQEZWj/OElMP3vgr//k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJPQaDMPUWN5u14UwhVvGX3aSx5HYGzbyUvXRXkhXVTSegggNRqksvqykyUwA6/M+
	 BzT1Xp3iczVSGNrWEsxEaHHJUgS08z3YzDH3lLTsIoAB/uNJaAJUlJNgml3zjDlw6l
	 6hjugFLws5Jl5xuFKCf7XN3psPUc3//crWV82JMmZ45QcN/pRnou09hJ+Qz/E0mwKO
	 NM/v/jD6ZJjXUqO363rU6ppWhh6+VY+x6YnUkT3gIVtHBL6dzMV5NWDFbD0yaibB8M
	 4ome5xrzAXJJfdHaGTNhn5kR9V0dmLFiMP8jpyylo3SQyKJAVg7FaRF/yfxoiv3RMn
	 eFQTCjNQqiZ4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Scialabba <matt.git@fastmail.fm>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	maxwell.nguyen@hp.com,
	appsforartists@google.com,
	swyterzone@gmail.com,
	matthias_berndt@gmx.de,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 97/98] Input: xpad - add support for Snakebyte GAMEPADs
Date: Fri, 29 Mar 2024 08:38:08 -0400
Message-ID: <20240329123919.3087149-97-sashal@kernel.org>
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

From: Matt Scialabba <matt.git@fastmail.fm>

[ Upstream commit 81c32343d04f8ca974681d5fb5d939d2e1f58851 ]

Add Snakebyte GAMEPAD BASE X and Snakebyte GAMEPAD RGB X to the list
of supported devices.

Signed-off-by: Matt Scialabba <matt.git@fastmail.fm>
Link: https://lore.kernel.org/r/efbfb428-06b0-48f9-8701-db291c2a9d65@app.fastmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 14c828adebf78..1fad51b51b0e1 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -366,6 +366,8 @@ static const struct xpad_device {
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x2563, 0x058d, "OneXPlayer Gamepad", 0, XTYPE_XBOX360 },
+	{ 0x294b, 0x3303, "Snakebyte GAMEPAD BASE X", 0, XTYPE_XBOXONE },
+	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
@@ -507,6 +509,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA controllers */
 	XPAD_XBOX360_VENDOR(0x2563),		/* OneXPlayer Gamepad */
 	XPAD_XBOX360_VENDOR(0x260d),		/* Dareu H101 */
+       XPAD_XBOXONE_VENDOR(0x294b),            /* Snakebyte */
 	XPAD_XBOX360_VENDOR(0x2c22),		/* Qanba Controllers */
 	XPAD_XBOX360_VENDOR(0x2dc8),            /* 8BitDo Pro 2 Wired Controller */
 	XPAD_XBOXONE_VENDOR(0x2dc8),		/* 8BitDo Pro 2 Wired Controller for Xbox */
-- 
2.43.0


