Return-Path: <linux-kernel+bounces-24023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753382B58A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06C428A5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE756B8E;
	Thu, 11 Jan 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stPan0EA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39056754
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367601a301so4959616f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705003024; x=1705607824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hARQAQOLcSzjwOPYvs4BLOOY/nQZprU58P/GDXDBCPs=;
        b=stPan0EAHPqgzz1Cpx+gYdnDp30PfCLG1c87lKQSgDhTJA8ielZlsgLgA+HfBH6IiG
         z00NYlxPH59bSE2MxPVdgpDbEdd7y5fFccMU+B3AOtah57F+Um97sz2jSzohopy+6D7f
         +P8bQO5B/4KeV8bMHCsTlZe55uRBRSoHiYBIxf12Ju8WGTqDBB536qxH8VWSey/OBcfY
         CeXFJ3ciT8AIq4Pm6rGUM4uAzAbaC8KGS4/ewzPtuLz3IHucsdSn/xDWEF8Poi69nKJe
         d5CvF/66EHau12lmF9NRFDe4pEgJg0W3E/Mpo46NWeJ0xVBmFEpKH73+S+Y7RDAYHU1p
         brtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003024; x=1705607824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hARQAQOLcSzjwOPYvs4BLOOY/nQZprU58P/GDXDBCPs=;
        b=Gy29BC2+Pw1uX5Cvq6UuCmYplNkOjeQXXr0rvDRT75ZovFZ64oWeE2+xNIseNR1jPg
         3LEFvwxdDnO0Lcr1cOAXy6yx1VfmPUgKwTFi8wo9ciZqoIZLethHO8DtJ620EHC8B7Zd
         G7ZRtfnvjIPFF3fVB8lpIV2AFEUqwhL0OwUFMsvOAZ/YOa4KdrotLrrjd1GB1/cldZkh
         +F91t25YDj6SJxUrgjxtQ7W1ifb2gHgrNEW2RgF0ViSATbXTJz/2XanuAB5oF6et89pP
         DJgjEHgNHz64elYThLqXEc6WGD7qtURa7W4kKkkhSq7XCDnMN2FDw2BWX6cVZC8zDzWP
         qpPA==
X-Gm-Message-State: AOJu0Yyi6i0N+caRXuvCPzP1mYiaCPOV32bgHpnotbZ3I1RDBHG/AYJO
	eSi1jemSOl1u+Jdu0tyusQ7iuPkN5Tb8+zVO/YFf+5LkLLHPVw==
X-Google-Smtp-Source: AGHT+IFL96e41K600fJJGUs5F1vtnJGv3lVq4s6iPMdPh4ieOBC2qO+nj0jDH5zlPmNgCaxRsYbrVg==
X-Received: by 2002:a05:6000:8c:b0:337:7680:885b with SMTP id m12-20020a056000008c00b003377680885bmr107073wrx.38.1705003024452;
        Thu, 11 Jan 2024 11:57:04 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm1955382wrn.63.2024.01.11.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:57:04 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jan 2024 19:57:02 +0000
Subject: [PATCH 1/5] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-1-b92a650121ba@linaro.org>
References: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
In-Reply-To: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
Gen 2 version 1.1 CSI-2 PHY.

The PHY can be configured as two phase or three phase in C-PHY or D-PHY
mode. This configuration supports two-phase D-PHY mode.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index f50e2235c37f..66ff48aeab64 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -148,6 +148,91 @@ csiphy_reg_t lane_regs_sdm845[5][14] = {
 	},
 };
 
+/* GEN2 1.1 2PH */
+static const struct
+csiphy_reg_t lane_regs_sc8280xp[5][14] = {
+	{
+		{0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x002C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0034, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x001C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0014, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0028, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x003C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0000, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0008, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x000C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0010, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0038, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0060, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0064, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0704, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x072C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0734, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x071C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0714, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0728, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x073C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0700, 0x80, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0708, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x070C, 0xA5, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0710, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0738, 0x1F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0760, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0764, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0204, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x022C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0234, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x021C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0214, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0228, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x023C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0200, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0208, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x020C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0210, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0238, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0260, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0264, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0404, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x042C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0434, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x041C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0414, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0428, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x043C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0400, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0408, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x040C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0410, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0438, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0460, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0464, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0604, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x062C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0634, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x061C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0614, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0628, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x063C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0600, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0608, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x060C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0610, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0638, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0660, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0664, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+};
+
 /* GEN2 1.2.1 2PH */
 static const struct
 csiphy_reg_t lane_regs_sm8250[5][20] = {

-- 
2.42.0


