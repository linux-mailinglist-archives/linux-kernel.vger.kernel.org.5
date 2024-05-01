Return-Path: <linux-kernel+bounces-165557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39B8B8DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185E01C20C96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE57130AD4;
	Wed,  1 May 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noiIre0C"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA59130488
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580386; cv=none; b=tBKJKkDDOT2UP6KKXthpUSUk06aYFQk2cHZNjGjBf8toIAKK6QPtV9zsUdqfGimcGvQMOduidexxLD6gdY0SIi75Q1tBRdjKwaIsC6yPUPvNAp/zBSZUJGYkZotXUsoCL5YpILtkfm6ncuumwThAkcso20djUtq7qwWpfhjD77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580386; c=relaxed/simple;
	bh=5Kn/Xp5aT6AU6VzISZGaeXF0Itj9GdwjhwxzVTTUE3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WisHKPtIp2rsLMT22/JuNU7mYvZNJYQgPW+Xl0y60a2UvccAKeueYD21tXELlqo6aCXVarWaLrrQ49O0MRBEDDauQnDWvEd83ngJyxkSYril1lpFIbB9sy1TAvEWhK5bfrA5rVHVdc0KtWBjufkXaWwWt2fd+EotnLENJiNi5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=noiIre0C; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so11819798e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714580382; x=1715185182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS7uXHBg97FEWIXT4Bv2Z1UzRhWVUsI51KDXVVeZ7No=;
        b=noiIre0CUH6nC3isZuWRyqn3NEBMoMTdmObHieUa840Ie+YB/b0YVLJXDMFAzq8CWC
         OsDqH0/QcKBCpV+EgZHAXzwmt+7SgT32WEXkIUAU3B+CIs66o6U+mMQq5XM4pij2NQw1
         fpNoGE8KRT8tG7QESJOXkv22rSeJ+y2mohdmrkjmd8rzMFqNWkWPysacOdhHzLjGNC1K
         Ws6Y/h32hSdfBgRK2s7P7lAOvZ06nZH098AB1ZC8do93mN3lWUCOnPpmE8ntyUpoA08W
         AN0K+x5NrY2NF1lIVK9/4eYfOeViXd6i6Lbo7uasc/AYAYoDwubinuZThybweQTlS9OX
         7epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580382; x=1715185182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS7uXHBg97FEWIXT4Bv2Z1UzRhWVUsI51KDXVVeZ7No=;
        b=eIzoHTWbMf3ndR9Z52aN5MnyV1L3nWnn2XmWSuwETZRQ0N3IGIYjhvcMZjH0zUArCW
         bOZloqjqY4azLiJhzMLWyDY5CndmmizTlGch0eVtWo+rNi45F1AyMXdiL402yBNaofzq
         zB7rH5xST6henCWjQKhDPtx4pftMBPBXWBGNehsPuWhvqqFR5VAy+nCLpGRyGTVS8edo
         PBkjts5d89X1KdoUwdDjtJ0DSgXGuj5EsVD/3GDxB6NmQjoiftK81DDxWYCPUMCeVQXJ
         jUGqJQwJQrHyMeDrte5VJqSl+H31paN1wBFroJMkY19tZzCePaBxlUWiv+zk9Nok++gi
         tP0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdBijZ5I9LG9OvtBSyISF4l0Tm0GffRDCUt2ItA71nOXC1IJQXEILvNnvzIEWJUA3MKyvT2iMY/LpOHBdDwLbfzfLFDfixzyfhERcy
X-Gm-Message-State: AOJu0YxMiq5Zbb8972lrpbyQOAVaM26WGjg1/ccTYlN1kPXcPt9c5nbk
	DtSHX+Ww/bVm0Ke+B7Z9k+tdEBWnaVbJgmLy04ogP8fcgSTPmwXpDP2/xxXz8e0=
X-Google-Smtp-Source: AGHT+IHOUpp0qpUkPb4uAi+MDjtYR+8QFYb6uaQRdhghuWRCMPDlkyU1X/O+WPQgGiFUFedU6jVu0A==
X-Received: by 2002:a05:6512:547:b0:51b:e707:74dd with SMTP id h7-20020a056512054700b0051be70774ddmr2402251lfl.33.1714580382667;
        Wed, 01 May 2024 09:19:42 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d30-20020a0565123d1e00b00516d0029383sm4909306lfv.28.2024.05.01.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:19:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 01 May 2024 19:19:28 +0300
Subject: [PATCH 02/13] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix
 msm899[68] power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-qcom-phy-fixes-v1-2-f1fd15c33fb3@linaro.org>
References: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
In-Reply-To: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 David Wronek <davidwronek@gmail.com>, Andy Gross <andy.gross@linaro.org>, 
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
 Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5Kn/Xp5aT6AU6VzISZGaeXF0Itj9GdwjhwxzVTTUE3w=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5pR9oypHnen8uYHvdjteSf5e0/N7fPO7+tmuZ8+ySeYq
 aWivW5LJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmkm7M/ldwyYkNpp8yOd66
 TPjf5nZvSmubMJfd/VD1lxPuTwiTk78hwy797UTizuO9x6+9k+zlzn78v2Vt/lPxItUJWe5GiqI
 MAcZpZ32NrkjdWa+dfjV+seUbSU6uVDXP5OaWzUHaczauCN3amP+lPD7a8uidSe8ZraO5C8W8y2
 77/L82tbVW6eq8bX9YJDizerOWz/y+2yCweLsUR5n8wmXvmjY8WW0jNCcgPeBZvI1b7uTTcfHVV
 2qFTQNfcUVMSousrD/4tkf1tlL3b/tTKTdfuJ3deWDtk9zW7rKbgVFTX3vMc5ac1xxb9/SDfoTC
 C8/FJZZWka1u51sXl4XKlZ4p66xdcJLJ4quAnXVhiKAFAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Qualcomm MSM8996 and MSM8998 platforms don't have separate power
domain for the UFS PHY. Replace required:power-domains with the
conditional schema.

Fixes: dc5cb63592bd ("dt-bindings: phy: migrate QMP UFS PHY bindings to qcom,sc8280xp-qmp-ufs-phy.yaml")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 9dac6852f8cb..f9cfbd0b2de6 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -72,7 +72,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - power-domains
   - resets
   - reset-names
   - vdda-phy-supply
@@ -130,6 +129,21 @@ allOf:
             - const: ref
             - const: qref
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-qmp-ufs-phy
+              - qcom,msm8998-qmp-ufs-phy
+    then:
+      properties:
+        power-domains:
+          false
+    else:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:

-- 
2.39.2


