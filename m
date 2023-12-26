Return-Path: <linux-kernel+bounces-11228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0581E36D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A14C2873CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9A4C9B;
	Tue, 26 Dec 2023 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjrxjFeu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34855778;
	Tue, 26 Dec 2023 00:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4166C433CA;
	Tue, 26 Dec 2023 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550115;
	bh=qetpHDRFWfYBuGHOtnC7oXohZ9dUj+2MjaGVCAW4Ctg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjrxjFeudnpayvLEnitM4DxoMsYdWTlfLdOCw+l3XUo1kM/MVFz3k+42XP5DP9wHK
	 CO1fouPvZdNxQffA+o1opOx/gQjr/A0gCacN4kHJbCr/35Ioj8YMqs1lupmzmrTDta
	 CuqBMxHQbdmwUNwKhPV+ZHoZxyKeBjtrhBsnLo7lAgxH5JpFxtGBka0NuzdI4Ksqop
	 t7JXCTakRZ/tbKQaH99pB/327Q+lZQo3+D1zfDIwTQxr+z3qQ3yE/2aGhxT9c4Hf+y
	 XphMQaFVoodI15S8DU1uTOAIaay3SgE+VBGDgSCqsQGay2RjwNLCqTlJmdGedTP64k
	 xikc9I5FNxHUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/39] pinctrl: cy8c95x0: Fix typo
Date: Mon, 25 Dec 2023 19:19:25 -0500
Message-ID: <20231226002021.4776-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

[ Upstream commit 47b1fa48116238208c1b1198dba10f56fc1b6eb2 ]

Fix typo to make pinctrl-cy8c95x compile again.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Link: https://lore.kernel.org/r/20231219125120.4028862-1-patrick.rudolph@9elements.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 58ca6fac7849a..993b30ebc6841 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -821,7 +821,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 	gc->get_direction = cy8c95x0_gpio_get_direction;
 	gc->get_multiple = cy8c95x0_gpio_get_multiple;
 	gc->set_multiple = cy8c95x0_gpio_set_multiple;
-	gc->set_config = gpiochip_generic_config,
+	gc->set_config = gpiochip_generic_config;
 	gc->can_sleep = true;
 	gc->add_pin_ranges = cy8c95x0_add_pin_ranges;
 
-- 
2.43.0


