Return-Path: <linux-kernel+bounces-60560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFEA8506B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFD1F21205
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E360BB7;
	Sat, 10 Feb 2024 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoYi3Gv2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285060884;
	Sat, 10 Feb 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602020; cv=none; b=C+8VFLmLIyWSU0hIXnEjXX1/YrUg2jm+Ste2TOn5C6Q0v1TibD2AybLl4+t4W2lNaOOKHNh3aapAC2rQVED0v4/nghUai+fJj+kBzOzRmHoGwulv97qgykHr6CxEZBlmBnQY82cAdqtMNU4i/rIf+S/sGHi/uvCUpVOcDkefF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602020; c=relaxed/simple;
	bh=bxc8EJBTU97uaAgMzrUDFX/3ZhRiWUNfsRvqcbGs/6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rdic3ixZ/7C5ualGvZxnQkxP17nGMhRF8puwaHG9kRQEu2Ko+Y0BDZGNTG4U9xy++M2SPagdcdyBy3j+wwIcT5S9sYjFF77TtmC7UGLbxb5Cj+fS7uou2ASowjRgZEVlQDQLjFnvW6bHLtYdE4XvEWFjbTk9JGWMEeuv5THdQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoYi3Gv2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so2465771e87.0;
        Sat, 10 Feb 2024 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602017; x=1708206817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fkky7a9eT7SBkGtnfLXUQcC5w2wTxfnvBE3rXTwzAA=;
        b=NoYi3Gv2+8slDlMv3RhL/qHd31BUlLKnVRzF+qv2auZpvD7lmwCvVUIv05HuT5SSK/
         DElsuwHLJSV4OKK6H4auehMVXfNPDbblZSlrTinsTNDm+jxElpfAEQQnDl98FAgX8mEK
         8lCcMg0AqTBqf4sJM8HecszL9/1NL8cTtOFEiQqEIz2jQ4PbKZwfjoCo+KrqeG4gRlBA
         1jXUNElXaQaTAkxarKj2C1t6xcyOPJVmkM+CLdgbRO5zFN2SETjaxLdVty5+8o5JB1F9
         jPpcWZ5/mSK411hw3LYJkLNo7zS1EHWUWGUBpXPNEGePQFNKT3IHxoNuBMqaHR9fvRHq
         8vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602017; x=1708206817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Fkky7a9eT7SBkGtnfLXUQcC5w2wTxfnvBE3rXTwzAA=;
        b=hY/RhWEuWjRpQ1iwZ/343kpYidMVeTaiaBuluyi45BOAdIvfoThNY6B0dz7MPLiMhf
         U+qynUeq6FiWyvP6v6c+wzLzEM9Re005gNvO4d0ZZJJXw1ywA0OF9T5SwyquutE3QQIG
         6lXiEtifpspja6Fed8R80RmgOmAiAB1YMnxtNClYKp202EhmixtY8lvJluQLDn9eBdwo
         EnzB5bBMNXH4jtEhBZ8JnBKLdtUAETE7zPwklKDo4sR726Xr8nJ3XTwahW1yRe5b7oMI
         NkT+boRooISU6eWDFkQy13a4G4Iv5nMXuIkKR5uIQXknaKDj1QddsRvlG3UsYI7qiStt
         iBpw==
X-Forwarded-Encrypted: i=1; AJvYcCWlDUnsa9pK9pyz7Mr4d11xvyi4uwm+XO6tswwbZ03Z2Fsdhga3GkTY/3SU/U4TVaABLSOhvDH3AQjMbXkHkaAvOi0T9Mm2wQfSEJSupH8SEoTanNOm5/VXYI6mgxnNjWSQe2QVJ1RRbLo=
X-Gm-Message-State: AOJu0YzHBPJWM5ta7d6P/b1cgnOAaJiz23dHIpu3x+3BS3jl4JAFtLkE
	3fIBUZcXvKGzkugXLnyDrQXs7ejwD5v+jgZhWZWNQ5dLHmpjOdyP
X-Google-Smtp-Source: AGHT+IGZUoy9DgL8eOxFwcpjypDGMxA0fTk4GJiEvk5rdmh0fCWaCal43bOtiJuJU0Q5RutWI4dD0A==
X-Received: by 2002:a05:6512:3994:b0:511:76e6:e0f9 with SMTP id j20-20020a056512399400b0051176e6e0f9mr2693656lfu.20.1707602016878;
        Sat, 10 Feb 2024 13:53:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLG+/0Sw+CxnHF8MX7j3iHqX+zPcGBaAxanzd5wx681sDEwNPArqysdIikDA+56j+wQl8/Sp1Psjc4tku6NgNJXyPeK4odAhY/2KvLaM3D1JWWFH8hASgDdsRMwus1FgLFjXCr1uXkNKMTGvNsDMpqxRbvIoMGCv+p89+cVcECbc66j6cTgrfodOLjs0Jy90IZBE5JfiaXqwJpZ64TYXh2EVTAc0VmeB9MVGKIjACkQuGb6TjsToPO7k3xihSiHqWsyvaafyzDfdC+bP4WvoiuU/J3OITE0ShldqBjCYDfVIjDKPKi563wMRSZR8W4E4zkW23r5K8ojposWyFg9M6U281Qui9SteWaLVDWmLoly9Pch5SGGw==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:36 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 13/19] hid-ft260: improve usb interface type detection logic
Date: Sat, 10 Feb 2024 23:51:41 +0200
Message-Id: <20240210215147.77629-14-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit simplifies the ft260_get_interface_type routine by
replacing the ft260_is_serial with iface_type and making use of
its return value as it's in the mainline ft260 driver code.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 3d1a9ec88cb9..9ecd91d173d2 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -309,7 +309,7 @@ struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
 
-	bool ft260_is_serial;
+	int iface_type;
 	struct list_head device_list;
 
 	/* tty_port lifetime is equal to device lifetime */
@@ -889,28 +889,25 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
 	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
 	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
 
-	dev->ft260_is_serial = false;
 	dev->power_saving_en = cfg.power_saving_en;
 
 	switch (cfg.chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
-		if (interface == 1) {
+		if (interface == 1)
 			ret = FT260_IFACE_UART;
-			dev->ft260_is_serial = true;
-		} else {
+		else
 			ret = FT260_IFACE_I2C;
-		}
 		break;
 	case FT260_MODE_UART:
 		ret = FT260_IFACE_UART;
-		dev->ft260_is_serial = true;
 		break;
 	case FT260_MODE_I2C:
 		ret = FT260_IFACE_I2C;
 		break;
 	}
 
+	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1713,15 +1710,12 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
 
-	if (!dev->ft260_is_serial) {
+	if (ret == FT260_IFACE_I2C)
 		ret = ft260_i2c_probe(hdev, dev);
-		if (ret)
-			goto err_hid_close;
-	} else {
+	else
 		ret = ft260_uart_probe(hdev, dev);
-		if (ret)
-			goto err_hid_close;
-	}
+	if (ret)
+		goto err_hid_close;
 
 	return 0;
 
@@ -1742,7 +1736,7 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	if (dev->ft260_is_serial) {
+	if (dev->iface_type == FT260_IFACE_UART) {
 		// FIXME:
 		cancel_work_sync(&dev->wakeup_work);
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
-- 
2.40.1


