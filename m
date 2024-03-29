Return-Path: <linux-kernel+bounces-124778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1947891C61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAF28467C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448B185F2F;
	Fri, 29 Mar 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG8aIaXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6A185F17;
	Fri, 29 Mar 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716127; cv=none; b=XVKDPTKGFxXvomRPDszJattm6ZBHXfe9Waljt+5VkdzcdsVbsoc0c9nNEOAhAn+OBtU3Nn/10E09fPC9/a2KUcdLvDkVV7EkPExKE+S45eyHqnOT/Ilul3OFXEwGkU9oev+NSRgDorGjBVo1vWZ0AUmD/VX687xKPdQrbaoU/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716127; c=relaxed/simple;
	bh=/QjzGuuut/USs5wAY2EV1/61sfdJ81IHHQB48v+JzWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMMKjIM6F1jlYNUSdhGVtbx2QUcLvDqlzhy8sek+t4ofYPSrdXGzPr4p3/oQOWoed9Jtg3uvWx7oEZWCHHCOn1/UuXqUqsaMXeVKw1R/mHLm3nd71iAuAYJ4jlw3eFs2ApbGBIjChgjWm5lFZ4Grqg+GXTFQ0XZH68i4a1pfo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG8aIaXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B640C43394;
	Fri, 29 Mar 2024 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716126;
	bh=/QjzGuuut/USs5wAY2EV1/61sfdJ81IHHQB48v+JzWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG8aIaXX/AAGgiXg8YGQ2WTWXniB4avE6WNBjrHZQUYkPqyL8f33XroKdWhk+WvJr
	 ISBe70FbOGsHWsYgFFbOxEdD/jFu+wwfT+EHiEr2kPRbufz2WeouQOWscDLwxHbHUV
	 E3wQRk1McRiVnSbwVs0YoanWz+ZeAc+4LKA2yFV0NG00ka55ftUZgv3J6xrYpgFD9Z
	 Fgb5EosvdY9vhQzAztsDZkMISPfJh2sDkfuKXqBNpeqARnrg2tuS0TjjG9PiaJkq8P
	 N67vBiEjnM+V0re8baL2+x46fGgy4luOPv+5Tlb0swrtz8GrZ9oHL+aO00E5zPUMk8
	 IxG6Q20zA0ang==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 68/98] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Fri, 29 Mar 2024 08:37:39 -0400
Message-ID: <20240329123919.3087149-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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

From: Daniel Drake <drake@endlessos.org>

[ Upstream commit cb98555fcd8eee98c30165537c7e394f3a66e809 ]

This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which was
originally put in place to work around a s2idle failure on this platform
where the NVMe device was inaccessible upon resume.

After extended testing, we found that the firmware's implementation of S3
is buggy and intermittently fails to wake up the system. We need to revert
to s2idle mode.

The NVMe issue has now been solved more precisely in the commit titled
"PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Link: https://lore.kernel.org/r/20240228075316.7404-2-drake@endlessos.org
Signed-off-by: Daniel Drake <drake@endlessos.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sleep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d112097..728acfeb774d8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
-	/*
-	 * ASUS B1400CEAE hangs on resume from suspend (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "ASUS B1400CEAE",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
-		},
-	},
 	{},
 };
 
-- 
2.43.0


