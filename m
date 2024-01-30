Return-Path: <linux-kernel+bounces-44781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508B842751
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5718A1C25D47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96D7F7CF;
	Tue, 30 Jan 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2duOxX1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E627E761;
	Tue, 30 Jan 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626663; cv=none; b=LkfW7HPHfwR1TYlXIMxeDN4cujyaJ1L1vBCQgvIkFIK1DXq6wtujeldgj69m9mMWkwc8rFNHLokJnfMcYa1wcGIwazrpC6tEXJuBy7nUY6QPYpWb8cFWz054wHIuH0cg2jCmz8RR+vGUzfwf3TVA59FQtlpJaZ3SMiUG/uJGfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626663; c=relaxed/simple;
	bh=Mb6wtC714kf+HK8azpbzU0t9E0KmcnySm1wF8tE0Wv4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ruAfizzTi772Yh6OPPaW7Jk6YGTotl5piN3MtRGvqT1yKca8xtJSFC2uzahFJbgZyIRC1oewCiE4FYcoOuJzG09PkOwujmJF5koDGfVgR2dzRsDLCePUS1zv5Tte02VDLnuO8TyLEtppVF+Pz83c/pti2Ln+Zv+glNPMDv2jyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2duOxX1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5102a877d50so4352966e87.0;
        Tue, 30 Jan 2024 06:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626659; x=1707231459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/NVySBHvc0o4wdoGiVlWfEl/BNyNyErkR0wz3BaYxg=;
        b=Q2duOxX18c/kT0VVwhxs0mP+IVGnMT98be6RP18tY0bVCPYyOiCnnioHt7rqQ31IBp
         JW2E5FbKkqexM7F13d9UOy4KnQA2D/CQXkvBTq4qiI+iOQeMrONI5PO39rIDk23eiFTD
         jlz/n023HylR0qZGdaMXgsf1zfig+ojrIo89RFYcU6D0ABOZoMfGI/9CfQUoPQ0bjoRH
         JkH5FwGJXODZq7lYzYmF2zKMRn/Bg4LjvjxHv0pTVkOjCMmFceNytH+RQQE1FMMs4pS3
         bTa1lUAYGI37J0oxMtOKvZjiiCXAUW3fA0XRfcWnlWF60/Y1048RtWOXFXt8jTp5fXrB
         k0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626659; x=1707231459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/NVySBHvc0o4wdoGiVlWfEl/BNyNyErkR0wz3BaYxg=;
        b=TipNtnqqEsgBs5ug9TSUu9o9Y1A7p8sUNAc833lg0V+9StrZJ/4Q/CfU/vp7s+aFb4
         Ljtg7S1ADIL9AT6ddlecMYG0q+b6R5yjE6ij3S/6g8VARC8qPs3N8dUGj25EWxHjOmmF
         7iRQ/9XLz3uSONqAggXg1rjoSb0AHEefRbcgjyDKOfyI2B6RGPYTint+hELg6gWPphdv
         ah5+zVob8vhZiRo1jYYlSd+PuIMay7Gs1HpppWuU46DnIOTG6/VHEURfZZ8htv6y/9It
         2+Wh+IaCD3PcFvAkvUQkU3Rm05DyMGShEjxsWciswF6SZWflXY9XA9N4fDqAk0YK3thi
         FYPw==
X-Gm-Message-State: AOJu0YymK3PGELegXZq7vwa3o9TF9FeQeqH+NJXp3OHlKubkY6IhB/hV
	WYn1/R+9m/2ERBh8jE9lA7SpCNHp7WWRHpK598nDoOdUHvXa09SC
X-Google-Smtp-Source: AGHT+IFn1Z26pvSzf1A60+etpdAcRjcbap+od6ft3lxl2E7sSOHZhEaK9JTfGX8g1RPOH8q3h/609w==
X-Received: by 2002:ac2:4835:0:b0:50e:7b4d:887e with SMTP id 21-20020ac24835000000b0050e7b4d887emr4801358lft.65.1706626659027;
        Tue, 30 Jan 2024 06:57:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtKPcxeDPDHRPcyvyciixUjP+8gxE9F9UoeTDo7kJsrWyOhFqmDwdKPVwCfKEYUPpJOm5LG+01o329oSO/CXK0fVXevvNd3hNwpoKGDQdW+O5c8GqFk7fQMph1uP6is4ZTXtj+0ofR3OLPG/JW/T65FczgaWc+i5lsqLJTzra1KQjLrmAUx4Uf6LFmUBzNrx/P+Nc1TTyjn0caviinMNAiUSFFtOCflrNF1wMr6Jv/r7XYpqYk59yjb09oFe/DHHejCJc7ou+F67/Yu/kegjf8myxnjnfEdjqL7ub3Y2qbBf2Nfgu8wn7x/LnL8ZxVxjvmCjGSafl7OGYkiXtcRmzCQM07NbIOVI5c4e5nPFOoNMYJR+eHKm+FxhxYRp+HkGDwd3vIohSxUCJEzwwO70ty6ubeDVJt3mZeh9aPOkW9yEtaZ1Fe4FHmzf2L+KREOHkg1gqGNX6pLVN8vQjDMrABxBlqcuvaPU7OUDb4/s7AD5T6vWQdDQ+LA3KWus/EsrlIRdwDP6fKO2+womw9Umlk6/igm6NG9Cw=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:57:38 -0800 (PST)
Message-ID: <691c3a0e-8831-4d3b-98b8-f08235cb3b83@gmail.com>
Date: Tue, 30 Jan 2024 15:57:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/6] ARM: dts: rockchip: fix rk3288 hdmi ports node
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Language: en-US
In-Reply-To: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix rk3288 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index ead343dc3df1..1a63281dcb36 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1239,28 +1239,38 @@ edp_out: port@1 {
 	hdmi: hdmi@ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0x0 0xff980000 0x0 0x20000>;
-		reg-io-width = <4>;
-		#sound-dai-cells = <0>;
-		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>, <&cru SCLK_HDMI_CEC>;
 		clock-names = "iahb", "isfr", "cec";
 		power-domains = <&power RK3288_PD_VIO>;
+		reg-io-width = <4>;
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";

 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				hdmi_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_hdmi>;
 				};
+
 				hdmi_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.39.2


