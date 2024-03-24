Return-Path: <linux-kernel+bounces-114200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8288890F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A67B1C27B54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C424E3B4;
	Sun, 24 Mar 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA6/KYzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C308208979;
	Sun, 24 Mar 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321546; cv=none; b=Gf1wSXo3CAxNCJkIx/mt24ZNwrrt9V6UK7GT4Pch5c0NXMU+3nkzNEQt1WbHHlJwbCLhaBUBbylplid4VC51xnD7vdDH62QYYUArkCGvd//P9QzjKhmtzA4L7ZcHhahWiwCwmgDB2eFqhC109TsIW3HQIf3A5kpyoCxdbZ0+8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321546; c=relaxed/simple;
	bh=gnliY6VElyIEbYJAxbLMX+CdhNylV1UaV2epdCmgx4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F28bi7S5BRA6e4b191H43XN2K5fn82qBaDXcwT2hRK6xj2gvz+zKFz6Jbdxu2pR1PCPzeeAMyrmbnxV6RWggctLYAoP4seyxJZunVrNAH8lGa/Fu+O6IjKtcfhgs+Zwek4NTESssY9plqLuA3aeY8nyvC8SRnTu4oM6+WSRTTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA6/KYzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7313DC43399;
	Sun, 24 Mar 2024 23:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321546;
	bh=gnliY6VElyIEbYJAxbLMX+CdhNylV1UaV2epdCmgx4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA6/KYzm9Po6Tg6BDrlzDjtWi+5c5SLJCi28DHBvcReG8GYDSkCAF4in2fLSoW+Vn
	 Xp+7HgSZ6gUel6rdpqW5ESBcHssqgWuIp47Y/3SCd1ySkdBpMxIRt9nGbz6er1TRKd
	 Dkf06E6vSb7NG3qQ02WHPCCNNkrpDdJS2Vb8QGszuFbsFJYKrH0xLrusH0DPgQNxH6
	 tLtSxAL9XaFEykYH9IiRuxRSwC4lv1N3cF7EPbvV/D6wAb6/ncj6AxChaxjSgXeCuo
	 ZCyQp5I+Xhb5Bc/70GiI4uaREFc04H/4/AkUppzo9I6ugyI31KqN2N5GVmm6TLzG+Q
	 I02RshSGfGgRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 274/638] ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 18:55:11 -0400
Message-ID: <20240324230116.1348576-275-sashal@kernel.org>
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
index 85ae394e793e6..b8378033117d4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -550,6 +550,18 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
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


