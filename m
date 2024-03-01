Return-Path: <linux-kernel+bounces-88116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A086DD7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5991C22529
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05616A35E;
	Fri,  1 Mar 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6G1bmjo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E56994E;
	Fri,  1 Mar 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282968; cv=none; b=OeLZLkbhBQKq5xRs6245nB6Deh83HsrK3W3fxuQMTEOFbk53jDGN58CVXKudJBcILNntNub8DdMr9nXz82BVAJ0V8HnRuGsOKcE+1MkISrN1bclusepwHn9kRFQgW/8QSQaErq6njDP+xWlj0J63x6VvoHlUTbMxNs3hOUX4foY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282968; c=relaxed/simple;
	bh=DW+s8lTWKFkamWUlLkKBFFDDJPnNEVE4Lv//8OKRTu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuQRqZzt2KgpUGCQZfUPJ8fq+iG0nscCb2IwRVSmj9/a//unh4RmqRX0Tzm4GMuYl73mMwrrNvS1n5xQeHxt/ERiPFYRzcU1plhlKZZhMgAGiuv9vev+c26jxwzyVAsYAmoScbGXAtxa5dsOl64nrqeFJ4F0Ssu5BET9ZIvvnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6G1bmjo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412bef42c91so9469925e9.2;
        Fri, 01 Mar 2024 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709282965; x=1709887765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKDDA/un+EZ0izsCtBEAsqVDnjIUKBkjfl0BkYbb1Xg=;
        b=M6G1bmjoCu81gVLd/yuCm4q4/Jp41ujcXSTioSf1fR/XqwBRJIoxqi+7GybHPnVrt8
         OA9MKntpQoZtXqnzX4Z3gz8V7YWZGI+ZLnenr7ySCT2oLdfXqq0nhRmxs+G3BBtb9N3p
         3PCG05rMY2EUqRVje/IKPeF/FoAxUgkreRTsAwUHwOO1VUKG5181mmPMujXlhTO45xuD
         104Diuv9ZPW17fhz3qukij3RjHyp5umQW4/XTcDNlTTs4jAOT0UTDLJUZpQX5XSh/MIY
         f+pzncfRAns8F+nantbV82zVmRoAYKSjiJRGpPG1GPY8qOQH3iYcBsD5m2DykqhmuOww
         Wtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282965; x=1709887765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKDDA/un+EZ0izsCtBEAsqVDnjIUKBkjfl0BkYbb1Xg=;
        b=LgQa/2ImmTsNwYhVm0ioVmh8stJt/NdjWxfb9MMw+bgp2TUd6l8GkTOtIpbSLTP7zW
         zSJJ3JwSJ7unDX5j+KJ6fYxelwqBnyo5iiTLOE+/GIUJHJMtMS6QvMRTBq4HiH7kTL3g
         +bKTFRjJWmzd6bW82tYrhWTes/2/bmEmIACnT4JB5VegHhVc+vqdpthkFxnY8zoIIE3P
         LMRlsRyp752bxhuFcG1qD4DBBghkMyi/pSzvlqKE8PRnA2Ay6bTAfpQmgMiriHttbl0x
         7ZwmWF/vUvryfOeGPhthoXnlvMYTowzcJEneEg8B5t4My4dxsOMOrwfuJmeF375JWdeY
         H9dA==
X-Forwarded-Encrypted: i=1; AJvYcCWqKfs4DNCEPiuV5xUTOPr6NZ6nXszaaEZjo/5/H3JLADkQKGtX8tmgjbGbdZz7OvQfgAeFdleNLlTMYx2nBFFfVtedSn9Q/7UTNf3iTIQt4IF+r4zkr3OwO7tLn8NVexNkgEvOTYjGAQ==
X-Gm-Message-State: AOJu0YyDspoYru7l3oXqD9vZHd5LlgF9z7j8VuWkmYhll/CgEciZgSsG
	DbpwCa25k6r1WeI/dLsf/REsUVcCNBAuCdJZKoxoEqjJm6rSOCB/
X-Google-Smtp-Source: AGHT+IFq1YVF7esH33lbpSAekWPKmcHytjI45jtnoR9W9mGatyyX4Tn5MAuBPwVLsAxfu8xZUgeA+A==
X-Received: by 2002:a05:600c:468a:b0:412:b0d3:62f4 with SMTP id p10-20020a05600c468a00b00412b0d362f4mr861878wmo.26.1709282965422;
        Fri, 01 Mar 2024 00:49:25 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:46fd:a61a:68:ed87])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b00412b10ce488sm4583566wmk.23.2024.03.01.00.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:49:25 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci
Date: Fri,  1 Mar 2024 09:49:01 +0100
Message-Id: <20240301084901.16656-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301084901.16656-1-eichest@gmail.com>
References: <20240301084901.16656-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Previously, we had the sleep-moci pin set to always on. However, the
Dahlia carrier board supports disabling the sleep-moci when the system
is suspended to power down peripherals that support it. This reduces
overall power consumption. This commit adds support for this feature by
disabling the reg_force_sleep_moci regulator and adding a new regulator
for the USB hub that can be turned off when the system is suspended.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index bf6d27e70bc4..bb066e726527 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -43,6 +43,15 @@ simple-audio-card,cpu {
 			sound-dai = <&mcasp0>;
 		};
 	};
+
+	reg_usb_hub: regulator-usb-hub {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpio = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		regulator-name = "HUB_PWR_EN";
+	};
 };
 
 /* Verdin ETHs */
@@ -183,6 +192,11 @@ &ospi0 {
 	status = "okay";
 };
 
+/* Do not force CTRL_SLEEP_MOCI# always enabled */
+&reg_force_sleep_moci {
+	status = "disabled";
+};
+
 /* Verdin SD_1 */
 &sdhci1 {
 	ti,driver-strength-ohm = <33>;
@@ -204,7 +218,15 @@ &usbss1 {
 };
 
 &usb1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	usb-hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		vdd-supply = <&reg_usb_hub>;
+	};
 };
 
 /* Verdin CTRL_WAKE1_MICO# */
-- 
2.40.1


