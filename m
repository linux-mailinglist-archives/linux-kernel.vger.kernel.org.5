Return-Path: <linux-kernel+bounces-129286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE889683D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18BD1C20C51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AB8595C;
	Wed,  3 Apr 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZOnfFaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07794811E7;
	Wed,  3 Apr 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131740; cv=none; b=su4or7BFfNunVlPjnRn8cpg12Tqq/Kp+/8KTvNkDhdVUiyCDva6pQ3mhLXFCKRQthL12SoIZLFMmjpxiOcvbS0Ak/23rE45WFVI98bfgoe8lYglRNWIsgMBx1DSyWaVdr1mxkKspMm4dnO099N5Zhr1F/vE35B1mMRwILC9GSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131740; c=relaxed/simple;
	bh=X/fK2OdkpVR6C+bG/qhKxNGaMgR2KonaIsE01GrX9Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+XZO/EjtZ57sm7oiO1yaUcAVODPnAItn85++q+teZb5WuoLPBv9V/sF+6IN8VANn1YO91DsCZVnCCeBTNoi4iUp4KgU02QYWNhg3uBLpHcXFvdvtufww2kAGrRssWdfLSR032SJyVeExI1SYizxAXtMzkg2kwlfHPWRyx4h2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZOnfFaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964C3C433F1;
	Wed,  3 Apr 2024 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131739;
	bh=X/fK2OdkpVR6C+bG/qhKxNGaMgR2KonaIsE01GrX9Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZOnfFaYvyXiyoYAQRLlANr35Zpb67OxxhuxvGgxH0VrCHjq9jozy+tKcGwZ38wAI
	 AmeGN6klOXqXVhxuwSBHvAB9iA5NUHd9rWmK0kdrgn5fh0o1NHHzxcc+uTgllGiWcO
	 fiG660QKYGH6pb3EHVtygPAX39MWImnmPPVVRMuTOob3WxhwMc/zxAs++zzQ/cNSBb
	 JQ/nCyXAqVcTpUiJPOLNEroGe4ynv08QPavclC9sOyG3JQ/LIv8AnMy7AXzJWFjRtv
	 gDpEnzBZfmZyIyRQXqO5vD03+/sbIPmYkVh9yiagXSR4Y5oiY6ba4FUeiLVE5N4wUN
	 x7ynm0mD+c8+g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Anda-Maria Nicolae <anda-maria.nicolae@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Lechner <david@lechnology.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pm@vger.kernel.org
Subject: [PATCH 09/34] power: rt9455: hide unused rt9455_boost_voltage_values
Date: Wed,  3 Apr 2024 10:06:27 +0200
Message-Id: <20240403080702.3509288-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The rt9455_boost_voltage_values[] array is only used when USB PHY
support is enabled, causing a W=1 warning otherwise:

drivers/power/supply/rt9455_charger.c:200:18: error: 'rt9455_boost_voltage_values' defined but not used [-Werror=unused-const-variable=]

Enclose the definition in the same #ifdef as the references to it.

Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 battery charger")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/rt9455_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index c345a77f9f78..e4dbacd50a43 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -192,6 +192,7 @@ static const int rt9455_voreg_values[] = {
 	4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000
 };
 
+#if IS_ENABLED(CONFIG_USB_PHY)
 /*
  * When the charger is in boost mode, REG02[7:2] represent boost output
  * voltage.
@@ -207,6 +208,7 @@ static const int rt9455_boost_voltage_values[] = {
 	5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000,
 	5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000,
 };
+#endif
 
 /* REG07[3:0] (VMREG) in uV */
 static const int rt9455_vmreg_values[] = {
-- 
2.39.2


