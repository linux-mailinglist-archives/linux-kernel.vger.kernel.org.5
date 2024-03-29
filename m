Return-Path: <linux-kernel+bounces-124933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C5F891DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69371C27F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5CA1A568E;
	Fri, 29 Mar 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXyxV8Tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACE1A5667;
	Fri, 29 Mar 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716449; cv=none; b=fYDCCMreDSKFSfwgfRGJHyfZwUHB4E80/15PJ/wWBCsGH/Gd/AcNL9NQbT5oaWS12QIxNW4mLgTNKs6JzF8vZ3M7dtYxW8h3JVKf7KVYwVrya8265E3vfCR+RTmyZUVg1u414zx6C8TtF5giEeLm/KdTvej+4Rqiu/EgROWJTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716449; c=relaxed/simple;
	bh=+ydgHXvTtI2J3Q/wnAFUDwMjqi3X8xRO4j6Yq9zkydA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIfDuTrbs/+dNjhuTSCtvKHHaT9XR6kQknoUaPNVPHHoi2kxBx5T5SF+NRyZ34y+9eGEMzfD1LkDCAm48hbs2BrWoYnl9APSLzLk14YRipGEsbgRd3K6vrpfkVvi884ZjV+6yLeZDCGsS+diP1FYe/R4dKQ6/6Zln3mi9eAdKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXyxV8Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A5CC43390;
	Fri, 29 Mar 2024 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716449;
	bh=+ydgHXvTtI2J3Q/wnAFUDwMjqi3X8xRO4j6Yq9zkydA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXyxV8TnXxpOmRmmBYqn9NFKiWxpg97wT4+kwAVmXyrJNQTCu2NvLz4slbfegrVLx
	 tTMiODtM2eVCkz0HoAsdvgN7Moud/GoXRH43etWIiAdS/nZKJ86/M35pT0EMx9Bdu/
	 MCt7Ye8TiFjQ/9SQX3G+q3wo8Wy0spD3e8eipmazbWjuRT+nQGNL3b57GyNC5nDr6u
	 67IgibI3XBur8pA9gJqmleYg758YE+3GRIWF5nkoKvfdeZMaGAKPjyxkEbzIyHRM6i
	 oO0+etbzZUN+5IoHHzC7PYKec6lvrS2n7UJ09rzJkWL5HauH5EN5Ud+maV1CcnhgYd
	 IBGgfADxOEO+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 49/52] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
Date: Fri, 29 Mar 2024 08:45:43 -0400
Message-ID: <20240329124605.3091273-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit 1266e2efb7512dbf20eac820ca2ed34de6b1c3e7 ]

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Link: https://lore.kernel.org/r/20240227223919.11587-1-alban.boye@protonmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 11d72a3533552..399b97b54dd0f 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1177,6 +1177,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 dual-boot (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
 		.driver_data = (void *)&chuwi_vi8_plus_data,
-- 
2.43.0


