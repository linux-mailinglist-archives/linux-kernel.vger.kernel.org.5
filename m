Return-Path: <linux-kernel+bounces-37124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14883ABD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058531C24704
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE47CF14;
	Wed, 24 Jan 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1JbQUOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E237CF16;
	Wed, 24 Jan 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106522; cv=none; b=V1a6wkys2uRFbavdUXLUZWBTbVHXmNVOogJCf6oM5URIODzjZBSxWDZE6d72TC98+Wb5mtp/2PLrd1OafuCDYuNxNU0mPw+VBGs5/rEKaj7ltK5DRBh1phCliO213sq/tFnNHk/KOlx3WSu3PPkPi2Sv1ijeoDvloer7hcoUj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106522; c=relaxed/simple;
	bh=l6lT8MOMSiG0DvSXCsTdt7NAl3vqkpxsoqyKOWBEn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsF1pJqxU7oB1QKOzH3OG6CJK4roiv9FUFH5OqImTTPYTgcjXzAmAzRI8EctEAU8GEgGPEHBEg2YxNDY6XluQyYSg/VzwSndxm7ZyumVcI9GeOX3BZKt1CeNwHFlzICM7/9OyzD6RnVpYNNh3RSZn/3PW38jBhz9loLRy9vBnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1JbQUOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6DC433A6;
	Wed, 24 Jan 2024 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106521;
	bh=l6lT8MOMSiG0DvSXCsTdt7NAl3vqkpxsoqyKOWBEn6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1JbQUOhPFWK2sA8h2O1SCFTV2xG7VTW6jIPuphcfIpWx+ARm46IBdyVqb27jesOc
	 9R16oF4x1QoxETU9RZmYItisl5Qdi1ztYELVmJmjKMpzEbNHj0LWox2MN4mY76JQd4
	 bGOtpByE9e8AyXMPknc1OoLzolwcBKD6vclOKCkL7YyRzXxjZ/AW5R6Rds/ruT6++Q
	 I0CUnheuQWi/kTpqBdsjuChJ4id1BvUE8+BrYwotOXSafvHPxj1saaJyUvW2CYDrJ2
	 YBeitkl6EfYFZ+gOwnigg4hyN1fxgetx1nHKk0OghEkPbRJHdMZWCVNmKr/zvJalxj
	 oz7SAHAK/7ZVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Mayo <benny1091@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 08/13] ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA and E1504GAB
Date: Wed, 24 Jan 2024 09:28:01 -0500
Message-ID: <20240124142820.1283206-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Ben Mayo <benny1091@gmail.com>

[ Upstream commit d2aaf19965045f70bb2ece514399cdc6fcce2e73 ]

Asus Vivobook E1504GA and E1504GAB notebooks are affected by bug #216158
(DSDT specifies the kbd IRQ as level active-low and using the override
changes this to rising edge, stopping the keyboard from working).

Users of these notebooks do not have a working keyboard unless they add
their DMI information to the struct irq1_level_low_skip_override array
and compile a custom kernel.

Add support for these computers to the Linux kernel without requiring
the end-user to recompile the kernel.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Signed-off-by: Ben Mayo <benny1091@gmail.com>
[ rjw: Link tag, subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 9bd9f79cd409..eb34d201b65f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -482,6 +482,20 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus Vivobook E1504GA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
+		},
+	},
+	{
+		/* Asus Vivobook E1504GAB */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


