Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B97F7786
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbjKXPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjKXPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:18:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB41723;
        Fri, 24 Nov 2023 07:19:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4079ed65582so13676505e9.1;
        Fri, 24 Nov 2023 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839140; x=1701443940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0/dU+s24A21H8KB1oHsdy9DBO1Q1Csxfdq88eybO/s=;
        b=bWC1zE/3YuRVIpqeRoLz3sIoU0gkXLSPZt5/QZ6Rp5KDSXghKb8H03iEDiaBK5CG+0
         ioxdjcSjOe61SKBKRklugQFCSCbsZIOSygw1TVfJlKNJu3vFO1U4/CoZTo/8dV/Y32Xb
         LVvdhAibulc7uORNB5qO0DYjjzjZigUYS/F5FOXeVuX5iyOyvWWb+cYQt628S3kVxW+n
         YeC9Uqpg4hO5CSwPVbsJ5wpVYp3UofuaMLJ6c2VI2KIGL1R0S+1TvoocJ9E9k/4CXJGC
         gkojoUlAvNmcB1ZIsm55vycpz5J728voIrm6JIltLFMFyO3fLH7GWkQtQm8GAJcnc8KW
         dHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839140; x=1701443940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0/dU+s24A21H8KB1oHsdy9DBO1Q1Csxfdq88eybO/s=;
        b=cw+bV8I75Wa9nEs+J+zLY9FXta5Vy6wh5BWY6LAJGXVOEDFLXA4KDortIkA/jUA78/
         LV40xAxZomMi7QwhgMa1WoKmjJUrIEQYdqa5xRe48DUDVogM/Mj/WcTxbjXzH4xLuPad
         0JYA67PzE8qrP9IQSrNeW4dwQNW5nhhmQ25WTidIDebNb30+SL24+ss5OIe+8leK6/jw
         FL12mgyttmj+rW5lZkzRDx/WnP9eVTOMRM44kUtDAf6JiO8u89767oWlFt+Gyjs5SdrH
         EfQe3QOiDJ7X5C9Z/xNlDe7N230gCbCHIKa5vl1wFNDbWUksOlCieGo7CnP/1Afsb15G
         3nAA==
X-Gm-Message-State: AOJu0YwTiqgHarYdsOuxv+tH8OfU4iaq8y92gBYsckFZZugxHOoTQa+v
        ID0ltiXjNH8gkB4PdkD2ftk=
X-Google-Smtp-Source: AGHT+IEE5YKz/4ooMFfdZ+RwQzm3azmhoIA7WYOU9MXK+PiJoogDpOwVolUwITxe91fc/pyNQB6Luw==
X-Received: by 2002:a05:600c:4507:b0:40b:338b:5f10 with SMTP id t7-20020a05600c450700b0040b338b5f10mr2815122wmo.32.1700839140192;
        Fri, 24 Nov 2023 07:19:00 -0800 (PST)
Received: from localhost.localdomain ([78.209.42.235])
        by smtp.googlemail.com with ESMTPSA id x12-20020adff64c000000b0032dcb08bf94sm4513699wrp.60.2023.11.24.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:18:59 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v7 3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Fri, 24 Nov 2023 16:18:47 +0100
Message-Id: <20231124151847.1915-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124151847.1915-1-ansuelsmth@gmail.com>
References: <20231124151847.1915-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 63ac2ced76bb..595cb7bd4834 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1681,15 +1681,23 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
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
 
@@ -1716,14 +1724,14 @@ gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map[] = {
 
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
 
@@ -1743,15 +1751,23 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
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
 
@@ -1778,14 +1794,14 @@ gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map[] = {
 
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
 
@@ -1805,15 +1821,23 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
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
 
@@ -1835,14 +1859,14 @@ static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
 
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
 
@@ -1862,15 +1886,23 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
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
 
@@ -1892,14 +1924,14 @@ static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
 
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

