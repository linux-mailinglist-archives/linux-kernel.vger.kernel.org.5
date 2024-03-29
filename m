Return-Path: <linux-kernel+bounces-125016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D1891ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA172288B23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189E1B8597;
	Fri, 29 Mar 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM2BnVNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A591B8584;
	Fri, 29 Mar 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716637; cv=none; b=ZU+DF57AKzKWY3VQHANxP4dIg8+nxefGiBNHLjsS6k+z4Hof6zyDzOqvKf5Y2RaatRADkJ1PxjcKxhV5Srlp8tMpOdKSlWUAKvhRtBfquI51EZpkrc+hNYKvmzZUL47chAQ1EtzOZpMP9vdLms8SPGMFfQhfzdBxKewx6igals4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716637; c=relaxed/simple;
	bh=zwcDsX9XqGeRfOXaV0OqiblrlYAFBRKPywf5cl6CGGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8HHtQxeF/PXLrOX7mG30UptjCbO2LluNJku4yYNLw47KY9lZrtX/bJ4wBn9Bf2iFfaeMDExTv0b0TqpgGbbjvLA65alqcvgF5FsICHI2GXdSoJ/zR1iDrJzL8yyiAk39YcTmzwF05bWUaV1hebMhkJ94xpToZRT4Q4GkvDQUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM2BnVNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5ADC433F1;
	Fri, 29 Mar 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716636;
	bh=zwcDsX9XqGeRfOXaV0OqiblrlYAFBRKPywf5cl6CGGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mM2BnVNaAHeHnDijNLleEBYKoSHIlFyG8VhAu8tNN5z3Q0h/R5+Df3cKGq2zBUozw
	 QVx75V1CqoAqF4sxjOpovhcCTvhoPxVy1jA2jkgfGKWO1xcpyLsP8XfTYkeAqV8KGH
	 yNk9QTs7CeZuX1r/cJ7r8llR2Vq+jx6k9/X+xT3b8pYWmXVmg1hI0Kq6kKN53jPTLn
	 O6CvqAavFcvQWJyuPXAlaIojF2JJKlZPwoiLe15rZMg+XKVMLvf//5cldcb4ggHS8a
	 odmze5gW9doPve2zX2E7TTUJPoF2rVZUSo5QfXjUNfi7fg2JlyrnfthT1wkevKiveH
	 hcycbbhnNVpmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/23] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Fri, 29 Mar 2024 08:49:47 -0400
Message-ID: <20240329125009.3093845-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index b9d203569ac1d..5996293f422e3 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -382,18 +382,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
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


