Return-Path: <linux-kernel+bounces-11264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649581E3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9AF1F22347
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652C446B2;
	Tue, 26 Dec 2023 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq3ETUkg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AD5ABA3;
	Tue, 26 Dec 2023 00:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB38FC433C7;
	Tue, 26 Dec 2023 00:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550285;
	bh=ajNCLYj0uIJYPJMO3a7bh8UDJlgcD+wUexrwkNVj32Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq3ETUkgU4Nb/0/IhBKTzPlm9U28Xsdr3Ei2iT6STyz6OtRQ58MI9VgC++ZMo22k/
	 PEQgPoKampDpCOpMmZvpFu1CBPx2I/o7GqcWUhzyuI64rQCWhv7uLPnXPuhwLKHf68
	 qcujQyXDYoewNwddkxtvC3FSPox8/ARNIlo6W567McFMB7l0mcNJpCqC3kMe83LzUw
	 5p2Ulvjq2U82kpy1odODpvQfBq/HcE1hwF+wFupS0yE85hZmBLI2YzjFroQqjZWEqy
	 Jjs2x92Y71wyzbROz6PFMxaJqh+hAMp7BVHoaLDxXOpJqmQm5hVnismHupDLGYbFof
	 i3edJN9NA0+cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	radon86dev@gmail.com,
	mkorpershoek@baylibre.com,
	maxwell.nguyen@hp.com,
	matthias.benkmann@gmail.com,
	doublej472@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/11] Input: xpad - add Razer Wolverine V2 support
Date: Mon, 25 Dec 2023 19:23:57 -0500
Message-ID: <20231226002420.6303-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002420.6303-1-sashal@kernel.org>
References: <20231226002420.6303-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.145
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit c3d1610345b79cbe29ef6ca04a4780eff0d360c7 ]

Add the VID and PID of Razer Wolverine V2 to xpad_device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20231125-razer-wolverine-v2-v1-1-979fe9f9288e@z3ntu.xyz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3bf5c787f9149..1ff0d4e24fe68 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -268,6 +268,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
-- 
2.43.0


