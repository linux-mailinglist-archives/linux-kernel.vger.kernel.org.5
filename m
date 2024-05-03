Return-Path: <linux-kernel+bounces-167505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CD8BAA88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016142824C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385161514E5;
	Fri,  3 May 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muyJZW0K"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056F150991
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731068; cv=none; b=fuTA20hXIOlgcrodiF/bQV7brp+NoJC+Dk6srz2hw6JUAdYbXVose0PQcOygUHID2kCtAFXi7vlOcSw6mQFgBsOo1hvFZCO0xm0JA1qovA5Mqff5xeSOitbV21zwsY67RVJzBudDn1VhxvtFgSqPf1mCJ1mYtMPDPFH7ytmWOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731068; c=relaxed/simple;
	bh=fwfKG8ZRMuQy9n8iRy2dfyr5NtXqms4juIZ2/nyVcTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ypx0U6oKpD9nM6cclXahXFzWbPZW+HPZfSSsY7aTkk2bHPJdO/NubHpp7ORaQfsT2Ke4AwDXESEbc86/6iyjM9zWQrdmTNqeFjbZZPpkI9/JE6y5/IwcRr5jTjklP9uz4IHliyL3uj4Kw2JV6BvrqY4IzrB+5hdR/wbD5VP8MOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muyJZW0K; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so109919341fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714731063; x=1715335863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyCFzpo5qJGMxdVIFcHH9iqjN/KbhdmN2jOVI2WS+r4=;
        b=muyJZW0KHrfRjv0rOVXb0f+O0kAqQyZSsflJg0r9hZ0qN6uAuwHeCnypl997285KHt
         gjPcdF67LfrwEM+BQ/leoA4TT3ioqDTdnbQpblAylpE0Li9UBOU4YH0iyj0eW13CcOiR
         jzNNjBEoHfchB3GFJNiHfdI0jAhtx7IiB3mGecHs+WTYaj6Rdk+YR82H5vIr7jT4RIj/
         7yBhPWA6iUci5CUYZE3XuxtbGbHOp3snjuTppFPQkTuE2WAgia9YldUtMW0o4+/ECTOF
         WKQ4HJn3ErrrlqRnwPgTLBryVenyZx7kSGaTB4mR0BQCfyEvbOSfA9Ve1dK9IVqLj4Bj
         w+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731063; x=1715335863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyCFzpo5qJGMxdVIFcHH9iqjN/KbhdmN2jOVI2WS+r4=;
        b=jIdD2V2wwsfPUIGZubss0TSPAapB2BV8g9lKMv1soLfyd+esfwLWJVhQSO83hXXVWV
         qbjsu6AdiYbc27+7IGsubpsHGOQoFDUnkiaMExVHPz1ztMl1YzbjOSXySw4T1ymAxhkj
         8ZERt694E3iXpX3A0VHDzjxlE4P76ogRiyB9e2Hz4NZd2tR3d0XgJ7cgus54rXg8QwQb
         +aYCchqKOR8ZrX0eSaH3a7WkjhyKmBiioWgerZ+J8qTS6RrzhgEnBRtWjGku7iJDB96w
         SdtKvGqaC3V3KmGELe4Dzg10a29h/zh0EBk5E5KErJBUAeFNaMjL9+2k0CnaAFvVjEoi
         Onaw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlpuiG2uTr2V4mX/e+Zpb5NpHYy1PawZ070oYFxIDh2GkKPE91iid3FNmp7LbTNw6wmxyRhPzJSj/VvQL+0Y6B2fAhjCg/JU5P65I
X-Gm-Message-State: AOJu0YyET92u+p6s/Mjhstkiu94++q/BDoQh6K5jj7ubolzMK/xHQwJY
	Cjxz2qEVCvW1Q0jrFnb1GPEBJCeGNgNKryHjb6x64bMYvnb0AX+ORtAvce0cbQA=
X-Google-Smtp-Source: AGHT+IGjSqhxl5Azs5WanCc/J8PolFybccFfqq+TTvPKJI0Aj9Pxj5n3xNFQ5ZXSq5sMOlaDbO+oeg==
X-Received: by 2002:a2e:98d4:0:b0:2e0:e470:8845 with SMTP id s20-20020a2e98d4000000b002e0e4708845mr1525154ljj.2.1714731063270;
        Fri, 03 May 2024 03:11:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm8832702wms.7.2024.05.03.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:11:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 03 May 2024 12:10:53 +0200
Subject: [PATCH v2 2/2] USB: serial: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-module-owner-usb-serial-v2-2-7887769dbeff@linaro.org>
References: <20240503-module-owner-usb-serial-v2-0-7887769dbeff@linaro.org>
In-Reply-To: <20240503-module-owner-usb-serial-v2-0-7887769dbeff@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29904;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fwfKG8ZRMuQy9n8iRy2dfyr5NtXqms4juIZ2/nyVcTM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmNLgx8f+nnqkw+XaPWXqEgNosgZjSGJGAhDEP2
 GKRZSbN05CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjS4MQAKCRDBN2bmhouD
 1+/MEACU8KQCRPkmbwBqBylQsVxutu6qloTUZ4zn8UBmyymIeyIrU8+iqEhTFwmcNjzD5pmqb0U
 5gpk9OvzIGrBmEowIl58/5m7UQNeE6gXahTuOeRDwwjBgMfIGfaRtEUzytGVs+22qNC/k/O9+QP
 c6C3PfcpCmH7nw9NUJmoBho1UG0wojKYiazPgIgqVlEUtEzoKPWGa60FToXTLAoYqoRm4mzu4jd
 +DbHvJwDcfQUOmAHtrLW0ABfDat02ppXO1zakO/Gj6cB8fZZYoNhZbfaJPjoIsEhg4Ps3VTpfDM
 xvbThyWZchTVQ2gKmHoxgbujP3gp6Kt16haQ09psCe3Fx08wbUKEBsMwqRBh1T+c6B4BFnvRRUP
 sM+xC//L8ssZzNO+QCtBVdDuStPSb4mP1qgUJvn0WXKufI1WMV3Isqg++Dga/yoJBu8S2tLF1yg
 jRbSY31RFegNAyK2qe+KGMRv1ZMu66Jsp5D2bASpjRJcq5KISfyI0t267ImtYZY8oyitil/A2Ot
 X+da+xEbElubOXdbATOv3MA8QKgeuMKCI4N/cE7svxmbJd7QCUl9B0py39rIzUTnWUBkHiL+ZaJ
 4qf4+FHQs6BqLmXc7Wmfb1aqAhzG0QOuaOIOvBJN1dS/hg7xf6/CUwjUi+kfb/u8Mj6c8Mi+k1g
 6CEgODwHcxUDJ0Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/aircable.c          | 1 -
 drivers/usb/serial/ark3116.c           | 1 -
 drivers/usb/serial/belkin_sa.c         | 1 -
 drivers/usb/serial/ch341.c             | 1 -
 drivers/usb/serial/cp210x.c            | 1 -
 drivers/usb/serial/cyberjack.c         | 1 -
 drivers/usb/serial/cypress_m8.c        | 3 ---
 drivers/usb/serial/digi_acceleport.c   | 2 --
 drivers/usb/serial/empeg.c             | 1 -
 drivers/usb/serial/f81232.c            | 2 --
 drivers/usb/serial/f81534.c            | 1 -
 drivers/usb/serial/ftdi_sio.c          | 1 -
 drivers/usb/serial/garmin_gps.c        | 1 -
 drivers/usb/serial/generic.c           | 1 -
 drivers/usb/serial/io_edgeport.c       | 4 ----
 drivers/usb/serial/io_ti.c             | 2 --
 drivers/usb/serial/ipaq.c              | 1 -
 drivers/usb/serial/ipw.c               | 1 -
 drivers/usb/serial/ir-usb.c            | 1 -
 drivers/usb/serial/iuu_phoenix.c       | 1 -
 drivers/usb/serial/keyspan.c           | 4 ----
 drivers/usb/serial/keyspan_pda.c       | 2 --
 drivers/usb/serial/kl5kusb105.c        | 1 -
 drivers/usb/serial/kobil_sct.c         | 1 -
 drivers/usb/serial/mct_u232.c          | 1 -
 drivers/usb/serial/metro-usb.c         | 1 -
 drivers/usb/serial/mos7720.c           | 1 -
 drivers/usb/serial/mos7840.c           | 1 -
 drivers/usb/serial/mxuport.c           | 1 -
 drivers/usb/serial/navman.c            | 1 -
 drivers/usb/serial/omninet.c           | 1 -
 drivers/usb/serial/opticon.c           | 1 -
 drivers/usb/serial/option.c            | 1 -
 drivers/usb/serial/oti6858.c           | 1 -
 drivers/usb/serial/pl2303.c            | 1 -
 drivers/usb/serial/qcaux.c             | 1 -
 drivers/usb/serial/qcserial.c          | 1 -
 drivers/usb/serial/quatech2.c          | 1 -
 drivers/usb/serial/safe_serial.c       | 1 -
 drivers/usb/serial/sierra.c            | 1 -
 drivers/usb/serial/spcp8x5.c           | 1 -
 drivers/usb/serial/ssu100.c            | 1 -
 drivers/usb/serial/symbolserial.c      | 1 -
 drivers/usb/serial/ti_usb_3410_5052.c  | 2 --
 drivers/usb/serial/upd78f0730.c        | 1 -
 drivers/usb/serial/usb-serial-simple.c | 1 -
 drivers/usb/serial/usb_debug.c         | 2 --
 drivers/usb/serial/visor.c             | 3 ---
 drivers/usb/serial/whiteheat.c         | 2 --
 drivers/usb/serial/wishbone-serial.c   | 1 -
 drivers/usb/serial/xr_serial.c         | 1 -
 drivers/usb/serial/xsens_mt.c          | 1 -
 52 files changed, 69 deletions(-)

diff --git a/drivers/usb/serial/aircable.c b/drivers/usb/serial/aircable.c
index a1df686c3066..aa517242d060 100644
--- a/drivers/usb/serial/aircable.c
+++ b/drivers/usb/serial/aircable.c
@@ -138,7 +138,6 @@ static void aircable_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver aircable_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"aircable",
 	},
 	.id_table = 		id_table,
diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 67a07cc007f0..800b04fe37fa 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -599,7 +599,6 @@ static void ark3116_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver ark3116_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ark3116",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index cf47ee4ae5d3..44f5b58beec9 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -66,7 +66,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 /* All of the device info needed for the serial converters */
 static struct usb_serial_driver belkin_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"belkin",
 	},
 	.description =		"Belkin / Peracom / GoHubs USB Serial Adapter",
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 612bea504d7a..26d48a4f7036 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -837,7 +837,6 @@ static int ch341_reset_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver ch341_device = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "ch341-uart",
 	},
 	.id_table          = id_table,
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 21fd26609252..c24101f0a07a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -299,7 +299,6 @@ struct cp210x_port_private {
 
 static struct usb_serial_driver cp210x_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"cp210x",
 	},
 	.id_table		= id_table,
diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index 51e5aac3bf4c..76dd8e7453b5 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -67,7 +67,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver cyberjack_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"cyberjack",
 	},
 	.description =		"Reiner SCT Cyberjack USB card reader",
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 1e0c028c5ec9..ce9134bb30f3 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -139,7 +139,6 @@ static void cypress_write_int_callback(struct urb *urb);
 
 static struct usb_serial_driver cypress_earthmate_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"earthmate",
 	},
 	.description =			"DeLorme Earthmate USB",
@@ -166,7 +165,6 @@ static struct usb_serial_driver cypress_earthmate_device = {
 
 static struct usb_serial_driver cypress_hidcom_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"cyphidcom",
 	},
 	.description =			"HID->COM RS232 Adapter",
@@ -192,7 +190,6 @@ static struct usb_serial_driver cypress_hidcom_device = {
 
 static struct usb_serial_driver cypress_ca42v2_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"nokiaca42v2",
 	},
 	.description =			"Nokia CA-42 V2 Adapter",
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d1dea3850576..a06485965412 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -262,7 +262,6 @@ MODULE_DEVICE_TABLE(usb, id_table_combined);
 
 static struct usb_serial_driver digi_acceleport_2_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"digi_2",
 	},
 	.description =			"Digi 2 port USB adapter",
@@ -293,7 +292,6 @@ static struct usb_serial_driver digi_acceleport_2_device = {
 
 static struct usb_serial_driver digi_acceleport_4_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"digi_4",
 	},
 	.description =			"Digi 4 port USB adapter",
diff --git a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
index 405e835e93dd..aedcf7ebd269 100644
--- a/drivers/usb/serial/empeg.c
+++ b/drivers/usb/serial/empeg.c
@@ -43,7 +43,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver empeg_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"empeg",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 5f7a46bcace6..530b77fc2f78 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -967,7 +967,6 @@ static int f81232_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver f81232_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"f81232",
 	},
 	.id_table =		f81232_id_table,
@@ -994,7 +993,6 @@ static struct usb_serial_driver f81232_device = {
 
 static struct usb_serial_driver f81534a_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"f81534a",
 	},
 	.id_table =		f81534a_id_table,
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index ef126cd3d94f..685930ac8383 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1538,7 +1538,6 @@ static int f81534_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver f81534_device = {
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "f81534",
 	},
 	.description =		DRIVER_DESC,
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 76a04ab41100..c6f17d732b95 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2871,7 +2871,6 @@ static int ftdi_ioctl(struct tty_struct *tty,
 
 static struct usb_serial_driver ftdi_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
 		.dev_groups =	ftdi_groups,
 	},
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 670e942fdaaa..5e1244d87cf7 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1413,7 +1413,6 @@ static void garmin_port_remove(struct usb_serial_port *port)
 /* All of the device info needed */
 static struct usb_serial_driver garmin_device = {
 	.driver = {
-		.owner       = THIS_MODULE,
 		.name        = "garmin_gps",
 	},
 	.description         = "Garmin GPS usb/tty",
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 15b6dee3a8e5..757f0a586ddb 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -63,7 +63,6 @@ static int usb_serial_generic_calc_num_ports(struct usb_serial *serial,
 
 static struct usb_serial_driver usb_serial_generic_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"generic",
 	},
 	.id_table =		generic_device_ids,
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index abe4bbb0ac65..c7d6b5e3f898 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2978,7 +2978,6 @@ static void edge_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver edgeport_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_2",
 	},
 	.description		= "Edgeport 2 port adapter",
@@ -3013,7 +3012,6 @@ static struct usb_serial_driver edgeport_2port_device = {
 
 static struct usb_serial_driver edgeport_4port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_4",
 	},
 	.description		= "Edgeport 4 port adapter",
@@ -3048,7 +3046,6 @@ static struct usb_serial_driver edgeport_4port_device = {
 
 static struct usb_serial_driver edgeport_8port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_8",
 	},
 	.description		= "Edgeport 8 port adapter",
@@ -3083,7 +3080,6 @@ static struct usb_serial_driver edgeport_8port_device = {
 
 static struct usb_serial_driver epic_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "epic",
 	},
 	.description		= "EPiC device",
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 7a3a6e539456..7d0584b2a234 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2670,7 +2670,6 @@ static int edge_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver edgeport_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_ti_1",
 	},
 	.description		= "Edgeport TI 1 port adapter",
@@ -2708,7 +2707,6 @@ static struct usb_serial_driver edgeport_1port_device = {
 
 static struct usb_serial_driver edgeport_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_ti_2",
 	},
 	.description		= "Edgeport TI 2 port adapter",
diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index e11441bac44f..3c6a9b9b9c2b 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -496,7 +496,6 @@ MODULE_DEVICE_TABLE(usb, ipaq_id_table);
 /* All of the device info needed for the Compaq iPAQ */
 static struct usb_serial_driver ipaq_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ipaq",
 	},
 	.description =		"PocketPC PDA",
diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
index d04c7cc5c1c2..b1e672c2f423 100644
--- a/drivers/usb/serial/ipw.c
+++ b/drivers/usb/serial/ipw.c
@@ -285,7 +285,6 @@ static void ipw_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver ipw_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ipw",
 	},
 	.description =		"IPWireless converter",
diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 82f108134e6f..a106b71e698f 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -71,7 +71,6 @@ MODULE_DEVICE_TABLE(usb, ir_id_table);
 
 static struct usb_serial_driver ir_device = {
 	.driver	= {
-		.owner	= THIS_MODULE,
 		.name	= "ir-usb",
 	},
 	.description		= "IR Dongle",
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 77cba71bcccb..c21dcc9b6f05 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -1157,7 +1157,6 @@ static int iuu_remove_sysfs_attrs(struct usb_serial_port *port)
 
 static struct usb_serial_driver iuu_device = {
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "iuu_phoenix",
 		   },
 	.id_table = id_table,
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 0a783985197c..9129e0282c24 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -3001,7 +3001,6 @@ static void keyspan_port_remove(struct usb_serial_port *port)
 /* Structs for the devices, pre and post renumeration. */
 static struct usb_serial_driver keyspan_pre_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_no_firm",
 	},
 	.description		= "Keyspan - (without firmware)",
@@ -3012,7 +3011,6 @@ static struct usb_serial_driver keyspan_pre_device = {
 
 static struct usb_serial_driver keyspan_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_1",
 	},
 	.description		= "Keyspan 1 port adapter",
@@ -3036,7 +3034,6 @@ static struct usb_serial_driver keyspan_1port_device = {
 
 static struct usb_serial_driver keyspan_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_2",
 	},
 	.description		= "Keyspan 2 port adapter",
@@ -3060,7 +3057,6 @@ static struct usb_serial_driver keyspan_2port_device = {
 
 static struct usb_serial_driver keyspan_4port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_4",
 	},
 	.description		= "Keyspan 4 port adapter",
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 0eef358b314a..e98b479593d3 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -676,7 +676,6 @@ static void keyspan_pda_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver keyspan_pda_fake_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"keyspan_pda_pre",
 	},
 	.description =		"Keyspan PDA - (prerenumeration)",
@@ -687,7 +686,6 @@ static struct usb_serial_driver keyspan_pda_fake_device = {
 
 static struct usb_serial_driver keyspan_pda_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"keyspan_pda",
 	},
 	.description =		"Keyspan PDA",
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 394b3189e003..a2c0bebc041f 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -75,7 +75,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver kl5kusb105d_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"kl5kusb105d",
 	},
 	.description =		"KL5KUSB105D / PalmConnect",
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 5e775f68fcb8..5eb59ac3e564 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -77,7 +77,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver kobil_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"kobil",
 	},
 	.description =		"KOBIL USB smart card terminal",
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 6570c8817a80..e5a139ed5d90 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -69,7 +69,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver mct_u232_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"mct_u232",
 	},
 	.description =	     "MCT U232",
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index 30ab565e0738..028878292901 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -341,7 +341,6 @@ static void metrousb_unthrottle(struct tty_struct *tty)
 
 static struct usb_serial_driver metrousb_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"metro-usb",
 	},
 	.description		= "Metrologic USB to Serial",
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 23544074eb1c..e59bfa7c8030 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1724,7 +1724,6 @@ static void mos7720_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver moschip7720_2port_driver = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"moschip7720",
 	},
 	.description		= "Moschip 2 port adapter",
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 8b0308d84270..70ff2408b99a 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1739,7 +1739,6 @@ static void mos7840_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver moschip7840_4port_device = {
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "mos7840",
 		   },
 	.description = DRIVER_DESC,
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 1f7bb3e4fcf2..2188e9668c41 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1278,7 +1278,6 @@ static int mxuport_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver mxuport_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"mxuport",
 	},
 	.description		= "MOXA UPort",
diff --git a/drivers/usb/serial/navman.c b/drivers/usb/serial/navman.c
index 20277c52dded..99b633051729 100644
--- a/drivers/usb/serial/navman.c
+++ b/drivers/usb/serial/navman.c
@@ -95,7 +95,6 @@ static int navman_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 static struct usb_serial_driver navman_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"navman",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 41f1b872d277..397ebd5a3e74 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver zyxel_omninet_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"omninet",
 	},
 	.description =		"ZyXEL - omni.net usb",
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index e31a6d77da3a..1ee84ccc4bbd 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -375,7 +375,6 @@ static void opticon_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver opticon_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"opticon",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8a5846d4adf6..e190ddedacd3 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2338,7 +2338,6 @@ MODULE_DEVICE_TABLE(usb, option_ids);
 
 static struct usb_serial_driver option_1port_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"option1",
 	},
 	.description       = "GSM modem (1-port)",
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index fa07f6ff9ecc..24068368892c 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -138,7 +138,6 @@ static void oti6858_port_remove(struct usb_serial_port *port);
 /* device info */
 static struct usb_serial_driver oti6858_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"oti6858",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..9e3b524a2e7b 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -1234,7 +1234,6 @@ static void pl2303_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver pl2303_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"pl2303",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/qcaux.c b/drivers/usb/serial/qcaux.c
index 929ffba663f2..fd34f7e48e53 100644
--- a/drivers/usb/serial/qcaux.c
+++ b/drivers/usb/serial/qcaux.c
@@ -72,7 +72,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver qcaux_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"qcaux",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 703a9c563557..c7de9585feb2 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -454,7 +454,6 @@ static void qc_release(struct usb_serial *serial)
 
 static struct usb_serial_driver qcdevice = {
 	.driver = {
-		.owner     = THIS_MODULE,
 		.name      = "qcserial",
 	},
 	.description         = "Qualcomm USB modem",
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 821f25e52ec2..4167a45d1be3 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -924,7 +924,6 @@ static int qt2_write(struct tty_struct *tty,
 
 static struct usb_serial_driver qt2_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "quatech-serial",
 	},
 	.description	     = DRIVER_DESC,
diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 6accbecb6318..238b54993446 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -284,7 +284,6 @@ static int safe_startup(struct usb_serial *serial)
 
 static struct usb_serial_driver safe_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"safe_serial",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 353b2549eaa8..64a2e0bb5723 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -1021,7 +1021,6 @@ static int sierra_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver sierra_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"sierra",
 	},
 	.description       = "Sierra USB modem",
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 09a972a838ee..0d3ac5a56983 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -462,7 +462,6 @@ static int spcp8x5_tiocmget(struct tty_struct *tty)
 
 static struct usb_serial_driver spcp8x5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"SPCP8x5",
 	},
 	.id_table		= id_table,
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 1e1888b66305..df21009bdf42 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -500,7 +500,6 @@ static void ssu100_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver ssu100_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "ssu100",
 	},
 	.description	     = DRIVER_DESC,
diff --git a/drivers/usb/serial/symbolserial.c b/drivers/usb/serial/symbolserial.c
index d7f73ad6e778..52a73812afac 100644
--- a/drivers/usb/serial/symbolserial.c
+++ b/drivers/usb/serial/symbolserial.c
@@ -169,7 +169,6 @@ static void symbol_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver symbol_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"symbol",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 0fba25abf671..a0c244bc77c0 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -417,7 +417,6 @@ static const struct usb_device_id ti_id_table_combined[] = {
 
 static struct usb_serial_driver ti_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "ti_usb_3410_5052_1",
 	},
 	.description		= "TI USB 3410 1 port adapter",
@@ -450,7 +449,6 @@ static struct usb_serial_driver ti_1port_device = {
 
 static struct usb_serial_driver ti_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "ti_usb_3410_5052_2",
 	},
 	.description		= "TI USB 5052 2 port adapter",
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 46952182e04f..15a17bf111f1 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -407,7 +407,6 @@ static void upd78f0730_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver upd78f0730_device = {
 	.driver	 = {
-		.owner	= THIS_MODULE,
 		.name	= "upd78f0730",
 	},
 	.id_table	= id_table,
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 24b8772a345e..d733b31fe51b 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -24,7 +24,6 @@ static const struct usb_device_id vendor##_id_table[] = {	\
 };								\
 static struct usb_serial_driver vendor##_device = {		\
 	.driver = {						\
-		.owner =	THIS_MODULE,			\
 		.name =		#vendor,			\
 	},							\
 	.id_table =		vendor##_id_table,		\
diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index 6934970f180d..840373b965fc 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -78,7 +78,6 @@ static void usb_debug_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver debug_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"debug",
 	},
 	.id_table =		id_table,
@@ -90,7 +89,6 @@ static struct usb_serial_driver debug_device = {
 
 static struct usb_serial_driver dbc_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"xhci_dbc",
 	},
 	.id_table =		dbc_id_table,
diff --git a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
index 4412834db21c..062a38fe0c1c 100644
--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -161,7 +161,6 @@ MODULE_DEVICE_TABLE(usb, id_table_combined);
    and Palm 4.0 devices */
 static struct usb_serial_driver handspring_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"visor",
 	},
 	.description =		"Handspring Visor / Palm OS",
@@ -180,7 +179,6 @@ static struct usb_serial_driver handspring_device = {
 /* All of the device info needed for the Clie UX50, TH55 Palm 5.0 devices */
 static struct usb_serial_driver clie_5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"clie_5",
 	},
 	.description =		"Sony Clie 5.0",
@@ -200,7 +198,6 @@ static struct usb_serial_driver clie_5_device = {
 /* device info for the Sony Clie OS version 3.5 */
 static struct usb_serial_driver clie_3_5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"clie_3.5",
 	},
 	.description =		"Sony Clie 3.5",
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index ca48e90a8e81..009faeb2ef55 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -91,7 +91,6 @@ static int whiteheat_break_ctl(struct tty_struct *tty, int break_state);
 
 static struct usb_serial_driver whiteheat_fake_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"whiteheatnofirm",
 	},
 	.description =		"Connect Tech - WhiteHEAT - (prerenumeration)",
@@ -103,7 +102,6 @@ static struct usb_serial_driver whiteheat_fake_device = {
 
 static struct usb_serial_driver whiteheat_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"whiteheat",
 	},
 	.description =		"Connect Tech - WhiteHEAT",
diff --git a/drivers/usb/serial/wishbone-serial.c b/drivers/usb/serial/wishbone-serial.c
index ff4092f9b33c..670d573f6b63 100644
--- a/drivers/usb/serial/wishbone-serial.c
+++ b/drivers/usb/serial/wishbone-serial.c
@@ -70,7 +70,6 @@ static void wishbone_serial_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver wishbone_serial_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"wishbone_serial",
 	},
 	.id_table =		id_table,
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 1d9a12628f81..4186e791b384 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -1082,7 +1082,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver xr_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name =	"xr_serial",
 	},
 	.id_table		= id_table,
diff --git a/drivers/usb/serial/xsens_mt.c b/drivers/usb/serial/xsens_mt.c
index cf262c9a9638..382b3698c1d5 100644
--- a/drivers/usb/serial/xsens_mt.c
+++ b/drivers/usb/serial/xsens_mt.c
@@ -49,7 +49,6 @@ static int xsens_mt_probe(struct usb_serial *serial,
 
 static struct usb_serial_driver xsens_mt_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "xsens_mt",
 	},
 	.id_table = id_table,

-- 
2.43.0


