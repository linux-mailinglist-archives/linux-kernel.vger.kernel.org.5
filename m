Return-Path: <linux-kernel+bounces-19539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B884826E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6931F22D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3B55C10;
	Mon,  8 Jan 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZvfrBL6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827B5578F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so1886904a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717181; x=1705321981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK26HotwUpgahbJ9EX5x/C3bT14krI/fYq92tviseyE=;
        b=WZvfrBL6Ae9YuubkMjUU6Wv09BGnSh93kpR3MR58rxNpwcB+JUe/GPQJ7crZRfjqtX
         Vjj49pVg8QWqG05DAI4V8/x1bys8v8+e4vd+2Jeu7PViSazrbXIfHzcbSzZd9MwtE6i5
         UwbWy51tUVyNmjTO1qA2ru58U2VOYeJkZozOzEAO+kgTAWX9OVYxN7CloYcdeGeMjyAn
         JGsDdwiCiyqFxF7ypU/ady+hvLTFxGW991yIpDkar8YNT/EObVFGjzGhqHPbB0kg1d74
         UNe4HL+xwIpIrJ+v2xUc6rMDtWq+NMp4F3+vkd5gg7yyXfA0y09a9TDTGM59VnIPmIWQ
         HY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717181; x=1705321981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK26HotwUpgahbJ9EX5x/C3bT14krI/fYq92tviseyE=;
        b=mDpm3N9I8USrXUpKwHPowNlsCFADEn0o2sfvRWS7UGkKHBzwzl7QXVhpuxou5fSVDl
         rsN8MkDazcDedXTr/2oqel/W0c4JZfgqZ9yvxYkEpJoicPoEr+1NryNVwKviQUCCLnQM
         cazu6sqN8AeAqKhj1SRgTPEpMn5a3laHJRwNa0O+e/pxEbER2LGKNlCJGCvzrzm47aFE
         7ZWbWL5yYeUcw+bGJAylGQLU+I/ETBChznfBhrDfE+nfehzpOqxSSRSf1lGh/bPpUqeZ
         mTqJm8h3MiLuenr8I7ypilltwQkvOUdrivj+3Xsjyv6JP847h1/LNH9mxJ+RRUKIs2mU
         DrRw==
X-Gm-Message-State: AOJu0YztrJt+sI63E7n7+CsP7tZox7tkrBAuG4MGZN4N/pB6hbpU5GFD
	V4nMYQjfrVen+FgyCgPfqlZElUO9HDz1WECcbah6IkoWe5Q=
X-Google-Smtp-Source: AGHT+IFP5toUqJ2PsQh5sURXL5AJbn5HeLIcwq8psbcWs8Nx+5z7izOF90UKuJtQUmoOMEDusD4Jpw==
X-Received: by 2002:a17:906:c00c:b0:a28:27cd:966f with SMTP id e12-20020a170906c00c00b00a2827cd966fmr1365932ejz.66.1704717181156;
        Mon, 08 Jan 2024 04:33:01 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:33:00 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jan 2024 13:32:34 +0100
Subject: [PATCH 17/18] clk: qcom: videocc-sm8450: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v1-17-981c7a624855@linaro.org>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=feC9+GWvv8xnYn7InxxSn/5ZFRq5Aoh8gmZgqG+eDBw=;
 b=OPV3N3uzB/vrUgOyJfIOwt2UGKoUYpVGHHCkKZ+OpReIfDnf163UoQ4KTPgw/s9RjIpwPFhU4
 uO7lSiA4A73CXaZcJNFOfcwIDYDGpzGxS44UDPUUEk8dTeZf0putT0I
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/videocc-sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 16a61146e619..67ca302a0737 100644
--- a/drivers/clk/qcom/videocc-sm8450.c
+++ b/drivers/clk/qcom/videocc-sm8450.c
@@ -373,8 +373,8 @@ static const struct qcom_reset_map video_cc_sm8450_resets[] = {
 	[CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
 	[CVP_VIDEO_CC_MVS1_BCR] = { 0x80bc },
 	[CVP_VIDEO_CC_MVS1C_BCR] = { 0x8070 },
-	[VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
-	[VIDEO_CC_MVS1C_CLK_ARES] = { 0x808c, 2 },
+	[VIDEO_CC_MVS0C_CLK_ARES] = { .reg = 0x8064, .bit = 2, .udelay = 1000 },
+	[VIDEO_CC_MVS1C_CLK_ARES] = { .reg = 0x808c, .bit = 2, .udelay = 1000 },
 };
 
 static const struct regmap_config video_cc_sm8450_regmap_config = {

-- 
2.43.0


