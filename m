Return-Path: <linux-kernel+bounces-87233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C286D174
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084011C228A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABEB7829F;
	Thu, 29 Feb 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVBq1Kss"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8578261;
	Thu, 29 Feb 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230105; cv=none; b=sUdyLp0x/x8gQ2bGnir5We29xw+YHNKv7F1/AmtF4Othl3f3no5IhDI2/suhkrJGzqdMnz+ZemjZyCMvHBGnNFllAG947nW4RYPelxDrmCEnno8h3D5ASeZQNAAFtGdrwE0INOHHdwuQr3rSmVTvogyMmnA+r9ELR8YEU4skc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230105; c=relaxed/simple;
	bh=GaTSHoEdQQZfdVPgGu4OC9tyNlKXbXyeqwoMC3yFiEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWir/VVH1Tnqb8ecGzwpouvJnH0gHaV0glrIstMlE/+w1Ol2aple2TJDybBC9Am1h/Ep5+F+ru6I5cbeJGbx3MInw88fV3yS5z//IqWwTMxvRGd4zwuiZcqaCxkD2rLzmQYx72vXyxXEBO1tshidwMsoNRr6Y/EOkAwzB3xbd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVBq1Kss; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412bb23e5c5so6894015e9.1;
        Thu, 29 Feb 2024 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230102; x=1709834902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH08pUQU08Y2ZLx4/JDTMu/sqhpXrAaQNeadE+HITMA=;
        b=hVBq1Kss7t8GRpNIqwb7NBnqPiHg4nhnl4dciO7YD5mSiLcLF/Ug3OJuDlvUbP4x2r
         BsJSwiB4nw9P1s/HR8N8YLgDRwCVImxIVM9qxxJpmiTHnUmPC8vKrnCPUJo+aGGFI/xX
         IiYnRh9RpbZotbmgRLkYMwNiIiZcxeJVIL1IeoX1XOeQo5VflRiN9oMVywvEGZUtBNsv
         Lwc0yP2FG/dJuTx5ZJGxclm1gbBo1Yj9xRzqAahq+PoNEPwwv4tPMtDIlB8sqHo91yQB
         jgAOET/62oIuOPDk65xk6+FOr7V3m68ByunKeckZayfG6JSDhnkhe1tTcS21YPuentBL
         JM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230102; x=1709834902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH08pUQU08Y2ZLx4/JDTMu/sqhpXrAaQNeadE+HITMA=;
        b=LxEXy8sCpBnZqfBpRQv85L7XT/HnskizFNbM2n9FL+PBK5GQI8fkhiiGVVM/NuSKQ/
         XDzXyastoAlgtSXaGy7mO5XWvS82RHV3xZT4+cNPMwJkPKoA0Vw/35AKPtMMJVRQ1Mwy
         +c/tCsDnsZRNY3A60vvTEXrHq9IQRSsUxHpmIQnSmaLlYYSTa1hKpoxtW3ztDxrANunk
         WftKPp1vmvJfhb+O+PJ2yZvapXhUs6OeX/6N4YW0sCZGviLd2LG+T5galV8Tarqr80WN
         w6M3aPKamtCTxNBW0BVQIUwjKr+kMX/WQqMDjq16lyX/IfqwrQsZdP5pgw8bGpxboovd
         c/1A==
X-Forwarded-Encrypted: i=1; AJvYcCXOuQswpqjQcmpPsX0C4sQKB87dM4PdH4hm+mfzDyhMidwfT9oE1BQ4RuYDfX9jQJaq1UiNJsjcsReTliWZkJc4uYAXEclZD85yzQgaXWIjVWcShPMIaic2naMi6XcCuYCXeaXxxQ2C
X-Gm-Message-State: AOJu0YzJphcalU4Lmb0vQL2gVnf4ideZ/q9rcIioPnH3URm+4Gly+knf
	3wKaZjwIJQ6Nzl00TyFmC/sUpcl8zcZtfYwnmRQ6yyP0GjxkqCxM
X-Google-Smtp-Source: AGHT+IH22zo9cFZjUhrRWIvR6gJU6E/1MNLkCACiuLXwjAhwhV4YuRt8iR9nZr+p2bfsIq91eS9xaA==
X-Received: by 2002:adf:cb82:0:b0:33d:b312:2130 with SMTP id q2-20020adfcb82000000b0033db3122130mr3449072wrh.11.1709230102255;
        Thu, 29 Feb 2024 10:08:22 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:21 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:46 +0100
Subject: [PATCH 1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
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

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 4aba47e8700d2..856a2b30e2a8e 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -857,6 +857,7 @@ static struct clk_rcg2 lpass_sway_clk_src = {
 
 static const struct freq_tbl ftbl_pcie0_aux_clk_src[] = {
 	F(2000000, P_XO, 12, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 pcie0_aux_clk_src = {
@@ -1099,6 +1100,7 @@ static const struct freq_tbl ftbl_qpic_io_macro_clk_src[] = {
 	F(100000000, P_GPLL0, 8, 0, 0),
 	F(200000000, P_GPLL0, 4, 0, 0),
 	F(320000000, P_GPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 qpic_io_macro_clk_src = {
@@ -1194,6 +1196,7 @@ static struct clk_rcg2 ubi0_axi_clk_src = {
 static const struct freq_tbl ftbl_ubi0_core_clk_src[] = {
 	F(850000000, P_UBI32_PLL, 1, 0, 0),
 	F(1000000000, P_UBI32_PLL, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ubi0_core_clk_src = {

-- 
2.44.0


