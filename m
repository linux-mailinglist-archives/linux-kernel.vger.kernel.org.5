Return-Path: <linux-kernel+bounces-50417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9138478B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20CF1C25691
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFA152BE4;
	Fri,  2 Feb 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+91RmjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD615099E;
	Fri,  2 Feb 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899312; cv=none; b=nbPBCbnPRJhRMib5vDd002a3fyWyOYzAorlJwqegR1Dz7Ei5tQWlGWqyTL4f0YFUhqav1fnygpKBMSyPftxmZOI42TOV76A9VimbG2IEyMAxGmpYMpmWVofU8E66VFEjJU2KCcIAxgjgFIB9gTEGnlTUERx6I9m70I8q9yTg7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899312; c=relaxed/simple;
	bh=M9wBgqupwhTELvQhqkNKpCNfjRPsU9wC61rYfxM9bHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brsoUWKHourGq7ewA/CukeYuCvqS7y7G7x4UphNZ00FYKvVV4UDdo24cgXjuA7Vqa+smLYZpyPWrFKzr/WxxwthAbzsRSnILR1+90YtM9q16lXCSkxNMXiyfE+QHdm9C2YzjMObW1/hSlLNcYKk9pmHNyt2DZAokLWy3cHAOqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+91RmjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E13C433F1;
	Fri,  2 Feb 2024 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899312;
	bh=M9wBgqupwhTELvQhqkNKpCNfjRPsU9wC61rYfxM9bHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+91RmjV6PQ+gnGmU0M9udXO/VnSWIlq8gJ7innImnsqobAya8JO/LceCSHiyD2nI
	 YdQ0WFHkvw4dkqbreB9l8zYkr97aYr5+B9GkXGJNOYloBvE6KF9V0UuDi1icLSoKYb
	 MIdPpSjxUgAWrwqgUnRCx0G+F+Ao1wPVuaBXbh18kKE7ZR0lamtxT1d9GkO0MQgaAS
	 25epEUCgkmFpoznEqRIJ8z3UlnpyO/vDX0pQF1LiNPMANTxmd6kooF4Kw9n9V8qejZ
	 W/YMmEs2AOmKYYqqOIPJj4i4pvlRi+qeaLc2H11fAqgHxyUfzwoTgK7lzuL65GI2Tr
	 itmO+DFX/FCdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phoenix Chen <asbeltogf@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 11/11] platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet
Date: Fri,  2 Feb 2024 13:41:25 -0500
Message-ID: <20240202184130.541736-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
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

From: Phoenix Chen <asbeltogf@gmail.com>

[ Upstream commit 1abdf288b0ef5606f76b6e191fa6df05330e3d7e ]

Add touch screen info for TECLAST X16 Plus tablet.

Signed-off-by: Phoenix Chen <asbeltogf@gmail.com>
Link: https://lore.kernel.org/r/20240126095308.5042-1-asbeltogf@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f129e29b295d..397283893f39 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -916,6 +916,32 @@ static const struct ts_dmi_data teclast_tbook11_data = {
 	.properties	= teclast_tbook11_props,
 };
 
+static const struct property_entry teclast_x16_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1916),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1264),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-teclast-x16-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data teclast_x16_plus_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3692-teclast-x16-plus.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 43560,
+		.sha256	= { 0x9d, 0xb0, 0x3d, 0xf1, 0x00, 0x3c, 0xb5, 0x25,
+			    0x62, 0x8a, 0xa0, 0x93, 0x4b, 0xe0, 0x4e, 0x75,
+			    0xd1, 0x27, 0xb1, 0x65, 0x3c, 0xba, 0xa5, 0x0f,
+			    0xcd, 0xb4, 0xbe, 0x00, 0xbb, 0xf6, 0x43, 0x29 },
+	},
+	.acpi_name	= "MSSL1680:00",
+	.properties	= teclast_x16_plus_props,
+};
+
 static const struct property_entry teclast_x3_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -1552,6 +1578,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_SKU, "E5A6_A1"),
 		},
 	},
+	{
+		/* Teclast X16 Plus */
+		.driver_data = (void *)&teclast_x16_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "D3A5_A1"),
+		},
+	},
 	{
 		/* Teclast X3 Plus */
 		.driver_data = (void *)&teclast_x3_plus_data,
-- 
2.43.0


