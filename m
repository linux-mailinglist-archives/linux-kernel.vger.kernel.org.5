Return-Path: <linux-kernel+bounces-124989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E1891E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B402283872
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BAB16DA13;
	Fri, 29 Mar 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojhVLaJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60311509A1;
	Fri, 29 Mar 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716574; cv=none; b=EM5y0K6Wua1j+WW+2yj4gcET4wNGk8iTQWT3SFj1bsyqT91+4ik6U6Tx9ha/WX9cBfjZYIvpf2JalAdsFJ9lHrJiyd4oDUyQemb0vEPcQwjKdJBZhdSwE6/asVtphsgt0GutKa65uMC9PWQEOrroEq9tnW1rSdXPbJUhVdE9O9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716574; c=relaxed/simple;
	bh=d1d9U2Q/lHi8ZaT50Sjyir2GFekjet1hwXT7QHEJXoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMSDRs6EjfkBMC7ZCJLKxRi2l1hzgluCsTb6HRZCG5UIP6QD5YFwLgMgweAmpuAZlXzujfCtY1sKcFZutTWvH0xO2fGODcXPUrROme8CM3rYpiEhL6e1Eo9gskBe1WNgch4rFBDItDsR4lbiy0MXcbg4eyq/qmspQrrH3O/eZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojhVLaJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DCAC43399;
	Fri, 29 Mar 2024 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716574;
	bh=d1d9U2Q/lHi8ZaT50Sjyir2GFekjet1hwXT7QHEJXoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojhVLaJ2r4AoDvEsJFAt4xHb8wraVDePKSxIvFFMY8cSRS0XJJ66MmJ19X8g87Zkh
	 uFwxZBK6xUgWo+Kx7ZkVdxP5JTu9yKasD76CXK68KWupsP5BIbw37uCcOKzTuaDtsJ
	 RLeZj4SWzn64ey2b8M21LC2HVT2XyiVXVB9RO9/M0zdkkF+AdkPzZO9orcRgQZpcJ8
	 07dW/3bWOjNuh/2abX6xisb9Swdtgu6pRFwXbBz5C6ifd5YpG9GRK7iIFD8p5bwZQD
	 1UcInGCMcLjdoZ+0KPLRVvEdUAH9ftlWax7WSbyQgjfxY1VDE+KXJlset7orebTchX
	 ZxGwHJjFIThPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/31] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Fri, 29 Mar 2024 08:48:35 -0400
Message-ID: <20240329124903.3093161-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 097a5b5f46ab0..e79c004ca0b24 100644
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


