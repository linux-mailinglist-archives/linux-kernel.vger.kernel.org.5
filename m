Return-Path: <linux-kernel+bounces-124914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88A891DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CC4285CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32182BF318;
	Fri, 29 Mar 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4A9UUTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000642BF302;
	Fri, 29 Mar 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716422; cv=none; b=seRsN6nfvsrS9T5J9P05V+KCUnfwarE/DNDYcBDgLlIyAdMgOk0ocPtt7AwjXCS7hkXuaNAJRSk4QCRHHWRJJTVjRoUxWxYZlNLbZIcFByavHhwRsbDQrHpkQecBx8YUE8tmPnTkjGTPaUJlXGLtGAC0CdnYJEXMFXJt220fmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716422; c=relaxed/simple;
	bh=ed2cUITjT6VQusC+aW3CeplbXf3sbglIv8AIqMzuOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tigfmNhflhu9T6eaPR60O0q+gTh0bqXt02rRpNLb2G781kIsK+sLDsz6ZgboslA7XjTIqkjMW7ycPTlT33CjvWCqaTOexEvZQfCByUU/iWG1UVpMevapXlaN9dukA88RapJ0EEyrWU0SH/8qt+CH2kyoVyCmO0qE9FnbwT0/HeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4A9UUTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9322FC433C7;
	Fri, 29 Mar 2024 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716421;
	bh=ed2cUITjT6VQusC+aW3CeplbXf3sbglIv8AIqMzuOvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4A9UUToKUuzlWmmFJDTePqUtsalelAA4vGoMs9pyPtx7I1HL5jUR0tzF/g50PP1H
	 fVceeLQAXWOtlAf/swcZW6l4WsXdLv+0X78BwnMe4hlHFNs1xezc+n0NMenqjDitMo
	 Ia5lvnlhKRze5FSZ4BX501uMuHPkTr5hjaGwM+a3tAHwRcCI3ndFQpE18/7yz0m297
	 yt6064U6zfjqLGOp6oiBgn365TSh816DNr0ZvkHlk8dbftUC/zrsqJaMRyF1tc7nKz
	 nNdOGNhfk9vJk79q8jIHdZp0ImP53PzcYGA1AIuxyT9B1pyIeihmtSs20mFEIeAstS
	 xHRkCn7blPT5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 30/52] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Fri, 29 Mar 2024 08:45:24 -0400
Message-ID: <20240329124605.3091273-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 539c12fbd2f14..6026e20f022a2 100644
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


