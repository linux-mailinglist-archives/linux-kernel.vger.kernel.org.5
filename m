Return-Path: <linux-kernel+bounces-68423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12056857A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B926A28256F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E08208CA;
	Fri, 16 Feb 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1hBmwRTP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4091CF94
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078259; cv=none; b=XFyAYqQUHkEfOf7ZO2Yo9nAGo20uzzbaTpE/66sBV69maii99itSJ/o7jHyp4eiPWDoO4gefjeFpg3Fwu6LoxExkXsLm6YBE8kcTCTm+N9JrazU3usT8AiEw2z6SZ24trqIr3ZC+MpQwTYID80IZeKTcKbZyZW5URi6LBr2U/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078259; c=relaxed/simple;
	bh=4Du11M3VzUfqimWgLoJBAywNDaWIGTyQLxBL2NShpoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQV3198wX4ZsIO7sA40F5HjdIF0ET7a6e5ZdT4bEuAc/TLKDyXEBIJQwIKhZwI0A3qnfk5vS6o0oK/WZSCwRyhsuMrH4zt4uO5LwQHGERi3T3ZqxhBSBehEdY8iiBVL9wzXvwl/3Gmj+0hv6FM0CsRBHuTYwMLzwp0WkSajwhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1hBmwRTP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30f7c9574eso245374966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1708078256; x=1708683056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmseNUB8XmILHTMGFvZmTPWMBMRG2oDjG5cDxIINlKQ=;
        b=1hBmwRTPxKDwlQdzpcNmd2xv4t7A6XCkx2uRGL4Db/3l4GA/nJhpvCilxWuMB0a5Dy
         LWaWrUngGtm3vjILB4B5TUPs9jOucnVm1nNmMKGr5/Kx5qVrVaDqwRoML6Nm+d1tDAdk
         lRwXtpa8wikntFu4yq5W+5TOYtGgeYUd5mJParJr83vU8jxW/muqHnwc9xFdMRn3cdfN
         o4RbTTH6Ay0pnnXHfA1kZee4tZe0tpXHi0OKj2ds6+ZvfpQN/xxJSgw0K2jthZwbgxnX
         KcNQqk6UvZngVIa30so3ew/RDZWMfV3a7Onl+JMdo6E+0cP6xXeivgAHJElsFpl/yY3e
         l8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078256; x=1708683056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmseNUB8XmILHTMGFvZmTPWMBMRG2oDjG5cDxIINlKQ=;
        b=tq1APHy6vhcY/u3Ruj30pVRWNMDqPFVoSwHivNPONoIQY1YVDO/uNa6FcYke85+koJ
         sWodQM+QseOJvF8znJg5/CKH9j8Xdsb4DehZIcj649wVcvvtc2//OM6S6PaqK/Q9Tvun
         0nWRY0tRF/x6v1Tia9KA64GJL+zYhjkANe2m9Yn8utS7FHngF7SWus93kogBhgF/OrDY
         Vpf9hoJngZEzCletmlQO2g8GGnxf5ApoUHBE3rceV23zXoZj5pGm3svE5TbRrobNZCcm
         MtRage3p5y8Ets536MsEqGR28PtitkD8wdhya/xGlfRi7DkIzZcnhUnyexYncWDuPXfH
         e0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwj2vb5WlVL8aXXkynQnbcCt4PBKusmPcWAgKAgfcKEKe0VVVMW34GagiKpeeVrwpg9OIzc6kMm7y5RLzsp3RprSueFZlY897wO/k
X-Gm-Message-State: AOJu0Yx9xar6CnghV1P85Nus4iodUdeXIFnypCCLNuTnLVlEGYUwkSl8
	KXkLowLOntIIhwTaCBA0lhu3qA4f8vFHP/c1jrQhDg+PG23jkfATLrvEuygm6Z0=
X-Google-Smtp-Source: AGHT+IGal/6tJIPm3J0RtSc6ctiEJ5BTu7plrarS8+4pAaRz8meufv50XtRwP5cMKv1YKhUbtkQgvA==
X-Received: by 2002:a17:906:6bcc:b0:a3d:f81a:d50b with SMTP id t12-20020a1709066bcc00b00a3df81ad50bmr112120ejs.70.1708078255900;
        Fri, 16 Feb 2024 02:10:55 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm1398019ejd.113.2024.02.16.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:10:55 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Feb 2024 11:10:51 +0100
Subject: [PATCH v3 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 display and GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-fp4-panel-v3-4-a556e4b79640@fairphone.com>
References: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
In-Reply-To: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Add the description for the display panel found on this phone.
Unfortunately the LCDB module on PM6150L isn't yet supported upstream so
we need to use a dummy regulator-fixed in the meantime.

And with this done we can also enable the GPU and set the zap shader
firmware path.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 53 +++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 5a05f14669be..c8099b10ddc4 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1328,7 +1328,7 @@ gpu: gpu@3d00000 {
 
 			status = "disabled";
 
-			zap-shader {
+			gpu_zap_shader: zap-shader {
 				memory-region = <&pil_gpu_mem>;
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index ade619805519..4e61da8078d1 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -68,6 +68,14 @@ key-volume-up {
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
@@ -373,6 +381,14 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sm7225/fairphone4/a615_zap.mbn";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -404,6 +420,43 @@ &ipa {
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
+		compatible = "djn,9a-3r063-1102b";
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
2.43.2


