Return-Path: <linux-kernel+bounces-114807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2758893AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1060B283C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667661B885F;
	Mon, 25 Mar 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtrHIKER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE80130A48;
	Sun, 24 Mar 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323417; cv=none; b=LUBiOpe/BAmIOlZVdbnDxaBxHLtrHHIb7yKATJfl7XAT7gw7Ygp+xQ6WC6kwluExXX1GFLVqtB8txx1GOwrBfo0v5zO8DVWnXXVFgIIfOWlV1mNai+a+0l1GQeRzNIj67uIqeo+J1xnSXlGShffAOaHTuhn6HbGhbfwRxGZTMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323417; c=relaxed/simple;
	bh=7KtJtuNFRVaxEGGiEmg0uLBDuikiomwiTay6L1kpgZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVIrBwbvvdCAIVjniWn75mbPidAffYPbNpGWBtiKNq8RRidREdoqiOp3UZLyd48RzgdXYvOfwYkDoUK8rySlyp2WrjE8U5VUMB836iSWrQ+t5WFzkoXfDAbywE3P/UNoNEeOUWIONjoOa4mFE1F4XnkIJE9c2+2A77AKan1WwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtrHIKER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E1BC43394;
	Sun, 24 Mar 2024 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323416;
	bh=7KtJtuNFRVaxEGGiEmg0uLBDuikiomwiTay6L1kpgZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtrHIKERzWSw/tWA2IORunSDzQ/xtpyPLh2PJfL9O89/Bp7dE0qXUzRGyTY6t7ELG
	 Fv1inmkxViLehz+xqR+utTfuN9cT1WLkOxWvKfwAegdJDwUB0CLCJpG0eOWBM1H/Fj
	 IBwGOmQhCBTCIZNxNVawLMMZ2SSHOataOBrVLFWD62Ko7S37nUXAbghvCLM6AZ/rHf
	 mWuunrGx6rk29KevhcQZSJNjp6YixktLjbZ3FmGJ8xHc3W/2ueWXLyJoruZjiigqiR
	 1LGpSYk0Sy2Kwl7ruUhCAA8g/5jmvq1/p+vyrE3PtAavXyHyRLswyFB4fEn3IncAHx
	 RmEbi+lMFEUwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kudinov <m.kudinovv@gmail.com>,
	Maxim Trofimov <maxvereschagin@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 118/317] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 19:31:38 -0400
Message-ID: <20240324233458.1352854-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index a46e0bf0e1dc4..0f533aff23a17 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -572,6 +572,13 @@ static const struct dmi_system_id lg_laptop[] = {
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


