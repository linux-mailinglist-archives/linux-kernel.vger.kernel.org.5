Return-Path: <linux-kernel+bounces-98388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE00C87795A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5571C20DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B464C7E;
	Mon, 11 Mar 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ/UuWHR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586410F1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710117212; cv=none; b=DyfrulRfa0Pttk3mTZOzqscQEwhBuHwINb0jz+E5/HnYpA0H1Zsh70G0NIrOdJXDe77kQNRWTkl70v0M+k2fClAFgYcg697olMtMLReFOSTyBR5xrKbpMzGzLCdMyTjcyAIsPlIcXe6VHBeUvsb9AGfw1pkiFpioJEOETvQKpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710117212; c=relaxed/simple;
	bh=6x6qS+PKks1vssAtWEk+UCzHzvg/Y2i8NzHpUWJh/NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIr5u6vinqpMt69/6ItYgcomsbNmLdMDpfHRptMzjD3Q3rTNvfSpjo8nCK8xNvCsOITXpoDiQh9ijVcmKUQ4ac1lw3VqGshutVKHQQ5DBAn2CyFW1e819UysRo313GKROrF4FrRrreLnskRULjQfQ6hkJSJsS/uSQSDdkWjkSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQ/UuWHR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e7ae72312so1985116f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710117209; x=1710722009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmOvVR3ukklFbxgndRD6p5C3vHUYb9SXByhvwW6S0L4=;
        b=OQ/UuWHR/H1urByBTKhgfsnxTBLFhqC24oxmUzFZx7iWryimnE6nYSjChDfsPARnC4
         EbgNc+qwRtFe4WHQR6xdBy2UkpohNv35U7LyZOq6qUd/+gHhx3RJy8U/h++s5tQAgUFP
         zLH/UJ0oN0EvnFAzeukaFFwnxP4M/AgtAz1/YKkWNPBmiMhhWMiGnA67Qbk+11EOKrkV
         6zqeVE5ygz92s9j+j8q+NGu7oK+MfSYkZhJiNgrbDk7Jjgp8rH+Sduw9uP3XNNcmNwrt
         bhM47UnheMoJlz6l0GKEibfUaTppDwgymzWlK+QsWtEw9MNa+/JssOVWlRpsmOFjQK5y
         KaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710117209; x=1710722009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmOvVR3ukklFbxgndRD6p5C3vHUYb9SXByhvwW6S0L4=;
        b=t+8MfgpHYeXtw4nAfeL84WePgThcsQsPrjNedQq7UKaurYfSE3UPY/xbCHWyj8SvYc
         Txzn1SPSPQqiITYHX5WNcL4DCIJwSIEHEKDVleCOHFOnSQPjbPAjjO1zhElfc28rzqN0
         J+rGVvUd2QM52AMtmNlPHaGxkNnDUNPs27xlnUIXD7KTxbUXZHNo5fdEY5fERr2Cn1qq
         35uiI6EmrA+2iTNvkolsYbsd7sdy3Z0+oJpFh70J+uDgz2EZTIv+ACifaYTFa5DfhDjL
         jhqN43BSP7d3+UGLksUGA2Wdrxy/7cpPoY6LTfnGGiVXMASIQ62Nx1mt2Ise+NdJHAG+
         JJcA==
X-Forwarded-Encrypted: i=1; AJvYcCWQrhKASJJDwEoDdQTDRaEU81zFEI7TpCkGVIEmS01vYPsXKfwEcGGVwvDhjNhXd5VSaullVWNCSpcBxDeUhISG0AKGx6TTxYiopRpw
X-Gm-Message-State: AOJu0Yw4qzwbEFrYea2EkMIYtWxvc2drmQTa3TWmAR8bx3ToAEkjM67E
	hxpdzbAlVx1/OxOI/gRSshFbWhCVvYeruBlVvalJEux0025ADtrYClHIcYiXzL1m52wsS4OxCIr
	d
X-Google-Smtp-Source: AGHT+IGAOsSKPQLg9syKKDEivpOtvcSvGyYVNDz7m/SWNDIp2rQb3GsY0k/im7Dh+YgHiW31v6uUBw==
X-Received: by 2002:a05:600c:3b23:b0:413:286c:4fcf with SMTP id m35-20020a05600c3b2300b00413286c4fcfmr1340405wms.32.1710117209267;
        Sun, 10 Mar 2024 17:33:29 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b00412b6fbb9b5sm13881720wms.8.2024.03.10.17.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 17:33:28 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 11 Mar 2024 00:33:26 +0000
Subject: [PATCH 2/2] clk: qcom: camcc-x1e80100: Set titan_top_gdsc as the
 parent GDSC of subordinate GDSCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-linux-next-camcc-fixes-v1-2-d126ae0b9350@linaro.org>
References: <20240311-linux-next-camcc-fixes-v1-0-d126ae0b9350@linaro.org>
In-Reply-To: <20240311-linux-next-camcc-fixes-v1-0-d126ae0b9350@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615

The Titan TOP GDSC is the parent GDSC for all other GDSCs in the CAMCC
block. None of the subordinate blocks will switch on without the parent
GDSC switched on.

Fixes: 76126a5129b5 ("clk: qcom: Add camcc clock driver for x1e80100")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/camcc-x1e80100.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
index 46bb225906bff..d421da57697a2 100644
--- a/drivers/clk/qcom/camcc-x1e80100.c
+++ b/drivers/clk/qcom/camcc-x1e80100.c
@@ -2212,6 +2212,8 @@ static struct clk_branch cam_cc_sfe_0_fast_ahb_clk = {
 	},
 };
 
+static struct gdsc cam_cc_titan_top_gdsc;
+
 static struct gdsc cam_cc_bps_gdsc = {
 	.gdscr = 0x10004,
 	.en_rest_wait_val = 0x2,
@@ -2221,6 +2223,7 @@ static struct gdsc cam_cc_bps_gdsc = {
 		.name = "cam_cc_bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2233,6 +2236,7 @@ static struct gdsc cam_cc_ife_0_gdsc = {
 		.name = "cam_cc_ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2245,6 +2249,7 @@ static struct gdsc cam_cc_ife_1_gdsc = {
 		.name = "cam_cc_ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2257,6 +2262,7 @@ static struct gdsc cam_cc_ipe_0_gdsc = {
 		.name = "cam_cc_ipe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2269,6 +2275,7 @@ static struct gdsc cam_cc_sfe_0_gdsc = {
 		.name = "cam_cc_sfe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 

-- 
2.43.1


