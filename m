Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625C768556
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjG3MwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjG3MwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:52:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688719B5;
        Sun, 30 Jul 2023 05:52:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so5823078e87.0;
        Sun, 30 Jul 2023 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690721531; x=1691326331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOmcpofEINHsYWCPF0Dg9enYDMSNdG9NMW4mrLFrvnc=;
        b=CZt3CSjT/WMZW08Ixuna8O0rtLu+1vB/57ycA/xQi6dsKmY6nRw9uH9i30sUZbRylu
         7bp21W5xH7rfHI58+IUP6rN8Pg8Iv5cegEc8PdmEf/HbMYRFYHyn3JDTjnUdiBL7tG4y
         Cn13Lh6cBdwyuQno2pI0CW0fzVoYd2OW33lSnvAAWZLf7GhdXJZOuzDAkd+vxAET4O5t
         KTdqK4e2qhdk/ZZJw6sQzeEDdVC7+3UvO/WLq4nhGD6VeCjpOgaCfYmuB7HQzxUVlIij
         g8CpcBrwTwTtgaD+rDZokHxMVzlsJKdDjBgmY+eV5SX/nEWvIDxS7vl6mEg6SNfYibmH
         LG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690721531; x=1691326331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOmcpofEINHsYWCPF0Dg9enYDMSNdG9NMW4mrLFrvnc=;
        b=aUc3/I5RuVFKtbVlE72EfkInSmZ4aGPYV/F477FdElI4SVK54gmL6atEViNjwtxU9z
         h134EZ3Ir8HRS8PHusGCJkexy8zOKeRLSo12S1eKhuoxZvu2v26lJGgyGgM+NsyjYRnL
         vLVw0c6DRHs4Lth4FjWy5NMkNownX8GdZLqXSQN9lbodTdxKTuYDsrjI3KNADtx3F2zl
         vh1PCZkyaPbp6onOq0I7DO+aTKfm5Xe91zgzung7rK1oNNgV/UJtCj+TELj1eWMZY9Uk
         cblnaV6UsY9BWBy9KRC0yFXSwUFgGLz1zAsujHORNwSzlB9bkIFtF+gasRanGb1ADmMY
         8fmg==
X-Gm-Message-State: ABy/qLbrmzZdpMHDRuexegmm9ay0ddQIS8iyEUt96fIIs1Sn3rrH1Jt4
        d2LgBIbKfvCXb0ZkrztueXE=
X-Google-Smtp-Source: APBJJlHK/53dC5Rp9AYZR8qMI10kmjvqs7ozhRvjsBfYSFMbKuB4tn4kVQ00I510+3eBWC3GHgdvCQ==
X-Received: by 2002:a05:6512:1147:b0:4fe:1e74:3f3e with SMTP id m7-20020a056512114700b004fe1e743f3emr3702991lfg.48.1690721531032;
        Sun, 30 Jul 2023 05:52:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e6-20020ac25466000000b004fe1f37035csm1227273lfn.224.2023.07.30.05.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 05:52:10 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: tegra: transformer: use labels for mmc in aliases
Date:   Sun, 30 Jul 2023 15:51:50 +0300
Message-Id: <20230730125150.4716-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730125150.4716-1-clamor95@gmail.com>
References: <20230730125150.4716-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use phandle references for mmc instead of path in aliases.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra114-asus-tf701t.dts           | 12 ++++++------
 .../boot/dts/tegra30-asus-transformer-common.dtsi    | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
index 84a3eb38e71d..3a420ac969ff 100644
--- a/arch/arm/boot/dts/tegra114-asus-tf701t.dts
+++ b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
@@ -13,9 +13,9 @@ / {
 	chassis-type = "convertible";
 
 	aliases {
-		mmc0 = "/mmc@78000600"; /* eMMC */
-		mmc1 = "/mmc@78000400"; /* uSD slot */
-		mmc2 = "/mmc@78000000"; /* WiFi */
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+		mmc2 = &sdmmc1; /* WiFi */
 
 		rtc0 = &palmas;
 		rtc1 = "/rtc@7000e000";
@@ -605,12 +605,12 @@ i2s@70080300 {
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		/* WiFi */
 	};
 
 	/* MicroSD card */
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 
 		bus-width = <4>;
@@ -626,7 +626,7 @@ mmc@78000400 {
 		pinctrl-0 = <&sdmmc3_default>;
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		/* eMMC */
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index bdb898ad6262..b0ca56e611e8 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -12,9 +12,9 @@ / {
 	chassis-type = "convertible";
 
 	aliases {
-		mmc0 = "/mmc@78000600"; /* eMMC */
-		mmc1 = "/mmc@78000000"; /* uSD slot */
-		mmc2 = "/mmc@78000400"; /* WiFi */
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+		mmc2 = &sdmmc3; /* WiFi */
 
 		rtc0 = &pmic;
 		rtc1 = "/rtc@7000e000";
@@ -1388,7 +1388,7 @@ i2s@70080600 {		/* i2s3 */
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 
 		/* FIXME: Full 208Mhz clock rate doesn't work reliably */
@@ -1401,7 +1401,7 @@ mmc@78000000 {
 		vqmmc-supply = <&vddio_usd>;	/* ldo3 */
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 
 		#address-cells = <1>;
@@ -1431,7 +1431,7 @@ wifi@1 {
 		};
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		vmmc-supply = <&vcore_emmc>;
-- 
2.39.2

