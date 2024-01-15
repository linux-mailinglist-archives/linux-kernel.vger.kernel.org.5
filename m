Return-Path: <linux-kernel+bounces-25848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0482D6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55B5B211D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB277101E2;
	Mon, 15 Jan 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImyIWIEy"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02659FC11;
	Mon, 15 Jan 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20400d5b54eso6091316fac.1;
        Mon, 15 Jan 2024 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313137; x=1705917937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xuERi+6bQR7y5tPqB1j/AvrNG5S4Bu3K4yfT+CBdxo=;
        b=ImyIWIEyF3Ir3I5KgNM309faoN3QF+XtpSfAqLcfcqBAdduftBj/pHXb+XMexq1fVm
         lD5dPXvHJQwz4PnI4Fau6ftjEnam/lYgHj50ehw6SzvOh3g9Pnne2aaMfnTn39VSuT6D
         NcjGlka8daRq4TLS9AJlTkjEhjDiNzZwupG+uE1ciah/Mw0n4j3/dpHt8U/5b9NGX93o
         1fpKVh+o62SVkAgw4yJipGkblEVpYoL27VrezuF31GhOo0c3AJA9uoiHUepLLtrwWBVi
         JbqtvdW5xUQmJLhGsetivrrE3HUrc2Aqh4VNVmU429SmhL+ottQ13dVDHz8qQTPR7lMc
         4tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313137; x=1705917937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xuERi+6bQR7y5tPqB1j/AvrNG5S4Bu3K4yfT+CBdxo=;
        b=ZWMCRHi5jdR6g1qY6FMTGlZEAHUiqqF5lZr2gv1MKw1Foed5zqKIfAq9H+R/i/ECMu
         I0YIZK9YMn9ttR06DGBsdk8BeOzm2eWuILjvkj1n1z22JNvhTjiToqsOAc0Q19imBC7Q
         xr5H5yubuiYJc+ME6NPDWOgVLAsseSWNXsFQhlyL8YByN+ujxBSy/+G3M9OwTRZNbDAZ
         h0jzdrS2V6d4sWkYC/68tDxTkbHxBFcFYdNM9wvLmkmbDm6FGOxdW1j0WE/Z9MVXMtS/
         HZAJbAijdu8x5bq+EPRMPiOm5DtdRSJI5ZJYvG3Mx6oiWvUzXAXKOjiuYWCbyVuxc3jz
         Q0CA==
X-Gm-Message-State: AOJu0YwuFkL2RbTnDg2qj4TgEy1QVJENyPq0Uw+tQI03WDWelsBWgaGZ
	VTcwr6kFzks0N4l2s4gDbPM=
X-Google-Smtp-Source: AGHT+IGJRg3xp69kXQGlFO0nRnfXE1MCJJVk/1Kyq0qjQ4MhVNt7O/VwtNkrJs3jJiFrhCicIqWczA==
X-Received: by 2002:a05:6870:9a24:b0:206:81a7:9a7 with SMTP id fo36-20020a0568709a2400b0020681a709a7mr7646364oab.4.1705313137004;
        Mon, 15 Jan 2024 02:05:37 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d10-20020a65424a000000b005cda7a1d72dsm6870712pgq.74.2024.01.15.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:05:36 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add asteralabs
Date: Mon, 15 Jan 2024 18:05:16 +0800
Message-Id: <20240115100518.2887549-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115100518.2887549-1-chou.cosmo@gmail.com>
References: <20240115100518.2887549-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Astera Labs, Inc.
https://www.asteralabs.com

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 02aaa1f538b2..ec8cfe1b46b0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -157,6 +157,8 @@ patternProperties:
     description: ASPEED Technology Inc.
   "^asrock,.*":
     description: ASRock Inc.
+  "^asteralabs,.*":
+    description: Astera Labs, Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
   "^atheros,.*":
-- 
2.34.1


