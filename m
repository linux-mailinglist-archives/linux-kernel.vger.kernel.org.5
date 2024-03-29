Return-Path: <linux-kernel+bounces-124517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359DD891938
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6710287720
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0C144D14;
	Fri, 29 Mar 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN3nPVCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14D1448F3;
	Fri, 29 Mar 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715282; cv=none; b=XBFc5GQAh7hrd0D2VVAYxglKZL8kjh5R8I1lI95ixplawGkpi7EIWGUF2rAIu+NT02NA5WUEp/GfjHA6j9NBSy0CFKHQMgKdZ3n/l5/EoMezo0AqzRcny9kGgZVRuHlfAaFrwOikwb1TGCWlsove/ZmsTecB05SfrnmAO2k+C1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715282; c=relaxed/simple;
	bh=4O1Vte6fsnpVIqKWi6MUYJs7yvI0UQm1XS+XRgmqiWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub6vg3+t2VNl9244gphcWP091ufK7SLUQIHU2q2D/Hm3yZcTJyhaG2ywCo7iqqUiF7PYHJoIuLL/ZTKQXq875YtWAJp8l6Q6YYVTvYhoHjtiZltPdScktMtVLAsJmX5rgbZr+ldr3RFSLuyy2vNSBya6vGtLAT4FydZI4tN3a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN3nPVCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75646C43390;
	Fri, 29 Mar 2024 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715282;
	bh=4O1Vte6fsnpVIqKWi6MUYJs7yvI0UQm1XS+XRgmqiWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN3nPVCXSnA0PnMUo+UwMRGazsNt+FAfFIuFhipsRFPDzCJPzx/NHpiD1FaLJsc+Z
	 BZ1SGqipBsnpk1/hjQbsJOBuLEEyGvHC82NzR8cWhXvy5lDyHHvvYO0X2ByTLTfIiw
	 PYuvIMzcPmnY2aWdCuOe4NfnCnMy71ygddpuQxsoE6OOwoog/H4uyjaw/wkERVm0QE
	 tz8+PCHYX9gTwrs5EGaiQH+Q+8sy0QP/z1sebJ6JOL2fBiYf7o97wQemTVHphYWbQp
	 oY1QFPXdo3quBawdqEnpW8ItU27nJ0ONhoWjcp+B1BV8ycd4GqeJXSv+wtGi85WKiw
	 J1SqA3cFCTuSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 36/68] ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA
Date: Fri, 29 Mar 2024 08:25:32 -0400
Message-ID: <20240329122652.3082296-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>

[ Upstream commit 0793e511c4c66c38dd26add86f7236bcdc70c3b5 ]

In order to fix the keyboard on ASUS ExpertBook B2502FBA, add an IRQ override
quirk for it in analogy with how it was done for other members of this machine
family.

Link: https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.mpg.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
[ rjw: Subject and changelog rewrite, fix broken white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0d..2f7ae709bb192 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -489,6 +489,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B2502FBA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.43.0


