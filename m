Return-Path: <linux-kernel+bounces-45674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C48433DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C04E1F2678A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565663D0;
	Wed, 31 Jan 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+jpgNR5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50058EAD3;
	Wed, 31 Jan 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668063; cv=none; b=Lwplk/WlUoUuPatm8rwvsikqHr8TRI8zIxaKA2MbGTg5p2PNIp0L3kMBDrktBiRBpKkO7qs4PbQclzd5t6tKH59Msn++iRw8zts60C+EyNrwmytISJ5PWZzfMDgwp07BSOFvLnhdeRlLlRAN9IxmdfHLPRoWjd0/A2EFTP032V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668063; c=relaxed/simple;
	bh=AOE7n0KnewlaWwxbj8BBqxz1kEl4nUkcJEnkd3Rd1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hH0wcr1VSixaPaHwY5l6hhsW7YIHUCbUyc5JhflG6UxauMI2tIWWjf8Bapx6PJIWSPVfPU4BNwr6m344vkE8LGOys4AbidfIG82v5jrfM8KfLIJNTcf/gUIBM46qDbfKdCI3O+7DJYrHssrzBXby0hObfkK+SWpEKgz6l4eEz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+jpgNR5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so10556925e9.0;
        Tue, 30 Jan 2024 18:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706668060; x=1707272860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=R+jpgNR5HjHv2Q8r7VHk6c/DXsmadNZumly8nOpPHY9vmNfK3jKuYUh0XRvwxjiiYy
         4JPwv1G/F+Ged0dYUhq3fMqRJ1VrFKmvleb/tdDBt+oN7TwpYWEiArqWdBMN3rrhJ0i4
         mPXnxhi0Ie8ZgvNPnA7299/uwd3UWxk0SjMdMq50u6MNtLDSdziGSoTPiTutiTWWoweg
         bLDhmQzTS+eZiZAkYIxZ3ZZKJ0i1GVvh33cn7AeKuPsuyQKOEPTivpjr7j0INEgWITtc
         aZqQIs2aHFvsm3ZJ2fnVbEBZrVR9nct9ljh/epsdscNcrTtm57avu+jioe5tTmxSVciU
         i89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668060; x=1707272860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=wfcQAJ2fllhCJkMaCpY2dBp3yfowy+XDmgfZ3/ly+iGnT/73duawddQAuQEwkgbgrS
         Oe39JH7CFgGzKPOk6pIISAUIT8cfNFfBg8qNVU543QugYI6vhZAdDPJfpA9UZOxGQoYz
         vbt28Tc+EiaVOZjeOY2jND9ja8GB6CAPPwsobqg6x+uo9/ZUa4klyKm7ldXQmwEE0lYt
         Kj/4XAqZFa1bXOejZ8wlzU8U+cvIjJwK6c+rCXKxWK3VxRQwCqce9wVu6C/OLCLhSWTt
         T4iFSWgYot4Ua5odqwkdz4O0DTISvxUDHA3g4GsJGXGR6cVQfF2STGw2pECOFa6hmUpc
         xrdg==
X-Gm-Message-State: AOJu0YwfC+WbwVqlYYY/Q268Ytr7FBatezMWXIubqdCzOgJWzUptpVw2
	Sn2uCw1WOtKRPN1vZi1t5vY6V6oFAiLpoVVeAH63/uGekCbnUZSU
X-Google-Smtp-Source: AGHT+IEfuX5naflRiSxTuABH1p4nt4fptctJ+l1YuqFTiJXHp73kkRs5JyN75ighFRfKA3JwPrk72A==
X-Received: by 2002:a05:600c:5487:b0:40e:4ab8:639b with SMTP id iv7-20020a05600c548700b0040e4ab8639bmr188577wmb.39.1706668060321;
        Tue, 30 Jan 2024 18:27:40 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b22-20020a05600c151600b0040ef10ccd43sm980580wmg.1.2024.01.30.18.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:27:39 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
Date: Wed, 31 Jan 2024 03:27:29 +0100
Message-ID: <20240131022731.2118-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
of using the default value of 390KHz from MDIO default divider.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2f275c84e566..08ddfeece043 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -264,6 +264,8 @@ mdio: mdio@90000 {
 			clocks = <&gcc GCC_MDIO_AHB_CLK>;
 			clock-names = "gcc_mdio_ahb_clk";
 
+			clock-frequency = <6250000>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


