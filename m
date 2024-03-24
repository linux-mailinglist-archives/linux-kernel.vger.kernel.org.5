Return-Path: <linux-kernel+bounces-115876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A5889864
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DA1F3709C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4865382CB8;
	Mon, 25 Mar 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlY/GwEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558414830D;
	Sun, 24 Mar 2024 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322107; cv=none; b=I6Nu9eHdx4pmPz47khoxAMa2AvpaTPlpZ3xNlDVhvOfEaJCpnGwpx5guCGm3Lky7puTxORDB/wtXlx2xZV1lySLiZdfKriS1YqTnd80nCZiSd+G6mTOp/BROdQEAsw5KFcGqhQYxb8NJ7oU+ezBlj7jjg7cEZ74YhwVsZCo4ZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322107; c=relaxed/simple;
	bh=IHleBqfgzxhVRg4DT3RAVWHeDYHXt5XC/UbFXbs1LYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEqOtXgAg6VT91wzMMDcuM8Cr9BRCeaFZlyPJxSMk9eWtmO2G0NW37oIzRJyFrpvlaJ2xMGDdmvQqXVvk+JWfU3rYAQFt57LqkeixFekLlwZRsLsegrSar9EhRiTvF5QAosbz6ykCaupKWoGw/QkybWrtcKooMsNaPZaCWbvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlY/GwEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B11C433F1;
	Sun, 24 Mar 2024 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322107;
	bh=IHleBqfgzxhVRg4DT3RAVWHeDYHXt5XC/UbFXbs1LYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlY/GwEsScQeJXgc3fIymg7QKuwy/tl6XMsy6xU/XF6aFe/D+OEMW/ZCmk/X4eIsu
	 31J0KqiNtsRsyw37bSSr01SEu4Yf6rvVtVQSMRbaCiXcuFkA2GCp6U5BZmDGLldOZf
	 nJbVaqP3tocngaXM6tL9zWFonpHmCYCQ0bY0Hz1foNQr1I6TczkzmwpQyHwbSqDeWB
	 6kajA0FYOPu0uDnJJ0AfDv6cxsjk3MoJ8Deapg53QRh8pbf+qjsIlovHWMZ8K3LmT2
	 QVQaKpdJwaq1slj4twUN5r17wtLhYvYyZCjRWzCM5oP/YOqgvMPMeSjZVDCFTjzRln
	 f5/1Kq78yC6hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kudinov <m.kudinovv@gmail.com>,
	Maxim Trofimov <maxvereschagin@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 182/451] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 19:07:38 -0400
Message-ID: <20240324231207.1351418-183-sashal@kernel.org>
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
index 8420d97287f86..1c5c1a269fbee 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -569,6 +569,13 @@ static const struct dmi_system_id lg_laptop[] = {
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


