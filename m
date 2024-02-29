Return-Path: <linux-kernel+bounces-87237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BD86D181
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F8E1C22731
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A60134434;
	Thu, 29 Feb 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO/Ks9Xc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0917D3F2;
	Thu, 29 Feb 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230110; cv=none; b=lTvPwdoR3RbD2F9Pz/R2mhi0R0WbIymugm8YVe0gFfxdEXsqdvP1mfByELdaXYZZsVqBOWvaI7oSc0lur9jmpCxDUSB3cwqhrv8T8yWFH4NUTgMJUcBNH6ZbUl2+d8dTxGeSP/m4IVvZ9Ti9c+0bbqSU0ohqtclgbtVcWbTv6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230110; c=relaxed/simple;
	bh=4qATgv2NIkBbPJ4MXwBLLL2AM9zlNCrH2AkubYOzo2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yh9dy62Ly4vfIhzOJ9cUfFP7nexMPsvMav7NMagjQQTCQldWI/eX1vbBZo5yTZnEXxnfZCpPIIyb1G3Wn+/pMlk24QQrUme3S0e0lLAUCW3HpP6m1T/liH/3tM/fllvff3c5JlH5V/xpVQcfF1nCbfnVACGQC7uK9PsR3DevWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO/Ks9Xc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412bcb76703so7088605e9.2;
        Thu, 29 Feb 2024 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230107; x=1709834907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ1CttY3QePOBroynm6EQeC99boR7JdlBwjlYres+fA=;
        b=kO/Ks9XcBNsUGoJv51QX4IFV59AeoFSAb2VtsmFvW0JwjphBJl+Ux0r6YVOw3OVqlG
         uj6DePXtj09clEU7jlYWY51fKUIFjVKWWxhmMX7UzSiyGevtq2lKY6ueJVVsQhMkEg7u
         ohSAqaPuPrSTadS++Qlx9RhyH44vE7XHFkptB8Bcf6rUtqsOQ5GewoxqyJHFm/vxNj62
         NLNA0iqEcnM2Si2c+lbcgQBrwcHt0LAW4Mke/oGRkwgA6+jnPBIOmqCc3Zp9RoZGDakq
         Nr3f548aovElkfWbNoxCRYAuHW/MVN23fELISau43v7zKg6GGzHGm3swYd9UaVa1ldk+
         PxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230107; x=1709834907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ1CttY3QePOBroynm6EQeC99boR7JdlBwjlYres+fA=;
        b=hG95hUoXi2wSre810hbkRjtMQIpsfRy7lcn/5Cd72CRelT6G91eXsxJuYzaS4ZDQ1D
         Oj9VoruCBZuEaiKVntMJ0odyiQYoEFjNQPavvlTRGyrUm6GkWcFh/fjg+vQuBI3shWTU
         VrG5KfTAQwworQ6GJAYaxCGNbt+KxNRqtTi1IFskArJU0sAR0rFapx6wx38/Z/ydP3Mi
         tX1q205OzbFrIfotYVbBZ/nhxeT09d5THZz5Rl4Jewg5w45MehpYA0sMzYreG+YcJUbL
         UN97ca3+SaSgYaw5pSCPbQYPGaPPlVQ19HvajDy/fIRG8TtNxq7ABf9/iF4cejLGY1C5
         uh4A==
X-Forwarded-Encrypted: i=1; AJvYcCW+X8Hp90tpp/euHxaWrhIwBROdEvGthVubI7W6tKil/NgykvYBMIkmHzJd77ldJC/OJ8e1ZXSH3W5qrThv5vJiwyig7muKC52qsUOfV4m68hkm7aOn2/884H5cC2kldPLH5atYb+DQ
X-Gm-Message-State: AOJu0YwbT9oUk5joRRh9k0zuBqk/dfWccQsj9AWhiapLeQdBxGSh+NJU
	yZlJ0GaEfb36J0b36Kh5lax2y7OFzKenRsRRO+9tSbBJInNKKyGy
X-Google-Smtp-Source: AGHT+IFx8WHJYEtjEx85k/mCC4sEK18kSet4ygICvSqzOaSFu6VLczg+zdsVwoiA/Df4hawc6NCUFQ==
X-Received: by 2002:a05:600c:4f86:b0:412:bafe:613f with SMTP id n6-20020a05600c4f8600b00412bafe613fmr2586709wmq.22.1709230107391;
        Thu, 29 Feb 2024 10:08:27 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:27 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:50 +0100
Subject: [PATCH 5/7] clk: qcom: camcc-sc8280xp: fix terminating of
 frequency table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-5-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: ff93872a9c61 ("clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/camcc-sc8280xp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
index 3dcd79b015151..7f0ae9a5f28b2 100644
--- a/drivers/clk/qcom/camcc-sc8280xp.c
+++ b/drivers/clk/qcom/camcc-sc8280xp.c
@@ -630,6 +630,7 @@ static const struct freq_tbl ftbl_camcc_bps_clk_src[] = {
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
 	F(760000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_bps_clk_src = {
@@ -654,6 +655,7 @@ static const struct freq_tbl ftbl_camcc_camnoc_axi_clk_src[] = {
 	F(320000000, P_CAMCC_PLL7_OUT_ODD, 1, 0, 0),
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_camnoc_axi_clk_src = {
@@ -673,6 +675,7 @@ static struct clk_rcg2 camcc_camnoc_axi_clk_src = {
 static const struct freq_tbl ftbl_camcc_cci_0_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(37500000, P_CAMCC_PLL0_OUT_EVEN, 16, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_cci_0_clk_src = {
@@ -735,6 +738,7 @@ static const struct freq_tbl ftbl_camcc_cphy_rx_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(240000000, P_CAMCC_PLL0_OUT_EVEN, 2.5, 0, 0),
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_cphy_rx_clk_src = {
@@ -754,6 +758,7 @@ static struct clk_rcg2 camcc_cphy_rx_clk_src = {
 static const struct freq_tbl ftbl_camcc_csi0phytimer_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_csi0phytimer_clk_src = {
@@ -818,6 +823,7 @@ static const struct freq_tbl ftbl_camcc_fast_ahb_clk_src[] = {
 	F(200000000, P_CAMCC_PLL0_OUT_EVEN, 3, 0, 0),
 	F(300000000, P_CAMCC_PLL0_OUT_MAIN, 4, 0, 0),
 	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_fast_ahb_clk_src = {
@@ -838,6 +844,7 @@ static const struct freq_tbl ftbl_camcc_icp_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_icp_clk_src = {
@@ -860,6 +867,7 @@ static const struct freq_tbl ftbl_camcc_ife_0_clk_src[] = {
 	F(558000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
 	F(637000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
 	F(760000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_0_clk_src = {
@@ -883,6 +891,7 @@ static const struct freq_tbl ftbl_camcc_ife_0_csid_clk_src[] = {
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_0_csid_clk_src = {
@@ -905,6 +914,7 @@ static const struct freq_tbl ftbl_camcc_ife_1_clk_src[] = {
 	F(558000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
 	F(637000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
 	F(760000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_1_clk_src = {
@@ -941,6 +951,7 @@ static const struct freq_tbl ftbl_camcc_ife_2_clk_src[] = {
 	F(558000000, P_CAMCC_PLL5_OUT_EVEN, 1, 0, 0),
 	F(637000000, P_CAMCC_PLL5_OUT_EVEN, 1, 0, 0),
 	F(760000000, P_CAMCC_PLL5_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_2_clk_src = {
@@ -962,6 +973,7 @@ static const struct freq_tbl ftbl_camcc_ife_2_csid_clk_src[] = {
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_2_csid_clk_src = {
@@ -984,6 +996,7 @@ static const struct freq_tbl ftbl_camcc_ife_3_clk_src[] = {
 	F(558000000, P_CAMCC_PLL6_OUT_EVEN, 1, 0, 0),
 	F(637000000, P_CAMCC_PLL6_OUT_EVEN, 1, 0, 0),
 	F(760000000, P_CAMCC_PLL6_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_3_clk_src = {
@@ -1020,6 +1033,7 @@ static const struct freq_tbl ftbl_camcc_ife_lite_0_clk_src[] = {
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ife_lite_0_clk_src = {
@@ -1140,6 +1154,7 @@ static const struct freq_tbl ftbl_camcc_ipe_0_clk_src[] = {
 	F(475000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
 	F(520000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_ipe_0_clk_src = {
@@ -1163,6 +1178,7 @@ static const struct freq_tbl ftbl_camcc_jpeg_clk_src[] = {
 	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
 	F(480000000, P_CAMCC_PLL7_OUT_EVEN, 1, 0, 0),
 	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_jpeg_clk_src = {
@@ -1184,6 +1200,7 @@ static const struct freq_tbl ftbl_camcc_lrme_clk_src[] = {
 	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
 	F(320000000, P_CAMCC_PLL7_OUT_ODD, 1, 0, 0),
 	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_lrme_clk_src = {
@@ -1204,6 +1221,7 @@ static const struct freq_tbl ftbl_camcc_mclk0_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(24000000, P_CAMCC_PLL2_OUT_EARLY, 10, 1, 4),
 	F(64000000, P_CAMCC_PLL2_OUT_EARLY, 15, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_mclk0_clk_src = {
@@ -1320,6 +1338,7 @@ static struct clk_rcg2 camcc_mclk7_clk_src = {
 
 static const struct freq_tbl ftbl_camcc_sleep_clk_src[] = {
 	F(32000, P_SLEEP_CLK, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_sleep_clk_src = {
@@ -1339,6 +1358,7 @@ static struct clk_rcg2 camcc_sleep_clk_src = {
 static const struct freq_tbl ftbl_camcc_slow_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(80000000, P_CAMCC_PLL7_OUT_EVEN, 6, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_slow_ahb_clk_src = {
@@ -1357,6 +1377,7 @@ static struct clk_rcg2 camcc_slow_ahb_clk_src = {
 
 static const struct freq_tbl ftbl_camcc_xo_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 camcc_xo_clk_src = {

-- 
2.44.0


