Return-Path: <linux-kernel+bounces-17934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3513825551
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D41C22E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D0434CD3;
	Fri,  5 Jan 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vXAP/mmR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1131A94
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28cd136f03so187282766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704464964; x=1705069764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcIsCf9lD/knWhOV4w5QILuSqh1F/UU7FLo8OWJM7Io=;
        b=vXAP/mmR1F3UOq0ZfU8iZoHma0GHpgvcu8NTYuu0fUvhGtkCVBsf012UbNPPZ+GE0w
         SjncPnq2YABwM5/q8f8p8R0VIz/jFp8lgL5sZLQGE6XvuTDEZ0qrnkHL1QZRxI87LkVY
         +bJVJdCOtNexXed0u+8RnhFnjxJMJGhzKmlxUGI+os6I2c1aIuoYkS0SYSgdBO8xbFBX
         WDWDBeu/HTli1oW5mubOhyOFd5A98Hauo++hojNRKUWI29jMzbsObsUw1l0MY7kPH9ZQ
         f64YQohUAZFn+g9PIAJtBiD7oF+/JULHYLNsmZkgd30AxYJI9Ksh4pHNoobh0uVh4gJK
         IPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464964; x=1705069764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcIsCf9lD/knWhOV4w5QILuSqh1F/UU7FLo8OWJM7Io=;
        b=E/D54yy+DgX58Hy0oyiupoVxkilq6Q3bAtrJvqelgUwxPVjxjy3O62viWPURQvnUmG
         E5UDV5qDyzEHcFrsvLjQlCbkWxWzzRCuvL8y5Q0RKLCjZhqcDQmB5YFD8THhb1EgdLcP
         tSrHrH7kG2zNZamQ0sFm9Exi6KItlTsnU/pOpqJGbIOVQpAq5cKYU2fFd/wYmyP8vcdO
         jtOKPlscnBd2rL9sOtXg0G/+q6B3GgExZVxvsJWDH3lXqBrMeelvvzC5z2Ky8lc4xYDq
         cIaWcQSRMkn1GIc9wlk8Dxla+SOi+0SNdYrqz61810BAXDNYiCVajmhb+8K/JsrUIHPi
         xv8A==
X-Gm-Message-State: AOJu0YwavoX5eKSmAxJgTQKTH8pni8md1LvwS/USEzzqdrot7djMeT96
	+utmMn9f6Ki4axV/wGLrTP4X6AlpX7j+8g==
X-Google-Smtp-Source: AGHT+IFG3RJXE6tYpwVAbEAn7QPS50WJ+2cJRim2jdSJpfqmulybpFQu+xxg4rk4FJSzZPs+mAwQag==
X-Received: by 2002:a17:906:6d3:b0:a28:be7f:3ef4 with SMTP id v19-20020a17090606d300b00a28be7f3ef4mr1170053ejb.24.1704464964761;
        Fri, 05 Jan 2024 06:29:24 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709067d0700b00a26b057df46sm927006ejo.126.2024.01.05.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:29:23 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Jan 2024 15:29:14 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable display
 and GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-fp4-panel-v1-3-1afbabc55276@fairphone.com>
References: <20240105-fp4-panel-v1-0-1afbabc55276@fairphone.com>
In-Reply-To: <20240105-fp4-panel-v1-0-1afbabc55276@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Add the description for the display panel found on this phone and remove
the simple-framebuffer that was in place until now. Unfortunately the
LCDB module on PM6150L isn't yet supported upstream so we need to use a
dummy regulator-fixed in the meantime.

And with this done we can also enable the GPU.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 62 +++++++++++++++++++----
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index ade619805519..8eb376f2db46 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -45,15 +45,6 @@ chosen {
 		ranges;
 
 		stdout-path = "serial0:115200n8";
-
-		framebuffer0: framebuffer@a000000 {
-			compatible = "simple-framebuffer";
-			reg = <0 0xa0000000 0 (2340 * 1080 * 4)>;
-			width = <1080>;
-			height = <2340>;
-			stride = <(1080 * 4)>;
-			format = "a8r8g8b8";
-		};
 	};
 
 	gpio-keys {
@@ -68,6 +59,14 @@ key-volume-up {
 		};
 	};
 
+	/* Dummy regulator until PM6150L has LCDB VSP/VSN support */
+	lcdb_dummy: regulator-lcdb-dummy {
+		compatible = "regulator-fixed";
+		regulator-name = "lcdb_dummy";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+	};
+
 	reserved-memory {
 		/*
 		 * The rmtfs memory region in downstream is 'dynamically allocated'
@@ -365,6 +364,10 @@ &cdsp {
 	status = "okay";
 };
 
+&gmu {
+	status = "okay";
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -373,6 +376,10 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -404,6 +411,43 @@ &ipa {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l22a>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "fairphone,fp4-hx83112a-djn", "himax,hx83112a";
+		reg = <0>;
+
+		backlight = <&pm6150l_wled>;
+		reset-gpios = <&pm6150l_gpios 9 GPIO_ACTIVE_LOW>;
+
+		vdd1-supply = <&vreg_l1e>;
+		vsn-supply = <&lcdb_dummy>;
+		vsp-supply = <&lcdb_dummy>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l18a>;
+	status = "okay";
+};
+
 &mpss {
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
 	status = "okay";

-- 
2.43.0


