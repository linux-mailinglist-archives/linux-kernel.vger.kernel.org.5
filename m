Return-Path: <linux-kernel+bounces-156100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA7D8AFDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B301F23D56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A121BF40;
	Wed, 24 Apr 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zv0kPoV9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539B10A1A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922777; cv=none; b=t3bgAkZXXPoDUwsHnA0/0Z/GeU5sXHWHUZ18uKRF4ORRY33iy2C8dFzFq+rRGhHUpmojl5GUt17NyY291hLHIliwMjWq92t8MvRxdqEerxaCLQJ+eWcIMV7PyhMpcLun7s70HADAepdxaS4Ime6srsbl/6iJrNlSXPdGVMyS0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922777; c=relaxed/simple;
	bh=zB/5/SiVEaWqGONs3bHHf5u8om8piOX61Ct2vWQ8uzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enkamRhj8Mj+dxfK2yeIqXR3lMjD73XKkn7MrnOK0Qf/IC/NezWK9PLqNNilgH7PBrhHT/PQbVUQkLHla9nYIK8OLPBgpMUOejbJa19yzKQK7t6q8WpmR2N5wvyDXwi9NHyPj7uFLQb64kMZ7ZLDxGcvRlS3yxc9h+RJN+00Qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zv0kPoV9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5196c755e82so8885944e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713922774; x=1714527574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0SAcbh24fRWzetmmLWxyCX4LLEoLPaKUr5EKpApP2Y=;
        b=zv0kPoV9fCfsVnt7Fw8/DEy+RVskbQdhU5oOWAX3f2cyI+QSa8BCC+uJ/vnK/KC6/u
         1OYKmtJOBCVtcsGblcqlWiKzFxRDpGBhJqc9B3VAuL9yh1W7LkaZQUFz1mM6MqJCr3aO
         DL0Kgk4WSEyKH6YcZEf4BQ4jaF0u2MgOk0QVcILoHQxfPbZtoqFN7/1V1z3MsyJzDsjR
         bPbZpuH0n8BrnMjsv1qdbfMYL+ZMwr74I+CWbS+/ozNOmKTbtYgWs6yLrClOtf6pygXr
         3mQJ6sk+0GVMfACJNjEBCymHof1JhXE0F7sTaQ8r5d8tvT2wcUgY6ARVYptEJFbKt4ME
         zhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922774; x=1714527574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0SAcbh24fRWzetmmLWxyCX4LLEoLPaKUr5EKpApP2Y=;
        b=qbYqaFK4OOBhqJEEMFeuI+Z3BD00RyxBGACVFyENm24/UFEzD0OfsZ5XSQFwE79Vim
         JcFcz0UMaQR5boJiUEwte7MW5pObSDwANQfIFmoaNAwV3eHB3hRtOAGmlRkAcYXeqBto
         y+0LT/cTVbpyTrXIeZNca5/4P+r9gp63TYcJCCvQxK8m+2bKiea8rAIbDwTHr9dSPLx7
         HxrXqZTZVl2aDausoFhGVNFuU6PqneTV/O6hNcZ3MqLnxI8eIaWhJBof+XmQ6pKgkuKD
         f5u5aPqTk5RDXJDO6nszT5nxcMX2neOFdnB2AO1vrUKLxS0/l6S7CiGkzZweovTt469N
         ZRgg==
X-Forwarded-Encrypted: i=1; AJvYcCXX9m8oP1o6LC6YS6afCfWxePsT6gOoT4Orn0zlPTgYtuy27QKVGXjIcKX+gmeDQMj1/UMz0SVPp545o/B9NdRUsOF9J02ylopd7aTM
X-Gm-Message-State: AOJu0YwPdJLQ3FWDnJ7S2pueF1I4z3EHS71JkAI5SEqcg/C4egIFecfn
	TZt7tsRFFjIuU87UveYQlg6HN/wgTAm1pcUU2Tyrbgd3wIlsafn7gVWqLVpUJcIa2u2ER1+USjV
	Z
X-Google-Smtp-Source: AGHT+IGdbQI0R2wOMogLqkeQ21E23IGK/kQjS17BkmhhtGkLD8SfxJi7UWEru7YPXiHAhcrrAeBCJA==
X-Received: by 2002:a19:6a14:0:b0:513:b062:98c4 with SMTP id u20-20020a196a14000000b00513b06298c4mr556942lfu.11.1713922773840;
        Tue, 23 Apr 2024 18:39:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ac0c000000b0051bb40c7ee7sm308220lfc.185.2024.04.23.18.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:39:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 04:39:32 +0300
Subject: [PATCH v2 4/4] clk: qcom: dispcc-sm8650: fix DisplayPort clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-dispcc-dp-clocks-v2-4-b44038f3fa96@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zB/5/SiVEaWqGONs3bHHf5u8om8piOX61Ct2vWQ8uzE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5pG0iVJnYX9C7JjFph8MF1o3mPiraS88YJd9gsVG52qk
 K62GMdORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEwkZCX7/1otyTk3mlaF3JzJ
 fGxyx7VjP9XqLifanj69kOGU/7vWwvrOPwm+RsU2DN2aM19X8pms3Lj8rMKCs+92+OiHKO0wqej
 6PtvuqJOQptDGd10HV+ctuNmvKT7xg8ayzPKrefdl20JLGDzF4n4VyhicT//M82nZ1/U/uZXZu8
 2vRtmt95+z+w/DtBsJOq9VctZ6P30hPE3jQbzkrvzo1D2HP0dbV7dMVxNJXJz24dZtc0fvvnm1G
 /l77azOikVMbvlfobG95dnTx4LBq336rFfZzwy9yfAuwVZtU39GZt3c6keFOTt9/QXe7ZWfWxb7
 6Z6btNKXeXXl3c5LLnnGc9daiYqtju+u+9Hx8YNRc1kqAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SM8650 DisplayPort link clocks use frequency tables inherited from
the vendor kernel, it is not applicable in the upstream kernel. Drop
frequency tables and use clk_byte2_ops for those clocks.

This fixes frequency selection in the OPP core (which otherwise attempts
to use invalid 810 KHz as DP link rate), also fixing the following
message:
msm-dp-display af54000.displayport-controller: _opp_config_clk_single: failed to set clock rate: -22

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index 9539db0d9114..3eb64bcad487 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -343,26 +343,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
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
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -416,13 +407,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -476,13 +466,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -536,13 +525,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
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


