Return-Path: <linux-kernel+bounces-113754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639088866E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A99B20916
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507A1EFE41;
	Sun, 24 Mar 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POvjKDEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7F1272D5;
	Sun, 24 Mar 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320758; cv=none; b=FwDFE47A1OLroVosJDCpNUx2QKF9l1cNOd92OaZVoPE43eREo6yILFbRRcXN7RrIRrvE/L3xJn4NAljFL6abkty3MOmJTHSjSAWblswj5mxOFapJcgUf6cYBZ6Wl9LaUdTFs6UjPTRljSljqHXiWdDmwqOGbtIzIjzt6r+GqG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320758; c=relaxed/simple;
	bh=XDtBQWhsDplhQAGI/ZUTgS2XDcZOfYklpJ8bHYM4Src=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+bmGSMILiOraYyMHIRQHjMxf9rTI+ucwLPC299suE4g9VTzz8rfP5PqDHGl+EvKoe1uOjeyu1fbhZKHzEJH2YSVXghUMGzvmdEl7tPvFV1M4V1aSOvLoSJi4G8XQnN20x3yAOVwRV59pdvHDCPPEQm7kVm0WyK3xs25EEcT22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POvjKDEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63863C433F1;
	Sun, 24 Mar 2024 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320757;
	bh=XDtBQWhsDplhQAGI/ZUTgS2XDcZOfYklpJ8bHYM4Src=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POvjKDEloxaIY5r9KMPKSwZ8ChxYfHqDNSW7j7znn/LHphB50fiihGbrZ9eBDc9NI
	 ARoVJF8ZiSilzgzJgvCW361F2ulPx27bg4LXz8f0niY03812JBdq/L2Nr89op+qawe
	 pMrFJxvX17EPaMxhagmGT2gpnYseEuAW7s0aSHGYiw05bg+RGFPpczUaEKjvAmECxQ
	 Hzv9gvhsllYDKbOs6J7mk8yybXZC+/j/v2v4qTSPhlsV8xMvbJbnwzziYVDhHspEhb
	 8pZ7ncroiB7sJWrS4cTyaeIrVRsZG/KqP5riqZcvMmK+ABg8slCUzks30bMctA9F+P
	 zK74TE7W8Fhpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kudinov <m.kudinovv@gmail.com>,
	Maxim Trofimov <maxvereschagin@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 321/713] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 18:40:47 -0400
Message-ID: <20240324224720.1345309-322-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 3ebb74eb768a5..c843feb02e980 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -602,6 +602,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
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


