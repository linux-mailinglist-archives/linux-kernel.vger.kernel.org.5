Return-Path: <linux-kernel+bounces-38142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525F83BB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1E91F2155D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BE175BB;
	Thu, 25 Jan 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTHcs++q"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20D18E2E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170422; cv=none; b=oP7z9Zia4ZtA82E1xMnJOdrXIOzkyvlrEnUIGbr/+Ntc3y7IVUXXYfazbAx8v+GLzR6XWeP/3PyFf0ovp4LC2NzgRC5xPyL/VNrp0OCy80+yPcycDlAge22Vf8WGVHaoiwPgBHVUhkTmWTWunu7xqHDVIVP1FMS0ICHoJZMETRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170422; c=relaxed/simple;
	bh=1PjAFbLu+QatkpIULOJu+tdaaDskbNtEhNTIImAUfzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIcUBylk/CizPJCMB4riWF4nklMK3Y2r7zflnW1LTihm2Khp5TZH9RZTRDU1LvUsBAxTDU78KvZMs6UgBFc1x9r6tu5tBqUg3oiYCW9Fuj0ybLXRrvbotC+BU8QqvC20Rs93znylT2VwFZJIRY3ob7UBsCiKaG65WarmCKonIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTHcs++q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337d58942c9so6495414f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706170418; x=1706775218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCQe/+k3llTSJdQx+Lotjl3qv3Ze8JJbbwzIaaR7inc=;
        b=iTHcs++qqYACQNulobQJaYDcRqn96SEwZ9hJDTOruqVyifkEpO3puPeMjuZPB17ZOo
         2WraGDv8gY1qKTx1+ql3tTAlOpXk2Lrqhigq2wNL5yoPvAmOoZ1N0SRwQvrHZLinyPYu
         FK41pnBKugHMxfRBGLx2PlpdaWBEdQ0McGEEQj+3wHmCDdZjWsnujRF75GtpgEOV4SzF
         O0mvqnz45VMY8Z+Mj993RoMUdttChf+b/R2hYeiIUOP651BLakO9nXdlonRqbIPhCdHW
         bkKj6T/hBXemeVCZnndSRO87p1YAAZHQN4WgBTBUKwNLRY9ak/6dOq6fb3BXK3eMr00y
         NCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170418; x=1706775218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCQe/+k3llTSJdQx+Lotjl3qv3Ze8JJbbwzIaaR7inc=;
        b=Lz8ELTkVdH3/IM6NanVOaDJ8bQpc8wVb8AeM6gpg85ZCt8TxW8nsXXbFJ2WqyN57PU
         W7W3xq4D7NVnTJ5P18tMulFmq9gXH20IoK4iknhQx0lPAI8ICK03cimHZfusFuNWaxTA
         nvZQrbZ0vW/XvDY32nIk66v+xZM+3utPPGkqtX3hrs4Fd5GSSh+3OG4QvpBo/gHJjM7p
         A7epmfXJlhJ3eqxGP1GGpnlX1wUTvLlqbyvE1WPoBzClhQjsU0CyB6okUtZmgm6efid3
         o0xJm7ag25f7IMYA3udvJV3I6mN3JQHT3C5CTL8dpiC9lTrV+EPt2I08gUZN/HEwvxEP
         zb+Q==
X-Gm-Message-State: AOJu0YzJO+a9Mo2obdslMFR1ZTKPW7Br1ffsBNHjWQj/yEVTnPHGKJyo
	iHygx6AQ5aBBztNwHaT1bxkELazsVcuvUfCeP9qFLYQkuaDGrtXQavhpmZkGdYI=
X-Google-Smtp-Source: AGHT+IE4nmhn8ZT67QzXSj5JfT4WLUw+FPOzC7wAh+EDKFvvB1jXtCdIzQ18pHfiVb1Z4PrxqQexsg==
X-Received: by 2002:a05:600c:c0d:b0:40e:c709:dcc2 with SMTP id fm13-20020a05600c0c0d00b0040ec709dcc2mr294491wmb.43.1706170418196;
        Thu, 25 Jan 2024 00:13:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040e4a7a7ca3sm1638350wmq.43.2024.01.25.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:13:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jan 2024 09:13:34 +0100
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the HDK8550 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-topic-sm8550-upstream-hdk8550-v3-1-73bb5ef11cf8@linaro.org>
References: <20240125-topic-sm8550-upstream-hdk8550-v3-0-73bb5ef11cf8@linaro.org>
In-Reply-To: <20240125-topic-sm8550-upstream-hdk8550-v3-0-73bb5ef11cf8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1PjAFbLu+QatkpIULOJu+tdaaDskbNtEhNTIImAUfzI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlshgvUbveyw0aDRQjDYSJvghOX7q6oyOz6eje4d1L
 9NnsluWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbIYLwAKCRB33NvayMhJ0f5AEA
 CpbBo8e542kVcIWHZDdsXj2gybtqv3eRfdsRMQxSTOXb0bIO6fSuetXP+5opaGONh8j2pQoeTpnqVG
 Dc7jsVqHo9Y555MYPCDxaae6PURkU9V8IYdN0l4y6sdkygA/IGns2+ghCGVOfcxijHbum8bZ2+K3ze
 pl0uUoH60YyJJ8M1lMwp4YnmCFLXc3jyB/HrCBnypyMlpwS77mVxYaaf4nnJ2iVABvko3nVYA095fO
 O7wE4OWQGvtUFToTqBtyxrQ4jSIpoekXMQMV/kgX6AvV4ayUZe96wPk+AEAaFY/PfzhaRdD1kKu+Ru
 M2tEH/yvoqYsCEziWlwlgrAEn3PNbdRLI2Ewl6Z+7W63jHdn3XAD6T4pc5iYW12yUDJVpn7a0uDsnL
 +TxnAhzH2vwDDYZ/qCybChFLSYbUQq9pNPduYbbODnJPHI3LmpBctphZljk4Yr4P0E7Pf1glIUgcT7
 KhaimHIX6SjuVexa2S6nvSwpt5ydutltxv8DWBZ0l5G8whqoxDgz6OsaH7SN42xuw9QnRplhbifD0s
 huWQ1ATb0XN0Z9qbCgM9/1MCbLKaIA+ii0zJUZl2L9jPkL9RaV3saDgsq9nLW1b84y8xHUGmdrpyXN
 RtaDPBizBTIGRRP9j1B4gHJy+513FtDc4wMOFXtUuikFziElz62DvrBO73Cw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8550 based HDK (Hardware Development Kit)
embedded development platform designed by Qualcomm and sold by Lantronix.

[1] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..c1720dd960c1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1035,6 +1035,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sm8550-hdk
               - qcom,sm8550-mtp
               - qcom,sm8550-qrd
           - const: qcom,sm8550

-- 
2.34.1


