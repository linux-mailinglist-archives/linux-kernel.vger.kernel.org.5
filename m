Return-Path: <linux-kernel+bounces-32132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A68356EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF8628130B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5139AC3;
	Sun, 21 Jan 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aup/fFS3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301638DEF;
	Sun, 21 Jan 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856365; cv=none; b=YGfxg54diaxu1ZAVuwtxAxNk3zFWbNi4Z9NxNkgpCa5xL0bQ9P4CTj3a4eMsTvpv2hCJZZGTHdeREVWQiRULgoOwzZ7tN932Eujs0SmgoReMQDNeSGpsl0ym3ibyEhacdpmjXD4ZXLfSoXJmht90hnV+1WR9qu9J4kQP8qEVLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856365; c=relaxed/simple;
	bh=8+nVfXj0pK+UjGyYY9L8MCyBz+TFFNaW6LNlpt4ylqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMIF6lRw26/DIiQnYvizgkmvaVmqD87H5X7unCuB+y3jAuuJoFvQkx9kjoVtjBSkDe1MdYs8rNBVqAhJtZyU2cvQpZop3N2VaoMgOKRUSNwODzx9Ar20SGTsVQbCyFgFE5RSGmncSzMcyDSayQljFflX9Qt1+egDf1pMEJjZ888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aup/fFS3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so2182005f8f.2;
        Sun, 21 Jan 2024 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856361; x=1706461161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+6WENXvJzBB49YV3y2BUzN0W4hKGmw5Xn61RrMIgRs=;
        b=aup/fFS3Y4w8TthsRFKNqL27UHQ9/LgKbWpfMiKMvlLtrFad5NAkpn6tGVkQai7RBn
         w11sQ9CVhFc+QFTFL/VMHEA52D22OQXJ2Z6RjqkRK05NKbPZ30FDKAanWVFayFHcW4Jd
         UF/JUGgtXkJHPaQNYGLH0cuci2IahDAWS6Wt0+mMabAQHILP6Yux/hO68cKgwQXVgghp
         +hW2FbgCc6guHut2wp/sgi20yD/cKPBbAg9hQDxxaqpO75RM8T+dLcnaeEgesCPbO2e3
         MSOOPCttD0eF0G0dUW8a+Cm6KqQ0EZ20WrM0+Kwur+K8M1L6vfWbKwKqRX7ULK/p9TCa
         zcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856361; x=1706461161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+6WENXvJzBB49YV3y2BUzN0W4hKGmw5Xn61RrMIgRs=;
        b=HeT44XzeFYtk9BGN2slyFxNmj0ERMjJxfMwivVt3qt3ZvXEyz3stI/3o/d2rKjUR79
         N9TaZPU92kG1lb2dzmzyco1OMZfdMv59+62JNRT5sAZkK0WIL1X8rEbiWcj+tAVu90xf
         jSqjDjQYdypq3niMQXQTJOupnSDeczhjJ8derOgLdikUePcDvGocRmw9/gZS6ewkVe14
         uS92Q2WeBjFDi4G9mvVNtIPlLhd0f2BMAJccuKApuDIlPf8vA4Cl/cInvuG/vLSWeMbu
         XifXS5sd4Rq4xnH4r3Jjx2eHD+HeP32HrnB5yO6UChLB1XBKjWbF/BlH7LPkHD8wScBK
         ktvw==
X-Gm-Message-State: AOJu0YwHCAytBxn1HACUPKhgf91JUSqN96VqlMWdkBhbIWw9moKY+uHG
	5gOhXxHrQi/WFF135D41hTM+K3e7TDsTorea98IOqcwdd9qxSxwH
X-Google-Smtp-Source: AGHT+IGKDLspvXbJOtsgxvDfAuNqgIbRDm7R7ElQMadvYLL94yJb/D6uXw5FOYyFeAiMNtop26bL1Q==
X-Received: by 2002:adf:ea88:0:b0:337:d649:da82 with SMTP id s8-20020adfea88000000b00337d649da82mr1495551wrm.101.1705856360907;
        Sun, 21 Jan 2024 08:59:20 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:20 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:45 +0100
Subject: [PATCH v4 5/8] phy: qcom: qmp-ufs: Add SC7180 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-5-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=882;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=8+nVfXj0pK+UjGyYY9L8MCyBz+TFFNaW6LNlpt4ylqk=;
 b=kfHyJ/tjpR2+eR1yN56hNm0nYVS3p8pzrA69vt9HClWzleBmTA8xfzM1UGjRKCjNUZ3gJoXeK
 xrtY34kSzyyAqbfw/wsmQQZWdSqyTCxxbx2lA4kyLhZ2PefdBtNDzaa
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

The SC7180 UFS PHY is identical to the one found on SM7150. Add a
compatible for it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 3c2e6255e26f..0276de802d78 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1880,6 +1880,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sa8775p-qmp-ufs-phy",
 		.data = &sa8775p_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc7180-qmp-ufs-phy",
+		.data = &sm7150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc7280-qmp-ufs-phy",
 		.data = &sc7280_ufsphy_cfg,

-- 
2.43.0


