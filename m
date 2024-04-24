Return-Path: <linux-kernel+bounces-157560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07C8B12DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9DE1C24E86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A720B34;
	Wed, 24 Apr 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3duIMAd"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0F1CF8F;
	Wed, 24 Apr 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984674; cv=none; b=UKi9moF1355wav04Wr1CXdfDzqFIpbSFTfQDuhZ6KVYIoP8oeZvZkNhNMisHZ2Q7Ht1Y3vo43o06ghMgYhGI+8M/7TbFgKvhBnQQrWm9t5/o0/xJWKqOs4Y5aNSKWxsAOnGlLiwB6nd5LRKQqw2P3iL+2kg/Nwr4RN+RBqhfQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984674; c=relaxed/simple;
	bh=3JKiAlnke7ad9UapGflQTchX6DP8jIuQysYvvcVfMbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIXkfFXoCF4IcU6XxLsMa/V7NPZWf0jrq9vFPg1TGXkAB89Zh0NKBRJIpk1OHn/8v/xUcVl44MBqn6nGE0NnuFJe4LSpRoyXYSxFdscIxq57d+zwSg7dbKpSuvLAhK8EmjhCTgte0nATBRELqLhhusRcksJ4TW7b4gKId2pbmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3duIMAd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b137d666so1186295ad.2;
        Wed, 24 Apr 2024 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984673; x=1714589473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj2xwdnfxc+ze8SbiK+i5jZDgRNHrTg59d272CHxPl0=;
        b=j3duIMAdMJJIcAyPnnd2dz/kOcQYnAzdqqK1dr8/VXVo0FHqs40x5HpsdU0P5EYsBK
         2sgl5yF5oebQ2KiSQYai07gS0hD0AI/WyrZoGs5w7VtXaP0w3BGf3++G2pYwGiK3Gj8W
         wXME/W+/TNrdsiojKAE7JlY4HRlY42rNtfcvsNsvk0J4BSa00FR+xtvWTvUpszV3kv+5
         OisZQpBKxos9lce0l30Oy+okNPOsIJ0AxKUHfq8cXh7XMP7FaW9vs0XZdNlllB5HKijo
         Ys1aSfFiJCFjwLR3TfLShyWnjmeKDawhIgnf+Ie8KLwFEPESAeF5ZL88TNRxtbGOZo76
         +o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984673; x=1714589473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj2xwdnfxc+ze8SbiK+i5jZDgRNHrTg59d272CHxPl0=;
        b=JtAiYbLAvG9tz4wl01Jbm+visJ3RD5wPVH5yp2++xhDKN3hC24t1mXTtN3sb8tSupM
         VLaZM/iqPUfTtKXMjFbBQe//M32HBlz8IgIZBIE4+h/e4TaSmn4ifY46z8JDweiYs1iD
         vunD25W1bQJgztN0bq2c60zBNqlsCc5uvOwDOL7QZ4KamiXtVyGqvA4fBAOmvV5usYWB
         kzOoL1nwmSay3QRqNzBoLWIz1aSwQJNW7297hkPU5or3mzUJHGXI3zeRYnTcqbKzJABX
         /J+vJjLTW1MracwrPyqU65jUh/iplU5Rl24yalQp0n9o3ZbZ9qZZr37ZOxRPQwztjAps
         wwsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3GPgRTpbGYrgz7PWNa2rAGUp3cwEYXYxtdhKDtmRvLSQf67lx2Ho7p5O7ynImi/vPZfC1m8h1DycL+ZsHTSXZOg5PtoIn+tpcBBd5UqvwMSug8hxbZMrCa2mge/Ny11qhnr52yRenVy7ywtbwiTlLjWQL/RbqLlQIigvFS32Uj4xtnDA=
X-Gm-Message-State: AOJu0Yy3mep7RS7dILP7euAmcy7XbwDFqeNVA2XBOxhFm+I/eG2ezJQf
	12NSeECpxOYiD3wHU6+QKCOioCidSDUjXYhxC+z0RMJHtroP1+fJ
X-Google-Smtp-Source: AGHT+IHFsfd1jX7pOazkuawT08Lov2Gli5HIokS31G862grOZlEAa7XZMq3oEvPkdYQNBTJt+IaKqg==
X-Received: by 2002:a17:902:6bc4:b0:1e8:b7fc:7f85 with SMTP id m4-20020a1709026bc400b001e8b7fc7f85mr3033829plt.31.1713984672683;
        Wed, 24 Apr 2024 11:51:12 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e425d86ad9sm12268728plf.151.2024.04.24.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:51:12 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Phil Elwell <phil@raspberrypi.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH 2/3] gpio: of: support gpio-ranges for multiple gpiochip devices
Date: Wed, 24 Apr 2024 11:50:38 -0700
Message-Id: <20240424185039.1707812-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424185039.1707812-1-opendmb@gmail.com>
References: <20240424185039.1707812-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers (e.g. gpio-mt7621 and gpio-brcmstb) have multiple
gpiochip banks within a single device. Unfortunately, the
gpio-ranges property of the device node was being applied to
every gpiochip of the device with device relative GPIO offset
values rather than gpiochip relative GPIO offset values.

This commit makes use of the gpio_chip offset value which can be
non-zero for such devices to split the device node gpio-ranges
property into GPIO offset ranges that can be applied to each
of the relevant gpiochips of the device.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index cb0cefaec37e..d75f6ee37028 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1037,7 +1037,7 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	struct of_phandle_args pinspec;
 	struct pinctrl_dev *pctldev;
 	struct device_node *np;
-	int index = 0, ret;
+	int index = 0, ret, trim;
 	const char *name;
 	static const char group_names_propname[] = "gpio-ranges-group-names";
 	struct property *group_names;
@@ -1059,7 +1059,14 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (!pctldev)
 			return -EPROBE_DEFER;
 
+		/* Ignore ranges outside of this GPIO chip */
+		if (pinspec.args[0] >= (chip->offset + chip->ngpio))
+			continue;
+		if (pinspec.args[0] + pinspec.args[2] <= chip->offset)
+			continue;
+
 		if (pinspec.args[2]) {
+			/* npins != 0: linear range */
 			if (group_names) {
 				of_property_read_string_index(np,
 						group_names_propname,
@@ -1070,7 +1077,19 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 					break;
 				}
 			}
-			/* npins != 0: linear range */
+
+			/* Trim the range to fit this GPIO chip */
+			if (chip->offset > pinspec.args[0]) {
+				trim = chip->offset - pinspec.args[0];
+				pinspec.args[2] -= trim;
+				pinspec.args[1] += trim;
+				pinspec.args[0] = 0;
+			} else {
+				pinspec.args[0] -= chip->offset;
+			}
+			if ((pinspec.args[0] + pinspec.args[2]) > chip->ngpio)
+				pinspec.args[2] = chip->ngpio - pinspec.args[0];
+
 			ret = gpiochip_add_pin_range(chip,
 					pinctrl_dev_get_devname(pctldev),
 					pinspec.args[0],
-- 
2.34.1


