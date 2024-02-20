Return-Path: <linux-kernel+bounces-73780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E485CB28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE51C21486
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3A154BF9;
	Tue, 20 Feb 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZqhGiNI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E997154436
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469449; cv=none; b=fJE+3Alux8M8yU6984PbiOyXIPtYnJBc+x3jgXJFLkPyNAejWJ+O2owvq32RBPbRaXq/Ee7f6YS4DKS4R4c05qfEeL32Pjh6Fc89MmFBkrngWaXO2YJ3/XZP8CUfct6jkikRGQoAM+3NvM+IT42aeAlsTSHj/hpdu8Nl9mwhqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469449; c=relaxed/simple;
	bh=xokivPWqt+OPrUy3qaqKvKtZ107TpFIVR/LoscCcyTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoJ/vJoYkFwU7BWhZVjsVUrLcG/OwhjEPIM4mGfc7Rx6KjxynGCEm+acmGy1kXzE5cnIHVTl2C8uAYM2nhLsZoJkwO32IUWWial1O2TLM8dWnZwp+24Kz580v1XEokH6EA+jbu2CnPPWPbz8SXOM81Y/g3WKyjqPg+fkSqsS37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZqhGiNI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso6623229a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469445; x=1709074245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAclynvLiJs4xc4X+n+IF6izOuxUCTeBxe7d9onfU9o=;
        b=eZqhGiNI3GLeNjqn5J3rsAzWvPZSJkuNmgw0PDB34LNiESTfsJ8iqoT+1iVXLy5P8g
         NwZEVkCHkhpPeDLFAD7UlSvH/L7w3tdE8h47L2heHxqhZtm8nRcMW4S+2k7JFGexEbzR
         DwH6HKV6gTe8u0UxUcBW8/oz91WxojjPoSSLUoC943vV02STARfBpHlw6LX1gAAvxkmJ
         MHrxXis3QMcmislpPFFqMKICqfNCO5JAtcHYQCnBTM06LhBk4FZLDpKTu1dLh6SqG4NG
         l1jP8dr1J/SY1YUDRuPMyBJUNzlqOLigtUErBUELrnx+o2npj8Ebr5RwIbDAYZP7e2iw
         nmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469445; x=1709074245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAclynvLiJs4xc4X+n+IF6izOuxUCTeBxe7d9onfU9o=;
        b=gAZpuPbMxsNk2FBc5zQPTmb7hdNafTc+kJsQqG0tTfpTIorfbXja8v3FCAdstRf26U
         lPYH6z6T4nLF5f+svYpg9Ykaz87TGVz3eSFoTh4WsKu13E7BFK4d3scdJMkFSjQnEUzB
         BVO8km/O5jD4b2x13EuL/4rBiAR4xFjhF6Q7CwFagvoU2RWIu0I0/YTlYQBwMZBchbXz
         uDiAPKVkP4lDKHG+Id9iQ+x2sLugckm2Yo05CfAovHjvF7VOQXSeCiE6kghspr5CQwrF
         GL7qqErMzUxsSJn93JUDgw+9olvQrF/4IPP9gQapBlUjGrPw7cLLWi/Rg90cdDMMYp93
         c3ow==
X-Forwarded-Encrypted: i=1; AJvYcCUJrv6qCYwvjvq958izfHnpJBcLAs2sMXddrQA2u8Vc4n81wUm76c3RjmCyBp9GkiY4B7OvE1/rGPkS0V7z9XrlP/pHpyMt5wcg8WXk
X-Gm-Message-State: AOJu0Yy2vTFCzq0zPR2v8g/hmhXmrSPht9DONjJced+Ns7MRol2trjAF
	JAD4NsTRISHhasBBb8V0+xohjrXKmg12cQbqHjdZ0l6Rzpclkuvi0Vn5OXvaitQ=
X-Google-Smtp-Source: AGHT+IGtp0ljYvl5+RLa6/+qPwzEM9IDl282QnpAQGsoIKzGC77aR/4ftcoFDAa2yPikOtd4CbjY7Q==
X-Received: by 2002:a17:906:4544:b0:a3e:71fb:348e with SMTP id s4-20020a170906454400b00a3e71fb348emr5267043ejq.63.1708469445643;
        Tue, 20 Feb 2024 14:50:45 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906c18300b00a3ed811cff9sm1601977ejz.154.2024.02.20.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:50:45 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 00:50:32 +0200
Subject: [PATCH RFC 2/3] drm/msm/dp: Add support for setting the eDP mode
 from devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-x1e80100-display-refactor-connector-v1-2-86c0e1ebd5ec@linaro.org>
References: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
In-Reply-To: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=xokivPWqt+OPrUy3qaqKvKtZ107TpFIVR/LoscCcyTU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1Sy+36STHspnFcIKJqXRYK9pPMBNFXIGIP+1/
 MxB9l2APl+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUsvgAKCRAbX0TJAJUV
 VrQzD/9TWhF8Cm+XOQatc5eOGqEMLDijupKbH+5yJAXa0+SjGXbltXHyJpU3H5HgljlqnreFIUA
 zJzgtspF3aAFY2EiTIuTkEGwnNC7Wjzd44H63+eMO0ml8/ncRTODjqn3hcIUPdN3e3+0CrDHQNv
 IN/k4SPTpjGy94WufMiCYDwoop9dNBpkOTkk8+qasUsAjSUBM+iZ3NKIC9aG5Ns7I/NRRfIY1vs
 AJXySPU9SEndP+Cl12ZeBwixyWDWi4yAjvmIqOIWhAeWGxcerHv6l8iFZYN+LbHtOae/6MofMS2
 0EXFoM2XbpVIageIxJ+LCrkkC/ocD785ukY0il7aSsA1OE3YXPkqMaBOhvfyPQ2HHuMsoTqdazu
 qml1fdH58bvkvPvqwykJui2pGF4pqvHxEwOqQYcdZLMKUWkGD72Aq+v6+TWI6x3y/Tcq7scoZnT
 LY9945Fx8rF1aNWGVkliJx5jjgo6d1Ll0x8iM+Zms8nD90/CKmvkT0ltMkFfNH9K35iVxoaYFXH
 Tnd72VrK10hS7oKaQVf3TazP6aUXjSrr19LeC6LoTgJ+jYYtnbLU+F8oskievQHZeCbjlKfziDo
 cc4AMrCSaX09jC7bdtMaFmKFD0cPKX1xPBTisWXPGa9ENV45TkqsjoQY7Sk5BbAakGkoG3DRmrA
 b3CxU0M6AJb4+vw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Instead of relying on different compatibles for eDP and DP, use
the is-edp property from DT to figure out the connector type and
then pass on that information to the PHY.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 11 +++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 19 ++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 320f17fce9a6..bd81cc6bd5e3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1533,6 +1533,17 @@ void dp_ctrl_set_psr(struct dp_ctrl *dp_ctrl, bool enter)
 	}
 }
 
+int dp_ctrl_phy_set_mode(struct dp_ctrl *dp_ctrl, int submode)
+{
+	struct dp_ctrl_private *ctrl;
+	struct phy *phy;
+
+	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
+	phy = ctrl->phy;
+
+	return phy_set_mode_ext(phy, PHY_MODE_DP, submode);
+}
+
 void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
 {
 	struct dp_ctrl_private *ctrl;
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index fa014cee7e21..a10d1b19d172 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -32,6 +32,7 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 			struct phy *phy);
 
 void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable);
+int dp_ctrl_phy_set_mode(struct dp_ctrl *dp_ctrl, int mode);
 void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_irq_phy_exit(struct dp_ctrl *dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e4433891becb..9e58285d4ec6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1229,6 +1229,7 @@ static int dp_display_probe(struct platform_device *pdev)
 	int rc = 0;
 	struct dp_display_private *dp;
 	const struct msm_dp_desc *desc;
+	bool is_edp = false;
 
 	if (!pdev || !pdev->dev.of_node) {
 		DRM_ERROR("pdev not found\n");
@@ -1243,13 +1244,19 @@ static int dp_display_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
+	if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP ||
+	    of_property_read_bool(pdev->dev.of_node, "is-edp"))
+		is_edp = true;
+
+	dp->dp_display.is_edp = is_edp;
 	dp->dp_display.pdev = pdev;
 	dp->name = "drm_dp";
 	dp->id = desc->id;
-	dp->dp_display.connector_type = desc->connector_type;
 	dp->wide_bus_en = desc->wide_bus_en;
-	dp->dp_display.is_edp =
-		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
+
+	dp->dp_display.connector_type = is_edp ?
+					DRM_MODE_CONNECTOR_eDP :
+					DRM_MODE_CONNECTOR_DisplayPort;
 
 	rc = dp_init_sub_modules(dp);
 	if (rc) {
@@ -1257,6 +1264,12 @@ static int dp_display_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
+	rc = dp_ctrl_phy_set_mode(dp->ctrl, is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
+	if (rc) {
+		DRM_ERROR("setting PHY submode failed\n");
+		goto err;
+	}
+
 	/* setup event q */
 	mutex_init(&dp->event_mutex);
 	init_waitqueue_head(&dp->event_q);

-- 
2.34.1


