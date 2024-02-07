Return-Path: <linux-kernel+bounces-57202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000B84D514
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A1286C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4056BFA1;
	Wed,  7 Feb 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi5d/UT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2856BFCA;
	Wed,  7 Feb 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341215; cv=none; b=dpTEnSrUM7l5Dt4OIor//GDD7Easl/d1PpZVA9khroHziU0yZcWifSXKSd4ueuqK4oJezXvo6CjcTcZ1tEeUj0Hx+Cr/rPYFtQno8bEzWir2X33lInMNpFl5b636UuBNqjmLjoSppMuFHLyTVOgW8R2dl1FFAcKf9MAzyh9PZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341215; c=relaxed/simple;
	bh=5AfnTg+OU3W3j2LltrIgksiWO7cV1lN5s+AyZFDoXm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJPPbHbQW2q6zBPczkEwtYlQm4bGhk4lqk2FJAuE8XM0fe+lrsVyyX2ORqszSumU8bd3Q2vSq/NfPkrUB8+cU3LVb7JDwEKgK/V/CZ18LAUwMSxLQudpc4UKovetgjRJ4m0PsGQFKl9azy8IEBIKBsXvyZgYkiKl+Y+IEywMDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi5d/UT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E6C433C7;
	Wed,  7 Feb 2024 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341215;
	bh=5AfnTg+OU3W3j2LltrIgksiWO7cV1lN5s+AyZFDoXm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zi5d/UT0U9NRflzvVA1w136ezNMO21RFTECjOHv+r66sGL6opNoxsjE89MRluX585
	 uIcxzl261kg39/rTXDt/tXH7AZUwQjiTl0BfThFM5Pk/zbHqlMmZd2hlUlHVfDeH8b
	 +pfQYSOMEaIZA/w7OdentQDFNCfmI1mLjWwEkFPbdubj+ctNbhJxdMSWfsfc3DF90t
	 mCqBMKb1Tt5mIc7vc0K9K4fD3c8lr6PI1P1OQjOHm5pcW0H6ETysqM3paHn5wOLvMB
	 +PAjI3NgD59htYEHrafZIyI+M25630an+q5e/2qDuUE2RxmzG2aQEAeeBRR4CW7qWf
	 HNaSoghCxuQ0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szilard Fabian <szfabian@bluemarch.art>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	wse@tuxedocomputers.com,
	jdenose@chromium.org,
	hdegoede@redhat.com,
	eshimanovich@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 23/23] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Date: Wed,  7 Feb 2024 16:26:04 -0500
Message-ID: <20240207212611.3793-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 6af38f53154b..37b87e05cf0b 100644
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


