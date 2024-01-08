Return-Path: <linux-kernel+bounces-19524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E164F826E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16AA1C2258C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2F51C38;
	Mon,  8 Jan 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7QwnjlZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE51008
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so890309a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717154; x=1705321954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUvQsMq1PbRCWmoeSPQnQVBbz3tj7l9AsvjXF5PvuL8=;
        b=h7QwnjlZyyhDWs/H8McSNX+DYKnqEum/fUWlJdHaDzUYIISABMWnkW17lkNBbjpTaQ
         vWQaSRAKrx7u67B6DBHKGjQ3GnbS2ar55MgawuILgdQYoQD+yjLLtieIKU8HhWAb+X2V
         4wro+Oi6IZO60hkplN9McWaDPxK8GLjchZg6FZJfcpmG6VN/AolQudlAwkUToMsrfd+c
         sGFEYbhB5ZYsvAB72alNC+3YKjb226TkA9iWGFZJHUa7k+omBFYLCi86i4I2GuIHp1Ij
         55eit7KqE5PkFXnOaqaJ9ahN9NY/5mzHnV/OL0iIpgVHz7wqZsvP5SCyWH3wWywQmdqP
         k4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717154; x=1705321954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUvQsMq1PbRCWmoeSPQnQVBbz3tj7l9AsvjXF5PvuL8=;
        b=B1eqbPHMUzBQnhqxjIEgqPHyzQ7iwil9dB62kG1ngCxJKdovN3L4zobJ6q2Au2DuId
         H1G5o+qdpR8Zl/5+baDhjhC4O2c21/D5Qn3kuQN9TyZn2nVNgixy/19RzO5A0YWjK3HJ
         VwFLMD+Srl3IewUPL7K96C16IYEjR4gDElA78F6OsZNyxHKonaZ/uxug1vQjl784pbwF
         fZR8v91tgkbPiloxzB34GRtB+Q5gQMeWzum9YHXLZ+E9BMGQeZAfBpyUGXpCO3U3vd6c
         G5pVS+hyaypAcp4p/PeQmD18AKn5cDzhIx/gq4HwJC4RBf4LMmKzeALVGkvNYJ/mEgl8
         xXzw==
X-Gm-Message-State: AOJu0Yz4U51mRGOS+CwfIE0tFcdyKLDOE4LrqW87JA2w+2exajtQlURO
	yAEr86e5vrNzCLP9M29uQdmrA0150mmExskGF2FxTg8K3fo=
X-Google-Smtp-Source: AGHT+IGw5aWqNxEhkkmO3WxhcToxtCBVAW7j5MAuvgc2LH41sdshJTZCrU6Wz1+XC/Quspwn0BEuhA==
X-Received: by 2002:a17:906:4f8f:b0:a28:9546:f92a with SMTP id o15-20020a1709064f8f00b00a289546f92amr3213285eju.67.1704717154382;
        Mon, 08 Jan 2024 04:32:34 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:32:33 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jan 2024 13:32:19 +0100
Subject: [PATCH 02/18] clk: qcom: reset: Commonize the de/assert functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v1-2-981c7a624855@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=1900;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8Ln08zwOLxxs1oCk9D1EV6KlVNtzHvoS1MgmoKMR/Vw=;
 b=uiBlXQSeveo6OYtgybsM4Ijx6cJYCnikHYLQARjmmvJSPRoT7VQNpExbZxFteGRcrSkoV7nIV
 k30jOX8wJPNAfiTklEPXntTjteUaycuNfblwmHzLXT7OokZFEvnvC+u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

They do the same thing, except the last argument of the last function
call differs. Commonize them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/reset.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index e45e32804d2c..c4ac4d18829b 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -22,8 +22,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	return 0;
 }
 
-static int
-qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_set_assert(struct reset_controller_dev *rcdev, unsigned long id,
+			     bool assert)
 {
 	struct qcom_reset_controller *rst;
 	const struct qcom_reset_map *map;
@@ -33,21 +33,17 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 	map = &rst->reset_map[id];
 	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
+	return regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
 }
 
-static int
-qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	struct qcom_reset_controller *rst;
-	const struct qcom_reset_map *map;
-	u32 mask;
-
-	rst = to_qcom_reset_controller(rcdev);
-	map = &rst->reset_map[id];
-	mask = map->bitmask ? map->bitmask : BIT(map->bit);
+	return qcom_reset_set_assert(rcdev, id, true);
+}
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
+static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, false);
 }
 
 const struct reset_control_ops qcom_reset_ops = {

-- 
2.43.0


