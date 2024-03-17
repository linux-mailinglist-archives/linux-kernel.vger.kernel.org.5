Return-Path: <linux-kernel+bounces-105527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C087DFBE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B871C20A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15B1EEF7;
	Sun, 17 Mar 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxrVru5O"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B439210EC;
	Sun, 17 Mar 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704310; cv=none; b=tVWUaney2Sw+MP0XZF8PCRsRMu9/A5unXDkXQM7018U/cVkaUhRtLNTIlwk2sUBeSs3dShZ+2a6khCrdaqEl90FrS8JDVNX+0VTfDGjx6ve/WEnw6PwGN7d/uLCEDrVIWq5BI7X3x5ICoHGBUnRCr9cWbr8B8bCoeumhGlmX8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704310; c=relaxed/simple;
	bh=lUHaerA7sm8HS5VEf8GULwhZwvO9fhb5VvvPZ5w1aXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVRqC3Wy2/idW8CHzbinBKjyAaFjWXy9Y81wA9S0LgTcwO43g0urI2az2nRbWoSTr/a7EYJmGxPlIhbBDEmFm+iKFD5lZBrISR5KN6i+PBJyOd6Mm8lBtGLJTsDufuCM/b5s22b+nPKX/hEXwyXRuBdgxp/2N9EPEV4Rxi7gP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxrVru5O; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso687279a91.1;
        Sun, 17 Mar 2024 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704307; x=1711309107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO9G69iyqVQbbyIAUNqe8gLJ4ujwClNwkyBvzcpz7K4=;
        b=hxrVru5O3Cre08TFhHhN7tPR4O/p6APp+RNLa6G3LIaKLPAmodJrjG/xenZUoGrqSY
         K/kyQ2cbq75Gl330n6ZMskHD9Zr/CfBC7C2hKdSDrEmvM8phB+Sb1R1aRpLwSI8k34Mw
         PtcBQmSa1AgbWLLeYLfmqbzgwz2HGXIxCEyqpLQsYI6jb9C7OvFCuH2ogvifrW2bWAyi
         ns/fGfFaVGSIYHj1/kegkdpEsC5EpI4Ubjs9czRg3LmPtp8REP3asBGPUAKmMKRKv23E
         vSPItUJWXLHIQD4oTCutOl1BAPKz1S8ximIifhuHLNVnxIZsNKV/1d7LLc5SLN1ecfFe
         En6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704307; x=1711309107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO9G69iyqVQbbyIAUNqe8gLJ4ujwClNwkyBvzcpz7K4=;
        b=lBkzshzmHWzZq3puaxbvq8Xee5XohMh24dTe8jQ415fSbPE/Y+poPK4AkOfqwteGnO
         lIYw9aeTvLQlLk966Ih+oHfGNrAjyIx4/XyBHSFyTe+zBU9kpK2UkeUOsxc+/QLy2smG
         sRpdpRPqfPbuxVAr7Xqx6bHWCOvSGakeqGLWxOqX55fnG8F/FHZqtfPpzQJCZG/lSK1H
         7Gc3+PWTlyqTzPNB18DIu0tWwwY3Fj5AZLgyWWuWfGpPVBdtmlZDVde5SZUpvgcY4UBa
         MdQv8zexGwXCP7nzxbvd71YeLclJV4oWh8TmmJmqJXCpTba6cTx4mu6NMAK/AMgN7Ojz
         aB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFjFhZjxcWHZzZ7yzfK3UvFMLkLchjYkLTVMIXv572T/rxsue/w/MeUcc7eOVuAuTwrtBk+HODcweSisLuWKLTA9k1DZTCX2joldXeLSilQpmPkhBqN7VTNLhou6N3d8NW1KnBRA==
X-Gm-Message-State: AOJu0Yy1desVxjkQCKwyLTcV79v6ycwVP5Ugr5ioyH5ywqHFf/qr8gQR
	oIzq8ooBxoBrXi5U9maZ+m0y5BK41qGoXeUQQb++f1ccKO8mO9f7jvdbPGqPxdg=
X-Google-Smtp-Source: AGHT+IHb5ZQG5AZs1yNwiaA+uHOH5JqdctbG/pUZFDyCNz6pl0xo2W10sE+uFQzu766SlSdKr8rJ2g==
X-Received: by 2002:a17:90a:de93:b0:29d:fb99:7dcc with SMTP id n19-20020a17090ade9300b0029dfb997dccmr9795831pjv.18.1710704306906;
        Sun, 17 Mar 2024 12:38:26 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:26 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v4 3/5] greybus: Add mikroBUS manifest types
Date: Mon, 18 Mar 2024 01:07:11 +0530
Message-ID: <20240317193714.403132-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317193714.403132-1-ayushdevel1325@gmail.com>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DONOTMERGE

mikroBUS addon boards allow using same mikroBUS connector for a wide
range of peripherals. It is also possible for the addon board not to use
all the pins in mikroBUS socket (marked by NC or Not Connected). This
would require the need to create an almost new overlays for each
permutation of the hardware.

To overcome this, a manifest format based on Greybus manifest
specification was created which allows describing mikroBUS addon boards.
The reason for choosing greybus manifest for the identifier is that so far
we discussed only about physical mikroBUS ports on the board, but we can
also have mikroBUS ports on a remote microcontroller appearing on host
over greybus and there a device tree overlay solution does not work as the
standard identifier mechanism.

The patch introduces 3 new greybus descriptor types:
1. mikrobus-descriptor:
   Is a fixed-length descriptor (12 bytes), and the manifest shall have
   precisely one mikroBUS descriptor. Each byte describes a configuration
   of the corresponding pin on the mikroBUS addon board in a clockwise
   direction starting from the PWM pin omitting power (VCC and ground)
   pins as same as the default state of the pin.
   There are mikroBUS addon boards that use some dedicated SPI, UART, PWM,
   and I2C pins as GPIO pins, so it is necessary to redefine the default
   pin configuration of that pins on the host system. Also, sometimes it is
   required the pull-up on the host pin for correct functionality
2. property-descriptor:
   Are used to pass named properties or named GPIOs to the host. The host
   system uses this information to properly configure specific board
   drivers by passing the properties and GPIO name. There can be multiple
   instances of property descriptors per add-on board manifest.
3. device-descriptor:
   Describes a device on the mikroBUS port. The device descriptor is a
   fixed-length descriptor, and there can be multiple instances of device
   descriptors in an add-on board manifest in cases where the add-on board
   presents more than one device to the host.

New mikroBUS addon boards also sometimes contain a 1-wire EEPROM with
the mikroBUS manifest, thus enabling plug and play support.

I have also created PR to add mikrobus descriptors in Greybus spec and I
think the old PR on manifesto by Vaishnav should also work. However,
both of these repositories seem to be inactive. I am guessing the
greybus mailing list can provide more information on how I should go
about these.

Here is a sample mikroBUS manifest:
```
;;
; PRESSURE CLICK
; https://www.mikroe.com/pressure-click
; CONFIG_IIO_ST_PRESS
;
; Copyright 2020 BeagleBoard.org Foundation
; Copyright 2020 Texas Instruments
;

[manifest-header]
version-major = 0
version-minor = 1

[interface-descriptor]
vendor-string-id = 1
product-string-id = 2

[string-descriptor 1]
string = MIKROE

[string-descriptor 2]
string = Pressure

[mikrobus-descriptor]
pwm-state = 4
int-state = 1
rx-state = 7
tx-state = 7
scl-state = 6
sda-state = 6
mosi-state = 5
miso-state = 5
sck-state = 5
cs-state = 5
rst-state = 2
an-state = 1

[device-descriptor 1]
driver-string-id = 3
protocol = 0x3
reg = 0x5d

[string-descriptor 3]
string = lps331ap
```

Link: https://www.mikroe.com/clickid ClickID
Link:
https://docs.beagleboard.org/latest/projects/beagleconnect/index.html
beagleconnect
Link: https://github.com/projectara/greybus-spec Greybus Spec
Link: https://github.com/projectara/greybus-spec/pull/4 Greybus Spec PR
Link: https://github.com/projectara/manifesto/pull/2 manifesto PR

Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 include/linux/greybus/greybus_manifest.h | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
index bef9eb2093e9..83241e19d9b3 100644
--- a/include/linux/greybus/greybus_manifest.h
+++ b/include/linux/greybus/greybus_manifest.h
@@ -23,6 +23,9 @@ enum greybus_descriptor_type {
 	GREYBUS_TYPE_STRING		= 0x02,
 	GREYBUS_TYPE_BUNDLE		= 0x03,
 	GREYBUS_TYPE_CPORT		= 0x04,
+	GREYBUS_TYPE_MIKROBUS		= 0x05,
+	GREYBUS_TYPE_PROPERTY		= 0x06,
+	GREYBUS_TYPE_DEVICE		= 0x07,
 };
 
 enum greybus_protocol {
@@ -151,6 +154,49 @@ struct greybus_descriptor_cport {
 	__u8	protocol_id;	/* enum greybus_protocol */
 } __packed;
 
+/*
+ * A mikrobus descriptor is used to describe the details
+ * about the bus ocnfiguration for the add-on board
+ * connected to the mikrobus port.
+ */
+struct greybus_descriptor_mikrobus {
+	__u8 pin_state[12];
+} __packed;
+
+/*
+ * A property descriptor is used to pass named properties
+ * to device drivers through the unified device properties
+ * interface under linux/property.h
+ */
+struct greybus_descriptor_property {
+	__u8 length;
+	__u8 id;
+	__u8 propname_stringid;
+	__u8 type;
+	__u8 value[];
+} __packed;
+
+/*
+ * A device descriptor is used to describe the
+ * details required by a add-on board device
+ * driver.
+ */
+struct greybus_descriptor_device {
+	__u8 id;
+	__u8 driver_stringid;
+	__u8 protocol;
+	__u8 reg;
+	__le32 max_speed_hz;
+	__u8 irq;
+	__u8 irq_type;
+	__u8 mode;
+	__u8 prop_link;
+	__u8 gpio_link;
+	__u8 reg_link;
+	__u8 clock_link;
+	__u8 pad[1];
+} __packed;
+
 struct greybus_descriptor_header {
 	__le16	size;
 	__u8	type;		/* enum greybus_descriptor_type */
@@ -164,6 +210,9 @@ struct greybus_descriptor {
 		struct greybus_descriptor_interface	interface;
 		struct greybus_descriptor_bundle	bundle;
 		struct greybus_descriptor_cport		cport;
+		struct greybus_descriptor_mikrobus	mikrobus;
+		struct greybus_descriptor_property	property;
+		struct greybus_descriptor_device	device;
 	};
 } __packed;
 
-- 
2.44.0


