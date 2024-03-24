Return-Path: <linux-kernel+bounces-113751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB2888F75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038F9B352B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB11EF7CF;
	Sun, 24 Mar 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNw4s4w6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059D1D8DD9;
	Sun, 24 Mar 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320755; cv=none; b=mVM+apPIo8QKzWgYPKwqG6MOz7I+ckE7Fk6gfGVKbNS5VvOjSJIAAzJbfpQBApnf3BD+vY9Ms8xDIekEz2M2jooux5qT0l51pydLAXWo6lMtg+eMQkJMjc/XQ77o/O7VNkXdLaJbTKJI86DTd5sFMOWpdBYnXo6ALTAxaKTEstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320755; c=relaxed/simple;
	bh=Gy2dyvh/ntyyDPtr64AevhST2rDGnJU/UmphK66lt+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmYBg2uV0iLeIIkpvEY7vbY/IOVGi9U3f50bXePXxODRB+GdYXycBPvsMRoCA6cAhTXh42EywYUohN70MxiwdSiLmoQ/u4/wF+G2H1FPUpXegkfe4yNZOsmKS9Ogf58prjRRqXZPZHMB4Rcw7me3YvicQd4QXqDNOZ7aNnYmdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNw4s4w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F59C433F1;
	Sun, 24 Mar 2024 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320755;
	bh=Gy2dyvh/ntyyDPtr64AevhST2rDGnJU/UmphK66lt+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNw4s4w6qABQ+07Rc1w1Ql4j4rpbTE1K5xVaana+e4ID8L2ykG4qKT/noANx9eCly
	 iUmkmeIWSHqH1XOo9QET9NMSaXILvGKMFvdrJ9L36fQ//T0YU9uEZvPP0kCLhQpWw+
	 46IeMlKXloCiZqBwjEmsQKDnTEKJgErTgY17Mp67rtzu3qQbA/o0R893ISZA+L4UYm
	 iYCQDP2bPCVnZb0Y+PoynyBdmuZ5voLi6YA9stmIvWHyd23ovvwEfCaaRs/+YNQrph
	 nrZIr5FyJI3fYm5fYN6TNnLIMtubhcsSAkvS9rkmb5FgUtaiGZkLX+Wt7WE3DCY/+o
	 I7Q2f0AO5RLqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 319/713] ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 18:40:45 -0400
Message-ID: <20240324224720.1345309-320-sashal@kernel.org>
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
index 03b52d31a3e3f..dacad1d846c0d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -576,6 +576,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
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


