Return-Path: <linux-kernel+bounces-50368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99B847818
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61B91F2F12B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1A512C811;
	Fri,  2 Feb 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PumQBerj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9212C7F8;
	Fri,  2 Feb 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899208; cv=none; b=rjGekYGkImtCE7yO6vJkfsQwPo1jI/IcoUPB70M05KhizjG/Rpg7cEM7koXTa6Vm4YbRA7uTYmW4/CIhd3FiMYVTKfOFwjM1wezl72a85i116em3wbIPGEAh7HpqyfeOApD2ipiVA0T7wfohLKsXo8X779j4tC6alHStOaQu8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899208; c=relaxed/simple;
	bh=DBhCBpHNYtAfNq4+MxgcsEhfGsHqbT4zWuXR+vsZt0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YozTNb3Yqw0l/RUPPdrktN2HqOScQGqodBSSx6mif5Ki0Ilajw5s1NL/3vO0A3nX50RxMjMzTonEhW9ryNirhgIuWQlh3zzkSk67WSeAf88h5da5iios5foyFNxPrU06bHU5EC6rZ+upH7s6FBB6Lntr98boXAGe/dtoe1K5qYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PumQBerj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC737C43399;
	Fri,  2 Feb 2024 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899207;
	bh=DBhCBpHNYtAfNq4+MxgcsEhfGsHqbT4zWuXR+vsZt0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PumQBerjT+fhgCS+JdEkX3p/vvGxRuf8DN1dVWiqCAvFrbqZtMn3BFHhRRnJOB1Av
	 b93KC744kXq6vLo8g8i+PBTp8k0pNMMBUBWx6OVh3xxp2c7O00W7OcltUIcT+vMI1b
	 Mj8AwkIFBBtLba6B413IKOsa2mWTGsQ5I62VwVkRVIuCkDoAMZmp7R0s3HddOadqFs
	 lmXQtyd5W26iDfRCAPY62n7GX1dvfUUQKG545wq3Qp99RviRWkSchqHN/wqEX++T5o
	 Mth5evmeKBQL0p9r3acclFx/ZOz0wMHiYhRBhxnvxttIBPyZVRlYjhDvxvsUh/2DNz
	 Y30nM76G0K7ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phoenix Chen <asbeltogf@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 23/23] platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet
Date: Fri,  2 Feb 2024 13:39:19 -0500
Message-ID: <20240202183926.540467-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 0c6733772698..7aee5e9ff2b8 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -944,6 +944,32 @@ static const struct ts_dmi_data teclast_tbook11_data = {
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
@@ -1612,6 +1638,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
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


