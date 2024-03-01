Return-Path: <linux-kernel+bounces-88775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3586E666
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF38B1F29547
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81C70CD9;
	Fri,  1 Mar 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="i4f7gS//"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90111947E;
	Fri,  1 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311669; cv=none; b=e0YK5ISZKFaV4fmjcx39suf7fPdyrVs4xt1W9cPXxUAi7TP9MjE7hX5OtVVKK0LxTcc54J+gsBv0KtFvXlf0ylvePHyn++844j/0TqK6Jvy0S38G1JRat3fWtbhLlq4305FyS70wdwBwUpzIQZ8n57C3gSacu8TbX4Ro1M7K75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311669; c=relaxed/simple;
	bh=TwO38cA3UyCr2W+EpuHHLQjPXPcd10Pe64Cu4R4UPC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwSa8p/m9dkTnbqnYijT/Ak1bt2eeqAw46qZR0wZb+WsAWTTj1xgmY+dj1RaPutVmxPp9w0fnyUWXG0i/L0tFXg1VQJxZ00f9C/qfrGGQLWibJe9OyrrCy4gOx/SEisrGU3F7i3dMQKks0fzfW4TRnQxENCWqTB7tUPMJ842M2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=i4f7gS//; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 8239C284258;
	Fri,  1 Mar 2024 17:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709311658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7DmL1iFyPuL+YAdM6p9eG7fp01uB00uvAhrDZTooCM=;
	b=i4f7gS//gRybv9G91n4rfHD3U3QiMVHe+6kQ6HKg543tZlwYFWSeirBz1b8NB7+jZNC3fu
	0cgiuBMh8OKMRcDzFqXxgij0z4/gESuUIQX74rEZ3UGjt2StU43OCyqvDc06G+bNm8lhZX
	cOgXDxbXnoUy23vLudtQ1KKBxuNJIiE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 4CF374587C6;
	Fri,  1 Mar 2024 17:47:38 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	karelb@gimli.ms.mff.cuni.cz
Subject: [RESEND PATCH v5 5/5] input/touchscreen: imagis: add support for IST3032C
Date: Fri,  1 Mar 2024 17:41:04 +0100
Message-ID: <20240301164659.13240-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

IST3032C is a touchscreen chip used for instance in the
samsung,coreprimevelte smartphone, with which this was tested. Add the
chip specific information to the driver.

Reviewed-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v4:
    * Change the WHOAMI definition position to preserve alphanumerical order
      of the definitions.
    * Add Markuss' Reviewed-by trailer.

 drivers/input/touchscreen/imagis.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 9af8a6332ae6..e1fafa561ee3 100644
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
2.44.0


