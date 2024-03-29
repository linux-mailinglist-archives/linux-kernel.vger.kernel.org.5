Return-Path: <linux-kernel+bounces-124867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F5891D43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F5D1C2728C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E61C9EC5;
	Fri, 29 Mar 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnMcIdEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9E1CB321;
	Fri, 29 Mar 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716317; cv=none; b=pg6gqz5CRByV6/stt87yUkJGGUuz8mGdTfirDoR0uOPByRD6+S9IsrVdmKmZinXBN4GXtLCkewtdoSRIu5ZviUaee06uax4ZdmBNwZYO0wFkT7999iBx4oaq5MMkJOfPynfwQyopkkO1/8dMEJxYsLHgHfkL+x/Ugz/08B047y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716317; c=relaxed/simple;
	bh=yuX9XVGrAT1kcHDp/0Thq9ukxuSdmRxes7/j7tsWnhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyntCVVZtTQxxG6cYiH9Shvd1yb0QY9A5Jqo1/l/BAkz0Bh30POzOYMiBqgM0gSeEywL0Chqdxg4kymUhKLHy6zw8+lUCRue9XgCOM8z0kXCnDAIvxOpLORbIw9US9YK5ctCTJw7ByRAG8nyKXF5JzB2E0QmcEbm6QvrJdsRcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnMcIdEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B8CC43390;
	Fri, 29 Mar 2024 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716316;
	bh=yuX9XVGrAT1kcHDp/0Thq9ukxuSdmRxes7/j7tsWnhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnMcIdEPcWjfrRuQDE51VG/FDpABEbVGldHRi8rSVHM9tT1fk7ZN8Vj3UK7f92DAZ
	 jlyr2kAQPEo+tvBDHc6p6VWs4e/c4njUx0c6W0F1L1EQWRGGqI4ULf28P92EHG2USv
	 m2HvXKgK8BHOj9js8Zk4MtKSdmBxl0bjLUOosUT1RcbcP4Dt4sfq4wHwFzUsNQgsyM
	 VbKh7A7K00dlR6AKR6yvjgPV9lAv5fzc7q7225eitepMcBTsLWFNTL76yTIC/x7R3y
	 Yjwsw0FiSKI/K6XrX1xryZIl+nNDnASPkJcsT8PX1R+fqoReN8urNcUSEJ+Xb2JTpu
	 KwV2L6f8DLSDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karel Balej <balejk@matfyz.cz>,
	Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 58/75] input/touchscreen: imagis: add support for IST3032C
Date: Fri, 29 Mar 2024 08:42:39 -0400
Message-ID: <20240329124330.3089520-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

[ Upstream commit 90cb57a6c5717b83a110c0da720a03ee32ed255e ]

IST3032C is a touchscreen chip used for instance in the
samsung,coreprimevelte smartphone, with which this was tested. Add the
chip specific information to the driver.

Reviewed-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-6-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 9af8a6332ae67..e1fafa561ee38 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -11,6 +11,8 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
+#define IST3032C_WHOAMI			0x32c
+
 #define IST3038B_REG_STATUS		0x20
 #define IST3038B_REG_CHIPID		0x30
 #define IST3038B_WHOAMI			0x30380b
@@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3032c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3032C_WHOAMI,
+};
+
 static const struct imagis_properties imagis_3038b_data = {
 	.interrupt_msg_cmd = IST3038B_REG_STATUS,
 	.touch_coord_cmd = IST3038B_REG_STATUS,
@@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_data = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
+	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
 	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
 	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
-- 
2.43.0


