Return-Path: <linux-kernel+bounces-162064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604288B5572
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4DAB22351
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C5F3BBEE;
	Mon, 29 Apr 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBED0H0I"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4A39FE0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386955; cv=none; b=YsaIAky61nVBX9PYWv1eeOjWSPXfv85GBagXJJ473tz9egZnDRkNxDG2bXTtzHPVjoWCP9VlXpW0/SUQvA5aA1jHeHCBT5BZYK/T0z48sUuw8looQWpNX3K/veCr+FzpsxnVMlCTUw0vRO+suA7/TOzl7uzntU414eRvNdwl1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386955; c=relaxed/simple;
	bh=fts+EqqJEQMrSn2q2Mnm1gRT3XAykdHfEXeGyXOoxD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQ/QFrJ/QJbIlH9FKbsex/fqVfDHZbq277EVRnunGZ0Zc/1lKv5PrQ4VPRf172Oa6P1gLCchAQDzmVjUooWhTFYtj90ihVDpVf85dXET/9SDi3+223REbUzf0RQH8ZmRmhHbNQtKPk9u/TRPFrUQ90IyhJdy6cyoVHtq6eIe/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sBED0H0I; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57288691c07so558505a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714386952; x=1714991752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BotRiJuMknWO6A5uoPFQl9tYeRWBO9rg60FRsrEoXKY=;
        b=sBED0H0IlFIapE29mdU+pj/yq+rIygRb89s4O6RV91k0Gqmv9F8H11201zr741v4xw
         /qojsXWw0yU7moG2rcNbPO31+qpq4LWrui22B2/w+SxGTJmmPDvJO2zzy9sO+G3Y/pOM
         koF8SYMNRG4i1X0ht+1ycsjt5QQmnT9dpDulH+5MSURSd1U9KYMQgBCrxD8AuMFvX1Oy
         /CCF7eSkTTIxD6qanFa2OUoSHQTlchTS4rVLG56Fm2H7pL3rbSs8oPJGFcUgSOGoTXyd
         CHiC/LX4MEqLndN8rwO2cf9wqrfL83CQ5m1H2D1i6LbUdtrm45WpIkatb+rM13+8B3FW
         oy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386952; x=1714991752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BotRiJuMknWO6A5uoPFQl9tYeRWBO9rg60FRsrEoXKY=;
        b=YrNw+uJ8qnSDHFPuaI8khLcWCOXgtqpV2tbEcLXI4aBtEjgTAHSXBiAM3OUtBySllp
         iJQSOKghVF6XyKZJBnxY+v1y9nwE7n/Y1VjiWcXFYZFUvXwYR2EzMLM33o5YHDdx9W62
         Z4ghYRuYLw3sd/J5owWoLqX7Gmr5TkH/M0eC+LjJakrwiXJ5+s5V0D7vAjzpyweX1c/G
         hkII3S6+HQzbb7BibskM+7cCda71vcQkFL+48Gi5o4pwzgNxwjHu+8/25FvmGCHukPzZ
         eAqD67DAqGf9x3M2d3uWKIb/VVF1Xhd0Qo6/pCEYpgWriZVsZWoIah2iyLWk958qH1Fr
         C5cA==
X-Forwarded-Encrypted: i=1; AJvYcCXz2xlZUEaU1V0iOkuQNSnS6RqZAS/BAlNE3L7+1+7eTSsqyWESF/wF2/lQiyO3aFZAuEeruUrhUclNS6OMWw9NHpQbGc+i77ZuM2OL
X-Gm-Message-State: AOJu0YwTsVfUdf4CRxoAqbx0iWSrpdCe07Oo2gyFCT0tthBoeKlKumXa
	vDoBnSNbeDo4S+X0Rd5tQ+C1o5vCPRyoUfGvpxK24TiYZqL/HfbFjccrXx1f+sY=
X-Google-Smtp-Source: AGHT+IGO+qUZw0HaGip2ru9OKaK2870UwQguaV2epeETrTGCGciSJ5nPdGOqzy/4vS/d1MIGqydbTg==
X-Received: by 2002:a17:906:fa1a:b0:a52:1e53:febf with SMTP id lo26-20020a170906fa1a00b00a521e53febfmr5597846ejb.69.1714386952083;
        Mon, 29 Apr 2024 03:35:52 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b00a522bef9f06sm13717707ejp.181.2024.04.29.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:35:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 11:35:50 +0100
Subject: [PATCH v2 2/2] arm64: dts: exynos: gs101-oriole: enable USB on
 this board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-usb-dts-gs101-v2-2-7c1797c9db80@linaro.org>
References: <20240429-usb-dts-gs101-v2-0-7c1797c9db80@linaro.org>
In-Reply-To: <20240429-usb-dts-gs101-v2-0-7c1797c9db80@linaro.org>
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
enabled by the bootloader. A placeholder regulator is used for now.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2: fix commit message
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


