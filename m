Return-Path: <linux-kernel+bounces-115917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797E8894D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242C22965AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31E38A16E;
	Mon, 25 Mar 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL22DE5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F11148306;
	Sun, 24 Mar 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322106; cv=none; b=UWFMUgHJmferDkHYm0Aw3a6hSuyX4c86RI2IQffHAZ+sMf4L9CODE4T401tg3qufjzHNy13JEKsIBJGS4rg6APcDQBlrqtYyDyDOis8EmU9fjeLqAu47GEdRlTZkCWNMzlc8ug39AJI/5QwmfPd0U6rbOwxETOU8mkx+4IoKjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322106; c=relaxed/simple;
	bh=r9p82nwq3SbuY3gJ5vMnydbl3jGN8WfF4TJodVM9dL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbJiS2Kgxvc2x69Hty/i2ee3hXZ8H4FdQUglo49+zoC7eBDFCKXde7MOMXkRcnUrUJ3gfoLs2ztKy8wCHbitKuUxyDjj4wptI1J9x1aG+lcomXLrKHZAU0b+3ObwyctlvzgffUuFdajm0TRDeppybfSi+PiDzPrQ+469zaCIl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL22DE5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCFCC433C7;
	Sun, 24 Mar 2024 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322105;
	bh=r9p82nwq3SbuY3gJ5vMnydbl3jGN8WfF4TJodVM9dL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TL22DE5Y0w4tjrYDuBDJL4sIkaMeb0BzhUiHtOh0IzMsMBBUMl6iJPy+8XeDr0JKO
	 GeGSA36N6geB1naaoc7EYAXPPU8twOLTltMnQIQbZE+WvzW7MZNQBGPth5/vTY/WDA
	 kBnfOzKRpy0iRCv4nec6+BSz2LAyjGncheBLYwhIS8mNMluy+0io0LdtkLpJorbFL5
	 jUeRxhuOfwHry2dAyG5iFR5qQPkYu+CW3OWhqA6S2IOC/LcGrFDlEPyPHv7pFo05TP
	 k8HnMOzy5epy1kY+s8stGh72Bomk2HdR2Yklmfi0+fQnGw0YrL7j2kWiXjii73Aog5
	 qEPN2yoArvO9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 180/451] ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 19:07:36 -0400
Message-ID: <20240324231207.1351418-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David McFarland <corngood@gmail.com>

[ Upstream commit e2605d4039a42a03000856b3229932455717b48b ]

A user reported a keyboard problem similar to ones reported with other
Zen laptops, on an Infinity E15-5A165-BM.

Add board name matches for this model and one (untested) close relative
to irq1_edge_low_force_override.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 021a67d09615 ("ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5ebeb0d7b6be0..35a98a5916f63 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -543,6 +543,18 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


