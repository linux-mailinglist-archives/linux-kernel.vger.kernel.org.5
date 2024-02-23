Return-Path: <linux-kernel+bounces-79303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3786208A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E32F283699
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135A14D43B;
	Fri, 23 Feb 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBuw6Mj5"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252C14CAD1;
	Fri, 23 Feb 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730177; cv=none; b=kKlinBcXTf6x3Dfj7FjVR3SRUZZm5iXlKfqr/8lpfan5Y7J1gwyCmyVC1s0BBPBT+ZnvQT9bT8HVr2HutI473dK3WjJTetqLfpswdO+Lxn/lVuUic6BqDw6JZ2/GUiYNFQr+0FKJw95BfsgzVCAPEH4+0Fs4jeDJVIaGVaDAYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730177; c=relaxed/simple;
	bh=dK1BjyOXGfLwN5ILE7hkJADDu3le/Lw6z1zJA5AtyVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tP+gCul+tlK684WpH19abQshR7Zalsh3NNxfc3fhCppCFPdoVljt89/OgnzZa+KXdNBoxr9Rf+DccGUel1lzxr3e/m3VLdbm1WMVTqTZUMjPsC/azngmbJe8a6P/2QNle+b9m8omDHWE87mFzHrZIs1JWajco4E7CS/WMzvyU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBuw6Mj5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so12169735ad.1;
        Fri, 23 Feb 2024 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708730175; x=1709334975; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ap5jfynKUwvFrOMjr8+smc5ih4W+k0wxlpnBX6ZIbOw=;
        b=cBuw6Mj5RlWHzQ1K4BrIsqytuOq/nV9w44hac/GsD4ak8dOFhr0CyUWYB+2s0Epsnt
         iNj04XR4ecoZ7IWJRexbRYV9GI1FXRXACa7W2JnQHlJ3BXOHBmeUXG/ad2kD/bWInd4q
         sgagdHAH5mfZ8YPU5YtJgFwLxEqkejkV6BJDR2/iJEQrP3rzJUv/g3S4sZcUX1FuVMSW
         o4m07EYYkR0VrD/W3kyaCYEJuZD++5JYawGAt/BN6aI5V4ALZtPKiI4nsIvsUHEk3gBJ
         NQUwRSDTyrTGsNS3mNFSinAfCzKQvPeTZ/3M0MZpUGrl2v+I7fDz4chXFjuVNh5mQlrd
         Mi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708730175; x=1709334975;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap5jfynKUwvFrOMjr8+smc5ih4W+k0wxlpnBX6ZIbOw=;
        b=IYD33roeWkx5jnZF2r6jQ+B5IJ8LIgP4NS7JQ6NqLbDXDCa0HegkD7nImr0CctpkA6
         YbaUo85fkb1plmYDIj/TdlPc7KFcaXMVMg8q37swCIixyXLMlKC7cIsA7E6L8Z/rktEt
         xK9iSg20R/sdwuyDAa5f10wmq3cBYW3MskGyq3TdMBxl97cp7UMhJzK4wB4WVUo0Af3N
         rnxbtcWVTNPKoYfoD+iJOmdo62jsUvbJcDqor097IuzxN4KyujI87Ed3SAYTOHfgUu5J
         y4QL6GID1omS2QP9kvVlAPmzvxPg+w3uecEbowgHYZpXGKdqtnNgnyXNS9AaHKAXkDc3
         ZGqA==
X-Forwarded-Encrypted: i=1; AJvYcCVV64CS7RMeoSbXUTE2c0AN0w97jMH0fEYI2vjJEcrp/nOljbjVtH6icghsyVYVJXWtmZYrtojBZyuk9AE6zZzKhPU5FK/xsvmsRqOH12ee3UYcmro593cfD/U1KDK7uPDmvTxS2lXwSCU=
X-Gm-Message-State: AOJu0YzYUf9PJHKSIxU7YdroMdgqIl0W2P+v/4+tN9CqIeCWTXeiQECJ
	H0vP0a0MkhBiliOkDrldO48Fua63mxVUoZpYfHnmJdweFR7C+FwB
X-Google-Smtp-Source: AGHT+IGcAjdfNPBzL6liO8W0ZiZ+ojd6M1x1g4CEoa9UsWYoEVz3zzIeNdRS4kEDaDJ0/7PIQQtzLA==
X-Received: by 2002:a17:902:db0a:b0:1db:c113:29bb with SMTP id m10-20020a170902db0a00b001dbc11329bbmr1480811plx.34.1708730175455;
        Fri, 23 Feb 2024 15:16:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f0c6:1cdc:5abd:78b8])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001d8f82f90ccsm12119196plb.199.2024.02.23.15.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 15:16:15 -0800 (PST)
Date: Fri, 23 Feb 2024 15:16:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kenalba@google.com, dianders@chromium.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: avoid polling stylus battery on Chromebook Pompom
Message-ID: <ZdknA5qa8B-nB6ta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Internal touchscreen on Trogdor Pompom (AKA Dynabook Chromebook C1)
supports USI stylus. Unfortunately the HID descriptor for the stylus
interface does not contain "Stylus" physical collection, which makes
the kernel to try and pull battery information, resulting in errors.

Apply HID_BATTERY_QUIRK_AVOID_QUERY to the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e4d2dfd5d253..05f451390a3b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -426,6 +426,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
 #define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
+#define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c8b20d44b147..e03d300d2bac 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -411,6 +411,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{}
 };
 
-- 
2.44.0.rc0.258.g7320e95886-goog


-- 
Dmitry

