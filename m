Return-Path: <linux-kernel+bounces-86598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647E86C796
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078481F22776
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31CA7C6C3;
	Thu, 29 Feb 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="l39f0LH5"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12D7C094
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204332; cv=none; b=eP/xO9MuDR3Ba+rVnSnwQwGvIHMyIjQBT7PleoXRSwp3JQ6gvsvNBcSHks0cdbRBYu9GVwWl1JodMRWJ4rw/XQ4he3Pvq7oVfwD+mtb7WSK5J6hhdaYszN4h4WbfTbLFBvcjvFRI6WHGWwkwiFaSsuCCU/vvP192bgNjphHfYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204332; c=relaxed/simple;
	bh=ZbKsOmGSKAyPdZNFs9gxN3ij9YHd3GYHGCrOYJ1IK9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4N81bOh/IqimkIug/Paa/e6YqOoZE14f6+5hMoLKX0xNe4DIWJEDyfSHFgYtumXgx1es63XzLgB++QBugVYC0jTRKUZqSwApI4wH0aiRms1b5QU+wP78TzMciFL3oUbEvIeAGvqlGKp/7u6RHQUst2DHxPhD9ne/viW1z1pBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=l39f0LH5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zth6cqyN6gI2D0vPZW2SkkUMiLbZva005HC3qhC1wrE=; b=l39f0L
	H5htQ0M2kR5NZ/hcmyjWVV+a9nvQGpTeFcWkpey3Wu66p2ayE7ToyrrZWTX+mo32
	jbnCfVjfySnDRzX/7kJvgDiQDUPT9vDqQ431jluGxncZKMsoRhPNEumYAd9Alt+q
	M3hySeSifv7S2aD/BXkFnDayhF/dGEHauB6DEmuqu/GUXH9bs7WdIuoDKTFpvR0U
	QmxD3sFOMeg6RHKxT0qO5MfmCmeyBug0aw0lYTC9+epbO/QXGuK6VKoFAXrYM+/A
	4b+D+czZIGrXdx3tFZl9AMtjMj4fyW9DAo4KPs0JhVowjo9QxYC7TUh4TS+5GQ2O
	b8xPaSE1JxjCh1Dw==
Received: (qmail 2278110 invoked from network); 29 Feb 2024 11:58:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Feb 2024 11:58:43 +0100
X-UD-Smtp-Session: l3s3148p1@VO2HJIMSSD5tKPFZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFT 3/3] i2c: mpc: remove outdated macro
Date: Thu, 29 Feb 2024 11:58:13 +0100
Message-ID: <20240229105810.29220-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229105810.29220-5-wsa+renesas@sang-engineering.com>
References: <20240229105810.29220-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRV_NAME was useful back in the days. But here, being used once, it is
only cruft.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-mpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0b4de9e569ba..8d73c0f405ed 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -30,8 +30,6 @@
 #include <asm/mpc85xx.h>
 #include <sysdev/fsl_soc.h>
 
-#define DRV_NAME "mpc-i2c"
-
 #define MPC_I2C_CLOCK_LEGACY   0
 #define MPC_I2C_CLOCK_PRESERVE (~0U)
 
@@ -960,7 +958,7 @@ static struct platform_driver mpc_i2c_driver = {
 	.probe		= fsl_i2c_probe,
 	.remove_new	= fsl_i2c_remove,
 	.driver = {
-		.name = DRV_NAME,
+		.name = "mpc-i2c",
 		.of_match_table = mpc_i2c_of_match,
 		.pm = &mpc_i2c_pm_ops,
 	},
-- 
2.43.0


