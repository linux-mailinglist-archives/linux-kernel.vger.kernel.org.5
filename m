Return-Path: <linux-kernel+bounces-14044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC5821751
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC74F1C21265
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAE14F67;
	Tue,  2 Jan 2024 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sihXvgsw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997810957
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so5626006e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172658; x=1704777458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNBnE1TIVjn0hN8hBoAZ+Kp3NltRt05a2JY4lZGjMBM=;
        b=sihXvgswTfIQMyWPSeB//aJ+6Y1ZCY+NZP28+iBxIJ++u3BNhESIO36Odu4hrw7ji0
         CtRZrizeZAxrTVMxQsoDXaRsS6ZkxKvf31513EVqjgMg20rdMRRl8cZBDs/4U0uLC78q
         hGw3AuQYCrR9tz739+P8cyQVqfoe9MXhzOGB4eIOs/A9wiU+0sK+D0CZCTtCPwwm90O8
         4B9uBhI8zaXfUNQN9WVB30M3S2uLobSy4GgfaTuT3+URzH0vReKbDEmj8Cf0hPzYBLTC
         NlhS+0xG97fA2HtPUxC/L9sHCMUvlAKN7UmHuYCDXrt49dst9g9K9x0pMV1Zlu7AANqy
         jwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172658; x=1704777458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNBnE1TIVjn0hN8hBoAZ+Kp3NltRt05a2JY4lZGjMBM=;
        b=nzBSKRRjgpeeEOUvSU7pg43PMh1lhKhx7TYMmCxHqvhHwXP5foguPGtYofFOl0BSmh
         LlEXlnLafCQesno5cpgcFDkuDROPi+ZSNPqhQVP+Fz3YdCXtncKDBb5gfpc4xKQ40ccV
         rzGuC1KKgn1hvMRGo01Hk6OTVJM3bjBgHW/yB+ujKORy0FQHEqfQAtdbSsj28yuwyErD
         U7WJoFYYdWbRU8AzSa1KtjECY4PuHBok6A6zQnulYaqrK9Cf9Nqz9Lv86hQewsj3QYSG
         MiKSoJUsHVCF0RuXjdtgvMLseAb15MjsKhFlnaWgaRI5j+0QnBA+axYVjvA/5cr7E/lc
         vaIA==
X-Gm-Message-State: AOJu0YzLU6cbp/s4rnHHQXfbQjCD5NImiN6wjg3PnM8P8e+Tb1AqX+yE
	5Xl8FkRmFqghKzoVs21lTgHWYG0pqceufQ==
X-Google-Smtp-Source: AGHT+IFrLGqUci85AMuFYh4dcddPv+UxhiXAbhz/MxMdqZrAhWpAXvU1cwnur7jDCnsD1r564hpD6Q==
X-Received: by 2002:ac2:4152:0:b0:50e:61a9:87e0 with SMTP id c18-20020ac24152000000b0050e61a987e0mr7999565lfi.2.1704172658768;
        Mon, 01 Jan 2024 21:17:38 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:37 +0200
Subject: [PATCH v7 17/22] ARM: dts: qcom: apq8064: declare SAW2 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-17-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HGYqjIJyAD2GI/gXSq7W4K6RgkmqlA4A/at5d+w6bVs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xlXn3k4uN5ZQvh0l66H+bmn4ilr4RrDKOz4
 AyYZ1y77reJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZQAKCRCLPIo+Aiko
 1VAuB/0VEiepNlkGn/4TrJBSQmLhw8eSqmdu8d1tuWQ9s8d/IOP/DyFfaeEaKSfE0QE4M5reTF2
 /8BT2UygBIRTKzBzQ+9AWaRzIA697H8grZ1tPDBeof3wuwj2DH+kzYUmaTwaET09XunitZz++Ws
 Xn477PbbjoxeasqJKZdcAgfJKN5kwQ6uLWTNKa/VPWzaPj0b1sq7BvzBpPLTre8nnbK4QQ6xq1m
 fdyfgvpG0UL4aNw4mI/WEK4H2ja0qo0JLfEau/blDsheQzu9tWkgthobcsUtiF+cx4BBuGuyVZC
 TNp7FWzSRAoPMVVi+J8MmbZjtQWJs8GW/mKXHx4n8D1sBGyM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SAW2 (SPM and AVS Wrapper) among other things is yet another way to
handle CPU-related PMIC regulators. Provide a way to control voltage of
these regulators.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 3066ee49daa7..d1cbd2248558 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -368,25 +368,41 @@ acc3: clock-controller@20b8000 {
 		saw0: power-manager@2089000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw0_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw1: power-manager@2099000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw1_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw2: power-manager@20a9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw2_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		saw3: power-manager@20b9000 {
 			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
-			regulator;
+
+			saw3_vreg: regulator {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+			};
 		};
 
 		sps_sic_non_secure: sps-sic-non-secure@12100000 {

-- 
2.39.2


