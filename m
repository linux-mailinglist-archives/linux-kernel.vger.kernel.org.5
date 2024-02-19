Return-Path: <linux-kernel+bounces-71750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA085A9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049A71C22BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736745BE4;
	Mon, 19 Feb 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yj1s0RZG"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9F4594D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363521; cv=none; b=GTZezX9KM7Y6uTb2SYfUXp4kmotyh6HratwIAQumv13Zo3HfxZddLkyZSjFNVnavLW0FHvNQEFGqCbsfmlmd3V003/FjoHVAPg25IqNpp2WNJDRLv8KCcj7aC6MXc6ONHu4BQTRf7faC7mglcBwMFYNHHxBE7p7CVtfwLRu7L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363521; c=relaxed/simple;
	bh=YIicIITc2ib0yQ8qRmPBSg2iHcrZN5WbeymMxz5U2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxQGTIa5I9awNpfF3B0Lz8OqDTZtm26yQmbmJNtC3gjXys19z0Nq3/zSUENpEPkYJ7j5AckxxOQwF6R9VCU/CzMfrSXFJsC6TsiJTi182Bs0v1NbyxJAi/t7s4yx10jwjTTqKdnCqjz/oIDAzhmzk8MJGP4iMrIyMzYBOjni3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yj1s0RZG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E75F440CBF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708363516;
	bh=c/dgxBV/ZRlDOQItl/9FyiCxG83XxCJBX32Rg820zgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Yj1s0RZGfYNP4QEUUdiFHkpKUuoU1aTUCdiWQDp9sXwSr95vJBNHNQsl/epEZEK9O
	 Z4ivNVFg3XHkdSq+Y6ReNgPEQuGbaG1LFDDlkaZxrKhtGUWOCgKT4yICw2hz17y68m
	 JF4rn4M17P0KRRK5VUiePboX04yayRSn8nQ76/IeGgHBNQ7y/5aILfBcMOVkfZyj/W
	 6mz5ZicF3u13o5pJi+7n3cT4bj2vG+trkfJkapRpKagbgs3HTdoi3nk6NzhiH6MqmR
	 y+3wKUehyYgKIgxQCAQ/ZoHiqTJ+bT4OsHcFHFktGcvqNbTs2p6KOmk77CihXXWYZX
	 QAaFLkKmG7RXQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3e68c15996so61107166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363516; x=1708968316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/dgxBV/ZRlDOQItl/9FyiCxG83XxCJBX32Rg820zgo=;
        b=H7CU7jlgXKdMupjotu4Jq/X03qKGhwj6WnhJqn9wPA5FMv+TmWINVe4qA0LbX7grvK
         jc8GGUlww72R0K15f4kUiFYZZMK0jPiT+9ajxWkzLH7prng1eKdog9CAFyEKwm4I63Dh
         /we/C7/fGvTFoet8PeyyOEyPAq1SzKNvRWW2sy4Hq0te8pWREcNjJ32ZdTztx9IK6RkG
         HBwaysD6Ks/L4kgTzYpyNH3AHWxrpIMaZq8ALWqNlHWqexl+zqqy6mU4Dk9/gyo4f5DG
         qDiR99EKNU6OnzSsm4Ghl428SU9XI3vwhBYpr8LZ5vLleCWYUmGg1F9PzCVCkKgISgzs
         /TNg==
X-Forwarded-Encrypted: i=1; AJvYcCXhi/zzYhuleu2PD+FWRQtAeLedL7glgiR9BOCehvVh3h7P9+g56o7OSnKBsKJrotiOid13oOFOFBWCZKyznueyQXlJ3ep6U3QVafBj
X-Gm-Message-State: AOJu0YxeFZB+gplE3KzNvTmUk/UVc2RFM16r4sAG2eWWKGaNJoJNmBXS
	Khtpzab+POmtUZfOuB66AL2lYuWdFQ2Ix3Z2Nt6tkZrIWUqxQisI3IZXpbuwSUAGF6EGd3yngir
	L3Z0eSK/WpAAc5mZM0hnpDiv0WyJD+r+m7QnfOm3gq2n5X4jWFVBsE8SLFjMJ6rmreIieaNA4Ho
	3k6wIB9duo+w==
X-Received: by 2002:a17:906:3b94:b0:a3d:26b2:94f4 with SMTP id u20-20020a1709063b9400b00a3d26b294f4mr9124375ejf.73.1708363516177;
        Mon, 19 Feb 2024 09:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVSGSt+679PRLIQruMOf2KigCwtnzXdW8xDu8nqC9O4FyyyEBwy3v968YzSCbhO5uck7J3UQ==
X-Received: by 2002:a17:906:3b94:b0:a3d:26b2:94f4 with SMTP id u20-20020a1709063b9400b00a3d26b294f4mr9124366ejf.73.1708363515870;
        Mon, 19 Feb 2024 09:25:15 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906370700b00a3ea4e080dfsm1032207ejc.42.2024.02.19.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:15 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jisheng Zhang <jszhang@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1] gpiolib: Handle no pin_ranges in gpiochip_generic_config()
Date: Mon, 19 Feb 2024 18:25:13 +0100
Message-ID: <20240219172514.203750-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to gpiochip_generic_request() and gpiochip_generic_free() the
gpiochip_generic_config() function needs to handle the case where there
are no pinctrl pins mapped to the GPIOs, usually through the gpio-ranges
device tree property.

Commit f34fd6ee1be8 ("gpio: dwapb: Use generic request, free and
set_config") set the .set_config callback to gpiochip_generic_config()
in the dwapb GPIO driver so the GPIO API can set pinctrl configuration
for the corresponding pins. Most boards using the dwapb driver do not
set the gpio-ranges device tree property though, and in this case
gpiochip_generic_config() would return -EPROPE_DEFER rather than the
previous -ENOTSUPP return value. This in turn makes
gpio_set_config_with_argument_optional() fail and propagate the error to
any driver requesting GPIOs.

Fixes: 2956b5d94a76 ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")
Reported-by: Jisheng Zhang <jszhang@kernel.org>
Closes: https://lore.kernel.org/linux-gpio/ZdC_g3U4l0CJIWzh@xhacker/
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
Hi Linus,

I didn't add your rb since I don't think
  if (IS_ENABLED(CONFIG_PINCTRL) && list_empty(&gc->gpiodev->pin_ranges))
will work when the pin_ranges member is only there then when
CONFIG_PINCTRL is defined and it seemed like your rb was on the
condition that I used that.

/Emil

 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b3a0f45b574..e434e8cc1229 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2042,6 +2042,11 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
 {
+#ifdef CONFIG_PINCTRL
+	if (list_empty(&gc->gpiodev->pin_ranges))
+		return -ENOTSUPP;
+#endif
+
 	return pinctrl_gpio_set_config(gc, offset, config);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_config);
-- 
2.43.0


