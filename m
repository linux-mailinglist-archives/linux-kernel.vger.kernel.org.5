Return-Path: <linux-kernel+bounces-57110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581984D41F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218E3285667
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83913EFFE;
	Wed,  7 Feb 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+3jayCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F613DBB0;
	Wed,  7 Feb 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341004; cv=none; b=gmmcjuVh8HqDtFjk+Xa5usZc/BEyX4XIz+pprhVNgc7AEr8Kt+r0fAVFGnzdRKmOGZV5kCqNTN8LXc1AtayA3+b1hblcuYazlKi2SFoMFqjYJ0wTYZw/TZPfQlZ2RFEk+ZeMcbE2uoXGckuXTqZLmMy7Y0l17JrUYhVFqUeKWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341004; c=relaxed/simple;
	bh=7evh+XqFxwvu7R9U2lsnxI8rZrzANHrt6c8aSq0JI28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScXM8WDpOzQqXU0KaOORd8P1BLJtGkyWaIM3slQaG7jNMYzZ7UVaIXzV1c5RdzmprI3qqPCncJbOt7QuBPd86qwThDxGzwmnJYr5P6xdRgLDCLHdK7kT18rWAY1q6IWGlEjS34Ssxc5IfaXJ0FOnWWQSA0eeTAh8f70D6UR4cSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+3jayCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8925BC43399;
	Wed,  7 Feb 2024 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341003;
	bh=7evh+XqFxwvu7R9U2lsnxI8rZrzANHrt6c8aSq0JI28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+3jayCyYwKnpYq8BzQN9D4QeDabWQigEX61XMDuMFjDgHFloUQLc9zKSXoCNbhPn
	 nmI3dM2TSXZOtefWRa2WkTO48H+d2EID4oSN9ZhLTRELY/NVzbM1KpquqqFfGhzLul
	 EwwXwCU9b4BUtmQay1bDzWanwwkXx8OA5lpDixHfKjH5Fra93f0y3pt0LAK/TT+UCl
	 sPI/hJc4+1UJq8oCUHWrvuhOEFzBRxbEdpAmbY2Mbf0Zr5dgwo6k4YclzQqrC7GAjO
	 GFoSmdMOqHgA12G08wxTP4k7LOuimUeN0g+vYisHCyyCxTSFqKpHWBfkB8K3F/gMaA
	 mzZnVfjZApghw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szilard Fabian <szfabian@bluemarch.art>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	wse@tuxedocomputers.com,
	hdegoede@redhat.com,
	eshimanovich@chromium.org,
	jdenose@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 44/44] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Date: Wed,  7 Feb 2024 16:21:11 -0500
Message-ID: <20240207212142.1399-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index b585b1dab870..2fd056ebce1c 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -634,6 +634,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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


