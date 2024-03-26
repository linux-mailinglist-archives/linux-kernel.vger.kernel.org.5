Return-Path: <linux-kernel+bounces-119592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93088CAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C47325C22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157141D555;
	Tue, 26 Mar 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uq9MAU3n"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6952F8A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474105; cv=none; b=i8c2KcXE9fi0rxQcGidKGBgFQNz/6x/6ETf6OXi+pxzqfbPBDwbGCIcNHc0G3eG0IRIVj8/nq9wt5G45smo9UDHPYNEC2+xOlk/S6qIMYMPyyy9KCLzRGhMoUXFqIpvil7IdXmqqFafuq862KTRU8o4XA5yXLn6snTwzVPqsd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474105; c=relaxed/simple;
	bh=nARcfiZlUnvY1ZPvneLyuDt7eO8S8uFLarD8KzDMlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql1/WEwxgWqV3SJtL7CVc1kCMwKBrdC7WztIbedc7GgoPjOjyaMTxhBPDo6CNm8cvd2qusfZrThaRvv2s7McCffU0pM3RqDgN/C3DQliZqTXGcEhe4lDI1qsRnHML7x6L3jHCuoTmQjRtu1tFXU9UksBSQ9mbDktFCpjbZFAjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uq9MAU3n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41490e42c74so189145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474101; x=1712078901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlu5tlZv1NnWrU7oZEVBCA7Z9WWnYwfmx3GleUt60b0=;
        b=Uq9MAU3neRtrkZlWv/E6cyMhWj13wT5TVWbkqskrevFXpc1/Hl4MwYmMnFi05oKt+/
         TyhM/0mtIYzsZtMDE2Z9WJvjBKDBPsJCrcmt8S8jcfWVwsCu4REzzfXwzPuefU+ntLFR
         3Kbh9M9M90ptQf0OIf6l7J9mCapYyckmFZZ+8BcBKh6KwoFI3apYztPeLchtq/owMKF9
         DoXmmLPTEojbFauVhZDUaOMzaghYh20PfIAUhg6fF1blQ4UUhIzx0mXk/Vc8/Cr8Fn1f
         z3zB4YaDTevlpCmdASlQ1Dv37AZkJ7bXXE9701VXIFEW1wY6nXuRMDTqIM30NoJt5FDV
         QRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474101; x=1712078901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlu5tlZv1NnWrU7oZEVBCA7Z9WWnYwfmx3GleUt60b0=;
        b=GFvPxQMq67a8ixg8wdoW8AaGgMQ60a1hjKbPrRgc7aTnFI8t5WO+KUQT4OsAy9Afmy
         u6PEf8v77nchG6fuw7p+jTyAY/5UE6pXWmIvE3/sl9TPpOKHhDXsFmFAtXLa+KbVqDft
         sSk3ZX2pptIG/FWCW3d2VyoKkUe5JjXG3hlufOkcRjIBe5CQ7kg4PMN/QIG1kqWQ996I
         ctgMp9npQWjApKlwBjwBRjXpAJOKXynLjms5T4KYeeyehnC3yPORmvxQ6NVzE3FRsvT6
         lX8ML+OAMuDmmsK7H3Wq9gNehZLz87mWL6LF347MmeFRYp2sxl4X9wR9Wal8sBwOT3ib
         NLOg==
X-Forwarded-Encrypted: i=1; AJvYcCWRe/jmblrzHxnoeR+2iNe2HZvZV1I87m2FYhJNarLXBVE5KhMyXG4TbUZkhTPqiKtyINnjNV63rlNQdJJP61ukKvnr95GRzGXBPlUj
X-Gm-Message-State: AOJu0YwGmbzTjqGyogWXWUM8q+DSOpeEdN/mcyf5VmEyj38Q923YVRSp
	4pfKxUsSKVhg3WiAlQOAMc2beZd+c+2tMIO2DAymvMNBT8DO/mK3M7rMl4wTHxk=
X-Google-Smtp-Source: AGHT+IFi5Dw6hdyWEskOQrVrXf/NiF6eOfNTaMS4wL9ltspnASJETatFdxOoM6l4BQULqxdS6t0R8A==
X-Received: by 2002:a05:600c:4708:b0:414:5e9d:ad31 with SMTP id v8-20020a05600c470800b004145e9dad31mr2001569wmo.13.1711474101017;
        Tue, 26 Mar 2024 10:28:21 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b004148f9c5822sm2063281wmb.22.2024.03.26.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:28:20 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	semen.protsenko@linaro.org,
	linux-clk@vger.kernel.org,
	jaewon02.kim@samsung.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 2/3] clk: samsung: gs101: propagate PERIC1 USI SPI clock rate
Date: Tue, 26 Mar 2024 17:28:12 +0000
Message-ID: <20240326172813.801470-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240326172813.801470-1-tudor.ambarus@linaro.org>
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SPI transfer is being prepared, the spi-s3c64xx driver will call
clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
is a gate (leaf) clock, so it must propagate the rate change up the
clock tree, so that corresponding MUX/DIV clocks can actually change
their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
all USI instances in GS101 PERIC1: USI{0, 9, 10, 11, 12, 13}. This change
involves the following clocks:

PERIC1 USI*:

    Clock                              Div range    MUX Selection
    -------------------------------------------------------------------
    gout_peric1_peric1_top0_ipclk_*    -            -
    dout_peric1_usi*_usi               /1..16       -
    mout_peric1_usi*_usi_user          -            {24.5 MHz, 400 MHz}

With input clock of 400 MHz this scheme provides the following IPCLK
rate range, for each USI block:

    PERIC1 USI*:       1.5 MHz ... 400 MHz

Accounting for internal /4 divider in SPI blocks, and because the max
SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:

    PERIC1 USI_SPI*:   384 KHz ... 49.9 MHz

Which shall be fine for the applications of the SPI bus.

Note that with this we allow the reparenting of the MUX_USIx clocks to
OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
reparenting of a MUX_USI clock corresponds to a single instance of the
USI IP. The datasheet mentions OSCCLK just in the low-power mode
context, but the downstream driver reparents too the MUX_USI clocks to
OSCCLK. Follow the downstream driver and do the same.

Fixes: 63b4bd1259d9 ("clk: samsung: gs101: add support for cmu_peric1")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 90 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index d065e343a85d..ddf2d57eed68 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3230,47 +3230,53 @@ static const struct samsung_mux_clock peric1_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_PERIC1_I3C_USER,
 	    "mout_peric1_i3c_user", mout_peric1_nonbususer_p,
 	    PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI0_USI_USER,
-	    "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI10_USI_USER,
-	    "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI11_USI_USER,
-	    "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI12_USI_USER,
-	    "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI13_USI_USER,
-	    "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
-	MUX(CLK_MOUT_PERIC1_USI9_USI_USER,
-	    "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
-	    PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI0_USI_USER,
+	     "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI10_USI_USER,
+	     "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI11_USI_USER,
+	     "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI12_USI_USER,
+	     "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI13_USI_USER,
+	     "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
+	nMUX(CLK_MOUT_PERIC1_USI9_USI_USER,
+	     "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
+	     PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
 };
 
 static const struct samsung_div_clock peric1_div_clks[] __initconst = {
 	DIV(CLK_DOUT_PERIC1_I3C, "dout_peric1_i3c", "mout_peric1_i3c_user",
 	    CLK_CON_DIV_DIV_CLK_PERIC1_I3C, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI0_USI,
-	    "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI10_USI,
-	    "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI11_USI,
-	    "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI12_USI,
-	    "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI13_USI,
-	    "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4),
-	DIV(CLK_DOUT_PERIC1_USI9_USI,
-	    "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
-	    CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4),
+	DIV_F(CLK_DOUT_PERIC1_USI0_USI,
+	      "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI10_USI,
+	      "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI11_USI,
+	      "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI12_USI,
+	      "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI13_USI,
+	      "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_PERIC1_USI9_USI,
+	      "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
+	      CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4,
+	      CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
@@ -3305,27 +3311,27 @@ static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1,
 	     "gout_peric1_peric1_top0_ipclk_1", "dout_peric1_usi0_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2,
 	     "gout_peric1_peric1_top0_ipclk_2", "dout_peric1_usi9_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3,
 	     "gout_peric1_peric1_top0_ipclk_3", "dout_peric1_usi10_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4,
 	     "gout_peric1_peric1_top0_ipclk_4", "dout_peric1_usi11_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5,
 	     "gout_peric1_peric1_top0_ipclk_5", "dout_peric1_usi12_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6,
 	     "gout_peric1_peric1_top0_ipclk_6", "dout_peric1_usi13_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6,
-	     21, 0, 0),
+	     21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_8,
 	     "gout_peric1_peric1_top0_ipclk_8", "dout_peric1_i3c",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8,
-- 
2.44.0.396.g6e790dbe36-goog


