Return-Path: <linux-kernel+bounces-8182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104EF81B33F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328AB1C24567
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8FE5103A;
	Thu, 21 Dec 2023 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm2gBf7k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24B4F60D;
	Thu, 21 Dec 2023 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26964245baso47982066b.3;
        Thu, 21 Dec 2023 02:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703153458; x=1703758258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFf3Xy2cMnTXIbMlXJLnwk2HDFYZqTaJR84g5dBGsLI=;
        b=Pm2gBf7kk0BAb+eG0QaMJQo0fLP5GRI2DHVQBayvurjdC80ybJMvMngQhaPTYUY4zC
         9IhJze+Zxb0HcgLuOMAuLhaaNpCZoY09dRacWS6g6DbvBX+PXQOIXStySTaNldOUKpoa
         HYQCm0XuDxpPoOMorKUnBHjCxTPdSMgXU0Gf9uL9mpRzd8XtlLZrAdl9pzge6Le89jBP
         MIOanfvqzc1PUy+8HJPRKr7+lGC667crHGATBkwCopjP2sHbVIJTBfavHz3FzRF47jTj
         mMK/ziTNjYrdlx0nYtqDWO+rrhSNoPxJcjN8o/j9Fpfz0OH3IzWmS5GpytpG1llH4e6R
         hPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153458; x=1703758258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFf3Xy2cMnTXIbMlXJLnwk2HDFYZqTaJR84g5dBGsLI=;
        b=sZiosoJ6VwvD2CqqZtl6pibeVRW3acxUIBWDiB9TFsxI8b+J85rMgBFOooz4SWWn72
         q2OwwJhifRKCyr6maHkxcW1esICpXCmV1mCCvTXKkhQoJpQdObFUeTinLSV3QqGgwObN
         Imc/0Tiri+JCp8NfKoBlHpWJ+CvoSirO7FQKtidBTGtwrpN0f/zZF7H3QPxh3xq/y2ea
         /HV9QZ2eNHqaoJr0Sa9l0ksXrReMZ1c+kBwRhojouEn5QlekHUtuMzsVM+g7f2ABTdei
         fG4KdavIZrW7XvzZ5lJoplqFbw2JNAICjeBZHd4zTkY5RigQA71Riqyk0Oo9XSAZ1p9n
         vB4A==
X-Gm-Message-State: AOJu0Yxx9pPs5xgQ3522ibMxhtGLLVMbEB0nfB2Wk5jJcIGnZSNXMjmq
	5CkyKm0rQVbv8PBeEzcuFtM=
X-Google-Smtp-Source: AGHT+IHdyV4OQDmEi6Na15vJj61uqzNpkif4Hepo9TNBl7sFfbA0b7Ola/s2/GZQujvgdIcyNME+FA==
X-Received: by 2002:a17:906:159:b0:a22:eae6:1657 with SMTP id 25-20020a170906015900b00a22eae61657mr8537126ejh.33.1703153458485;
        Thu, 21 Dec 2023 02:10:58 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.204])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906b08700b00a25f5dba09dsm784928ejy.145.2023.12.21.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:10:57 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v2 3/3] riscv: dts: allwinner: Fill in OPPs
Date: Thu, 21 Dec 2023 11:10:13 +0100
Message-Id: <20231221101013.67204-4-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221101013.67204-1-fusibrandon13@gmail.com>
References: <20231221101013.67204-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify two voltage ranges, in order of increasing stability,
for each OPP.

Link: https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L133
Link: https://github.com/mangopi-sbc/tina-linux-5.4/blob/0d4903ebd9d2194ad914686d5b0fc1ddacf11a9d/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L182

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6c..7e2e015e0 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -39,16 +39,23 @@ cpu0_intc: interrupt-controller {
 	};
 
 	opp_table_cpu: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "allwinner,sun20i-d1-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		nvmem-cell-names = "speed";
+		opp-shared;
 
 		opp-408000000 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <950000 950000 1100000>;
+			opp-microvolt-speed1 = <900000 900000 1100000>;
 		};
 
 		opp-1080000000 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed1 = <950000 950000 1100000>;
 		};
 	};
 
@@ -115,3 +122,9 @@ pmu {
 			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
 	};
 };
+
+&sid {
+	cpu_speed_grade: cpu-speed-grade@0 {
+		reg = <0x00 0x2>;
+	};
+};
-- 
2.30.2


