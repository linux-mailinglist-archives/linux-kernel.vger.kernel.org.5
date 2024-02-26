Return-Path: <linux-kernel+bounces-81790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B059867A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6162A3F72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDA12DD9B;
	Mon, 26 Feb 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeK1VO/g"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DD12C559
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960961; cv=none; b=k2zkL2GagkQzUJStr1oX4iQj0WKbQhv8QMjOYQ/j/0+XdD6r4pEO+PPse7fzMqDL9p1lV3Qo5aeFGv00GQnQEw71Jw9iTsBDsnQXo2w7jLbyo8+WO5naiy4OX49GdTw8l7MLamb9NNMJOVaPpI8kKVQbMxsuUU4oLDQ8BLTrwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960961; c=relaxed/simple;
	bh=37wQmO+YdaEsa3xL7Q6rKO9ox5eQT6E5utt65Fi0uWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/HiC7aj+gMKAh4HpK1roE9qtVvraYH/j7H1ft0v6sWI/cYeXfqbXyqdP3CTzeHb9VmcSSdo6TSDxACqaY3ZP+wns/ktxGeb3Vlwby6GSQRjbFMXl0pQ1nfeWuwPWEQ1vUigLQaf5+SHONpccOD6dB9SwRNiHusG97zWnbOIQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zeK1VO/g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a882bd4eso4013485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708960958; x=1709565758; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onsSHtOKzEIZICx5NzIaNglbxD6fxTitMyvZQ+hIAqU=;
        b=zeK1VO/g6vNqLIHxNEMJ1OGZstMbOTQVVpRQmBwQvwJvZzc0+6RHmbBCPKpMcw52FO
         8jZ3VhXnzdG+Eh7YRbbvnrW/IRF4+YbvpWMjRI+qjNvnt9dS9xSfq8+L4PVQF+HoYW5o
         nAbmwuRcMtvuGUos7kPD1hFA+jTidw+6OLre9laXWJHg6GM3axatywuI252AaKCEL5oI
         Kyky0jM6YRLuO3chk8lbvE4PSuRzy6ccqTFpupmirFn2WeBjoGO5ZT+MdhOeJbRLKHfA
         8hGRiFicQb1NAu+giaOIh07ii3sSN3twWuhwcJyVp6tQLHAIYKZM+zAU902d2O2phYjx
         7UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960958; x=1709565758;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onsSHtOKzEIZICx5NzIaNglbxD6fxTitMyvZQ+hIAqU=;
        b=Ot/DbcsHWRFuXUBcIMEDUthTYETg3S7bNNYCrMIcvNpfuPJiQxI07Cdle/EgmfwqBp
         viyanEJ452YsiZ2Q6DWsQh9pdShoZ3t4Hj/IXy6fKiP/zaC/Qj+tbFEFeRcwf9ndBab3
         98hJdQTamMVpvvQ54q10U7zdSrwhK9NUKxj6NA+S8fcq2cbe9X8B3KzROJZWodaWvZdn
         JkzNLWhtq8XWQMC/waYP68n8YA4HX3qzrEl7k7ftvgMQZVJV8f2oM3MA1pm2Za6dDqu5
         eQFAgE4rxQIl5svoObodsqQmQn6mAVWpP6veKicSspn2T+wiFLQUhGR1/fQ46DFPEwBR
         KePA==
X-Forwarded-Encrypted: i=1; AJvYcCVVoavy6fnOpAATU3Zf/j9QAmhJbDPxhkyIKptzoROmS8caHyU6xNVbv/SsWxtwPZ2aZrxMOvy3NmqsukaZFAPtU3bWzxUT9BmnlCIV
X-Gm-Message-State: AOJu0YxIWnzxn5KU+2wRTV1J8DJw8QW0RcZ+aaChOBNKZ31vYAco0daF
	HuSQhNqVY47kOzBd8pDgTGEeDn/chJn6aUWmmrH1rmblOTnt/KBZYVC2+zry59I=
X-Google-Smtp-Source: AGHT+IHmIAE28QIf+BOgjzS1zi4WvdZf+4TEqP7lmYyZmGNVY7QdJSt90PHhdVd7cN8dHnYUh/tiRg==
X-Received: by 2002:adf:cc91:0:b0:33d:46b6:395b with SMTP id p17-20020adfcc91000000b0033d46b6395bmr4861177wrj.7.1708960957695;
        Mon, 26 Feb 2024 07:22:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b0033d73e1505bsm8687383wrb.18.2024.02.26.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:22:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 26 Feb 2024 16:22:36 +0100
Subject: [PATCH] phy: qcom: qmp-combo: fix sm8650 voltage swing table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-topic-sm8650-upstream-combo-phy-swing-update-v1-1-08707ebca92a@linaro.org>
X-B4-Tracking: v=1; b=H4sIALus3GUC/x2NSQrDMAwAvxJ0rsAxzkK/UnpwbDXRwQuW04WQv
 8f0OAzMHCBUmATu3QGF3iycYoP+1oHbbFwJ2TcGrbRRWo9YU2aHEuZxULhnqYVsQJfCkjBvP5Q
 Px7UJbyuh6Rc76dlMyjtoyVzoxd//7vE8zwsAV5SofgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=37wQmO+YdaEsa3xL7Q6rKO9ox5eQT6E5utt65Fi0uWE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl3Ky8MrhetOzd/dgn1AZoOgkWz4JjSAOJRRohsEox
 zH+aA8CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZdysvAAKCRB33NvayMhJ0XvsEA
 Ci9Nb/Lc28Ri7tvyVr3ZqwThwYr/pTkkgAMKkiA/vmAc0zcpefA/hoWPMmyUnCH3M23irg11jFIITH
 9iHaokAjzj7XniUL2vqOvwb5+TtZsRjCvJPOjL+XHHPCivmtDDJTC0p0biANppJjmUHwQOc964Mt+x
 hm1Yirt4Q3sqlgZEq/djlV7zd+2qB3mv35tQfEs5+8FbMUNgtD6YqZDUxwdGc9sZrknECYE5/y/oC4
 rV+kWH32K1FSWscWykvM9mGUxdN3lAImUVqZBqmObdWZN3/MOGUBdQnurMd5TKfETxE9DTlHLH/8fl
 i6YkbKmFHABfDxy9nlpaCuohzoBtbkbEBGvH9tXVwKPawQ3fko45Y6314QxtHjcudlwzwVmHDy2IxV
 CTag5bSdAs+F1twLcsz351vaZGCEdMp7dYggFCRmTUa+pepIGfI3jbnfg82yJDsom7wmT4RHcfPeRE
 YIpLjW1iRIP91ydrHJ66gVpMEYiRHQs3CQopmOSNoxSWDj6lQXYWpuQiNer4f+ldkMtmbL6FOEomMG
 tVSQG245OaPB6eULzyCd8YWf2rathd+tnoe0G3phzlGGeBRrVXGfXABhzxeKpLRVkamvlXTOi39rY8
 Py4TE3eKnodh78TFCtJcL6zbtM13EI/USVy3tXplexWm726bcqGBwXVXOFdA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP PHY found in the SM8650 SoC requires a slighly
different Voltage Swing table for HBR/RBR link speeds.

Add a new hbr/rbr voltage switch table named "v6" used in a new
sm8650 qmp_phy_cfg struct replacing the sm8550 fallback used for
the sm8650 compatible.

Fixes: 80c1afe8c5fe ("phy: qcom: qmp-combo: add QMP USB3/DP PHY tables for SM8650")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 ++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 546d3c6bee32..66991886da87 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1377,6 +1377,13 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x3f, 0xff, 0xff, 0xff }
 };
 
+static const u8 qmp_dp_v6_voltage_swing_hbr_rbr[4][4] = {
+	{ 0x27, 0x2f, 0x36, 0x3f },
+	{ 0x31, 0x3e, 0x3f, 0xff },
+	{ 0x36, 0x3f, 0xff, 0xff },
+	{ 0x3f, 0xff, 0xff, 0xff }
+};
+
 static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x20, 0x2d, 0x34, 0x3a },
 	{ 0x20, 0x2e, 0x35, 0xff },
@@ -1996,6 +2003,51 @@ static const struct qmp_phy_cfg sm8550_usb3dpphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 };
 
+static const struct qmp_phy_cfg sm8650_usb3dpphy_cfg = {
+	.offsets		= &qmp_combo_offsets_v3,
+
+	.serdes_tbl		= sm8550_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8550_usb3_serdes_tbl),
+	.tx_tbl			= sm8550_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8550_usb3_tx_tbl),
+	.rx_tbl			= sm8550_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8550_usb3_rx_tbl),
+	.pcs_tbl		= sm8550_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8550_usb3_pcs_tbl),
+	.pcs_usb_tbl		= sm8550_usb3_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8550_usb3_pcs_usb_tbl),
+
+	.dp_serdes_tbl		= qmp_v6_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v6_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v6_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v6_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v6_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v6_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v6_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr3),
+
+	.swing_hbr_rbr		= &qmp_dp_v6_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v6_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
+
+	.dp_aux_init		= qmp_v4_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v4_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
+
+	.regs			= qmp_v6_usb3phy_regs_layout,
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+};
+
 static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -3625,7 +3677,7 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 	},
 	{
 		.compatible = "qcom,sm8650-qmp-usb3-dp-phy",
-		.data = &sm8550_usb3dpphy_cfg,
+		.data = &sm8650_usb3dpphy_cfg,
 	},
 	{
 		.compatible = "qcom,x1e80100-qmp-usb3-dp-phy",

---
base-commit: 8552c902efe7ef670b6961fb8885b67961aeb629
change-id: 20240226-topic-sm8650-upstream-combo-phy-swing-update-41ba728470dc

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


