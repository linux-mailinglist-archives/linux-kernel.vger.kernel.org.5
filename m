Return-Path: <linux-kernel+bounces-63272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C617852D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A292A1C220C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232523749;
	Tue, 13 Feb 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvacZi9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CE2231C;
	Tue, 13 Feb 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818023; cv=none; b=LA50fFqk7I6tl7AJAvrOeUvT/ycrAJj6Fw4s97pqaDNSBV2AUcl+9uUDofz0zjvz9LQhFGxJmEubgz5z67gDAQI7DKws5c902fG7wB0Vx7sVrkEw5jpyi2RX2jR7kaA5gaHKjnraFuOTjTNkhFHftb0EaZgg2kUb1ulpXdvZ+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818023; c=relaxed/simple;
	bh=bFI73x+EDujHXYYrJUlTZT0kXjJSqN26v00ObvOwDkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnDzGfxffz0Upj5WFoPDT2W/+LEoMm1X/xK0x0uijkCZWFwygznIB8QzXL+gsP0hvDBaGHnBhRo1YMIV9eQBci7Zc7NdVOUSrde/ytbQMcljUOe5V90v+Xhlo6tFRGY/KjFdNes1P0AP+aWoALX5DX2dnqzz00YvvfjaySKDxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvacZi9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E7C433F1;
	Tue, 13 Feb 2024 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818022;
	bh=bFI73x+EDujHXYYrJUlTZT0kXjJSqN26v00ObvOwDkM=;
	h=From:To:Cc:Subject:Date:From;
	b=qvacZi9X7b6BKTUHvmK2DIdtUCZLPSLSuXmyZJDWMuK7DW7vHAcMnQzPNXgmW/ZaA
	 fZeZMJtwINqnID9p76XEJUJ12OhQypiyt561d2sbP6AB5ea/Bf7bNwc3YeV84OtgIq
	 GSArVzcFw/7orSOeOHlJ4QrSQ84N272ruNllkqiNLF4+rk1BsRTdkW9llJ8S2oZemg
	 QgGIyY8uFtpMi9Gb/uT9F/GMIea/rHho1nfYe6nUHlTo3GNFOmhBd3RZ32noCiM3ca
	 YfHYMo56XDBoTd9tulHp1evA1FxGYKOQfUOjJ+BzKosCcya2LbrY2VoX+JE+DqxkVf
	 x3TyrB3ELGUcw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ALSA: arm: remove an unused variable
Date: Tue, 13 Feb 2024 10:53:18 +0100
Message-Id: <20240213095336.453562-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The only user of a variable got removed a while ago, but I only now
ran into this on randconfig builds with clang:

sound/arm/aaci.c:742:15: error: unused variable 'aaci' [-Werror,-Wunused-variable]
  742 |         struct aaci *aaci = card->private_data;

Remove the unnecessary variable.

Fixes: 793e0fca25fa ("ALSA: arm: Remove superfluous snd_pcm_suspend*() calls")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/arm/aaci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index f64896564728..c3340b8ff3da 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -739,7 +739,6 @@ static const struct snd_pcm_ops aaci_capture_ops = {
  */
 static int aaci_do_suspend(struct snd_card *card)
 {
-	struct aaci *aaci = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
 	return 0;
 }
-- 
2.39.2


