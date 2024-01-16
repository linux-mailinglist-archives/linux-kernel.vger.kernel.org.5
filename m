Return-Path: <linux-kernel+bounces-27679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9282F403
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A0A1F24A04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956C1D54C;
	Tue, 16 Jan 2024 18:18:45 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756F1CFA8;
	Tue, 16 Jan 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429123; cv=none; b=CPDFdZO/wLiJwxWitzjdA38XwIISmGENVCTShPD4aIK1TX4LoiPQs+vV0BQ3vdHUqGSQZ9+m9PfSeRkz6wDtL5z3f9yCp3pFKxk91N8/UeHM7U0R0JX7+tjPFgzWDK8oZZOFO4wwUILKA85WunYPobBOzoSWP23HfvZqpyGSnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429123; c=relaxed/simple;
	bh=QHO9UQMEs5KY0cgVzuXHyTQ8hJjnYblKkQRGc4wBjq8=;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key; b=As20v6jmlLwmmVxK7iB7f9Dq+ewTgSnGC0wmpwUcdtKmACk7M+SmTduPe5DTJ2FqFr3PdcQCArSu78SLVxYkJ2ZG32iijaGTvtjQv8A87RN4WI+wIrkXnp+HYXZyhRTM+ReIAEZICC8ECzzaDQrMX17wB2LlDe9uiJ48ObHjFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 8A2258AA33;
	Tue, 16 Jan 2024 19:18:33 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 16 Jan 2024 19:17:47 +0100
Subject: [PATCH 1/2] ARM: pxa: drop MOUSE_NAVPOINT_PXA27x from defconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240116-navpoint-removal-v1-1-593ae4954a83@skole.hr>
References: <20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr>
In-Reply-To: <20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr>
To: Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=QHO9UQMEs5KY0cgVzuXHyTQ8hJjnYblKkQRGc4wBjq8=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlpshZphHiIKgo91Jkvc5Qul/7GDtz+ZKyshc41
 v4yNNyf5eCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZabIWQAKCRCaEZ6wQi2W
 4YwMD/0bfbz2aIxE1NkfuZihRIZj+XOgBCaXr57qwMpS39lzlKENq5m1tU9Gx/tgIToVY7/eEWa
 2eHSB3IUj1C/l6bRdstbN1U/fcPJO4Cm4LAdHcvzMw4nIdvJHvzjS0onisfQrTg6ybWQaVWJNZH
 BsjIfvhvWR3gQ87VtbFiUQI2p9Q57WJU5yR8by57+GK5pEZUkozGTHXSFFbp9Rn/oDcBuVTpYEu
 KLDcfQSW3L+74VnwQeYIyAVfOWKYKti5Oprhd0Vj9GahMeD0hYh2oHMJY/mwkbRxbFiLuS1mnD7
 NluAbmA8hhW4hJAlogDtFfwccrCXAmPUR0qKxI0tGDQ7XJqLex+tI0t/0wLS7ehZS/HxXfsRc4x
 XFu7FEKgw4IxO0YBYRZLGQu7N4ZBERWdw9iC+wq3treJIbxrxgg000qb4ytstdwJpKNB+5TLpsm
 eRdqqjSPFr5ItfVAWKD9/O4FQk3uwA85rRy1/ody9Y3otcCVJhQ6dFY91PxlRgPaHhyG90rJqx6
 GLip7qgljT/nhnLe8L7GPP8/J0AZZLeQqsWAHGPaYNgVAqGiee3AbkaERFv+kkeG19Gdqqcq38U
 u60yjjM/3xU9JWopCHErRitqOXNI0WpN8kSdxvtMn1bvhIyP7grvxA5Xtaz1jxktvfZqnAqqC7K
 SKlRZPCg+VsK0vA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Drop the Synaptics NavPoint touchpad from pxa_defconfig in preparation
for removal of the driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 9e81b1849e4c..960a7f3efc3a 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -244,7 +244,6 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_SERIAL=m
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=m
-CONFIG_MOUSE_NAVPOINT_PXA27x=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m

-- 
2.43.0



