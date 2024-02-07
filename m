Return-Path: <linux-kernel+bounces-57218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D075884D53D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C66B1F29325
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF743144B20;
	Wed,  7 Feb 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djkdWuRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757C143D5B;
	Wed,  7 Feb 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341251; cv=none; b=qhEoQw5PR1xCZRF/gWSzhf7Y1s4Bmn4+eZRyYAlEwnz+ws2I6ogZ84PItOuFKTA2NaxHA7/XJqVsju8H58+pUlh2OEwTYvwk0Gg59TMDdWwuZsepW+9FYTYwErPhbTruSggecxq2QQY/CHFpZ4IM0wvmBMvh47bGFAUCdHxFn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341251; c=relaxed/simple;
	bh=0Qidyr6PAaPq2GIi6iWq9ZPaWPYuC2K6/1r4CFQQdsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhCg5HT3OTNquHZaFSEGtEDXOkijA5bvGIRxfOwBg8o3+bf9fUr6NGiZiKm3vCXd+2hKJAjIubbQf4GXoOiulnhF5pw26E24FD+Udyx+L37TiTuN3PNqovqD8CNZGv6hLopEzx6gwoG60hK5Yi1TP3u0iHwaLrkRoyrBqy1r2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djkdWuRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2160C433C7;
	Wed,  7 Feb 2024 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341250;
	bh=0Qidyr6PAaPq2GIi6iWq9ZPaWPYuC2K6/1r4CFQQdsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djkdWuRSQ4gho/Hm3VnxCvz+YU8u/H5xDC4CLDHJhUkOtvIlJ0SPvgH+SXG5ZtYT9
	 phiQ9YqJEBW9l3EMgiN6SPgsqxaF4vI1XQkRF6jZx2IKpq/WBsEjpwABqK+riv1LyR
	 Uf/N4EXVT2XCdcoPI1xVfOfG8/MiuNxXiqS1Q3PoWUBVOZLKKi1djDwh5aQZ2LdbMh
	 ctCfHCe2maseSzFtwx8M9soM7o7umFjuZsF3HXXkthSsjpRF6tabqDNewkq0FttV2B
	 KSjmcgqiyDMOCuIAtrFhmbt+JXP24vSsoslqef2ecuswwmny7s7yA53Gy4oqnBKf3L
	 2Ok3YX25pCadg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szilard Fabian <szfabian@bluemarch.art>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	wse@tuxedocomputers.com,
	eshimanovich@chromium.org,
	jdenose@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/16] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Date: Wed,  7 Feb 2024 16:26:56 -0500
Message-ID: <20240207212700.4287-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Szilard Fabian <szfabian@bluemarch.art>

[ Upstream commit 4255447ad34c5c3785fcdcf76cfa0271d6e5ed39 ]

Another Fujitsu-related patch.

In the initial boot stage the integrated keyboard of Fujitsu Lifebook U728
refuses to work and it's not possible to type for example a dm-crypt
passphrase without the help of an external keyboard.

i8042.nomux kernel parameter resolves this issue but using that a PS/2
mouse is detected. This input device is unused even when the i2c-hid-acpi
kernel module is blacklisted making the integrated ELAN touchpad
(04F3:3092) not working at all.

So this notebook uses a hid-over-i2c touchpad which is managed by the
i2c_designware input driver. Since you can't find a PS/2 mouse port on this
computer and you can't connect a PS/2 mouse to it even with an official
port replicator I think it's safe to not use the PS/2 mouse port at all.

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
Link: https://lore.kernel.org/r/20240103014717.127307-2-szfabian@bluemarch.art
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 124ab98ea43a..816711771ffd 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -625,6 +625,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
 	},
+	{
+		/* Fujitsu Lifebook U728 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U728"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
-- 
2.43.0


