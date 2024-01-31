Return-Path: <linux-kernel+bounces-47265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C9844B23
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7E291B31
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8A3BB2A;
	Wed, 31 Jan 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE4m2gYb"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BC3A8D2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740654; cv=none; b=iFaOjNC359s3WymISqFNVUAY1KR0G7w8mwudC9p+OL+JhucejkUCvilj7D1S0oz/t3eJp3GHec14h0gHYkWisbAgDmPV0BuY9gTaX/hodRw5xN67S0n77DN7fXqKVAnIIddxoXgywM2PcZqz5Z5MdQ0S5s20mt8SH3+YF5NL7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740654; c=relaxed/simple;
	bh=qs2IwTXMaVMdAglmU0WRwo3NIfb2WrdCf70I7utlgJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxrFP0262kdSl3u0oO+Du/gth6/vlUbdlzVmiFMshsXDt13Vi7NPak0KhRRpgELaPcjuMQ4SCTQC9QdcNFjOSaPJobnhKjqew9uER4K244ejufq8anM9xha8qDKV0crgpIKwdeMetMHv3Bc0xLe0aMip1joEehTPXQTOeLbbsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE4m2gYb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5112cb7ae27so451604e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740648; x=1707345448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DrXHgtRj4uXVnKQSHYAiPmivQLWMpRFu04w8Lw2Uhw=;
        b=hE4m2gYbteTmy+sHgBEvYTf/3i94+39FzSnKtC7MC3Edb1qOEms7VKkvlcPFu+aMPZ
         seJrnYiHtl1qKDHtxzCS5F4zFH6cIMu+UeKZtUX1xpaue9JByhaYkclg5RYuiM5fJKi0
         8skSsGHf+W34cS4fsXDqF3BHpaKW5M5Lp9XJPhgIAQRd9BEuA9iy9BI5FKM2YQqLcp+W
         hSD6ogXPVM4tYdwQOLvSa8Ql6jtnZyVEPcY7S662e3uY9681auDMDnfshDVI4bCh4iP3
         wj0BcacuT0n6OiHw+LEufQYoHJJ9tTYTXvmHL7AGhcoksaH2ONyelbx5uhc2s0UGE63f
         HrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740648; x=1707345448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DrXHgtRj4uXVnKQSHYAiPmivQLWMpRFu04w8Lw2Uhw=;
        b=GXlO7ODVwhDeSJYJK5lT/aasBLN60oj7c6lltzEY3XiqPfMOjRovvnJj/zgRaU/+c1
         dRCDZk/Uo8kTlNdndGt5V4t2d3FE/E8L0Jq18tq/icC7d04SZXJq5sIlWYfMN/+sj/mt
         6SibvX3dlUDvV8MCRpw6M39PL8txqhM850qXy5rvK3h2qDhOi623voJ4CTXfIERW/1D0
         Hpi5kbchBWQzpBdhXw7yzHuTg2CjKKDdKkk3HMKu2TRSvDDqcvqhCxZqEE3m+JActXPU
         nqiq6n/3cPiImiexkC86A/DxBVa3Iuemn3hUU1RZQJRpPhRxclBQG8NhV8P7mbVzcR0U
         24SQ==
X-Gm-Message-State: AOJu0Yyk95ccth34AjEpfMyCxi2+jI+9PmGQbyHI8zU2na/qau4ITOpd
	PQEP6KKnzbFwMA4EoUs80+civOnFgnCVGjjsDrm+l1pq0m2D6Oh4qESfwaUpRAQ=
X-Google-Smtp-Source: AGHT+IHi2rdan0vzvY3WJ53/OhmnsWjwEgrGErJ9PujYvsVhU6yQ5terlMO9S1GY55tz3i4rJ67UrA==
X-Received: by 2002:a05:6512:74f:b0:511:ecf:e5df with SMTP id c15-20020a056512074f00b005110ecfe5dfmr480442lfs.28.1706740648240;
        Wed, 31 Jan 2024 14:37:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMQDd0jdlmjd8LP1gDqtuZnmdtJ/f8Xv3tT40eOqMozES6c/VXBoJuzMJweWxBCFWWaB01StTnH2fi2WG8laVUthcdxf1Bw8IiozdWj7hZ9jT+2Y+Yws4kQLkSLrjQyGJOEVlQ/t2C6tbfe4OIRPi8YzW80V+bEGdDuggS4QBfDI+Uak8OsVWouEQ5+59ICBDHXabvmZlpO2lV48Tl09GF0zlfJmTcZ5vUE+XM7JZp91jHRUlEMUAZqi6QNbebP2SiV9Ke8mHwCRsNlQS7su/EbFOGr9u3bO81mUHA/de45UDIoqi7D7fby3N87oco9+fBgXfgFeJs4SsIfZcYDox0yGL21Y9bwk7WvksU/g6eak5dcKVA8brkgRS+V5Vsz42wEjnbuNI8s7CgcLMhArrB+nDPh8CfJgB0lmgC1/K3Yen6kW3XIrsNkq1uGWgjPMpdUMnPYhQs3OLSMA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:22 +0100
Subject: [PATCH 3/6] brcm80211: brcmsmac: Drop legacy header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-3-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The driver is using all the modern abstractions to obtain and use
GPIOs and the legacy <linux/gpio.h> header is unused, so drop it.

Fixes: a8e59744e16b ("gpiolib: split linux/gpio/driver.h out of linux/gpio.h")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index 89c8829528c2..9540a05247c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/mac80211.h>
 #include <linux/bcma/bcma_driver_chipcommon.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/consumer.h>

-- 
2.34.1


