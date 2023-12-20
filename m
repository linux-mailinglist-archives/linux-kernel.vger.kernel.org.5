Return-Path: <linux-kernel+bounces-7503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161D81A8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD7A28D39C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F594B5B2;
	Wed, 20 Dec 2023 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngynl445"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B54AF79;
	Wed, 20 Dec 2023 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so1973885e9.3;
        Wed, 20 Dec 2023 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110670; x=1703715470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoL1IP5/8m1OxKspN+bDc7OtzceuHolddBcPNgOTtWM=;
        b=ngynl4457z19gpXxH76QYfWp9U1eNp+i5c3vX/mO/AiDkpnnhUf7GnUS9GNoc1UBne
         e4brjdNqrkSshEVyLKnk4f4JgcpyicIkNIRY2UlYYk0UEXpzaO1AeoxikRugYXctXeVY
         ZGp+l0ItI9Nr0aCzYE1VfpFwSThzvJjy2yT+3CDXTV2mguETQOOx8ogy2tE3/GiM7Exu
         xcydqN8Cmti6P6wPywiRJ/FSOYGMAKOqWwVXJmi7oyubp12tl8w52HPhgJo+SzhjYj/t
         AAsr7UIsrVXVo2jt1AsuPsVpxqC5Pp3kHGWvACbapsFHQetWTHR1wZQeM1fvTZVLiVb7
         +kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110670; x=1703715470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoL1IP5/8m1OxKspN+bDc7OtzceuHolddBcPNgOTtWM=;
        b=nAuhK/HEeOdD0kZgdGLGqh1Elkm0IwTkh+Cu8c8eBOR1yH8vi+eeH4dk0Tx74W8yCl
         7KfMZXM2j4DSkoBqNLcsaR0KmJZU6Ht2dnmZ2AP65E14q3SIqGBMYXK7Yfh1jlROsH9q
         mTSmrIJdT7IQEwf7wXH8ED0BiJ7DBIJakD6qRdnVXSelvdmxX/nyLcKdB1KQdzVd10oh
         6M34yqh70WM/r+kI2oFOWDAlI5VJ18oon9t+lZU0ZKh+v6rhPEY8HeVbhF7tYF1YEWJS
         1h0h2fJWU7KYZ5W4c5qkj3jXxu64YE3Yss/3tuCztJr4qpNi4VKyYH1i5bMVuL3ocHz4
         V3hg==
X-Gm-Message-State: AOJu0YxClUp7sbtx/peSlnB9TYMVUlDdXLaDXU6Q8JTQFGO8b802gD0a
	qNQkGuJ8z6R0zz5mqZ5Z37w=
X-Google-Smtp-Source: AGHT+IEq1deFeW2q5omLXJ7iHkcy7EdrmQdxJrPfD+COl2+qqgXRIiNqr7cmJLIXq44UGlyvimEedg==
X-Received: by 2002:a05:600c:19d3:b0:40b:5e1e:fb94 with SMTP id u19-20020a05600c19d300b0040b5e1efb94mr128343wmq.73.1703110669756;
        Wed, 20 Dec 2023 14:17:49 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8908826wmn.14.2023.12.20.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:17:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v8 3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date: Wed, 20 Dec 2023 23:17:24 +0100
Message-Id: <20231220221724.3822-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220221724.3822-1-ansuelsmth@gmail.com>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework nss_port5/6 to use the new multiple configuration implementation
and correctly fix the clocks for these port under some corner case.

This is particularly relevant for device that have 2.5G or 10G port
connected to port5 or port 6 on ipq8074. As the parent are shared
across multiple port it may be required to select the correct
configuration to accomplish the desired clock. Without this patch such
port doesn't work in some specific ethernet speed as the clock will be
set to the wrong frequency as we just select the first configuration for
the related frequency instead of selecting the best one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index b7faf12a511a..6f9ca10c29c5 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1675,15 +1675,23 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_RX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_RX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_RX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_25[] = {
+	C(P_UNIPHY1_RX, 12.5, 0, 0),
+	C(P_UNIPHY0_RX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_125[] = {
+	C(P_UNIPHY1_RX, 2.5, 0, 0),
+	C(P_UNIPHY0_RX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1710,14 +1718,14 @@ gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_rx_clk_src = {
 	.cmd_rcgr = 0x68060,
-	.freq_tbl = ftbl_nss_port5_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_rx_clk_src",
 		.parent_data = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1737,15 +1745,23 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_TX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_TX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_TX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_25[] = {
+	C(P_UNIPHY1_TX, 12.5, 0, 0),
+	C(P_UNIPHY0_TX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_125[] = {
+	C(P_UNIPHY1_TX, 2.5, 0, 0),
+	C(P_UNIPHY0_TX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_TX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_TX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_TX, 1, 0, 0),
 	{ }
 };
 
@@ -1772,14 +1788,14 @@ gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_tx_clk_src = {
 	.cmd_rcgr = 0x68068,
-	.freq_tbl = ftbl_nss_port5_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_tx_clk_src",
 		.parent_data = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1799,15 +1815,23 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_25[] = {
+	C(P_UNIPHY2_RX, 5, 0, 0),
+	C(P_UNIPHY2_RX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_125[] = {
+	C(P_UNIPHY2_RX, 1, 0, 0),
+	C(P_UNIPHY2_RX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY2_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1829,14 +1853,14 @@ static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_rx_clk_src = {
 	.cmd_rcgr = 0x68070,
-	.freq_tbl = ftbl_nss_port6_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_rx_clk_src",
 		.parent_data = gcc_xo_uniphy2_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1856,15 +1880,23 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_25[] = {
+	C(P_UNIPHY2_TX, 5, 0, 0),
+	C(P_UNIPHY2_TX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_125[] = {
+	C(P_UNIPHY2_TX, 1, 0, 0),
+	C(P_UNIPHY2_TX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1886,14 +1918,14 @@ static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_tx_clk_src = {
 	.cmd_rcgr = 0x68078,
-	.freq_tbl = ftbl_nss_port6_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_tx_clk_src",
 		.parent_data = gcc_xo_uniphy2_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
-- 
2.40.1


