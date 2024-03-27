Return-Path: <linux-kernel+bounces-120459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4788D7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF9BB21311
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CE31A89;
	Wed, 27 Mar 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVxAd6Hz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABF52F8D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525538; cv=none; b=gqxpiK/J7GNXlbfES1KBxBuAWccZnOxoRaGXAzrneo/9XAvjlCZ95mD5hE0TEt6SzyfjAFNAN6f6211RepKAXlrmLqHRlKmwm0+08GEi37OuKvQNSDYUSwqi9cpD84m8WBSNSJelsu48LJGjBFBWZHPrDmg1rCSGntxJEyMBfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525538; c=relaxed/simple;
	bh=EbQqgwvN1r65HWzJV7CMyjZrBbROUhFBxoQYQIT27zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRW7/neKf62CY/4zkcWvGs//rLlbszYzxJFA4NCtUceUdbf46ssOcOiDm+MjWD9dkHuhvcZTSwugbbx6wY7Ki3DXGsR1IdUjANLXHblrSKf6neVAWf2Q786t2X1d0WQE6SGTc+jmNvUnU+yaREIGWtmpv8SriebFwoG8nekUF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVxAd6Hz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4751063318so418349466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525535; x=1712130335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8Le4sUVJqd02ZBVvL3RJMgLIM4otS0YGGg/BKyebeg=;
        b=RVxAd6HzGyug0Fu8wNcggVn7A/A9G0zNtiDNtQpC566Inc/ZZw3a8X9scOWJ7f4nAy
         7zk3QxMEzCqX2rjfWuRp74uW6wAwAsx7zYU4eK9SwibmmgEsEbDOczLc+p2pxsnpc4pa
         o724+1tJj1kVVxGHD5RmMWms6f4SOKcQndLq2P0E5MeJqNgV1cUVDiv0SOuIMIgRSCww
         KjyLn5krdWj0SivU1dxCA3nwTxA+LGtX5Q2cqcmFn4PQJW8mDSnl0vcUpgEm/wZ3SN3+
         +1P7t/iWBKQd0a913U9wMrrsLXkcaF0PlPRH7ccZB/XciMQ5CGnLvUTAzDU5HMv40WB0
         2JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525535; x=1712130335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8Le4sUVJqd02ZBVvL3RJMgLIM4otS0YGGg/BKyebeg=;
        b=WlLDZBWFVz/b8FY2jfMXE7NB/OgXMGR4K5snhQDsncC3NaBPKQkfjHTg1b6+FB8aOU
         IUzqS5CNe4sW3vrIAjL7Wp9X/7oTh7rkv2wtjZ58HfuTUAu7WkfrT2Y0CozNeR6n1oQt
         UkRxywEWJv1xpilSlIS5wEKMZDnB2LMjezyRyC4WEfVtL5/fnHVJRD+G7elbOhooq3Wg
         nah7R2dkHdJ/ZrjKQQ0tDq31sr7uoCzvh9N3pnJ2TK/g1wGK0yfPh/oyOnHyNq1S4sqa
         bF99Lgv7migT8mVoc7Zrnj3fP0FSYxJZJnewgGtk+fcxPiXAnHU7HPT/JlCzEbAR+vVz
         PHag==
X-Forwarded-Encrypted: i=1; AJvYcCVwG8lVfWH7x2030MaLQzvNG6k7hMUN9GM/IgvkYIe5RipoYGuKvhPH8jIsD86qCu3TyVjeE2TDGkvHbtJL0CiWFnjBn7upmb3KQLw0
X-Gm-Message-State: AOJu0Yy1NTTRod3qGamQU41eMDPJ0JiP3OmWFQfGrsimia8/pWAMfIip
	mIbqs/Iq/Y+ej2I0xYLE4Yd7dJDLCPxoVzWHXyr1BH9hLY6whl+cGW5ff4vuJc4=
X-Google-Smtp-Source: AGHT+IEzV+BFKeOUwGwzEB25imi/izr3ikFPLCCSFgmAP/6NwJ5dgX43wK1Z1iZb2LJwr2waUzWPIw==
X-Received: by 2002:a17:906:6b8e:b0:a46:e595:f357 with SMTP id l14-20020a1709066b8e00b00a46e595f357mr2460511ejr.9.1711525535427;
        Wed, 27 Mar 2024 00:45:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:01 +0100
Subject: [PATCH 14/19] platform/x86/toshiba_bluetooth: drop owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-14-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=706;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EbQqgwvN1r65HWzJV7CMyjZrBbROUhFBxoQYQIT27zg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85XdoQt+iBMPFfmXZUU0oc7GLiKM89aryVNk
 EdtxJClnnCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOVwAKCRDBN2bmhouD
 10C+EACQl1pfOlRBl2OzmIaRJsekwhgmrNl6BMMODvybgz0CIP4FqjvvBmqhKD7p9o0nOQuxgOu
 vrN35MkGCmx9UIJbfyYSKAS1Ld2Qo+5s0XfsQWtfkrguihuIYFIuHEo/Y+3ZguxUzlCHrHm1DdP
 h/XtYAfRFrBLWyz23C/1vNTX22/yf5dP3iYB51WCmpTQKeXNtsctyLcdmSNODRgMcSVz24Ylzzc
 FbHPSxHa7pp1oELpBNEnkzBu1PP0rw5ML+M9SX47bnyvTdPHeKenk54LoAjP5H5d7GSyxuUuuvD
 8s12NfCrZlbPKcTiCrkYJV2L9Z2nOx84t6XG/cqT/Pokg9BGcVpV1ybD3fI14x8W4LwNrBSMWQa
 N3VlNRimdx5/mW04+CMBNJt6Ry1WqvT6OfCFuo6JnDNt3gJlyTIF+akG4bfY4DZ41t+iDjENYox
 JlTQLItFnN8Cngk8pqMmQwCHnX0fVNHgcUO/8Mh9IFM+FBWGJof3QeS2CclEHrUgnMupXYoH3ND
 oLGWTimM8O9vzFbYBB2VkV/35OXfdQflvvsE1Dtn6I6EU0zuG4YIqv+0ocQX8BdjpRYrSIaZWl9
 0iiy4R/mrUtVPli9VFrpeMFTn/kqIBuDsik6iIHJs/tt5JuPSYjy3JfPIYiRkGjzr0Rw2+LvAWk
 5PldtpJ7Pd7aC8w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/toshiba_bluetooth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..dad2c3e55904 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -59,7 +59,6 @@ static struct acpi_driver toshiba_bt_rfkill_driver = {
 				.remove =	toshiba_bt_rfkill_remove,
 				.notify =	toshiba_bt_rfkill_notify,
 			},
-	.owner = 	THIS_MODULE,
 	.drv.pm =	&toshiba_bt_pm,
 };
 

-- 
2.34.1


