Return-Path: <linux-kernel+bounces-124883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9405C891D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AE91C26730
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1921C170;
	Fri, 29 Mar 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC2ot5H+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017552101BF;
	Fri, 29 Mar 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716342; cv=none; b=dLowNO1lZFuWyq5by//7d2rL3/4S1ufbCXGS3rlmbimxlgEnscfDGbT5W/75PbwQUQeVvo9wWsw2r6pjR5kSbQ2PW23MoMH2kzyTymFlDj/PRwNcw2W2mzXsm0sQlg22U687otOqfZiZYLTpMLfR7czs81SRtHsOdKwrHRxzCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716342; c=relaxed/simple;
	bh=9BouK0cvyz4CebDFKqfn+1sFwX7Su+j+j0D8cIZoeFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRik3IdUpDCjqj1Gm8OjV2/SnLEKNCUlWgOOH86zBLPSo7TK0xWS/sT4abjZS/rSwmCYdBn35UNySb4TTEDGncRSUQfM9uxe9dFYFrhnDB8hjOumsBYeGoHziIGwDXfrleGdBVksVNXP+zIEp9JZ7Sacram9lqo0rhiL3Y4tQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC2ot5H+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDDC433C7;
	Fri, 29 Mar 2024 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716341;
	bh=9BouK0cvyz4CebDFKqfn+1sFwX7Su+j+j0D8cIZoeFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YC2ot5H+hQWG5G3AMjqwGFUhfDM3EQ78dK3SPrRemK8ZlusSgIJxS9LCd/ujRKU8H
	 P/Pnbjc2KJenQDPoX1/KUSHeY/hkw3ICUxSWlt3zJMXsvxZepcESu7J+tGYj+sHKh6
	 6cb80ZgHDou8K6ltLivM8j3ePlLV8NvtfpmSF/3o8dHrBc6QVtRgy+Fw6SbYU83Knc
	 FYSI/oX52vAXQS5Yu9+88Bl8aSvSOYb1iryVqWxCONoSBx/u+jSwIxWhm2WwxX2Lad
	 FW3fIJwvRuqQiDcyr/7SYdcdXI6Hm4rYBqXPRI/9Nd0La28hbYFCHHqHQbdgkCYdpL
	 /bdr/UF5L/ERg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Scialabba <matt.git@fastmail.fm>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	maxwell.nguyen@hp.com,
	carl.ng@hp.com,
	appsforartists@google.com,
	matthias_berndt@gmx.de,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 74/75] Input: xpad - add support for Snakebyte GAMEPADs
Date: Fri, 29 Mar 2024 08:42:55 -0400
Message-ID: <20240329124330.3089520-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index d0bb3edfd0a09..57c052a027f7d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -361,6 +361,8 @@ static const struct xpad_device {
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x2563, 0x058d, "OneXPlayer Gamepad", 0, XTYPE_XBOX360 },
+	{ 0x294b, 0x3303, "Snakebyte GAMEPAD BASE X", 0, XTYPE_XBOXONE },
+	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
@@ -501,6 +503,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA controllers */
 	XPAD_XBOX360_VENDOR(0x2563),		/* OneXPlayer Gamepad */
 	XPAD_XBOX360_VENDOR(0x260d),		/* Dareu H101 */
+       XPAD_XBOXONE_VENDOR(0x294b),            /* Snakebyte */
 	XPAD_XBOX360_VENDOR(0x2c22),		/* Qanba Controllers */
 	XPAD_XBOX360_VENDOR(0x2dc8),            /* 8BitDo Pro 2 Wired Controller */
 	XPAD_XBOXONE_VENDOR(0x2dc8),		/* 8BitDo Pro 2 Wired Controller for Xbox */
-- 
2.43.0


