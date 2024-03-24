Return-Path: <linux-kernel+bounces-115658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD6889DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65B2B356EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A311256811;
	Mon, 25 Mar 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNVinnUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D669208989;
	Sun, 24 Mar 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321549; cv=none; b=SHny56A2irsEI5qUjOaClSqFTMkN6yIuozQmju3rJFU4rZy1ifXFX/HqYnI66lxn5w4UEHyGE6sGPSueO3piDQjwKDNFvRwnCRfrJ6Ql3WVzah9oUJT4R5wK0rgHCVou1UEhieutRj/TuZibi046qdc7OiaKgpFy/qGmpWlC8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321549; c=relaxed/simple;
	bh=ko3SOaIWgbG8YON21og9hSLDB2wMrpiFM2HPWVRL5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMhkdR1loNqoV4ty9615AkeQErC2NV2rJrfsI2rEreiHv2vSZYnumKOdfketmnko1zq+g5FQMXKagrY9WnbL/JxZ3NkstWs7PHZeMu6a2+J5heRGvv8Sah/PW4NHbW0pvFgYblSwIQ+xC0InWeDpHtiJSjtw27ygKiJ4qZJCFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNVinnUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E42C433C7;
	Sun, 24 Mar 2024 23:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321547;
	bh=ko3SOaIWgbG8YON21og9hSLDB2wMrpiFM2HPWVRL5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNVinnUEjO7w8DldJDZqeSyzt3C0KM4VcAHjgomBpESI6yBg41AfcBEfTqXqKIIH4
	 diVTXTAaf+28+szVNRabClAS3id7W39uXaCy78WNRLuuxrfuOpLWlG3od2u4i4QB4d
	 h0wBuiopGQY3j+q5J+qvIeS5jRkWAT1C0cs2bQjIL7XDAQLcM3bzaQAet+gaOCs61U
	 K4JufDAQmG/W3weTW92Qh1E/5YqJgZfFcarO98iITpljgqt5fsKy6inS4YEqxjTPNL
	 7n93PjlTai8jM+YnV+uDXBoo4tbWGn5TsMaZGTIttnzfpG1TAw6IAJkchaU+NJ+sy8
	 pdoZSCnN4NIOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kudinov <m.kudinovv@gmail.com>,
	Maxim Trofimov <maxvereschagin@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 276/638] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 18:55:13 -0400
Message-ID: <20240324230116.1348576-277-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maxim Kudinov <m.kudinovv@gmail.com>

[ Upstream commit 021a67d096154893cd1d883c7be0097e2ee327fd ]

A known issue on some Zen laptops, keyboard stopped working due to commit
9946e39fe8d0 fael@kernel.org("ACPI: resource: skip IRQ override on AMD
Zen platforms") on kernel 5.19.10.

The ACPI IRQ override is required for this board due to buggy DSDT, thus
adding the board vendor and name to irq1_edge_low_force_override fixes
the issue.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com/
Tested-by: Maxim Trofimov <maxvereschagin@gmail.com>
Signed-off-by: Maxim Kudinov <m.kudinovv@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ab1865e22864b..b9d219ac4e6bd 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -576,6 +576,13 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
 		},
 	},
+	{
+		/* MAIBENBEN X577 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X577"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


