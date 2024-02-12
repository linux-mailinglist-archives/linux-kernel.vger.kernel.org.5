Return-Path: <linux-kernel+bounces-61145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F5850DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D851C21EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4972F9F6;
	Mon, 12 Feb 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRcDX6g0"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39571EAE3;
	Mon, 12 Feb 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722351; cv=none; b=c2cq0Bb6tTXUUIrb2NSMblUIFug0WJsgOGsjPA3MHd2rKedbhGnAJa2qsd3aOoFjVAVajG7jrvbe1LlxJIF0ZcUEGcP35N/5lXYLZ633Puf9ZAmJg68e9tZKrhdoUwb6RolC+37or3e6xc+oB7foXXDtvKYpy0ag0kXZpcnY9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722351; c=relaxed/simple;
	bh=fE1QIMr4xLLo0ooVVph4bQIR+IZ4RX2RWK3D0lizQ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pD8vueQfELJPuFmuAQ9Bay+FmRWsKXxrNXXBOclBGxIUPnpYNCD7I8qOavimw4FLYBW8nj9YzkfiRPQq6kVL4HYv7chbw/e1Lnq2uzZszKGE1C2WNnHEEA1vr2nBGoRINqiQyAdfIcOhAr00ITz7RiReP5ijJW9gXEr+gJrxJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRcDX6g0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51142b5b76dso4258208e87.2;
        Sun, 11 Feb 2024 23:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722347; x=1708327147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IINiDZNCSW8AHV1xCnQ4FeCJGodkxBYCNnjjjudE6+o=;
        b=eRcDX6g0FlrXkYmTDOywnTWaON1FwLC5/skLiVHNnbJaK8IF4sjSijRpe7D/j8zX8m
         xwWHQy5MHpsTYZDZ2M3FWoq46O4Lyrh5vE+SUlkwUaworsUbkBK+/E9wNB3iDGY2imID
         6miEIcF8s9nWF1cr/d1AfmXl1juRrCs+LwSFroagyvP+rn6BnwSJq3sJ5kzjXcB1d435
         Yh+U+9jATlcTklK51oK+Vt+7JT9N/VRt3ynNC8PJH8ZsyNJX1PdAakT1FIRRyu5vKmhX
         eRHaCrbZqFiq5C+T37SEfiTbNqHGp4rWyXl4CilI5W8DOg78yaE86yh/lMePThKc/FQY
         F1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722347; x=1708327147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IINiDZNCSW8AHV1xCnQ4FeCJGodkxBYCNnjjjudE6+o=;
        b=Mf0sB0jepj207IGC4x3mvK09yuqjArkkRL7L0I14aof9uTkbwiUeBWF0YszV8NRdHM
         NYmh7u8Ny70ikidyW+DkTkn+P1obx7cP8BR3oa2sc2Yc8ewyQc6WqO0PUVr5tOb0JfxA
         jDbZr2D7omRCg0FbjWI72C1PErGeSyaHyMCPDJw0zDqVAT+9TSHT01+B36IzSiKPVoDx
         ySF2cAHKAbK8/u6MS1mlM58YZV9LzMFuhCrXNeftB5b3naHlLfBlcLJ5h1Ie9FeLGGXW
         /uZB5Sy1HfthHBj1I3XNcJCgSsjboWffAyxvEFkHqaFu6DfS6BdMjZESle3U0Qic58N4
         5C6w==
X-Gm-Message-State: AOJu0Yy5fEdEQIff1zB2Ir2jfS2keQzMkUbCwVXZXY4fQsXTykP3vcjg
	0tOSlkBbGBiwmpXvxOxM//eyXcnzRia50TLXg3WYU1wre4XEZGSZ
X-Google-Smtp-Source: AGHT+IH9+GUHfN+fff+O6aLR0fXD25Bd5YJyh4IoX8+huuN0LPbJ/ljXDz5ZjAlG5Ziaz5k2BBHYkQ==
X-Received: by 2002:a05:6512:3994:b0:511:76e6:e0f9 with SMTP id j20-20020a056512399400b0051176e6e0f9mr5153957lfu.20.1707722347041;
        Sun, 11 Feb 2024 23:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuRp2O2MOh98BhhHXxXwj1FSPM6hsjBDpgPPVPAgK41mKhbBzVI7IPSbtf+iRjSYy3esolBekoxkTFf4B10WdAEWPCx4kpt/LLZkPSV3N2KY41DLG5VNSZ5HosmnQMm3w7XLUXWy5p+pHjP3+vqusvpxC9PyIpmAN3aKv+6opW3VN8yGvrZowQJAbpNltSNWdWA1FBTuIC0ZxJfSRi/oVwDmsLpIq+ttTmFBP/fiC+HdWqOT8zVR3B42BQ+I5ClebBhX016j8ZT6w86OMb6Z4fp6qY5+3UMiy+R+UWpzPB/7KUAYR3hd/lHUqOxhJsCmqQ3pCWvyftEg==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00410cfc34260sm2340327wmo.2.2024.02.11.23.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:19:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: tegra: set correct naming for Tegra Note 7
Date: Mon, 12 Feb 2024 09:18:42 +0200
Message-Id: <20240212071843.6679-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212071843.6679-1-clamor95@gmail.com>
References: <20240212071843.6679-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct codename of Tegra Note 7 is "tegratab", while model
name should be "NVIDIA Tegra Note 7". Fix this inconsistency.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/Makefile                            | 4 ++--
 .../{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts}       | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/nvidia/{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts} (98%)

diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
index 7a422f150488..474f3fbbd99d 100644
--- a/arch/arm/boot/dts/nvidia/Makefile
+++ b/arch/arm/boot/dts/nvidia/Makefile
@@ -2,8 +2,8 @@
 dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
 	tegra114-asus-tf701t.dtb \
 	tegra114-dalmore.dtb \
-	tegra114-roth.dtb \
-	tegra114-tn7.dtb
+	tegra114-nvidia-tegratab.dtb \
+	tegra114-roth.dtb
 dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
 	tegra124-apalis-eval.dtb \
 	tegra124-apalis-v1.2-eval.dtb \
diff --git a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts b/arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
similarity index 98%
rename from arch/arm/boot/dts/nvidia/tegra114-tn7.dts
rename to arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
index bfbdb345575a..30b2ed91be23 100644
--- a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
@@ -5,8 +5,9 @@
 #include "tegra114.dtsi"
 
 / {
-	model = "Tegra Note 7";
-	compatible = "nvidia,tn7", "nvidia,tegra114";
+	model = "NVIDIA Tegra Note 7";
+	compatible = "nvidia,tegratab", "nvidia,tegra114";
+	chassis-type = "tablet";
 
 	chosen {
 		/* TN7's bootloader's arguments need to be overridden */
-- 
2.40.1


