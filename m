Return-Path: <linux-kernel+bounces-76960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1918A85FF11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F91C2433D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247B15697F;
	Thu, 22 Feb 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFuD7z2u"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA0156973
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622233; cv=none; b=ZHNLfUc0sQWlpuFYIQcXUcYvxmOi631Q3bsPrwrZQe9QAAUeu2b7lllM955nTRyaqbaTYdSC26rqKtpY7FcVYMjkgdALFB7rf5xadDd5SHFi7jCmwZZzHEfnOtfdNaV/9sTuBVq+zvESUxr+aD+dxbvTrUxx6pv0twma+FfR2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622233; c=relaxed/simple;
	bh=cLQhxeY5m7+f1sIIazN76vqrdMg9gAn2ab23CTCOFLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0JketaxBSGnVBkXzqCSu7DVuJ5OP9Q96fVEi74joBg/XSoWet7/sf+Apqyn1fI+vAp2LjbmSr9CRzG2gsiKW9DkNoqaSHf4gazvIaDqXan3TreGnncgOKMiYga0THG3S+RrASTVL5TeBga5puWLLqwqjVmYyjhQa/QY1ilnrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFuD7z2u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4128e15d5e5so3367575e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708622229; x=1709227029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE3IgGShX6BtBbQgPX7VSpK+DdgLAt84LQ8LG1/M94M=;
        b=RFuD7z2u5tgxLppgNmS9XKVdIMpAIYKHTgGWjiu6kvNNWlYHFBI/xDA++tT1M64skD
         bnKCasiOi+s8oftCOVtFyUY72ntGACgxv12OJSdHlVqjO05PhDE4JHZ0EB5GvZTg0nO3
         Lp2fUMHkWJdjpAFuZ7JGDIdGUI5UQALUTn66K50KXL0s6wfZmwscyJdPEJY/a5wkxFYD
         g9iza1zyFKoWEYVW5+X4+v9+nsVNiSb7eD+QY6SZZCwGVqdJXXiAAd/Pq5uYuKtGr2R8
         rqQsvMvgy4ADE+XwiFLkHvXf2hLoKExEmk7c5qmpdyi+Nl0sjJ0nxRMGu/0+lod74dNB
         p6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622229; x=1709227029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE3IgGShX6BtBbQgPX7VSpK+DdgLAt84LQ8LG1/M94M=;
        b=K/uf8WySKv5X7nOsFL1hHTAk5YajFWVY9lyJeLpwRLwuRpN9lzcXtz+HA2mCYOoQPa
         MJp+GGomJ//uPATDXxh2HQ6/VhtdC01xv7prVfMef3ozUI7vLJBy2C3RhAaq3hjEF4ox
         ZFb10GJt/vsJpMTBWGCDkGe09jKsTJzXKQ/b2jF68PcXXF5blecfI7SXD2RqNLizgmm+
         b6AIjh4wWUo9zBYqjkyey31GZ6O46GE+QxkgIkm35vc0ChfpIEhtMJ8zjUOE2Y/6pGLl
         b/13LOUIiIirE2cOwgbetd0hYM9j0dBNXxZcjXByvGa1Jo9hBemnlapWDAl40uuIrNMV
         X8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXnq/nyUDAkl3GwAec+cUBYx0COm9ovk3Fwz05Jt1KgC5Ru8/IejeQi+Hy6yoh5mirWMuROeRBnKqM6lT7f4iQb3ag5UpUsbLNCRdHI
X-Gm-Message-State: AOJu0YwZ0I1V6d/kSEyNdnYA7kiJmaL5IHnqag/ip3EJkIUxqfkdi8uy
	IOOxZ1yo6Gq6HGELqv6WAI2opYGL8FsOWRYGF3CdwVkyK+jjFjDndBbajY/r1h4=
X-Google-Smtp-Source: AGHT+IFbTz/XpdtoxtvZQd91lOC7Nv8YD1kxhxHbJjScPmxqq8yXWpi3TV/Ty/eXVmByflk1peWlEA==
X-Received: by 2002:a05:600c:19cf:b0:412:5e41:6f35 with SMTP id u15-20020a05600c19cf00b004125e416f35mr10610610wmq.10.1708622229279;
        Thu, 22 Feb 2024 09:17:09 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b0040fe4b733f4sm6656512wmc.26.2024.02.22.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:17:08 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 22 Feb 2024 17:17:00 +0000
Subject: [PATCH v6 2/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-b4-camss-sc8280xp-v6-2-0e0e6a2f8962@linaro.org>
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
2.43.0


