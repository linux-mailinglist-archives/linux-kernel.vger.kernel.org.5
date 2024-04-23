Return-Path: <linux-kernel+bounces-155376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400158AE989
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF9B23FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEB13BAEC;
	Tue, 23 Apr 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOs3Jeb1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22313BAE8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882671; cv=none; b=opMaTuEx2anYXRNCAk4E/jCWCLE6kZQPRIAFRDJ9vB/ixHJDg4b2Pms9cb7GnPjTS4b5HisfEDHjFNNfTcvJVkfb67IavcsnyiH0ZN4zMXUOjMwSaKnbPNtkwLCaGEVrsM91dHPSBfPkLdjLfDPbjOlNjJzuXYnIzPN28mvO6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882671; c=relaxed/simple;
	bh=+UavbOojFmAIVuDGknU8MaLgwR7F3N2h7Re+qQZJ5JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2YEcCbj8lPFLT8Lz7z5QZnaHlMRIUK3lxT2R0IdE3s8NrBXAFpCVH6SD7WvGMItSvcL7OjJRIbpPjtrwhpBhNSSy+cW8ZKVn8djf/umue69ewFHrBR2SDrUw6rj6ZFRYXtn6O+uN7ihiHZXNPVa618gTwQ29NzZSgA8BfDehTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOs3Jeb1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57225322312so628059a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713882668; x=1714487468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IDPH8aO0C/CgFOvGahjdiLNFhkL4WdyF17UbMtaO6w=;
        b=uOs3Jeb1PBkFtWHue3LJysWPE/eiRq3MCNKtsJxYiuc7IaJcbHK7/KErEkfvXtLgxL
         gFI0NuAzJuSCOzl+I01w6Wn3b9GistRxrPz2nuTa7g3Pu6tF2WBY1FB/tLJsVKed2dl0
         v+M1sI40R28l+M2ckMburiyRR43YBJx6qHf7AcjSNkXwXkIiEDpBMYywSRWN777x5iZU
         bJamRjfIZBhs7ytAWOyLS4h5JOi7UFf1OlCzIFnRmmvr9rdtQc8PiGrs+2/84UkjC5/y
         qAyYNA9QiiTltRX36BP/DaUeigB2ZkuFHe440azSRtN9aBKBAviO6o+bYrUFIqwEij+S
         lu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882668; x=1714487468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IDPH8aO0C/CgFOvGahjdiLNFhkL4WdyF17UbMtaO6w=;
        b=BLoARaiY93MeHXrEveqK8Iq0IKnCRZmwThVPixpGIgRRCTdSma9GvIzVaLQm49ICdl
         06buxsTB3lbimKNG2ELAuLVgRTJnZBjBh3WCUyjn3KjKecaYdl1rv1Og8zZK6XR6wJww
         kAMqOiQUyhQ5kmiPvYopvWHwioJFYhY1Q7QMJn2bEnKjE6PXpUyYpsfmEQqDfSBGJ5n8
         brICKXzyy6Gucb3WvKmciwBqi5pWkWFFG/YbT06c/chbgd5AkQiMYw+xUOaPwXFkfyky
         sZAJ6zP5LmBd9AEMqc8uOQ2lfeuRme1ytJG4NPJZEG+aCPjhlSV5J1tyTWoVNUnVQ/RR
         cfVw==
X-Forwarded-Encrypted: i=1; AJvYcCXZNgvPSzUSVUc2wc4Y/zyY82ycCAIbLuPQUHWj0ZMN6w6kHARQoaivcXqrMc/kIq1+jhHhdqIuA7NB1hiT/bQaSHPq6WbWipNfgLA8
X-Gm-Message-State: AOJu0Yyse4hq7bq6Uo+AJnxg8AN8aMUFKEEiiohbvPQOb7dOp9nRKM4B
	xu91SzTpkW2t8LzysyOiRAuthjXSfxWK+ztemSEUMhIVPGbvJO9ZFZlGb0UAnqE=
X-Google-Smtp-Source: AGHT+IFYZf3kNXrbsNynZ3gGf77a9GhwGcDNyKdEdv42OO0DXfASpzIR/lk0VyJPU+3cTv810Ziq9w==
X-Received: by 2002:a50:d5c3:0:b0:56b:d9e7:1233 with SMTP id g3-20020a50d5c3000000b0056bd9e71233mr7620642edj.32.1713882668343;
        Tue, 23 Apr 2024 07:31:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005704957a968sm6708099edb.13.2024.04.23.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:31:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 15:31:04 +0100
Subject: [PATCH 2/3] arm64: dts: exynos: gs101: enable cmu-hsi0 clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-hsi0-gs101-v1-2-2c3ddb50c720@linaro.org>
References: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
In-Reply-To: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Enable the cmu-hsi0 clock controller. It feeds USB.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index eddb6b326fde..9755a0bb70a1 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1247,6 +1247,20 @@ spi_13: spi@10d60000 {
 			};
 		};
 
+		cmu_hsi0: clock-controller@11000000 {
+			compatible = "google,gs101-cmu-hsi0";
+			reg = <0x11000000 0x4000>;
+			#clock-cells = <1>;
+
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_HSI0_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_HSI0_DPGTC>,
+				 <&cmu_top CLK_DOUT_CMU_HSI0_USB31DRD>,
+				 <&cmu_top CLK_DOUT_CMU_HSI0_USBDPDBG>;
+			clock-names = "oscclk", "bus", "dpgtc", "usb31drd",
+				      "usbdpdbg";
+		};
+
 		pinctrl_hsi1: pinctrl@11840000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x11840000 0x00001000>;

-- 
2.44.0.769.g3c40516874-goog


