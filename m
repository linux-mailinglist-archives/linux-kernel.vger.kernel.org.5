Return-Path: <linux-kernel+bounces-125831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586A892CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F262C1F21915
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951445974;
	Sat, 30 Mar 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeIRiWzD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082841C93
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711828199; cv=none; b=RT/eG4lXdKVYQVTGVYLlameGth4EB2gmISDIUN9nANY8dd2GzscIVlOy2aI4M1bvvru0Lh/uIF0HYBtQHwEHWEflTpMjZgbBDdo+StXiVE+y6N8AeGhGlWGBQBOFlTqwQPSL2BcGyYidPnbsDCx/8YpPb7PZzmlDk0wgn7kHVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711828199; c=relaxed/simple;
	bh=TIu+fFC9OIBUqLhyjsNVKzlA9djiX3m9wVSM8WIu9w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIA1i9FWq/XuqoVrN5fjrWNAz9Lc0FlXwSna5i6L+aNXw3qMkev3R3sD8RAVe6YML1lvOdy72IzXdK/fjouH64f5gNyYO9JshuHQA0w1E60irTWy4GsNI6Cb9w+xWFeNOlWVUWI3jHaaReqyOa7w8NMx09VV5lVCFT11IlC/8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JeIRiWzD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-415515178ceso9249605e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711828195; x=1712432995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxstXRVnrMSo82l5gXcb6I01Op51WiRiTjfQdQAjDdY=;
        b=JeIRiWzDZBI/WeVjzscA1aGjjkAm1EYWXmBNaVEd8w7jSOWIrDtyisY+RP2gjq+izO
         ZLGypOMOVToL06THjMnaF+o3rvuPMkW/MlplXyfbwUvWHIAeBPKDhpcR3EDL7jgkKbML
         5FJF9HrdOu8loS4OD9Erefys4yZp+Vbnfyu8Qm4SWoZG9GLKHZTvbxEN7Xc6xTXo9buP
         aOz9gn8rwBIsik3BWDkn183hYBCYqoi4l9/eqWZCorLpgOlMBeBZPndPCKkiGmIBZOYj
         Drnrf5+u6t7eEVkVFRD44bw/XbY7VJlnXbKS32PS0tcQNGNVV7utxM/zHpIR84JGavvS
         aItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711828195; x=1712432995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxstXRVnrMSo82l5gXcb6I01Op51WiRiTjfQdQAjDdY=;
        b=GBCiOhD6bkUOoiYZdSZxysDHcyCbbKPN1dro7dvTw1OZ6mNLLkPPnt7VIshGRy+dqR
         XIpKQCFygWJTkcOloIf5YAvvJ6pyyTMMKA9kOvdMUgfXl//uyYkfniRQtfOByCYXR8gR
         YD6LjRtgKnQJjaOMHEwcph9tZwComFJ/4T6torqAAatiK/nOXrAmxXIazh2NkzIjFDJa
         i6S8jEaLF6/zGINmhHFa1MYNgDkPO8ZwDaJ5om4fV/45ivpsedzXYZWhO8/JoZCkqXvx
         zvuVDPPz6G9HGkEhWFnNH/CO+vm1dMJlywGZzFoPN+tfO694oDCrDxHRCMntnOboaXEa
         CE+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgRU/zg+Dd/j3GL1dL8cJiOXd1KF56l0s5SxPUnhMgt1qTrQPVVXMZhfn9MRWnb5gBrgW3wAxfVGhJNTlFSfLndOOAcSHpZWVvWLso
X-Gm-Message-State: AOJu0YwYp5QrNM5QJE5RgUTHm7DJuruNYCJ6YJNgdbyEKsXTZh8Haiay
	RW4BPiE0fmPnk6IIjDgevEKvwX2Nra7O50ccmETS8Vq+WBujVt2imTn0C0tJBmgdUQ4M/IcZDHR
	r
X-Google-Smtp-Source: AGHT+IHQUflMqlUGv5wUfT71RkwRUapmc7b3JWOoVb5iSDbnQjiM7CiZPG8o3guLIIED2PJY+5F8mQ==
X-Received: by 2002:a05:600c:3550:b0:414:6211:14a0 with SMTP id i16-20020a05600c355000b00414621114a0mr3854252wmq.2.1711828195407;
        Sat, 30 Mar 2024 12:49:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b004148b9272a7sm9571616wmo.0.2024.03.30.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 12:49:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 20:49:47 +0100
Subject: [PATCH 1/2] firmware: coreboot: store owner from modules with
 coreboot_driver_register()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-module-owner-coreboot-v1-1-ddba098b6dcf@linaro.org>
References: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
In-Reply-To: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TIu+fFC9OIBUqLhyjsNVKzlA9djiX3m9wVSM8WIu9w8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCGzfCLQFtVOOBVw9RS8kjhS/ktWi9RX6tGHLH
 B1M1vrcySaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZghs3wAKCRDBN2bmhouD
 13efD/wOaEE00AsxqMuQTxYQvvwpCS4Wl7IHVIiBVjJjzGFYdW8ZhAkEYGt3rYTwNg0rB8EsIFB
 8xWTMiJeNEd6m72hCAO2lLnQxdSDEhZtSvU3izurHwYNEfngE55o4sBGy+cb2zVUnwzfP5iFf+V
 5U6rGmBjv610XpHYXXwA3E8r2T9cWn04IywsvNatn7VCNx/UHWwBIXVGqqTNixJ3xLKW7J/m8VQ
 PsCkgGjbBETd4vj67u5outYTpYjrTGk8CogmrjbZr/D4XHoToQ4g2WYwWsIaQUVpDbOqNKLTVDt
 iDJspqaUheHvV9yeAGi0Y+o20bCdK0dHayrWw+1EkKquO8gGTrPBhSZyR1FZPzJ/tu70TNZA/sE
 nIxT7GHmfXdpV64tPZ+Jy6JIg9N3BG+U9uMSKlgGSzvqOndHEfPJP5SAQmVeEw/CistU6Ww4wLg
 +/qEMeQurarEOgJ+ZzBizO6HGBJZHb2886o+KAhBhVt9O1oYNxed2SGZvDrMVRoR9Jsdk5WtCWV
 meRv26AzE6FMYCObhmRk8p0NNxjMYwX2VsTIFO7NWyijV60fts7WcCP8amlH9Q2SobSiteO6BzG
 lYUfT90vr+plv+1wQVe5S4jp3fg/vStCw5NUXjbAXAQSz+LXI/SQSeZkfjjNchUIOD1T9dbf1Dv
 eaceSf2fd5NSdyg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with coreboot_driver_register() might
forget to set .owner field.  The field is used by some of other kernel
parts for reference counting (try_module_get()), so it is expected that
drivers will set it.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Moving the .owner setting code to the core this effectively fixes
missing .owner in framebuffer-coreboot, memconsole-coreboot and vpd
drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/google/coreboot_table.c | 6 ++++--
 drivers/firmware/google/coreboot_table.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index d4b6e581a6c6..fa7752f6e89b 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -85,13 +85,15 @@ static void coreboot_device_release(struct device *dev)
 	kfree(device);
 }
 
-int coreboot_driver_register(struct coreboot_driver *driver)
+int __coreboot_driver_register(struct coreboot_driver *driver,
+			       struct module *owner)
 {
 	driver->drv.bus = &coreboot_bus_type;
+	driver->drv.owner = owner;
 
 	return driver_register(&driver->drv);
 }
-EXPORT_SYMBOL(coreboot_driver_register);
+EXPORT_SYMBOL(__coreboot_driver_register);
 
 void coreboot_driver_unregister(struct coreboot_driver *driver)
 {
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 86427989c57f..bb6f0f7299b4 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -97,8 +97,12 @@ struct coreboot_driver {
 	const struct coreboot_device_id *id_table;
 };
 
+/* use a macro to avoid include chaining to get THIS_MODULE */
+#define coreboot_driver_register(driver) \
+	__coreboot_driver_register(driver, THIS_MODULE)
 /* Register a driver that uses the data from a coreboot table. */
-int coreboot_driver_register(struct coreboot_driver *driver);
+int __coreboot_driver_register(struct coreboot_driver *driver,
+			       struct module *owner);
 
 /* Unregister a driver that uses the data from a coreboot table. */
 void coreboot_driver_unregister(struct coreboot_driver *driver);

-- 
2.34.1


