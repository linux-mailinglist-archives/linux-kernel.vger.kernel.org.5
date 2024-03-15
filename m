Return-Path: <linux-kernel+bounces-104610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1CC87D0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D207B220DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98A446BA;
	Fri, 15 Mar 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="uZzgZR3g"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6933FE47
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518672; cv=none; b=rZpgI15FSI4riU9IXssfy1B7JSrCoPdZRInONhDC7ymHS6rOFoSAMBSPmAIfNhuqCk5AqLCg21CIj5NRfynmdpcpr+/EbeccDa1qCqKSHSrAFi0HVWiX09kPj00/DHmJ5ponigPojd132MfzHl33YE7JIu9u21BYC2n7U5Ry9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518672; c=relaxed/simple;
	bh=Y2vBhougN5jQh8rv8uN/2CT0672Y43Pi3tSh1ogMX2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t573QzXcBji6gyi+W8Z35gcXCPQTfLrQQxETQugtY2UodV5cJXBSzZ0LLqdWp1pgBXW0S8MIH4pY9gdmO8wUlWmZ+GzXeDwGWK+xVymnkEZ8TEV+PpesdajjLSyQPATKookLxlfonelMI8dWb5EJNVwFKFJCrL4crK4UoS6JXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=uZzgZR3g; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a27d30aso303585966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1710518667; x=1711123467; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEkvKZn2d1cHdZ6UttH48shh7x+tm1u4UGnsox8Pajk=;
        b=uZzgZR3gWzYUgt/PZJlVxTY2ZE2sDeoc5K7567+HJU0/fuVvB1Qu1upq5mz/GYXa+S
         /+pR2KiSopkUproiZseMX08QLYr43IAgaxpize6zSSEUV5joTjN5IO5MGmGYavvNRDuZ
         Bz49D/MnZ/fTjqGcPhepTE/mZHZ+/BeC05R42AaiFzm1unsNLSab4C2/kYu7FjsCqHaL
         0ni3qj1R9yCOdXKqfTLvZ3aB7EIoXvB5SV4x+zck489dCIDC4Tn25BIi1Nu8Etq9QhiX
         5DRs2baCbK4ezNzNPFKMFivdhhOBC+W58ipuaaY+6ZPYAoEm4mMlisyQFfDRNrE5Reqb
         FKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710518667; x=1711123467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEkvKZn2d1cHdZ6UttH48shh7x+tm1u4UGnsox8Pajk=;
        b=qV8CzglaNVVnYoqMGOBd8eW1liDyL5kevue/uaOKYdzSXMGUZ9V7q4w1rl8SnIoKnf
         uhiQXub2q2Wf4ldO5wanFjfE6df8wZk1/nIQdqwzgL4RIAml1qCZzz6gEsLOlIbdYC7P
         BcfAuqGZou7P4kBae+3+dlpSwRmYIYUiFkjjIB8EsFzyVp4urTXEqkY0JTTnOfmN73vn
         gz2kEiuZZyGKNUfVVk0NDykuyW5WWYIh9OSfSjUp7GzZuNfkilWVhjsa7AuMFmSEX+hz
         Uhk1HSHMcy0CYUa6Vmzv6MZT5NhJtMoM5GrSPkBOIyVMFQ/nBHWE8dSkDrdvc1ppMeoh
         fLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUOkkMpVi0FAGBm2lM8rOX/6WCtn7zp20HvYXVBvceYsrRHsbp8XJ9GiW3tCWgk5QW/7OpzgZw3Lm1rCkabeDFA0PJ3SbIKxu8XJ2ve
X-Gm-Message-State: AOJu0Yyx+F0ii5FgIqura2Dr5Inqz2d/dUVbDX07i/iC1/rDBZEFu72r
	YeP2U4XeOGjwfZq9fsIy8rmsX3zJ3OvxBcq2J9XGwh/kCpgmtZQaKQ6LahDadGU=
X-Google-Smtp-Source: AGHT+IHsdRPSLjh2pfnZbg/sjdZRuqxBUf7OCP9LULpsybl02qKzFwkUtJvej+Qmg2MWXFSq72Y/Xg==
X-Received: by 2002:a17:906:c245:b0:a43:f22e:57a6 with SMTP id bl5-20020a170906c24500b00a43f22e57a6mr3672338ejb.67.1710518667125;
        Fri, 15 Mar 2024 09:04:27 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (213142096067.public.telering.at. [213.142.96.67])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170906aac600b00a4673706b4dsm1648047ejb.78.2024.03.15.09.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 09:04:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 15 Mar 2024 17:04:22 +0100
Subject: [PATCH] usb: typec: ptn36502: switch to DRM_AUX_BRIDGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-ptn36502-aux-v1-1-c9d3c828ff2e@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAIVx9GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3YKSPGMzUwMj3cTSCl1D05QUszQjC8vEtDQloJaCotS0zAqwcdG
 xtbUADC3eFF4AAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Switch to using the new DRM_AUX_BRIDGE helper to create the transparent
DRM bridge device instead of handcoding corresponding functionality.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Very similar to this patch:
c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
---
 drivers/usb/typec/mux/Kconfig    |  2 +-
 drivers/usb/typec/mux/ptn36502.c | 44 ++--------------------------------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 399c7b0983df..4827e86fed6d 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -60,7 +60,7 @@ config TYPEC_MUX_PTN36502
 	tristate "NXP PTN36502 Type-C redriver driver"
 	depends on I2C
 	depends on DRM || DRM=n
-	select DRM_PANEL_BRIDGE if DRM
+	select DRM_AUX_BRIDGE if DRM_BRIDGE
 	select REGMAP_I2C
 	help
 	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
index 72ae38a1b2be..0ec86ef32a87 100644
--- a/drivers/usb/typec/mux/ptn36502.c
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
  */
 
-#include <drm/drm_bridge.h>
+#include <drm/bridge/aux-bridge.h>
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
@@ -68,8 +68,6 @@ struct ptn36502 {
 
 	struct typec_switch *typec_switch;
 
-	struct drm_bridge bridge;
-
 	struct mutex lock; /* protect non-concurrent retimer & switch */
 
 	enum typec_orientation orientation;
@@ -283,44 +281,6 @@ static int ptn36502_detect(struct ptn36502 *ptn)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
-static int ptn36502_bridge_attach(struct drm_bridge *bridge,
-				  enum drm_bridge_attach_flags flags)
-{
-	struct ptn36502 *ptn = container_of(bridge, struct ptn36502, bridge);
-	struct drm_bridge *next_bridge;
-
-	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
-		return -EINVAL;
-
-	next_bridge = devm_drm_of_get_bridge(&ptn->client->dev, ptn->client->dev.of_node, 0, 0);
-	if (IS_ERR(next_bridge)) {
-		dev_err(&ptn->client->dev, "failed to acquire drm_bridge: %pe\n", next_bridge);
-		return PTR_ERR(next_bridge);
-	}
-
-	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
-				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-}
-
-static const struct drm_bridge_funcs ptn36502_bridge_funcs = {
-	.attach	= ptn36502_bridge_attach,
-};
-
-static int ptn36502_register_bridge(struct ptn36502 *ptn)
-{
-	ptn->bridge.funcs = &ptn36502_bridge_funcs;
-	ptn->bridge.of_node = ptn->client->dev.of_node;
-
-	return devm_drm_bridge_add(&ptn->client->dev, &ptn->bridge);
-}
-#else
-static int ptn36502_register_bridge(struct ptn36502 *ptn)
-{
-	return 0;
-}
-#endif
-
 static const struct regmap_config ptn36502_regmap = {
 	.max_register = 0x0d,
 	.reg_bits = 8,
@@ -369,7 +329,7 @@ static int ptn36502_probe(struct i2c_client *client)
 	if (ret)
 		goto err_disable_regulator;
 
-	ret = ptn36502_register_bridge(ptn);
+	ret = drm_aux_bridge_register(dev);
 	if (ret)
 		goto err_disable_regulator;
 

---
base-commit: 9bb9b28d0568991b1d63e66fe75afa5f97ad1156
change-id: 20240315-ptn36502-aux-15dd6f289aff

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


