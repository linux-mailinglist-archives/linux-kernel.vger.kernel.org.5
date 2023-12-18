Return-Path: <linux-kernel+bounces-4018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E98176C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275C3B2268E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16455BFB5;
	Mon, 18 Dec 2023 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCVDHbyX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2F498B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b5155e154so41189595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915347; x=1703520147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeZetCZqAjDfSmYH46X1jjlV0+TjZufo6m3dLVzQ+S4=;
        b=aCVDHbyXp8XIpxKCqBbIKLTaXbB4yNe3M/7nwZrIWprL6XYTg0vAEn7br2DpVsHsYd
         5MWeWp9MOuUAcdX3BeXxuolkvVeYHsQwMkrOegXRKa2Dq8f+PB7uvhKgXl3eqvgNi7ol
         ra2dD890cEwd7JpjHktH03XXzO/bj7+GZ6LPPAWAOX4hEKTVPw9ZzRhNouwoJ8Sa5DYM
         HmBUtQBa01ZXP0hs8pvwye8rdB3k9kdXfozk4fJnzOALvnDSWLMqZnp3YokqVfeJjvnz
         xY9DbB1RHHIKAcPI+M63NyLR1G1xPcHG+qWOLgsSHDjTV+NmcuIBzyOc3TeqGInZKYTy
         Zk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915347; x=1703520147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeZetCZqAjDfSmYH46X1jjlV0+TjZufo6m3dLVzQ+S4=;
        b=WZoCYJE52VmmJEKKtR1YOSwKAYyLP+xPggN9GwNPAW/lAmvzezKWc2sg0cgekwl+Zm
         Ho4jST4dVUJYkop/kpxJ1Orqxq0kWwKCNJu44PHXGV7j3GXsHDlgqW1ef8u57Eojbvbt
         qjDDQCSy3StxXaU2ljb04MXWb8N/YLGKMYth2pj7a3BST9vwZaBemlLuqUdHVTFdQRaQ
         yNSerG3s3LQigLpXJLS6VEIiJU+4fZADdc3UkuVHtpbJyt4q807H1QMC6dn9qNs7Qt0H
         7OoYCVEJwezhB9erSMwxGa+DSlWBVBA8wLB6S9lOeNYGSoWySCIpIbLzQ5Q4+Pt0Pjlg
         wSog==
X-Gm-Message-State: AOJu0YxlJBlKndKKNyqDd2kCDo4tqkq0QETYMAOS3/i+azi5tOXExnnS
	Z/0LmlJtDuMI3mShLtHYtUzKHA==
X-Google-Smtp-Source: AGHT+IEhH8Cm/7N1a2HGbuWE26iVjDxJr/RSPJj5TmO1nT/mLSPqnfvL2D5CLL3oKA1egQJFO8uxWQ==
X-Received: by 2002:a05:600c:474d:b0:40c:708b:cf52 with SMTP id w13-20020a05600c474d00b0040c708bcf52mr2013391wmo.122.1702915346798;
        Mon, 18 Dec 2023 08:02:26 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:26 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:06 +0100
Subject: [PATCH 05/12] clk: qcom: gcc-sm8550: use collapse-voting for PCIe
 GDSCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-5-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=1720;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N7ribrag25hwrEIJX+mk3d9ZiSp/Y74Ht6lzkGi4xcQ=;
 b=Q0hpQovWX3D9xySyJlu36S3vjYXNimLqsRXVvoDPkESrr0Tz8RPZbVIA4Ax+HmuuKblQEcaS4
 pRsrNl+94xoA7LlvekJOjpLRk0zNUJWxHmDqY9i9dLummXWEoXnZ6oJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The PCIe GDSCs can be shared with other masters and should use the APCS
collapse-vote register when updating the power state.

This is specifically also needed to be able to disable power domains
that have been enabled by boot firmware using the vote register.

Following other recent Qualcomm platforms, describe this register and
the corresponding mask for the PCIe (and _phy) GDSCs.

Fixes: 955f2ea3b9e9 ("clk: qcom: Add GCC driver for SM8550")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8550.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index a16d07426b71..73bda0d03aa7 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -2998,6 +2998,8 @@ static struct clk_branch gcc_video_axi1_clk = {
 
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
+	.collapse_ctrl = 0x52020,
+	.collapse_mask = BIT(0),
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
@@ -3007,6 +3009,8 @@ static struct gdsc pcie_0_gdsc = {
 
 static struct gdsc pcie_0_phy_gdsc = {
 	.gdscr = 0x6c000,
+	.collapse_ctrl = 0x52020,
+	.collapse_mask = BIT(3),
 	.pd = {
 		.name = "pcie_0_phy_gdsc",
 	},
@@ -3016,6 +3020,8 @@ static struct gdsc pcie_0_phy_gdsc = {
 
 static struct gdsc pcie_1_gdsc = {
 	.gdscr = 0x8d004,
+	.collapse_ctrl = 0x52020,
+	.collapse_mask = BIT(1),
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
@@ -3025,6 +3031,8 @@ static struct gdsc pcie_1_gdsc = {
 
 static struct gdsc pcie_1_phy_gdsc = {
 	.gdscr = 0x8e000,
+	.collapse_ctrl = 0x52020,
+	.collapse_mask = BIT(4),
 	.pd = {
 		.name = "pcie_1_phy_gdsc",
 	},

-- 
2.43.0


