Return-Path: <linux-kernel+bounces-11283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C181E407
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CCE280E90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0B5E0B0;
	Tue, 26 Dec 2023 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDLFtnnR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A225E0A1;
	Tue, 26 Dec 2023 00:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E964C433C8;
	Tue, 26 Dec 2023 00:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550389;
	bh=gip/2JM0WP86RCAP1yBp34R9G8avsnlGeL4HV2huiZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDLFtnnR2KiZ5YC1VsABHzcWUfIyFckblorf/MG3TSneGGjLuxDHQ4sB8mj+9m1Na
	 Yw3YCUzV1BevnhwrzU9BkqcEGCHqqNC7BqRRpNcRLXG1kyye+lBgjHv6M33LFoeWw3
	 qPcvz9Xk8j/T+u1MXFZzq6TDpNFtNH+RARtbRYJs2YikAyl/WQvVMkQh9feq1W8NnK
	 HYfe9Wo0xATffLEiDl1CW/4VyHaXtqUvl1aaJuADSmLavawXeTEXJkYwqciWtiefNL
	 0rAnRfOlAqwV50jecbv3DKtWlctyXbMhWzKZOMLTDtzv0zn3nr7rtI00V0VXwi/bI9
	 En6KmQvJQFIZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	rrameshbabu@nvidia.com,
	matthias.benkmann@gmail.com,
	matthias_berndt@gmx.de,
	radon86dev@gmail.com,
	doublej472@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/8] Input: xpad - add Razer Wolverine V2 support
Date: Mon, 25 Dec 2023 19:25:50 -0500
Message-ID: <20231226002608.7089-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002608.7089-1-sashal@kernel.org>
References: <20231226002608.7089-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.265
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
index beedad0fe09ae..239471cf7e4c2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -266,6 +266,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
-- 
2.43.0


