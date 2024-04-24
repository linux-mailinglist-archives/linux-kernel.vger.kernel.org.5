Return-Path: <linux-kernel+bounces-156099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17338AFDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312D21F23120
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F9182B5;
	Wed, 24 Apr 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2HpVrkR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6479E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922776; cv=none; b=m/XfSSRhL+4oRp70qYpVNe6ejAcmelb6enW8O3tIJR07vkBU4YnjG1ZwFd9IhouRbj+TdYG4VGEgauxr9rtJY4ZruMgJ+h1aQtRsGY0kUtpRwEfrW76vySyFsyi1K0RteOnxj0oJ+bB3gTFyJ+8eBHDIMIw0f0dBV+cnERP2YT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922776; c=relaxed/simple;
	bh=+wcSE0jQUAsuubsPo5heuUnwmIQFYUlds9F5s8pvyXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSUNVO9VMKo8U2lOuk2LWpCRpMDPeP0DA2rqzC/n2752D+OapHgpqduW0JnbKzAO27F6AnvEFbnzllFHvNJAA+lNAtLJ4qqxH/AHF3+ydHVddtdzrF9Xlm9U9gDcaFS4a/FQrpcAoOW+cpGgwK82tjw9Yn7qowIRK6mz6nACE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2HpVrkR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so6462453e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713922773; x=1714527573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRE2xz+4SCVpjxieYxKZULbd5N+a3QgwBKnW385TBno=;
        b=s2HpVrkR3rh4lGn/Y7xWbBV76P9taQcLwqyICQM4B6vwPSeVYF2y8VhSHfV4rDAlTj
         7CU/sVTZDVjU2QmoL//D1k8lakNYFijsZCWjHaTSO0SmOn6zQuonZgMmZ5XdQLqr8/rr
         lxZS4rUN/lUlV4qjt1HSkgG5XB2cQs8Yc1nOjFM65khsChPIzbgC6cNjRTZgWtVNw9YC
         VVVOaypBDzvOIybFQHadI+O2zVxPr5n2WDTH3odtZ7mpO2Ijgv5qRBfd7AWtlsEMxpj9
         bTOUbeNC2C2fs/EYEUUjavWhXKzUAB+cp4+RHX5eu0mmkXTyaikQaHJErFflFHkMsvrS
         xKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922773; x=1714527573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRE2xz+4SCVpjxieYxKZULbd5N+a3QgwBKnW385TBno=;
        b=mb12iw9gF7QGO/iMlcNyECHAGor8eKju6sLu3VHT/OvVPIdhUcI7qrpDTHH6nPRcZy
         Tbn2Xv9WNVwc2ECaxgu9Ls174n8MoBmvGU5ggLpt7a7daDC3dvUvLF01+xfZmZdJFcYe
         jH+blD0eZuM+wlA0AcuJDy6nwjdisr+Z1kYP3K3Q4oPzfrx3zocps8jrh4sUXye0qLrM
         8RoQ6q+xBhZYfKeojHavn3DQruiodK9Lk99S+HecgC5cw8glFXll4Hmgm8h7CU0+rNu8
         Il47XkcOjcKOtkDjcFFkSWlMHUxkYK4T6KNW+1K9edVtU9HDLX8P0dB7tgA8gOf2Yp/i
         Op0w==
X-Forwarded-Encrypted: i=1; AJvYcCWeO0mdgjMNS26V5z9ihp6nonlCSAqGhFZhBHyH4IsvQLqzX6BNHJ50uMAog+pX4V7noKkuGuQ+D46vht0EfyI2qNXZfj9Xpr126nD2
X-Gm-Message-State: AOJu0YyUxtbQbLKYB4Z+v6LXw+Ol/yRm4p/I71V1VN+Twdy5MqnstzA8
	NOKZlGbIO31TsMrcqrEa5C7Y99/Tm/uYn+ePCBBa8aT3d3VDDpnJ1JgQxaCML4zxTBqNJGAHFY0
	1
X-Google-Smtp-Source: AGHT+IGRzIXPdB9QF4OcOMf2yjGCh2HxaDOEJZ98eApb/jKsXg56E91CsY8Sx1A75w1ipLAosxB77g==
X-Received: by 2002:ac2:4291:0:b0:51b:c6b:f87d with SMTP id m17-20020ac24291000000b0051b0c6bf87dmr619750lfh.35.1713922772952;
        Tue, 23 Apr 2024 18:39:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ac0c000000b0051bb40c7ee7sm308220lfc.185.2024.04.23.18.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:39:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 04:39:31 +0300
Subject: [PATCH v2 3/4] clk: qcom: dispcc-sm8550: fix DisplayPort clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-dispcc-dp-clocks-v2-3-b44038f3fa96@linaro.org>
References: <20240424-dispcc-dp-clocks-v2-0-b44038f3fa96@linaro.org>
In-Reply-To: <20240424-dispcc-dp-clocks-v2-0-b44038f3fa96@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3479;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+wcSE0jQUAsuubsPo5heuUnwmIQFYUlds9F5s8pvyXk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmKGLRAV1KakRYNoWd1kjF4UdOERvn9SJVGwnvq
 +D2bkvZkBaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZihi0QAKCRCLPIo+Aiko
 1eDqB/9GiAaLEiNaC0CA0LKXCOKa0vb1gQFjUGjV0J7jQic7zzkC9qm2Kf14APNhbxr78ncwJTm
 /PLVVLaBoXvillojCGnbGovLWdAu39k2HAl4sreiOucjHLbSkd01eZXRcN6+QH72INXBSH6k0gT
 IFOiPYj1a38mNooF32jqZP6BzlEiM1HEufZGY+s+ZcMgRc2fFPWnpKqBFf9VzQegcHlktH1YR8Z
 +s5FpX3XoE5UyvHaZ6ebA0o5FJrXnWGtE0Zo/A1BPEKky67YpnRUL+z8GXx5ypiB5jJQMADMMqF
 PYfmDxvz1RX3xRnLvQ1G7K29TWuMftKQR1In5Mk3l543D6/d
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SM8550 DisplayPort link clocks use frequency tables inherited from
the vendor kernel, it is not applicable in the upstream kernel. Drop
frequency tables and use clk_byte2_ops for those clocks.

This fixes frequency selection in the OPP core (which otherwise attempts
to use invalid 810 KHz as DP link rate), also fixing the following
message:
msm-dp-display ae90000.displayport-controller: _opp_config_clk_single: failed to set clock rate: -22

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 3672c73ac11c..38ecea805503 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -345,26 +345,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x8170,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -418,13 +409,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -478,13 +468,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -538,13 +527,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 

-- 
2.39.2


