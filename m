Return-Path: <linux-kernel+bounces-11291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3A81E41D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676E31C21B64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D14AF6F;
	Tue, 26 Dec 2023 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjCRQJNW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523E5FF19;
	Tue, 26 Dec 2023 00:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C0C433C7;
	Tue, 26 Dec 2023 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550432;
	bh=ijfe7t0lftFncEzvO8g7YKkWfm0djqxRf56wkv4vblo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjCRQJNWhCbTDOUvKnkGkrGmA242hQupiyI8WwWamtatASuvPRd9IIcjN7Brzhumc
	 0GzGQE7jlg4YcXpN1DCPN37IUSeVBpYYPS9fddtVP5T4igVvVtLWAZx0n/fJyimF7d
	 q1Ntyl+pX43CdNpS97T/7uXqid40vERFecPkS0zswALsnysQqbuu/nsPQAW3sVcWtS
	 nIuMIQQcC351UE4DLP7RsnnrVA+pRucTme55fWsE/OT7bZTdfE05PnCsOgDYwwtveN
	 EMoT1eus5DNTxeREsz0Pn9YimnphcUi4l+LsXZSLftKkrZLxSDdAIc2Zk6voYGE7co
	 F8VqDZKIAEQog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	maxwell.nguyen@hp.com,
	lyude@redhat.com,
	matthias.benkmann@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/7] Input: xpad - add Razer Wolverine V2 support
Date: Mon, 25 Dec 2023 19:26:31 -0500
Message-ID: <20231226002649.7290-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002649.7290-1-sashal@kernel.org>
References: <20231226002649.7290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.303
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
index e330d28b59ec4..dffdd25b6fc94 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -280,6 +280,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
-- 
2.43.0


