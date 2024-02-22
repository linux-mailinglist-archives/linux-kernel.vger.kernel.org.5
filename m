Return-Path: <linux-kernel+bounces-76964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841985FF24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62C91F2C45A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC388159568;
	Thu, 22 Feb 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PudsjMuV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F9157E9B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622238; cv=none; b=HvynjzocHK0jj4EkPC4Rk35K2CCJcQIbDMfPZ5RsePrn1nzcpqpP8EmCoSIJ4ImPoa9UbvI61TPbcyFSGZNnVN7TDfLba4RudhYYu0JWJ8+zNcIHV0NFEH71vx8gZJf0Sh8poAAMr0oBzjHYk8ja9y/R4x3nPeWSkiE8sfe/WYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622238; c=relaxed/simple;
	bh=UqVawexoXcAUNjwQgThum7xtct1LHK27SiESG7oajqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f437xuycC5XrI4yGcMmkrswrTP+Uje9kK5otjsMwyKjUH4VUzpxLuUhIg28qkeehI91RSkJOySuReaLaLtB5hyndVp1BFOT6X9ZbAK575Ji+WDe7sU4opJD8J8Dv+V/asM26vsn5mQe1YjSpfcJzOenDV8v90Gq4+Sqv/vQOb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PudsjMuV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41282be73e7so7279505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708622234; x=1709227034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXl97YK3+0rCThc5an+WREKX5C7QOu/wAYiVjW1hlOk=;
        b=PudsjMuVpEbyX8N47ZXyITQdzqq5N/f+vP3x+GLq0EGI/H+HWldB04JRiSlyOsi4tE
         /ds1RKvD9Pm/KUT23exLAow7DGWarVtzpz/Wst8dmiGOimF9W9a5gzvS9e0BQHWy1M37
         mVBQT00ZtIEq4jGaO8r/Q0zn4O7fxZ1LvhvZYUqSuM1CG9KvqkIzKhDuYx7nLlt2F88v
         rNU/F3wjDMxAB3tfEzkXwjEWooHsFypQeS0KMx4dR/UbEaRI0wYVN2mmRkzJUBiTtIaC
         rpsuZnKNTsaKcc3Lq/Ec8eKRIdJLcxfS1O9sPRYAtqOceWapQgQM0rBszqVJwxMHJfUa
         3HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622234; x=1709227034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXl97YK3+0rCThc5an+WREKX5C7QOu/wAYiVjW1hlOk=;
        b=Js5vQcEpA42X1bYz5KW6uuXrM7DSu6Zxd73OiMO4OADH37g+73pQF3VDuvT2KdEFZu
         A81RyZtcLHnN/MVrIQ+6mDFa4myKWzWsKXN50MSSRr0StkExZv2AOhl1f6ZVUTUHR0fT
         7dEEEnumaQDlgLwRMhJeFxP460yDvSyhq3aOYsZU/URogtfzgZrZg3xWZtAZhwZwLnu/
         7Ph0xS+gf0V5y2urXAU+IMEP19TocmWX/b9xNm1SQrmGkUmUOA+AGYQ+LTGl4O+h3DL9
         IrR18McBob0o+r2PXwmVPmTfyA5nQGxdBFbOrPAa/cysB5sGEJsLTPC9pr3KyCQEYJ4D
         OtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4t3OzB4rookgb6d6n9djJyCnygaRVX4tKfM2V5UDFufPOvLggVmXmdxg+KAoJD3lWd4m7VI6LMZ7hdZyVkrpCpxQYMs5PyR1ekSYU
X-Gm-Message-State: AOJu0YzEI8AhlhcLoZzt0wdzIcTvpCC1IhuBipumGnb3ERClrNKsnGjm
	zFy8dSNcs9Aw3DKiRHRuzgkpzUlCqIKxtSTopmNErHgzXuSVsfnrc4HzC0X0h4M=
X-Google-Smtp-Source: AGHT+IEbWME5JZZSPL/evAFLw0AcaVWXfZvcRXo8iGg5J7VZ7izp0ZxzS2rcZNN5Q1ndOdIwDLiAUw==
X-Received: by 2002:a05:600c:4503:b0:411:ae8e:5945 with SMTP id t3-20020a05600c450300b00411ae8e5945mr15360251wmo.36.1708622233882;
        Thu, 22 Feb 2024 09:17:13 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b0040fe4b733f4sm6656512wmc.26.2024.02.22.09.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:17:13 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 22 Feb 2024 17:17:03 +0000
Subject: [PATCH v6 5/6] media: qcom: camss: Add sc8280xp support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-b4-camss-sc8280xp-v6-5-0e0e6a2f8962@linaro.org>
References: <20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org>
In-Reply-To: <20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org>
To: hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org, 
 matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

Add in functional logic throughout the code to support the sc8280xp.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 23 +++++++++++++++++---
 drivers/media/platform/qcom/camss/camss-csiphy.c   |  1 +
 drivers/media/platform/qcom/camss/camss-vfe.c      | 25 +++++++++++++++++-----
 drivers/media/platform/qcom/camss/camss-video.c    |  1 +
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 66ff48aeab64..df7e93a5a4f6 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -513,6 +513,10 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
 		r = &lane_regs_sm8250[0][0];
 		array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
 		break;
+	case CAMSS_8280XP:
+		r = &lane_regs_sc8280xp[0][0];
+		array_size = ARRAY_SIZE(lane_regs_sc8280xp[0]);
+		break;
 	default:
 		WARN(1, "unknown cspi version\n");
 		return;
@@ -548,13 +552,26 @@ static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
 	return lane_mask;
 }
 
+static bool csiphy_is_gen2(u32 version)
+{
+	bool ret = false;
+
+	switch (version) {
+	case CAMSS_845:
+	case CAMSS_8250:
+	case CAMSS_8280XP:
+		ret = true;
+		break;
+	}
+
+	return ret;
+}
+
 static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 				struct csiphy_config *cfg,
 				s64 link_freq, u8 lane_mask)
 {
 	struct csiphy_lanes_cfg *c = &cfg->csi2->lane_cfg;
-	bool is_gen2 = (csiphy->camss->res->version == CAMSS_845 ||
-			csiphy->camss->res->version == CAMSS_8250);
 	u8 settle_cnt;
 	u8 val;
 	int i;
@@ -576,7 +593,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 	val = 0x00;
 	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(0));
 
-	if (is_gen2)
+	if (csiphy_is_gen2(csiphy->camss->res->version))
 		csiphy_gen2_config_lanes(csiphy, settle_cnt);
 	else
 		csiphy_gen1_config_lanes(csiphy, cfg, settle_cnt);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 264c99efeae8..45b3a8e5dea4 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -578,6 +578,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		break;
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
 		break;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 2062be668f49..d875237cf244 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -225,6 +225,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_660:
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -1518,6 +1519,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 			break;
 		case CAMSS_845:
 		case CAMSS_8250:
+		case CAMSS_8280XP:
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
 			break;
@@ -1595,6 +1597,23 @@ static const struct media_entity_operations vfe_media_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static int vfe_bpl_align(struct vfe_device *vfe)
+{
+	int ret = 8;
+
+	switch (vfe->camss->res->version) {
+	case CAMSS_845:
+	case CAMSS_8250:
+	case CAMSS_8280XP:
+		ret = 16;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 /*
  * msm_vfe_register_entities - Register subdev node for VFE module
  * @vfe: VFE device
@@ -1661,11 +1680,7 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 		}
 
 		video_out->ops = &vfe->video_ops;
-		if (vfe->camss->res->version == CAMSS_845 ||
-		    vfe->camss->res->version == CAMSS_8250)
-			video_out->bpl_alignment = 16;
-		else
-			video_out->bpl_alignment = 8;
+		video_out->bpl_alignment = vfe_bpl_align(vfe);
 		video_out->line_based = 0;
 		if (i == VFE_LINE_PIX) {
 			video_out->bpl_alignment = 16;
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index a89da5ef4710..54cd82f74115 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -1028,6 +1028,7 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 		break;
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		video->formats = formats_rdi_845;
 		video->nformats = ARRAY_SIZE(formats_rdi_845);
 		break;

-- 
2.43.0


