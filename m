Return-Path: <linux-kernel+bounces-157561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4B8B12E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECDC1C243E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144118B1A;
	Wed, 24 Apr 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQbWBH6J"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335B208B0;
	Wed, 24 Apr 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984676; cv=none; b=UxgcV12/V1QBs7tRPwc4lC855luuaf+kAXb/g0T1o7US6aiL7i8SWw0CGOzuCwx5XUUb8pD9iP51DACgo9jRsAJ4/59j0dUZtahVJnI/hkw8gjl5YsF49B1OLwvphKbeBdcZlBM5ILyLgJ0TK6Mz3b/QrkaJa9t2r+LwjPrz/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984676; c=relaxed/simple;
	bh=FMYtZTU4m/aaM/hLt+IYtsY//iU7mILC9fcIqhJS6fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSWV54NSMFi1yNwQGMHFsN6ncfv1pL8IxOu509ODzg6+VUlMTYC63xWtL6aksJtTlEJ/OD7pdUgKcAH4i/9VA06rFCscLvqo/BFO7CYv5oYSggwiFF9FQGFa99itaC6tk6x21Qms4FaFQsA9ifnrEZQfQ9KQg2fRnnoCpyl6NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQbWBH6J; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so223047a91.0;
        Wed, 24 Apr 2024 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984674; x=1714589474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6X+5q1a247m8fqLqnCGs505zqCuuzBrbu8TFFgUqlA=;
        b=VQbWBH6JlQlqm+j8i70Ykio0K7rMboyRFhbV77rr66oVXfikZd7pQsc/Di/brGYZiB
         BI9NDINlXPZXoI9rd208xT96w5iwKS1irKmr9Ox0jt38gK0EskBWHFYyfXFf33v2cEhR
         oeGd0cz5YmeMHcncyINu7IklILzvoOrlD1eOHO7C0hMFXQ+j+ZS9VBiS0BIeXEx/rLoJ
         YjhC9rmnnu2OyeAeHXq2jmejOzHePzWsGxPeEisUSMIM9UwuxPi53Y3k0W0fMxR94E24
         eXC199kDIhdXJTB7rsp3eltHSvYeoIXA3gNj0XNBrcE3xvMilMPVaOLEV9ocULbKUt0N
         oJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984674; x=1714589474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6X+5q1a247m8fqLqnCGs505zqCuuzBrbu8TFFgUqlA=;
        b=wXhYrxWT6EVOY+TFI0fFN+ImmlQc4trdqfvTX85cGe7qNRaqgObRGXcTWCNHEk6wHq
         TiCl+0ZGlwGnGOeD5FtfcuFAL4FINur1iEz4lj27j7EGOtEP5KSJxoh2PzUf1Q5GmrHC
         ZIDbcVPd4HBMxyvXmeAn2XZl9NMGityy9X2NLDK76shmVReTHOivT4Fe7MFkreIio4d2
         MuYD/0ZUfJ5GjP5lzoPvk+84xaYXc/oSuLdH/tSvTc3tpc/ibKtq/is449wmkHwmuOZg
         wZ5mD/kClIpzI3XxO7Sv505GJ8feKQDU9GR2ZGlM46/aNn+ZQGsk0e4yFrjHcuOqeY1E
         22Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX3QpWDB7ZrEzKmd9XQEVgr8CHMgcL4GyhocQogapPN5C9BXtf1eh1HCcrIyHF+UmH98JLY91qQD43zQdtnQH3LsgqsZx4wOd281BcgxQdX84ABWyZ4nvx8QRaSLmYw321RBjI1h7tS7FwYPs77/PdMztZfWZyg3GaAgPo0JVDht/tgNvs=
X-Gm-Message-State: AOJu0Yx/eZQ0YoQp1A/q3QAIIjb0lUXH/pOxkg06dKnGoB0I4tg6Wtbx
	c9QH07k3Oiz1OrKkkruttPLlahXugBgG+mxpm9bxS9uIfGQbR4Xf
X-Google-Smtp-Source: AGHT+IG2S6ThdztYb6nuOhNHcsI2+OyS+uqKCdcFORMaUGu/yUaxmgf9JxNsSHJqm+2ECP5SHr4tZg==
X-Received: by 2002:a17:90b:1d0e:b0:2a2:f284:5196 with SMTP id on14-20020a17090b1d0e00b002a2f2845196mr3224723pjb.45.1713984674335;
        Wed, 24 Apr 2024 11:51:14 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e425d86ad9sm12268728plf.151.2024.04.24.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:51:13 -0700 (PDT)
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
Subject: [PATCH 3/3] gpio: brcmstb: add support for gpio-ranges
Date: Wed, 24 Apr 2024 11:50:39 -0700
Message-Id: <20240424185039.1707812-4-opendmb@gmail.com>
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

A pin controller device mapped with the gpio-ranges property
will need implementations of the .request and .free members of
the gpiochip.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Tested-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/gpio/gpio-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 790cb278b72a..8dce78ea7139 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -694,6 +694,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		/* not all ngpio lines are valid, will use bank width later */
 		gc->ngpio = MAX_GPIO_PER_BANK;
 		gc->offset = bank->id * MAX_GPIO_PER_BANK;
+		gc->request = gpiochip_generic_request;
+		gc->free = gpiochip_generic_free;
 		if (priv->parent_irq > 0)
 			gc->to_irq = brcmstb_gpio_to_irq;
 
-- 
2.34.1


