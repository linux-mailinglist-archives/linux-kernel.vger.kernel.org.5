Return-Path: <linux-kernel+bounces-57148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A918F84D47C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C561C20EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8578154450;
	Wed,  7 Feb 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDD+E7/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981D15409E;
	Wed,  7 Feb 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341094; cv=none; b=mkzmb4VSwnO6r1uLpOlIdethHxQJ4mr+7QOOv8yH/ZajLn/okdtMWulEBNOQrX3gMvsdPodxJaeYULmS08j/w9oztQ/3cch0uyO78H8+He2fvpK5GR/J6+OOnqLNEs+qvm7HT/sxLcjZYNkQthUVh2Y6mxI6tJOt0KFw2+XSFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341094; c=relaxed/simple;
	bh=7evh+XqFxwvu7R9U2lsnxI8rZrzANHrt6c8aSq0JI28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+LMPzwCEXdpR+bNONTtMr7XUXXQ22fqutZEEiiUpDj7SuoCv+aLvvmRaaOqCTwKBgCWJNzIPdJ8KYisGiQIWcPyBsOTRW+yr/L5BEuhZ5vu8h7Z/kF5u/4J8zipzRgiEJhj0ke9mAOwiYzlg+lckqxNQj95i5he8lCvKkXL6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDD+E7/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62505C433F1;
	Wed,  7 Feb 2024 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341093;
	bh=7evh+XqFxwvu7R9U2lsnxI8rZrzANHrt6c8aSq0JI28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDD+E7/TEquaNEY5ECLWGeKAcCe2K+/Pr9K8bp/pbWF8ex5H3ChX9WqSF4oSv++3l
	 +xMpecI6z8abP8bFcmGVsj9YyoU4lHx3nSbgG05CALwdGM29hlNZZY0CcevMYhvWx7
	 zAa9YbFIg2YLytl3r7gcK99FkG+AFYwsOmhRp73AkoS6EBWMq/gXdw8Ert0rsrVuYD
	 +A0cBaDdQQajjx3otCkRzlFjTvW+QgYeP60ZK2vEryDHMueiubcA75lg3XE4RbaXMu
	 LhwHvhIfIxok72wTD8Chx65QxKJORVZnTDYOdHKQV43eQdwnBlGp95U3QnySQYCVvv
	 b+Y+bgFSCC5Xg==
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
Subject: [PATCH AUTOSEL 6.6 38/38] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Date: Wed,  7 Feb 2024 16:23:24 -0500
Message-ID: <20240207212337.2351-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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


