Return-Path: <linux-kernel+bounces-87238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BA86D184
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF21F2629D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9CF1350F1;
	Thu, 29 Feb 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZK4+MAd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED37827B;
	Thu, 29 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230111; cv=none; b=rrGJ2rot1hDdAIfWn2NIwUttVk0fYlZT/z4ai1uMTpTF3LmSBYaahAJYQPkldmb7QhhI5GrBw5KSgBvw2IOF0kPOTOT/uXibjjOBPaDHzit93AFspRwd5g0z8JRSEuicgM6jNssLmEhAz7qUwKetpNt16F6HLLgRcnWxCnzavBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230111; c=relaxed/simple;
	bh=n9HZ8WlG3tVYyfs4qDWScus2Mw1QcHzAyJ6G8lMbDUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK2OlgKQEtqxz/BUCpXif0oHX84U4uMfRwEfeBeiBKto6eByKfo2VMROOMXBC0u/Qk7yAStEfa0atmor34l8q/eBCWoQ6AaMA4S7ElTka9xaB9lSyjONfZqzfo/A3yk+1zWGxY7XsvLCsMWSfvHkeHe5B8r5avuWEcySOhz1Jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZK4+MAd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412b83cfb44so8094225e9.3;
        Thu, 29 Feb 2024 10:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230109; x=1709834909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHEkZ7LkAYiQY4fORY2GQCirviKcqtGOy+eYZIPtn30=;
        b=bZK4+MAd80pbQLPvrSbWzaixZiFbocFIRuvSUVeIwUpo5pWEGFpyHEnw/YzhNEie3f
         DWbxoQX7Sq6Gcrynyv/q6KH5YMaSERYglgu2abcmNEPoN5RZlkKkoaooLikPvijG0nkY
         HLrWRR8F8gKXbIl5rOe7+yV3Pl+0z9l4NIPXzkeXslvO8BvWwMqSOOzIOXQcQGETwbjy
         221xCM/YubmvUSydW/u3BHVOyShrueQS1eEXeTgQIJN3c8q95lmsvrNaHjpVd535isZv
         AwUxyMfF8T2vsbeDdo6puoDAphjuPZnMbI2DceEouA5OYix2rlKAhvdGkRwucDF3X9ye
         a7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230109; x=1709834909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHEkZ7LkAYiQY4fORY2GQCirviKcqtGOy+eYZIPtn30=;
        b=YGQz7zHti5xjlQaaMgCmmz7uzm9lSfucP63T4W12zqdQ9gHH6NTsxVIwVo8IVXS9Hm
         6ezUDZDlSk9w0gw3fY4VM4cLwoxbHM8te3NCduPDkpqIqFtkN2F3R4j3gKMKe+gYjQv6
         V31zbuVHKKY4Os/sLkjREycA8/QxCkkU0jT/QVkCHbcV0n50yO+MTRxUzP75ogNZiwMz
         fbQfc6b2YCUrQVzM5tboPMTOe/Nh9w1EfAd5UxxlwMkixlZs4CwTNSevEAbXGvCDdsZY
         2g6H6ki9nCJOU0eUU35slUMPTiI9vVySEuDlXIkHF90VUvJawv060DIKUAu47aurLc76
         0CpA==
X-Forwarded-Encrypted: i=1; AJvYcCVlw5hpgBtejzqXr9W1gqprNc5AzpuijPWVxBIRR4VAzcUpHKxrXK4qB9xnf9krf6lU93Sd/M7ZYrYsqCktpKfcV4gLwMu0FsTNXzBXUqGoSyreSVyrzsocKQMhZrCUFnlOxvwjNj6h
X-Gm-Message-State: AOJu0Yyt4wRQxo06U2YyaoX/LSMZ44DUbFCkAP529ByVfduwNAqfGRxG
	3rMw40e9Lp1dqV2QbBgf18Q1ydCXSCNDp46GMLQ7vNfsK536u0rS
X-Google-Smtp-Source: AGHT+IGfIk70CGd9jgpNki5T5kP9imwifMA1iTr+PJNC4QqaZd9DdaXiXHXzkUKKvajEwDWD1pzChA==
X-Received: by 2002:a05:600c:4d26:b0:412:b6b8:b5f1 with SMTP id u38-20020a05600c4d2600b00412b6b8b5f1mr2464527wmp.18.1709230108724;
        Thu, 29 Feb 2024 10:08:28 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:28 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:51 +0100
Subject: [PATCH 6/7] clk: qcom: mmcc-apq8084: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-6-074334f0905c@gmail.com>
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

Fixes: 2b46cd23a5a2 ("clk: qcom: Add APQ8084 Multimedia Clock Controller (MMCC) support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/mmcc-apq8084.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 02fc21208dd14..c89700ab93f9c 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -348,6 +348,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(333430000, P_MMPLL1, 3.5, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -372,6 +373,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(228570000, P_MMPLL0, 3.5, 0, 0),
 	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {

-- 
2.44.0


