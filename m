Return-Path: <linux-kernel+bounces-155892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E78AF89E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F28B29ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0A144317;
	Tue, 23 Apr 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzO2akyG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAB143C6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905574; cv=none; b=A98HvUydW/xM2rs2ssPxPjtFzXZ9fkrSotTIv8kv9Dimh9Sinn43t5yGxTGNqpAyvFOQJJZFZMthNKAPxfEg59ETVTbyO+sDVtypEG9QQJsZf26JbFF36lqwJP10NgQztFj3NXEZv/RbQGabVjZEM6WzuNtZhCtisvyjZ9cH/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905574; c=relaxed/simple;
	bh=ynd0BU/QdPiedpmwy4ixCC8VlFeGhbbYTb+LcXtnnXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKToribB7Wep4geFUR1JHe4lqy0ASvHGC6fN9M44wnw4NigRhpUKZbpegSnEDrRkg9VBalKEYruc5lqbR7GR+ZPEL7CEloVGbGMXlVKY8Pmsa+9sgkcpzoBi12rdMZa5sc+Js3+I/fhK17e88grSyoxXSR9dx+bmvHkEH8/7QDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzO2akyG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343f62d8124so4938563f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905572; x=1714510372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBOMQvlwyQAQ+Abc2xhhW1DcJnrKUYVw/PPBC3M05Co=;
        b=AzO2akyGPqpe7pcru1YNxiMPxP8U9d1xLa158rAyCjgZkiL6zubvhbHG1oqAFKAfDY
         PBlmj0HhcYcRh835S1YBYDuuDeaMOa0DZ2O5t0gxsIIyDZKrQN+6VHPSgqDg8tRdt3ak
         s4ZTL61UyGOHEonESYgSRblWbLggAbzKh7LIIcic/DYiJQ8RQEKdqSIDe3w5HkkiJVqV
         4XWhknDEOF04+iBh8yQh3pNNz9MUX6KeY2lLISsJmQOK4DFW0DRHJUTiabJJlMC39DNj
         M65NqAUNeDhu7fDVQuZJpxzua/MUPFZ7hME+Igz6f8aOfSMVhKg/L9hmdQHj6QlCWRfE
         LZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905572; x=1714510372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBOMQvlwyQAQ+Abc2xhhW1DcJnrKUYVw/PPBC3M05Co=;
        b=QMp9jDrTzmHpoqxz+rKpnVexriau0leEaUaMHi2Jsh8TPDeIJM7ZI2lnYUfBN0/4Xo
         pYwwm/1nUhZ3B/5k66EsKBS6RQwBd1XpE6bC7mE5Cps41rGWtNTvAjNUPrGa5dwuzXbD
         XkANHYk2Dj8ZFZNefgFY/pKMg/PLpC2VuFPNJ2VZWYBwOak9OFRlthi2BCU298Gve0wY
         rqV3tJsKB/4PkVHN/Nnsyosd4Zitqupcmv6RgenKB1QZzmhLQNmCnGZFdNXUpAuYAmRq
         n9QLrCvMwBKWQ9N0FwX+/kbeGo2C6EIVayougEX4wDdhuMyTW7sgQHmRpuZ11rlkWizX
         m3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXJqgq9ov2FbWXZk+EKyViQMhVOuBxeQZcEDpx18luAq5b6Lz6+jtXK0z7/NEEqBhp0V03mULnR+mvN+4W4zR7ASgd84pRQpGdyGtni
X-Gm-Message-State: AOJu0YwJkpEdoyTntZWt2973aS4D+ElAeScP9Pq67Ddla6JuDkoiVm2N
	zxjIOhd2coDIcTQgVcYPjxxE3JVu/MBHjcosTORFk1nb25qFNdsZRDvwz2xZTus=
X-Google-Smtp-Source: AGHT+IG9DgCjmKcQA9J2q7MrzxwwWtFfg6SaXIWhfP3iX6GYqmoGdroKdUSDaXrKbhvSY/tA+wyliw==
X-Received: by 2002:a5d:5610:0:b0:343:b252:2222 with SMTP id l16-20020a5d5610000000b00343b2522222mr272098wrv.6.1713905571616;
        Tue, 23 Apr 2024 13:52:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm7443632ejb.203.2024.04.23.13.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:52:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 21:52:49 +0100
Subject: [PATCH 2/2] arm64: dts: exynos: gs101-oriole: enable USB on this
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-dts-gs101-v1-2-3421b0371298@linaro.org>
References: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
In-Reply-To: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Pixel 6 (Oriole) has a USB-C connector that can act as host or device.

The USB role is detected dynamically using a MAX77759 TCPCI controller,
but since there is no driver for the MAX77759, the role is defaulted to
peripheral, without any endpoints / ports.

This allows Oriole to be configured as a gadget, e.g. using configfs.

As PMIC regulators are not implemented yet, we rely on USB LDOs being
enabled enabled by the bootloader. A placeholder regulator is used for
now.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6be15e990b65..03b2a6fdfdc4 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -53,6 +53,12 @@ button-power {
 			wakeup-source;
 		};
 	};
+
+	/* TODO: Remove this once PMIC is implemented  */
+	reg_placeholder: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "placeholder_reg";
+	};
 };
 
 &ext_24_5m {
@@ -106,6 +112,24 @@ &serial_0 {
 	status = "okay";
 };
 
+&usbdrd31 {
+	status = "okay";
+	vdd10-supply = <&reg_placeholder>;
+	vdd33-supply = <&reg_placeholder>;
+};
+
+&usbdrd31_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	maximum-speed = "super-speed-plus";
+	status = "okay";
+};
+
+&usbdrd31_phy {
+	status = "okay";
+};
+
 &usi_uart {
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";

-- 
2.44.0.769.g3c40516874-goog


