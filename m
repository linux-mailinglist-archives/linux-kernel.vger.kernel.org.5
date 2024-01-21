Return-Path: <linux-kernel+bounces-32131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376798356E6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF00A1F22836
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA238F9F;
	Sun, 21 Jan 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MntYn5yD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00289383A4;
	Sun, 21 Jan 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856363; cv=none; b=DlklOIOujt+gnK8gkGhWX8ixEJibXEByXMMpgAYSC5tijb3NAPyAENISf13hoXgYD6W1fwqa7YHw4XV2tJhba5SDBZGVjyApo7QxVqwjc9++eNU3IR5yW83pcACTHiqXNd7Cr5htwloVcIFqFIIhL5MLj5gYkYKElExmQ22DCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856363; c=relaxed/simple;
	bh=9P0k3L/QGLlCkBie4meFZUg9K/Pv6h/ZSaFYlC5vj8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iC/qDwirFXeeMcbt1gP6iifG5Xrj92lo9jBnJ0WmpCohxYzvCjwFJaS6gvwfFqAqWV4U6xH+73xST/bt3CXKNQ6bhAyiMmR7Srugj9/edQWSgS8eIHSew8iu6NKpL+eIRS2lL21axnOkllqaT0XlDl1frPnWzffBTWF7tF/5K2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MntYn5yD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8801221cso24260505e9.1;
        Sun, 21 Jan 2024 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856360; x=1706461160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPmH+29RYhsMvZ/W94dqz0aawqDom5pf3+7eomrNrXY=;
        b=MntYn5yD/bORVPPQDrw5c251POtXgOM3uZXytFHQL8y0/nbHEP8Evfdeq+yWjAETZz
         Exq0GlezXy72w3mwj1UIFryVqTgw2po6uta2W3TkDvcUP4u6PHWUmlXQsssPveVFlPII
         yNb6CW2Vm9bYnIgOjz60LWPRR5klT+8ALlCkBjHOJULP9wTkbZblutcVNvNdmgM9suGd
         F0boFK12+L8RNSBBmZAlJuzeL6gUaiTwE1MkUbmN3jTHfDxPh3orBqpqE1lqnt09AfVS
         0eEwXRxSi9O77ImbJF9sXRRT4dfhlzpQoWCdPplY/u1RLtlJiiHsl43QL/ZJR+dlWjSU
         am3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856360; x=1706461160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPmH+29RYhsMvZ/W94dqz0aawqDom5pf3+7eomrNrXY=;
        b=P9J2VbLBiPbr63fFGCvgS7AUL3PLVstoeQIuWbPTilP/VmtXx1uYy3St0/Ah2WNoRp
         s4wBg/7PrxxzeEBKwX89xgngyRCiLEzLvAhpOFMYDXt+geF0C1IXB3JgFdr5P4l2x24E
         OmjmEmcoU82TsG4cLeb/VvToxqJWwy+5/Zlcm3FTAIBn1b0xMN8rGEatgbDjRKHUvbSd
         l43cPyuMjTVmNjEBXA6hfz8X+/pQUxHGQpoQwEvnryAqcGZl3tI294JkUuL5LEb5j6p8
         Q2RpSDchxOdTaCeD/d4WzBQS+p1R2q8/l4/D0ChUgjf64yLrTBl6bALS/uLpDJCOqL9S
         VOcg==
X-Gm-Message-State: AOJu0YxGfXi0fzkKSAOG0JJvCufAfgNmOJFoergrXhamV6BUS2Jyt15v
	izAQlD72tp2+RbPPdn1DI6wSC+xWUwmCBMOPmgPNoEbPmET9xah8
X-Google-Smtp-Source: AGHT+IHd062lUefjKuYSDE1sm0d+aQdF5Lm9X7ZGzR/cGqkeMNk1bVa+M+tTf+NCko2ktDoO+NPlOw==
X-Received: by 2002:a05:600c:3147:b0:40e:4833:8141 with SMTP id h7-20020a05600c314700b0040e48338141mr1949674wmo.4.1705856359854;
        Sun, 21 Jan 2024 08:59:19 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:19 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:44 +0100
Subject: [PATCH v4 4/8] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-4-f7d1212c8ebb@gmail.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=772;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=9P0k3L/QGLlCkBie4meFZUg9K/Pv6h/ZSaFYlC5vj8A=;
 b=7dgjLWpE/KNwH5PdsDAbxrechK9n7aC3A6OOpy7q0P62gZKsZCc5Zuy5ZKyG8P1EnxxYMNGPI
 /A583JCdPVnC3yofzZfDQZVugh9sHjovG4WI20FDjk5v1zqg059dZHg
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Document the Xiaomi Redmi Note 9S (curtana) smartphone, which is based
on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..59430524dac6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -988,6 +988,7 @@ properties:
 
       - items:
           - enum:
+              - xiaomi,curtana
               - xiaomi,joyeuse
           - const: qcom,sm7125
 

-- 
2.43.0


