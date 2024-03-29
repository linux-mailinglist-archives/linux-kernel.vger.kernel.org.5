Return-Path: <linux-kernel+bounces-124802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C222891CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA97D287905
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33718E0FB;
	Fri, 29 Mar 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRPALXO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F39148857;
	Fri, 29 Mar 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716160; cv=none; b=qa/Fxg6ppZIXM6Wvyobau2at7ptT+Z86eysbb3qG6+Nm1uo7SE8H+n2DimeRSDyW33vHmcjqPfpDr7skbg1M7yt8l8vohY/EqDDLuDNkZa9UJxeu4zGe9KBtUqn0yRq00ZkLNSKyVwasxn4kjpd4MQijPyKs7sfpzBcwPfQtSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716160; c=relaxed/simple;
	bh=vRQVAlzqkZ4/vWP0Ort/kr1xUwekI3NUEn/LlVcGoGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3gPM6KBS5jLu4DlUVqzWcyb26zc13YpPMjqKcWyDE6xcF7U5qJvUnaOE3hRJrKbMxS/4856vhBOkodLuBA4GmmSa5PR2353EggjsUH20lKvlQdKTLnT125aqclYizw8sVFT5FEfzbO3VjCU530J67xs5F6gRkOCScO9wVP1HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRPALXO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208BCC433C7;
	Fri, 29 Mar 2024 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716160;
	bh=vRQVAlzqkZ4/vWP0Ort/kr1xUwekI3NUEn/LlVcGoGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRPALXO0x96o4W/8E5lq2N9G4gWbx5pqmPEPZbS8cKYETH75ZtnweX+B50DQlLx0V
	 9Lbi56uy4c3xyXhuMhtTifzCAzbmceKK6j/82Kb0YSGyjiFh6yFbSYRmxRYrXsAKYT
	 t4Tb7Ie4LcEvVJsY1vxgW0jc7X1/DbU63zd0fFAvF2EvNwQS3PnWMcTRCusAoTHaZL
	 LxOwZzllktfQ5h/KnI9UOB9OkgSF6xlb/2ZucnWIPQ7YNPV2D7rBSpy3oRz04SuGmC
	 xdmPuvepHsG0p2J1SUy7ga40GDvVhmP3nazV38p7FUnLxOQcaoVWR+wcX7OmVD61Id
	 Ral82cyFS1nOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SungHwan Jung <onenowy@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 91/98] platform/x86: acer-wmi: Add support for Acer PH16-71
Date: Fri, 29 Mar 2024 08:38:02 -0400
Message-ID: <20240329123919.3087149-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: SungHwan Jung <onenowy@gmail.com>

[ Upstream commit 20a36ec343d4c5abc2378a45ab5e7ea1ca85020a ]

Add Acer Predator PH16-71 to Acer_quirks with predator_v4
to support mode button and fan speed sensor.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
Link: https://lore.kernel.org/r/20240220055231.6451-1-onenowy@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 88b826e88ebd7..771b0ce34c8f9 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -584,6 +584,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH16-71",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH16-71"),
+		},
+		.driver_data = &quirk_acer_predator_v4,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.43.0


