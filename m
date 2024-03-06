Return-Path: <linux-kernel+bounces-93935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D520C873731
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745DE1F267F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA754130AC3;
	Wed,  6 Mar 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpXvpjgz"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3F86AE9;
	Wed,  6 Mar 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730056; cv=none; b=Rd//FffP9wXMsFYax/4CD+JVPH+FcGT0Mk0gLpDoLN/NalygOiYd/TNX6P6sOwTo/uRh1pj3cna8SiwOjavb6TR35FxZMSpTFIL2SJgcT98k4nLQi+61DfTEmEJU+jmPtZOHUqM7abg8cs5+t9JJADWXvr63f1ph4MDhroaReYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730056; c=relaxed/simple;
	bh=CEvkqjTDaxcNB5SC7mszcOpSuSpnuOp3AupaCODMgNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8J4CYzBWJX19cjo0Lzv5WytTFL13ofmqy421akBwrPjw+Do9PHdDTzKhnjggFi2Qmnv1xTjPYF1eSJX/AmAAT7Ev9uTyIyUTyDkOmATfNPqqPDi5LPVWJZJLuFvJR5ckam3KFF8RdnI7j8G+UhUuC8vRZ8xsCDY670h068f0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpXvpjgz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd10a37d68so30306245ad.2;
        Wed, 06 Mar 2024 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730054; x=1710334854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+yP1R410expbvz5k4M/+bWxyv8gdnQ3RGI7sVEJL1w=;
        b=JpXvpjgzajIvRhJc7eyMTqPOQThjZN5yLznaD9n2bK8KdYGBUkLnuGYWLmymlpR97x
         VX43qAm84744OLMKzYiquUZASiOT+KPekuybvY5mrYumWmpyt0lTuFZ9myLIF/JrzsrF
         dj4zloh54L7USkjQvy7D7psAn6SSk7i4wy6y41nZEl5Vj8vDeS7xZgeF3xuWhdRbdBWS
         uX8yN2RlBpEWlm6dqVCftxgx1clBR75CeF5nRedvFsYTtFuKP593kO2LMwTvgGNb66W3
         wojPhDKd9sD6/rSAFzliq7ME7xhQzYR/Qod2HfWGc0IwFPRAE/46wNE6Qd7LQ1cmPV3E
         UnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730054; x=1710334854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+yP1R410expbvz5k4M/+bWxyv8gdnQ3RGI7sVEJL1w=;
        b=VVMifyaA2ICfQF756HnS7oicV5IchvKjR/P1N5MFd198PFrAIvsAG+kVuv51/L0DbP
         o+Z1k/uh5A7FZ+iIEGZK/Bbgz9Up7T6RRzJFAst8Omn9B0KzD+F94mPEgwqD2FGkB5Vw
         76R5Jmt2KA9dMXywEsqVQJnCM+RmwmzLNfQbJ52hbEwJbWoO5eKWzbfYhmey/fULod7T
         BbNzZUakKrP4yyspFLBNvD2dhxBfZaPbGK0cF/1z6UNBdXpFn991/kIb/QSs1XCRitdR
         fLjfHi7eRmCXfw0H4bZtFr6uJvucgjiXFZ0SL++Uyz8Q0DuvU5/EukS8x4Wwqqe7TNZI
         PTDA==
X-Forwarded-Encrypted: i=1; AJvYcCXa4rRKhrj/TFUVvJgKslWFfsPvSomvyj7p+rJAvRQiZrrrglTazpqsizpDITtqmNYOxZ7O/DW3V/hy4BZzNwFK/vQOrZzUOSW4B7VM
X-Gm-Message-State: AOJu0YxxYtqpkbZDiqBBGiyYBODLSQBtPZf5dWX49YZSDJGdoI3CC8S3
	ib4n8/jqh2aRlzVS8iKOcUzAYLxrv6YCFguSVE2svT6Vb5VEjGIQ
X-Google-Smtp-Source: AGHT+IE0YMRxDIKnsZAbfdQ8ZDNP2Xify5CG5iQJfpnTPQMaPodMwP4tOCR5fMa0OPDUVILNN7JFzQ==
X-Received: by 2002:a17:902:d3c4:b0:1d9:f83e:3a54 with SMTP id w4-20020a170902d3c400b001d9f83e3a54mr4444147plb.64.1709730054326;
        Wed, 06 Mar 2024 05:00:54 -0800 (PST)
Received: from VM-147-239-centos.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001dc78455383sm12535924plg.223.2024.03.06.05.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 05:00:53 -0800 (PST)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: wentong.wu@intel.com,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	andi.shyti@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	Yongzhi Liu <hyperlyzcs@gmail.com>
Subject: [PATCH] usb: misc: ljca: Fix double free in error handling path
Date: Wed,  6 Mar 2024 21:00:42 +0800
Message-Id: <20240306130042.26811-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), callback function ljca_auxdev_release
calls kfree(auxdev->dev.platform_data) to free the parameter data
of the function ljca_new_client_device. The callers of
ljca_new_client_device shouldn't call kfree() again
in the error handling path to free the platform data.

Fix this by cleaning up the redundant kfree().

Fixes: acd6199f195d ("usb: Add support for Intel LJCA device")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
 drivers/usb/misc/usb-ljca.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index 35770e608c64..be702364be08 100644
--- a/drivers/usb/misc/usb-ljca.c
+++ b/drivers/usb/misc/usb-ljca.c
@@ -590,12 +590,8 @@ static int ljca_enumerate_gpio(struct ljca_adapter *adap)
 		valid_pin[i] = get_unaligned_le32(&desc->bank_desc[i].valid_pins);
 	bitmap_from_arr32(gpio_info->valid_pin_map, valid_pin, gpio_num);
 
-	ret = ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
+	return ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
 				     gpio_info, LJCA_GPIO_ACPI_ADR);
-	if (ret)
-		kfree(gpio_info);
-
-	return ret;
 }
 
 static int ljca_enumerate_i2c(struct ljca_adapter *adap)
@@ -626,13 +622,9 @@ static int ljca_enumerate_i2c(struct ljca_adapter *adap)
 		i2c_info->capacity = desc->info[i].capacity;
 		i2c_info->intr_pin = desc->info[i].intr_pin;
 
-		ret = ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
+		return ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
 					     "ljca-i2c", i2c_info,
 					     LJCA_I2C1_ACPI_ADR + i);
-		if (ret) {
-			kfree(i2c_info);
-			return ret;
-		}
 	}
 
 	return 0;
@@ -666,13 +658,9 @@ static int ljca_enumerate_spi(struct ljca_adapter *adap)
 		spi_info->id = desc->info[i].id;
 		spi_info->capacity = desc->info[i].capacity;
 
-		ret = ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
+		return ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
 					     "ljca-spi", spi_info,
 					     LJCA_SPI1_ACPI_ADR + i);
-		if (ret) {
-			kfree(spi_info);
-			return ret;
-		}
 	}
 
 	return 0;
-- 
2.36.1


